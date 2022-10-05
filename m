Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9375F5046
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 09:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbiJEHVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 03:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbiJEHVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 03:21:35 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83270696EA;
        Wed,  5 Oct 2022 00:21:28 -0700 (PDT)
X-UUID: d8ec0272405d4860bacc40b757f105e8-20221005
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=VSas3qzcmB/XcP6Rz3vwrQbLQPkbYsvV32MAX1mOiJc=;
        b=tM7+YJZeLaIP6sV/MfJDS/edYRMz48/P2i6E+wNuGa4uda7nscCVUdC74wewti0v+WSSqgC22WVjAsD7l5lzcDZS8KLfwgGrIbp12AJoXwCawQF34Hu9H6KIXLId9FimxCVPOZtZfXZjvwr5uOe70qdphCUqJO0HKYO8oecQO5I=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:2f003b33-7b74-4d7f-9001-fe9c7b13522b,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:39a5ff1,CLOUDID:1665ec69-c578-4abf-baf4-d93ecc5e701f,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: d8ec0272405d4860bacc40b757f105e8-20221005
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1367743099; Wed, 05 Oct 2022 15:21:22 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 5 Oct 2022 15:21:21 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Wed, 5 Oct 2022 15:21:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BVXKEXjgLyzxWZ+d1fXpmso+5FQLjc8wu5w7xmoDg+FJBTnTPo6Ieovzlq8H57NfckH109wGYAXZwROc5KNT4PWMwZeHjaG0X/wdsJ8wwAItT2/uCZ0qpGNSsztPA+DLNioEgLnVn1mRuW0i2CCrnxmscilZvgjqTUoD1p4RNW8VVdvYEswrhKlb8F2iEI7xOayP1ZK/KZQxeSbv0QVa5RqEESiGsHw3sGUW325wTMx2wxz/XzQLPOoPwG/ieWTF3xsXDGNv6V9cLmKW7sOguGgo2gZJEMmAfyl08qlJS1dFVqOb2yvECyJNpzH1Ntq3GDiV4ADDqXY8zvpEn/2+jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VSas3qzcmB/XcP6Rz3vwrQbLQPkbYsvV32MAX1mOiJc=;
 b=nanrEO1UCphwTRGZTheW2Nqkp9/I4nCtmf0XUMcfJG+7Z6z+D35Poarj2FkD/SmHoNCo0Uc98oPn7dabBTj69iW3RXZp9CEeS+hHgMwnEugWRFegXB7tvRKXYZvZTgY0eHOulM+XfhK82gejhf6ruz64gnBOPIcJYFS2iRoL6gRltZC0JIIZgMVRm+hH3MdGb2yId2pO4ujGIAPNk1ZgE9esuTlG0mel0IorzADBDOwmy60BsJV3+IoPOREIkjDDO3Keb/zK/WaCwWn7Zx0GYZ7BoaVNyrs/uAFe4ekqu2YDgkL20WyE2Ntn9kPfBLQlKdEvoGyI90OmSybI6GtBkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VSas3qzcmB/XcP6Rz3vwrQbLQPkbYsvV32MAX1mOiJc=;
 b=IQW16DaG2S/xDvOZvpc4KMxouLcIOyFHlULOp46l0nRWuMC2GJvgKRzgiCSIP+b+m3aD518cdkIxVaWC6eyhGn+WcY+Hz1G7k0EyGo4M42s0Yf5l7v2ElQcKAOXxBXncyxtoQdfQzLjWrGNd/8XEOEOBOxZE1uVMq3AHcLZ8aMc=
Received: from TYZPR03MB6919.apcprd03.prod.outlook.com (2603:1096:400:28c::9)
 by SG2PR03MB6400.apcprd03.prod.outlook.com (2603:1096:4:17f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.7; Wed, 5 Oct
 2022 07:21:19 +0000
Received: from TYZPR03MB6919.apcprd03.prod.outlook.com
 ([fe80::1334:39fc:7259:5f6a]) by TYZPR03MB6919.apcprd03.prod.outlook.com
 ([fe80::1334:39fc:7259:5f6a%3]) with mapi id 15.20.5709.009; Wed, 5 Oct 2022
 07:21:18 +0000
From:   =?utf-8?B?QWxsZW4tS0ggQ2hlbmcgKOeoi+WGoOWLsyk=?= 
        <Allen-KH.Cheng@mediatek.com>
To:     "robh@kernel.org" <robh@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Subject: Re: [PATCH v4 1/2] media: dt-bindings: mediatek: Rename child node
 names for decoder
Thread-Topic: [PATCH v4 1/2] media: dt-bindings: mediatek: Rename child node
 names for decoder
Thread-Index: AQHY1L8dCAPwNN1uhkOBnORLrQwrlq34hoeAgAbmGIA=
Date:   Wed, 5 Oct 2022 07:21:18 +0000
Message-ID: <ffc56eb60a3ef74c815c8d3c170a0df51958e20d.camel@mediatek.com>
References: <20220930112237.14411-1-allen-kh.cheng@mediatek.com>
         <20220930112237.14411-2-allen-kh.cheng@mediatek.com>
         <20220930220011.GA1107972-robh@kernel.org>
In-Reply-To: <20220930220011.GA1107972-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6919:EE_|SG2PR03MB6400:EE_
x-ms-office365-filtering-correlation-id: 36c59e5d-4f5e-4d90-3be8-08daa6a23286
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: faQCKPgJf8Hl/QeIvNq0J9Cr5+F8X6gtJPjAP6w6J99W8zxjrETJ7Cr4chqM2fgvi1EkHgyfAzEFyNNe4aWpLVxqHdUvGCn5rxk89r9bFYJbUCnv8CdmAxZSoOzR9UCNs6a2lZnyOA6UfA8+h0B+GWIXJj+pD/sIlMhppMgZmHwxHw7E2ZUjdepYK6JKZ8QfSjZqesgAVt6/Yoo4dDiFtpb+K94hqzZVg4PYrHpUBXSwG/MSKwqDrqDLoqzzkrtVqE7K7OrBzfiTnwtbBWzL+h4+olXNpB1/JJplD+ZoZhDO6g5RIbQX1TwA8uiDZPyxoaJwA8NFxfiUpVDWLSXAV0bI7z3BvSKgc23/bNK7htpEgPI7b02Yvc+7vYjGuvJRk7Urc8eOQ7p7kdWliKAl/XpA7Vu1q2pcUY9R5g+1gr8x0tiAbKTHBr58RXK5xxWC0CL5vFgdXmsuEsoLFIPtq/AKIwE4XF0OERryATHypW6CwI4hOERyBKMNQZNgAikNIzBnNvBRsYdrsbWQPpv0yWy6ADRF8NEeOQNj10cNYR8LgKk77u28q0GdAFXjfRFDXnuvSgWBJcoYOzuLeqOpMsT6p3d0+wmg3Kxpb74PWQp0wzrrfkHS5Lt9iavjloXKvycLS3Ev46wC78MApG8WnvCGKg0JWHaMgKnMeMA3+2oIskEepi3BucrxTZ2BRkMy6z5IQ+5Xj7zxlXcDQQBYgPxy9fk2tEDAP6bkNSHvIAuwdDtp4NY+z1UI1v0GiA8g417bJ+5EbP0dzfMoappzwg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6919.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(376002)(39860400002)(136003)(346002)(451199015)(83380400001)(8936002)(64756008)(66476007)(66556008)(54906003)(8676002)(2616005)(66446008)(4326008)(71200400001)(86362001)(6512007)(6916009)(85182001)(316002)(122000001)(76116006)(38100700002)(41300700001)(6506007)(66946007)(478600001)(36756003)(5660300002)(26005)(6486002)(38070700005)(2906002)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U0c2YVZWOTdhV0JZT1kxYjFXL05xZWFMOHUrMG1aNXpFN1dLQUxzS2VSOERW?=
 =?utf-8?B?cVQwNmllTlhUbktKOVlUWThMREErbHdWMlIvbE1OaW80SzNTMDB6NVg4NU95?=
 =?utf-8?B?bFR5SDhLaFhXRzR2NGhCcnFpMnZ0RkZGSCtVTGx4clN4ZmtuR0dvdWhkQWlw?=
 =?utf-8?B?WHhNKzNFVWVJK2l1V1NHbVp0MjNUei9jMTZFd2ZVcXZWZkhOekkybnZaZmxL?=
 =?utf-8?B?THRsZ1NKTWdyTzhSTjhyVnVCcURPMFZLMHF5eDVTL1pZY3JGbXU3d2NkS1N1?=
 =?utf-8?B?TVYrU3laZnB5V0NLSVg0US83YTdhc21sSFdOWGxvLy9BMkx0RWdKRW1DVDlY?=
 =?utf-8?B?NUxEL0o3eU5JV2FOMkFhcFMyUkYzL2dON3VpN0cwZFVscG9NeFdXSU1SaEQ1?=
 =?utf-8?B?bWN2eTFKQ2NBcCtZWGJRbWF4WmowaEVyUVFTWWR4ZHhURW1FaGxzMW95aENo?=
 =?utf-8?B?bWN6RjlaRWJEaUJobWF0N1hsK0tzdjB4eFVuSXFmQVRMazhpTU45cy9tK3Vi?=
 =?utf-8?B?Y3ZWcXU3eGZFcE5zbE9Ic0NNdnZFWXdlMUFJT1dlQ2pDWExYYUVkanVBMlV5?=
 =?utf-8?B?ZmVSL2kwbkRGeE8zaG4yb3c2N3BwR3Q1OUdHdnRQSk9nSWpXQVcvakEyQXgw?=
 =?utf-8?B?U3FVYkY4NEk0Ny9NOTFxOUI4NjYveWJTZWxzRFFKVjdrUEl0cTdOdjluMmZq?=
 =?utf-8?B?RjJCYzlJL28rSUNNMzJWYVJFRTVTWGF4MWRLUiswUlIzT1lUb2ZrSE0xUlVI?=
 =?utf-8?B?SDFwMVdsdnpEWTh4ZTc4alBKUHhBOW9LZnZxZXpuSjlObDJrb3M5RW9vQkNI?=
 =?utf-8?B?SkcvR2hDa2MyNVVjb1hYT3JWQVFtbWtNek00SmZjMDE5RzNpQnlrWWdiM01n?=
 =?utf-8?B?dXFKMEUweWZESXkyMm1wVjdNU0g1NURZdFF6UTBBek1uWFhadWlQRUVrNVpz?=
 =?utf-8?B?djVNdUQ0bXhHUndOSk5oazFYd3E1bjNZNUZBOHdtYjRvSUZXalZoclltUVpO?=
 =?utf-8?B?T0JaZmVGbVJFck02MHZxUFJVV3FuYTFoTTFQVi9zc2NIaTRiU3RWVmxYN3hH?=
 =?utf-8?B?MEo1NTR5UkR6T2crZ3hEZVdTdmg2cDg5SjFWZjJiR0Y4MXREcWdtSC9qVEVY?=
 =?utf-8?B?UWpOdVBIUUplaUNNblJjM3M4VG9OTEdUR29FQzYveE1XeEVGTUUyR0swbEpr?=
 =?utf-8?B?cUllNDAwYmNYV1RBQ2YxSmVNTjJobGxOelRleWtoMnJmTDE5Z1FkclZqeXhK?=
 =?utf-8?B?SjdUS1A4dlVLazQ0OFNCMEU0YWd1SUptc004NWJrSEZPQ3lWU2lvMjdoZ1NX?=
 =?utf-8?B?MEpFV0tCaThKanZNeS9DRklhUjJ3ZmN4TnludE1xeUdWa1ZpMXk4MlJjUUx1?=
 =?utf-8?B?NmhGeVAwajE1T1VaOEtTUGhsWS9TNjJoUThlSVNITWpDUWtMQkhuZytIekZu?=
 =?utf-8?B?NkdPR1Y4dXYzbmVNU2tCbVR0STNxNnRGcjg0VjFEcSt1WnRWYUZWb0I5Vjdi?=
 =?utf-8?B?cjhmR3ViT3RZd2tBZEl3VzRXeDlMYlAwRXk0NTdaM3lkV2VtWVN0QzlVMVRZ?=
 =?utf-8?B?NFRwcC9QNDBqc1ZWbkNvN1d4cnJsQWhidFpka0JRQ3Bnd3R4WE5IdUN3aDBJ?=
 =?utf-8?B?NUJ1MDhtZHdxR3NjMnQyTElaOHhhTjZRNmhsNmxtcm9sT0FCQ3ZObmtxaE5a?=
 =?utf-8?B?YksrRFEzbXJPdUNqbmN1WFFiQ0hnbmU2L0hiMXZRUEJBeXQ2aUJRUjdEclBS?=
 =?utf-8?B?aU9hWm5LRkswMGllMlEzWFVPbmV0NkZCL0pEQ0hMbUJsVzUvd21WcTgxNVd5?=
 =?utf-8?B?LzFLMHBPNVEybTR5dWNIdHZVYXhoK1hmRTlBQjBwenl1RGw3REJVY1F1M2dr?=
 =?utf-8?B?VGFpeElSTUU2SjFHd2dtVkZkc2tVWEJ5eG52YnEvSy8zOG5ESkFFZGRtd3V3?=
 =?utf-8?B?OHdKc1RsWk5MT3RJTGxVV0YyTEhMTzZvTFRaMVl6Wm9YdVhrU3kxUStyZW5l?=
 =?utf-8?B?eWlRZlV0dEt1eDluZk5qeGI1cURXWE1ZaDczVEtDcnZ3OFlpdHc5b24wN2pR?=
 =?utf-8?B?NTJkelNBcmw3Y2oweE1yejBMelhhTFJYUUY3aklqR2JJSnZJdlVCVS91M2p2?=
 =?utf-8?B?YzFpOXhqTVV6QXc5V3dmUStsMjNmNXg4S3FOU0lGajI2UHpSUmJBelAvRnVB?=
 =?utf-8?Q?1FCf9+KZQL97bTR4fp8rf3A=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <75867E5C04189B4E85242EDA3BB85115@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6919.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36c59e5d-4f5e-4d90-3be8-08daa6a23286
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2022 07:21:18.8292
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4ypmUCntSfukoRW3BjPmWGK3fXk7NLofhDseugXE+pjjkrjYTHYQ/58m5UxhPJ8am6goBH8vcVToytOdUgel+PaaOkva2gAoZNpIETCwiGs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR03MB6400
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,T_SPF_TEMPERROR,
        UNPARSEABLE_RELAY,URIBL_CSS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUm9iLA0KDQpPbiBGcmksIDIwMjItMDktMzAgYXQgMTc6MDAgLTA1MDAsIFJvYiBIZXJyaW5n
IHdyb3RlOg0KPiBPbiBGcmksIFNlcCAzMCwgMjAyMiBhdCAwNzoyMjozNlBNICswODAwLCBBbGxl
bi1LSCBDaGVuZyB3cm90ZToNCj4gPiBJbiBvcmRlciB0byBtYWtlIHRoZSBuYW1lcyBvZiB0aGUg
Y2hpbGQgbm9kZXMgbW9yZSBnZW5lcmljLCB3ZQ0KPiA+IHJlbmFtZQ0KPiA+ICJ2Y29kZWMiIHRv
ICJ2aWRlby1jb2RlYyIgZm9yIGRlY29kZXIgaW4gcGF0dGVyblByb3BlcnRpZXMgYW5kDQo+ID4g
ZXhhbXBsZS4NCj4gDQo+IFRoZXkgYXJlIGVpdGhlciBnZW5lcmljIG9yIHRoZXkgYXJlbid0LiBV
bnRpbCBzb21ldGhpbmcgZ2VuZXJpYyBpcyANCj4gZGVmaW5lZCwgSSBkb24ndCB0aGluayBpdCdz
IHdvcnRoIHRoZSBjaHVybiB0byBjaGFuZ2UuDQo+IA0KPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBB
bGxlbi1LSCBDaGVuZyA8YWxsZW4ta2guY2hlbmdAbWVkaWF0ZWsuY29tPg0KPiA+IFJldmlld2Vk
LWJ5OiBBbmdlbG9HaW9hY2NoaW5vIERlbCBSZWdubyA8DQo+ID4gYW5nZWxvZ2lvYWNjaGluby5k
ZWxyZWdub0Bjb2xsYWJvcmEuY29tPg0KPiA+IC0tLQ0KPiA+ICAuLi4vYmluZGluZ3MvbWVkaWEv
bWVkaWF0ZWssdmNvZGVjLXN1YmRldi1kZWNvZGVyLnlhbWwgICAgfCA4DQo+ID4gKysrKy0tLS0N
Cj4gPiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4g
PiANCj4gPiBkaWZmIC0tZ2l0DQo+ID4gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvbWVkaWEvbWVkaWF0ZWssdmNvZGVjLXN1YmRldi0NCj4gPiBkZWNvZGVyLnlhbWwNCj4gPiBi
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZWRpYS9tZWRpYXRlayx2Y29kZWMt
c3ViZGV2LQ0KPiA+IGRlY29kZXIueWFtbA0KPiA+IGluZGV4IGM0ZjIwYWNkYzFmOC4uNjdmZGU0
OGY5OTFjIDEwMDY0NA0KPiA+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9tZWRpYS9tZWRpYXRlayx2Y29kZWMtDQo+ID4gc3ViZGV2LWRlY29kZXIueWFtbA0KPiA+ICsr
KyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZWRpYS9tZWRpYXRlayx2Y29k
ZWMtDQo+ID4gc3ViZGV2LWRlY29kZXIueWFtbA0KPiA+IEBAIC05MSw3ICs5MSw3IEBAIHByb3Bl
cnRpZXM6DQo+ID4gIA0KPiA+ICAjIFJlcXVpcmVkIGNoaWxkIG5vZGU6DQo+ID4gIHBhdHRlcm5Q
cm9wZXJ0aWVzOg0KPiA+IC0gICdedmNvZGVjLWxhdEBbMC05YS1mXSskJzoNCj4gPiArICAnXnZp
ZGVvLWNvZGVjLWxhdEBbMC05YS1mXSskJzoNCj4gDQo+IEp1c3QgJ3ZpZGVvLWNvZGVjJyBkb2Vz
bid0IHdvcms/DQo+IA0KDQpUaGFua3MgZm9yIHlvdXIgcmVwbHkuDQoNCmhtbSwgSSB0aGluayAn
dmlkb2UtY29kZWMnIGRvZXMgd3Jvay4NCg0KVGhlcmUgYXJlIHR3byBzZXBlcmF0ZSBoYXJkd2Fy
ZXMgZm9yIHRoZSBNVEsgdmlkZW8gY29kZWMuDQpjb2RlYy1sYXQgYW5kIGNvZGVjLWNvcmUuDQoN
CklzIGl0IG9rIHRvIGtlZXAgdHdvIGNoaWxkIG5vZGUgbmFtZXMgZm9yIHZhcmlvdXMgaGFyZHdh
cmVzPw0KDQoNClRoYW5rcywNCkFsbGVuDQoNCj4gPiAgICAgIHR5cGU6IG9iamVjdA0KPiA+ICAN
Cj4gPiAgICAgIHByb3BlcnRpZXM6DQo+ID4gQEAgLTE0NSw3ICsxNDUsNyBAQCBwYXR0ZXJuUHJv
cGVydGllczoNCj4gPiAgDQo+ID4gICAgICBhZGRpdGlvbmFsUHJvcGVydGllczogZmFsc2UNCj4g
PiAgDQo+ID4gLSAgJ152Y29kZWMtY29yZUBbMC05YS1mXSskJzoNCj4gPiArICAnXnZpZGVvLWNv
ZGVjLWNvcmVAWzAtOWEtZl0rJCc6DQo+ID4gICAgICB0eXBlOiBvYmplY3QNCj4gPiAgDQo+ID4g
ICAgICBwcm9wZXJ0aWVzOg0KPiA+IEBAIC0yNDEsNyArMjQxLDcgQEAgZXhhbXBsZXM6DQo+ID4g
ICAgICAgICAgICAgICNzaXplLWNlbGxzID0gPDI+Ow0KPiA+ICAgICAgICAgICAgICByYW5nZXMg
PSA8MCAwIDAgMHgxNjAwMDAwMCAwIDB4NDAwMDA+Ow0KPiA+ICAgICAgICAgICAgICByZWcgPSA8
MCAweDE2MDAwMDAwIDAgMHgxMDAwPjsJCS8qIFZERUNfU1lTICovDQo+ID4gLSAgICAgICAgICAg
IHZjb2RlYy1sYXRAMTAwMDAgew0KPiA+ICsgICAgICAgICAgICB2aWRlby1jb2RlYy1sYXRAMTAw
MDAgew0KPiA+ICAgICAgICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdGstdmNv
ZGVjLWxhdCI7DQo+ID4gICAgICAgICAgICAgICAgICByZWcgPSA8MCAweDEwMDAwIDAgMHg4MDA+
Ow0KPiA+ICAgICAgICAgICAgICAgICAgaW50ZXJydXB0cyA9IDxHSUNfU1BJIDQyNiBJUlFfVFlQ
RV9MRVZFTF9ISUdIIDA+Ow0KPiA+IEBAIC0yNjQsNyArMjY0LDcgQEAgZXhhbXBsZXM6DQo+ID4g
ICAgICAgICAgICAgICAgICBwb3dlci1kb21haW5zID0gPCZzcG0gTVQ4MTkyX1BPV0VSX0RPTUFJ
Tl9WREVDPjsNCj4gPiAgICAgICAgICAgICAgfTsNCj4gPiAgDQo+ID4gLSAgICAgICAgICAgIHZj
b2RlYy1jb3JlQDI1MDAwIHsNCj4gPiArICAgICAgICAgICAgdmlkZW8tY29kZWMtY29yZUAyNTAw
MCB7DQo+ID4gICAgICAgICAgICAgICAgICBjb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ay12Y29k
ZWMtY29yZSI7DQo+ID4gICAgICAgICAgICAgICAgICByZWcgPSA8MCAweDI1MDAwIDAgMHgxMDAw
PjsNCj4gPiAgICAgICAgICAgICAgICAgIGludGVycnVwdHMgPSA8R0lDX1NQSSA0MjUgSVJRX1RZ
UEVfTEVWRUxfSElHSCAwPjsNCj4gPiAtLSANCj4gPiAyLjE4LjANCj4gPiANCj4gPiANCg==
