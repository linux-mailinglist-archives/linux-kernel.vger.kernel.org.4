Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB95725210
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 04:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240742AbjFGCXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 22:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240469AbjFGCXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 22:23:04 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C00A11732;
        Tue,  6 Jun 2023 19:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686104583; x=1717640583;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=bijb9fvB+tjU6eop9lwEvIyGzlS1BL7/uiPuQcrpqSg=;
  b=f4clu63Pk+zqrx1gRi9Nygz7RfrwPqNwkK66W43aFENnk3nN2Vqmz2R+
   hcjYYfWuUfP1w/naREPT0uRNMUHhHSKoBShXCFVO/B6FtL9hgOOd5aRoB
   K0umLkLsbmyUwHrBZLtEJTW14N2xKujH3vSdaYr6hQRiB0Z+GiraPYQgY
   BONSeK5NyPO4mpB1YfKGHme6/KXXTKX8kZK3z7ook95jBIWhkEO0QsLGm
   mqV953O43Q2x8A1/N/kPHfQsk4PRibJa/xs6Py83LfxfyL8gx6lI+0PJh
   Uzxk87qvVwQlbBCDq4xgzdcQ8actmPng9y7d+3iI7etlxA9csdIGN3tA+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="420407444"
X-IronPort-AV: E=Sophos;i="6.00,222,1681196400"; 
   d="scan'208";a="420407444"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 19:23:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="799105873"
X-IronPort-AV: E=Sophos;i="6.00,222,1681196400"; 
   d="scan'208";a="799105873"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP; 06 Jun 2023 19:23:02 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 6 Jun 2023 19:23:02 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 6 Jun 2023 19:23:02 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 6 Jun 2023 19:23:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dbrCYMoph7Nu0FB38iRl1U4UZz66+5IztbVxC1kkwt+hJK9Ps5eywpYCPebOCczJO+s56IZLZdYWWaAj/A8V/uv8YKwwnNZgmaxNkiWosyOAWw3OKI6B5/UHmGZBfje5TTWiREQSI63VgANRoEoUYmLyXhPWa4+TcJLpPoHePhE1lblZZUIlI/StTM3WMcAnREOjDMP2xlYM/QgMMJcSVsV2QXfSwfSECtFWnKts6I0WxbkM+anDWHg+sc0prDYuYCaIquvjXAqd9Rin11AryOnBoZbYivR5zTs7JNV8s1taoEw99e8QIQFDCf4ZUo9sbxWmI3JaLw6D0LpX5jx8gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bijb9fvB+tjU6eop9lwEvIyGzlS1BL7/uiPuQcrpqSg=;
 b=kjwOkBtQ2sAlMr+nAQWMknB+OSmmDA0xhxgnMqA1gPBYqTxj7LPvidM3Sx8rGzXvVDj66rmeCfjcpmJfIxYRsbXaNyFFIvqb0ea7MJ+6ERb26iLqack4x0vdzEy7mu7YVkqjPWCocyyhBej63ptSi24+yR99Lqo+5fAZEQd+1NB+DFt9643dzdK2yeD7AJWcgm3+Pweo/NDkfB5kp6GV0t5ZgEymLzwk7EkB0oQrYH01JQRfdsXaUxAmaVS3jzNhL/RvxR6uq+u9eESx9Q/RGUZf85iSUFmpkJd2wH8C4RNfH48CW5ytLVAh28S/5xs1zySOnAxODzN+0t0zTGuCDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6605.namprd11.prod.outlook.com (2603:10b6:510:1b0::16)
 by CY8PR11MB6915.namprd11.prod.outlook.com (2603:10b6:930:59::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.28; Wed, 7 Jun
 2023 02:23:00 +0000
Received: from PH7PR11MB6605.namprd11.prod.outlook.com
 ([fe80::cbf6:1cb5:b0d7:4fe8]) by PH7PR11MB6605.namprd11.prod.outlook.com
 ([fe80::cbf6:1cb5:b0d7:4fe8%7]) with mapi id 15.20.6455.027; Wed, 7 Jun 2023
 02:23:00 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        lkp <lkp@intel.com>
CC:     "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
        "arnd@arndb.de" <arnd@arndb.de>
Subject: Re: [PATCH] powercap: intel_rapl: Fix CONFIG_IOSF_MBI dependency
Thread-Topic: [PATCH] powercap: intel_rapl: Fix CONFIG_IOSF_MBI dependency
Thread-Index: AQHZmH9TBB7sM0bH0UevxBXlS9+OVa996uwAgACyCAA=
Date:   Wed, 7 Jun 2023 02:22:59 +0000
Message-ID: <62b7e97ede85927cd523578be0b702723043d92b.camel@intel.com>
References: <20230606140000.385223-1-rui.zhang@intel.com>
         <202306062334.5Z1NkD1F-lkp@intel.com>
In-Reply-To: <202306062334.5Z1NkD1F-lkp@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6605:EE_|CY8PR11MB6915:EE_
x-ms-office365-filtering-correlation-id: 8b56cdf4-b5d7-4dcd-7233-08db66fe1d2d
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2bt0J9ew5QedJ6uVbXm9VrkwJSBooz4FZuw1FLne4gRdvNMo9vos/biqz0SgzlwZMPfvvGVHDFjC3sb7edAljeAnXlNbfca8JQKcp9EifESLptALoCuJJ5ElR2gETqN6RpimuhCpJQfe/msTOiq40EZIsGaMEM4HFhDuMfYv9zGzMPRby7gj1zj0Gnq4UEuuLiynJaQTsgnQT2suktrjR3lh2XLUTYFUD3sYuN9oe77t+ViCWn6oehAZyZTzXRQMd5Bxuab4/2/AZi8UcKR9XH6AgXeSi8sSOjXd95E/Jg/TGumD6MRSx5aIgMJAHXHDW0WOZaV6cLkS1JCu/y4GCdXycHKfb9oaPj5ZZ+h4/6AoqJmcNXSoSYnWb2QW34w7wkdwySNGB7aUm6+owNlkKqzEJJyWYCtNSwKnXZ2PsudvGDPZGgmzYPIqTBpS2aSJgmBkvrRq6agXIcaztCpXqI8oGM79Tcg3C5g9eVwsf4RUZInWKhlbcpsHWE0HYoDgJWMAvImzSDIeaAiBwvCXdmMyL1r0B4++q2NYTjLLmvQ+mjjk/GfP0bPlZy1s2/1CYtvfx2WCDB9lRqLx2WVeF1qSN2Hx49lj81raGZKBICrDiBk7FEKLLUSeLVS5Yw5ykQRGCko6K5Fz7ADX/SWjUg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6605.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(396003)(39860400002)(136003)(346002)(451199021)(6512007)(6506007)(38100700002)(2616005)(41300700001)(6486002)(186003)(26005)(966005)(83380400001)(71200400001)(478600001)(110136005)(4744005)(54906003)(122000001)(66446008)(91956017)(6636002)(66556008)(64756008)(66476007)(76116006)(66946007)(316002)(82960400001)(2906002)(8676002)(8936002)(5660300002)(4326008)(86362001)(38070700005)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UW9xaHVnL3ZPRkcyLy9MaURZUXRhVU5iUmsvS3F3NjlCTmtxWmxtRDVrbE1F?=
 =?utf-8?B?QUxac0ZyU082cnplVHZ1VklVSjgvbFVhZWdSODdlVUhuN2tZVVB0Q0JuNVZ2?=
 =?utf-8?B?M2JKVGk3bWdpQ3hGbSthR2VFMEJvNnNvbS9LZUY4bXROYVBHeGlRUzR1bGMz?=
 =?utf-8?B?Qjk4NnRDQTlDQVRuRzA3S0d4clVwVHNNMERuNGhhRDI0cUhYVk1mb2sxZ1lp?=
 =?utf-8?B?RHRscmtmSFJnNlc0NDh6TGhGaDg3aWdzTTd6YlBGMmxrVzV5Q01QYksvU1Zu?=
 =?utf-8?B?eXlSZ1NHTUtSSWlmU2tINXFqM2lnQktQSUl1NjJ4clNkc2REWmwvVHZ2dHZZ?=
 =?utf-8?B?RU1IVGtFNDh3YS9yaDBJV3o0Wnd5cFhHM3J2UUhlNDNLczBoNU1PM0lKV0g1?=
 =?utf-8?B?TW1qNWRsK2xpRDNSUTJTeFEwaXFnQkFUS1RDNU9SUHptUkhoZlovTXFUdHg3?=
 =?utf-8?B?WVNIdHFuNjBVZHVINk1SZjA3YTNKVEthOHRvaWREMnJBNHA0VE9zR0JTUFhF?=
 =?utf-8?B?TDRPNWtTcFpIOWp1Ykt1KzJWSGVzOE5jcnZ1WVlBb0hzYktDNnpZTVl4MHBL?=
 =?utf-8?B?SG1tczRYdVJicnl0STZ2VDVQOFZobENLNFFDQWhISkVTQTlDS09zRTI1dzZF?=
 =?utf-8?B?Mmg3NjhrT3Nnd3ZMRkwveTFzeUhjZ2JWWEIyamgzc0JRMkc2SS9JS3BqL3dE?=
 =?utf-8?B?Z0J3MkZ4dkZEVjltZkZoc2swUm4xcGFaUnloaXFsREVJV00vVDNDN1lWUnZk?=
 =?utf-8?B?ZXBTRGxmZStiaVhiQkZpYUVxNXprdU9mdEh3YnRiNHQrU09SNWlKWVIrWG9s?=
 =?utf-8?B?ellmaVRkdFdHT1RrU2xMdTUweGF5dm9RaXAxSHViR2R0aG5maUY4U2ljeitH?=
 =?utf-8?B?YlVuU1JPUmdIQVBweVpzbjBqRlVqbE9MR0hXWjBWZFJQK1RQZ3FqQXdtVEtw?=
 =?utf-8?B?NThkM0g0bm9taS9YaDBkU3R5UlRldklaNHpQa2tNY1NMMWZQbmlqRURpbGFr?=
 =?utf-8?B?cit4Z3Jjd3oyRHVxWVpLQU8wK2RORkt6RkJ2cW85akhNQW5Cd2krdmlqV3kx?=
 =?utf-8?B?QVFoc013WlJQRS9UR0N0L1IvYmVWell5UkhTaDUwckVZcjZCLzR5SWRhdWxN?=
 =?utf-8?B?MVQrK2lKQ2NGTW9Xd3doeC93MHcxbkM3VVdNMGJPNG9WT2VoN0k2SmV3cUEx?=
 =?utf-8?B?RUw0dGd6OG45T3FYMEF6V1NzSUIzSTVDTTRCRUl1anQ0Q0pqMWJ2aWtyWjBj?=
 =?utf-8?B?bUxnQ3VxOTBoTE5hU1dyMjM1UHVIS3FxcnRhWXhieVVOQzk2NnRiQ3NIYWNW?=
 =?utf-8?B?UmhKVVg5UUIyZmtuRTJUQlBvTFgvRzB6aHhaMG1XbkI2YllDRHhJSGdqbnVY?=
 =?utf-8?B?UzMvYm4rWTl1UFAzK2ZBU2xNVVZwRjZ0SldTYVppZzB4bGxLVDdKWHd1ZjF3?=
 =?utf-8?B?QkZsSDgrTTBiSTlhbm51cTV4ejFIejFkRlJRaW9SU054SzNqRFNLQWs1MGRk?=
 =?utf-8?B?R3A5WC9DRnpMdS90VmhWVnhMb1BVYnpWK1ZNQnJNUHJBTk4rYWpueGZUblJB?=
 =?utf-8?B?d3JvWXMzaGlCU3NMeWJqWjViU1ZOUUVrWGx1UWlkR0JlbVhub2ZYWTl1MDhi?=
 =?utf-8?B?WDVnem56ZjRNZWZQdm5xZXVlZWt1UUlYMGpTTjdrOElPU3N1TThlZjhxaWV6?=
 =?utf-8?B?VWdFYUVGOWovYnRzTnpzNE1ITlRvSHhjaHFrRU5qZzUvSjkvdG9NRlBSS29V?=
 =?utf-8?B?c3pTTTgrU0RSZ1BBL2pWWmhaYkhIVGdBU0pJZytkcFNYbm4wYkZ5Um9VZFc2?=
 =?utf-8?B?SWhuWUNjS29OQi9KWVFpMHRLUUJmUVVremRsL2FQNTJ6cEgvdVQxMkdMMW9O?=
 =?utf-8?B?dzJld2tIUGE4cTNoUnNGSGYyclZpb005WnR0U1liRUVndzJrOFNBYUptcVpW?=
 =?utf-8?B?Um9QMXhzaUVOcVp6aE1aWFBhemxJV0VhUHRRdnVFMmFhUXdBdkhycXpYQng5?=
 =?utf-8?B?dlFrYmdNNkNONTJuRlpqYzFVWDRBWG5xb3JaTi9pMS9kL3FHZ1RrcUFhMWdZ?=
 =?utf-8?B?MVRpRXhzNEIrdjZqWnVVcm9jaTJRcmZDbWJnL09MN2RXd0FZSXJGaitCVkN1?=
 =?utf-8?B?enhpZE8yUzQ2MFArTnVLQnNjL3RWbi9kWUh0SUd5eFQyb0hXYTdXV1Z1dGpT?=
 =?utf-8?B?aVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <72E8F73B8E43A34E902CC8A3DFD2C9D8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6605.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b56cdf4-b5d7-4dcd-7233-08db66fe1d2d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2023 02:23:00.0166
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XU5691xwVRaM0hYI+5FTf++5fwGy1ABIcJR796iE6y3XGOJZK+VMO1WXMlPCNn/Zyv738XLylPQxdbanhKu84w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6915
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIzLTA2LTA2IGF0IDIzOjQ1ICswODAwLCBrZXJuZWwgdGVzdCByb2JvdCB3cm90
ZToNCj4gSGkgWmhhbmcsDQo+IA0KPiBrZXJuZWwgdGVzdCByb2JvdCBub3RpY2VkIHRoZSBmb2xs
b3dpbmcgYnVpbGQgZXJyb3JzOg0KPiANCj4gW2F1dG8gYnVpbGQgdGVzdCBFUlJPUiBvbiByYWZh
ZWwtcG0vbGludXgtbmV4dF0NCj4gW2Fsc28gYnVpbGQgdGVzdCBFUlJPUiBvbiBuZXh0LTIwMjMw
NjA2XQ0KPiBbY2Fubm90IGFwcGx5IHRvIGxpbnVzL21hc3RlciB2Ni40LXJjNV0NCj4gW0lmIHlv
dXIgcGF0Y2ggaXMgYXBwbGllZCB0byB0aGUgd3JvbmcgZ2l0IHRyZWUsIGtpbmRseSBkcm9wIHVz
IGENCj4gbm90ZS4NCj4gQW5kIHdoZW4gc3VibWl0dGluZyBwYXRjaCwgd2Ugc3VnZ2VzdCB0byB1
c2UgJy0tYmFzZScgYXMgZG9jdW1lbnRlZA0KPiBpbg0KPiBodHRwczovL2dpdC1zY20uY29tL2Rv
Y3MvZ2l0LWZvcm1hdC1wYXRjaCNfYmFzZV90cmVlX2luZm9ybWF0aW9uXQ0KPiANCj4gdXJsOsKg
wqDCoA0KPiBodHRwczovL2dpdGh1Yi5jb20vaW50ZWwtbGFiLWxrcC9saW51eC9jb21taXRzL1po
YW5nLVJ1aS9wb3dlcmNhcC1pbnRlbF9yYXBsLUZpeC1DT05GSUdfSU9TRl9NQkktZGVwZW5kZW5j
eS8yMDIzMDYwNi0yMjAyMjINCg0KVGhpcyBpcyBhIGZhbHNlIGFsYXJtIGZyb20gdGhlIHJvYm90
Lg0KSXQgYXBwbGllZCBBcm5kJyBwYXRjaCBmaXJzdCBhbmQgdGhlbiBhcHBsaWVkIHRoaXMgcGF0
Y2ggb24gdG9wLg0KDQpJIHRoaW5rIHdlIGNhbiBpZ25vcmUgdGhlIGxrcCByb2JvdCB3YXJuaW5n
cyBmb3IgdGhpcyB0aHJlYWQuDQoNCnRoYW5rcywNCnJ1aQ0K
