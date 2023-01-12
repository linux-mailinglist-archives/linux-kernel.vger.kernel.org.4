Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7CC6668BF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 03:13:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjALCN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 21:13:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231803AbjALCNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 21:13:23 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F23026F;
        Wed, 11 Jan 2023 18:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673489602; x=1705025602;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=U7Vcf7HUMJDu7AmyiS93ZeozakLcGjra+JtTtMdEYYU=;
  b=EW8uCT3vui1cUD2vNLEQ1jTY40pze1ruaGItZzTh+XyXmb9jvo5h3xf7
   eOxweodcZ11PmNGXFxh14UgA4sZsneju6RBJzedWJEUcHWYiiMLv+IaGb
   m+km/mc68+173/gzPibT78eWqpFaeozrDKBYVecy9JdE7ViN1SIDge661
   BaUQhFAq6Q1cW3GoRFUWH3y0gGGlIAZLLkzhgB54/T0UFSh7aeBAdBaNv
   Tu3Q0TWc1GWRnjJiiP+amo1w6wYppLT81mUm6BXlHJVz0+jC/KiovWUMO
   SqrnWZyDo1dqejO1XzCH4EotdZErPMS9I6ZJPfNBMqHAATXkWhPh5YCaz
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="409826620"
X-IronPort-AV: E=Sophos;i="5.96,318,1665471600"; 
   d="scan'208";a="409826620"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 18:13:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="800038648"
X-IronPort-AV: E=Sophos;i="5.96,318,1665471600"; 
   d="scan'208";a="800038648"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga001.fm.intel.com with ESMTP; 11 Jan 2023 18:13:21 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 11 Jan 2023 18:13:20 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 11 Jan 2023 18:13:20 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 11 Jan 2023 18:13:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BxYRMaNOkdznzJVqX9+MjQRue+DyVeZy6cHWqKT/FQB5GUwjnllxdTXzBckdRoXxRJjozHYwOd2peh7FdMWbzvVonBuM6iGgH4C5lr69POKSns8wcDciDRr0IwbA35cK5beXU4HZQJSISBwyDlGDvQidIjRfrstIi3oiTW/3A2sVcFx/1hpNbnrDPscPw3n3gRNRrYBLUw7Ho3B6H54wVaClwgkvER2OpAlIMcQ5IPv3MiFeEC4CICIlabfRc5MBXA6SO00ZWcSUMlgD4m/6gfCNzGayNm7QUG+CQ2MP69oJiSM82UlX4a21dDj/mvxWc5RHk28HyVwXrImNbwguBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U7Vcf7HUMJDu7AmyiS93ZeozakLcGjra+JtTtMdEYYU=;
 b=oCo2UAU9sG3Ipw5VnBL5qakBR6DNFoTjSdYvoSathuh3mjD1gvFCM8YpbcKe7xMV9BIbvTQm2XtxigsA2B0jSuzdHCl/PGZkc2i7mVTp6Ppnbwe9YGtGqU6RxCNSOnl0uQ512mq86i1+0GXQlwOf/fgwxrGYpJwaWUBl5YrtPzvqeqK7Q+2NGEDevj6msv4SwbnhAyeAy6UMGlfCEKIR1Cw+0KsBkAj3mtn3OTBSIdjcy2yNJB0cM+h8++Me/nqhdNz59Ndw6uRRbbmvY7GfvfG8eWihwjC+yCxdkzZXiUrB9i0I14pTuoOISITfztL5h4Rkr62nJIQc6wFt3UAXug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by IA0PR11MB7283.namprd11.prod.outlook.com (2603:10b6:208:439::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Thu, 12 Jan
 2023 02:13:14 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::e30c:74f4:5052:6fd2]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::e30c:74f4:5052:6fd2%6]) with mapi id 15.20.5986.018; Thu, 12 Jan 2023
 02:13:13 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "rafael@kernel.org" <rafael@kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>
CC:     "srinivas.pandruvada@linux.intel.com" 
        <srinivas.pandruvada@linux.intel.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "christophe.jaillet@wanadoo.fr" <christophe.jaillet@wanadoo.fr>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v4 0/3] Thermal ACPI APIs for generic trip points
Thread-Topic: [PATCH v4 0/3] Thermal ACPI APIs for generic trip points
Thread-Index: AQHZJQa9JdJI+aJ8s02kRrdU2KA97q6ZHFcAgAAxf4CAAANnAIAAu40A
Date:   Thu, 12 Jan 2023 02:13:13 +0000
Message-ID: <ea4380ed951317c0a2cc472adff04256e95c232c.camel@intel.com>
References: <20230110151745.2546131-1-daniel.lezcano@linaro.org>
         <b070cfab-b8ab-f795-0c98-fc874f05f16b@linaro.org>
         <d51432466ed6b1a8eef0e966bf1b2c2bb2e1e37f.camel@intel.com>
         <31c07acb-adcf-3c7e-c415-fa2cd67fd12f@linaro.org>
In-Reply-To: <31c07acb-adcf-3c7e-c415-fa2cd67fd12f@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|IA0PR11MB7283:EE_
x-ms-office365-filtering-correlation-id: 94cf36eb-1f07-4202-25d5-08daf4428f7b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Qf9sCB0a6ev5gfim2uUqTYI0gS9xqG5u0sP2lKCHYNMv6OwOMM8nd4tK6RCN0wHVWBkXLuOlx0jyNB/FwJmEGTM+Va21pZykRN2IVggv2qw2Rpihuzu/HwwtM98n4L2Esyt8oWSWrhh/j14gPnjONC93uDYf+j78YLczpbWVNx/VBq37U4MjwClH26XoOIeXIxf99WR4qInoUW4l718YwLwVDxrLmxVwpZrHffnAIo0op55VPpWhLxPJJQOm86dgWM/Zpf2MblNasAm/MEtV8kGomh711QV65m54EbnQDTH2+Cxy6LPhpVX/vFLlWLoc1tdfopg81VhOJPXQQtMwUy3u+Bi2myT0GXRFNdlNSB0edQvp/DPcCaBxwpU+PBXm1y/WzMsVj8ByMEwhFrc7PL9A47Ay5POvJ5gzy+L+12uYVUFf7ow8qOpWFs3lA5xAx21ziFzUAm9RVOaaw4G1M96qVH/XxSYfnGnozoOecFdRA3zFjaLCwMg24J5h0lCgDMuQ5XwKIvXh1EuoE/BAmRhfMIBgY/Zj3POela2VLOlBZW5l9u1nV8RwGHpfwlRZtaZ7n0hyXy3dD3cXsNJ/Rye7FmOiQjSUufaAsn5ktc5onEThsPM6DWa1qfU9efE2/XkVowHhlffjAUqrbpMIJSCWP6jfcqDf4g4Xc6DJ0Cfz/gLh557WkpfvtRitLHjyiJfL2HzPgJ8JrreTzrjXR2MF2kYUG8f2mit80Yr0gxA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(136003)(376002)(346002)(366004)(396003)(451199015)(36756003)(82960400001)(4744005)(2906002)(38100700002)(122000001)(8936002)(5660300002)(41300700001)(4326008)(38070700005)(86362001)(83380400001)(6486002)(54906003)(110136005)(6506007)(478600001)(66556008)(66476007)(64756008)(8676002)(316002)(91956017)(66446008)(71200400001)(53546011)(76116006)(66946007)(6512007)(2616005)(26005)(186003)(41533002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YUpmMDQyYnRjV09SUElJVXVJODRLS0RkZmtyZGo4ZGc4STR3WXQ1TGd0ZTJ4?=
 =?utf-8?B?ZDBJRUxoNUVoYWJ0eHIvVDBFb21tMEcvbFZyNTlkVnRBb0hURnB1RWc3TUUy?=
 =?utf-8?B?dDBrZUxVV2R1K25aaUN6dWQ0NWQzdzd1UG1KWTl2SW5UVHN0M3V4YUFNRm5k?=
 =?utf-8?B?M1orYnZLQjZGMTR0Q2FWNUIreDkwUDdvVnphSUdTMldrb0NuRis4MjZMcnRi?=
 =?utf-8?B?MVZDYnJuY1RUVnZNR0JsQUYwSHdYZzFEa2VsdDZRdW5sYWFqTlphUHAxZTlG?=
 =?utf-8?B?WWoxdWxKdTJSbW1RNDNjd0RySmdpNktPcGE1ZWd2dG14YVJLWjhsZlJhMVp3?=
 =?utf-8?B?NXIram9XOWRuV3czQW5IT1lrZjFXWFlUaDBEVVRISEh4ZWQ3VUFMWlVWcDls?=
 =?utf-8?B?TDR2RnNYOGZOYkhzcXMxdlpjWXplRWh5V0FvNmhNWVlkT1ViOExsYmhUUVYv?=
 =?utf-8?B?a3BwL0M3Uk5aYkxpRjdxOWljRnRmZXJ1SGVVZWltSFZxVHk1WFFBZFhHUE9U?=
 =?utf-8?B?Slg4V3BZeHZpWnZvL1hRYlJ5T1VhWFZFMDZrY1hBdFdSbEo3djNDUkdRNm5Y?=
 =?utf-8?B?Q1VxZWRlYnN1ek00K0hycnlKRTVHY0owa0p2UWdadExKck43ZDk4alRBd2hh?=
 =?utf-8?B?Ylp4Q1VTU3NMcTR0RjA0YXFVeDE4dG1GdGg3QTZzWWZZM0I3NXpTV1E4NFF3?=
 =?utf-8?B?NDRpY3JWV0lqUnRpUjF0dGF6Vm9mallQYVl6ZjJ0MXNKS2RScXRsbWtlVVNH?=
 =?utf-8?B?RTEySE00V3p4U3ZGWFlWMW9SajFXcnVJTVJjL0lpWnFCNzFhalpuZEx3THIz?=
 =?utf-8?B?d2JyQU80WEdrSkMvMHBPVU5reUl0WUlCQXNTU1VWUkxCZ1ZTMHpQL1NRRXhi?=
 =?utf-8?B?VFo4NWxhSXpJMGZTYnlGdlhidW9qd3ZCUEd2cHAwQktKS1BQOUtydVEvcGZk?=
 =?utf-8?B?a1pJNTRIOTZhQnNxL1M5dHB3UUpwNXRGdjBJalhPK0U0bkZOYnVzZDR4RTBQ?=
 =?utf-8?B?SUV5UkpKZ3JuS3RGL1o0em5tQ0lKV1o2aUs5ZHdqSENvNnM2S0dOd3dReXE0?=
 =?utf-8?B?ZktlalcwdWxFMDFxNC9yS0ZCZWU5Z3Q2djNqOTF1MExvRlFFbFl1eTRsenEz?=
 =?utf-8?B?alR2eWgxc0oyMVRBczR6ME83SkVyenRyeU1mbExZMVlDZkNFelZ3b1oxVnBm?=
 =?utf-8?B?YXRXZ01wdjlmaUZVZXp6MmN3bjYxUlc1RUNUOWdXUFV1RW8xdUxrOTIwSWxv?=
 =?utf-8?B?S2VVMTNBWjhueFRzTi9wdDJlVHBwcFlqK2xXZ2NhdkgzL292TWMyVVNyYVRB?=
 =?utf-8?B?aElQVXhyaGhMdjZ0dzBYU05PdnYzbWFZUHdTYy9GOEYrRkJLYkRHbnpYNktO?=
 =?utf-8?B?bGowOXhLbHNVbkJIY3JZQTlEYUwrN2Y1Y3lMVkN5V1k2MWF3Tlp5T2p6cFlZ?=
 =?utf-8?B?Vm1KSTd4R0dHeldVS1ErVm1aeERNa1RwUUVKQ0t5UzJzbk1ETGtEK1lTcVpX?=
 =?utf-8?B?NGJtOHVlanhMazF2MmozWkNCMGY5WnFaZVk1N0ZYYzlLdWY0VUdabXFyNE0r?=
 =?utf-8?B?U29ENWJ2REx4d0xjSVNuenIvSWJWNlVOL3pFSWxISmczSm9sSlVIZFpZd2JU?=
 =?utf-8?B?VVZlT2Jnc0lEdE1MQVhHSm9EOTdPUGhUc1ZEMnVIZFRsZkF3WU5tQ0lxTC9H?=
 =?utf-8?B?YTFXcVJzSVFWL3FMdnR1blJLc1E0SVdSZmFUenhBdUtybmpEaGtSbmd2ek50?=
 =?utf-8?B?MXBSTE5TOWxTVWlJK214Um5MT0FjdDB4eUtHaTZtcWE0R1A5SHM3RUJVWkVE?=
 =?utf-8?B?S1dVaCs0S2FOWlVNbjJlMzIxOTg1MkxEN1Y1QXRPL0JVK3VMbTZuZHo2WG5j?=
 =?utf-8?B?WTRFZUlibzVjc1I4WXdYQWxPQ0wxNFBha1FQbWlVbWlNdmQyUklHU2EySlVu?=
 =?utf-8?B?WHRuU2FDRFhJM2l5RWI2Z2tVWTQvdnpnazQ5MjUwTTI2cEZIdkhYcVhiMjVt?=
 =?utf-8?B?YXVHbGllRjRlMTNQQ1ZOaEJwTzVyaXI3L1htb0w1VGVTSUhQc1FBQ3Z6dE9V?=
 =?utf-8?B?Njk0UHlYcCtOZmZ3d3VBcGpPVUFUYS9reEJ4Y3gvai9kejhuVDE0dEpqaUVz?=
 =?utf-8?Q?kodsAim1qJixQtcMtWLyadmVz?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8E839EAA0398344591F9B9755A195698@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94cf36eb-1f07-4202-25d5-08daf4428f7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2023 02:13:13.8265
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f6LDYaBdjbEDcpFTuJpm5dzXk4KM7xLPAzS5e6z/Tg5q5RNh1Qu1BRWuZExjTJeKV6xV6FWRWfAWeAMs/lKXkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7283
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIERhbmllbCwNCg0KT24gV2VkLCAyMDIzLTAxLTExIGF0IDE2OjAxICswMTAwLCBEYW5pZWwg
TGV6Y2FubyB3cm90ZToNCj4gT24gMTEvMDEvMjAyMyAxNTo0OSwgWmhhbmcsIFJ1aSB3cm90ZToN
Cj4gPiBPbiBXZWQsIDIwMjMtMDEtMTEgYXQgMTI6NTIgKzAxMDAsIERhbmllbCBMZXpjYW5vIHdy
b3RlOg0KPiA+ID4gQ2FuIEkgY29uc2lkZXIgdGhlc2UgY2hhbmdlcyBvayBmb3IgdGhlcm1hbC9i
bGVlZGluZy1lZGdlID8NCj4gPiA+IA0KPiA+ID4gDQo+ID4gSGksIERhbmllbCwNCj4gPiANCj4g
PiBJbiBnZW5lcmFsLCB0aGUgcGF0Y2ggbG9va3MgZ29vZCB0byBtZS4NCj4gPiBCdXQgY2FuIHlv
dSBnaXZlIG1lIG1vcmUgdGltZSBzbyB0aGF0IEkgY2FuIHRlc3QgdGhlbSBvbiBteSB0ZXN0DQo+
ID4gYm94IGJ5DQo+ID4gdGhpcyB3ZWVrPw0KPiANCj4gQWgsIHllcywgZGVmaW5pdGl2ZWx5LiBJ
ZiB5b3UgaGF2ZSBhIHRlc3QgYm94IGZvciB0aGVzZSBjaGFuZ2VzIHRoYXQNCj4gaXMgDQo+IGF3
ZXNvbWUuDQoNClllYWguIEkgaGF2ZSBvbmUgdG8gdGVzdCBib3RoIGRyaXZlcnMuDQoNCj4gDQo+
IERvIHlvdSBoYXZlIGEgc3VnZ2VzdGlvbiBmb3IgYSB4ODYgcGxhdGZvcm0gdG8gdGVzdCBxdWFy
a19kdHMsIA0KPiBwcm9jZXNzb3JfdGhlcm1hbF9kZXZpY2VfcGNpIGFuZCBpbnRlbF9zb2NfZHRz
X2lvc2YgPw0KDQppbnRlbF9zb2NfZHRzX2lvc2YgaXMgZm9yIEJheXRyYWlsIHBsYXRmb3JtLiBC
b3RoIEJheXRyYWlsIGFuZCBRdWFyaw0KYXJlIG5lYXJseSAxMCB5ZWFycyBvbGQsIGFuZCBJIGRv
bid0IGhhdmUgYW55IG9mIHRoZW0uDQoNCkZvciBwcm9jZXNzb3JfdGhlcm1hbF9kZXZpY2VfcGNp
LCBpdCBzaG91bGQgYmUgYXZhaWxhYmxlIG9uIEFsZGVybGFrZQ0KcGxhdGZvcm1zLiBBbmQgSSBo
YXZlIGFuIGludGVybmFsIHBsYXRmb3JtIHdoaWNoIEkgY2FuIGhlbHAgdGVzdCB0aGUNCnBhdGNo
ZXMuDQoNCnRoYW5rcywNCnJ1aQ0KDQo=
