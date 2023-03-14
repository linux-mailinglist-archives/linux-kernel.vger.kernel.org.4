Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D21D56B87F8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 03:03:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbjCNCDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 22:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbjCNCDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 22:03:13 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA981C583;
        Mon, 13 Mar 2023 19:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678759384; x=1710295384;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=XdOOzALU2kQIOu0Nf/C2rxrBVKz4507WNziz9J2xpPQ=;
  b=fQ/L9jR05UoyyZWu0mtDwH23vmB5wooUWe1/CUbP48m0n3ACaNjVACFc
   TCPCNlMgYWe/CPsQkQKoV4cD8cKfdtIcE7k3vPY9NKGY/FlM1M3T1OhT1
   JY7nzGb0HEcDmzZMVzr1xOjQxaYxZSu0foIokwFSU61Z1vhlDxocgOg7z
   H9s8OKPRh2JxaBNuO4jNXhzngOmGc8drmDjTDtpyoXIEJ+qRReqbP779o
   FO//RQYzPbv7bmptdXgfDciU1h2I1KHuGjirUG3HVENHRd9diWpRRezQ1
   bpUdD1nXhCX0yVVMS+0rbIjNxQIOGin4cf+aCTtLDmcFWgFDCN+kE8qVT
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="402179803"
X-IronPort-AV: E=Sophos;i="5.98,258,1673942400"; 
   d="scan'208";a="402179803"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 19:03:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="678915520"
X-IronPort-AV: E=Sophos;i="5.98,258,1673942400"; 
   d="scan'208";a="678915520"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP; 13 Mar 2023 19:03:04 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 13 Mar 2023 19:03:03 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 13 Mar 2023 19:03:03 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 13 Mar 2023 19:03:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZpHzeV88KG0VT1sClU1hoxWrr0m9iuMWKoGfF5atleG1O7g0/LZkdn5ULBzJkWgCuvjvKFxyqBUD1J9I1h97dYmTTd1uTf8KxM3R7p/5tyXTk/8r9aFoGaGbEkQeRg0Nbfz2kbVHkxZSXoftp0MXuEi/XM8MvrHDMUyzIP49O7USyr76ZZ5bsMeSQSZ7ewApMG/wgq+w0ihkGpnceWmfQdmyoMShacA4bki4b/LkMIHLTmy2KMbzChTpy440xXiwVSur5Gm4OCIjxIg4OY1gK1AWAhv/I30HYgQxR/oWTQTGZpmsi97+Bx10g07pwuty7yAzAPPznGRvGV5jw5v+Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XdOOzALU2kQIOu0Nf/C2rxrBVKz4507WNziz9J2xpPQ=;
 b=oDUuZQv6dF2I9ftuvjTTRGf/kZGLEKlrejB70A7OOh6JZgfnLSWO11ei530tOyL61CXyzxc4KnXwRwAVchgaV3pW4ivysvvL5W4A5LfmOMfHPr20br5iK3ppER+Zg4jxI8pmVpol4i2mvR6WWCfnbJbo1D9sqQhpiSTYL6ZU3h5Tf5t5kWC/owyJQ/CqTeY/nPF/7Xpm2Ij7cr/B+Ia9WltMRYth1A9OKE5k03P36/nekxBFmlkSHPGZ8tDQKuCYIbhzv1UDVgvYBbhugWHQw7Ja1qyxhXgmN+9LW6yc9IKUwb6LidSnOPwGlR49QFdXyayRvn4ZY1Ck/tsaQNW/qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6605.namprd11.prod.outlook.com (2603:10b6:510:1b0::16)
 by PH7PR11MB6452.namprd11.prod.outlook.com (2603:10b6:510:1f3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.23; Tue, 14 Mar
 2023 02:03:02 +0000
Received: from PH7PR11MB6605.namprd11.prod.outlook.com
 ([fe80::968d:9383:aae6:175c]) by PH7PR11MB6605.namprd11.prod.outlook.com
 ([fe80::968d:9383:aae6:175c%2]) with mapi id 15.20.6178.024; Tue, 14 Mar 2023
 02:03:02 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>
CC:     "srinivas.pandruvada@linux.intel.com" 
        <srinivas.pandruvada@linux.intel.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "Wang, Quanxian" <quanxian.wang@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v2 1/4] ACPI: processor: Reorder
 acpi_processor_driver_init()
Thread-Topic: [PATCH v2 1/4] ACPI: processor: Reorder
 acpi_processor_driver_init()
Thread-Index: AQHZVbj2vzR1bgNC4Ei7y+cmW5lVyK75hsOA
Date:   Tue, 14 Mar 2023 02:03:01 +0000
Message-ID: <813c85a727e361c8300b38b8d71b19e83c6260b5.camel@intel.com>
References: <2692681.mvXUDI8C0e@kreacher> <5934791.lOV4Wx5bFT@kreacher>
In-Reply-To: <5934791.lOV4Wx5bFT@kreacher>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6605:EE_|PH7PR11MB6452:EE_
x-ms-office365-filtering-correlation-id: 09cbaa94-f392-4109-087e-08db24303e02
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a8b6z2tdbolPeW7x30gy9CHIvPsk5kxK8biAdgYZJ86dITg5XyOp2oMsNJpqacMQ5ac3pYAsk6Q+nSugJ/fm0py3MoRNIGohNQjm6xhyHFj5aETQV2Rj8dPgx8FfNiONLO1HlFFDoTDQgWyzIG44EdLDu/9cLhxjTLXaT61s8O4bajvtttXgRHOeO4GIwwc00NRay6bRTAcGm2J8WrFQE5l1Gs/SxZQKL6jLmRA40REEqBCN5fIgA+R3xtVzuDUqJV4le8Ki3BYZhCSHhSbHNxIO6spDFQWroEUIgB4R92pRDwu7obdGSCvOmA5HrYL0Ex8o8hYGN3A0yGIOeUVIZmELTTQyc0cDTg5XCi2nH+SCsigCcIiaYWp9TBgBfhrp4wS0P6Tx6qvAlbbf1kQUdG1GseHG3w1YkW1v/BC7zShEukO3VjK6wEwmCoIfuVHXpei8koZpyiTIpekJcJXfUdgDmDKizgxnOyUsAUbL49/4c8BMW9cDpIL+E6kkkzgK242LBffFJ7iZiBpXrgDE0fNOziRX5ZX4K0aPkJIDFmsjc6tWAxM59lsHq3/TpPSnPpkzcYOMrDKpd4gX2oK12P0DowKySQHTjVuX8NxRda9wXhYC/b3xlsX5OC9YCkpMtFM9iO4MM3vHGvnq92qgmHofdQTpNqTLMImhGHdWr3f2QpHzaDSwmV9LEZVkFdoGSu3kty0CDZk+Zt9pksrXEkEyXdyfxCrCIeO9P7ehAhw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6605.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(366004)(346002)(376002)(39860400002)(136003)(451199018)(84970400001)(2616005)(2906002)(186003)(38100700002)(122000001)(82960400001)(26005)(6512007)(41300700001)(38070700005)(6506007)(83380400001)(5660300002)(478600001)(316002)(8936002)(64756008)(54906003)(110136005)(36756003)(66476007)(6486002)(91956017)(966005)(86362001)(8676002)(66946007)(66556008)(66446008)(76116006)(71200400001)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S2xXd0ZIbTJyRU9OaE1GdVVPVDdyRXZoQXNWZFFUWmpCUWg4NE5aekM1UFN3?=
 =?utf-8?B?cE81ZUQ2VmsxbWR5RDE1V3RKT2VQd3dEVUdMT1k3Ym5TcG01RW9KdFBoQ2lU?=
 =?utf-8?B?MXpxK2M0R3l2RGJ4TTkwbnVrTGlsTmxzYmVQV29JMjZ5eUZITG40N3NEQWFC?=
 =?utf-8?B?NFhEUXk4SFphWXY3cUt2Uy85emg3bE1SK3dSM0ZhVTNldWJJWEYwSFZDVWpi?=
 =?utf-8?B?Z2syVVdKNHdRTlNIRk1kRGtISWQxcXFDWXNWWG9xSjNQOXZCelVaZ1pHeU5Z?=
 =?utf-8?B?TkFmeTQwRURqS3N4cjV6VVhEa1hCYlFhMEM1Vy9GTlkzcE9OZHRya2dRRTZt?=
 =?utf-8?B?UHRXSXNDckg4T1lERU5KbU0rQmp0THdDd0dkQTBVdlpPTEtRSXdrU1N2OWNF?=
 =?utf-8?B?WWROdVcwRFNUWGxpcUkyU1M3Q1FKaWRJdXB3UUlneDFCUVlEb2k2OEx6OHpl?=
 =?utf-8?B?Y1dZNHpVd0pQSytmODYyelpFQkpvTnk1UFErTEJUdzJPYjJaOGQyT2dMTWNW?=
 =?utf-8?B?a3JWQU9WMmNFN1k0bEkzQkNkdUJJdkVsNDAwdER6MU9iQnJIa0NLMlNaeVN6?=
 =?utf-8?B?ZzRMbGoxdVl2bGJSQVAwbk9QNGQ1Y3VVSFQvVjRCc1VhdEdlaDFOSlhhR0Zl?=
 =?utf-8?B?ZjZ2STljYnFsTFFOKzRUbXRVNmQ4dkNpSnVVUjRrdHN1d3cyK0llNHNCNkJ4?=
 =?utf-8?B?TVJvdW9xbGdlVGd6VUF2dEFDYjArRDZXaStRcXE1Y2pyOW1ockZ2cXUvZWkr?=
 =?utf-8?B?UGE2THhtNGVuWDNNdXV2Skp6aGxVeUJGajYxTzVtczlCYXQ4RVVVNU45cUNz?=
 =?utf-8?B?dlRoWWs0TWxNSWQ4cWxKRmdKUXdNNktuNlQ5U3RoTmJ2c2hKTEVEdkxZSzhp?=
 =?utf-8?B?bFNJdUVZRS93NzRQQ3hVK2xYaG9rU2R6b0haOFQzL2VjVGpFelFraEgzNVp6?=
 =?utf-8?B?Qkx3bE4zN0VINHBHQ1Y2Z1BvQnJYTlJlbWlJaXgrNkpXRWl4NC9MOFIvemRn?=
 =?utf-8?B?VnhUN21kOTBQRmJSV0tXdTJQd1hPNjJWdytlUTkrZXNwdFdpOFNMcnYzS2w2?=
 =?utf-8?B?dERZS1RhZDZMdEJOaS9JK0duL3c3MTRqc2pubmo2UnUxMWJxNkVPVG51djFX?=
 =?utf-8?B?WFB6ZFBpdHZNbjlUZkMyeDluMHc4NDF2NFZZK3RZa2dJeTdQUjRiUDN6RFVM?=
 =?utf-8?B?Vmt1VkhBQ2luR3VnNlIycXN5dXVIN3VEU2ltQ0Q5eXhpVXlKZzd6RlRPeFpm?=
 =?utf-8?B?Y0NOeEpnTlBjM3BzR25pWVN3NmJPSElvSTlTQWV3ajFNWTVDVEtHbkZDamtj?=
 =?utf-8?B?QThoQ3JjVlI3WUc2Q1drWXRMR3F4YmRMbVVKN1E3bjh2NkszNm82OTJkanYy?=
 =?utf-8?B?QWFrdEoyZGdxV29WRFIyNFlxNWZyZ2JFTkdPWVBYYk9wRk8ydW8vdWVGYTRh?=
 =?utf-8?B?Y0V4T0YxTGcxbjVlV3U5NG9HakQzZWJ0bWttaG1CSlRod2R1VTd4SndRRnk4?=
 =?utf-8?B?UzJET2tJa2ZXSmlMWGU2TU5OL1BCR2U0b1lucEFiMXRzYmF5UUdXdVpKVTVr?=
 =?utf-8?B?eWRCdFhjYUNTdDlneGxVekxzbHEwVkp3V2l5a0F2MWtyVXJwWU9TbGJvVGc5?=
 =?utf-8?B?d0IyanZwajZnK3oyTFdMaTAzNVRFODFiNWdQaTdDb1RpMUpSbGh0dGpwRjR6?=
 =?utf-8?B?ZTkyWWd6eU5VOThoTy9LdGs2Y0VTQ2h3M0g3V2RxVzhFWk1QOVo3MDNjek5G?=
 =?utf-8?B?aXZQVXZDT3VJWDF0Tk10ZlgyeXBGMzdzTU9KMi9hWEZrcHcza244Wm1CMEZ5?=
 =?utf-8?B?S0tjU2dqMWNBWDFjTEpzZVNGV1B5R0gzWEFRR3p4cG11eEVuL01CQW9qazNh?=
 =?utf-8?B?cHdoUXduSUY5a0k2ZUhESW9WTVp6WWFac2I4NEgydldWTGVxZkFUZkpYVWNr?=
 =?utf-8?B?dE1yaVhOOXAvWlNIYUJoYkN0TzhKbjcrT0VIMG1HTlNRVG9Eb1N3bHRjVVFJ?=
 =?utf-8?B?THc3WG1hS1RtdWpOSUlhU0xJSHBIeWhrZHRpUHVrTGVrdFlaei9nOVBCdXpj?=
 =?utf-8?B?NE1zallKeHE1OWVLMEtxaXF4RHJUZ29yWEZVNEdDdm9ick5WZEpEU0NQMUk0?=
 =?utf-8?Q?YzS7j39GCsstoRsNkGM4XzUTZ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <90E65FA3A757E54184308E00E736C135@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6605.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09cbaa94-f392-4109-087e-08db24303e02
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2023 02:03:01.9783
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qc1zL10VnhZqjOlZqSWGYo14Ei8qUS5lrR1qlTq24pzDR3YuH6YJWf11A2bbYwZYbWHEV7sd7VpZ8WgIM7oa4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6452
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTAzLTEzIGF0IDE1OjI3ICswMTAwLCBSYWZhZWwgSi4gV3lzb2NraSB3cm90
ZToNCj4gRnJvbTogUmFmYWVsIEouIFd5c29ja2kgPHJhZmFlbC5qLnd5c29ja2lAaW50ZWwuY29t
Pg0KPiANCj4gVGhlIGNwdWZyZXEgcG9saWN5IG5vdGlmaWVyIGluIHRoZSBBQ1BJIHByb2Nlc3Nv
ciBkcml2ZXIgbWF5IGFzDQo+IHdlbGwgYmUgcmVnaXN0ZXJlZCBiZWZvcmUgdGhlIGRyaXZlciBp
dHNlbGYsIHdoaWNoIGNhdXNlcw0KPiBhY3BpX3Byb2Nlc3Nvcl9jcHVmcmVxX2luaXQgdG8gYmUg
dHJ1ZSAodW5sZXNzIHRoZSBub3RpZmllcg0KPiByZWdpc3RyYXRpb24gZmFpbHMsIHdoaWNoIGlz
IHVubGlrZWx5IGF0IHRoYXQgcG9pbnQpIHdoZW4gdGhlDQo+IEFDUEkgQ1BVIHRoZXJtYWwgY29v
bGluZyBkZXZpY2VzIGFyZSByZWdpc3RlcmVkLCBzbyB0aGUNCj4gcHJvY2Vzc29yX2dldF9tYXhf
c3RhdGUoKSByZXN1bHQgZG9lcyBub3QgY2hhbmdlIHdoaWxlDQo+IGFjcGlfcHJvY2Vzc29yX2Ry
aXZlcl9pbml0KCkgaXMgcnVubmluZy4NCj4gDQo+IENoYW5nZSB0aGUgb3JkZXJpbmcgaW4gYWNw
aV9wcm9jZXNzb3JfZHJpdmVyX2luaXQoKSBhY2NvcmRpbmdseQ0KPiB0byBwcmV2ZW50IHRoZSBt
YXhfc3RhdGUgdmFsdWUgZnJvbSByZW1haW5pbmcgMCBwZXJtYW5lbnRseSBmb3IgYWxsDQo+IEFD
UEkgQ1BVIGNvb2xpbmcgZGV2aWNlcyBkdWUgdG8gc2V0dGluZyBhY3BpX3Byb2Nlc3Nvcl9jcHVm
cmVxX2luaXQNCj4gdG9vIGxhdGUuICBbTm90ZSB0aGF0IHByb2Nlc3Nvcl9nZXRfbWF4X3N0YXRl
KCkgbWF5IHN0aWxsIHJldHVybg0KPiBkaWZmZXJlbnQgdmFsdWVzIGF0IGRpZmZlcmVudCB0aW1l
cyBhZnRlciB0aGlzIGNoYW5nZSwgZGVwZW5kaW5nIG9uDQo+IHRoZSBjcHVmcmVxIGRyaXZlciBy
ZWdpc3RyYXRpb24gdGltZSwgYnV0IHRoYXQgaXNzdWUgbmVlZHMgdG8gYmUNCj4gYWRkcmVzc2Vk
IHNlcGFyYXRlbHkuXQ0KPiANCj4gRml4ZXM6IGEzNjUxMDVjNjg1YygidGhlcm1hbDogc3lzZnM6
IFJldXNlIGNkZXYtPm1heF9zdGF0ZSIpDQo+IFJlcG9ydGVkLWJ5OiBXYW5nLCBRdWFueGlhbiA8
cXVhbnhpYW4ud2FuZ0BpbnRlbC5jb20+DQo+IExpbms6IA0KPiBodHRwczovL2xvcmUua2VybmVs
Lm9yZy9saW51eC1wbS81M2VjMWYwNmY2MWM5ODQxMDA4Njg5MjZmMjgyNjQ3ZTU3ZWNmYjJkLmNh
bWVsQGludGVsLmNvbS8NCj4gU2lnbmVkLW9mZi1ieTogUmFmYWVsIEouIFd5c29ja2kgPHJhZmFl
bC5qLnd5c29ja2lAaW50ZWwuY29tPg0KDQpUZXN0ZWQtYnk6IFpoYW5nIFJ1aSA8cnVpLnpoYW5n
QGludGVsLmNvbT4NClJldmlld2VkLWJ5OiBaaGFuZyBSdWkgPHJ1aS56aGFuZ0BpbnRlbC5jb20+
DQoNCnRoYW5rcywNCnJ1aQ0KPiAtLS0NCj4gDQo+IHYxIC0+IHYyOiBFeHBhbmQgY2hhbmdlbG9n
IHRvIGV4cGxhaW4gdGhhdCB0aGlzIHBhcnRpY3VsYXIgcGF0Y2gNCj4gYWRkcmVzc2VzDQo+ICAg
ICAgICAgICBwYXJ0IG9mIHRoZSBpc3N1ZS4NCj4gDQo+IC0tLQ0KPiAgZHJpdmVycy9hY3BpL3By
b2Nlc3Nvcl9kcml2ZXIuYyB8ICAgMTIgKysrKysrLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwg
NiBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQ0KPiANCj4gSW5kZXg6IGxpbnV4LXBtL2Ry
aXZlcnMvYWNwaS9wcm9jZXNzb3JfZHJpdmVyLmMNCj4gPT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KPiAtLS0gbGludXgt
cG0ub3JpZy9kcml2ZXJzL2FjcGkvcHJvY2Vzc29yX2RyaXZlci5jDQo+ICsrKyBsaW51eC1wbS9k
cml2ZXJzL2FjcGkvcHJvY2Vzc29yX2RyaXZlci5jDQo+IEBAIC0yNjMsNiArMjYzLDEyIEBAIHN0
YXRpYyBpbnQgX19pbml0IGFjcGlfcHJvY2Vzc29yX2RyaXZlcl8NCj4gIAlpZiAoYWNwaV9kaXNh
YmxlZCkNCj4gIAkJcmV0dXJuIDA7DQo+ICANCj4gKwlpZiAoIWNwdWZyZXFfcmVnaXN0ZXJfbm90
aWZpZXIoJmFjcGlfcHJvY2Vzc29yX25vdGlmaWVyX2Jsb2NrLA0KPiArCQkJCSAgICAgICBDUFVG
UkVRX1BPTElDWV9OT1RJRklFUikpIHsNCj4gKwkJYWNwaV9wcm9jZXNzb3JfY3B1ZnJlcV9pbml0
ID0gdHJ1ZTsNCj4gKwkJYWNwaV9wcm9jZXNzb3JfaWdub3JlX3BwY19pbml0KCk7DQo+ICsJfQ0K
PiArDQo+ICAJcmVzdWx0ID0gZHJpdmVyX3JlZ2lzdGVyKCZhY3BpX3Byb2Nlc3Nvcl9kcml2ZXIp
Ow0KPiAgCWlmIChyZXN1bHQgPCAwKQ0KPiAgCQlyZXR1cm4gcmVzdWx0Ow0KPiBAQCAtMjc2LDEy
ICsyODIsNiBAQCBzdGF0aWMgaW50IF9faW5pdCBhY3BpX3Byb2Nlc3Nvcl9kcml2ZXJfDQo+ICAJ
Y3B1aHBfc2V0dXBfc3RhdGVfbm9jYWxscyhDUFVIUF9BQ1BJX0NQVURSVl9ERUFELCAiYWNwaS9j
cHUtDQo+IGRydjpkZWFkIiwNCj4gIAkJCQkgIE5VTEwsIGFjcGlfc29mdF9jcHVfZGVhZCk7DQo+
ICANCj4gLQlpZiAoIWNwdWZyZXFfcmVnaXN0ZXJfbm90aWZpZXIoJmFjcGlfcHJvY2Vzc29yX25v
dGlmaWVyX2Jsb2NrLA0KPiAtCQkJCSAgICAgICBDUFVGUkVRX1BPTElDWV9OT1RJRklFUikpIHsN
Cj4gLQkJYWNwaV9wcm9jZXNzb3JfY3B1ZnJlcV9pbml0ID0gdHJ1ZTsNCj4gLQkJYWNwaV9wcm9j
ZXNzb3JfaWdub3JlX3BwY19pbml0KCk7DQo+IC0JfQ0KPiAtDQo+ICAJYWNwaV9wcm9jZXNzb3Jf
dGhyb3R0bGluZ19pbml0KCk7DQo+ICAJcmV0dXJuIDA7DQo+ICBlcnI6DQo+IA0KPiANCj4gDQo=
