Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45B267020B7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 02:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235618AbjEOAIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 20:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjEOAIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 20:08:37 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B2B710F5
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 17:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684109316; x=1715645316;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LUc7qyT0ZVQNiqAJkB4L40QOFfF15BR6h24flfzpKlc=;
  b=inu0tu/U9iViN4gMgzyXAyIkLKmI+TZ1pvlMcHgI9PO3hv+543x/cty2
   OpUkJwRxDkWl9x93spvTNieKCkOlaPWmjRM4TOaTxTKlTkKby3YjT04p5
   WKWhbZl4dDLaDY6A1odyvLpXUKt6S7qgN63jjOX+V/OeozKW1TankYDXa
   uX2KoeKOesu+O7gHWRo47x/LJy8NvxgOf52dt80azEeb3u/0aib85SXVj
   IsQohoMKFzejMruyiUnpOPTe49Gvff82AX1ArzWLIMYs2aCjDKsVkEdxz
   zLp9MlheFeGXZEx8n69d2TOrSj6oGTi/Y4x8bRG4GybA90aUJeTMwmAFW
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10710"; a="349922465"
X-IronPort-AV: E=Sophos;i="5.99,275,1677571200"; 
   d="scan'208";a="349922465"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2023 17:08:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10710"; a="1030705208"
X-IronPort-AV: E=Sophos;i="5.99,275,1677571200"; 
   d="scan'208";a="1030705208"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga005.fm.intel.com with ESMTP; 14 May 2023 17:08:35 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sun, 14 May 2023 17:08:35 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Sun, 14 May 2023 17:08:35 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Sun, 14 May 2023 17:08:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fcTusmID/93yDD+8Yfy7H+qTmmLpmGYCX72UbBtYkr70+T61Pkuaa8pNuW2jL6yqp+PgjaIpEBi5DfSyqflI5hg9EQ9Oc0co/GqPb9kJhG/mgIidrGg0QXQaJMxyjz36f1lBEqv+r8U1dRQy2QP1HTsnb3a3kCRPlMXNTNsZH1jqE9mA7yf+Au9N30F3i4OUTzIKK70FN4xSHzHMnbgWsXfzYm0NzVAx3ZpvHFSjaot0aib2Bf9LxTu8RPIO23/V+MUK0PRxGphPPY0IBGsc4X/vTJtimN+3ol+zelXr+xmqvMYblKTvoNW1jV0SLqoOaBp8VeFotvqQmBWuPv5AQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LUc7qyT0ZVQNiqAJkB4L40QOFfF15BR6h24flfzpKlc=;
 b=cqDdhlR6qh/Zb4RzUN3/a1rjVZ8utNP0fIZQj34Sik+Z3MillU8Sxv8iFFZvkl4HuxQvcjH1nq7NmJV4irrhDOeTRhms2TTNFhJt5XfBva12IIQI+VN53taUCudda6DIgSAvJd66RCDfQwE12qZZFa81rrkJ+vyFnoO9BQneLKBFtpAy5KsDpn7ZX8IZjn0aGwYWNo9w5DJQxNb7d48prn4fQvzHcFU66gVTk0pTcVs6jEc1ypHxrjpzaBBBiKul+eC5D+cBDA5HXLz5WpnEuihCd1l0w8ZjuhvNc7ASbInx9eZfcBas1F+AxbW5NawgmgFSLFD/CZqEUuqXFgfwCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5370.namprd11.prod.outlook.com (2603:10b6:408:11b::8)
 by MW3PR11MB4633.namprd11.prod.outlook.com (2603:10b6:303:5b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 00:08:31 +0000
Received: from BN9PR11MB5370.namprd11.prod.outlook.com
 ([fe80::5462:3495:2a92:72a2]) by BN9PR11MB5370.namprd11.prod.outlook.com
 ([fe80::5462:3495:2a92:72a2%6]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 00:08:30 +0000
From:   "Chang, Junxiao" <junxiao.chang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Hocko, Michal" <mhocko@suse.com>,
        "jmarchan@redhat.com" <jmarchan@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "muchun.song@linux.dev" <muchun.song@linux.dev>
Subject: RE: [PATCH] mm: fix hugetlb page unmap count balance issue
Thread-Topic: [PATCH] mm: fix hugetlb page unmap count balance issue
Thread-Index: AQHZhKJKazzbSBIjB0GWoh8AQ8c7Qa9XIT+AgANWVFA=
Date:   Mon, 15 May 2023 00:08:30 +0000
Message-ID: <BN9PR11MB53701B3F2930540D2704E230EC789@BN9PR11MB5370.namprd11.prod.outlook.com>
References: <20230512072036.1027784-1-junxiao.chang@intel.com>
 <20230512140353.8b95e8cb024c8e7a1a3b03c1@linux-foundation.org>
In-Reply-To: <20230512140353.8b95e8cb024c8e7a1a3b03c1@linux-foundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5370:EE_|MW3PR11MB4633:EE_
x-ms-office365-filtering-correlation-id: 4afac1f1-2ec8-47a1-33cc-08db54d883b0
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U7JX1z/i84jUHC8xgzvv30T0o5HL+HObpe5VgFB9M3UHZw9mU8Sd7hiGJ0VtZc4s8Yrltb7HlCFQ2EL/SBUYxajMvbRV3o1cA8qadFHx7bLATEXinjSrXKmTUxpAFNnqOlu01whsYAPPA9lDZxWDl/LD/bIX3eeq95/Qt8aQihL2EJ5jaHZ7v2AJM9bM9xljU+02TlFa8iGH1ULrvuABPZDQJ4fyfLsixKcO7qZWMxIpLBkeEDqV4DITQpc921KrnJQHzdLckTTil36FYpdZ8cyLs/R4CqUqcaxzy+jHas4w6V02HCP5awZJ0EtTEFr3R6Ju0W5w99q4l+ZzSvnUpZ23/uTkMcrsiUhHpUrqMj2rFE2uw+im63cfnQnfQhwl5Q2yjSPioG3cr2MV2WznBg1VPYvzK+sDXzfzM5uc9C+jVhOXK6POV3apdq3GTzXcFsf8ewBQc2pE8RNgE4FLMGoLTKf5xBR7sGL5j4CsS5Ifc3Tea9O95uDHg/Bwu6qndb79JkyV9FA7uzfMPwrMOYIlm5P8C/3fAfncCmp9vaEYvlamEqGlT925vr1rBj/y2Y9mrCnwuvtBIcgY0MwJCyWTj4KZm0pYOkD/zoEmhspC6wwF0p01EjhcdhFWHBO1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5370.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(39860400002)(136003)(376002)(346002)(451199021)(33656002)(86362001)(54906003)(316002)(76116006)(66556008)(66476007)(66446008)(64756008)(6916009)(66946007)(4326008)(478600001)(7696005)(71200400001)(55016003)(8936002)(8676002)(5660300002)(52536014)(41300700001)(2906002)(38070700005)(82960400001)(122000001)(38100700002)(26005)(186003)(53546011)(9686003)(6506007)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?KzlrQTZVNGNVWk1ESUlEYURQYTRWZnkzYVZuUU9ZdHJ4YUg3eE9wN0k3Tlp3?=
 =?utf-8?B?eEFadExyRVZueFlFcDViK0IzKzBNMzRkU3g3WmVtKzBGeTIxY1JvMng4QnVX?=
 =?utf-8?B?UmpiWFpIUG5SbWdMMGNGbllkZStJTlR1VUkzdHVYU3crc2xzWU03VUdBK1FF?=
 =?utf-8?B?dXVFWUpObG5YYXIyZS8rMWVxM3JFdlZhaTFjZ2lNa2w1MWt5WldocE56YmpK?=
 =?utf-8?B?a2hnN2tKamtGQ0xYbWcyWkJGNGlZR1ZPRFJUSW84ZGRWM2Q2RjdoQndYYjhx?=
 =?utf-8?B?MDltczlIclBTT1l2dncrdGZWVHVUTWtZTUNzWUFLWkdzSm8rUXU1TjQ1bVo3?=
 =?utf-8?B?UDZ0TkRPeUc5L3FzUG1FcXBtUUlMVGMyVkF0dlVKenhRU215ZldKWWw4VlBZ?=
 =?utf-8?B?MFdOb0hUZnVYTzlhanY0ZnUvcXhxNTQ3cWFzcU90SkF0dUprRHl2TGkxS0RF?=
 =?utf-8?B?TXdvMGw4c0kzcmI2OGpLTjV2Q29neHR6OTZXVktnMkZsLy9rNW5KMlV5UFNZ?=
 =?utf-8?B?VEw2c3hIR3V0b2YrNmpmaHBWcXpIdWQ5NHZEYkdWdGpMYzkwazhZdWRHSGdh?=
 =?utf-8?B?YkpHcmYzWVlwMGFrVEYvK25zZitnSFFaMm84Z1dMZXZiZDdnU2pSQXJzUG1O?=
 =?utf-8?B?RCt3N3BZQnhIa3BKYkpLaVF5dWxNM1M0TGY1Qnk3M3gwRUlrNDBCT0FxYkRQ?=
 =?utf-8?B?ZFVxZTg0RTY5QkR0L0dmSWk2dzdHcjZmcU5yVkt1Z1Q1NzJERHFXV3FNQzl6?=
 =?utf-8?B?dGdPTVJ5ZitqT3ByNWlUamUvQ016Z2JBQWgrK3hyalVHVjdzaVY2RnlHd3VM?=
 =?utf-8?B?bjVaU2xlYTkvbDBnQmpxVXdQVnozeTF1bFlQWmJuWWZmMmE2NGUzY1NXRFIz?=
 =?utf-8?B?elFwamVaWDg3em5QenZySkVtTmlrU09lNlY1dVVWWk5wTlloeXNuaVp2ZlRp?=
 =?utf-8?B?L3djV0IzRWFwWGJVOVdzZFNNZEtZM0lyVFBYeGZyMFJKbGNVNzlOeWk0WHgx?=
 =?utf-8?B?Q0hKakt1VTFCdlc1UHV4MjJhVHJLV2w5T0NjSHRMaGdQc1p1ZTNTcHpzbHI5?=
 =?utf-8?B?cHp5OC9NSVlwR0gveGsyOElOK2VsaXBOMlpZaVJGYVVSVUdLTTF0dUx5QUdY?=
 =?utf-8?B?RHN5VG4zV08wMHhSNC9iT0xPMUVab3FuckdLTHJqd2hhNzZmZEFOSVJwOFFT?=
 =?utf-8?B?a3hTcWEvM01jMWo2eUhEL2l1OW85U3VJK2JjS1QwWEVyVFp3eWMrcXpJM0sy?=
 =?utf-8?B?Mk5JemtVS2YzRzhwUWdYY3ZudG54cXFkd0EvSkdoakRLNGptcExVVENsbjl3?=
 =?utf-8?B?VWFBUVlnRFRNZmJ1ZjY5SEZGMXNUelJBdFFGL2Z4UE8rRXRTK1RsZHJCdzlQ?=
 =?utf-8?B?MGNKWG9jWWxIQWZsLzNYVTVLd3VGdDUxSzdsVlZVSnIxREVEMVlUbXB2MGps?=
 =?utf-8?B?K01pMkFFTThyM2tSSG5JMGh4VzhiM2Vsay9QMlJQUGVLNk9hRENraXpCYis0?=
 =?utf-8?B?cmVqakRRVVNzYm9lUENDa1ExZUZYVWtTeTdyd1orcEhvZ3Q5MVJTUWFBbEFj?=
 =?utf-8?B?NmQzb0VZQ3VWWU04QTBTTUZldkpyYnJraXRSZTZLVkh1T2VrbGwvT3RvNzZO?=
 =?utf-8?B?Q3R1M3RNZ1NYRTl3T3BQOS9Gby8ydWU0YTJzQzZVb25wSnMycHI1VkdrYXZH?=
 =?utf-8?B?MENxNFlDdDJRUG9TWkpQdGVRYk9YU0owc0FzZ0trWENOKzFaK2t0OEhtNVRQ?=
 =?utf-8?B?ek8vYURNcUhZMmNNeUZHcHdDZjZoV1RpbXpldUtkWmJ0Wnp1QkZicXF4UXlJ?=
 =?utf-8?B?VlpLazduM1FYN0xBcGIzTXFyeXJ0bDBZNlZzSnZuV0kwd3BlS2ZmbUFoTUFh?=
 =?utf-8?B?TGp3VzZ1SWlZejlOTm9NWER5dU16cVJSZG04UTNTQ21OMVRFakJkODdlYVM5?=
 =?utf-8?B?VDJsS3RBbTRqRjlxeVhSNUM4bWJBTXR5Ym5RSEkzV2tNRVhxT25SSXJVT0lE?=
 =?utf-8?B?eXhWSjdYOVlhb25QNGdXSWsrcDcrRUZhMmFaS3M0UXlrQVluU0lkZXlISStG?=
 =?utf-8?B?K1RySjJ5Tmpaa0p4c2JSRDVMWTkraVQ5VVFGWHZKMmRpNGlEWm1JZDdHcXNY?=
 =?utf-8?Q?IBc4NoAxzGCGVTjA3YrK7Yr/X?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5370.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4afac1f1-2ec8-47a1-33cc-08db54d883b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2023 00:08:30.2064
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GmnWD4HOZftS63Aw2Tpi2qx7breWQp+mYJgMMJGeADttSD5ZTWKzpSYk0fm480X+Lyqe6hE/uZcKDAHZRNJ1pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4633
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhhbmsgeW91IGZvciByZXZpZXcgaXQhIFdlIG9ubHkgcmVwcm9kdWNlZCB0aGlzIGh1Z2V0bGIg
bWFwcGluZyBpc3N1ZSB3aXRoIFFFTVUgY29tbWFuZCB3aGljaCBvcGVucyB1ZG1hYnVmIGRyaXZl
cihkcml2ZXJzL2RtYS1idWYvdWRtYWJ1Zi5jKS4NCkkgYWdyZWUgd2l0aCB5b3UsIGl0IGlzIGJl
dHRlciB0byBtYXAgaHVnZSBwYWdlIHdpdGggYSBwbWQgaW5zdGVhZCBvZiBhIHB0ZS4g8J+Yig0K
DQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogQW5kcmV3IE1vcnRvbiA8YWtwbUBs
aW51eC1mb3VuZGF0aW9uLm9yZz4gDQpTZW50OiBTYXR1cmRheSwgTWF5IDEzLCAyMDIzIDU6MDQg
QU0NClRvOiBDaGFuZywgSnVueGlhbyA8anVueGlhby5jaGFuZ0BpbnRlbC5jb20+DQpDYzoga2ly
aWxsLnNodXRlbW92QGxpbnV4LmludGVsLmNvbTsgSG9ja28sIE1pY2hhbCA8bWhvY2tvQHN1c2Uu
Y29tPjsgam1hcmNoYW5AcmVkaGF0LmNvbTsgbGludXgtbW1Aa3ZhY2sub3JnOyBsaW51eC1rZXJu
ZWxAdmdlci5rZXJuZWwub3JnOyBtaWtlLmtyYXZldHpAb3JhY2xlLmNvbTsgbXVjaHVuLnNvbmdA
bGludXguZGV2DQpTdWJqZWN0OiBSZTogW1BBVENIXSBtbTogZml4IGh1Z2V0bGIgcGFnZSB1bm1h
cCBjb3VudCBiYWxhbmNlIGlzc3VlDQoNCk9uIEZyaSwgMTIgTWF5IDIwMjMgMTU6MjA6MzYgKzA4
MDAgSnVueGlhbyBDaGFuZyA8anVueGlhby5jaGFuZ0BpbnRlbC5jb20+IHdyb3RlOg0KDQo+IGh1
Z2V0bGIgcGFnZSB1c3VhbGx5IGlzIG1hcHBlZCB3aXRoIHBtZCwgYnV0IG9jY2FzaW9uYWxseSBp
dCBtaWdodCBiZSANCj4gbWFwcGVkIHdpdGggcHRlLiBRRU1VIGNhbiB1c2UgdWRtYS1idWYgdG8g
Y3JlYXRlIGhvc3QgZG1hYnVmcyBmb3IgDQo+IGd1ZXN0IGZyYW1lYnVmZmVycy4gV2hlbiBRRU1V
IGlzIGxhdW5jaGVkIHdpdGggcGFyYW1ldGVyICJodWdldGxiPW9uIiwgDQo+IHVkbWFidWZmZXIg
ZHJpdmVyIG1hcHMgaHVnZXRsYiBwYWdlIHdpdGggcHRlIGluIHBhZ2UgZmF1bHQgaGFuZGxlci4N
Cg0KQXJlIHRoZXJlIGFueSBvdGhlciBzaXR1YXRpb25zIGluIHdoaWNoIGEgaHVnZXRsYiBwYWdl
IGlzIG1hcHBlZCBpbiB0aGlzIGZhc2hpb24/DQoNCklmIG5vdCwgY2FuIFFFTVUgYmUgY2hhbmdl
ZCB0byBtYXAgd2l0aCBhIHBtZD8NCg0KU28gd2UgZ2V0IG9uZSBsZXNzIHdlaXJkIHNwZWNpYWwg
Y2FzZSBpbiBNTS4NCg==
