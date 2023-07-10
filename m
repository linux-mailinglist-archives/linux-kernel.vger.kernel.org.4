Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B845774D996
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 17:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233540AbjGJPKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 11:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbjGJPKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 11:10:53 -0400
Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01olkn2141.outbound.protection.outlook.com [40.92.63.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE986A0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 08:10:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cBSViALkQ1GKu3UCHkTDfxVXV7h6wSCpUKIekYQ3jtc5zBCvD5v+n6Cvtr0exhAsbx62KBEed+TdzBFUuVpf3IPp89RHfJZ+VjJmqcCIlmMTXRMuFx5N13L0kXFS3wZy1I+4Ba/AZ2yY8xdYQWtZvZomqvFBg7vlz+g5vcZRCT8BOI0YCWWxc7nDhiFcShZVF/YrXfimnv2l5ASEhe7SUY8RSv7BUjNmcouVXkuC31MfZ3X9umj/ECk5V/LQBcH4Oe3+VLPXRkzUh30aGepYsmQAKn0OULyS6gziJdtqIxmSOiQ1e1HusQeoNjcBoY46J1xR1oa4IrTV9cgxw/IjbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EjJjXPx/zmFuyFUtvc4G14ke0031sGsYfzPcKmIEm88=;
 b=NxLPaKn6tWoZQXLULNxN6mWPBVb8oU/urTQsemyC3/jsJX4cM/I9/mExQ2jkHW5ylRKMLy01zC1FxCiOtYm0co1yeZk3c8gec3nMpAMvdAaM1AcOuGL4RAIGbqtWVbIeaftM1hKlwDS5LhOIKYtfY2QUIPXcuZg/njJjH+HIv4WeLTwpJAkgAD2DE8ar1SNhvsP1OCUgqmWGe6VHp3bHQuyLWvZcacPLB6iJW4fRy7l9Oisck09g48K+ByrHIrNOBE/5tUdOerLf6Lcmf541B2yugzvCWijwx9YM51wRCSjXYB6QvZhXk5jM4g6svACA/YOIktnOYgu49I1MhRiJMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EjJjXPx/zmFuyFUtvc4G14ke0031sGsYfzPcKmIEm88=;
 b=qmbiK6bsY02NatTOSOSSK1el3zt0xIfq8bpkuuWGFhPRgOPP/75ywa5Ys6ahnz1eWLIlBeoDtVOHlVROcC5l+O7El2gjLHWCsuQQ4GfvYzU6wKgRKD3O817xvhe8Huy4tTMsWd3WQ1nTicYROzAAFUhluhFmGaZpEkjFNb/w2ffYm17XjLSxYMYLG06k2A7x/NN8raspmkj/AxJcJkbxWsUbnqKfcT1fFHLZk99Imoaeapk4Ye3mqoImGew7JauOSSoMMBqBaLoOxtJDB9qPFIOGQef1ZcA7lnN8odWpqZdxXJatyTXNn1AYg85BY+uVYg45JybZXqKwJdfkZu5S/Q==
Received: from MEYP282MB2597.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:128::9)
 by MEYP282MB1928.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:c2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Mon, 10 Jul
 2023 15:10:47 +0000
Received: from MEYP282MB2597.AUSP282.PROD.OUTLOOK.COM
 ([fe80::46f9:569d:f1c:4f6f]) by MEYP282MB2597.AUSP282.PROD.OUTLOOK.COM
 ([fe80::46f9:569d:f1c:4f6f%4]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 15:10:47 +0000
From:   =?utf-8?B?4oCOIGRvbm1vcg==?= <donmor3000@hotmail.com>
To:     "chenhuacai@kernel.org" <chenhuacai@kernel.org>
CC:     "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
        "kernel@xen0n.name" <kernel@xen0n.name>,
        "yangtiezhu@loongson.cn" <yangtiezhu@loongson.cn>,
        "zhoubinbin@loongson.cn" <zhoubinbin@loongson.cn>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "tangyouling@loongson.cn" <tangyouling@loongson.cn>
Subject: Re: [PATCH] loongarch: Make CONFIG_CMDLINE work with
 CONFIG_CMDLINE_EXTEND and CONFIG_CMDLINE_BOOTLOADER
Thread-Topic: [PATCH] loongarch: Make CONFIG_CMDLINE work with
 CONFIG_CMDLINE_EXTEND and CONFIG_CMDLINE_BOOTLOADER
Thread-Index: AQHZsmnnf7L6P8pq70KmLgqGjaEZu6+xj+EAgAAiuACAAO/FAIAAejUA
Date:   Mon, 10 Jul 2023 15:10:47 +0000
Message-ID: <5e7a5304b61f1339ab5229c7300f11f769ce47f0.camel@hotmail.com>
References: <MEYP282MB2597CD6E861D659E3218148DD933A@MEYP282MB2597.AUSP282.PROD.OUTLOOK.COM>
         <CAAhV-H5P_NgJ5kTQ1iO-eL577D=-COjEZ6u9_OgvrHpWJLqsXw@mail.gmail.com>
         <62e81ce06e69d549b12d1145429730f8b27ad156.camel@hotmail.com>
         <CAAhV-H7ihMnYD3LZi4kfJ1SQHxpX=j8D39Riinbvbb0AMo2oDg@mail.gmail.com>
In-Reply-To: <CAAhV-H7ihMnYD3LZi4kfJ1SQHxpX=j8D39Riinbvbb0AMo2oDg@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [nElOfXoBPOBnQTABL9osLMdKaRBNU65UdyYqvw1i2NNMy3trt2quP2rlWF7F3sBa]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MEYP282MB2597:EE_|MEYP282MB1928:EE_
x-ms-office365-filtering-correlation-id: 3ffdf2f1-adf2-422a-0575-08db8157d700
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AAXe2zM09F2XdKX1EzU8/WVeXInjFcp/QAqBd9eLMRS2ifk+dllbjW2rKXLjGISagL9W9VP5k5Yva+oBlaD3wHoX+y0LobMzpwvrjEOUAoTBPemgYsvaYB7id9BxeBlPbEQqvD1gnCoqww5NSUJUUMxBCTKSUuO4Mm9uU4eVPbEehCbfkCoGfXokPglA/EWhvW/UGZZT42cqHkQ6WoItbkFhvWsvP06QHSd6ZueN5/cj3xl+d+JO1Iu6jIzpYjKg8I9Pc2hOkthrVuWB6u0QEK1Ehg+BsaMo+XRJM562+V3ugMO+unppn25eV1ZHZi8zA5bV+qbMHBI1lB2oz7GUUaSyHgk4KdKRooXvLgul2tdXjK414jJmLu30DppL4WxFF7scoboeql7cPXcSEB3ETfSC0yQnHKulmZ4v5xShFqsqqkeVMHPqs1SssycughPhG7JX1TqJVaJxH6v7TVjjKnTNt+eExtaTs9/KWy4OQnPJam4TG4l0cN4ZbhEtpb2nZd7E90oULmIxpO5WFFpWUCzpA2iSTi6+wTGUPuR2PFe3sQoaHr6x9XO4LRISWGAo
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NDZJQndHRWVTZEhUWEMvNkozSDF1YzJ0NFZIL3hHTVRZSzNCY1NXSHp2dmU2?=
 =?utf-8?B?SUgvYzFEZFFhRmIycnY3YlIvWFEwR2hrQjJkOThwb1U5QnpNaCsrcWJRc054?=
 =?utf-8?B?RGVXNUlnUlJwWlhUTGNCRStSMmNha2EwWlBuWVRjblB2SE5CbWExQk1XR0k2?=
 =?utf-8?B?Z1lad3RBWDhXTGw3d0xYdFZuU3pZOHUvV1VXZFN5T2c1cXFETE1aVVowTjhZ?=
 =?utf-8?B?aERhLy9VVUUzVEk2ZENsVTNxWFhXRE9ZWFdxRVRVMUR6cHN3L21uU0JVUldT?=
 =?utf-8?B?SFlvVm0vOGZESzJHLzAwdjd2SDh6cGhtRHB5NnN3SnM3c3ZPbWw1ZExhV1BW?=
 =?utf-8?B?QkpkSytaTTRxbGljNHRwZ1hiWmhGOVZqd0tPeUhXMjRsU2xxV09uWk4vNm9q?=
 =?utf-8?B?TlE4d1Mxa29uZjRYd0FSZDZnUmdPMW0yYUJvYzFzN044RkI5Q2M1NGVXWG1s?=
 =?utf-8?B?dWZ4cFJ2NFJYZVhWR3FOaWUxRlAybU05WEZsMzR5cysydFVBS3lrYUUzMnpx?=
 =?utf-8?B?WkJGUjFVS08zVWI0d1NXVjlDMVA1dGJ2RlZyZkQ2Yy9UNTRna3pPakdYaktk?=
 =?utf-8?B?elJseHpreDlQWktMMXFZakM1VGFHNnMrVitGWXJONXJqNy9GMUtOVkJ1ajJl?=
 =?utf-8?B?NzJBZUNJclQ2UmM3YVRjK2lEU1ZmekVMQjVuNlNMd1BDK3RQVkJNWFU0TElN?=
 =?utf-8?B?MmZKa050WmpMNHJXVDVNdTJIblRqSXdia0NqeDkrbVVPdTZzOE9tZmE1OW1G?=
 =?utf-8?B?QTZnT0pSK3AvOTFaWW95MXFZUUlJcVdCcjFLRzdJb1IwbmRnNlNwaE85NU5k?=
 =?utf-8?B?RGgxRWsrNjQ4bloySktGUEtLcmNBaHdIYjRvckVRTFhqUW1WRm9RRDFQd0Jn?=
 =?utf-8?B?UWNtdXhHREF2Z24xL1JrY2M5NDA4VTExVnE0YWpPVHVnaHdGYVJRQUFyMHlp?=
 =?utf-8?B?WVdsN1M4d1VNYjBuenZzOTdzandKTUVHcTExdk9Tc3RHTjdTL2VWcnYzcnBj?=
 =?utf-8?B?SEtaKzdUSjlBeFIzYzE4RkpBUkFOZllXckxyNFpFUEllUG5zZkhtcGd5MkZw?=
 =?utf-8?B?bjlXMmdWWEN4Q3ZxMkhBd1ExWm5Ub3JCOEhvTjFSYzlaVTh2K0F1TTBPcFY3?=
 =?utf-8?B?OUM2eDdYZWkwZEp3NU9mL2Q0MnVsdkZobUNFeUFDTUR6bHRPdDVHMlhsMkJi?=
 =?utf-8?B?NnN0U3YyRmVBbjVpcEZTeWpnV05EMm1vVDQ3VzdueXJPTEp6enpMOU9FNTMr?=
 =?utf-8?B?S2g2RlZud2R0MTZoeVA1RlhieUhKLzJCaTRGclU0TXlRV0NoUHc1Qm9EdGlt?=
 =?utf-8?B?c0JKWjN1KzNCUVpkT0RuTUVadXYzODRWY1RiRjk1cHZGdm9vQUJuS2R4MWt6?=
 =?utf-8?B?V3k2QnZHN2x1VlBWaUI4L1FGNzNtMzBJU05qVkg1cnpvZlNtOWZlU2wyQUdW?=
 =?utf-8?B?L09OYVJJZEdKblh4c3R4VWVYU0hyb085eG5CcWpDRFRQYS82MWNhS2lNMmtH?=
 =?utf-8?B?M28rOWlxeHJSRUlHR1VudzYxbmdEam9uR0FLOURUamlTNEpUa3NwRjJiOHl5?=
 =?utf-8?B?dE9EcUE5ZnRBNUFxU1plSlg3VlJwd09TYUM5bWd3VGhZOFlwTDJtRndSYzdh?=
 =?utf-8?B?NktwVEhkZC9yWExBUWhOMU9GWU9qenR3aUtVcys0Mkl2YmtXbDFWNUgyWmRa?=
 =?utf-8?B?N3pKQm1KeEp6Ky8vUXBjNkZ0OWZkQXJyVDdnWUFGQktxSlQzb3BEbzRUTU9m?=
 =?utf-8?Q?6YrS5CERP28FbzdzdY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FEDC66507F983449BD18A1196F028BE8@AUSP282.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-746f3.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB2597.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ffdf2f1-adf2-422a-0575-08db8157d700
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2023 15:10:47.1993
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MEYP282MB1928
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5ZyoIDIwMjMtMDctMTDmmJ/mnJ/kuIDnmoQgMTU6NTMgKzA4MDDvvIxIdWFjYWkgQ2hlbuWGmemB
k++8mg0KPiBPbiBNb24sIEp1bCAxMCwgMjAyMyBhdCAxOjM14oCvQU0g4oCOIGRvbm1vciA8ZG9u
bW9yMzAwMEBob3RtYWlsLmNvbT4gd3JvdGU6DQo+ID4g5ZyoIDIwMjMtMDctMDnmmJ/mnJ/ml6Xn
moQgMjM6MzAgKzA4MDDvvIxIdWFjYWkgQ2hlbuWGmemBk++8mg0KPiA+ID4gSG93IHRvIHJlcHJv
ZHVjZT8gSWYgeW91IHVzZSBVRUZJIGZpcm13YXJlLCB0aGlzIGlzIGhhbmRsZWQgaW4NCj4gPiA+
IGRyaXZlcnMvZmlybXdhcmUvZWZpL2xpYnN0dWIvZWZpLXN0dWIuYzsgaWYgeW91IHVzZSBub24t
VUVGSSBmaXJtd2FyZSwNCj4gPiA+IHRoaXMgaXMgaGFuZGxlZCBpbiBkcml2ZXJzL29mL2ZkdC5j
Lg0KPiA+IA0KPiA+IEluIGZhY3QgaXQgJ3Mgbm90IGNvbW1hbmQgbGluZSByZXRyaWV2ZWQgZnJv
bSBlZmkgb3IgZmR0LCBidXQgdGhlIGJ1aWx0LWluDQo+ID4gY29tbWFuZCBsaW5lIHRvIGJlIGNv
bmNlcm5lZC4gQ09ORklHX0NNRExJTkUgd2FzIG5ldmVyIGJlZW4gdG91Y2hlZCBkdXJpbmcNCj4g
PiBib290IG9uIGxvb25nYXJjaCwgdW5sZXNzIENPTkZJR19DTURMSU5FX0ZPUkNFIGlzIHNldCBi
ZWNhdXNlIHRoZXJlIGlzIGNvZGUNCj4gPiBoYW5kbGluZyB0aGlzLiBUaGVyZSBzaG91bGQgYmUg
Y29kZSBoYW5kbGluZyBDT05GSUdfQ01ETElORV9GT1JDRSBhbmQNCj4gPiBDT05GSUdfQ01ETElO
RV9FWFRFTkQgYXMgd2VsbCBidXQgaXMgYWJzZW50IGJ5IG5vdy4NCj4gDQo+IEkgbWVhbiB0aGUg
Y29kZSBpbiBkcml2ZXJzL29mL2ZkdC5jIGFscmVhZHkgaGFuZGxlcw0KPiBDT05GSUdfQ01ETElO
RV9FWFRFTkQgYW5kIENPTkZJR19DTURMSU5FX0ZPUkNFLCB1bmRlcnN0YW5kPw0KPiANCj4gT24g
dGhlIG90aGVyIGhhbmQsIEkgZm91bmQgdGhhdCBmb3Igbm9uLUZEVCBzeXN0ZW0NCj4gQ09ORklH
X0NNRExJTkVfRk9SQ0UgaW5kZWVkIGRvZXNuJ3Qgd29yaywgYnV0DQo+IENPTkZJR19DTURMSU5F
X0JPT1RMT0FERVIgd29ya3MsIHNvIHlvdSBuZWVkbid0IGZpeA0KPiBDT05GSUdfQ01ETElORV9C
T09UTE9BREVSLCBhbmQgeW91IG5lZWQgYWRkICJnb3RvIG91dCIgaW4gdGhlICJpZg0KPiAoaW5p
dGlhbF9ib290X3BhcmFtcykiIGNvbmRpdGlvbi4NCj4gDQo+IEh1YWNhaQ0KDQpHb3QgaXQuIEkn
bGwgbWFrZSBhIHYyIGFzYXAuDQoNCmRvbm1vcg0K
