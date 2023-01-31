Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4B1682B4C
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 12:18:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbjAaLSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 06:18:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbjAaLSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 06:18:04 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B3E20D32;
        Tue, 31 Jan 2023 03:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675163879; x=1706699879;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=KWvtiYditwMKuQcFJk3GUzkEokWHA7CMADc0pSsWMQ8=;
  b=gU9Vy7h3YSKFlwyczwnreOZjCwlUwD0TY9XEzyLvFOjQQcscZNQyrELW
   qZ48w8X3SN1ajiYv/egELTUrnuyeTRy57hNb56wzwtujs6tXwC6k8J3O8
   kFlN2GiEsVhvPACgKN4xIUMfT+JFQhHTAENHxwZv24/JAfi+5z/PmJ6/I
   zWcDW2yVRjRQYlmL1Toii3ao+Btb9y+8GT4380s+GWyBUNkscUVH+rQz4
   QdDysFD62Zh1a9D+VqPRvDT7EoqQ2FIzMRqHsCyOIr+8nPeFUJTrGNEkN
   eAg4eLUnChsQ1a+DwjmcPaOqwQyHtqkxtMg3L2cbt6nOnxvL3g4EnSzH6
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="392364019"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="392364019"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 03:17:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="696780011"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="696780011"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP; 31 Jan 2023 03:17:58 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 31 Jan 2023 03:17:57 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 31 Jan 2023 03:17:57 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 31 Jan 2023 03:17:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jqcJIM6xsYeo/I8vUyAQqO/O6NoO4yOPEfn9pGWvYLRK8zQxM/BEB1Jt86ma0ZndhP5/YkmpjQMXSD9shLrH8IIpk3SlpSKpUT+cCG6vSN0IFKyisKpINsln1Z7Q/sFIMC3QCWXKmisaCCIoUqycDlSNSNyceu4G2x3Gcjuj6/r47S+0tOyErQR/fgisqRB6Pfqx2V+cXLOtxye6Lt0krpBlZYN1t/VqwZc+WgOZfILvttKTr/PNLdirc4r/bSIobYzC8TxGh2qMXBU6o/w8zCIbbLxvqj0RkuOmwcgqistJVISb/xK5+ukBreegvNACbKQVGQ165kgirlIeBEoEKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KWvtiYditwMKuQcFJk3GUzkEokWHA7CMADc0pSsWMQ8=;
 b=hWMPbI9GJrKOwQW/lEidKL6dN6p4F9UYpL6ipn6h/X9YxwD7fYD5n6mQSUli+aCErA/Mupc4aaBma9iCw3ggoKqKlngiRZnjXpnyQgLhMRHVUdV57KWc/YjGbhq8qHPPXkobPYu80gQpQi0Q86AWTXKGeD9qNssXFibp9AIimKBMkhKojVpJyPVTyufMdLsWr9s1FlJpMMc2C5k+4+Ev8czWILApF6LNLxFSrMuCD59FjJUFtSkrAtARBUjmY5AmaALrrwgK+ftM5a/3tav0bEDAw/iqzZw//0Y3ytfpyWIbcv4wge3DzRFthMl3CLPrKAlg4FeK8hXBbd78jI5KVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by CH3PR11MB7844.namprd11.prod.outlook.com (2603:10b6:610:12a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Tue, 31 Jan
 2023 11:17:55 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::e30c:74f4:5052:6fd2]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::e30c:74f4:5052:6fd2%5]) with mapi id 15.20.6043.038; Tue, 31 Jan 2023
 11:17:55 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>
CC:     "srinivas.pandruvada@linux.intel.com" 
        <srinivas.pandruvada@linux.intel.com>,
        "david.e.box@linux.intel.com" <david.e.box@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v1 7/8] thermal: intel: intel_pch: Rename board ID symbols
Thread-Topic: [PATCH v1 7/8] thermal: intel: intel_pch: Rename board ID
 symbols
Thread-Index: AQHZNN4c3lVe7s9hAkGTg+wdD2YO+664YZGA
Date:   Tue, 31 Jan 2023 11:17:55 +0000
Message-ID: <03b213dd351605d34f3d2ebc29fc3795cd2a58d2.camel@intel.com>
References: <1751684.VLH7GnMWUR@kreacher> <2144306.Icojqenx9y@kreacher>
In-Reply-To: <2144306.Icojqenx9y@kreacher>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|CH3PR11MB7844:EE_
x-ms-office365-filtering-correlation-id: 5fcbb6e5-5102-4c00-c6a5-08db037ccceb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Zrux+6aPipNEw35xzobPsnnweTGBklk8zNCwnmafTxwQolIp2KKWVY4mx7tX7QtqSHBR+3X6A/R9UiIKtloIfGA8V069aHL2FBhQccI77I1UBodw8VlkSYRtqRklsyoxQijRtco5pXQ/96DWB7tNkblXWw9QNcrbtntamTvtevWmGSmzfnVpU0clMVHlPh/LGSfuDBemRR+NsLPIK48ztSXNyHoDYeiLiCopRuxuxbtJOJLxOLysK+UkQvcTthq/fHfcpWnDOET512M9oalQx/tMc4ZDNbdCMW2l1LXBfV/9VC/IXA4njDF5SdbtT5JsqvVqa5gqZBITOAzY0GXh6ffYxR7YIAKVE4qtVdRWhFZD2WhS3KVzTnu9mE624l+9hrarcvA3uq1cmLPIyDi8ukvikFXheqUcggGhE2pA4tb71X+fyqNtIuebbNCE8s0GBskdjEbnwmHQ6Dl/f8MyyYvJjHlkpFX9wF/FDdpXpCzzDignKY70H/bV4GnVSRfBbj+ioxvTDpaJes/9VVQZyVkL9sTb2GyWFLzzBpDe2osUEf62Hbo3zD9+J2zM0k7S+KgHJTP4NM6WbhAkJnOwzlLzxtGHkSIoRhAsnlfFztysVCUp0PEUb0K6yyCgX062rVr+DSOBUDK97Zgiv/iIA0QMHKe/aMQdrEiPiZ/FQTcHsCyaYkLmTEUPiDmh6EiLB9AMWcE5n2D4hbnoVMa4wql+2Gtm5bem/csoByR4WmAWf7UhaS5S89MrI1yOw9h3f+1ovd8g4AEgXbNM55fhtg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(39860400002)(136003)(366004)(396003)(376002)(451199018)(2906002)(36756003)(83380400001)(316002)(54906003)(26005)(110136005)(186003)(6512007)(122000001)(966005)(2616005)(71200400001)(6506007)(66446008)(76116006)(64756008)(66556008)(66476007)(86362001)(91956017)(66946007)(8936002)(478600001)(5660300002)(38070700005)(6486002)(4326008)(41300700001)(82960400001)(38100700002)(8676002)(84970400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OWIyUWxiOW94Q05RZkxlQUtMYVNjc0Ivd2E3clQrNU1hMnJ1UitPL3BxcFp0?=
 =?utf-8?B?REpkdU0xcWJjcjlFUHF3aERobC9YR1NvamRkL2tFUnZmSmVwc0tISFRDa0NG?=
 =?utf-8?B?MnhWQlhkOTU2ekt1VG80N05HS3BaYnhYTGI0c3FZS2I1cjFEV25ST0VmeDlY?=
 =?utf-8?B?eTcvVmF0U3R0ejI0OVh4OHlmbks4Q0hGMzlpNUsyL1VFbGtKVFV4eTU5dHJS?=
 =?utf-8?B?SFl6UUoyK0lWS1BudEVJb1lLc3pXNmRjWHczWGU1OGMwa3ZxNlA4bkxNYlRv?=
 =?utf-8?B?bEhZNFdPMnlOKzNPWUpxSlR5MVI3RXNvRkdyc3Erd0t1VGxjdUpCeUk2VXJT?=
 =?utf-8?B?QWg3Ykp4TjcyanlqaGwzY1BRbTJZVjFqQmJ2a285WUhJVW9JWVVVTHNFZmRR?=
 =?utf-8?B?elhSejROenVQT1pSbVBJeWJDM1U0czV6blhtNnp6bjZ5MUhKSlhxNDdHaUlM?=
 =?utf-8?B?cmJwN3VMZnNONE84cHMwVE5Gd2JSYmtOcVFrc0orY05EWFhrVnZYVjk3Sk9P?=
 =?utf-8?B?OTA3ZTByU1M3UjZjVHV5M1BzUlZzdjN4VGRGMHJONm1zb2VtdDFBdnZmSWd2?=
 =?utf-8?B?M051SWVuaFRHMFIrQ0lQNWdUbVZPd0ZjSG43cDVaSGk5YWs3YjJlcWdSR3Za?=
 =?utf-8?B?cGg1aGtjNXdnNm43cXJGMG5tZkRRT0RTalNPT25KR2NjODMrblNnYVhRSHlE?=
 =?utf-8?B?OThKek9EVkJ4aXFDSmtkdHRqaVVkcm9HWnV3dVJJVVY2amp4U2RQRzh6S21I?=
 =?utf-8?B?SDBKYXlldTNmSG9ZUzc0S0liaThoS0NVYjJsWDFtZ2ltL290RmtmQzhuRWFV?=
 =?utf-8?B?d2pLc25teTJ5aE9aZkRTRnQ0b3RpZ2NJTjdQMU5WK3V3c290bTRnR3Vyb2Fy?=
 =?utf-8?B?NEh3a1luVlRCbmJPY1RjSGNxcUZLRnJvVFZkclRicU1wV0lOQkZ4Yzczdnlk?=
 =?utf-8?B?SVhaekJrNXJoNzNjcG1Udm5CMjdZVG05bDFjZDdsNkFUbVQ2RS9tVHhHNHE3?=
 =?utf-8?B?UnFvbklLM2Ivb3lFL3A1M3pQMEllRkwzc2l6MlFPUHVUcjQ3YldQVE0wK3hk?=
 =?utf-8?B?RWZ2c1YvcG12bVo5TUxGWjBFemhDMkxORFNxZVp0VU9xN2NrdUJMZk5ZU0xV?=
 =?utf-8?B?aTZudFZJbFRpejZvaEQvVys3RG16V05uSUppWmRnRzZmYVJvT1JRakJtbFpW?=
 =?utf-8?B?UUcxdnc4T2lraks3VGMwR0ZDWXBId2VsRk5JblFDU3VkTkZCekFuY042aWhn?=
 =?utf-8?B?cHV6OGR1MEkveGwzUUhjQWErLzYzcExxRG1PdU1STWtzSmlrUnlpdjg0TmVr?=
 =?utf-8?B?KzJKdTNrcGhYQUNXSGdFY1hEK2FBSXlDbWtPSGQ2Tmc1QURnU1hET2ltTWV2?=
 =?utf-8?B?M0g4Sk5oNGowcmlYTno5cVhFWExyTzhUNS84NFVJbWp1QWJDQW5HWit3UDBw?=
 =?utf-8?B?a0dONTZ0VVAvN3pxaWxRclY4SENyOUc1REpZVkk2SFU0cktHT1lUNCt1KzhX?=
 =?utf-8?B?OHlDeXJ1VUlvbGEyYWJQVTd2Z0hnTkNKQk1xL2VrUkxGejBOck1DVnh1U3dl?=
 =?utf-8?B?aHpZNHRkUVJLekxkeFNleWpzNE5xYStJMHpWQS9TdVZRN05qUE9QbXZhTWU3?=
 =?utf-8?B?K1RUNEhwbktNRU9renVOV29Gc3RvcHhkcTVLcFFhbDlWY0RiSTd1VmNHTlpG?=
 =?utf-8?B?YWNkNFdOWnRHMkpZNlNRNWZTS0hQODZnWmRXTGRiNkN0djIvSVRZN1JJNDY3?=
 =?utf-8?B?QkZhQTVaWkZidC9BWnNvR3Q0eWdxMjQxZG1lN0x1UW1JSFZGOGFYYlBTNkta?=
 =?utf-8?B?THhoZExZTzdDVmVTTGhRSm00cUx6SlBVMTdtMWFUV0JEMGZZNDVSQU5qVUlR?=
 =?utf-8?B?QTZLV0R1dDBQY1hxTWdEZkY5STFtSFJQYVdCMXBab2lJWVZHR05hcno5YUJt?=
 =?utf-8?B?Y2NnYit6aTA0R1Z2eDk5M0d1MlY0ZlFZS1BiUUdmSGxrczVnV05CbUlTQmJW?=
 =?utf-8?B?UFVPeXd6Y0ZtUmpBWkFPSkNseFo2di9CR0tuNUtxVnVaYjdsWWMrRjFJNnNJ?=
 =?utf-8?B?OVZkWVlIT0p5UlBMVzJyZ3d3UXEzcFBQY1VYVkRramltcW5qQjB2cW1BVWdT?=
 =?utf-8?B?TG1yY1JrZmdjaGhldTdNZDN4eDUvSEF0MkxObHJCUlJVZ2hxQlNQMmZUeS9V?=
 =?utf-8?B?RXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DDE8272CE7C98143B9E40E061395788C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fcbb6e5-5102-4c00-c6a5-08db037ccceb
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2023 11:17:55.1264
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oNcobhK8sCKCZVmlOd5CaAnsm9+6AKhAh3RsMCh5YXtMl80exIZrUQnEZuxNq2au7QlRURDe7wYV4Ad1v3QlPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7844
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTAxLTMwIGF0IDIwOjA0ICswMTAwLCBSYWZhZWwgSi4gV3lzb2NraSB3cm90
ZToNCj4gRnJvbTogUmFmYWVsIEouIFd5c29ja2kgPHJhZmFlbC5qLnd5c29ja2lAaW50ZWwuY29t
Pg0KPiANCj4gVXNlIGNhcGl0YWxzIGluIHRoZSBuYW1lcyBvZiB0aGUgYm9hcmQgSUQgc3ltYm9s
cyBhbmQgYWRkIHRoZSBQQ0hfDQo+IHByZWZpeCB0byBlYWNoIG9mIHRoZW0gZm9yIGNvbnNpc3Rl
bmN5Lg0KPiANCj4gQWxzbyByZW5hbWUgdGhlIGJvYXJkX2lkcyBlbnVtIGFjY29yZGluZ2x5Lg0K
PiANCj4gTm8gaW50ZW50aW9uYWwgZnVuY3Rpb25hbCBpbXBhY3QuDQo+IA0KPiBTaWduZWQtb2Zm
LWJ5OiBSYWZhZWwgSi4gV3lzb2NraSA8cmFmYWVsLmoud3lzb2NraUBpbnRlbC5jb20+DQo+IC0t
LQ0KPiAgZHJpdmVycy90aGVybWFsL2ludGVsL2ludGVsX3BjaF90aGVybWFsLmMgfCAgIDU0ICsr
KysrKysrKysrKysrKy0tDQo+IC0tLS0tLS0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAyNyBp
bnNlcnRpb25zKCspLCAyNyBkZWxldGlvbnMoLSkNCj4gDQo+IEluZGV4OiBsaW51eC1wbS9kcml2
ZXJzL3RoZXJtYWwvaW50ZWwvaW50ZWxfcGNoX3RoZXJtYWwuYw0KPiA9PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQo+IC0t
LSBsaW51eC1wbS5vcmlnL2RyaXZlcnMvdGhlcm1hbC9pbnRlbC9pbnRlbF9wY2hfdGhlcm1hbC5j
DQo+ICsrKyBsaW51eC1wbS9kcml2ZXJzL3RoZXJtYWwvaW50ZWwvaW50ZWxfcGNoX3RoZXJtYWwu
Yw0KPiBAQCAtMTM1LDM4ICsxMzUsMzggQEAgc3RhdGljIHN0cnVjdCB0aGVybWFsX3pvbmVfZGV2
aWNlX29wcyB0eg0KPiAgCS5jcml0aWNhbCA9IHBjaF9jcml0aWNhbCwNCj4gIH07DQo+ICANCj4g
LWVudW0gYm9hcmRfaWRzIHsNCj4gLQlib2FyZF9oc3csDQo+IC0JYm9hcmRfd3B0LA0KPiAtCWJv
YXJkX3NrbCwNCj4gLQlib2FyZF9jbmwsDQo+IC0JYm9hcmRfY21sLA0KPiAtCWJvYXJkX2x3YiwN
Cj4gLQlib2FyZF93YmcsDQo+ICtlbnVtIHBjaF9ib2FyZF9pZHMgew0KPiArCVBDSF9CT0FSRF9I
U1cgPSAwLA0KPiArCVBDSF9CT0FSRF9XUFQsDQo+ICsJUENIX0JPQVJEX1NLTCwNCj4gKwlQQ0hf
Qk9BUkRfQ05MLA0KPiArCVBDSF9CT0FSRF9DTUwsDQo+ICsJUENIX0JPQVJEX0xXQiwNCj4gKwlQ
Q0hfQk9BUkRfV0JHLA0KPiAgfTsNCj4gIA0KPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBib2FyZF9p
bmZvIHsNCj4gIAljb25zdCBjaGFyICpuYW1lOw0KPiAgfSBib2FyZF9pbmZvW10gPSB7DQoNCk5v
dyBzdHJ1Y3QgYm9hcmRfaW5mbyBoYXMgIm5hbWUiIGZpZWxkIG9ubHksIHNvIG1heWJlIHdlIGNh
biByZW1vdmUNCnN0cnVjdCBib2FyZF9pbmZvLCBhbmQgdXNlIGEgInN0YXRpYyBjb25zdCBjaGFy
ICoiIGFycmF5IGluc3RlYWQ/DQoNCkJUVywgSSdtIGJ1aWxkaW5nIGEga2VybmVsIHdpdGggdGhp
cyBwYXRjaCBzZXJpZXMgYXMgd2VsbCBhcyANCmh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcv
cHJvamVjdC9saW51eC1wbS9saXN0Lz9zZXJpZXM9NzE3MDg0LA0Kd2lsbCB1cGRhdGUgdGhlIHRl
c3QgcmVzdWx0IGxhdGVyLg0KDQp0aGFua3MsDQpydWkNCg0KDQo+IC0JW2JvYXJkX2hzd10gPSB7
DQo+ICsJW1BDSF9CT0FSRF9IU1ddID0gew0KPiAgCQkubmFtZSA9ICJwY2hfaGFzd2VsbCIsDQo+
ICAJfSwNCj4gLQlbYm9hcmRfd3B0XSA9IHsNCj4gKwlbUENIX0JPQVJEX1dQVF0gPSB7DQo+ICAJ
CS5uYW1lID0gInBjaF93aWxkY2F0X3BvaW50IiwNCj4gIAl9LA0KPiAtCVtib2FyZF9za2xdID0g
ew0KPiArCVtQQ0hfQk9BUkRfU0tMXSA9IHsNCj4gIAkJLm5hbWUgPSAicGNoX3NreWxha2UiLA0K
PiAgCX0sDQo+IC0JW2JvYXJkX2NubF0gPSB7DQo+ICsJW1BDSF9CT0FSRF9DTkxdID0gew0KPiAg
CQkubmFtZSA9ICJwY2hfY2Fubm9ubGFrZSIsDQo+ICAJfSwNCj4gLQlbYm9hcmRfY21sXSA9IHsN
Cj4gKwlbUENIX0JPQVJEX0NNTF0gPSB7DQo+ICAJCS5uYW1lID0gInBjaF9jb21ldGxha2UiLA0K
PiAgCX0sDQo+IC0JW2JvYXJkX2x3Yl0gPSB7DQo+ICsJW1BDSF9CT0FSRF9MV0JdID0gew0KPiAg
CQkubmFtZSA9ICJwY2hfbGV3aXNidXJnIiwNCj4gIAl9LA0KPiAtCVtib2FyZF93YmddID0gew0K
PiArCVtQQ0hfQk9BUkRfV0JHXSA9IHsNCj4gIAkJLm5hbWUgPSAicGNoX3dlbGxzYnVyZyIsDQo+
ICAJfSwNCj4gIH07DQo+IEBAIC0xNzQsNyArMTc0LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBi
b2FyZF9pbmZvIHsNCj4gIHN0YXRpYyBpbnQgaW50ZWxfcGNoX3RoZXJtYWxfcHJvYmUoc3RydWN0
IHBjaV9kZXYgKnBkZXYsDQo+ICAJCQkJICAgY29uc3Qgc3RydWN0IHBjaV9kZXZpY2VfaWQgKmlk
KQ0KPiAgew0KPiAtCWVudW0gYm9hcmRfaWRzIGJvYXJkX2lkID0gaWQtPmRyaXZlcl9kYXRhOw0K
PiArCWVudW0gcGNoX2JvYXJkX2lkcyBib2FyZF9pZCA9IGlkLT5kcml2ZXJfZGF0YTsNCj4gIAlj
b25zdCBzdHJ1Y3QgYm9hcmRfaW5mbyAqYmkgPSAmYm9hcmRfaW5mb1tib2FyZF9pZF07DQo+ICAJ
c3RydWN0IHBjaF90aGVybWFsX2RldmljZSAqcHRkOw0KPiAgCXUxNiB0cmlwX3RlbXA7DQo+IEBA
IC0zNzIsMjcgKzM3MiwyNyBAQCBzdGF0aWMgaW50IGludGVsX3BjaF90aGVybWFsX3Jlc3VtZShz
dHJ1DQo+ICANCj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgcGNpX2RldmljZV9pZCBpbnRlbF9wY2hf
dGhlcm1hbF9pZFtdID0gew0KPiAgCXsgUENJX0RFVklDRShQQ0lfVkVORE9SX0lEX0lOVEVMLCBQ
Q0hfVEhFUk1BTF9ESURfSFNXXzEpLA0KPiAtCQkuZHJpdmVyX2RhdGEgPSBib2FyZF9oc3csIH0s
DQo+ICsJCS5kcml2ZXJfZGF0YSA9IFBDSF9CT0FSRF9IU1csIH0sDQo+ICAJeyBQQ0lfREVWSUNF
KFBDSV9WRU5ET1JfSURfSU5URUwsIFBDSF9USEVSTUFMX0RJRF9IU1dfMiksDQo+IC0JCS5kcml2
ZXJfZGF0YSA9IGJvYXJkX2hzdywgfSwNCj4gKwkJLmRyaXZlcl9kYXRhID0gUENIX0JPQVJEX0hT
VywgfSwNCj4gIAl7IFBDSV9ERVZJQ0UoUENJX1ZFTkRPUl9JRF9JTlRFTCwgUENIX1RIRVJNQUxf
RElEX1dQVCksDQo+IC0JCS5kcml2ZXJfZGF0YSA9IGJvYXJkX3dwdCwgfSwNCj4gKwkJLmRyaXZl
cl9kYXRhID0gUENIX0JPQVJEX1dQVCwgfSwNCj4gIAl7IFBDSV9ERVZJQ0UoUENJX1ZFTkRPUl9J
RF9JTlRFTCwgUENIX1RIRVJNQUxfRElEX1NLTCksDQo+IC0JCS5kcml2ZXJfZGF0YSA9IGJvYXJk
X3NrbCwgfSwNCj4gKwkJLmRyaXZlcl9kYXRhID0gUENIX0JPQVJEX1NLTCwgfSwNCj4gIAl7IFBD
SV9ERVZJQ0UoUENJX1ZFTkRPUl9JRF9JTlRFTCwgUENIX1RIRVJNQUxfRElEX1NLTF9IKSwNCj4g
LQkJLmRyaXZlcl9kYXRhID0gYm9hcmRfc2tsLCB9LA0KPiArCQkuZHJpdmVyX2RhdGEgPSBQQ0hf
Qk9BUkRfU0tMLCB9LA0KPiAgCXsgUENJX0RFVklDRShQQ0lfVkVORE9SX0lEX0lOVEVMLCBQQ0hf
VEhFUk1BTF9ESURfQ05MKSwNCj4gLQkJLmRyaXZlcl9kYXRhID0gYm9hcmRfY25sLCB9LA0KPiAr
CQkuZHJpdmVyX2RhdGEgPSBQQ0hfQk9BUkRfQ05MLCB9LA0KPiAgCXsgUENJX0RFVklDRShQQ0lf
VkVORE9SX0lEX0lOVEVMLCBQQ0hfVEhFUk1BTF9ESURfQ05MX0gpLA0KPiAtCQkuZHJpdmVyX2Rh
dGEgPSBib2FyZF9jbmwsIH0sDQo+ICsJCS5kcml2ZXJfZGF0YSA9IFBDSF9CT0FSRF9DTkwsIH0s
DQo+ICAJeyBQQ0lfREVWSUNFKFBDSV9WRU5ET1JfSURfSU5URUwsIFBDSF9USEVSTUFMX0RJRF9D
TkxfTFApLA0KPiAtCQkuZHJpdmVyX2RhdGEgPSBib2FyZF9jbmwsIH0sDQo+ICsJCS5kcml2ZXJf
ZGF0YSA9IFBDSF9CT0FSRF9DTkwsIH0sDQo+ICAJeyBQQ0lfREVWSUNFKFBDSV9WRU5ET1JfSURf
SU5URUwsIFBDSF9USEVSTUFMX0RJRF9DTUxfSCksDQo+IC0JCS5kcml2ZXJfZGF0YSA9IGJvYXJk
X2NtbCwgfSwNCj4gKwkJLmRyaXZlcl9kYXRhID0gUENIX0JPQVJEX0NNTCwgfSwNCj4gIAl7IFBD
SV9ERVZJQ0UoUENJX1ZFTkRPUl9JRF9JTlRFTCwgUENIX1RIRVJNQUxfRElEX0xXQiksDQo+IC0J
CS5kcml2ZXJfZGF0YSA9IGJvYXJkX2x3YiwgfSwNCj4gKwkJLmRyaXZlcl9kYXRhID0gUENIX0JP
QVJEX0xXQiwgfSwNCj4gIAl7IFBDSV9ERVZJQ0UoUENJX1ZFTkRPUl9JRF9JTlRFTCwgUENIX1RI
RVJNQUxfRElEX1dCRyksDQo+IC0JCS5kcml2ZXJfZGF0YSA9IGJvYXJkX3diZywgfSwNCj4gKwkJ
LmRyaXZlcl9kYXRhID0gUENIX0JPQVJEX1dCRywgfSwNCj4gIAl7IDAsIH0sDQo+ICB9Ow0KPiAg
TU9EVUxFX0RFVklDRV9UQUJMRShwY2ksIGludGVsX3BjaF90aGVybWFsX2lkKTsNCj4gDQo+IA0K
PiANCg==
