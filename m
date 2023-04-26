Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 818696EF7C3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 17:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241266AbjDZPb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 11:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240523AbjDZPbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 11:31:24 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C4130C1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 08:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682523083; x=1714059083;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=PtrmPrDC4vYIL57E0713/6Dfw8UgKVdps3NkUJyHthI=;
  b=enz5mwek03UgJ8MVQa1FSTyKUAw6G0Qnv1w4z4S2xLoUlyyXVS7w718U
   QiCQm2w/rYvanHxGQ9w6wiw8xL+YwBZ3qVYQAo4RZsTebHW42zJ/hMGNB
   g16YqaPk6nayvdq5+YOgLwo1q7ULjlTl34l94UYu2hr6M8PmaU9Pl+b+7
   2tMQBlzeVEykcvI/8Pr5mkQ6q5TLs0Jt2imaeTpp3Ppl33X7fhkt0D4uQ
   PnzcZrzdlWi/25PqSlQB5Fw6DZLTQ7OA1NR2JlcL3si8+K2K09C1LGSiW
   R/SuSf+y2mBe9TMUcgEo3yvzLIpN1GgM+xEWMAaHFzhBR0oGArsGDdQA8
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="349079897"
X-IronPort-AV: E=Sophos;i="5.99,228,1677571200"; 
   d="scan'208";a="349079897"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2023 08:31:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10692"; a="644292606"
X-IronPort-AV: E=Sophos;i="5.99,228,1677571200"; 
   d="scan'208";a="644292606"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga003.jf.intel.com with ESMTP; 26 Apr 2023 08:31:20 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 26 Apr 2023 08:31:21 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 26 Apr 2023 08:31:21 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 26 Apr 2023 08:31:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fWTCAMI0q3h4IWPymSFei5AoH6GQn4zUGyItkc1BTDipIe9Md0MGnHLjR20vfpsFclota6oaO99s43i2kKmJWcfz/ddS5UUJ8vFSToGYLVc0G7R2RxW1EbtaVcy+hoR40kNhtY0ShdVhdvV4b7itBGBLGpWotYlKh9PO6KYi7zybzv/oAR9MqVnU32FviCt8Em5W9NRbsEjd/4xqr88/a5DGa75Cpz/ZUYtkZ3rmuapSlRyQ7L+neuMRarzjDBVBdAmRbk3mid3Dh3048dR9HJjDS3QFlPGi8qJSXBJ7d74wFrLpUZIDp4QssIOSPvpKCPm3vmZQVZztJkwS6Ray7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PtrmPrDC4vYIL57E0713/6Dfw8UgKVdps3NkUJyHthI=;
 b=DnLoRy32h8GOPhCKJDquWbGvrpieABwNz/xvrByEaT71gZDYUpsyCGyDJ2Qt0OjcLd+gGNyrIvmKvO4WB1zxJmInmpLPDSX4aFRJ2Z5u6EMzjsVQp9FABoCqw4yPjFBIcB9CRnBLiBubdDQuJhR1HOF4Jmk5NjTE32mKflTZQhDAVrpcjcetEHfVBjBSi/Z7VWoo6rooGYJVu9neI05A8bTP5zE7N3cloj7gBkgoY5LlMi61S0+47LfZxG+ZXjxRYhwc6F28mNG/u2KIKI6a+E4+SVJHhzMisnQZawh8O6copDr/kWR26/D9TDQEPv8fty2/IucAfOfInp5OMypIlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH0PR11MB5444.namprd11.prod.outlook.com (2603:10b6:610:d3::13)
 by SA1PR11MB7129.namprd11.prod.outlook.com (2603:10b6:806:29d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Wed, 26 Apr
 2023 15:31:13 +0000
Received: from CH0PR11MB5444.namprd11.prod.outlook.com
 ([fe80::a3d1:bd7a:6d0b:3f29]) by CH0PR11MB5444.namprd11.prod.outlook.com
 ([fe80::a3d1:bd7a:6d0b:3f29%7]) with mapi id 15.20.6340.021; Wed, 26 Apr 2023
 15:31:13 +0000
From:   "Cavitt, Jonathan" <jonathan.cavitt@intel.com>
To:     "Hajda, Andrzej" <andrzej.hajda@intel.com>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Auld, Matthew" <matthew.auld@intel.com>
Subject: RE: [PATCH v7 0/2] drm/i915: Hugepage manager and test for MTL
Thread-Topic: [PATCH v7 0/2] drm/i915: Hugepage manager and test for MTL
Thread-Index: AQHZeFHU4hKj8xc/dkCVVRjZhAqYXa89tJzw
Date:   Wed, 26 Apr 2023 15:31:13 +0000
Message-ID: <CH0PR11MB54443013C3378D4D5992033BE5659@CH0PR11MB5444.namprd11.prod.outlook.com>
References: <20230425-hugepage-migrate-v7-0-fa6605a986c9@intel.com>
In-Reply-To: <20230425-hugepage-migrate-v7-0-fa6605a986c9@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR11MB5444:EE_|SA1PR11MB7129:EE_
x-ms-office365-filtering-correlation-id: eef2e2a2-3000-4e74-085c-08db466b44b0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vNxet9wI9nDZcVpxBXvE9msoM3QpEFGcNTm/zxomGbrVzWzfNdhnF+pI23HLWxKKL/UD2OhhIFWU6/GHLxWjwiVm921hltNsAKkFyDuAVrQTb7Zfx6UvbIQlPKtgItyz4otA8viwAKQ5Nh2nNCP5gyeJp8m+TOq1JkocJDebZnR1oXpNsowl/L/JkmEGf1HE2Q9LYV/+MDeUlHt/rXAvJvnZPgl++m7SamvCsoTiYzpNdewlzBIbCF2LLvZs6Yyq57QP/r3RUWVWjRDmt0+DnVjOeUTt8zjL3PadkvMpr7CSYa9saHwu6YQiVJ8fknb/BAEQ8HkazoDtpAS64S4HF6XdxYx0iJikFUil91e+Y2kXXJ+mUodCPZreHjj9y8azUj4Gw//znwVJqwpDs74kzIbHTXTV8AwoNG2fF7LZ9TOpCTdipGOLq5Iwj4D3HjnqOgg62SSPUzN+jdFgGHVzDz61hzkSYLudkVxBlMtYycNO51fawtejXhIk4G+Pipsmg+BJVArD8MWvyKhapmP98KtevUSSd6aGk/HIPGSBh1iv0PP41RI5IXZifmpBH4M7sYYSwwVmBXrcERvtI5SwdQS9eZyDUbCH5oDAPDeLNOMKxADxxicX3Tq7HKX2GsZc
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5444.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(346002)(376002)(136003)(396003)(451199021)(38100700002)(122000001)(38070700005)(82960400001)(86362001)(83380400001)(2906002)(26005)(9686003)(7696005)(186003)(6506007)(53546011)(52536014)(316002)(478600001)(33656002)(55016003)(66446008)(66476007)(66556008)(64756008)(71200400001)(8676002)(76116006)(6636002)(41300700001)(5660300002)(110136005)(8936002)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RTcyUFhpV2pKMEFZZVZwNit3dHAxcFVSUFNGR3Z4M2QrK0xyaEFQYnRoRVQ5?=
 =?utf-8?B?U1l3SlQ5N0ZUTmhmOGMvdkNPTEtTRXAyelBaV2gwOW5BaVRLb1BWek0vSENT?=
 =?utf-8?B?NTVPaDFDK0RSUUpMR1FoYU9Dei9BVzVLaEw3THMyU1JSVngrRnVIaVhsQlhE?=
 =?utf-8?B?aGV3UmJ5c2ltak5objhxeGYrdDJhRG9XekJrMHltUVg2QlJ4WHJLRDg0VldV?=
 =?utf-8?B?YjJIZ1cyUHd6T0dUbUFVZkxCUkpsbm1iOVhJUkd5VTB1Rml1TUZPQ25zQWVB?=
 =?utf-8?B?NlJUS3VlNjhjeGFLdnlUMXA2UEplT2pFMGtTTUEyWlEwQkpYK3pIN2tOMHpz?=
 =?utf-8?B?NmFVelhPbVNtMjk3ZWQ0bzVWeWliQjZUTjJObVE0RkdDcFNMVEVESm1SUzl2?=
 =?utf-8?B?azJzMUlvNHV6SmNybExhZjRoVTdUdnh0bm1JZmgwaGluSVcyTlBIOUV6dzlS?=
 =?utf-8?B?MGJpR1RwelIyMEIyb0VHRXM1L0doL1A4UlNIU0xjRzlyR2daazNKOG0zeE5R?=
 =?utf-8?B?Tys5c3daVCtsV1IrM0JyUTAwYWt1YjViMVFqRnBqdG9uZEtoQnByUnVuam5r?=
 =?utf-8?B?NTA1NU9pdHhzNWh0L3VPYnV2UlEyK3pFODZJejlRdUQ3MktaUGFXQkEzOUt0?=
 =?utf-8?B?RkFydURtWDFuOWsxcjNyR2ZkQmNuNVVCRFpQcmtXaktOcjJGSnBJQlVDcmtl?=
 =?utf-8?B?TXZIRElTUWxmUFlPQTRiU25TVlJRQzhBeXdLUStYaVg5UkJKYlUzY2U1VlFn?=
 =?utf-8?B?cGk5Vk40aUVXYXFjZVZoK3MzajZzWnNKVi80c0ZGeG94Mk9NK3pwamVvWUgw?=
 =?utf-8?B?WDdSdWNqSGdJQ2hRRFV4UnIyQzJEdmxRRTNFNVBCVmlKTmlQNW0vQmNqMmpx?=
 =?utf-8?B?SDRPMkJtUHdJRlNJaisyYXphWEpqUlo2L0lQdGpOYk9aVEtmNk82T3FrWFlj?=
 =?utf-8?B?UnpXUEt6MjMwSklkZ0o5eExoWjNuWHB6ZDdZMHk4NGZKSlp0V2VMTis0QmJ1?=
 =?utf-8?B?Y05YekJBZk8yeU4rQ2thQXNaNlNZc09DOU5nMTRMeFFFVm1mWDhPVEg0Z29o?=
 =?utf-8?B?V1RRMUx1ZWpBRHV6MENqVFZhQjRPQUx0REsrM3pFL0s3ZE9sTWV6c0lTbTlU?=
 =?utf-8?B?SE1tY0hLQW1tN2UrdXhGZVBQY0RlRlRlOFUxNU1vcDdpMEkwTDkyajF5djY2?=
 =?utf-8?B?cTJZbG50ZjhXT2ZOZWQxV2VMOEVjSUZYaVYrbUhjTTFUYTdEclJDSTZKaUZN?=
 =?utf-8?B?MWlaUi93OWFDM1lDZ3c1N1ZLeWRzeklnV2dON05HUi94S0ZQQmNobHlWdm9P?=
 =?utf-8?B?UENYQWRlSHFlcFUvR09aUWFjbjI5OHFYU3M5SEJtTG1BMytGdDg3Skd4b0hO?=
 =?utf-8?B?VXl2T0ErbkE0RjI1L0tMSTFnOGdiNmk0ZnlhTWhPNFFXcmhyeXZob3ZIQUxD?=
 =?utf-8?B?WSttZ1VIRW1TR0xvKzhETmlRQXJ2aVpod1JoUnRsVHBmNHZjTUtveTZjejVK?=
 =?utf-8?B?ZzBGQmp1TkNGblNSNzFVcVpHSDVPVlR0SWhkS3pXcDZRWTRwTFY0N1RLV20y?=
 =?utf-8?B?Zmw3L0VZdVh4VW84Y2VwTmZBaC9MUm8xOFdyS0d5NEpSeUxWcThQZEtLbVJN?=
 =?utf-8?B?aFVGc3FxVmYzVnNaR2dOQm8xM3lHejVoc2xzWUVTV1hJUmV6dDd6MVl4Qndk?=
 =?utf-8?B?bkpoTlcwVFpDVm10bW1jY3hDTjZTNUVCcDN5ZU1sZ1JacFYwWXMzTm1MRzRr?=
 =?utf-8?B?MlRLZjRWMWc0WHJqOFY0YVRFSW9nRWloZFVzSkYyTDVMQ09NZjdXQnVBVm9x?=
 =?utf-8?B?OVExVU5YdkZVRkdDRkpiOTUyaHdMV202TXRTZXVRVGhsSHZQUVgwSWpPRVBp?=
 =?utf-8?B?NGZ0Q01FNkpibDNWd1N6aGxRMXZ6NHQvYS9MV1pTQXE2TW5PYlkvWC85djlQ?=
 =?utf-8?B?c1dFY0EwYjZVSDdobjZtYjBTZ05Tc0J0UmJTRGZXazF6SVJIM3I1RFVZQmZT?=
 =?utf-8?B?UENtN2h2TmQvMzdQdGNjZWpMWTFwblIvdmJ6SGkzSStRNnZLUHprYWl0YzJm?=
 =?utf-8?B?cEpaYWVyMU9lRUIxc3hFOGpML2dyVkJScnBZWXRBSTRqRW1DbzRKOW1QaWFs?=
 =?utf-8?Q?HLUzNozUI2oKDtZzVvJ9XhIn7?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5444.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eef2e2a2-3000-4e74-085c-08db466b44b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2023 15:31:13.0512
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7n5gueTKJl/wM8QaHfBIH6ugt2XRDKOKXF5heeuca08o0rC06znmBLiQud/zcOBssxGX4r1vtXVyBqQ8pJXzRsYr4tM1sA1/apPpySpAD9E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7129
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEhhamRhLCBBbmRyemVqIDxhbmRyemVq
LmhhamRhQGludGVsLmNvbT4gDQpTZW50OiBXZWRuZXNkYXksIEFwcmlsIDI2LCAyMDIzIDg6MTQg
QU0NClRvOiBpbnRlbC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBsaW51eC1rZXJuZWxAdmdl
ci5rZXJuZWwub3JnOyBDYXZpdHQsIEpvbmF0aGFuIDxqb25hdGhhbi5jYXZpdHRAaW50ZWwuY29t
PjsgSGFqZGEsIEFuZHJ6ZWogPGFuZHJ6ZWouaGFqZGFAaW50ZWwuY29tPjsgQXVsZCwgTWF0dGhl
dyA8bWF0dGhldy5hdWxkQGludGVsLmNvbT4NClN1YmplY3Q6IFtQQVRDSCB2NyAwLzJdIGRybS9p
OTE1OiBIdWdlcGFnZSBtYW5hZ2VyIGFuZCB0ZXN0IGZvciBNVEwNCj4NCj5UaGlzIHBhdGNoc2V0
IHBhdGNoZXMgc2VudCBieSBKb25hdGhhbiBhbmQgQW5kaSwgd2l0aCANCj5hZGRyZXNzZWQgQ0kg
ZmFpbHVyZXM6DQo+MS4gRml4ZWQgY2hlY2tpbmcgYWxpZ25tZW50IG9mIDY0SyBwYWdlcyBvbiBi
b3RoIFByZS1HZW4xMiBhbmQgR2VuMTIuDQo+Mi4gRml4ZWQgc3RhcnQgYWxpZ25tZW50IG9mIDJN
IHBhZ2VzLg0KPg0KPlJlZ2FyZHMNCj5BbmRyemVqDQo+DQo+Sm9uYXRoYW4gQ2F2aXR0ICgyKToN
Cj4gIGRybS9pOTE1OiBNaWdyYXRlIHBsYXRmb3JtLWRlcGVuZGVudCBtb2NrIGh1Z2VwYWdlIHNl
bGZ0ZXN0cyB0byBsaXZlDQo+ICBkcm0vaTkxNTogVXNlIGNvcnJlY3QgaHVnZSBwYWdlIG1hbmFn
ZXIgZm9yIE1UTA0KPg0KPi4uLi9ncHUvZHJtL2k5MTUvZ2VtL3NlbGZ0ZXN0cy9odWdlX3BhZ2Vz
LmMgICB8IDg4ICsrKysrKysrKysrKysrKy0tLS0NCj4gZHJpdmVycy9ncHUvZHJtL2k5MTUvZ3Qv
Z2VuOF9wcGd0dC5jICAgICAgICAgIHwgIDMgKy0NCj4gMiBmaWxlcyBjaGFuZ2VkLCA3MSBpbnNl
cnRpb25zKCspLCAyMCBkZWxldGlvbnMoLSkNCj4NCj5DYzogaW50ZWwtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZw0KPkNjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+Q2M6IEpvbmF0
aGFuIENhdml0dCA8am9uYXRoYW4uY2F2aXR0QGludGVsLmNvbT4NCj5DYzogQW5kcnplaiBIYWpk
YSA8YW5kcnplai5oYWpkYUBpbnRlbC5jb20+DQo+Q2M6IE1hdHRoZXcgQXVsZCA8bWF0dGhldy5h
dWxkQGludGVsLmNvbT4NCj4tLSANCj4yLjM5LjINCj4NCj4tLS0NCj5Kb25hdGhhbiBDYXZpdHQg
KDIpOg0KPiAgICAgIGRybS9pOTE1OiBNaWdyYXRlIHBsYXRmb3JtLWRlcGVuZGVudCBtb2NrIGh1
Z2VwYWdlIHNlbGZ0ZXN0cyB0byBsaXZlDQo+ICAgICAgZHJtL2k5MTU6IFVzZSBjb3JyZWN0IGh1
Z2UgcGFnZSBtYW5hZ2VyIGZvciBNVEwNCj4NCj4gZHJpdmVycy9ncHUvZHJtL2k5MTUvZ2VtL3Nl
bGZ0ZXN0cy9odWdlX3BhZ2VzLmMgfCAxMDUgKysrKysrKysrKysrKysrKysrLS0tLS0tDQo+IGRy
aXZlcnMvZ3B1L2RybS9pOTE1L2d0L2dlbjhfcHBndHQuYyAgICAgICAgICAgIHwgICAzICstDQo+
IDIgZmlsZXMgY2hhbmdlZCwgODIgaW5zZXJ0aW9ucygrKSwgMjYgZGVsZXRpb25zKC0pDQo+LS0t
DQo+YmFzZS1jb21taXQ6IDRkMDA2NmExYzA3NjNkNTBiNmZiMDE3ZTI3ZDEyYjA4MWNlMjFiNTcN
Cj5jaGFuZ2UtaWQ6IDIwMjMwNDI1LWh1Z2VwYWdlLW1pZ3JhdGUtMTg2OWFhZjMxYTZkDQo+DQo+
QmVzdCByZWdhcmRzLA0KPi0tIA0KPkFuZHJ6ZWogSGFqZGEgPGFuZHJ6ZWouaGFqZGFAaW50ZWwu
Y29tPg0KDQoNCkp1c3QgcmV2aWV3ZWQgdGhlIGNoYW5nZXMgcHJvcGVyLiAgSXQncyBiZWVuIGEg
d2hpbGUsIHNvIEkgZG9uJ3QgcmVtZW1iZXIgZXZlcnl0aGluZw0KYWJvdXQgdGhlIHByaW9yIHZl
cnNpb24sIGJ1dCBJIHRoaW5rIEkgcmVjb2duaXplZCB3aGF0IHdhcyBjaGFuZ2VkOg0KDQotIEkg
d2Fzbid0IGF3YXJlIGEgMjEgYml0IGFsaWdubWVudCB3YXMgcmVxdWlyZWQgZm9yIDJNIHBhZ2Ug
c2l6ZXMuICBJJ20gZ2xhZCB5b3UgY2F1Z2h0IHRoYXQuDQotIFRoZSBleHRyYSBkZWJ1Z2dpbmcv
ZXJyb3IgaW5mb3JtYXRpb24gd2lsbCBiZSBoZWxwZnVsIGluIHRoZSBjYXNlIG9mIGEgZmFpbHVy
ZS4NCi0gR3JhYmJpbmcgdGhlIHBlci1jb250ZXh0IFZNIGluc3RlYWQgb2YgdGhlIHBwZ3R0IHZt
IHNvdW5kcyBnb29kIHRvIG1lLg0KDQpFdmVyeXRoaW5nIGhlcmUgbG9va3MgYW1lbmFibGUuDQpB
Y2tlZC1ieTogSm9uYXRoYW4gQ2F2aXR0IDxqb25hdGhhbi5jYXZpdHRAaW50ZWwuY29tPg0KVGhv
dWdoLCBnaXZlbiBJJ20gYWxzbyBvbmUgb2YgdGhlIHNpZ25lZC1vZmYtYnlzLCBJIGRvbid0IGtu
b3cgaWYgbWUgYWNraW5nIGl0IGlzIGV4YWN0bHkgYWJvdmUtYm9hcmQuDQotSm9uYXRoYW4gQ2F2
aXR0DQoNCg0KPg0K
