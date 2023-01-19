Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 193AB674B4A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 05:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbjATEuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 23:50:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbjATEt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 23:49:59 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56EC6D88D2;
        Thu, 19 Jan 2023 20:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674189824; x=1705725824;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=YaT1K6lnFmz4UK0X0miIKfEfFDxaJ2q3TF6D/iAhPKg=;
  b=hjdxXAjusNgL/qwXmV3OM7OyJiRD/RVuY8dxpPYyilmWXgVG0MumkmN1
   AGY6UWe4WJ4IXKiuB0g5ch1XggUyYfxREQEg1squt1dfg5GkD8Se1QQXN
   n8djWLhq+8KNcgmV4oE+3/Rg5aOmG9zL1tl1bRQKBbGfthON1hlDN0mZc
   cdmWS20cHTmrpVN6LvHvH6hhZRtqYOEsorQ2OqrAptFbf22WklGXS+QnV
   t2fzxcGezpFm3hrAR8sB0GJIR1UozKp3ygX73BSaZjmY9rDp34w104FJy
   IGEGs7GTHDUiMNa7ZMT7TWmkVCG7PlyeqxOcgT9YATkz00iYCc27WgsBp
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="308776905"
X-IronPort-AV: E=Sophos;i="5.97,228,1669104000"; 
   d="scan'208";a="308776905"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 23:41:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="802522206"
X-IronPort-AV: E=Sophos;i="5.97,228,1669104000"; 
   d="scan'208";a="802522206"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga001.fm.intel.com with ESMTP; 18 Jan 2023 23:41:29 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 18 Jan 2023 23:41:28 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 18 Jan 2023 23:41:28 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 18 Jan 2023 23:41:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mJcxn6149pKHS6+4GUS2BWgx3RaceV7ebi1dp65bWa5jmv+NPHzui14qs1i2wZLLaVbZ3ovLrnGO5LjU4tCNPmtIAdklkpdiAsbsIRfy/sLF8WU0oanGHvmuZ3FFQjct7fwRz0hIH59jNE4esopKpu7BM/QCoelyAch9enf2d/B2nmu5ruj4zgXHchjJ5ci3f/AAcHCHLwFwSMWegSeL7RoJo5F4AiJV3ej/vtTVpdPM68ggcT+dxRjehRt1L5MhnPLoF+TOyGGg75i9+zX2GOqEWmMU91ypq31Ikpx+ClyqFSVr8dmtAwYDHH3/x8bRq+tae6/NKo2ZFNj19XeE/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YaT1K6lnFmz4UK0X0miIKfEfFDxaJ2q3TF6D/iAhPKg=;
 b=XU9JtBcNhyliTEPeYwwM5CyyH+WJ5Z30bsrsgBv7V3/VOhgwr7EGc1U5NSr4wca7vQyVzEfYoPOutf9F2gwbUsvmZlXrb7V7HjoeBzsa0Q85ALSRQsFmncuelurqXVmY8dwGcpx6bChChfIx9t9GXvyvuAR8pwuxDn0apwMk3gMyFqmO8QGuWXEAbmsmu97RYobEHV3VEInQafDR29XuaXLNRoNUjtAc5UPmsJKS4qiIAvuUPHVTe+3zt2COzFSxdIQ9J5xaP9BNHgk21+IBqmP1tfspR0vaT+W4fGF5F/8//eLGPo9E0iObaZYgawu5yhKiyhdh3UyzsGl3d8NAjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by PH7PR11MB5943.namprd11.prod.outlook.com (2603:10b6:510:13f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.24; Thu, 19 Jan
 2023 07:41:26 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::e30c:74f4:5052:6fd2]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::e30c:74f4:5052:6fd2%5]) with mapi id 15.20.5986.023; Thu, 19 Jan 2023
 07:41:26 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "rafael@kernel.org" <rafael@kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "amitk@kernel.org" <amitk@kernel.org>
Subject: Re: [PATCH 3/5] thermal/core: Remove unneeded mutex_destroy()
Thread-Topic: [PATCH 3/5] thermal/core: Remove unneeded mutex_destroy()
Thread-Index: AQHZK4F2zxpcXOgVoEO8JnggFxWh3a6lW9qA
Date:   Thu, 19 Jan 2023 07:41:26 +0000
Message-ID: <92a6e8494b92f0bb8cb36c98d2237ee3d347c358.camel@intel.com>
References: <20230118211123.111493-1-daniel.lezcano@linaro.org>
         <20230118211123.111493-3-daniel.lezcano@linaro.org>
In-Reply-To: <20230118211123.111493-3-daniel.lezcano@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|PH7PR11MB5943:EE_
x-ms-office365-filtering-correlation-id: bf83e361-241b-4820-9d4c-08daf9f09226
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q+rkr0NYiz31RQBEnzaKY4Yx0S8xgEVNNyhuMZzmuYXez0T/wunufMV3vWGnG0cUPhdHnh3T/2jccYpayHlu46blQf5vERvBaDfkE3IhzU1Wtmkl5uKW6IRdEOInSR986xsIcSbs5dCGyngK3MrR65Fdf58JHC3eqMOdUtI3eKjl1GHEZffow/+GVglKYvVBnkzpaJ5NfDXCrB2IZ0xr2PbNvb1k1hXMn+DTW6wsBgAa7MV0L4CkEdKJaB7W4LlHIQs5+wuitSlFKa3rPVQbfff0Bd/HoZj36yJ9atM9/LlausV9JPEcOgVoCN4Kc6V54vPcJBZdq71Ic/Dv3vxG8drlel8fA/REQNAkR9aBEbed0BRfrQQwaRn/wmBxwdjuHG2n5w7ENVTQurwazSkpD4NvEowzKRZLZWegzCFn7ql03uG/uIfYLT8Qdh1OMzjSG9XV4Kyl0NRxZglsMjZct16hrmj/FmLR2l073Pf6yNYb1/HAAX5zgOvCvQbkPC6FHAMcMkboD28uSoxUABH0m+M8obZJWZSadMAUlImCCHw7QHl6IoeuwHUJkrfzZvDxsQ72lePNXOXTt1nqjExFBudUGpFbJpZYVkWRz1JL4gd1kKfCTsZW3xVcr/oSr008Zpj/VGbf2WzunA0hM31JYtk6iZ44pxddilhC9Oxx6kL5t410NUmdQak+veRu2uku5RD+JlbcCHeKC2pfi7qcew==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(39860400002)(376002)(346002)(396003)(451199015)(36756003)(86362001)(122000001)(76116006)(66476007)(2906002)(66946007)(91956017)(66556008)(8936002)(5660300002)(82960400001)(38100700002)(316002)(54906003)(110136005)(71200400001)(6486002)(6506007)(38070700005)(478600001)(66446008)(8676002)(64756008)(4326008)(41300700001)(186003)(83380400001)(26005)(6512007)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RlFRRXZQMUZ3MnNaZEtxUjVFMHA0QjZHU0NWekd2UG13d00vWUoyT2k3QllK?=
 =?utf-8?B?T3g5a3YvZlloV0llSmNSSWIzMDNnckN4NFVsU3VWMFZqWUhoQnh2eG9pT0do?=
 =?utf-8?B?S0ZpcEFxNWhsTFNSWVNEVkZ5OWF3bktjbUpYcjd4SUJDUmdoUEh1UmpLRm5p?=
 =?utf-8?B?Q0ZtNFRxSVRYaTlMQVhoQisvaEMyVG1pTkVuSFJWUnd1OEs4SG0wWFl6NXdy?=
 =?utf-8?B?QjBQandRVTlwU3pyNUc1TG1Ld052Y1Fyd1ZxL0ZUZkhNcGkxaWtZVTI1dEhM?=
 =?utf-8?B?NjltRUxGaDFsOHdSMDZpOUhEUkdPMTc1bkpOQk5KZHRPU0hPT3J0MHBhNlJs?=
 =?utf-8?B?OUdVVFVSU1ROTGRqa3ZyNlJWM3R5SmtWNEo4cTN3SzIrS25xNUtVS0lKdkUv?=
 =?utf-8?B?aXQ2NmhvTTQ3RGFhNGE2TjA2UUZWZTdReGZyLzVDWk01REdjcWRJNHV2eDEr?=
 =?utf-8?B?KzVqTHZhcUtNREQzMmwyOXMwK2NHZmRlYWx6UkhoNVRYK0QvZDFMeUJjcFFQ?=
 =?utf-8?B?K1phODhKbUw2RWpFbzdmbENTY2hwOWVUaVFiMXdYVStBc3hTckswanJ4aXVG?=
 =?utf-8?B?czJTMkdtOWlGWnp3S2xsQXY4Vi9RMFk0ZUlRbkFmOVkwb05mYmR4blN4RjAy?=
 =?utf-8?B?WmhXSGpjRFoyRWZWazRNRXlNbU9zT1NJSjYzNVdDVzZsZ0U5dGR6OGpRcHlQ?=
 =?utf-8?B?ZitRYUtrZi80dW1wMEwrVmo0NXNTb3ZxWlAwK042eSt4SGloY3QvSWd6dkpL?=
 =?utf-8?B?V0g0dk5uM1E5L2VxRkFDN1Ntc20wZm5hNmNiVmZkaXpjczlZeXo1TGhPUjR3?=
 =?utf-8?B?UVJzVlUxMlZLbzkyQk9FTFR1OTVCbWV3d1loVlpKbzVMU1FMYmJzazJaVW1Z?=
 =?utf-8?B?UXRhMHRoZlpLSVRRQkRBQ3Nla3lXVitPeXFWVmxoamdBVzZNMGdpWUJKU1ZE?=
 =?utf-8?B?OGNJcHFxRXRMdXROZjlVZGxvYklVbVF0RmF3UEV3dmxKNk15YVl2d1FDa2My?=
 =?utf-8?B?bXEyN240OUh4dWhueXovTmRWMGw3OEh5Y2FmTXIrZnREaHlsYmZxYzRkL3Fl?=
 =?utf-8?B?by9CaEpPY3FRSjE4ZEZUY3JFMXlBVzRVQ0VnSnJ6V1F1cnpqbkNVZGhycHhv?=
 =?utf-8?B?VDI4VmJ3dFE2WTkvSDV1S2szYkZsdHdkZzNLMjlEN0lMdVErTElBQlJLY2th?=
 =?utf-8?B?M05iOC91aU10aVEwejFwcllzU2ljRmVVc1laaTU5L1kwblRXQnpRbUtEcFpF?=
 =?utf-8?B?VnVNYVFKMjdmdC9CMGdJZ1NVNUkvMDF4NGhWZWwvVEF1K1Q3OHU3c3A5ck15?=
 =?utf-8?B?QU1WWFcvT1VybHVRTndhRUhqcWg4ZzNreEYydVBNQi9FWkF4Ti9yd2x0Q1pM?=
 =?utf-8?B?OWFLVHdYd1FtSklTamJjVmF3L2tLSlB5VFE5YXUycTd4K0cydGxab3FDeHNS?=
 =?utf-8?B?TUFkZC9CUzZ4SEc2SmVlaVQvaXFlWTI3cGozbWRrSWxGOE1BZ1RTNVYveHVs?=
 =?utf-8?B?bU40MUFvRDY5R25XN0lIeG9pUHdmZDJ6Vk1uSkNhOEQ5REMyeGhGdHpTTTZ1?=
 =?utf-8?B?a09yb2NKWkw2bzFjcmViNm01V2xvMitsRWVDaDMzV2JBSEZTZFY4ZnNNY2RN?=
 =?utf-8?B?dlNvMzJKK1FJbUFwcXB3d3B6YmFhMFI3aDkwakhRWDVwczJReXI0d1ZNWnNI?=
 =?utf-8?B?ZXdNVjNLbFlCWFdudzVxbDMzVW5Za0w1MHFXZFB3ZHAwR0RKSjVyZURWb1ly?=
 =?utf-8?B?TnZxbHo1ZU9yUVlCRFpPSEMzelVQbXBWTHFuUFBBaUR6ekVhMG9CNEVKajh5?=
 =?utf-8?B?ODZMckZsSUNqanUrdG9Yd3VsVW9NYi82Z09XaFg3aG91UGtMTlJaM3o1M1VY?=
 =?utf-8?B?UVEvMi9vTXRGbWIwWmw2TDMrWldwakREaklrMS91T3FVOWRZSlZ3T1FDWWU2?=
 =?utf-8?B?TEV1NGRHcG02WWtrOWJsK3Q3d29NMEZOT0NhUzhpVTFyOE56NWo4czBnc2VD?=
 =?utf-8?B?NkdOV0VJU05HT3JwM2UxTDVQc2RnVUdYOU1YNFdRaGVVdjZBeVVDTzY4ejZ0?=
 =?utf-8?B?cFE2UFpoUUMyc1labDUyTENxdUdnUWxLQ3YwOWUyblc5NHhuR1pNTjhPUFI0?=
 =?utf-8?B?UlQreTkwOVhMQW5COGhxZXVCTGVuWWViOVV4RVFaaFF5Y1BIcVdBU1BLTmI2?=
 =?utf-8?B?MWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CD94F72E63FF2442885274D2C19876BC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf83e361-241b-4820-9d4c-08daf9f09226
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2023 07:41:26.5193
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CrsCtHJWdlO6PsjfUY5KGCbKz93p//QxaYFIMqq079rGNd+sSyWt1XG6+dooSP992I1DNwgF8fSjDOX9rha10Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5943
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTAxLTE4IGF0IDIyOjExICswMTAwLCBEYW5pZWwgTGV6Y2FubyB3cm90ZToN
Cj4gSWYgdGhlIHRoZXJtYWwgZnJhbWV3b3JrIGZhaWxzIHRvIGluaXRpYWxpemUsIHRoZSBtdXRl
eCBjYW4gYmUgdXNlZA0KPiBieQ0KPiB0aGUgZGlmZmVyZW50IGZ1bmN0aW9ucyByZWdpc3Rlcmlu
ZyBhIHRoZXJtYWwgem9uZSBhbnl3YXkuDQoNCkhtbSwgZXZlbiB3aXRoIG5vIGdvdmVybm9ycyBh
bmQgdW5yZWdpc3RlcmVkIHRoZXJtYWwgc3lzZnMgY2xhc3M/DQoNCklNTywgdGhlcm1hbCBBUElz
IGZvciByZWdpc3RlcmluZyBhIHRoZXJtYWxfem9uZS9jb29saW5nX2RldmljZSBzaG91bGQNCnlp
ZWxkIGVhcmx5IGlmIHRoZXJtYWxfaW5pdCBmYWlscy4NCkZvciBvdGhlciBBUElzIHRoYXQgcmVs
aWVzIG9uIGEgdmFsaWQNCnRoZXJtYWxfem9uZV9kZXZpY2UvdGhlcm1hbF9jb29saW5nX2Rldmlj
ZSBwb2ludGVyLCBub3RoaW5nIG5lZWRzIHRvDQpiZSBjaGFuZ2VkLg0KDQp3aGF0IGRvIHlvdSB0
aGluaz8NCg0KdGhhbmtzLA0KcnVpDQoNCg0KPiAgV2Ugc2hvdWxkDQo+IG5vdCBkZXN0cm95IHRo
ZSBtdXRleGVzIGFzIG90aGVyIGNvbXBvbmVudHMgbWF5IHVzZSB0aGVtLg0KPiANCj4gU2lnbmVk
LW9mZi1ieTogRGFuaWVsIExlemNhbm8gPGRhbmllbC5sZXpjYW5vQGxpbmFyby5vcmc+DQo+IC0t
LQ0KPiAgZHJpdmVycy90aGVybWFsL3RoZXJtYWxfY29yZS5jIHwgNiArKy0tLS0NCj4gIDEgZmls
ZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy90aGVybWFsL3RoZXJtYWxfY29yZS5jDQo+IGIvZHJpdmVycy90aGVybWFs
L3RoZXJtYWxfY29yZS5jDQo+IGluZGV4IGZhZDBjNGEwN2QxNi4uZWE3OGM5MzI3N2JlIDEwMDY0
NA0KPiAtLS0gYS9kcml2ZXJzL3RoZXJtYWwvdGhlcm1hbF9jb3JlLmMNCj4gKysrIGIvZHJpdmVy
cy90aGVybWFsL3RoZXJtYWxfY29yZS5jDQo+IEBAIC0xNjAyLDcgKzE2MDIsNyBAQCBzdGF0aWMg
aW50IF9faW5pdCB0aGVybWFsX2luaXQodm9pZCkNCj4gIA0KPiAgCXJlc3VsdCA9IHRoZXJtYWxf
bmV0bGlua19pbml0KCk7DQo+ICAJaWYgKHJlc3VsdCkNCj4gLQkJZ290byBlcnJvcjsNCj4gKwkJ
cmV0dXJuIHJlc3VsdDsNCj4gIA0KPiAgCXJlc3VsdCA9IHRoZXJtYWxfcmVnaXN0ZXJfZ292ZXJu
b3JzKCk7DQo+ICAJaWYgKHJlc3VsdCkNCj4gQEAgLTE2MjMsOSArMTYyMyw3IEBAIHN0YXRpYyBp
bnQgX19pbml0IHRoZXJtYWxfaW5pdCh2b2lkKQ0KPiAgCXRoZXJtYWxfdW5yZWdpc3Rlcl9nb3Zl
cm5vcnMoKTsNCj4gIHVucmVnaXN0ZXJfbmV0bGluazoNCj4gIAl0aGVybWFsX25ldGxpbmtfZXhp
dCgpOw0KPiAtZXJyb3I6DQo+IC0JbXV0ZXhfZGVzdHJveSgmdGhlcm1hbF9saXN0X2xvY2spOw0K
PiAtCW11dGV4X2Rlc3Ryb3koJnRoZXJtYWxfZ292ZXJub3JfbG9jayk7DQo+ICsNCj4gIAlyZXR1
cm4gcmVzdWx0Ow0KPiAgfQ0KPiAgcG9zdGNvcmVfaW5pdGNhbGwodGhlcm1hbF9pbml0KTsNCg==
