Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EECA6B7FA8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 18:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbjCMRmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 13:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbjCMRmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 13:42:51 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70DA96C689
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 10:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678729371; x=1710265371;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rzbDXWosBok7WouJsharnuMVlZFzUoKx25OjnU/PPiU=;
  b=Kc5aoGK2+V4CLaM7xam5Dh1kz736ePhnlXVfjvR7LbQr0whDN3orQUCx
   6MqFa7HJhz7HmTalYmfpVF74dFagMWHMYJ2cbw+nA0BIR/ooWYoJQQtNG
   Ag1kqb9aLiRyS7u759gCl4egueQcPWF//ZnnButVS1O+ybzMoDg32GcsW
   /MIwce+ZOwCoP6uYdFENfeUQfataf/Tj9O/QYeayqV9NsjyYOYrsKm/nA
   rCTWxXDCFVKr+9qk2bmQmDIKS5dWVFuU/1H7xbeMwOyZAA5bU4Z7FFgfk
   btsRwXwrY0XbL9zmGShBkSEIlo0jw2uhzE4e5EaQ4Xep8zAoHAXiQ+Uhe
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="334692390"
X-IronPort-AV: E=Sophos;i="5.98,257,1673942400"; 
   d="scan'208";a="334692390"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 10:42:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="708965403"
X-IronPort-AV: E=Sophos;i="5.98,257,1673942400"; 
   d="scan'208";a="708965403"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga008.jf.intel.com with ESMTP; 13 Mar 2023 10:42:50 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 13 Mar 2023 10:42:50 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 13 Mar 2023 10:42:50 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 13 Mar 2023 10:42:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RKfHAaeza6d/BTMQ1F/6HBFwBTvOn3IgptBpv4bNMfvZF9DPOX1HqLsCayPlWovfwFuSvBlebmQmKZp+sQs2f6uj1TTuBPbwsPI/7PkOxWdOuvCwQuU7g8nVNT+wASmAeVeh/CwA822F0VNCymAB+0PsiDdWRP1tk9OsZ+ZIkh+mRfOzII/PtI9KHrxU7EfsJzuU03NF92ZDY34AwyhCYN+W2SP3KhZgwWVdIlIkyE4wHnmiM53b+6PAWw56XhyC9NGRME8Fxxk1pWAQgAo9SWcVj/ArFkXqNo4HVocnz0NkuRKY/0X1Y7kzJRNjHAY6LqKDx9PcaFFSJEOGWXE5Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rzbDXWosBok7WouJsharnuMVlZFzUoKx25OjnU/PPiU=;
 b=eU4Gkk4nmYgJCTrMwdTqGuWde7JFq0+yfKjWLb9++YwKjMK+alaiEULvztnQVy8lgYDDQDhQGywdFrOZzL5WO5KKB5LXkyz+xpLaUyL6BxcaHXtIDEeGp7IB8CCZoW9HIFn4W4+6O18OpA7JRAE3KZWeUiICznuK8U0lL78lGQOY5Uuj9Ypw1ZFljDyj5noGREOZvVA+4emUZHcW8XpKKh3vCYyu4zJHAIc51/Z3zVByZVJ9Zk5FkOJLMesdnjhENJuFsJ4Tid3mK9gOtiA4hiSVzXO0xk894d++WCymMDvyHLqn4T8ilwTO+cYAZ4d7Fs5dTMf7ZgqIDRC1ugj8Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6734.namprd11.prod.outlook.com (2603:10b6:806:25d::22)
 by CY8PR11MB7291.namprd11.prod.outlook.com (2603:10b6:930:9b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 17:42:46 +0000
Received: from SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::7576:1f4a:2a6c:72f7]) by SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::7576:1f4a:2a6c:72f7%2]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 17:42:46 +0000
From:   "Li, Xin3" <xin3.li@intel.com>
To:     "Hansen, Dave" <dave.hansen@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "Liu, Yujie" <yujie.liu@intel.com>,
        "Kang, Shan" <shan.kang@intel.com>
Subject: RE: [PATCH 1/1] x86/vdso: use the right GDT_ENTRY_CPUNODE for 32-bit
 getcpu() on 64-bit kernel
Thread-Topic: [PATCH 1/1] x86/vdso: use the right GDT_ENTRY_CPUNODE for 32-bit
 getcpu() on 64-bit kernel
Thread-Index: AQHZU/pnrQNA4Qs8TE+zA+Udtp/Txa74104AgAAkKCA=
Date:   Mon, 13 Mar 2023 17:42:46 +0000
Message-ID: <SA1PR11MB6734CF1607F263CB8389F5F2A8B99@SA1PR11MB6734.namprd11.prod.outlook.com>
References: <20230311084824.2340-1-xin3.li@intel.com>
 <5e84fd48-459d-8850-d26f-860c6d34a9ad@intel.com>
In-Reply-To: <5e84fd48-459d-8850-d26f-860c6d34a9ad@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB6734:EE_|CY8PR11MB7291:EE_
x-ms-office365-filtering-correlation-id: 4d082876-c6dd-427f-ab76-08db23ea5b2c
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IU09mMLSZbCqLKmsEQ2AOCLhGr8ZKK49e+pkN9OmqNek5iCti4hVwI/WLlVNAMT9YSfpjE0zf1Lp23o36k9WJ28TvY2FKecCvnuK7Sn2wgB4b+LyXp5+wJAJP0JjZqEzB880WozTA5h1hBwO1IyJ8/cRzKyaDprmgaO0zyNH/+7Unxv2oUXW57wXIK8Y6ZXMuuhlEd8BNerbaTjpZecaDYCctZZeDHbWTkgxkr4eouW9QNF+fzvzF9iZwasA4S50Eb3+8O7L1zqlW+HCsap9VOimTLkxqwp38d4zdt/SmjC1D2vGXdeKJuXkxhtO/xIMNd0PtF5med1184fNuzDWqk4I2ZAx9karPj5LAaNBdIFYnHcw4Vmdbw1zkPyavoc6ZSSFK1Xgh0RUiksO+MCc/EZisnGSyj8wo5qUQw9ZhT3cM3yH1/vzYfYSfywQsIH44VJgz5pcy4C+FixWvzOcGOO7+iOQWcX661hHdHgtfCBirJexv/qN+WjMMOOGTHMchOOu/HMO7pTO31gT2LJdyxSzf7FirQgFdYOyZDh+rLpjWGeXwqqRNhVqpepyqSy6AHJaRbPO3tUJ7sTxBo7WW/GlIeyU0gRLJahI1TnVt1znoy99JSSAbh3eegZY8JEvBIKLrf4wLcg8RzYAf45S3PsZm6QKQadUkZr2q/UH0UKBGnVl6vkOK5aalx5m8rDwjb+epltlK98fo+9rjN7m6g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6734.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(366004)(136003)(396003)(346002)(39860400002)(451199018)(7696005)(82960400001)(83380400001)(110136005)(38100700002)(316002)(478600001)(122000001)(54906003)(8936002)(186003)(33656002)(52536014)(71200400001)(55016003)(8676002)(4744005)(6506007)(9686003)(26005)(5660300002)(66446008)(4326008)(66476007)(66556008)(66946007)(76116006)(64756008)(86362001)(41300700001)(38070700005)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MXhWU2kzN3dWMjVmSkgxb29OM21Sams0S0Q3ZzNHYXljTk4vc2kwSVV6bldj?=
 =?utf-8?B?bkRYdTNkR3Rmd2pUMUVzWkxGUTBSS3lKejZPRFFxV0ZsM1E3eWg4SUVacTNx?=
 =?utf-8?B?dkpQTFd6RVBNeFNHYSs5MGdrNktNT2JJRktkcm81bldYMW14UmkzYmFZVjNr?=
 =?utf-8?B?WlpURm5uUWgxenJNYVFVZzd5K0dkaSsrelFnWURoOTVsUjZlRVFLMjVYNWU2?=
 =?utf-8?B?T2cyZnA0cG1ydElnWWxXei9yWTJ6T2xJdU0yaWdSajJZek9tR2M3bW1adFJU?=
 =?utf-8?B?YWthRURjL1RnZXdxQUF3WUhEb1NZb0JwS3dnZDh4ZkxrQjJSRnVGcXZPN2Vl?=
 =?utf-8?B?SU5wS0lRS3lHUWtrZDUvdm5GRkNzUFlnUGp3NVRiaTlMVXNhbFB6WlhEdzlO?=
 =?utf-8?B?SjdNT1JJZUxydXNMdXY5ZGpyRy9CcmdjTWExb1dmbnpyaGhxU0czWWlTOFJm?=
 =?utf-8?B?UDRhT0xYTXRsRThNRkY4M1VXUkIwYU1DYktBRHkwZ3RaN0l2T041bTlhb243?=
 =?utf-8?B?QlMyQUNpRGwxSTJjb3ZGM3l3TWVGNkxOT2ZJZG9pSzhSc0oxNmR3Q3NwNFNJ?=
 =?utf-8?B?RjJMU0x4alJrN04yb1MvRTcwdm9YNjdzem4yMTRZcWdjeWlHdGgwWDlmSHhh?=
 =?utf-8?B?Q1ViQytKQ0VXK296NDNxeWx4TjUxWTUydXRrc1Bob3p3N2lsbW5OeVVCVld0?=
 =?utf-8?B?ZFp3RENMOVdKSURQVGdoZ3E2NWFadHN2MnZ1MGRPWVZvOThIaXlrcjJoWDdR?=
 =?utf-8?B?WGlRSmdMWXd2blZRY1lHWnpROGMxSm5xTkI0VGREaW51b2Fsdy9LS3RqeDRV?=
 =?utf-8?B?L2xJOFYzRXFqUlFKcjBlOE9oRElvblIrWCs2YjkrWDUyYkl3SkswK1FTak5n?=
 =?utf-8?B?VEZQZWJadU95bzVuNXRDbDMzNTBXRnlBMGM3eEhhY2pGRjVMMGxJTTUzR1c5?=
 =?utf-8?B?WGV5R2prZWVieHdiajNGdmhUSzdFaHJMcllVeEl1SFJoQUJmaEJ5MTB4MExk?=
 =?utf-8?B?Rk9TYjJLdjV3cVE5ZnR3NjNXVlZKVmtZakRkY1ZOa29ObWhocUJSUkhnY2sz?=
 =?utf-8?B?Rld2eUxSalVNOW5WdXlzdUE3aVFCWUJyOE41ZTlabCsxY3ZGdWhwQyt6cWdr?=
 =?utf-8?B?QmYzbzhvL1ZvOXFUYzVDTW14Q3VWYzhPNCtBN2RWQWNUOGNCZC9EekplQkJi?=
 =?utf-8?B?dEZneGkxY2srNU1aSHUzTHVIMXVxWEhNMmJTNk5Pc3ova0tzVHZjbFR4SFpl?=
 =?utf-8?B?T0Y0eFByaWpPUEZoTUhmN2V5OXM2WStwSmQvbGI4eVY2L05OYjk4bmdwZGQx?=
 =?utf-8?B?c3laWE1zbTZUSGttbkl6TGJOOHFzN3FtZDRPTXBCd1NzY0tiY0ZVM2ZRU0FM?=
 =?utf-8?B?bktKTVdjZVQwL05yb2lIaFR3OXRHV1k2ZStoSVlNNE5wOWJxdEJwNDJVQXpn?=
 =?utf-8?B?Z2x1TkpIRnJ3QUxpZFNVZDd3NDVnU3YwMWRjSkMraC90ZGF2OHNnelpGaXds?=
 =?utf-8?B?Q1pxd0ZCOWpGREMwYW1mcXA3ZHUxNnIzbzd0R2VLVmxPdllZa2c5WDNOUXhz?=
 =?utf-8?B?VkVrWXJYVXp6WjdlVVJyczN0VVNhcnJDRGgxN01jem9HQzlWTHE0MEg5alZk?=
 =?utf-8?B?U2NyTXdpWE1NdEtYTUN3eWJielBYRndpM2ZjNVVNSjBwTzE5MzNjUVpXcWp3?=
 =?utf-8?B?Nm9vU09vN1NWdEF3cStyMHp5Ym16Q3NKM2kvY3J1TlluUU9vTHBEcXNtNEtx?=
 =?utf-8?B?ZHQ2VUdCMmxpR1B2UHZCQnFtMENua01hZnZEVVR2bk5XcHB0cXZ6OXhDRHRH?=
 =?utf-8?B?MjJwcFVhamVRalVTVG5ScTVBOVRRZjRBTVRWblhVRFNxL2JBdnRvNnZnaXBQ?=
 =?utf-8?B?NmFQNkdBWW5VY2N5S1pFZXB6Ulg1RHhnNnBSa0xlcjFHVkVYNk9yY3hJVHRw?=
 =?utf-8?B?cTZ4bm9hLy9Wc1oySm53TTUwRGJzK0V2OHYzYm1hcUJxTmZWamZxWVdkN2Ri?=
 =?utf-8?B?T0NYSEdzNmN3QnlxSGhsN2lkbVRNbTBqQmVVdmVudFNaRUpXR093Z05xbFhx?=
 =?utf-8?B?bXNvZkdMMHU0Q3p3REVVeU9jV1JjOWtEemV5V2NFZFBVWithd05Ea0xDY3FB?=
 =?utf-8?Q?Mwjk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6734.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d082876-c6dd-427f-ab76-08db23ea5b2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2023 17:42:46.1717
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DW9LKNFvxJC/FOg5nnEGiipLb/6GcpLwGXZ3egGRuIz9GMwkqQtvf/fEXDqveZYjri2gw2cR9IjkLmVUD92ssg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7291
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+ICsjaWZuZGVmIEJVSUxEX1ZEU08zMl82NA0KPiA+ICAjZGVmaW5lIEdEVF9FTlRSWV9DUFVO
T0RFCQkyOA0KPiA+ICsjZWxzZQ0KPiA+ICsjZGVmaW5lIEdEVF9FTlRSWV9DUFVOT0RFCQkxNQ0K
PiA+ICsjZW5kaWYNCj4gDQo+IElzbid0IHRoaXMga2luZGEgYSBoYWNrPw0KPiANCj4gRmlyc3Qs
IGl0IG1lYW5zIHRoYXQgd2UnbGwgbm93IGhhdmUgdHdvIGR1cGxpY2F0ZSB2ZXJzaW9ucyBvZiB0
aGlzOg0KPiANCj4gCSNkZWZpbmUgR0RUX0VOVFJZX0NQVU5PREUJCTE1DQo+IA0KPiBpbiB0aGUg
c2FtZSBmaWxlLg0KPiANCj4gU2Vjb25kLCBpZiBhbnkgb3RoZXIgdXNlcnMgb2YgZmFrZV8zMmJp
dF9idWlsZC5oIGZvciB0aGUgVkRTTyBzaG93IHVwLCB0aGV5J2xsDQo+IG5lZWQgYSBzaW1pbGFy
ICNpZmRlZi4NCj4gDQo+IEkgdGhpbmsgSSdkIG11Y2ggcmF0aGVyIGlmIHdlIGRlZmluZSBhbGwg
b2YgdGhlIEdEVF9FTlRSWV8qIG1hY3JvcyBpbg0KPiAqb25lKiBwbGFjZSwgdGhlbiBtYWtlIHRo
YXQgKm9uZSogcGxhY2UgZGVwZW5kIG9uIEJVSUxEX1ZEU08zMl82NC4NCg0KU291bmRzIGEgYmV0
dGVyIHdheSwgbGV0IG1lIHRyeS4NCg0KPiBBbHNvLCBhYm91dCB0aGUgKnNpbGVudCogZmFpbHVy
ZS4uLiAgRG8gd2Ugbm90IGhhdmUgYSBzZWxmdGVzdCBmb3IgdGhpcyBzb21ld2hlcmU/DQoNCldo
ZW4gbHNsIGlzIHVzZWQsIHdlIHNob3VsZCBjaGVjayBaRiB3aGljaCBpbmRpY2F0ZXMgd2hldGhl
ciB0aGUgc2VnbWVudCBsaW1pdA0KaXMgbG9hZGVkIHN1Y2Nlc3NmdWxseS4gIFNlZW1zIHdlIG5l
ZWQgdG8gcmVmYWN0b3IgdmRzb19yZWFkX2NwdW5vZGUoKSBhIGJpdC4NCg0KICBYaW4NCg0K
