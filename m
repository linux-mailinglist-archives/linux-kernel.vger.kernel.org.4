Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0C768628A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 10:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbjBAJKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 04:10:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231856AbjBAJJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 04:09:57 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE6661D5A;
        Wed,  1 Feb 2023 01:09:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675242564; x=1706778564;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=4IsYThNonca1cHZC4O2lHLz3b4tArzqP1MXYJUcExds=;
  b=ABwt86i7frdjJR3sf6Iy89xJuVfH+r9miyLHwtXpugQWb0JcAoWd3OiA
   IBz4I2LJzzMog7Jl5wXhP2Rl6SP6ORYhurcfOX+YTzKRMo2tiTH4lJq7W
   3Mt48mcpdDJ81jLQ0NnEsczNaYlLcX5/f3SIbxYoi+9LayBxeFEuAd9pX
   ehF5t9feRpFspHa8rvE/r2hMBkra+qsD6uf64uLOEnDgWEvhiKf/NBZoP
   fU+w0ZwJmOaLfe7X2eIoyN9vd+LkhUr4L+b58iox9dvNeD18UrgetJeVm
   yPCzo9IBf0Yh1G5uYmSoAq8SuNYniIbR6g9DIn1GYpICnSoEufh7Xywce
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="329385052"
X-IronPort-AV: E=Sophos;i="5.97,263,1669104000"; 
   d="scan'208";a="329385052"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2023 01:09:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="788809894"
X-IronPort-AV: E=Sophos;i="5.97,263,1669104000"; 
   d="scan'208";a="788809894"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga004.jf.intel.com with ESMTP; 01 Feb 2023 01:09:04 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 1 Feb 2023 01:09:04 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 1 Feb 2023 01:09:04 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.104)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 1 Feb 2023 01:09:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bJBX8r9rJAnFNj6jZD+GNOPqn7PkLF2SONhObO5jELSlLHx2QDnRxFm4lF/q9LcEEhXWPixcI5Glb8u7dcifUpMy//czc/46SY+k1HvF/6OFXqDRjIh9vZEYQOIio8GJtLJ1cer+HfhxncNTh0+D0+xIDNTqccKCJbRnral/y1wgap494KkQwklGQ4KMZeRwv2uNs7hx4tTn+F/jvkggz6pYEU8DepF6A3XNpDpEXCJbcpUJ2tiE+B+mN6aLKhCVQgQyz/fs2HeA+Xd+Nh5TxbA03AcztHCGgdKy41bitX2iyibT5A5OcMS+vsBNa5uZaAhchsYSL/zT55qjCoaJmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4IsYThNonca1cHZC4O2lHLz3b4tArzqP1MXYJUcExds=;
 b=MmECx491kBQIYEYKcC7F/ZYG5Q2qq5A1WIbB8qkeSDDpHBTMTMlaWAS7KFlkRpxwcVscHhfr5oX7ByTHB+vSc3o65gJnj3b27eIx3K0ZMQ606AG28+kfMGpnb6wqunKkLmYGnvUpALQfAkxFH/CONC/1LWxvtXhrQRT6WL1ZaZRdKGljT1e0kKd50hIIiQ61jm6Rz0Ii5U+H0+on54W+MzYB3Gah8Yees70esOkcftRIZ6fSKXfP9MHJT21EqrB+mtid3OgoKVlYGmQrKlJM0b031Q7WHbBmnuv92SdlobwftfxfQltCLp0vViuT9wX/Fn7YLFCzNyYIMBkZOlXAXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by PH0PR11MB5032.namprd11.prod.outlook.com (2603:10b6:510:3a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.22; Wed, 1 Feb
 2023 09:09:00 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::5b0e:bf7:d908:2837]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::5b0e:bf7:d908:2837%4]) with mapi id 15.20.6064.022; Wed, 1 Feb 2023
 09:09:00 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>
CC:     "srinivas.pandruvada@linux.intel.com" 
        <srinivas.pandruvada@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v2 0/4] thermal: intel: int340x: Assorted cleanups
Thread-Topic: [PATCH v2 0/4] thermal: intel: int340x: Assorted cleanups
Thread-Index: AQHZNNtppzlt3tXRCUuqaIENj6n5u665z+yA
Date:   Wed, 1 Feb 2023 09:09:00 +0000
Message-ID: <351fc4241ff072a76bb5a522b974b8843a4c8bea.camel@intel.com>
References: <2133431.irdbgypaU6@kreacher>
In-Reply-To: <2133431.irdbgypaU6@kreacher>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|PH0PR11MB5032:EE_
x-ms-office365-filtering-correlation-id: 7f65c0c1-75f8-4513-d646-08db0433f51a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DcIJG6Fjz7cVR8W1BPNyFCSwEwtwfagA+n1mmS0ejV4kx5HTFHHPP6ZN7Knog/oIkKiQJTj33m+ynn2XaqsI9jIA8P/FfCpRpAUwcPzKTXVNyIqug6AyFbpnkFHnIg0VFtFZjSA0b+AuyhTY46a1RBuNqhUDJVPuzt+PBtSPYagdX4PQ9s5h47L7FmKZvQC7eETRbLKsd8WK6tmuW+s9k6i6zionaUhgooCyCjXq0mjEMtJYd4apRtI1UbY0xzgs6zhMl25ivQEdjgaeHuh1B9yK1Zdd8EdZDfK7hvO32PizsDymCaMnJRNwAbdPyYhxWcN5bWThKgeA4ZgiOyXXE24eabWGbow3cpgr8TmfWMTZskAr2Y0KlLTvbEWIllNgIv9IrLP65VA7yut8XatQ63CO7/om3AmTx24DMs/mcjioqZg7+gnvBN+fQ+1KrA7kFIK62GKdFSVnRfWDbHUMn+GGuRN1bZFDxxNeqJnukJtKnfyw41oZtzti3mDLwNhUniwOIm8/S1Drub4LPmdYpwIiEJMNUa/sc6vEooPiHVCrRbVvMlIr/J0rRD4XLQE/FEhK+1MnBgh85SfvMNoOqDxbrcOP3AT9CZ5Mr3O2wzuYDLf1nZeeZSulBsB37bE4RHSRBUu0UdVzWsPS8pd7Tg+k8udkMKR6+UdNmcdAVkGgt/xCLnoSqrzayMO+nrn7apk6SUXXrxIq3weWonVGnumAqSb9zj84AZyDC35UU4Y+CrZEyyRmkEMf1M8AC1q3uiWVcPOyMXvypSI5frQtpQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(346002)(39860400002)(136003)(376002)(366004)(451199018)(186003)(2616005)(26005)(6512007)(6506007)(36756003)(38100700002)(38070700005)(122000001)(86362001)(478600001)(966005)(71200400001)(6486002)(110136005)(54906003)(5660300002)(316002)(4744005)(8676002)(91956017)(76116006)(4326008)(82960400001)(41300700001)(2906002)(8936002)(66556008)(66476007)(64756008)(66446008)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z2dIVkZQWXA5ZTgreW5DZG5yTjZ5QTBnckRZYzhzd2pmV1ZVTnMxSUtKelkw?=
 =?utf-8?B?VnljbEI2VFhSVklQWG5rMkNrNnhoU0FlWm4xcFFQMUlCZzE5RUJ6d21HTU04?=
 =?utf-8?B?ZDdaZmpleDZiL2FPV1QvOTcwR2tPNXdNQkZkMEQ5MFlDM3hDYmtZYXdwOE5R?=
 =?utf-8?B?aVFoM3VueC93WWNWUEs2cmQ1UTlpYnA3NkF3Q0JLbFZCNHoveDVKNUhHYzB3?=
 =?utf-8?B?c1Q5RzJ0ajNSNHBodjJuRU5ENlZ2THkvUTgvbEtyQy9kczQrTVh2UlFPRHpK?=
 =?utf-8?B?YnVCMXgxZWhwZmFBNy9jbCs5WllMWGlVczRwOFJPNG1SVTVtWXlxOGd2VFZO?=
 =?utf-8?B?VWE0SVczUXhpcTBBblBIZFBPTzVnR1lqQXd5UlNBa05aeHk0ZlprNnRLbDlo?=
 =?utf-8?B?bk5JL1Btb1M4cmgvdnFJaXZNLzNsaHB1alFEZ3FiT3d5WTFoUHlXOTYwR0xz?=
 =?utf-8?B?Y2k3eStocGhOQmk3cVJWaDBLYUJqV2ZFT1daV2ZmdzNTNU5relFzWXFaOHJm?=
 =?utf-8?B?a3FzUWtqcUZGVUV6cXpIMGNaRVdVWGxFS3pQM3IyUWZjTlR2OG04b3ZGY0ZT?=
 =?utf-8?B?ZlptVkxJUzBxZjhnR3NqOXExeFNnSGhvc0Fzb1NLVFp0ZDdtNk1CV1dORTZw?=
 =?utf-8?B?cHkzdVJqMSs0c3FoSkpzV3ozMS9mUEd6dDRYRCt6bTQvc1VvMUp3V0xGSnNq?=
 =?utf-8?B?VnZxVyt1b0MwaWdyZEp0cFFmMkFvRFFWM0JNSXM4ZG42VFlCbjNtSGxQUnZB?=
 =?utf-8?B?U09aZjA0OTV6NTNrcm9tRk1DUDc5WTY3RUZnZThGbWpYZ1NFRUkvSGtaMlNi?=
 =?utf-8?B?Ni80TnFQYXFvdlBhanUrTnBmYzFmOHdFbTRkRmFzTTBOcVRjNmRCUDZISVNW?=
 =?utf-8?B?eXNVU2Q5ZzhPRFdnbUxBYkx4QUhTa2E3SjdEaWFPVDkvMm8vM2VVeVBKRDhj?=
 =?utf-8?B?YWI0UnlqTXdic2hIRW1uOHdaM1AzQUdhb0FYT2lDWTZFVWl0Wnd0QlJYWXRz?=
 =?utf-8?B?M1ZhTzA0SEVUVHY0d2luRDFIcjg1OXNKWkdWcWxUVVQ4R3gzdGZxcFhtK3Ru?=
 =?utf-8?B?enFkUllveTJiVGVEK3JIWGlHdU1LVC8zWTdXUlVPR2NVdUNBZWd4QVd5RUxT?=
 =?utf-8?B?L2E3dTF2YldYcnQ2WXlFZU52Z2JaVXFMbHZERG1Oc2drOGw2YnYySHF0cDE0?=
 =?utf-8?B?aFJnVmNxQlJLem53Lzh5MUc3TzAwSFMwT096U2VtcWtLSE5FK0ZXNjJBM2ZK?=
 =?utf-8?B?UWNhTDVLOFA0Qk5qWDk2V3g4LzExTDgzRWlsYTJ6Um5oWGhwWFAxcklZdUk0?=
 =?utf-8?B?ajN2RzBpS3J6V0JTN0hBaGNMQWJPWnRsNnoyVS9lYmNMRjYwd0QzNVlRTmhZ?=
 =?utf-8?B?L0l6QStHdzEvUC9xSTh5M09NVGx5TEE2aEVyZHBCRktVTmwwOWdTQ3orcjY4?=
 =?utf-8?B?YlBSeWFWRXZuWmErUHV2WC9aUFRvWE8xMzFoWGhlQnZQbndMLzErZ0hIVVVG?=
 =?utf-8?B?d3V6bGxJQTdTYVlTVGFnUHJvbC90NHJGWnd5b3VZUUNJdm5JM3VYdXYwb3p1?=
 =?utf-8?B?QndaZFFld09uNFBlNnFsWFJla0VLR0tSemdua0JoZEJ6TVlRTklJK2NqZ2ww?=
 =?utf-8?B?Zm1RREcrc3NoSHpEa0NYMmJGODl2WnVidUFXazhLMFhPeUF1QmRaaHAzMmlW?=
 =?utf-8?B?MGZCbForN3hVUlhqbGorNEE4dXljZFc1ckg0Smx6clk0QTQwdDFjcVpvZjFu?=
 =?utf-8?B?R0J4QkNFeEk0RkJxWkVXUGtObmFKKzlBRkgwQUloZG5Bc1pML1FVMkpvVmVz?=
 =?utf-8?B?ZmFvSk9zUGJoVS80WnF6Y0tMbHhOb2JEZitmWlFKTzJWZlk3bDU5WDlCNWQx?=
 =?utf-8?B?d1Z6Z0ZQbzlQd2lsSTg1RnEvbERFYjQ1U2Vsc1Q0enJkM2RQNXYwMnh0a0hT?=
 =?utf-8?B?L0xxVE9oOTk2bHlGcjRRc2wreHBDTHFjSm55cEI4RXc1R1I0T0ZkTW9jUlND?=
 =?utf-8?B?UjVIbm1xMkhpT1c0c0E4ME5FSmtJTkhMWjBTdWNXN0NIQlVYMmwrMmNlVkNR?=
 =?utf-8?B?L2pjSXlLSnhwREZVUHZKTWdnKzR3bkIrdHQ3VmorTmo5MGZSZzlmOXZGNEJF?=
 =?utf-8?B?Q29lSHhQZmFVaXJ2MjF5NW4rN25UbE1ac1VMNGpoSVlnekNuaE52QW9NYzEw?=
 =?utf-8?B?UUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <06D2A8BA94FD954A9C632BB308896400@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f65c0c1-75f8-4513-d646-08db0433f51a
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2023 09:09:00.4920
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AiBCRJFoduFAKMFTRuxv58lBQLVYo+mOujqR/vLmAi+WLPQIsFY/cLcByuFCztNKD2cYfIVOWvgrc+tdHg6SXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5032
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTAxLTMwIGF0IDE5OjM3ICswMTAwLCBSYWZhZWwgSi4gV3lzb2NraSB3cm90
ZToNCj4gSGkgQWxsLA0KPiANCj4gVGhpcyBpcyBhIG5ldyB2ZXJzaW9uIG9mDQo+IA0KPiBodHRw
czovL2xvcmUua2VybmVsLm9yZy9saW51eC1wbS8xMjE1OTIyOC5POW83NlpkdlFDQGtyZWFjaGVy
Lw0KPiANCj4gd2l0aG91dCBhIGZldyBwYXRjaGVzIHRoYXQgaGF2ZSBiZWVuIGZvbGRlZCBpbnRv
IG90aGVyIGNoYW5nZXMgaW4gdGhlDQo+IG1lYW50aW1lDQo+IGFuZCBvbmUgZXh0cmEgcGF0Y2gu
DQo+IA0KPiBQbGVhc2UgcmVmZXIgdG8gdGhlIGluZGl2aWR1YWwgcGF0Y2ggY2hhbmdlbG9ncyBm
b3IgZGV0YWlscy4NCj4gDQo+IFRoaXMgc2VyaWVzIGlzIGFwcGxpY2FibGUgb24gdG9wIG9mDQo+
IA0KPiBodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvbGludXgtcG0vcGF0Y2gv
NTY0MTI3OS5EdnVZaE14TG9UQGtyZWFjaGVyLw0KPiANCj4gd2hpY2ggaW4gdHVybiBhcHBsaWVz
IG9uIHRvcCBvZiB0aGUgY3VycmVudCB0aGVybWFsIGJyYW5jaCBpbiBsaW51eC0NCj4gcG0uZ2l0
LA0KPiB0aGF0IGlzIGFsc28gcHJlc2VudCBpbiB0aGUgbGludXgtbmV4dCBicmFuY2ggaW4gbGlu
dXgtcG0uZ2l0Lg0KPiANCj4gVGhhbmtzIQ0KPiANCj4gDQpUZXN0ZWQgb24gb25lIEtCTC1SIHBs
YXRmb3JtLCBldmVyeXRoaW5nIHdvcmtzIGZpbmUuDQoNClRlc3RlZC1ieTogWmhhbmcgUnVpIDxy
dWkuemhhbmdAaW50ZWwuY29tPg0KUmV2aWV3ZWQtYnk6IFpoYW5nIFJ1aSA8cnVpLnpoYW5nQGlu
dGVsLmNvbT4NCg0KdGhhbmtzLA0KcnVpDQoNCj4gDQo=
