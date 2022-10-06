Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE28D5F6449
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 12:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbiJFKWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 06:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiJFKWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 06:22:12 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80101.outbound.protection.outlook.com [40.107.8.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45CEA12761;
        Thu,  6 Oct 2022 03:22:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V5b+3BnILVUXxL1bvgwE9hBlLkUcOzsAIxTEXaGzoLPuJrbogRCHdXUWKMbU6yVGx4NjU8kL0+ZxsmXgUV0U1XUAcNaOkK9w8HnZNBDkqVVWdyEZ5YoLO9ZXjTSpo+/lawLYr9G6aZ3Yij/rba/N/FMdxINXtEiC2lwGApdm/iO5p730cmr8mg/NXHFhg7UBC1RXifWW3BTCiAwbf8IZwdJiyqPLePDqlo1VZPhoLOhEJaig4ppCm1NAyqR5Mao4iCwAdYG3N1eKWbo/+zSSRPdImZm657AT1qpWR+qRGbYTRLbQic0MmE91q2VihOYACf3xGxo9EA9NXCcknGiIWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tC/3PXGDsL+KxpyjjVj2M6zKkuIsW74x0JWttadoczc=;
 b=Ceifm2WqRBqemN7UqlwDb7YsbQc7zP/zgNOOcq3RKQuIHdi2vT0iK1WXIsj99no1qWWKaVdbSGW3Sn8OVrz3JeDEdNpSFv4CHayCpEixQjrhiIx/te2ZUbScrL38feyuTruX+HLGTs1ngNHc7RRltuKjdJrL62lyhHtqpc42AR2mldxkx3rAbx2J/H3AeUsJnLfYVPPGmM0R8yrR6edZSmbHIlTkM5GLCa6DoTBJg1zDhmHYmk2CIyiOyd/gXYrbjuODkVGFEQBmpmiYQDBJbL2Be+VynZwk45gcmfU0c6ysLbrTXaSB7nG55Pv3dZg+dNz4EYubNd/U/wnKUsgh6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bang-olufsen.dk; dmarc=pass action=none
 header.from=bang-olufsen.dk; dkim=pass header.d=bang-olufsen.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bang-olufsen.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tC/3PXGDsL+KxpyjjVj2M6zKkuIsW74x0JWttadoczc=;
 b=EKV7OxEUUISNzr+x8Hr4zWVGkmJeSCku5d94iNJQ0lKFxU86MGEtC3wTdnKx+okCpYOkaPUMR0vMlyngB9/YCG0hdklhOIbzZjuHV8IF7u7V+c/56idW7zbiGexaIo9Vz4VTc4CBFa78C3Gt89q0Q50+cCVsCSGVHcLb2RhdopU=
Received: from AM6PR03MB3943.eurprd03.prod.outlook.com (2603:10a6:20b:26::24)
 by AS4PR03MB8459.eurprd03.prod.outlook.com (2603:10a6:20b:51a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.34; Thu, 6 Oct
 2022 10:22:08 +0000
Received: from AM6PR03MB3943.eurprd03.prod.outlook.com
 ([fe80::f17f:3a97:3cfa:3cbb]) by AM6PR03MB3943.eurprd03.prod.outlook.com
 ([fe80::f17f:3a97:3cfa:3cbb%5]) with mapi id 15.20.5676.034; Thu, 6 Oct 2022
 10:22:08 +0000
From:   =?utf-8?B?QWx2aW4gxaBpcHJhZ2E=?= <ALSI@bang-olufsen.dk>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     Claudio Cabral <CLCA@bang-olufsen.dk>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] ASoC: dt-bindings: add pin-switches to
 audio-graph-card2.yaml
Thread-Topic: [PATCH 1/2] ASoC: dt-bindings: add pin-switches to
 audio-graph-card2.yaml
Thread-Index: AQHY2Mafr+xemZDQ6USahrmQTIqiJq3/9zqAgAEyMAA=
Date:   Thu, 6 Oct 2022 10:22:08 +0000
Message-ID: <20221006102206.6kvbmrassp564vyy@bang-olufsen.dk>
References: <20221005142734.2724537-1-clca@bang-olufsen.dk>
 <365e37ca-1c70-93ae-8507-35f08639088f@linaro.org>
In-Reply-To: <365e37ca-1c70-93ae-8507-35f08639088f@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bang-olufsen.dk;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR03MB3943:EE_|AS4PR03MB8459:EE_
x-ms-office365-filtering-correlation-id: d74a5e88-6efa-4a9e-5d67-08daa7849f9d
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EJ/KxJbLb+n74oKg6BfvPpusFBYHoMdNAtw/V5YLqkrrGuH31isAAlpXWo/KJueZe6EZoW8St05VLcswJcyyD6g+fJtSK4yO3gUIq7NGWj0afhbFX3ykk+z4hPGCiYG7aksfStRpT1q27SmkDzHHIiX1iIGvjrWoG4/+0pg+DpWpJFoeZOqeaFxVla63nXhNVDQnKeS/A9OdFDKhbi93C4mxXjWC3IUbCxqtWRor35/o/QNLB7Xw/R1gi33Yk0J0cYeR+jZpR78+6d2FsvaOd69DIPFOvoIk8n9pSUiHeoKdNris8FBaoBwntymNyBkix4WUvnizHeOPo5PhlplL6ysVte7bxMIfw+vR4Q0esgnv4y7eHnLhI5PvPWNdzt8IKwqGU8gk7dnvYASPc1NVxUGoUJ63AYQh+378d19w7s4vvhTO8qv+kik6oL+rpvgKcspREAQoB0jgXP2SB4buNDkW8hN62y4/ze3wg6AOu0uunSXOXA95ub+iIFF50zBiUR6kqqeMy8YWqvw6ry+KTQkZ3tpezLHsctY4TqGiIiq8ZZRcYI2Sfqv4YE5VcL5SkJUCsnr60ERbmRQXi14GBNYJV3frsR1PbrjCMFnxQ3Vm680cq2QpahyZu124WQ0dppaHcwmA1M8RqebvhmEYNsa4O75qcVv62fMupRUgGMHEVn6z0e/Wa0/pPOzPfVW8Q5jJFpH3QWPZD6ykq5BdRskq/5KnT2GhqQNqs8D/9ZCyEMffvRPbgCn4xws3rxY5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR03MB3943.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(376002)(396003)(39850400004)(346002)(451199015)(6486002)(6916009)(54906003)(316002)(66476007)(91956017)(64756008)(66446008)(66556008)(4326008)(66946007)(8676002)(478600001)(71200400001)(76116006)(26005)(7416002)(6512007)(5660300002)(41300700001)(8936002)(8976002)(2906002)(85202003)(2616005)(53546011)(6506007)(1076003)(186003)(4744005)(36756003)(86362001)(38100700002)(122000001)(85182001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d1VnSzkzNDV5QTdGL1EzOEtMU0pEWnNTQlhTRHVoWkVhWk56aTA0OWhjYTdS?=
 =?utf-8?B?S2ExU0lmY1lBUU55NThCWjF4cnNHaEZVVXAzUUxJYVVvSHRIK2JqT3VZZmZk?=
 =?utf-8?B?Uk1PWi9XT3RaVDg3U1ZLN3BDTzkwNEpHUDFMWDNjWWxBSDIwMHVQODFjNUNl?=
 =?utf-8?B?VkhUaVNoRHErVFZwUjBreTIrZk8yeWVMeXJEV3l0VFFkZGxpNHU2TldPSDFw?=
 =?utf-8?B?a3RRVjlSQWMrRHVnSnJDOFpmZ2xiQ0gvaWppRHJYZmVmMGs2U2pxK0JDYWRL?=
 =?utf-8?B?RVRYNzVVMlNnSEp6YTBkdmN5STl4eFB3cHpJRVdzSHhQcVp2QUt3bmp3andR?=
 =?utf-8?B?QVJjQlZER0h5dFVWZDg0Z2lMdUxlUGFKcnRrZVVqMXhoZXA4ajdPaWYzbFkx?=
 =?utf-8?B?QlQxRnIyK1NFcG9pZ2xkVDVSQzZnSlRxZnZsOFJocmRvMzdxL2JlTkN2N0wr?=
 =?utf-8?B?QS95c3FIeXp6SnMwa1p0WWFvREtweHZjZnh2R0phTTYzSWNLVkNzdEEwMU9a?=
 =?utf-8?B?UlBtRks2Y0ZFWWc4OUhTblg2NC9weHpIajduY0xsYm1uczR4ZVRmVnV2L3Rw?=
 =?utf-8?B?a1pHZ0thRytiVWZLN3lldExMWVd0WENidnFPN3RaM3gwRGpINGlYMnNubnV0?=
 =?utf-8?B?Z2VpeTREMnpaUnZqdE9nLzJVSkppSVdiaXBTbS9UdU4vcUExN21YbXRqd2hq?=
 =?utf-8?B?NitVaHA0bitYZDcrbWlwM094QTdmSjJaRnJGakp3ZnVYb3FHb2NNSWI5aFZL?=
 =?utf-8?B?R05iZFJqMDdoTDUxb0ltK1FmVDU1UlN2UHZNU0FESElQZjBRdEJ3aGNXNGhU?=
 =?utf-8?B?cGY4TmVUT0pUVmhOOElSMEpMMjRsZ1puUWlwMDJYZDdROWtJVWVCemlSYlg4?=
 =?utf-8?B?cDJ5YnpWb2VPYk5FanJ2cGhERElJMFBVMVVRcWdSTkFuL2doVWtEVkZ4WnRq?=
 =?utf-8?B?aXFHQkxhMTFBY1JxNjc5OGxtN3c5aCtqeGEreVZiK3NRdEtzVnRQSHhYcG5l?=
 =?utf-8?B?eXdIMktwVExhRFQwaXZRVnd3dTAweHlhNWViTno2S2E5OVI2NzI3dkhIZTlp?=
 =?utf-8?B?bm9xS3VMa1cvck40RW1veHhJMVlsbzZTYnR4My9oQXlJcjRzMW5Ya256RmND?=
 =?utf-8?B?ZnllZEhQRi9BemlSN1NaeUxoOSt5RkFsb2VxaDl2TjhnNUxTV285SXhibXhs?=
 =?utf-8?B?K0dFZzVxWEpSM3p2dVdkV0ZkY0xxeXJ4ZUZDQnQ5NFJJOFdyWVNjMm5xL0lB?=
 =?utf-8?B?dmhnVVhWZVI4MW82cHBOaVQrR1kvWG8wZHk2K0ViVWhIVEoxaHhva3daY3NF?=
 =?utf-8?B?OXlLcGkrQUZ4Qkl4M2wrcGdRNnFOMHI2VXRQSXVPeVcrc2xDMy82dkg5VUVS?=
 =?utf-8?B?c2xIczhUcndCR2VvVFhUbDZTbGxZMkV2aFdOcitmaHpKQjFoZ0FXdHd4THkw?=
 =?utf-8?B?NFo1K0xmMVE2N2pxd0tWK09JNithbUZ3SnRZRmdzOHR4VWtaWnR6dDZuUmtK?=
 =?utf-8?B?K090cHAyVXRoOVZXbzNwb3FqS3h3MGFsNmVML0xSMEgweS9GK3Z1Uzl2Tk1J?=
 =?utf-8?B?RmN6cElZNTZoRGo0TGdNaUNmTWwyZUlwaU5JQyt0ck9PeWlhUUx1UUNGVVNl?=
 =?utf-8?B?UHY5aDMzVVR5Yi9oRjdXazA1cFFhc3djMU5BcUYxZTdHT3dLR2x0ZFlFdk5S?=
 =?utf-8?B?blFpYXlUbC8wYnUrbUQwSHNBc0VEcm5WOHVMdVEzTkRPV0J4bnRlV2JyMFgz?=
 =?utf-8?B?c210TzRLcFgrcHozclJraHQxWk5HdWNYdE5SRnh2OExzM0UyUDh1K3FNK0tw?=
 =?utf-8?B?djRJbUE0M0ZTWisxWW53L0hMSlZuZ25kakYxL2t3cEREd1NzTG1RM2gyM1lQ?=
 =?utf-8?B?UEl0TW5VL2RxbUYvK2FtSnJWdXkwWXJqbkNxMnRZUjQzNmJHai91WXhJSzYv?=
 =?utf-8?B?WFJ4bk15dEc2RkpwNm1heGVtdG8rM0w1VjNyaE1GQ0U2dnVKSDY2cjlkZHU2?=
 =?utf-8?B?dUdyelprSGVYS245bXhxMEk3cEFkRjRxR1dPNE82YkJGMFh6b1FPTDRtbE9t?=
 =?utf-8?B?MTdvRHk2VjM3blo3MmpYYWVxUXpKWWtCSjFVRUZUUitqcENieVdNcEk4Q29X?=
 =?utf-8?B?aUI0VnUzYlg3TVdaZENoNWZPd3dQVWY1MnFBTGhURzdxTlo3LzAvcWM4OXlF?=
 =?utf-8?B?TWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <71BB662D2D39D34DBBC1B186545047E6@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bang-olufsen.dk
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB3943.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d74a5e88-6efa-4a9e-5d67-08daa7849f9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2022 10:22:08.1446
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 210d08b8-83f7-470a-bc96-381193ca14a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3JtIr7ZKT27njtJkvAQGQOkWas5bc2o/qgzqgUrAxgDPUZmtdTh9yclO86ibmOF2p7pF071DQW67qtNm/TwLvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR03MB8459
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCBPY3QgMDUsIDIwMjIgYXQgMDY6MDY6MTNQTSArMDIwMCwgS3J6eXN6dG9mIEtvemxv
d3NraSB3cm90ZToNCj4gT24gMDUvMTAvMjAyMiAxNjoyNywgQ2xhdWRpbyBDYWJyYWwgd3JvdGU6
DQo+ID4gUmV2aWV3ZWQtYnk6IEFsdmluIMWgaXByYWdhIDxhbHNpQGJhbmctb2x1ZnNlbi5kaz4N
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBBbHZpbiDFoGlwcmFnYSA8YWxzaUBiYW5nLW9sdWZzZW4uZGs+
DQo+IA0KPiBBdXRob3JzaGlwIG9yIGNvbnRyaWJ1dGlvbnMgKFNvQikgdXN1YWxseSBtZWFucyBz
b21lb25lIHJldmlld2VkIGl0IGFuZA0KPiB0aGVyZSBpcyBubyBuZWVkIGZvciBib3RoIHRhZ3Mu
IFRoZSBjb21iaW5hdGlvbiBvZiBib3RoIHRhZ3MgYWJvdmUgaXMgYQ0KPiBiaXQgc3VycHJpc2lu
Zy4NCg0KVGhhbmtzIGZvciBjbGFyaWZ5aW5nLiBJbiB0aGF0IGNhc2UgdGhlIFMtby1iIG91Z2h0
IHRvIGJlIGRyb3BwZWQsIHNpbmNlDQppdCBpcyBDbGF1ZGlvJ3MgcGF0Y2guIEkganVzdCByZXZp
ZXdlZCBpdC4gVGhhbmtzIQ==
