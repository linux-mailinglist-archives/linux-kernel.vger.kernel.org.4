Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3B3C65B2D1
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 14:42:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235990AbjABNmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 08:42:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232976AbjABNmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 08:42:18 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA3063AB;
        Mon,  2 Jan 2023 05:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672666938; x=1704202938;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=J7xkNIQzzgDCVvL5DMEDTfOrVUQflU+RR1Gp6KwWTrs=;
  b=UmfrTPB2NurVTgrYa4YANB9+diTrPXoGkHHcfl6i4WKNr6F+KMceVtdR
   zkxQWp6o7LBZrghSa0RxEYUN7S/gY62HCh0fQ+yg/dNuc39yBn3SpMT4D
   TuMxxIGdRPOss8tbNudPqOZJ+kd3raeUXkji/KWTWlmB1a+BhsgO8zi1H
   0TyrmyauTKMII0pYRSBtw7fUbaNRJpOeJSnw02ZLFMFWOcu6NE3tLTOT1
   Jbme6b2JDtiTTSj6b8uF1gzys/cBWXi6sUyVGQmsgx3aBKbAmk0Tn/Yd8
   tu+bQ2X5XOlSAn0B5zFJvgI8Ur07LrNV5oU1NBcvcRhHqgTHaclE/gOzm
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10578"; a="320197987"
X-IronPort-AV: E=Sophos;i="5.96,294,1665471600"; 
   d="scan'208";a="320197987"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2023 05:42:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10578"; a="604536032"
X-IronPort-AV: E=Sophos;i="5.96,294,1665471600"; 
   d="scan'208";a="604536032"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP; 02 Jan 2023 05:42:15 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 2 Jan 2023 05:42:14 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Mon, 2 Jan 2023 05:42:14 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Mon, 2 Jan 2023 05:42:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HCcByUthVRIYxkjAr9qbNlEmtArlo+pDIZ2M8/7FWvJCYckn969X7NILfp+HUnSkQUBMux0Lw6lprN7YoxB12bxukmFwt2LhPqRalF5v2sAWNBI0RA+nMmtb5trZuU+5c+b6FicZClN3+XuKD2RD+LKWmA3ghoUDHgK4+qTrUAtMkkxkkT+sLijHpnOzSgkVldpZE2wafMAvRojQ8+Fk33gtdGtpvFHzNFh6M8NJKGzsejRtnhkJ3f5U/O3SZsfwZuFvL+Nsi0KNjini0/GYQXOWXhaj5JcW5LALWU85sv8mh6y5v8yOpbjYUNvfV97vPaQebqW9KGHynGxIw6GSEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J7xkNIQzzgDCVvL5DMEDTfOrVUQflU+RR1Gp6KwWTrs=;
 b=HeoeNzjjmgRccsFVNRaTgYR7YtImPBsEWigo+CY9mIv9uEB4Btvv8fJayewUXxGdbCxrTjXbSNCowMbS78Is4FJUmTFUCb1m7PqoQpg7VQB2WcuX6TVuPjLZWBY1eAREO7Se0m9QJfOOsfnDZ2x1XIhIpPjG3WPj2xZG0bOfThf1X2NxDnCVKjqxvt53HwjsiNZWWuX+gsTAxsaBMlN95mUTmaiJDYFVRe54ehcg45k5xY1FHtuKbPB7F2PSnPQM9PsaFlouupmK2WexFb+KIzW5Y4dOgTFrDp8IjO89bnHNpS4Z3YeXN0fCsAzSZui+8ZzFPkgyvIuik9tkygPIYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by DM4PR11MB7183.namprd11.prod.outlook.com (2603:10b6:8:111::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Mon, 2 Jan
 2023 13:42:12 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::e30c:74f4:5052:6fd2]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::e30c:74f4:5052:6fd2%6]) with mapi id 15.20.5944.019; Mon, 2 Jan 2023
 13:42:12 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "zh.nvgt@gmail.com" <zh.nvgt@gmail.com>,
        "rafael@kernel.org" <rafael@kernel.org>
CC:     "lenb@kernel.org" <lenb@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH] ACPI: custom_method: fix potential use-after-free issues
Thread-Topic: [PATCH] ACPI: custom_method: fix potential use-after-free issues
Thread-Index: AQHZGb1QetPbVOMpVkW9t0fR2xIkiq6GxkwAgARmQgA=
Date:   Mon, 2 Jan 2023 13:42:12 +0000
Message-ID: <c052bf9dd21df44dfa3161bb94544559a41ab17e.camel@intel.com>
References: <20221227063335.61474-1-zh.nvgt@gmail.com>
         <CAJZ5v0jmOMHHXvRnDcetDbh+0CySh5ddZJx1g3xTXPzCHokZRg@mail.gmail.com>
In-Reply-To: <CAJZ5v0jmOMHHXvRnDcetDbh+0CySh5ddZJx1g3xTXPzCHokZRg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|DM4PR11MB7183:EE_
x-ms-office365-filtering-correlation-id: c1b1fde3-faf1-4c07-ca3a-08daecc7272c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3SF6+I+B+vBU2bweItMXt1FvYnGaC1xVhWRuRlpKK31+nUHI0zvfizVkiV1xkYcwiiBFng5S/4UB1WqIYim4H8w3W1TxvDH5QH6m1bb78Oy+v6tkDWaj98Bk9iWMZEq3AMF4Pf3SJeHrpP8CuI3Zy+HllZNnPryvwYxZJomZwJ2IonqcL/UC9llftFojxfLIUHN92LaF8OXSroaFfTuhmfsn6kOvvNjcqGYAeq0k26U0crCQ2GS7oU6fqsocS+d+amv5SoCAozt6UQbBr26D8DKoOxyrply2S/Dud1sCs1vr9yAazYtLJdttaTDuPcbS2ZqEcAva8LNhniMVvtX52BAfQYsXy0cpd4iMQHo2aFeqJgqpM4dqSRHSqvxpoDbHpqRvxFVeRCyix3hwEJImsZmw3pVO7wvko1V36+QD97zn9n4H4yRI6pngHFZY19Lr1jNWnAdTAmoj5iJvWXs0q4Pf4OEVWxHPfWJHtw9W8NPDbzmCHHs7OgUfVsF9XwdyB2H2u0LkP2GJE6x3IbF4w3IwUgECWSmN80ko268J3d0hZPhrI/B7KzAbOr7kZGlIbyOvyCLiDz1HHGJwFXFlhW+8X9qYQwpaJ4RHtPe2NFlfkA7OpqxWEM3D1CQzzh5g7pLbp3VLx41o7QLfVPzXFGxZh09//GyfxeU+wA3BK2VCH7mNcMMg6e8MrfD3FJS3jtBBLX6AwnOkTMoB6WMfy2WrGHtLFD7jxEK5hv1DDULsMeevR06I14yoV0PC8pJB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(136003)(346002)(39860400002)(396003)(451199015)(53546011)(6506007)(478600001)(110136005)(71200400001)(6486002)(36756003)(86362001)(82960400001)(122000001)(38100700002)(38070700005)(6512007)(26005)(186003)(2616005)(83380400001)(966005)(91956017)(5660300002)(76116006)(4326008)(66556008)(66476007)(8676002)(64756008)(66446008)(66946007)(8936002)(41300700001)(54906003)(2906002)(316002)(4001150100001)(22166006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OGpGbWFrSGV6OTJzclV4VGtHM0hzM0RpdjNibmxORnR6WnpmR05qK3N3WmVL?=
 =?utf-8?B?eXVVSG5JMmFwaWFKNmNEaTZmTm1ydDlkNWVQc25xYVNzbEt1K3VpUWxSSVB3?=
 =?utf-8?B?OGkwNVBWS2NFbmczMmtRUFRQQVYyQUFGeWNaeWhjKzk5SUttcUpoVTZwYVRq?=
 =?utf-8?B?U1dwdG5sREtpRUxFa2N4YndxamJSOU1xL2ZlKzhBdXVRejJIejVXZy9DeGtj?=
 =?utf-8?B?SUpmTmRPbkNtUy95ckN5VHlock5sOWlwMDR4N1lubVVKQUxPMC91RVlJc083?=
 =?utf-8?B?NUlXTThxZUpPN3FBY3cxRkEvVkdFOGhaWi9DYklmcXd6T3JMSFpUbDY4Mkpt?=
 =?utf-8?B?dTcybkYyTlIraCt1QWlLdm1LS216MlBEMHUwUUZyRUtxY3RGaDAvZWQzUFp1?=
 =?utf-8?B?cG9LdVArMzdsaC82djRHUnR2VnRXZ2g4VHgyTlJ6Tk90RDZ1WEMwZk1PNmFM?=
 =?utf-8?B?VE0xZGcyR0JrYXRORWlhOWFYbFhVeWgxek15d1N1NkV3MUY3cmpEcVAvSGpn?=
 =?utf-8?B?SmV4WkRJMzlZRWdJWFZoM2t4TFNJbjgwNGFQdzBCd2l2V0F1QTlJNk1LYnFV?=
 =?utf-8?B?SVRLbXE5dUEyYldGRVF1MG5OVEJhK01oYzl5RUFsT1JUQklTdDE4QmhDZGY4?=
 =?utf-8?B?aWt1aDVVWWlia3RNaVJFU3BiRm50TjhXeEc1TU1ySHJJRGJTem9lUU9JRU5E?=
 =?utf-8?B?NktMelNjUXppbisvVHJaL0ErUDZHSTEyaEtiWEJzaHhNcndjd2dLZU01UnJw?=
 =?utf-8?B?SDZtZC9SelBYZVVwNzFPdnBNZjA1dy81b1ZkR2J2TXNSc3ZlTElNZHVMVlRO?=
 =?utf-8?B?ZGZVb25ZVHNaTVBJblloTTdKKzVPMzJmR3VlNVN3QUh2QldSMlhHb1lML3l0?=
 =?utf-8?B?TW9mRHp3cVdzVVhnREM4Q2xjNDg5a2FGcTRJSmErbGNPbVI1aEhzYkRjQkxI?=
 =?utf-8?B?OHRKRk1sTE1yYTRPZ0FDcUhsSU5rRnpmSDJIN3BqSUJBV3lnMFFWYzIvVjJs?=
 =?utf-8?B?RTRMWkdBWE1QTzhZdzlsb29FaXRJVThubzdNa2tOTnV4eUlLMkt2SzNpdm42?=
 =?utf-8?B?NjFCbnV0VUU3Y0xFRlVmWkFYY08yUmJvM2JjcUhER2ZDRDZZYndqVk51TTJX?=
 =?utf-8?B?eTA0NFJKY0VWUEQ0VFpseVF0SXNQM1RJUnJLekxNeVBpUENJSUhHckF5b1Jw?=
 =?utf-8?B?RTc4U3dnTzNUQXI5d0hPQTBXaXZ6amNnS0VBTS9qOHRiR0h1VU1za2pUYkVl?=
 =?utf-8?B?SnhMZjAzMTZGTElzc1pwVXc1NkpCQ0kvQTRrbGN2YnN0cHZzVTQ2OFJDamc5?=
 =?utf-8?B?N2ZZRkRWTUxvYU5ueFFNa1RLcjBQVStUN2cxVjZJQS9WeVl2V09OU2xFUnBG?=
 =?utf-8?B?dnRWMmZ4QTBlRjJyNU5pa290M2VHemVacHh6cEZGa28wSnE5OFhFZGQwV0RF?=
 =?utf-8?B?OS9MSjhtcWtPbXQzY09FMHRIWllCUnJVTitjWnZYYVFoeWIyQW1VUVNBTkE3?=
 =?utf-8?B?dWlyWFVTYWl2VzdJdWtJRjFSR0pyYVFiRzQvWGErU2NMNWJiVWdjaUV0VUpY?=
 =?utf-8?B?b2wyYWU5VTRKOGEyQk5Rb3dWM3hWelVYTnVPUXRmanJFUEpEN2NSc3lvZ2d0?=
 =?utf-8?B?SWVBVkUrQ1dYRFBSanl6SENNTlkwVGc4L3NhRFV5MlVLelMxMldZdmI1Rkdy?=
 =?utf-8?B?OVVUWFJNWnZQL2JnY3V3Ti85ZDNGaEhOc3dwN0ZOZnBXRmtyUW5IMm8xaGZN?=
 =?utf-8?B?SER5bjRaSXJDU0NwSjNOd1FERFJBNWFVRXdiTkttS1VsT25nOUFRNzlZNUpv?=
 =?utf-8?B?SitBMnVPSEJ3NkZ2OHRlVDNWdlp3c054dzNoTUdwWmtnVHBnaHhoejJlc0Yz?=
 =?utf-8?B?b2tWQkFCRjI1SllMS3ZGNkRjcTVDY0M3R1VUK2FsMWFYWGhyNWFPa1JkdDNX?=
 =?utf-8?B?TVF5Y2YrRnNKQnVIUmtVZG9oUGZkODFmcUY5N3F6d081RU1PRkEyeUZXMnZ5?=
 =?utf-8?B?YXFYVllJSllGRUEwOGI3VjA0akxRS0IwcHo4Wnl6TTBlbTZsNkFURzk5V1Zz?=
 =?utf-8?B?cnJhNmRaaTBLOExEeGloSDg1RmQxdTNkUFhQSVZSWVdFc0VxZmFsbFZ0a2Jm?=
 =?utf-8?Q?Qpsc5d/dgHOyvppfb4V6vtHjE?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1A7E6FEDD7330B46B3FEC1A726794535@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1b1fde3-faf1-4c07-ca3a-08daecc7272c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jan 2023 13:42:12.5772
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VUT7OfaHthUSCT3XArTsDAND7A4aEUwBrsXN/o4uO2xCM6z0bqZxTdi6dp0NOcw/PAUMv97Z8mWxFADjUZK6Zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7183
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIyLTEyLTMwIGF0IDE5OjMxICswMTAwLCBSYWZhZWwgSi4gV3lzb2NraSB3cm90
ZToNCj4gT24gVHVlLCBEZWMgMjcsIDIwMjIgYXQgNzozNCBBTSBIYW5nIFpoYW5nIDx6aC5udmd0
QGdtYWlsLmNvbT4gd3JvdGU6DQo+ID4gY21fd3JpdGUoKSBpcyB0aGUgLndyaXRlIGNhbGxiYWNr
IG9mIHRoZSBjdXN0b21fbWV0aG9kIGRlYnVnZnMNCj4gPiBpbnRlcmZhY2UsIGl0IG9wZXJhdGVz
IG9uIGEgZ2xvYmFsIHBvaW50ZXIgImJ1ZiIgKGUuZy4sDQo+ID4gZGVyZWZlcmVuY2UsDQo+ID4g
YWxsb2NhdGUsIGZyZWUsIGFuZCBudWxsaWZpY2F0aW9uKSwgdGhlIHByb2JsZW0gaXMgdGhhdCBj
bV93cml0ZSgpDQo+ID4gaXMgbm90IHByb3RlY3RlZCBieSBhbnkgbG9ja3MsIHNvIGNvbmN1cnJl
bnQgaW52b2NhdGlvbnMgb2YgaXQNCj4gPiBtYXkgY2F1c2UgdXNlLWFmdGVyLWZyZWUgaXNzdWVz
IGZvciAiYnVmIiwgZS5nLiwgb25lIGludm9jYXRpb24NCj4gPiBtYXkgaGF2ZSBqdXN0IGZyZWVk
ICJidWYiIHdoaWxlIGJlaW5nIHByZWVtcHRlZCBiZWZvcmUgbnVsbGlmeWluZw0KPiA+IHRoZSBw
b2ludGVyLCB0aGVuIGFub3RoZXIgaW52b2NhdGlvbiBjYW4gZGVyZWZlcmVuY2UgdGhlIG5vdw0K
PiA+IGRhbmdsaW5nDQo+ID4gImJ1ZiIgcG9pbnRlci4NCj4gPiANCj4gPiBGaXggdGhlIGlzc3Vl
IGJ5IHByb3RlY3RpbmcgdGhlICJidWYiIG9wZXJhdGlvbnMgaW4gY21fd3JpdGUoKSB3aXRoDQo+
ID4gdGhlIGlub2RlIHdyaXRlIGxvY2suIE5vdGUgdGhhdCB0aGUgLmxsc2VlayBjYWxsYmFjayBv
ZiB0aGUgZGVidWdmcw0KPiA+IGludGVyZmFjZSBoYXMgYmVlbiBwcm90ZWN0ZWQgYnkgdGhlIHNh
bWUgbG9jaywgdGhpcyBwYXRjaCBiYXNpY2FsbHkNCj4gPiBpbnRyb2R1Y2VzIGl0IHRvIHRoZSAu
d3JpdGUgY2FsbGJhY2sgYXMgd2VsbC4NCj4gDQo+IFRoZSBwcm9ibGVtIGlzIHRoZXJlLCBidXQg
dGhlIHdob2xlIHN0YXRlIGlzIG5vdCBwcm90ZWN0ZWQgZnJvbQ0KPiBjb25jdXJyZW50IHVzZSBh
bmQgdGhlIGZpeCBkb2Vzbid0IGxvb2sgc3VmZmljaWVudCB0byBtZSAoZm9yDQo+IGV4YW1wbGUs
DQo+IGEgZGlmZmVyZW50IHdyaXRlciBtYXkgc3RhcnQgd3JpdGluZyBpbnRvIHRoZSBmaWxlIGJl
Zm9yZSB0aGUNCj4gcHJldmlvdXMNCj4gb25lIGhhcyBmaW5pc2hlZCBhbmQgdGhlIHJlc3VsdCB3
aWxsIHN0aWxsIGJlIGJyb2tlbiBBRkFJQ1MpLg0KPiANCj4gSXQgbG9va3MgbGlrZSB0aGUgZmls
ZSBzaG91bGQgYmUgcHJldmVudGVkIGZyb20gYmVpbmcgb3BlbmVkIGJ5IG1vcmUNCj4gdGhhbiBv
bmUgd3JpdGVyIGF0IGEgdGltZS4NCj4gDQo+IE9yIG1heWJlIGl0J3MgdGltZSB0byBkcm9wIHRo
aXMgaW50ZXJmYWNlIGZyb20gdGhlIGtlcm5lbCBhbHRvZ2V0aGVyLg0KPiANCkkgc3RpbGwgdXNl
IHRoaXMgaW50ZXJmYWNlIGZvciBkZWJ1Z2dpbmcgQU1MIGlzc3VlcyBvY2Nhc2lvbmFsbHkuIFNh
eSwNCmR1bXBpbmcgdGhlIHZhbHVlIG9mIHNvbWUga2V5IG9iamVjdHMgdG8gc2VlIHRoZSBBTUwg
Y29kZSBwYXRoLg0KDQpJJ20gbm90IHN1cmUgaWYgdGhlcmUgaXMgYW55IGFsdGVybmF0aXZlIHdh
eSB0byBkbyB0aGlzLCBlc3BlY2lhbGx5IGluDQpyZW1vdGUgZGVidWcgY2FzZS4gKFRoaXMgY2Fu
IGJlIGRvbmUgdmlhIERTRFQgb3ZlcnJpZGUsIGJ1dCBub3QgYWxsDQp1c2VycyBoYXZlIHRoZSBr
bm93bGVkZ2Ugb2YgYnVpbGRpbmcgYSBjdXN0b21pemVkIGtlcm5lbCkNCg0KSWYgdGhpcyBpcyBu
b3QgYSBwcm9ibGVtLCB0aGVuIEkgdGhpbmsgaXQgaXMgc2FmZSB0byByZW1vdmUgdGhpcw0KaW50
ZXJmYWNlIGJlY2F1c2UgSSBzdXNwZWN0IEkgYW0gdGhlIG9ubHkgdXNlciBvZiB0aGlzIGludGVy
ZmFjZS4NCkJlY2F1c2UgdGhlcmUgYXJlIHNvbWUgc3BlY2lhbCB0cmlja3MgSSBnb3QgZnJvbSBF
cmlrLCB0byBtYWtlIGl0IGZ1bGx5DQp3b3JrIGFmdGVyIHNvbWUgY2VydGFpbiBBQ1BJQ0EgcmVs
ZWFzZS4gQW5kIHRoaXMgaXMgbm90IGRvY3VtZW50ZWQgaW4NCmh0dHBzOi8vZ2l0Lmtlcm5lbC5v
cmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4LmdpdC90cmVlL0RvY3Vt
ZW50YXRpb24vZmlybXdhcmUtZ3VpZGUvYWNwaS9tZXRob2QtY3VzdG9taXppbmcucnN0I241OA0K
U2F5LCB0byBnZW5lcmF0ZSB0aGUgQU1MIGNvZGUgb2YgdGhlIG1ldGhvZCwgd2UgbmVlZCB0bw0K
MS4gY29tcGlsZSB0aGUgdGFibGUgd2l0aCBleHRlcm5hbCBkZWNsYXJhdGlvbnMuDQoyLiBJZiBz
dGVwIDEgY29tcGlsZXMgc3VjY2Vzc2Z1bGx5LCByZW1vdmUgdGhlIGV4dGVybmFsIGRlY2xhcmF0
aW9ucw0KZnJvbSB0aGUgdGFibGUgYW5kIGNvbXBpbGUgd2l0aCAtZi4NCg0KdGhhbmtzLA0KcnVp
DQoNCj4gPiBTaWduZWQtb2ZmLWJ5OiBIYW5nIFpoYW5nIDx6aC5udmd0QGdtYWlsLmNvbT4NCj4g
PiAtLS0NCj4gPiAgZHJpdmVycy9hY3BpL2N1c3RvbV9tZXRob2QuYyB8IDQzICsrKysrKysrKysr
KysrKysrKysrKysrKystLS0tLS0tDQo+ID4gLS0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMzAg
aW5zZXJ0aW9ucygrKSwgMTMgZGVsZXRpb25zKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvYWNwaS9jdXN0b21fbWV0aG9kLmMNCj4gPiBiL2RyaXZlcnMvYWNwaS9jdXN0b21fbWV0
aG9kLmMNCj4gPiBpbmRleCBkMzlhOWI0NzQ3MjcuLmUzZGU1YTA2ZDkwMyAxMDA2NDQNCj4gPiAt
LS0gYS9kcml2ZXJzL2FjcGkvY3VzdG9tX21ldGhvZC5jDQo+ID4gKysrIGIvZHJpdmVycy9hY3Bp
L2N1c3RvbV9tZXRob2QuYw0KPiA+IEBAIC0yOSwyOCArMjksMzggQEAgc3RhdGljIHNzaXplX3Qg
Y21fd3JpdGUoc3RydWN0IGZpbGUgKmZpbGUsDQo+ID4gY29uc3QgY2hhciBfX3VzZXIgKnVzZXJf
YnVmLA0KPiA+ICAgICAgICAgc3RydWN0IGFjcGlfdGFibGVfaGVhZGVyIHRhYmxlOw0KPiA+ICAg
ICAgICAgYWNwaV9zdGF0dXMgc3RhdHVzOw0KPiA+ICAgICAgICAgaW50IHJldDsNCj4gPiArICAg
ICAgIHN0cnVjdCBpbm9kZSAqaW5vZGUgPSBmaWxlX2lub2RlKGZpbGUpOw0KPiA+IA0KPiA+ICAg
ICAgICAgcmV0ID0gc2VjdXJpdHlfbG9ja2VkX2Rvd24oTE9DS0RPV05fQUNQSV9UQUJMRVMpOw0K
PiA+ICAgICAgICAgaWYgKHJldCkNCj4gPiAgICAgICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4g
PiANCj4gPiArICAgICAgIGlub2RlX2xvY2soaW5vZGUpOw0KPiA+ICAgICAgICAgaWYgKCEoKnBw
b3MpKSB7DQo+ID4gICAgICAgICAgICAgICAgIC8qIHBhcnNlIHRoZSB0YWJsZSBoZWFkZXIgdG8g
Z2V0IHRoZSB0YWJsZSBsZW5ndGgNCj4gPiAqLw0KPiA+IC0gICAgICAgICAgICAgICBpZiAoY291
bnQgPD0gc2l6ZW9mKHN0cnVjdCBhY3BpX3RhYmxlX2hlYWRlcikpDQo+ID4gLSAgICAgICAgICAg
ICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+ID4gKyAgICAgICAgICAgICAgIGlmIChjb3Vu
dCA8PSBzaXplb2Yoc3RydWN0IGFjcGlfdGFibGVfaGVhZGVyKSkgew0KPiA+ICsgICAgICAgICAg
ICAgICAgICAgICAgIHJldCA9IC1FSU5WQUw7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAg
Z290byBlcnI7DQo+ID4gKyAgICAgICAgICAgICAgIH0NCj4gPiAgICAgICAgICAgICAgICAgaWYg
KGNvcHlfZnJvbV91c2VyKCZ0YWJsZSwgdXNlcl9idWYsDQo+ID4gLSAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBzaXplb2Yoc3RydWN0DQo+ID4gYWNwaV90YWJsZV9oZWFkZXIpKSkN
Cj4gPiAtICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gLUVGQVVMVDsNCj4gPiArICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNpemVvZihzdHJ1Y3QNCj4gPiBhY3BpX3RhYmxl
X2hlYWRlcikpKSB7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgcmV0ID0gLUVGQVVMVDsN
Cj4gPiArICAgICAgICAgICAgICAgICAgICAgICBnb3RvIGVycjsNCj4gPiArICAgICAgICAgICAg
ICAgfQ0KPiA+ICAgICAgICAgICAgICAgICB1bmNvcGllZF9ieXRlcyA9IG1heF9zaXplID0gdGFi
bGUubGVuZ3RoOw0KPiA+ICAgICAgICAgICAgICAgICAvKiBtYWtlIHN1cmUgdGhlIGJ1ZiBpcyBu
b3QgYWxsb2NhdGVkICovDQo+ID4gICAgICAgICAgICAgICAgIGtmcmVlKGJ1Zik7DQo+ID4gICAg
ICAgICAgICAgICAgIGJ1ZiA9IGt6YWxsb2MobWF4X3NpemUsIEdGUF9LRVJORUwpOw0KPiA+IC0g
ICAgICAgICAgICAgICBpZiAoIWJ1ZikNCj4gPiAtICAgICAgICAgICAgICAgICAgICAgICByZXR1
cm4gLUVOT01FTTsNCj4gPiArICAgICAgICAgICAgICAgaWYgKCFidWYpIHsNCj4gPiArICAgICAg
ICAgICAgICAgICAgICAgICByZXQgPSAtRU5PTUVNOw0KPiA+ICsgICAgICAgICAgICAgICAgICAg
ICAgIGdvdG8gZXJyOw0KPiA+ICsgICAgICAgICAgICAgICB9DQo+ID4gICAgICAgICB9DQo+ID4g
DQo+ID4gLSAgICAgICBpZiAoYnVmID09IE5VTEwpDQo+ID4gLSAgICAgICAgICAgICAgIHJldHVy
biAtRUlOVkFMOw0KPiA+ICsgICAgICAgaWYgKGJ1ZiA9PSBOVUxMKSB7DQo+ID4gKyAgICAgICAg
ICAgICAgIHJldCA9IC1FSU5WQUw7DQo+ID4gKyAgICAgICAgICAgICAgIGdvdG8gZXJyOw0KPiA+
ICsgICAgICAgfQ0KPiA+IA0KPiA+ICAgICAgICAgaWYgKCgqcHBvcyA+IG1heF9zaXplKSB8fA0K
PiA+ICAgICAgICAgICAgICgqcHBvcyArIGNvdW50ID4gbWF4X3NpemUpIHx8DQo+ID4gQEAgLTU4
LDEzICs2OCwxNSBAQCBzdGF0aWMgc3NpemVfdCBjbV93cml0ZShzdHJ1Y3QgZmlsZSAqZmlsZSwN
Cj4gPiBjb25zdCBjaGFyIF9fdXNlciAqdXNlcl9idWYsDQo+ID4gICAgICAgICAgICAgKGNvdW50
ID4gdW5jb3BpZWRfYnl0ZXMpKSB7DQo+ID4gICAgICAgICAgICAgICAgIGtmcmVlKGJ1Zik7DQo+
ID4gICAgICAgICAgICAgICAgIGJ1ZiA9IE5VTEw7DQo+ID4gLSAgICAgICAgICAgICAgIHJldHVy
biAtRUlOVkFMOw0KPiA+ICsgICAgICAgICAgICAgICByZXQgPSAtRUlOVkFMOw0KPiA+ICsgICAg
ICAgICAgICAgICBnb3RvIGVycjsNCj4gPiAgICAgICAgIH0NCj4gPiANCj4gPiAgICAgICAgIGlm
IChjb3B5X2Zyb21fdXNlcihidWYgKyAoKnBwb3MpLCB1c2VyX2J1ZiwgY291bnQpKSB7DQo+ID4g
ICAgICAgICAgICAgICAgIGtmcmVlKGJ1Zik7DQo+ID4gICAgICAgICAgICAgICAgIGJ1ZiA9IE5V
TEw7DQo+ID4gLSAgICAgICAgICAgICAgIHJldHVybiAtRUZBVUxUOw0KPiA+ICsgICAgICAgICAg
ICAgICByZXQgPSAtRUZBVUxUOw0KPiA+ICsgICAgICAgICAgICAgICBnb3RvIGVycjsNCj4gPiAg
ICAgICAgIH0NCj4gPiANCj4gPiAgICAgICAgIHVuY29waWVkX2J5dGVzIC09IGNvdW50Ow0KPiA+
IEBAIC03NCwxMiArODYsMTcgQEAgc3RhdGljIHNzaXplX3QgY21fd3JpdGUoc3RydWN0IGZpbGUg
KmZpbGUsDQo+ID4gY29uc3QgY2hhciBfX3VzZXIgKnVzZXJfYnVmLA0KPiA+ICAgICAgICAgICAg
ICAgICBzdGF0dXMgPSBhY3BpX2luc3RhbGxfbWV0aG9kKGJ1Zik7DQo+ID4gICAgICAgICAgICAg
ICAgIGtmcmVlKGJ1Zik7DQo+ID4gICAgICAgICAgICAgICAgIGJ1ZiA9IE5VTEw7DQo+ID4gLSAg
ICAgICAgICAgICAgIGlmIChBQ1BJX0ZBSUxVUkUoc3RhdHVzKSkNCj4gPiAtICAgICAgICAgICAg
ICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4gPiArICAgICAgICAgICAgICAgaWYgKEFDUElf
RkFJTFVSRShzdGF0dXMpKSB7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgcmV0ID0gLUVJ
TlZBTDsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBnb3RvIGVycjsNCj4gPiArICAgICAg
ICAgICAgICAgfQ0KPiA+ICAgICAgICAgICAgICAgICBhZGRfdGFpbnQoVEFJTlRfT1ZFUlJJRERF
Tl9BQ1BJX1RBQkxFLA0KPiA+IExPQ0tERVBfTk9XX1VOUkVMSUFCTEUpOw0KPiA+ICAgICAgICAg
fQ0KPiA+IA0KPiA+IC0gICAgICAgcmV0dXJuIGNvdW50Ow0KPiA+ICsgICAgICAgcmV0ID0gY291
bnQ7DQo+ID4gK2VycjoNCj4gPiArICAgICAgIGlub2RlX3VubG9jayhpbm9kZSk7DQo+ID4gKyAg
ICAgICByZXR1cm4gcmV0Ow0KPiA+ICB9DQo+ID4gDQo+ID4gIHN0YXRpYyBjb25zdCBzdHJ1Y3Qg
ZmlsZV9vcGVyYXRpb25zIGNtX2ZvcHMgPSB7DQo+ID4gLS0NCj4gPiAyLjM5LjANCj4gPiANCg==
