Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAA7E6958A8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 06:48:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbjBNFs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 00:48:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjBNFsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 00:48:25 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B92717144;
        Mon, 13 Feb 2023 21:48:23 -0800 (PST)
X-UUID: 2decea7aac2b11eda06fc9ecc4dadd91-20230214
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=eKszVs61RcDbiiA7WDXNYnW2USGVnrEH4qbHidHwOkg=;
        b=C8Z2iUH4e/4R73dHJaBRWy4z2/aoIDbrABFI6VZC9PG1GfK87lLY4si6QICNJzz2Rrvsuf1ZchbVa8xSM5i2ogxmend0PZOD4AZ0LVNlyle7Sc1jcHJTWrqw0l2v0hJAf2h7MIu5Wbxts+svKrydY1eQp5ohQlg27nGdLfVE2Ok=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.19,REQID:4d05b466-3653-4f25-b0c9-4b70cc90c901,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:885ddb2,CLOUDID:b07bd18e-8530-4eff-9f77-222cf6e2895b,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-UUID: 2decea7aac2b11eda06fc9ecc4dadd91-20230214
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1693341605; Tue, 14 Feb 2023 13:48:17 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 14 Feb 2023 13:48:16 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Tue, 14 Feb 2023 13:48:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jOc3Z60twaac0kcJvOTzP8s8LZ3Jk6fZfYyKKV77hk5OX1dXS3kD2olpIt+LVWdibzMVho00JufT/o43fJC2AFxNvIDOHqjWfLfSZ+fqy0WOXlfcbbCqTcWD/4OiWtzdPw5pO3kwt0+sSGAxSWYmSilPkRbRsAMri7Q2t/TEr0M72+/tqg8lfYjid94ZlcsAtopUke9PzB1JbiOL/dRg+PEEa9QdNoq3IU1ZJdYOVDqwh4TJwTBPudg7tZJ5TlTbG8yN8NGPGx77Yu63esSoHpyMUHDRncLktlt28lEsqxeSbAmAl1w1bdgniRoYmxWTMgMJ683n4ve5VAvEhqB4CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eKszVs61RcDbiiA7WDXNYnW2USGVnrEH4qbHidHwOkg=;
 b=ZoX30eYaOFWY1q3pHqfCAwYyvUVjPvd0Sj7a6GcrvALR+V29mT3aW8O/u7jMC2OkGnbDTW7jdJnP3qGAYiO18J/gVIos5PdXTzYlHS3XS9acgoVin6pcrqwwq8bjqRS6CU6iDyp0rh6FzIPC2Kv7koYETnfRPpKXG69Rx0/T3eNCBiPFVcGzdbnv7UsNUnMucY/qOZpWrmnl1BE0+b1C6qe+29T++hOVed1j2qIZ2rsI56p+MyVE0fI28P7P8xe09wdQa8YSdkmpcmOGng0RacNYzn1jesduHYa4kv5Ld9Y9IhL3WKeBU/bPtoqP2j6ZPXGX/H9t+TDGNT3xRNn0iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eKszVs61RcDbiiA7WDXNYnW2USGVnrEH4qbHidHwOkg=;
 b=XyDkeowldaETCm1nRwj+NwWWUi1/9Xf6s8k9EZvZkTr2e3+1X3ccJTP+xFBZgD3x7hijmvLrP7wU0OMfD2KG1jD7pIOnAcPxuDia2JOTPJ8EqtgKgRgjvNh9e6T5w92upC7aA13ewip6dclD3Oxy/823q2Y/rnX9y5gnvPgzgM4=
Received: from SI2PR03MB5885.apcprd03.prod.outlook.com (2603:1096:4:142::7) by
 TYZPR03MB5912.apcprd03.prod.outlook.com (2603:1096:400:127::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.24; Tue, 14 Feb 2023 05:48:07 +0000
Received: from SI2PR03MB5885.apcprd03.prod.outlook.com
 ([fe80::4e0a:24eb:3ed8:b49c]) by SI2PR03MB5885.apcprd03.prod.outlook.com
 ([fe80::4e0a:24eb:3ed8:b49c%7]) with mapi id 15.20.6086.024; Tue, 14 Feb 2023
 05:48:07 +0000
From:   =?utf-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?= <Yong.Wu@mediatek.com>
To:     "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
        "abailon@baylibre.com" <abailon@baylibre.com>
CC:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Subject: Re: [PATCH 2/3] iommu: mediatek: Add support of unmanaged iommu
 domain
Thread-Topic: [PATCH 2/3] iommu: mediatek: Add support of unmanaged iommu
 domain
Thread-Index: AQHZNJVgHa4/PmO9xkO9oRNsSevop6623LuAgAGkNQCAABLBgIAAFWgAgBVdjgA=
Date:   Tue, 14 Feb 2023 05:48:07 +0000
Message-ID: <2b8e19488386b5ca523f010b8ded750a4213f84e.camel@mediatek.com>
References: <20230130102722.133271-1-abailon@baylibre.com>
         <20230130102722.133271-3-abailon@baylibre.com>
         <741920ba-8637-5e28-695c-699b46351590@arm.com>
         <f126c61f-6373-d6c5-59c8-24dea9d9d168@baylibre.com>
         <0e9f677b-846d-809d-9bc3-30906f703fda@arm.com>
         <21fef8eb-6482-fd8c-118a-c4d9da4cfbaf@baylibre.com>
In-Reply-To: <21fef8eb-6482-fd8c-118a-c4d9da4cfbaf@baylibre.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5885:EE_|TYZPR03MB5912:EE_
x-ms-office365-filtering-correlation-id: 786d5cd6-94e3-4234-4a87-08db0e4f0c23
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wqFz29AtY7QTckonvK7I/uLcoXB6jj1Hao6uzOlaDBtjGobfu30kVqS6eeFWycV5xkvOrfi5vyW7QckCm6uirCT3u+B9o/lTmNnlN9JqKsIseuKb98SkfMDstXp1GX5dC+VAECwg6LbIC4+61FMkXqTzlh4hLhUJALftd6sepht5iGAGeWEPOlPNGRGDxcBZb4JcwoQaK0QoVYqZuqk/N20hVOazLzogYUNfPFzsgjMBO31oKTbQfsnK5FjCVuZdfJeJ7kU0u/8WJ7GiSisypsNZERiRtztx8lTkutzuzMdZWwe3bTR2lJ8d44It78x8bB4kM+zxCRo99GXdKrzTEucNqoPfgg9+jN8tqm03+8TcLTkjYhmgt9W8zDnWNKnGZCGceDwk50nbaSmG8zFnozeWXBrlSyCHADgyGJ//fat6RF5sVoY1QLGDRCOk9ZwVnhsulyDrU/GfCw5zAVlPcm6a9LsUSgTqPWizodZgUEA8FJqxc68Tf1HKXtsJ9bkRwm8nqroEP7Rm5jLyJ/qPXuTTdBW4/vCkFlhxpoUmKYAw4WwD2mM/0pF3+g3irGjbbFZU5EhOU1AfGtKjpcYPUfgBG5D4OrFCuz6NtZNur2IGBV3FQnzR+7M5nZvR412b8kaJUcpiXJVV0OYvbgl9W0OS/dDDbwpY5ekBTllmHSuLT0jFYX+Il4Q15wIoiKs3rEL2JNex1H9GRnpIdRUn612ODd/9ZDqH/u7eQ/MUqtD2grh4aMglqvJApX5Dbwhe
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5885.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(376002)(346002)(136003)(39860400002)(396003)(451199018)(76116006)(5660300002)(66946007)(66556008)(7416002)(66476007)(8936002)(86362001)(66446008)(8676002)(4326008)(64756008)(41300700001)(122000001)(2616005)(316002)(38070700005)(54906003)(110136005)(85182001)(71200400001)(966005)(36756003)(6486002)(186003)(26005)(2906002)(53546011)(6506007)(6512007)(478600001)(38100700002)(83380400001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V3JUUFlHQ1NpUmdPd3RoTXVteHVXMGxtSGNjd21ETVlRVE9hbmVaM3Q2RjV5?=
 =?utf-8?B?am85dFhjd1QrM29rNkk0L1BqNDZJQmFPbnl3TENMOEhLaCtzcTBRSHhUYzR0?=
 =?utf-8?B?Y2VlL09TY0QvME5hNVVoSjdvZTcyWCtGTlJ6YncvVldpZmkwUG80R2pIbTFJ?=
 =?utf-8?B?M1huQnIyUFA0eGIvb3lZc2pFQW01QTlqS2krMUxJcUNWUTNQRXlXOU1mMDAw?=
 =?utf-8?B?MEJaNnpQdyt1aFJNYldBWGJNQ05jMWk0S2s1Y0ZyR2RRcUxpMERGSEdpOU1o?=
 =?utf-8?B?em00NytMU05YaVgwRjVydGZuU3ZzZkRPRWNEL1Zic01yMTFnTzh4TzhhZTI1?=
 =?utf-8?B?em9KUExram81aG4vU1hVUmVraXRNWUxyK0RaUGtKWnVFVzNmcmExZUlEcWpV?=
 =?utf-8?B?cGdmRnJrSWZyUVBJYjJjWTNscEJjbElyU0RMR0JTM2V6OUQrbFlOalpTSTA3?=
 =?utf-8?B?bDhkTWw2by9QNjFrOEFhZW1Ob3JvaCt0Q0xpUVlmenI2ak43eENBTjY3OVdj?=
 =?utf-8?B?SXlGVkhTRWM3NEdabjFodENub25YNFcrQjJHTDVzYmFRZnNkeVFDV1l0b3Z2?=
 =?utf-8?B?Y3NGUkFhZ2RIU2E5WTRLNzVza29BRFVWakxSUzhSR0pPRE8xQjc2Qlo3cE82?=
 =?utf-8?B?MDJvYkhDNzUrTTBBa015cXVRbWVKVURodlNwb3RSZCsxbnI5Q0lVYjYzNTdI?=
 =?utf-8?B?bnJQOEdIQ2xRSjVBTVZYY1p2dUd1cjRTRHFjaGJqMlBrVCtVbis3ai9LSEtk?=
 =?utf-8?B?VlZ0R0w1MTdaWGpkcHdPK3FpNy9CajMzaXUvLzFBc2lEZ3dMb1RsdDJoZFVO?=
 =?utf-8?B?OFQ1Q2ZBYzFPQkYzdjFnOENXbkZkRGdReHpPd0l5S3RQQ0FpQXhkVDFYUkxG?=
 =?utf-8?B?UlJ1c0hRYTZtcUE5TWdzN05JUVQ3NUZJelFvV0VHT1J3SVkzcVUvNGE0amky?=
 =?utf-8?B?djBpSWk0elhqUVUwYnVZRk1FOXJzYTBWQkhDV0xTcnFtMzFVcW1RcElCYldk?=
 =?utf-8?B?R1RaTkNndmR4TkV0Z1RjYU13Vm9Sbjg1amdaZDlvUThvd3lKeENwRDZpUjNu?=
 =?utf-8?B?VSs0NDZXUDlnRmc0Tmtia0hHTzcyWWdnRjd2UitLUnBnQzlHVmtTbXlMNlk3?=
 =?utf-8?B?b0dKMUpmQjJ2RWFtS1d5R2tocW5Va0tuZDZVMkFlWmF1eWZqVkttUEoxZ09R?=
 =?utf-8?B?VWZlRHB3cXZJZUhGNXNCaFMrRHJaT2NkMlpLQTFUaVlaTzRtRFJBUUFyNkdI?=
 =?utf-8?B?bWUvcjNxVi90UElXWGYvMzV2dUE3clZlVVg4V2Yva2svV3ovYWF0SmI3S1ph?=
 =?utf-8?B?alBSY3lBcnlmcEJDSTc3TXhJM21oUEFhbWU2WDFlTU11a3BFTXlEaWZHWk56?=
 =?utf-8?B?cHptWkFHcXRtNFRsVDFpKyt6VlBQQ2toa3RrRkE5bW50ZTB3TDRFd2Z5VC9t?=
 =?utf-8?B?UEF2UVNEZnN1QmJCeVA0TTFMbm1SaGVVeUVQcWtpYlJCVTVaYlZGcnE2dEh6?=
 =?utf-8?B?b2tGMzdhQ203MnhxbzRJdGY2bEVjenEweGNEelJHWUVUZ0NmSGlMbVdKY05R?=
 =?utf-8?B?NjVLK3FXcjErNkRneVZWdWtrQlhDY0NYeTRIS1NBaSt0dmZIdkNIdWVzQ1pJ?=
 =?utf-8?B?RUR5Smx0dkxMeUEzNnFKbjJ1eUlodXpadjJXOVpFRklOYXJldndlWThRbUJp?=
 =?utf-8?B?dGVHSTlFRjUvVkRHRzhCbDNlejh1MW1sWmt4T3p4b1ZRaEVBd095R3dPdGg1?=
 =?utf-8?B?WnA0dk5rUDY3eFQrQUpPTzY5NUZhSGxGVjhtNG1MOUxpTTZrcFhRQmVTb0dV?=
 =?utf-8?B?K21kcEtwQkZDQWwwb2VPWXZtVVFYUEhJOE1hMVFQWThFSjYzaWIxenh6NkJX?=
 =?utf-8?B?NkV0ZUZrL0k0RXg2NmVKdE9ZMDR0MW56b2twandSVko4TElqTEJsNFBGL1JO?=
 =?utf-8?B?UEhiVGdRYlhUMmZIbHZSUFNhWTZFeElJNnJINnhMaU4zM290YWFrOG93ZU5W?=
 =?utf-8?B?cjRmaTJaMmcwZ29Pc1hSMUl0cC9kN2lQRTgrVnp2ZjZ1ZXlNaGptUXlra1pG?=
 =?utf-8?B?TE1zSmw3QnJBaE44WDlhRG9VOHUwU1ZHbmxoZ1VWSVJEdExkWmlvS1JMa0pK?=
 =?utf-8?B?cEZtOGVIT1FySW5tUjdFUjBDbXpNQ3plQUY3NVR2S1BOamVWOS9uZFBmT0FK?=
 =?utf-8?B?bkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <277C142862718F48A3DCF254C756D5D2@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5885.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 786d5cd6-94e3-4234-4a87-08db0e4f0c23
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2023 05:48:07.1745
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VNVb2o0GYX3lQd4U4Mu6t32ge+T8AnqyES1wa9t0YLwmCr4pbo/70rKuSdxRBy88uCT+ceH/LgVRewVhdOtbQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5912
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIzLTAxLTMxIGF0IDE2OjMxICswMTAwLCBBbGV4YW5kcmUgQmFpbG9uIHdyb3Rl
Og0KPiANCj4gT24gMS8zMS8yMyAxNToxNSwgUm9iaW4gTXVycGh5IHdyb3RlOg0KPiA+IE9uIDMx
LzAxLzIwMjMgMTowOCBwbSwgQWxleGFuZHJlIEJhaWxvbiB3cm90ZToNCj4gPiA+IEhpIFJvYmlu
DQo+ID4gPiANCj4gPiA+IE9uIDEvMzAvMjMgMTM6MDQsIFJvYmluIE11cnBoeSB3cm90ZToNCj4g
PiA+ID4gT24gMjAyMy0wMS0zMCAxMDoyNywgQWxleGFuZHJlIEJhaWxvbiB3cm90ZToNCj4gPiA+
ID4gPiBDdXJyZW50bHksIHRoZSBkcml2ZXIgY2FuIGFsbG9jYXRlIGFuIHVubWFuYWdlZCBpb21t
dSBkb21haW4uDQo+ID4gPiA+ID4gQnV0LCB0aGlzIG9ubHkgd29ya3MgZm9yIFNvQyBoYXZpbmcg
bXVsdGlwbGUgYmFuayBvciBtdWx0aXBsZQ0KPiA+ID4gPiA+IGlvdmEgDQo+ID4gPiA+ID4gcmVn
aW9uLg0KPiA+ID4gPiANCj4gPiA+ID4gVGhhdCBpcyBmb3IgZ29vZCByZWFzb24gLSB0aGVyZSBp
cyBvbmx5IGEgc2luZ2xlIHBhZ2V0YWJsZSBwZXINCj4gPiA+ID4gYmFuaywgDQo+ID4gPiA+IHNv
IGlmIHRoZXJlIGFyZSBtdWx0aXBsZSBkZXZpY2VzIGFzc2lnbmVkIHRvIGEgc2luZ2xlIGJhbmss
DQo+ID4gPiA+IHRoZXkgDQo+ID4gPiA+IGNhbm5vdCBwb3NzaWJseSBiZSBhdHRhY2hlZCB0byBk
aWZmZXJlbnQgZG9tYWlucyBhdCB0aGUgc2FtZQ0KPiA+ID4gPiB0aW1lLiANCj4gPiA+ID4gSGVu
Y2Ugd2h5IHRoZSBiYW5rcyBhcmUgbW9kZWxsZWQgYXMgZ3JvdXBzLg0KPiA+ID4gDQo+ID4gPiBJ
IHVuZGVyc3RhbmQuDQo+ID4gPiBJIGFtIHRyeWluZyB0byB1cHN0cmVhbSBhIHJlbW90ZXByb2Mg
ZHJpdmVyIGJ1dCB0aGUgcmVtb3RlDQo+ID4gPiBwcm9jZXNzb3IgaXMNCj4gPiA+IGJlaGluZCB0
aGUgaW9tbXUuDQo+ID4gPiByZW1vdGVwcm9jIGNhbiBtYW5hZ2UgdGhlIGlvbW11IGJ1dCBpdCBy
ZXF1aXJlcyBhbiB1bm1hbmFnZWQNCj4gPiA+IGRvbWFpbi4NCj4gPiA+IEkgdHJpZWQgYSBjb3Vw
bGUgb2YgdGhpbmdzIGJ1dCB0aGlzIGNhdXNlIGNvZGUgZHVwbGljYXRpb24sDQo+ID4gPiBpbXBs
aWVzIG1hbnkgaGFja3MgYW5kIG5vdCBhbHdheXMgcmVsaWFibGUuDQo+ID4gPiBEbyB5b3UgaGF2
ZSBhbnkgc3VnZ2VzdGlvbiA/DQo+ID4gDQo+ID4gSWYgdGhlcmUgYXJlIG90aGVyIGFjdGl2ZSBk
ZXZpY2VzIGJlaGluZCB0aGUgc2FtZSBJT01NVSwgYW5kIHRoZSANCj4gPiByZW1vdGVwcm9jIGRl
dmljZSBjYW5ub3QgYmUgaXNvbGF0ZWQgaW50byBpdHMgb3duIGJhbmsgdXNpbmcgdGhlIA0KPiA+
IGV4aXN0aW5nIElPTU1VIGRyaXZlciBsb2dpYywgdGhlbiB0aGUgcmVtb3RlcHJvYyBkcml2ZXIg
Y2Fubm90DQo+ID4gbWFuYWdlIA0KPiA+IHRoZSBJT01NVSBkaXJlY3RseSwgYW5kIG11c3QganVz
dCB1c2UgdGhlIHJlZ3VsYXIgRE1BIEFQSS4gVGhlcmUncw0KPiA+IG5vIA0KPiA+IHdheSBhcm91
bmQgaXQ7IHlvdSBjYW4ndCBoYXZlIHR3byBkaWZmZXJlbnQgcGFydHMgb2YgdGhlIGtlcm5lbA0K
PiA+IGJvdGggDQo+ID4gdGhpbmtpbmcgdGhleSBoYXZlIGV4Y2x1c2l2ZSBjb250cm9sIG9mIGEg
c2luZ2xlIElPTU1VIGFkZHJlc3MNCj4gPiBzcGFjZSBhdCANCj4gPiB0aGUgc2FtZSB0aW1lLiBT
aW1pbGFybHksIHJlbW90ZXByb2MgYWxzbyBjYW5ub3QgdGFrZSBleHBsaWNpdA0KPiA+IGNvbnRy
b2wgDQo+ID4gb2YgYSBtdWx0aS1kZXZpY2UgZ3JvdXAgaWYgaXQncyBub3QgYWN0dWFsbHkgaW4g
Y29udHJvbCBvZiB0aGUNCj4gPiBvdGhlciANCj4gPiBkZXZpY2VzLCBzaW5jZSB0aGVpciBkcml2
ZXJzIHdpbGwgbm90IGJlIGV4cGVjdGluZyB0aGUgRE1BIGFkZHJlc3MNCj4gPiBzcGFjZSANCj4g
PiB0byBzdWRkZW5seSBjaGFuZ2UgdW5kZXJmb290IC0gdGhhdCdzIHdoeSBpb21tdV9hdHRhY2hf
ZGV2aWNlKCkgaGFzDQo+ID4gdGhlIA0KPiA+IGNoZWNrIHdoaWNoIHlvdSBwcmVzdW1hYmx5IHJh
biBpbnRvLg0KPiANCj4gVW5mb3J0dW5hdGVseSwgd2UgY2FuJ3QganVzdCB1c2UgdGhlIHJlZ3Vs
YXIgRE1BIEFQSS4NCj4gQmFzaWNhbGx5LCB0aGUgZmlybXdhcmUgdXNlIHN0YXRpYyBhZGRyZXNz
ZXMgKGFuZCB0aGUgcmVtb3RlIGNvcmUgaXMgDQo+IG9ubHkgc3VwcG9zZWQgdG8gYWNjZXNzIGFk
ZHJlc3NlcyBiZXR3ZWVuIDB4NjAwMDAwMDAgYW5kIDB4NzAwMDAwMDApLg0KPiBXaGVuIHdlIHVz
ZSBETUEgQVBJLCB3ZSBnZXQgYSByYW5kb20gYWRkcmVzcyB0aGF0IGRvZXNuJ3QgbWF0Y2ggd2hh
dA0KPiB0aGUNCj4gZmlybXdhcmUgd291bGQgZXhwZWN0Lg0KPiByZW1vdGVwcm9jIHVzZSBkaXJl
Y3RseSB0aGUgaW9tbXUgQVBJIHRvIG1hcCBwaHlzaWNhbCBhZGRyZXNzIHRvIHRoZQ0KPiBzdGF0
aWMgYWRkcmVzcyBleHBlY3RlZCBieSB0aGUgZmlybXdhcmUgd2hlbiBETUEgQVBJIGNhbid0IGJl
IHVzZS4NCg0KSWYgdGhpcyBtYXN0ZXIgY2FuIG9ubHkgc3VwcG9ydCB0aGlzIHNwZWNpYWwgYWRk
cmVzcywgV2UgY291bGQgaGFuZGxlDQppdCBpbnNpZGUgdGhpcyBkcml2ZXIuDQoNCkNvdWxkIHlv
dSBoZWxwIHRyeSB0byBhZGQgdGhlc2UgdHdvIHBhdGNoZXMgWzMvMTFdIGFuZCBbNC8xMV0/DQoN
ClszLzExXSANCmh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC1tZWRp
YXRlay9wYXRjaC8yMDIzMDIxNDAzMTExNC45MjYtNC15b25nLnd1QG1lZGlhdGVrLmNvbS8NCls0
LzExXSANCmh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC1tZWRpYXRl
ay9wYXRjaC8yMDIzMDIxNDAzMTExNC45MjYtNS15b25nLnd1QG1lZGlhdGVrLmNvbS8NCg0KDQph
bmQsIHRoZW4gYWRkIHRoZSBsb2dpY2FsIGZvciBtdDgzNjUoSSBzZWUgdGhlIEFQVSBpcyBsYXJi
MCBwb3J0MTAvMTENCmluIHRoZSBiaW5kaW5nKToNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tDQoNCisjZGVmaW5lIE1UODM2NV9SRUdJT05fTlIJCTINCisNCitzdGF0aWMgY29uc3Qg
c3RydWN0IG10a19pb21tdV9pb3ZhX3JlZ2lvbg0KbXQ4MzY1X211bHRpX3JnbltNVDgzNjVfUkVH
SU9OX05SXSA9IHsNCisJeyAuaW92YV9iYXNlID0gMHgwLAkJLnNpemUgPSBTWl80R30sCSAgICAg
ICAvKiAwIH4NCjRHLiAqLw0KKwl7IC5pb3ZhX2Jhc2UgPSAweDYwMDAwMDAwLAkuc2l6ZSA9IFNa
XzI1Nk19LCAgICAgIC8qIEFQVQ0KKi8NCit9Ow0KKw0KDQp4eHh4eHh4eHh4eA0KDQorc3RhdGlj
IGNvbnN0IHVuc2lnbmVkIGludA0KbXQ4MzY1X2xhcmJfcmVnaW9uX21za1tNVDgzNjVfUkVHSU9O
X05SXVtNVEtfTEFSQl9OUl9NQVhdID0gew0KKwlbMF0gPSB7fih1MzIpKEJJVCgxMCkgfCBCSVQo
MTEpKSwgfjAsIH4wLCB+MCwgfjAsIH4wfSwNCisJWzFdID0ge1swXSA9IEJJVCgxMCkgfCBCSVQo
MTEpfSwNCit9Ow0KKw0KIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2lvbW11X3BsYXRfZGF0YSBt
dDgzNjVfZGF0YSA9IHsNCiAJLm00dV9wbGF0CT0gTTRVX01UODM2NSwNCiAJLmZsYWdzCQk9IFJF
U0VUX0FYSSB8IElOVF9JRF9QT1JUX1dJRFRIXzYsDQogCS5pbnZfc2VsX3JlZwk9IFJFR19NTVVf
SU5WX1NFTF9HRU4xLA0KIAkuYmFua3NfbnVtCT0gMSwNCiAJLmJhbmtzX2VuYWJsZQk9IHt0cnVl
fSwNCi0JLmlvdmFfcmVnaW9uCT0gc2luZ2xlX2RvbWFpbiwNCi0JLmlvdmFfcmVnaW9uX25yCT0g
QVJSQVlfU0laRShzaW5nbGVfZG9tYWluKSwNCisJLmlvdmFfcmVnaW9uCT0gbXQ4MzY1X211bHRp
X3JnbiwNCisJLmlvdmFfcmVnaW9uX25yCT0gQVJSQVlfU0laRShtdDgzNjVfbXVsdGlfcmduKSwN
CisJLmlvdmFfcmVnaW9uX2xhcmJfbXNrID0gbXQ4MzY1X2xhcmJfcmVnaW9uX21zaywNCiAJLmxh
cmJpZF9yZW1hcAk9IHt7MH0sIHsxfSwgezJ9LCB7M30sIHs0fSwgezV9fSwgLyogTGluZWFyDQpt
YXBwaW5nLiAqLw0KIH07DQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KDQpBZnRl
ciB0aGF0LCBJZiB3ZSBjYWxsIERNQSBBUEkgd2l0aCB0aGUgZGV2aWNlIHdob3NlIGR0c2kgaGFz
DQpNNFVfUE9SVF9BUFVfUkVBRC9NNFVfUE9SVF9BUFVfV1JJVEUuIFRoZSBpb3ZhIHNob3VsZCBi
ZSBsb2NhdGVkIGF0DQp0aGF0IHNwZWNpYWwgYWRkcmVzcy4gU29ycnksIEkgaGF2ZSBubyBib2Fy
ZCB0byB0ZXN0Lg0KDQpUaGFua3MuIA0KDQo+IA0KPiBUaGFua3MsDQo+IEFsZXhhbmRyZQ0KPiAN
Cg==
