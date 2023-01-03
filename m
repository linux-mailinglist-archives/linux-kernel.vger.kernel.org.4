Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCA3F65BA73
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 06:39:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232978AbjACFiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 00:38:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbjACFin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 00:38:43 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C278F6412;
        Mon,  2 Jan 2023 21:38:37 -0800 (PST)
X-UUID: a10e254d6b6b455d869e22df04e0dd8c-20230103
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:To:From; bh=CbnlZZabiUrpOXnb1M6mfSY9mnWhB7l/UzQT6gCxfSk=;
        b=lq+3iPt5qay7Bk/1RcMclNn03SJSZWh7NOvOOwypkQP+qR5CqQeq+qu7qYcQndpLHcPu86wWj26MlDhoxNnEuculYsekilNmQHaShbNK//uB8BB7xZZLpkGVOENvuVzhAvx9wg2BTNtIBGfpzpe+l+cXubDS+XYWnxvC8JDcRtc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.16,REQID:cf9134f4-9673-4c29-984d-a5ccb056881b,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-INFO: VERSION:1.1.16,REQID:cf9134f4-9673-4c29-984d-a5ccb056881b,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:-5
X-CID-META: VersionHash:09771b1,CLOUDID:cc847553-dd49-462e-a4be-2143a3ddc739,B
        ulkID:230103133833OW1V6QV6,BulkQuantity:0,Recheck:0,SF:38|17|19|102,TC:nil
        ,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,O
        SI:0,OSA:0
X-CID-BVR: 0,NGT
X-UUID: a10e254d6b6b455d869e22df04e0dd8c-20230103
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2139534304; Tue, 03 Jan 2023 13:38:30 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 3 Jan 2023 13:38:29 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Tue, 3 Jan 2023 13:38:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oLi8Cc+jrxYLpNPXUOuqTpQ8mk8hf2QJXNVRpIpcv7imfyfBpVGmt3LTmocB0VEHh4D6kQiOZpgg33HW5qrj1/QhpRAvqmgvoWvKYrD+Vb1K1Ipyg23USqBaPED6YIWdAnvC8nDMV4b1eG3asxxjG+jT90B9HAwGUhyIOa1OAIFVa1zxnfhOEuMW+zUylZXlJWVS/PYHjsBJKTCHo2MLUswz8RvGJwPh1VzxEbBGx+XOKReydOJPEJw++TDSJ7wBlhwzcamOcDiUq3B43pl55aPg8BEa+XpByd3/sKOgFaMnI2GDMvdCPcDylSOMbwPW9pzrmRCYRvnW59pR+YUtrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CbnlZZabiUrpOXnb1M6mfSY9mnWhB7l/UzQT6gCxfSk=;
 b=WjU9+OrGe+wPhvTSvWPB5fNzK560pjjyEcwW0S/XReVaMd8Pfy3kQYnE8O1BrQvCg1Vk73UMYuGPehBvE7z0edWTnSxOcJjJq+4JPgolOGBLvGHK0hLc17zDXgFWu6RTkIdSrFCAj54Rd+zap6k9rowkW0o8lGEbJF9TbRYssdiExuisVa3811PQlqCqxBdzWEyR6tmbpxPe7V51zwy1JWb40AHDAK0li5118sgMyACK0AOQTSn+QMnBPaO7JU5F3WLeANX+KQ7COKNen7mIfCecop41RaGTLaAsdUb+RYMSoqLIO5qxaPtpKMFnQEgkLETi/i7gx/jfqvtV938chw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CbnlZZabiUrpOXnb1M6mfSY9mnWhB7l/UzQT6gCxfSk=;
 b=jp90OZHkwl9TOdwoNk3bDaw3BQbFahaT4zoR9lySoV2yNdhqGfOgPxT8UXmlUDsA+bM0CdiNTk5MpdMUN293NxRNVM8RNL2sUdeePxDHZt7WYGMghhfYhxm7JmA+YPer2fZBvXUvYRhap9V+BotWKqOJTBQ3iKbgrnqaxHQT3xY=
Received: from KL1PR03MB5062.apcprd03.prod.outlook.com (2603:1096:820:1a::22)
 by KL1PR0302MB5441.apcprd03.prod.outlook.com (2603:1096:820:45::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Tue, 3 Jan
 2023 05:38:27 +0000
Received: from KL1PR03MB5062.apcprd03.prod.outlook.com
 ([fe80::5e9b:f4cf:8d7f:60d1]) by KL1PR03MB5062.apcprd03.prod.outlook.com
 ([fe80::5e9b:f4cf:8d7f:60d1%3]) with mapi id 15.20.5944.019; Tue, 3 Jan 2023
 05:38:27 +0000
From:   =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= 
        <Chunfeng.Yun@mediatek.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "maz@kernel.org" <maz@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "lee@kernel.org" <lee@kernel.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "bero@baylibre.com" <bero@baylibre.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v6 5/7] dt-bindings: usb: mediatek,mtu3: add MT8365 SoC
 bindings
Thread-Topic: [PATCH v6 5/7] dt-bindings: usb: mediatek,mtu3: add MT8365 SoC
 bindings
Thread-Index: AQHZHI5WTqt8UnXMHUCcb8XijsQO/66MMhcA
Date:   Tue, 3 Jan 2023 05:38:27 +0000
Message-ID: <1b8645eef08313cbe21e7519ee4df63627fe3f7e.camel@mediatek.com>
References: <20221230203541.146807-1-bero@baylibre.com>
         <20221230203541.146807-6-bero@baylibre.com>
In-Reply-To: <20221230203541.146807-6-bero@baylibre.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB5062:EE_|KL1PR0302MB5441:EE_
x-ms-office365-filtering-correlation-id: c8431f0d-5daf-4c57-3da6-08daed4cbd35
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rr9QYpORiKErGa2ILoEuCaf3yogNHNV+TLeOs9ayXU2JRIThh+iF3pBbpekBBP8UbAtItqqqknBdEiy2UXKKNuRQMNpuzd4snX73xBG/nV7O2iW0/y5wehRtMjVHL1sSelSZPkXpyl8ASVPvYBg9kW4lSj/aHpN19IBxl0USNe011Z9sBx0yTfXwvBkhumkcqB+zjqBUEOzy6GFuLoe1t7Gjb6kk9eZc8mfQnZW6lLORDeKl6NM/p/JscoXg/EiUq1O1dVD04bHkPobIgOW0rWHLrFlcnsAw3Zr+DuoHwnYpThY1sz5/lgVzKHvqWjj85DprvcgpTI25U7SHYvqdyIv6Us31iUWnZVah5LoRpmX/25aNAeUm2TdlApFwYl3WxVBajEf7mHlOwlh6k7VsRTOC7wTnpdOX50C3tLusrUhc15L2vE0EBaCroYcfcUNOPebs4KN5BPVMktwSfPJQvGfsGMz1mgQ/e483D6V2lTsM0S4i//MonDoOODgR4BpT8uTnVnQAsDg4aRUOPUVjpx5Qk3nc1X+x6xOSZo53Htd8Mvld3B4VnuJtYPgGyHbOZXVBMLZr0i3LjGtiijhAEsvhpmcUyJXaR9HZt0Jcfaf5o+VOxPNs+pCp9tIdcb/Z+mRtz9nJ6SoIMxlAtqtQAvd4Re43EWp016jq2Rv9W68oahPKxVD01knYuhpHpIc5au+nxJ2eQYLisViyKWq5aBCvBUVi1qzIszAF3Wuxs4TzK5EPp6R3BLcUcZuyA5m3
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5062.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(39860400002)(346002)(366004)(396003)(451199015)(6512007)(26005)(6506007)(86362001)(38070700005)(36756003)(85182001)(38100700002)(921005)(122000001)(2616005)(186003)(478600001)(41300700001)(8676002)(2906002)(4001150100001)(7416002)(5660300002)(8936002)(4744005)(6486002)(71200400001)(66556008)(66946007)(76116006)(66476007)(316002)(66446008)(64756008)(110136005)(22166006)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SVNEYWNJYVlndldCVkYwUThQRVBNbXY2cGFGUXk1c0hMZzVyYWZwbEI1eExk?=
 =?utf-8?B?eFQvWDFOclhHK1ZtNUwyODZaeDA1UjVoYzRKd1JaSzhibXlndDlnYWFFNjNV?=
 =?utf-8?B?VFRsNHVYamVBNTk5bkJMbk1zdk9wOWpjaU15Y1ZEY0dhRkdLS1h2TVNyVndW?=
 =?utf-8?B?aE9NNitPU0h5bzQ0N3RYSHFSaWRQOTNYV2U1YVZpVXRiUldZZUtKdkdlYkgx?=
 =?utf-8?B?TCs3eGEvRDhXU2MzSjZuMEg3allFZmFFYm91SkJhUEdZK2FwK3drWjNlSnB6?=
 =?utf-8?B?dmJCR29rcFZsaEJDak1jamVXUzk4b2dQWi9IcWZoOWw3aHh4ejdPdnBJNjJX?=
 =?utf-8?B?dEt5SFpkem9IUGFHVDJpRFBwUHFxU1NjY2VqM0NVczRVaTdjaXA3L0FiTzlF?=
 =?utf-8?B?cHhncXlUV3Z6OVlBZU1mejgvKzkrMTlvOE9BbjZjZ1JUcm1RUHNIWWlpYU5u?=
 =?utf-8?B?aTFuTy9vY2ZrNFRpSmIvM3FEL1hsWmVHSFd3NUNmVzM1c25aUFl4WC9haU5J?=
 =?utf-8?B?SFlMM3RZZytYR0xOSWxiM3pVMmRtVWJRQzJGNUtEbmRLL3NIaGk3SXNDMHdB?=
 =?utf-8?B?OVVsN2xFd0o0eURTVFFFOFl4akF5Lyt2M1hhMjZtOEdvdXJBcEJMV0lpN1Q1?=
 =?utf-8?B?SzA4YWRTQUU3dG81aW4yWGhNY2dCQkFxVVJEWlFBSzhnT1hZZGVNNnNVNmdN?=
 =?utf-8?B?eXBnNFBZWnJjRWgyWkNFRkwzcGNCbFM3Tng5UFZTRCs3SUhGdDVMR28zS1BH?=
 =?utf-8?B?dzFTUkxHaHZkcytOWVcxZm5YRXR3Y1oydHl2VktjaVVNRER1RFIxMGxrSEdR?=
 =?utf-8?B?SWU4N2FQNmY3TGZFd2dxdXVZaW5WV3Rxdm5HODJuY2J3R2t3ZDlCUEZuM2R3?=
 =?utf-8?B?cm54Z3R3bHVUK05EMFUwMGgyY0pycmJDVXMwbDlSZE45SUtNclN6UFFId0JZ?=
 =?utf-8?B?OHVuM3AzUXdwTTdESUNiOG1oclA0SXpCL2Uxa2VYWXRMZUdURXpSYlp0cUtZ?=
 =?utf-8?B?K2tSRkZ5amVHOFhEYVN2aFVsYzV3dXk4alpkK09xU1c5MmsvSitJaEVKVk8z?=
 =?utf-8?B?NG5WWGpXTmhRWExZeGRlUGhTbC94RU9BYi9qb2FlaHFHNGdtQzBkZ0h2Z0Uz?=
 =?utf-8?B?RDZCOE5meEIwcEFDbTVWbHJMNUxlcndIV2ZEWTFOS2VtOFFVY2prNUFrNU14?=
 =?utf-8?B?dU95R3Z3dHFsaUhkNDJNTVN4VTdzSGRHUGFSUnRQWHl3ejBlOTVpZlEwMjR2?=
 =?utf-8?B?ci9yeDljVlVib0dhcUdIQkJOdU1SamMwS3FrTE4zNWtMV3E1L21KN2tvemYy?=
 =?utf-8?B?V0lPVEt4d0V0eGxMWnFOa2w1RmZKOFRudlVheGZodUxLTVRHQUdEM21ZbXJC?=
 =?utf-8?B?S3paemtia2Fhd05IbE5PMnVEOHVwaExqVGFmT0FJRVhna0duZEh0bkpoa05R?=
 =?utf-8?B?RDBnRjU2eGRmNWtrWGRldTRxTlNsZ1p0TTVxaHk2S0FwbUpUSmc5M09qYUlz?=
 =?utf-8?B?cTZRWHE3ZGdvYi9tbndDVnIrajNLcW9vQ3NPM1dxVUUwN0l6LzRlbXduUUo5?=
 =?utf-8?B?TGcvMGZHMTQ1ekR4WC9oQTNMWEI1M2FlZ3ovMFVTR2tPLzBKaVRuZ1ZDL1pM?=
 =?utf-8?B?OU9USUxDVGFpK2ovVDMwemlpY2FOU2o4Z29iZTNKWmhlL1J5RWVtRTdZY2Ey?=
 =?utf-8?B?UHdsKzNiMXh6SkZhVHlYZG1ZRzhoSXZoVUg3STBCZERjYjRudUVFZEUzWUFm?=
 =?utf-8?B?Y0R1emFkNEtCYlJmVzR3U3dMWURLWk91NTZxS0NuN25NMjJKaldlV1E0bGRH?=
 =?utf-8?B?QVMxbTFCQjhydTRIbU1FUmhTUEF1dXpVenNqd1U0UlhRVWE0KzgrMDltcTgw?=
 =?utf-8?B?Sm5mRWQwS0psZGZTZjlnYklwS0JMT0VLcTE4N21Ca2VaaUZzOHc0ZGxIM3Zl?=
 =?utf-8?B?S1A1UzVvUExLSCtBWTExalpFOXBzRzRtRFlQMVk4cWJOWkxTdEpJMVpVNWVa?=
 =?utf-8?B?cVJ0OFBvbU1UZ09kTDhZays0em0xOGpQU1ZiUFF2Z203TytJb1huVVNadC9o?=
 =?utf-8?B?ZU8wRk9TSUphWDZxNkx4VE5IOHVJZWc5QzNuNEUwTGw1ZFBMeE8vMVFFU1RX?=
 =?utf-8?B?b0E3eUFZdDc1NmtISGt2SkRLa2ZsS2NCVWN2NXNDakZSZDh3cFI3ZUNmZ2tx?=
 =?utf-8?B?UWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <323824D1EC6666459E9A3932E2248707@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5062.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8431f0d-5daf-4c57-3da6-08daed4cbd35
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2023 05:38:27.3401
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fpIGO+3nZ0F3ZcyE5dohVpLgkK732ZbyZ/Ge282rnn3zHE3vnN9GuPs+UdoTWrL/O6+fnpgsgAE+3liq9TlDzs5m6TRQBs6MYOH5+XfM3jc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0302MB5441
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIyLTEyLTMwIGF0IDIxOjM1ICswMTAwLCBCZXJuaGFyZCBSb3Nlbmtyw6RuemVy
IHdyb3RlOg0KPiBGcm9tOiBGYWJpZW4gUGFyZW50IDxmcGFyZW50QGJheWxpYnJlLmNvbT4NCj4g
DQo+IEFkZCBiaW5kaW5nIGRvY3VtZW50YXRpb24gZm9yIHRoZSBNVDgzNjUgU29DLg0KPiANCj4g
U2lnbmVkLW9mZi1ieTogRmFiaWVuIFBhcmVudCA8ZnBhcmVudEBiYXlsaWJyZS5jb20+DQo+IEFj
a2VkLWJ5OiBLcnp5c3p0b2YgS296bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5v
cmc+DQo+IFNpZ25lZC1vZmYtYnk6IEJlcm5oYXJkIFJvc2Vua3LDpG56ZXIgPGJlcm9AYmF5bGli
cmUuY29tPg0KPiBSZXZpZXdlZC1ieTogTWF0dGhpYXMgQnJ1Z2dlciA8bWF0dGhpYXMuYmdnQGdt
YWlsLmNvbT4NCj4gLS0tDQo+ICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdXNi
L21lZGlhdGVrLG10dTMueWFtbCB8IDEgKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9u
KCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L3VzYi9tZWRpYXRlayxtdHUzLnlhbWwNCj4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvdXNiL21lZGlhdGVrLG10dTMueWFtbA0KPiBpbmRleCA3MTY4MTEwZTJmOWRlLi5kMjY1
NTE3M2UxMDhjIDEwMDY0NA0KPiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvdXNiL21lZGlhdGVrLG10dTMueWFtbA0KPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvdXNiL21lZGlhdGVrLG10dTMueWFtbA0KPiBAQCAtMjgsNiArMjgsNyBAQCBw
cm9wZXJ0aWVzOg0KPiAgICAgICAgICAgIC0gbWVkaWF0ZWssbXQ4MTg4LW10dTMNCj4gICAgICAg
ICAgICAtIG1lZGlhdGVrLG10ODE5Mi1tdHUzDQo+ICAgICAgICAgICAgLSBtZWRpYXRlayxtdDgx
OTUtbXR1Mw0KPiArICAgICAgICAgIC0gbWVkaWF0ZWssbXQ4MzY1LW10dTMNCj4gICAgICAgIC0g
Y29uc3Q6IG1lZGlhdGVrLG10dTMNCj4gIA0KUmV2aWV3ZWQtYnk6IENodW5mZW5nIFl1biA8Y2h1
bmZlbmcueXVuQG1lZGlhdGVrLmNvbT4NCg0KVGhhbmtzDQo+ICAgIHJlZzoNCg==
