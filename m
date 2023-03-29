Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18F776CD95D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 14:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjC2Mdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 08:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjC2Mdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 08:33:51 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA1373C32;
        Wed, 29 Mar 2023 05:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680093230; x=1711629230;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=gQwXb25SDqJB1XTIh3+YXnmQIs3/r9deH2UXMZgFk6w=;
  b=Uds9lZEClXpPNZSFGI2ZlQQHUuMVJMows00hBACRGAjXwHu7sRNo5cC1
   384MbHK1nZ09bWtTAuHipfO0zpQzj5s7J6v6/rV3liCN/R5OKZVdHEziB
   sFohkIwt3AKEyzNGcIDO+hkQSMciXGomqvI2+PBo0Mu8DRoBKAcm+s/oq
   ij08tvLOA/P3z0j/u3lOXRuUXROzSutwAdJjOmQ9oZAmaLcbJlCD6UylN
   289VHIcR8/X/2ZH4kJ+tyYyATldLiFDncQWejv6yB0XfGrIG4vfIka1rI
   swirskdlvk6jQkKxJ1WdZVA4cFWJLAGhGw8/1rcr2Th+bLW5k/fFCi+ar
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="405804906"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="405804906"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 05:33:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="808195300"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="808195300"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga004.jf.intel.com with ESMTP; 29 Mar 2023 05:33:44 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 29 Mar 2023 05:33:43 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 29 Mar 2023 05:33:43 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.49) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Wed, 29 Mar 2023 05:33:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S3Tk/TgUP+VzXAhDHaBKHHRtlhARUtij9RFvT3ftMQScUoK7bOYGkWpS153mZqOHNBugn9JRRFvvfuMciy6++Oq1PayumhVR1U3XdXgn6l7vG5nGU7UXGaYweGlZPGavaT1viBoaVSa5XQ7BG9lM2WVsft5rN+h56dE8SbemjL3lidbqm5XL6k2ccOemYBH7+h/VKR9MoEG3ohXju4bDLTsKaXBNb8oE28Q9TBGyr0/ePm1O8O3Ruu0iXh+hWwv9hR3Ttp3E27Ow7zcCiq3cMwOKDYpq/EEcrAIID9PBhmt+nohsZWiRPMgs0cNM6/etf04BflGE99xgkKyBqK271w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gQwXb25SDqJB1XTIh3+YXnmQIs3/r9deH2UXMZgFk6w=;
 b=ixtMHo6KpkchGwgH2bABGq450MXyNk0hEikL84JeMXQvLkRU4o9ummrWGxLfWamSpRsmzswhNxTAqSwL9proYXvpiJ750k6BQKyJm+sq4WUi5HcN0tiPxDZRvh5vQ2sGmIqjGJt3qfk+7xjApWayjIHS+X3q+3nEuoS8fC05eQHeoNF9wXkhfeBaY3PGzAnX+QZsje64cHDkCq9wvDcbNUgWe155FjAPs9Ob0YaSvjRPo7ipwXmHuykdu083J1fikNz+yXfb7BJuOSX2UwAZtVHO5iC9osIISp8vnxsbtPD1y4psabPHyhY81bWel/vJ+8uqg2xWZQlntHWGrxwu2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6605.namprd11.prod.outlook.com (2603:10b6:510:1b0::16)
 by IA0PR11MB7751.namprd11.prod.outlook.com (2603:10b6:208:43a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Wed, 29 Mar
 2023 12:33:37 +0000
Received: from PH7PR11MB6605.namprd11.prod.outlook.com
 ([fe80::968d:9383:aae6:175c]) by PH7PR11MB6605.namprd11.prod.outlook.com
 ([fe80::968d:9383:aae6:175c%2]) with mapi id 15.20.6178.037; Wed, 29 Mar 2023
 12:33:37 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "rafael@kernel.org" <rafael@kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] thermal/drivers/thermal_hwmon: Fix a kernel NULL
 pointer dereference
Thread-Topic: [PATCH -next] thermal/drivers/thermal_hwmon: Fix a kernel NULL
 pointer dereference
Thread-Index: AQHZYh1uVnlfaKlfcU6JrYVgxsdgB68RhYcAgAAkDQCAAAeNgA==
Date:   Wed, 29 Mar 2023 12:33:36 +0000
Message-ID: <669e0114830d6e70e6fbc877c94de7446a239055.camel@intel.com>
References: <20230329090055.7537-1-rui.zhang@intel.com>
         <08aee7fe-eddc-7841-2539-16ae43fd8d66@linaro.org>
         <CAJZ5v0hGnoEhYadoK-KPTvMtvviOrGqbY9jrmOUzTjOGe_rB_A@mail.gmail.com>
In-Reply-To: <CAJZ5v0hGnoEhYadoK-KPTvMtvviOrGqbY9jrmOUzTjOGe_rB_A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6605:EE_|IA0PR11MB7751:EE_
x-ms-office365-filtering-correlation-id: 3eb17108-ed59-460f-107d-08db3051d194
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8XJcp5YExVfKH5D+08E2PKQrRppxT5H1pEAl7TGmBDJC52l35Debrl60lzeTtVbngBqQ5Uo9HKEFLc9N/nvdBhmhgzEpgftFgVGUz34qbVPcTfIRURSdnKM8F7Ne/VkIcS5RWUwgADH3g5IjdwHY+4eLwp1bsTsJ2kHShqWjxJjfhgz67ns7dudVPUxV6tSol9rEibOBL+8YpF7dL3G1FjwF0UM6xCZC6fjWjA+6YvdHRZIlPTOOHVAt8M7pLXaCSgDVBXLquSiuEyGizihUOLgQKPyRR4T2vSFy43TJDKbucjQSY5pM4nhLWMINe3go2QMkWQPc5828KvQQ1nYr2tA8WUIAENBbODDgtkonUMMjYgnd4wrHG6uyCGz33w0xw9MPl2mpl0bu2xOCR1brI50SmpCCwkkTe2S4ZDb9s5eAAmw72/rcQqMWVWTemwILigJyZQ2WFkC0RixcA4NXeVpasGLrZ7ESSVvSDHwB8x6/ACbLUTdDY9PzaCBsCGrAuiivYx7RkoOjOa3KDIwRQbOQnW7tAs2ik4DlZRhEf1hsO9KiyTDj5HelpP3OPHIpgB+9IxeXy4CJdO5H6fZIGdqVgkWoalMhQFPZAczRSQBRV77c4ip53QpMPkBuJnyc/3TzRvya9ASR31tEoE4izULKzDJoPdZYwivbOhVqKlHgPmCoTD/6bgAFXw9B0Zlf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6605.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(346002)(376002)(396003)(366004)(451199021)(26005)(66446008)(82960400001)(76116006)(66946007)(64756008)(186003)(66476007)(8676002)(6512007)(5660300002)(316002)(110136005)(38100700002)(122000001)(6506007)(54906003)(4326008)(41300700001)(8936002)(91956017)(53546011)(2616005)(71200400001)(83380400001)(66556008)(6486002)(478600001)(38070700005)(86362001)(2906002)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RGpocUFoRVExbVRGL0pNNDZvUDhWMXc1OG95NGdLVDBONEN6a0ZtcWp2bEtY?=
 =?utf-8?B?N3JlRmd6UTA1bWUwTlFGc0ZaSWNpVmRSRGErdk1oZUZwSmZ2RnBFdEpIaFNv?=
 =?utf-8?B?Z1piT3NrQUtzVlNnbXhHZHB3TXNXUERkS01JN0xMd2JOT1FxeFNJNEtLWVY2?=
 =?utf-8?B?czMvb1YwM1VJY2NkcCtFbHZNVnBRdTZESlQySUxwYWs3WFJqSFAvWXg4Z3Jw?=
 =?utf-8?B?MUh3SVoyZTVGWGxCNnlqN0ZlNUZkOWdHM2NueG5RWVdIdFdudlc3RG1lQVgw?=
 =?utf-8?B?dFFDQ3BrbTh2NG5kZVpIZTJacURuYWNqaDNhcElOYzZqK0lYTzRKRXNIZDNi?=
 =?utf-8?B?Ujh6eXJHT3ZVS1NmV01Ra0d0ZUhVUldaMXVqNEF3NUxLbnN3VGE2aEVsK2FN?=
 =?utf-8?B?QjkyMFdVRURFTHgwVDN6dms5bndUK3hrUkVhZjM1SER5a0szNVZyVWJ6WEJZ?=
 =?utf-8?B?L09kcFNQb3ZlWHRSQXRoN1hOSkpUYnlxeHl0bGtNSkZpY0pUZEg1TmxNbXhG?=
 =?utf-8?B?TG1yNmovSG5nendqbURNalJYRllud2N0cFByTzdRdmhJQnVpK1F1ZjhGMHpQ?=
 =?utf-8?B?L3hRYTdjN3NKdVlDOUQ4V3U3bUYrSG4xcFVWWmVJZlN0UGZ0dWxvKy92d1lC?=
 =?utf-8?B?cUMrVWVKTjJGS2pzditiZTZWbmlWUVluazRBclVmMkhReEpRV2g1MmFlNVE4?=
 =?utf-8?B?aUMrRHArZ21SRkUxWlZHL09LY1dFVEgyeHhPSEsyZ0x2VVBqb3ByeDQyUTRm?=
 =?utf-8?B?RUpPSVh0MnA5SFg2ay9BM0hqY2NaTkdtUW9tcUxKNGo5SjhFK25oQWlTdmsy?=
 =?utf-8?B?M3diK01kS09WaEo1SEhxbHVHampHZVYvbFRGcm5hcTEzVUFORHJWYTM1cmV5?=
 =?utf-8?B?V1BobW5mbkg5Sm5iQjZhVUNIRjJiaDAvREJqZXErSzJnQ1RJbDBGa29aSWkz?=
 =?utf-8?B?R3NzNmwzS3lZSTNMVkM0MTZRMmNySmJxV1QrUmpQSytLdmNhQ3F1RXhFdTkx?=
 =?utf-8?B?SzZndXRUQ1RSWHBiazJxS0hja1FjUHkwSEpXRUhSQnVjYVcwSEpvc2tqdENl?=
 =?utf-8?B?MXVqaGJ6NXRpakMxWFZjanoxNmJyUFpkUzFoMGtvRmllRXZPRWJSaGJCeGVV?=
 =?utf-8?B?RUNpOFpuYjhiaERiZ1dmWW5mT3pINmRqVGhFSWhCN1J2c0E2QWZ1Z0g2dVRN?=
 =?utf-8?B?K3NMT2YxcWNDV2V1YXNJcWVjNmsvdUIzeVowSXBMUldCQUxUcVUxTTFFaXFF?=
 =?utf-8?B?cXZhWHpUTkxmRGtGQVZ5TVJob01WTkdWUUM2ZUtWMHY4S0JPNlhvZUNNWitX?=
 =?utf-8?B?MENLSkNZMzFaQ1ltNlF2UHhNK1d5WWVWclhkbzNiRm5VaktROEw1MWtmKzRr?=
 =?utf-8?B?Z2s4SkxLZm1iV1BzSEhHank2cy8vcHBiVG9zRUdTRzhvOHFQcXYwM0xBS01q?=
 =?utf-8?B?ZHBvdlBmdzljZmhSQnJjVjBOMmxxRlpkVzUxT3FuWmpuUzQxVUZQc2RMbllk?=
 =?utf-8?B?YnlHWGNxSFZHRDF5eEdET3ZPUTBZRkVPOFA1YTQ3V1JFKzRHZ0NuMkhkUUt6?=
 =?utf-8?B?Y1dnem9YZnVxOFFIdElUaEN6blZ0MjJ6b3VSRTlWWldaMk9kQlJObWtITHkw?=
 =?utf-8?B?UUZXNTQ2RUJqdWdBdGs4M2UvMjdSbWJ6Z0U3cU9MMjBuRHg2YVo3UkZCNjRk?=
 =?utf-8?B?empCZUxETnY4aVZUeDZ4TUFMR3hucEcraHVJdEx4YksvOFRhMjk0MklyZGds?=
 =?utf-8?B?bmoyVHFGVStha2RYa1ArVGtLajF4WXRiOW5iUytYT0svRERGNkNsc1VuRGdS?=
 =?utf-8?B?M0FyaTRNeS8rZVczNlR1eVMvRE1jZEtvOGNlRnk1VlVhbUNacVVmTGxJL2hC?=
 =?utf-8?B?cElNWm1tZVo2T25ObVd6Zkh5WmhiUDFMc1BzcmtoMityYUNxZ3RjRlgxQ0hZ?=
 =?utf-8?B?S1BQYVVtQ2FZWVhBYkNXa3o3TmpTUGlXa1EwZ3JuSWlDb3dHMlBINnNmdlAv?=
 =?utf-8?B?WFBFaDhwaUNNbHpLMVdQcGp5dzJYN3N1RmM2UkVEOFRQRnZITk43aTAwU0xL?=
 =?utf-8?B?NWFjV1B4UlVSb0FodnpMZ0pUNGs4bytzWVFzUXdNa3ErT2lkcEFtVHNXNXdI?=
 =?utf-8?Q?ODTL0Dom1oMeYdVHXh3WIT9SU?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8A887BFDCE2AFD4C959AF5B2F63D90A6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6605.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3eb17108-ed59-460f-107d-08db3051d194
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2023 12:33:36.9057
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5Zsep/WYcbCRpi5YNUJb8qI0Nw4y+7E3GTB4nm3cjO8DoaxmPFF9kfem71RytCAQrk2iHLBUerJxnEtYlsQbaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7751
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTAzLTI5IGF0IDE0OjA2ICswMjAwLCBSYWZhZWwgSi4gV3lzb2NraSB3cm90
ZToNCj4gT24gV2VkLCBNYXIgMjksIDIwMjMgYXQgMTE6NTfigK9BTSBEYW5pZWwgTGV6Y2Fubw0K
PiA8ZGFuaWVsLmxlemNhbm9AbGluYXJvLm9yZz4gd3JvdGU6DQo+ID4gT24gMjkvMDMvMjAyMyAx
MTowMCwgWmhhbmcgUnVpIHdyb3RlOg0KPiA+ID4gV2hlbiB0aGUgaHdtb24gZGV2aWNlIG5vZGUg
b2YgYSB0aGVybWFsIHpvbmUgZGV2aWNlIGlzIG5vdCBmb3VuZCwNCj4gPiA+IHVzaW5nIGh3bW9u
LT5kZXZpY2UgY2F1c2VzIGEga2VybmVsIE5VTEwgcG9pbnRlciBkZXJlZmVyZW5jZS4NCj4gPiA+
IA0KPiA+ID4gUmVwb3J0ZWQtYnk6IFByZWJsZSBBZGFtIEMgPGFkYW0uYy5wcmVibGVAaW50ZWwu
Y29tPg0KPiA+ID4gU2lnbmVkLW9mZi1ieTogWmhhbmcgUnVpIDxydWkuemhhbmdAaW50ZWwuY29t
Pg0KPiA+ID4gLS0tDQo+ID4gPiBGaXhlczogZGVjMDdkMzk5Y2M4ICgidGhlcm1hbDogRG9uJ3Qg
dXNlICdkZXZpY2UnIGludGVybmFsDQo+ID4gPiB0aGVybWFsIHpvbmUgc3RydWN0dXJlIGZpZWxk
IikNCj4gPiA+IGRlYzA3ZDM5OWNjOCBpcyBhIGNvbW1pdCBpbiB0aGUgbGludXgtbmV4dCBicmFu
Y2ggb2YgbGludXgtcG0NCj4gPiA+IHJlcG8uDQo+ID4gPiBJJ20gbm90IHN1cmUgaWYgdGhlIEZp
eCB0YWcgYXBwbGllcyB0byBzdWNoIGNvbW1pdCBvciBub3QuDQo+ID4gDQo+ID4gQWN0dWFsbHkg
aXQgcmV2ZXJ0cyB0aGUgd29yayBkb25lIHRvIGVuY2Fwc3VsYXRlIHRoZSB0aGVybWFsIHpvbmUN
Cj4gPiBkZXZpY2UNCj4gPiBzdHJ1Y3R1cmUuDQo+IA0KPiBTbyBtYXliZSBpbnN0ZWFkIG9mIHRo
ZSB3aG9sZXNhbGUgc3dpdGNoIHRvIHVzaW5nICJkcml2ZXItc3BlY2lmaWMiDQo+IGRldmljZSBw
b2ludGVycyBmb3IgcHJpbnRpbmcgbWVzc2FnZXMsIHNvbWV0aGluZyBsaWtlDQo+IHRoZXJtYWxf
em9uZV9kZWJ1Zy9pbmZvL3dhcm4vZXJyb3IoKSB0YWtpbmcgYSB0aGVybWFsIHpvbmUgcG9pbnRl
ciBhcw0KPiB0aGUgZmlyc3QgYXJndW1lbnQgY2FuIGJlIGRlZmluZWQ/DQo+IA0KPiBBdCBsZWFz
dCB0aGlzIHBhcnRpY3VsYXIgYnVnIGNvdWxkIGJlIGF2b2lkZWQgdGhpcyB3YXkuDQoNCkkgZGlk
bid0IHNlZSB5b3VyIGVtYWlsIGJlZm9yZSBzZW5kaW5nIHBhdGNoIHYyLg0KDQphcmUgd2UgZ29p
bmcgdG8gcmV3b3JrIHRoZSBwcmV2aW91cyBzZXJpZXMgZnJvbSBEYW5pZWwgdGh1cyBwYXRjaCB2
MiBpcw0Kbm8gbG9uZ2VyIG5lZWRlZD8NCg0KdGhhbmtzLA0KcnVpDQo+IA0KPiA+ID4gLS0tDQo+
ID4gPiAgIGRyaXZlcnMvdGhlcm1hbC90aGVybWFsX2h3bW9uLmMgfCAyICstDQo+ID4gPiAgIDEg
ZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiA+ID4gDQo+ID4g
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy90aGVybWFsL3RoZXJtYWxfaHdtb24uYw0KPiA+ID4gYi9k
cml2ZXJzL3RoZXJtYWwvdGhlcm1hbF9od21vbi5jDQo+ID4gPiBpbmRleCBjNTlkYjE3ZGRkZDYu
LjI2MTc0M2Y0NjFiZSAxMDA2NDQNCj4gPiA+IC0tLSBhL2RyaXZlcnMvdGhlcm1hbC90aGVybWFs
X2h3bW9uLmMNCj4gPiA+ICsrKyBiL2RyaXZlcnMvdGhlcm1hbC90aGVybWFsX2h3bW9uLmMNCj4g
PiA+IEBAIC0yMjksNyArMjI5LDcgQEAgdm9pZCB0aGVybWFsX3JlbW92ZV9od21vbl9zeXNmcyhz
dHJ1Y3QNCj4gPiA+IHRoZXJtYWxfem9uZV9kZXZpY2UgKnR6KQ0KPiA+ID4gICAgICAgaHdtb24g
PSB0aGVybWFsX2h3bW9uX2xvb2t1cF9ieV90eXBlKHR6KTsNCj4gPiA+ICAgICAgIGlmICh1bmxp
a2VseSghaHdtb24pKSB7DQo+ID4gPiAgICAgICAgICAgICAgIC8qIFNob3VsZCBuZXZlciBoYXBw
ZW4uLi4gKi8NCj4gPiA+IC0gICAgICAgICAgICAgZGV2X2RiZyhod21vbi0+ZGV2aWNlLCAiaHdt
b24gZGV2aWNlIGxvb2t1cA0KPiA+ID4gZmFpbGVkIVxuIik7DQo+ID4gPiArICAgICAgICAgICAg
IGRldl9kYmcoJnR6LT5kZXZpY2UsICJod21vbiBkZXZpY2UgbG9va3VwDQo+ID4gPiBmYWlsZWQh
XG4iKTsNCj4gPiANCj4gPiBBcyBpdCAnU2hvdWxkIG5ldmVyIGhhcHBlbicsIEkgd291bGQgcmVw
bGFjZSB0aGF0IGJ5Og0KPiA+IA0KPiA+ICAgICAgICAgaWYgKFdBUk5fT04oIWh3bW9uKSkNCj4g
PiAgICAgICAgICAgICAgICAgLyogU2hvdWxkIG5ldmVyIGhhcHBlbi4uLiAqLw0KPiA+ICAgICAg
ICAgICAgICAgICByZXR1cm47DQo+ID4gDQo+ID4gDQo+ID4gDQo+ID4gPiAgICAgICAgICAgICAg
IHJldHVybjsNCj4gPiA+ICAgICAgIH0NCj4gPiA+IA0KPiA+IA0KPiA+IC0tDQo+ID4gPGh0dHA6
Ly93d3cubGluYXJvLm9yZy8+IExpbmFyby5vcmcg4pSCIE9wZW4gc291cmNlIHNvZnR3YXJlIGZv
ciBBUk0NCj4gPiBTb0NzDQo+ID4gDQo+ID4gRm9sbG93IExpbmFybzogIDxodHRwOi8vd3d3LmZh
Y2Vib29rLmNvbS9wYWdlcy9MaW5hcm8+IEZhY2Vib29rIHwNCj4gPiA8aHR0cDovL3R3aXR0ZXIu
Y29tLyMhL2xpbmFyb29yZz4gVHdpdHRlciB8DQo+ID4gPGh0dHA6Ly93d3cubGluYXJvLm9yZy9s
aW5hcm8tYmxvZy8+IEJsb2cNCj4gPiANCg==
