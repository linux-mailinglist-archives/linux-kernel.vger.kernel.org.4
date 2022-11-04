Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52A4561988B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 14:55:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231684AbiKDNzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 09:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbiKDNzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 09:55:51 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E11D2F001
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 06:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667570150; x=1699106150;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+BSBmNCdmUpInXlKMNB1ygdMdyiCv3dCUJRQQm+T5sk=;
  b=JDqnIxZmatPf15zu320DzbRlLaG9HsU7Eq7Ws5LdA67T8FefAz3UC3WP
   P0YJqHRj9HY6lrKf2zJzVlCJqgIOs7e17CmIjxNbw+FH77K0s77IbtX/o
   qUUU/Ock/d56SfOoQu+8TKsYSBBXvy4qF5miWlaAHl8H4PXSJYDVOSuKh
   uinDqqMCI7G5bObHp4iSpUkP2v+tzv03NWXj1dCX8DSf/pwnuwZr3/WGW
   roVhyQPc3QdCBZ5NEeKS2kPcNvsYMg6tvKcx+wXy4iJgZqcRA8fxwweKL
   D5M+6pQzrjggmXCpLx5jmP2vperTNFwO4/YQmFcOb+sMGCsVyIKoEamq3
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="289687010"
X-IronPort-AV: E=Sophos;i="5.96,137,1665471600"; 
   d="scan'208";a="289687010"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 06:53:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="668362015"
X-IronPort-AV: E=Sophos;i="5.96,137,1665471600"; 
   d="scan'208";a="668362015"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP; 04 Nov 2022 06:53:49 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 4 Nov 2022 06:53:49 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 4 Nov 2022 06:53:49 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.108)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 4 Nov 2022 06:53:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fLMlhQdkowetBsEyR5EQRvJqAQjnFpiHqAq9jKNAUL+0gE5/LZA+tmJIRMlWK3qSVMzeV/BbbjB/ebfIjvm8JGr/xdsUeAB64dTI/X52GDf+I+rnWkCzGClhsTCcm32mMiTBI8+RpxlrN/pvHbTfpZC1uweq9pbCRKfBXGcIOAey/3LqzOjt6SqGMCMeTJCo/waL1S8swhGmHR5A5IDw4hETcTp+gt/ffTlvSpmiu6dhVPROKt7WsYR0AHxP1As1WdenjZqzooAdp7WbPZtQTFEgqGa5N7mX8hc+5Fexxy1ycVRs2DcYjKaLofWjlFJeGkRr+q+isGmDe6UQ0uX0lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+BSBmNCdmUpInXlKMNB1ygdMdyiCv3dCUJRQQm+T5sk=;
 b=Ab0xJWH1ceY/iGW83PM3Z3UWIsFN4W46Pc3SItmPhVmfpcNA/l7mjadxY69tOStdquNiUaAr+uPBXR3GmfhJyjzDBIHBZ6wnChe+qr7724SvjNIMk/26x93xr0T9ZdZqqil0fOYR8aji7aBYLkpcqwcktsxvkhcq+bdz2SUQl7neU06+LQ8WyfsFiuqbBrqCy7eZ0cebgcJHfngjR0s0sDmw4JyXhkYU5Wa2QmYOuXowIJZO/nol1rNPLvAzrhS8IQgtuEzxJNVCTqHzDE4tDialzWG87mSzBkK1YBAF4NO1VzyUzjvcgwVZ4lwxptwCduSItcM44sG2j8/PUIqCUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5719.namprd11.prod.outlook.com (2603:10b6:8:10::6) by
 CH3PR11MB7346.namprd11.prod.outlook.com (2603:10b6:610:152::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Fri, 4 Nov
 2022 13:53:47 +0000
Received: from DM8PR11MB5719.namprd11.prod.outlook.com
 ([fe80::b695:d022:bb2:17c]) by DM8PR11MB5719.namprd11.prod.outlook.com
 ([fe80::b695:d022:bb2:17c%8]) with mapi id 15.20.5791.022; Fri, 4 Nov 2022
 13:53:46 +0000
From:   "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>
To:     Borislav Petkov <bp@alien8.de>, "Raj, Ashok" <ashok.raj@intel.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        LKML Mailing List <linux-kernel@vger.kernel.org>,
        X86-kernel <x86@kernel.org>, "Luck, Tony" <tony.luck@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Tom Lendacky" <thomas.lendacky@amd.com>,
        "Huang, Kai" <kai.huang@intel.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>
Subject: RE: [v2 01/13] x86/microcode/intel: Prevent printing updated
 microcode rev multiple times
Thread-Topic: [v2 01/13] x86/microcode/intel: Prevent printing updated
 microcode rev multiple times
Thread-Index: AQHY764DuDURk0B+lEawHCzJwY5+A64umgGAgAAvkzA=
Date:   Fri, 4 Nov 2022 13:53:22 +0000
Deferred-Delivery: Fri, 4 Nov 2022 13:52:51 +0000
Message-ID: <DM8PR11MB5719A5BB1C56D442F0E25544923B9@DM8PR11MB5719.namprd11.prod.outlook.com>
References: <20221103175901.164783-1-ashok.raj@intel.com>
 <20221103175901.164783-2-ashok.raj@intel.com> <Y2Tw2+LCmZe8XBJn@zn.tnic>
In-Reply-To: <Y2Tw2+LCmZe8XBJn@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.500.17
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5719:EE_|CH3PR11MB7346:EE_
x-ms-office365-filtering-correlation-id: f1bedaa9-1afd-4978-e6d3-08dabe6bfe9a
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KIMwGJwQ54Rf0Vxn+pGUnsEXT3M0COCAU0G8H31eXGrt2BG9hFuL73EElHqTM8WjHNFrvcSbQcZE5bEaTQ7UAmMnI8SGn1p/hpW03RpDmAhAKu3emrQ4d+zf4IJZmTxoBL8gLiHvxdiaJNKhV6c66taibce/A26PYaaDAYbbhNfuR1BO5W4lU0cBY3qxUQKiEZEdgZY1zte8Fa5DE865R3Y9Cm/OL9iP2RXJmZ43wVVXFT4mOdK9QwlWvUkFohxrkQBRl8mWRT4nTFhpHqM1N1ih8oPyjmsBe/auO7fbYKTVLTRRthmr4ewrqOx+9BN8M1qiPfU5IAxN7tcWxcvqpwZikVbpVUE0NkNBI0bM2kXrvVhp44XUrxdws+hkQKJUOKzFBbQmZQ7bkCHl1//6hlLAAJSAa5c+HTcYtCNnCF1zx7xVaCPyApoDsbAIY7y6MyjOLteK+SVntbyFSm1IU3Kkh8r5I6lLC9NiMMDgapc7Llk1bLAObqmZ0fXGlh30+/lNY6vs2oLhwApMBsmwB1RrFPHgcUOKcyXW4wAErbeHftI34lHajwrcn2lhZH22FcMT4ZGGnrC8cXgSPhKK8Lb7sZ83cwv4N73Op1EeEbL7aVKhL9DOk4bmuqvTlevzNXudOsYZOPKiQ//J0R6/udnV/x48gtEd/l6tCLz+us/8KnJifmfvilcPDgarWBnveVwUsN/JDH6NdhWCKq3Xenq/pzOyivSkZCZJAsIqjUWvFNlgY6rCScc00YSpE4E+GJyWaoHXGmxXfvKOb9NbFw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5719.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(366004)(396003)(376002)(136003)(346002)(451199015)(33656002)(86362001)(38070700005)(66476007)(122000001)(82960400001)(38100700002)(41300700001)(2906002)(4744005)(5660300002)(76116006)(64756008)(52536014)(66946007)(66556008)(6506007)(4326008)(8676002)(7696005)(6666004)(110136005)(26005)(316002)(55016003)(9686003)(66446008)(8936002)(186003)(6636002)(54906003)(71200400001)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V053TnBCTzIraHRYdXF1bkpZSUcvbjRhQjRDRHJHeWpaek1SUlZWNGVtRlIv?=
 =?utf-8?B?QmdnY1hWdW9scXVhcjBycmZqcWpyZUgvM0RINzlIY3lMaXNQOThra3JIT3dO?=
 =?utf-8?B?aXFLZlZ2MDdKdEpubVlJVnJ0WmRTalRGR2FKM1lMZGxMbGRsMDJQOU5wVTBP?=
 =?utf-8?B?UHp0Y0FhVXlPSGdRRGRoNXljYlF5dmRySXJLK1hnZThTVkQ5ajFrb0lkZ0pm?=
 =?utf-8?B?WS85aVprRUtxMFhhY0UvNG1xQmNHRldiZGE1MTNjbE50ZE1iQmUxcXd0VUZN?=
 =?utf-8?B?WlBmSDd6VEVGNWYyNDZIcDNRZUJLc1FsTXR1KzFYYm5RaE05RkdaZW4xN3Fw?=
 =?utf-8?B?R0Jnb3o5V01LbGhxVUNIMGlrOVc5VnJ6WHZwbXIrUk1LQ0xPU200VVErYXJY?=
 =?utf-8?B?ZHlCYnVoaHZBTHJvbWNaa0F0eS9mT010RXl2enlUMW9tdVpRSktSTnZ6RDZt?=
 =?utf-8?B?TS9yb28rWVBNK0RqSG8vbGZEaE5HR3JDTjBWRk4vK05lakFZMDVTdVFxMlFk?=
 =?utf-8?B?NkpjR1JiNHB0aUEzSmhiUGVxcXhVZlZuSTJ4WUJndDFtTDFmaDlOTXpFd1Y2?=
 =?utf-8?B?WnlKbjQ1b3BsMXpKZXRCUkcxbGdXWWtFZDk5L0RGYWMvc1NqMTB6QnFuYVlj?=
 =?utf-8?B?OTBCNlBZWVFkcHRkdlJ1bHh2K0pQV2p4ZkxRbVpVQ0hRa0xQZStodEhFaVFF?=
 =?utf-8?B?aWc4ZzVPc3hWMnlwdXozMU13R1dPaXcvd2tIcXVPTlNNTCtLVXdhVUpZOFJj?=
 =?utf-8?B?YW1iZmJOaEM0MzJMb0s1dlhrQnF2YTRsRTJ3MVNKWno5Rk9YWXB4bW9BZjRH?=
 =?utf-8?B?dlVwNEZqeFJuUVFkeGYrSXlkL3BUOCtEaURjYnRwZzNYY0xnb0RvaUQ0alNH?=
 =?utf-8?B?TzVVL3o1OHpuSUhScDE5M1kxWU9pUnl0Tml6cHBlcEdOdXFITVVJY0hkYzEz?=
 =?utf-8?B?WFNmRHhkSllzLzd2a2x5d05XcDl0Sk01aER5bmcwSWNnd2VMTDhadnJjcEM2?=
 =?utf-8?B?NEZhMVlWdFo2RWFSZERLODd3WDNhbVorVGFyd25RSFRhUUNjczZ2elRDSUs2?=
 =?utf-8?B?MUl3akJTVVlnMTJaMllnVTIyV1pGdFdFSTlvWDRUdEdkOExzaWhvZnMrM1hi?=
 =?utf-8?B?UlQyWkJFamJtL2hBWThURkJpWDdDdTdtcnpRemhzeXVJeWJCRkxQRHBEN1cy?=
 =?utf-8?B?TndFRlBmUWh5T29RREg1T3FwMTY5SldvTUIvcU5vQXlxdFVucFA1Sjd0eWxp?=
 =?utf-8?B?ejJoZU92SXhWR1pBbUhYcGZxbTJiaFFCMUVoMEp5NmRCc01qeGl6b1FRdVVl?=
 =?utf-8?B?Y2RUY2xFRXNkQXR3L0dVVlg1QVNjWmNrbU1FNTVTT1h5WXZPRnU2bXdGd0Ev?=
 =?utf-8?B?cU40K2c4VGN4TXlqaTlETmtDdituZzNFaEJUb3VRNWlqVHVBRzEwSWRHTXZv?=
 =?utf-8?B?MnU1cFhCWTNINVN2dGJKZEZFTFZnWUFqUXZ5bUhTbmswZ3hIOG96Sk5ObHJN?=
 =?utf-8?B?MXpvWjc3L0JnVHlhNm5RbjZxSzJXbnZ0Tjd5MmZkVVI0TWxsNVByQUtGdEZz?=
 =?utf-8?B?d0VNQXJiT1VYMm85Y29ra1doeFlwLzNra1lHYTJrMnZJV281dGo0WUFPVldr?=
 =?utf-8?B?SVRwYXRuZnoxSFNKbmhjSnJ5RDdUMWVId0owbE9RL3lPcnVBUHp5RFN5WXpB?=
 =?utf-8?B?bWd2enBTTFgrWTZaanhMZElwRUVlUUxDcm9LekQ5UmNTbUxGWFkvQXR5Zzdl?=
 =?utf-8?B?ZjdPSE9OM2dkeFNoV0owNUVDbmJxNDBKb2hRcC9rbkVrSXlIZDlhQkxmVUlr?=
 =?utf-8?B?TWlndFBPVmpGb2JsLzl6cmdXSEZ1dWYrb0hoMU5OekRRakZ6Unlnb0xjbzJ2?=
 =?utf-8?B?WTkrU1JyOHIwWmVHQmhqSC9VVnluMVI1T1BwRzFmUmZHNHFMNVlMZEU0NldG?=
 =?utf-8?B?MElLQ2hNd3dhL2U3NFFxUGlpVXJRanVZbjVkcnNwMDhkSjlOejA5eXRpUS81?=
 =?utf-8?B?N25hZE83M2lNNmkzUXlBMkdSUTVlU080TExoUEptNkJQbGJqV1Mza1g0a1Fz?=
 =?utf-8?B?c2lXUzNrdDVnTWxHS21OR3owOVBSRmZ0WG1UQzhPdzVTQ2JrMFlJOHF4RG1T?=
 =?utf-8?B?ZWJabU1GMytFYUtRNWhNOGRnQVpmMkZDQVNQNWFjU0VpTmkzaTBJYjF5YXhG?=
 =?utf-8?B?Y2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5719.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1bedaa9-1afd-4978-e6d3-08dabe6bfe9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2022 13:53:46.8532
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jA9QkqMuUr8RBZ29zGndpzTjmVDrR4mfQ0KntN8NmFgSLncPPrpxKIrSRIr4lbNfe89XT/NvglxRO3I/Diudrkn5jNylmXGxCDBRuzfmd3w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7346
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBUaGlzIGJhc2ljYWxseSBtZWFucyB0aGF0IHRoZSBsb2FkZXIgaXMgbm90IGdvaW5nIHRvIHN1
cHBvcnQgbWl4ZWQNCj4gc3RlcHBpbmdzIG1pY3JvY29kZS4NCj4gDQo+IFllcywgbm8/DQo+IA0K
PiBJZiB5ZXMsIGNhbiBJIHJlbW92ZSB0aGUgcGF0Y2ggY2FjaGUgdG9vIGFuZCB1c2UgYSBzaW5n
bGUgYnVmZmVyIGZvciB0aGUNCj4gY3VycmVudCBwYXRjaD8NCj4gDQo+IFRoYXQgd291bGQgc2lt
cGxpZnkgdGhpbmdzIGV2ZW4gbW9yZS4NCg0KDQptdWx0aXN0ZXBwaW5nIGlzIHJlYWxseSBub3Qg
d2VsbCBzdXBwb3J0ZWQsIGFuZCBmb3IgY2FzZXMgd2hlcmUgaXQgZW5kcyB1cCBoYXBwZW5pbmcs
IG9mdGVuIGEgImZ1bGwgc2V0IiBtaWNyb2NvZGUgZmlsZSBpcyBtYWRlDQood2hlcmUgdGhlIGtl
cm5lbCBkb2Vzbid0IG5lZWQgdG8ga25vdykNCg0Kc28gSSB0aGluayBieSBhbGwgbWVhbnMsIGlm
IGxpZmUgaXMgc2ltcGxlciwgc3RvcCBkb2luZyBjb21wbGljYXRlZCB0aGluZ3MgZm9yIG1peGVk
IHN0ZXBwaW5nDQo=
