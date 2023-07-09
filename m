Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D963374C45B
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 15:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbjGIN1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 09:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjGIN1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 09:27:40 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF8BF138;
        Sun,  9 Jul 2023 06:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688909258; x=1720445258;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=B9gFB3//5g9ltIwzP7tcxiWttRXYuejy2lgx8xf9KpM=;
  b=YYxTAH4a/exYGuWbYnOCILELDkw0CbxlIw1zUlWf7DMDzMYkeZEby+Om
   RlHlWPka1hREepaFeXyYGymWoq4/kGGyqHAA3I8GjJUhJIY7OjWXgXbQ4
   C716dSseQ3A0ZoopJ/1xcV0qRW2DPSonqph5N05AUlZMAPXSDxv3GGYW/
   ha8onhHkVw075G0didcafucJJwXtfCwn3rCS+0Bme3ei8p7ISXRpeJAaF
   HY8dCinc5V/iZmdg3ULp8a1I6P3apJ+x+FZ4ux1OYjW/yDmKm6pOJN5Ob
   vz1uezGN1UtVnCsATUCKCTOeRF/EfNb8aG8COcO2Nyet88Y4nmdF6+FC9
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="450527572"
X-IronPort-AV: E=Sophos;i="6.01,192,1684825200"; 
   d="scan'208";a="450527572"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2023 06:27:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="865056141"
X-IronPort-AV: E=Sophos;i="6.01,192,1684825200"; 
   d="scan'208";a="865056141"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP; 09 Jul 2023 06:27:38 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 9 Jul 2023 06:27:37 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Sun, 9 Jul 2023 06:27:37 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Sun, 9 Jul 2023 06:27:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WN6JKU5yD9wL/GO5SuPuVhtVhF8EcXiCGMmRk/ejvuVXEUpN2uqLPaZxlCKgDtF4rCDyHdJ0pn+hb9gp345TfHUyjqGOqoo0EtpPcIPiJ3qbqNJXjVjrfQNqT1N8RbUpRlaJZejABKn2lBmk2zuXejwknnZIA57kwW/NtE0XY/oJddjSdlmvrInCvEyomj3V4Fj6oz3FXBlJ4A9HSl5dp11XZj1/AEGlddLUTy/HG8KsyfkcTohi7TI3Vt/dzCDPNKMbmWjaOuFvKGl1yT4t3Wr6rsn5K0FEkfLW0JSrJHQ65iN+MfohkQPbFSZ7D9nz/gYYvciMr8W9pyVhOihf1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B9gFB3//5g9ltIwzP7tcxiWttRXYuejy2lgx8xf9KpM=;
 b=IkA/XnOrSl+f1KLRLGtD+2asi2gYOpoUrirk+jVHUcFuc6yXCdxZSIhfKRegYfntPWWImHSdMszjkSME7jDIJ8oJqyzanJD/Qu2fTlZ1OPsiApt53YqylG1VoGNrY8wW7tp+tukXct92xldJGjZtfEkNaWDQ+N3wFXXpO16cVB3qmwvUqjSxYbq1dWQcv9dacK+npL/cC744WVir0F25fkuw4BtjusRlTL1e/Gn/gx0d0kf7XtwRNd/eZBrsMdttF6yYs7a8IEDhg+oGNRNnpDvxHKoHB5l484VqgJaErpofH8AWgb9qd1UNaLlq6c+WvmDL/llCdGkKzXMgE7fSog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by PH8PR11MB7096.namprd11.prod.outlook.com (2603:10b6:510:214::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Sun, 9 Jul
 2023 13:27:34 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::9932:938f:1d21:93cb]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::9932:938f:1d21:93cb%4]) with mapi id 15.20.6565.026; Sun, 9 Jul 2023
 13:27:33 +0000
From:   "Zhang, Rui" <rui.zhang@intel.com>
To:     "Greenman, Gregory" <gregory.greenman@intel.com>,
        "Berg, Johannes" <johannes.berg@intel.com>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
CC:     "bagasdotme@gmail.com" <bagasdotme@gmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "kvalo@kernel.org" <kvalo@kernel.org>,
        "Baruch, Yaara" <yaara.baruch@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "Ben Ami, Golan" <golan.ben.ami@intel.com>,
        "edumazet@google.com" <edumazet@google.com>,
        "Sisodiya, Mukesh" <mukesh.sisodiya@intel.com>,
        "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>
Subject: Re: [Regression][BISECTED] kernel boot hang after 19898ce9cf8a
 ("wifi: iwlwifi: split 22000.c into multiple files")
Thread-Topic: [Regression][BISECTED] kernel boot hang after 19898ce9cf8a
 ("wifi: iwlwifi: split 22000.c into multiple files")
Thread-Index: AQHZsKyQVsJac0DEX0yOQldskAnw0a+uIaoAgAHK8YCAAYRGAA==
Date:   Sun, 9 Jul 2023 13:27:33 +0000
Message-ID: <4153ce0aac6dc760a3a9c7204c5c9141b60839a4.camel@intel.com>
References: <b533071f38804247f06da9e52a04f15cce7a3836.camel@intel.com>
         <a4265090-d6b8-b185-a400-b09b27a347cc@leemhuis.info>
         <c65d0837-5e64-bec7-9e56-04aa91148d05@leemhuis.info>
In-Reply-To: <c65d0837-5e64-bec7-9e56-04aa91148d05@leemhuis.info>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|PH8PR11MB7096:EE_
x-ms-office365-filtering-correlation-id: 2540b05a-916f-4507-0f7f-08db808040e8
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FyjGziEJACTIVFROsPmGuLbvGqu0dJ1wLtIWFHCWHbtnO3pGOmNo5aLQUo3Ev7PwNuH2TlzMYMNXBo27B2qochRoQi2JjIW/JLc0U5qba2t+WYMWCed8dujaRfiVzHKhbinnpcvFiTmG2UloNz9WThOc0aVLcWuG/S0Jes+EzxuZCeq6znkvN6CVjZn85xn//YRL+o/2fk+ZtDyyg+OrPELFYmG27ZbypVdWTHszvljZl4q98FCBfnBxl6Db0DFUCCHnEzya35++qpMbo85jeRKlDKxFNLx4ncmm9vjXW9lKQL6k324kCgcO4L43MT8uxCHmEbHNRoiIg9jIIKS/Y200jDAWWlNVJsop/2ZnZ8O3z/ipWGqgrNeIXq0tv6OQg0VFjvo2reQPnJa7mYzCggcmAN3qjCrP9a1Uwp9+sIr8SbxsBXYSqeO/nz6ZsJs5IVw0JtEUJCUeBQbg4BEwhWWCpFeOoVaOyomrmNGSFTvaYwj5AYBV+EVEEoGXnYa5evHSCtCMkZrs1xn/nxzpoBJ+QO6+XUEsY76sAA6Jdcz/KYtliWXH+FKT5+8fK0gOCH6BcdZ8nn+xjuHjoXQMuiWQKU757pOZcEyVmRTjiLMsXkS9yRKP5NEdVSyXexsg2vBMO77fIt19/tEDzhh1Fg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(136003)(346002)(366004)(376002)(451199021)(478600001)(6486002)(186003)(82960400001)(66476007)(6512007)(26005)(966005)(53546011)(6506007)(86362001)(2616005)(71200400001)(316002)(83380400001)(38100700002)(54906003)(91956017)(64756008)(110136005)(4326008)(66556008)(76116006)(66446008)(66946007)(122000001)(7416002)(5660300002)(8676002)(38070700005)(8936002)(41300700001)(2906002)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eFk1RExHdzF3ZnI2ektEOHZ1TXh3VFpFY24raHh6aFJZZWtlaDV6Rnhrb2lV?=
 =?utf-8?B?L293aEk1TlgyU01Qc1RVa3JGNDNnSUdhRGtIVGtRY3E0djc3Y0NPL2tzOHlM?=
 =?utf-8?B?SVhDeVlaK3VQN3ByL3puallZVlNCMlJRVUpoQWlEZ0c1YWJuNHp6MHlBSEhp?=
 =?utf-8?B?UFZ1Q3UrQUpGWGRyRS9wQ1NVTzRvNnJRRnQ5dVgySDFrdENmcm1wM0ZhOXVa?=
 =?utf-8?B?M3lLSWhRd0JoZGk0RkNGL3l6Ykc4TXF6UW1lT1A0TmxmclkwRTh2akc2N0p6?=
 =?utf-8?B?bHVqbHg4cENWZUNUeDltcWR0RWtEK0hBbU0zNWhJZXJVN0cvL0Z2bTFUTzhB?=
 =?utf-8?B?WU9KVVpXUEdsbk4zVlFPNHpQNnhZd3g1Y2hKTUlZOXJZYVRXNjJGUzVoWUtX?=
 =?utf-8?B?N3NidE9JTHV5U0FRa0dyaUhuSE40QzA4YjF6Ly9tTDFMMmpnNkZmWGlYWnA4?=
 =?utf-8?B?RG03a2lON0xicjJraHhLdzFUMjVTbXcwV1lDY0pza3hjejRva1BPTXAyTFM5?=
 =?utf-8?B?akRuNEZXYzlxVnl5eFJoRE90RmMzUWhwOEtnY3lsNzdrRGtVT25BMU5hcldu?=
 =?utf-8?B?ekxLYzlFR3VWMmNtT3B0YWhtY2doak12OGtwNlJwSzdPTnlwSTFFMWo4SW52?=
 =?utf-8?B?b01KSVVsMm91QjNYclF6T2lrVXlHTDF2V3RyUUtKeEVzSzRzcU5hSmY0b2ZZ?=
 =?utf-8?B?Y1lrZjZrbEEvbEZ6SWg0VDduSTNyRzRzOEtGdFlGTlRNa0dnMVJrZE9sUUlE?=
 =?utf-8?B?dlBoZTlHejQyeFBiTGwwNjF1NG1vejJNZjE2SkdjVFFrWHlFL2YyQWY2ZkJ6?=
 =?utf-8?B?aUlJVU93MTRHZlVaWWozeVNsL0dnVXV1Yk9sQ2hJbDlZQ1o3NDFPY2oyci9Z?=
 =?utf-8?B?RWR2c25lYk9hM2NjTzhPcThLT1ZEdGxCUmF4WEc5RklrZHMrQTdDSHRQWEl3?=
 =?utf-8?B?QTlSSHhjeVRITERNM25VZkZKNEFGSEQraXVJTi92SkVXN2lIbEttaVVXbytn?=
 =?utf-8?B?a0ZRaHZ3a1VIVnJCNnJaSDZTWXhWdGNYTnphNGcwSXFOMmNFN1FSTWR2TkRF?=
 =?utf-8?B?Y2RweXJpQ2FHbHNGN2NZWHowelZzc3JLcmVSSmkzR1dsbzVhSmFQWFF3VHFR?=
 =?utf-8?B?TlNiSEtEOWV2L05DM1N5cGpRckx0aFVSQW9mVDdNbXh3ZEJZN3lNOTh4dTA3?=
 =?utf-8?B?SnlIdXdYNmNZLzhJOEp1REdwOTNSNHgzL0dESGg2VDc3ekdKbXFFUi9TTGpl?=
 =?utf-8?B?aE1BTU0rNXFuUmxSYjhGYTFuSzZWTUxuMko3Vi8rRlE4Rm5NU1FjcVZ2UXlR?=
 =?utf-8?B?RUp4YjJsc0o3RWh4RGFjeXZTMmRkUXFMY2xqTy8rOE5KdEhWcSt0b3BjV0pj?=
 =?utf-8?B?YUxVd3MvR2JUcGRMajlPRDNtUUxFZ2tsUXVWZDFjNWp4QTdwVlhKSUpreXI3?=
 =?utf-8?B?c0Z0aXFxSVpVT1Z2SUxYVGlsWlN4Rm1ydlhUVVd4d0RFdE0yYVU0b2hMSVdp?=
 =?utf-8?B?WEl3T1ZTakY5bjQvQ0xDYVZyL09BYk5KeU04azBlZE83TExwTEM3blpBdTVD?=
 =?utf-8?B?Qk8waURrQmtIVGNDUVlaeHBuUXp6Z3YzQ0V5MThSRnlWVVp0Q2ZYc2JybmZX?=
 =?utf-8?B?c3lpZTBoWW1EcnludHk3SmhxQ044WHpEVGdVSDJyaFYyMGFqQnBSajZsNEtL?=
 =?utf-8?B?aUhHMzBKaXd4WmhiWnplWHpSNGlUV21RT2d2U3c3SWNOSmxUTkFHR0RIUzh3?=
 =?utf-8?B?MW10MDBrNW9ldG4wdThTQkEyL1U4WTlGUXgrM1dndEJib0J6eTE0YUdOUmtT?=
 =?utf-8?B?S3pYT0Y2OXBQckMra1pjYVlCYXZJakFrMlUxSmRYSXQ3YmkzN2R5Q1JXeENQ?=
 =?utf-8?B?QllLdEM1WVB1b3ovMG5vRmFQSkpDby91Tm1OTDZSWDM3czl3SEdma1dJZmF4?=
 =?utf-8?B?SStiRldMcU9aV2VYNUo0Wk02RmVNNEJyQmhTL3FGbmRjbkQ3TnJDVVRxczJX?=
 =?utf-8?B?amdpeFRVQXFiZlpOc3lkWWtxRW1XVHlkdG1TL3ZnNXBZRDBZeUtlNVlIb2lS?=
 =?utf-8?B?UmFGT3F6QkFJNnk5QS8xdDhIcmcyU2MyNGlGRHo1ZDZLQ1o0REYyUW44ZlVI?=
 =?utf-8?Q?gQtNy5r05rRkLcczFHu79Th2b?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B0744E920DBA684685DDC23B1A053F6B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2540b05a-916f-4507-0f7f-08db808040e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2023 13:27:33.6028
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e/GYuMm+6xc2B9msJy60YhpAfUvB0/9crjAjfDvh0+IbIn3XuK3r2+uWYwGPvZi/lf5Zvp6M+DTg1JqV6yHv6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7096
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0LCAyMDIzLTA3LTA4IGF0IDE2OjE3ICswMjAwLCBUaG9yc3RlbiBMZWVtaHVpcyB3cm90
ZToNCj4gT24gMDcuMDcuMjMgMTI6NTUsIExpbnV4IHJlZ3Jlc3Npb24gdHJhY2tpbmcgKFRob3Jz
dGVuIExlZW1odWlzKQ0KPiB3cm90ZToNCj4gPiBPbiAwNy4wNy4yMyAxMDoyNSwgWmhhbmcsIFJ1
aSB3cm90ZToNCj4gPiA+IA0KPiA+ID4gSSBydW4gaW50byBhIE5VTEwgcG9pbnRlciBkZXJlZmVy
ZW5jZSBhbmQga2VybmVsIGJvb3QgaGFuZyBhZnRlcg0KPiA+ID4gc3dpdGNoaW5nIHRvIGxhdGVz
dCB1cHN0cmVhbSBrZXJuZWwsIGFuZCBnaXQgYmlzZWN0IHNob3dzIHRoYXQNCj4gPiA+IGJlbG93
DQo+ID4gPiBjb21taXQgaXMgdGhlIGZpcnN0IG9mZmVuZGluZyBjb21taXQsIGFuZCBJIGhhdmUg
Y29uZmlybWVkIHRoYXQNCj4gPiA+IGNvbW1pdA0KPiA+ID4gMTk4OThjZTljZjhhIGhhcyB0aGUg
aXNzdWUgd2hpbGUgMTk4OThjZTljZjhhfjEgZG9lcyBub3QuDQo+ID4gDQo+ID4gRldJVywgdGhp
cyBpcyB0aGUgZm91cnRoIHN1Y2ggcmVwb3J0IGFib3V0IHRoaXMgdGhhdCBJJ20gYXdhcmUgb2Yu
DQo+ID4gDQo+ID4gVGhlIGZpcnN0IGlzIHRoaXMgb25lICh3aXRoIHR3byBhZmZlY3RlZCB1c2Vy
cyBhZmFpY3MpOg0KPiA+IGh0dHBzOi8vYnVnemlsbGEua2VybmVsLm9yZy9zaG93X2J1Zy5jZ2k/
aWQ9MjE3NjIyDQo+ID4gDQo+ID4gVGhlIHNlY29uZCBpcyB0aGlzIG9uZToNCj4gPiBodHRwczov
L2xvcmUua2VybmVsLm9yZy9hbGwvQ0FBSndfWnVnNlZDUzVacVRXYUZTcjlzZDg1ayUzRHR5UG05
REVFJTJCbVYlM0RBS29FQ1pNJTJCc1FAbWFpbC5nbWFpbC5jb20vDQo+ID4gDQo+ID4gVGhlIHRo
aXJkOg0KPiA+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC85Mjc0ZDliZDNkMDgwYTQ1NzY0
OWZmNWFkZGNjMTcyNmYwOGVmNWIyLmNhbWVsQHhyeTExMS5zaXRlLw0KPiA+IA0KPiA+IEFuZCBp
biB0aGUgcGFzdCBmZXcgZGF5cyB0d28gcGVvcGxlIGZyb20gRmVkb3JhIGxhbmQgdGFsa2VkIHRv
IG1lDQo+ID4gb24gSVJDDQo+ID4gd2l0aCBwcm9ibGVtcyB0aGF0IGluIHJldHJvc3BlY3RpdmUg
bWlnaHQgYmUgY2F1c2VkIGJ5IHRoaXMgYXMNCj4gPiB3ZWxsLg0KPiANCj4gSSBnb3QgY29uZmly
bWF0aW9uOiBvbmUgb2YgdGhvc2UgY2FzZXMgaXMgYWxzbyBjYXVzZWQgYnkgMTk4OThjZTljZjhh
DQo+IEJ1dCBJIHdyaXRlIGZvciBhIGRpZmZlcmVudCByZWFzb246DQo+IA0KPiBMYXJyeSAobm93
IENDZWQpIGxvb2tlZCBhdCB0aGUgY3VscHJpdCBhbmQgc3BvdHRlZCBzb21ldGhpbmcgdGhhdA0K
PiBsb29rZWQNCj4gc3VzcGljaW91cyB0byBoaW07IGhlIHBvc3RlZCBhIHBhdGNoIGFuZCBsb29r
cyBmb3IgdGVzdGVyczoNCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzAwNjhhZjQ3LWU0
NzUtN2U4ZC1lNDc2LWMzNzRlOTBkZmY1ZkBsd2Zpbmdlci5uZXQvDQoNCkkgYXBwbGllZCB0aGlz
IHBhdGNoIGJ1dCB0aGUgcHJvYmxlbSBzdGlsbCBleGlzdHMuDQoNCnRoYW5rcywNCnJ1aQ0KPiAN
Cj4gQ2lhbywgVGhvcnN0ZW4NCj4gDQo+ID4gVGhpcyBtYW55IHJlcG9ydHMgYWJvdXQgYSBwcm9i
bGVtIGF0IHRoaXMgc3RhZ2Ugb2YgdGhlIGN5Y2xlIG1ha2VzDQo+ID4gbWUNCj4gPiBzdXNwZWN0
IHdlJ2xsIHNlZSBhIGxvdCBtb3JlIG9uY2UgLXJjMSBpcyBvdXQuIFRoYXQncyB3aHkgSSByYWlz
aW5nDQo+ID4gdGhlDQo+ID4gYXdhcmVuZXNzIG9mIHRoaXMuIFNhZGx5IGEgc2ltcGxlIHJldmVy
dCBvZiBqdXN0IHRoaXMgY29tbWl0IGlzIG5vdA0KPiA+IHBvc3NpYmxlLiA6LS8NCj4gPiANCj4g
PiBDaWFvLCBUaG9yc3Rlbg0KPiA+IA0KPiA+ID4gY29tbWl0IDE5ODk4Y2U5Y2Y4YTMzZTBhYzM1
Y2I0YzdmNjhkZTI5N2NjOTNjYjIgKHJlZnMvYmlzZWN0L2JhZCkNCj4gPiA+IEF1dGhvcjrCoMKg
wqDCoCBKb2hhbm5lcyBCZXJnIDxqb2hhbm5lcy5iZXJnQGludGVsLmNvbT4NCj4gPiA+IEF1dGhv
ckRhdGU6IFdlZCBKdW4gMjEgMTM6MTI6MDcgMjAyMyArMDMwMA0KPiA+ID4gQ29tbWl0OsKgwqDC
oMKgIEpvaGFubmVzIEJlcmcgPGpvaGFubmVzLmJlcmdAaW50ZWwuY29tPg0KPiA+ID4gQ29tbWl0
RGF0ZTogV2VkIEp1biAyMSAxNDowNzowMCAyMDIzICswMjAwDQo+ID4gPiANCj4gPiA+IMKgwqDC
oCB3aWZpOiBpd2x3aWZpOiBzcGxpdCAyMjAwMC5jIGludG8gbXVsdGlwbGUgZmlsZXMNCj4gPiA+
IMKgwqDCoCANCj4gPiA+IMKgwqDCoCBTcGxpdCB0aGUgY29uZmlndXJhdGlvbiBsaXN0IGluIDIy
MDAwLmMgaW50byBmb3VyIG5ldyBmaWxlcywNCj4gPiA+IMKgwqDCoCBwZXIgbmV3IGRldmljZSBm
YW1pbHksIHNvIHdlIGRvbid0IGhhdmUgdGhpcyBodWdlIHVudXNhYmxlDQo+ID4gPiDCoMKgwqAg
ZmlsZS4gWWVzLCB0aGlzIGR1cGxpY2F0ZXMgYSBmZXcgc21hbGwgdGhpbmdzLCBidXQgdGhhdCdz
DQo+ID4gPiDCoMKgwqAgc3RpbGwgbXVjaCBiZXR0ZXIgdGhhbiB3aGF0IHdlIGhhdmUgbm93Lg0K
PiA+ID4gwqDCoMKgIA0KPiA+ID4gwqDCoMKgIFNpZ25lZC1vZmYtYnk6IEpvaGFubmVzIEJlcmcg
PGpvaGFubmVzLmJlcmdAaW50ZWwuY29tPg0KPiA+ID4gwqDCoMKgIFNpZ25lZC1vZmYtYnk6IEdy
ZWdvcnkgR3JlZW5tYW4gPGdyZWdvcnkuZ3JlZW5tYW5AaW50ZWwuY29tPg0KPiA+ID4gwqDCoMKg
IExpbms6DQo+ID4gPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIwMjMwNjIxMTMwNDQzLjc1
NDM2MDNiMmVlNy5JYThkZDU0MjE2ZDM0MWVmMWRkYzA1MzFmMmM5YWEzMGQzMDUzNmE1ZEBjaGFu
Z2VpZA0KPiA+ID4gwqDCoMKgIFNpZ25lZC1vZmYtYnk6IEpvaGFubmVzIEJlcmcgPGpvaGFubmVz
LmJlcmdAaW50ZWwuY29tPg0KPiA+ID4gDQo+ID4gPiBJIGhhdmUgc29tZSBzY3JlZW5zaG90cyB3
aGljaCBzaG93IHRoYXQgUklQIHBvaW50cyB0bw0KPiA+ID4gaXdsX21lbV9mcmVlX3NrYiwNCj4g
PiA+IEkgY2FuIGNyZWF0ZSBhIGtlcm5lbCBidWd6aWxsYSBhbmQgYXR0YWNoIHRoZSBzY3JlZW5z
aG90cyB0aGVyZQ0KPiA+ID4gaWYNCj4gPiA+IG5lZWRlZC4NCj4gPiA+IA0KPiA+ID4gQlRXLCBs
c3BjaSBvdXRwdXQgb2YgdGhlIHdpZmkgZGV2aWNlIGFuZCBnaXQgYmlzZWN0IGxvZyBhdHRhY2hl
ZC4NCj4gPiA+IA0KPiA+ID4gSWYgYW55IG90aGVyIGluZm9ybWF0aW9uIG5lZWRlZCwgcGxlYXNl
IGxldCBtZSBrbm93Lg0KPiA+IA0KPiA+IC0tDQo+ID4gRXZlcnl0aGluZyB5b3Ugd2FubmEga25v
dyBhYm91dCBMaW51eCBrZXJuZWwgcmVncmVzc2lvbiB0cmFja2luZzoNCj4gPiBodHRwczovL2xp
bnV4LXJlZ3RyYWNraW5nLmxlZW1odWlzLmluZm8vYWJvdXQvI3RsZHINCj4gPiBUaGF0IHBhZ2Ug
YWxzbyBleHBsYWlucyB3aGF0IHRvIGRvIGlmIG1haWxzIGxpa2UgdGhpcyBhbm5veSB5b3UuDQo+
ID4gDQo+ID4gUC5TLjogZm9yIHJlZ3pib3QNCj4gPiANCj4gPiAjcmVnemJvdCBeaW50cm9kdWNl
ZCAxOTg5OGNlOWNmOGENCj4gPiAjcmVnemJvdCBkdXAtb2Y6DQo+ID4gaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvYWxsL2E1Y2RjN2Y4LWIzNDAtZDM3Mi0yOTcxLTBkMjRiMDFkZTIxN0BnbWFpbC5j
b20vDQoNCg==
