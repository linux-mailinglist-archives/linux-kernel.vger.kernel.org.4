Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E305F6130C1
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 07:54:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbiJaGxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 02:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiJaGxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 02:53:22 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA1B9FF0;
        Sun, 30 Oct 2022 23:53:19 -0700 (PDT)
X-UUID: 309d8ad5ddee4991aaefea41d45f7bc1-20221031
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=MSlrE91iv0eiWpvnUCIfog/eivwqATFPPE550qNQQUk=;
        b=V4y9mHUPHuT605HBbNwwWTaS26olfzjaiuuKJxuiZUnev0mxU26zN/MBKrUnw/MDXlKLzazpSeyxO3JPKErVroga/mEw2Lb3aJZSy6lzRvHrKRTIUzS8C0F6dtUbn1dkOPP/kpYf0nRDSgmq9tav4NzkTYe1P5KN9Gu6fnJeGGI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:bddb4e7c-f113-4ae0-a1a4-9ed2802a2538,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:1,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-4
X-CID-INFO: VERSION:1.1.12,REQID:bddb4e7c-f113-4ae0-a1a4-9ed2802a2538,IP:0,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:1,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:-4
X-CID-META: VersionHash:62cd327,CLOUDID:4ec71690-1a78-4832-bd08-74b1519dcfbf,B
        ulkID:221031145316CQGBBBJR,BulkQuantity:0,Recheck:0,SF:17|19|102,TC:nil,Co
        ntent:0,EDM:-3,IP:nil,URL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 309d8ad5ddee4991aaefea41d45f7bc1-20221031
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1352704645; Mon, 31 Oct 2022 14:53:15 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Mon, 31 Oct 2022 14:53:14 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Mon, 31 Oct 2022 14:53:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NB+p3Q9G6Vo1Cvx8z5QltZF1v3AmKHBIyzAC524K2mqwP6b7L1LIM2LP1EHV3qwVyAGtogtSVF+IDVEI4EdTrxMP57CgV9c6TcQ726p5I2475J7+SJAdzo1N2BJOFfV0rl37Coj1AyoZzlxwtxf3vuYprKk/ebbrHJJPvz53wD5dN7v3boQOlCPId+m8tJJNzx3Wyn9daefFzTNvXPIO/+rnT3EQzODV7exR0DWWAI6FmZn/+0cQXGtWBJLwhlxWa+fakWtB9jzU8uXrglUoi/4RkUuUgVaVVbC9VfgDK+CCIpSS5eZtvJVqGJMoUGWAE55UMo2GWcgBaglehOj8yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MSlrE91iv0eiWpvnUCIfog/eivwqATFPPE550qNQQUk=;
 b=fxLqy9QogoKaFq056ECZJfwzXBj657385nxRQ7kiWuaAN6/IbztSyRo3/3wqhYHEoDqph0FxXq1GSEaIdc7wr6ZA36FVeUXKdD5wVywasMe9AOBqbbs81ry0cTLi24F+bwuB7thlw2NGmW7ZJ+uGqeT9OmpLA8o0HPOGGHUk5S5763yTwoZKZarX6cPqhWeTRtiufr203+NK1V7OmMW7/3AJ5CTRFfz7B+dr20Ya6ek+rdHb7dNXhQwezHVpOvJ2+d0B4qb1n4YxrDcwrm8p3Iv0AgHCFV1DxXKpJJ2C7Ns5WrKPHznD9Q2uXw9ywfLZ83R4AI9wECt3rwMmmiKacw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MSlrE91iv0eiWpvnUCIfog/eivwqATFPPE550qNQQUk=;
 b=oxcirsEieiHcLrqAjciJWcdaSrN5WekwT1khKSBq3OJlzcy2JmUh10Txwv4wXM2bfpHVg1dcPKlAi122ulaHgMjijQuMEPYeRJKSRhIwV18Kbk998XhtpPMrIse65Co+KFaM05kCPozvkRyBX3lfl8mOOgcxYN22D30dccj/J/Q=
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com (2603:1096:4:1e9::14)
 by PSAPR03MB5784.apcprd03.prod.outlook.com (2603:1096:301:8d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.14; Mon, 31 Oct
 2022 06:53:12 +0000
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::3438:1068:ae0:32cd]) by SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::3438:1068:ae0:32cd%2]) with mapi id 15.20.5791.017; Mon, 31 Oct 2022
 06:53:11 +0000
From:   =?utf-8?B?VHJldm9yIFd1ICjlkLPmlofoia8p?= <Trevor.Wu@mediatek.com>
To:     "robh@kernel.org" <robh@kernel.org>
CC:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v2 12/12] dt-bindings: mediatek: mt8188: add mt8188-mt6359
 document
Thread-Topic: [PATCH v2 12/12] dt-bindings: mediatek: mt8188: add
 mt8188-mt6359 document
Thread-Index: AQHY5SchNVki11xv20ucTP8FaxUVpK4d5UKAgAo7UAA=
Date:   Mon, 31 Oct 2022 06:53:11 +0000
Message-ID: <45ac89af9e7e5605f73cea634213c4afe9e76806.camel@mediatek.com>
References: <20221021082719.18325-1-trevor.wu@mediatek.com>
         <20221021082719.18325-13-trevor.wu@mediatek.com>
         <20221024183817.GA2019162-robh@kernel.org>
In-Reply-To: <20221024183817.GA2019162-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB6686:EE_|PSAPR03MB5784:EE_
x-ms-office365-filtering-correlation-id: 39dfcb5f-b325-4b5b-ea15-08dabb0c93b1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5stdqfXNMoTYS01KOBVr9wZGBe3OqvTAyIHVYQQ9VgUEs+wgU3Al7NxlEu36cEs4K3tAtqTcDwQPa3LoKWMkpamnSR18n/ktkiUosvvvfrBJ47QP2/zqdn/Z4tiYqYb6+O8mRPnhGfECrR36p0z+MXehd4sRapwtjZdu2sIFOKiim5E5lo92CkyBhn9X4TL3f5FpzXEUWaiBG8ODlMvlM+zEZlO882L/GFjD6gdAk/Ye5X8d1stGu1lxwcrgkRxA0GDTMNSeFFtnBz/nSOwZG5KO0D22E4xHBEwzcvmXwybTQIuPrVvtur1vHypJjpoTL8LssUMK0c39vnkqrI/+Q9blkdL06BD0MTS27St3ZiEmyy1sBqnJnpLHKADgfeGE1yAVxZSB1QVfxbK025Nw3sqXbQn49KM/AyswpzybbgIhPoBRnq2Bft5J149gCPkug+yF8aRapPgTFbb/i7UIyXkDnoP4JB1Hc1iu1zkOqFcqarktpkMRKyIi5w/r6ruAUPApuRj8ViO0Ytvbo6tDM7/C95sDdMKEiXjGG88RerD0tPopdnsSsxO1pSmigKNr/BWgR7NTWl3r+QvUgma5LQfGN1zphmgE+Qc4khER33ZydzYxRET4ArMbDit4CKr85cYn8RP1vzL5O9UFduSnd/JiAPuw/leEHCd0x5pQEV53KzeJuPGFlVorZ0qE9I7PkVbxXY666Ar+P6hE86fVadVLWmpqiLfPSceZGxdHpX05BG2GsTBPaM8icZ8xGcRZDVNDHiqEwyKP9cqldIYoeWGwPm4RCk2HJqOXVCG+E2s2z1OHtL9yC0Q1ea4cWBb30Pyt1bLtqq3k9xlgaL2cXgPdPTYeFlLoULowfLUACGg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB6686.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(396003)(376002)(346002)(136003)(451199015)(41300700001)(6512007)(26005)(6506007)(8936002)(38100700002)(2616005)(36756003)(83380400001)(5660300002)(85182001)(186003)(4001150100001)(122000001)(2906002)(7416002)(38070700005)(6486002)(86362001)(91956017)(64756008)(66446008)(76116006)(4326008)(71200400001)(66556008)(66476007)(478600001)(8676002)(66946007)(966005)(6916009)(54906003)(316002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VGExRjlickkrU2gvZEJ3Y2pVRzhqUDI3YmxGUVFaR082VjE4NGJxbGZwSDJ4?=
 =?utf-8?B?bi9WQkoycFQ0a3ArR0g0SW5EZXJsUitYQXZEa3g3RWY5TGM5YWhudFdjdUJS?=
 =?utf-8?B?WnNJeTRYcG52K1czOWxLMm1MZkNDbHNwL1RQdDVtYS9JUDdHcHNyMHZyc2JO?=
 =?utf-8?B?NU5aY1ZsOUhWdkZVQmEyVEJ5TktrS3hmaEJmemNna0FTd2tjRUozRzV2cGNo?=
 =?utf-8?B?ekNGZzQwQm5xOFV4OURYTmpIb0FyZ2thSVNnWE4yYXBTbERJeUpVVnMwSGVl?=
 =?utf-8?B?K0dvUDFHQVVQdzF0WTNPNHVuanhRUTNEdTBJSkd4NkYrN1FSZS84TDZaK0Zz?=
 =?utf-8?B?Z1gxNnpjSm55T0dleWc1dFdGOXBaSHV1RXhPVDJubjExWmZ6T2paNklKL2pM?=
 =?utf-8?B?TE9nL1hQc2NHV1JKYkRtcHFvSWZoaXdMRW1QQjMvT09xUlB1TFE0Mm5XY3Za?=
 =?utf-8?B?ZGw3SXA2ZEZqWXYrbkMvanhFTjJtM3FrTkRyQWVsSXJpMkJUNGs0OEI3aThN?=
 =?utf-8?B?TU9nT2YvUFBaOE5QQXVTWmdWbitVemduc3BQTXBOQ3plSjNWcGlUV1RoMW9C?=
 =?utf-8?B?VUhGRUgvVDJWb2oyZTZJM2JneVQxM1NiUkw1Tm9PVEdpVDBNMWJQUDNXSW0v?=
 =?utf-8?B?MFpXVFlrQlhYM2lwZ1Y4ekFuaHdKeHhCMjBNSUtkVG9peHN0TGlHTEhjellx?=
 =?utf-8?B?R1BzV3hHWGkzSk5iWHk5VmRaVGtIazRHWjBKVmhkcHliKzlzK0JLK2xZc1Nq?=
 =?utf-8?B?WlJUbzlPSE9lZG1HNG9LN01MLzR2eE1LeWpvbi9seEFjVHA4d3hnUHBCUkpv?=
 =?utf-8?B?aEp0OFhLdTl5cHZJb0xzNk1haVY3Zk1MczB5elZKM2J5ZSs1SVZ5Rit0RkRr?=
 =?utf-8?B?ZzlBUi92N004NjJoMTFmYmxyZDhRQ3BLeW4yeEtZbFhNM1B3RDVoOENRTk0y?=
 =?utf-8?B?YzYyM3JldEtRSFJuVWJXMnNQbWwxNE5iYmpwWXEyTGhzeGlnRy9WdHBocFZK?=
 =?utf-8?B?anJJU1BHdUpNTk9rdmdCT09OcXZrNDB5OGpjVWZlcmFTZVZTK1NBN01mTGdX?=
 =?utf-8?B?a0Z4ZGhFNkg5Ly9aVEEwank5T2JuOEVqOVRYZ3hrb1hyNkJrR1FqMVNsVDE3?=
 =?utf-8?B?MG41RUtMT2ZldGtZSm5KckxlTHVKZ3hTM1o4VU5Xc3loeXo2cGlZb1NDRjZK?=
 =?utf-8?B?ZjMrQzF4ZjFsb01EU2E2SnkwK0RlQVNiV2hhUE55c0dITTdVdXJsOC9zajdm?=
 =?utf-8?B?ZThvczFqVGtTRVpwUmJJajdxRUlCUytUSllyZ01KTUYxM0pobmtaZUNkQk9l?=
 =?utf-8?B?K0d3dVdMeEJxSjhwZWlZckE1aUttWUxpM0daMG5PQ3cySWhhcng3OVlpVS9F?=
 =?utf-8?B?KzBLRkt1anhBTXdyUG1oYUFLa2s3NElERFlpNXJjdXZEa21QNUVkZDNQQnhK?=
 =?utf-8?B?eTNEN0pKY0FVQmoxMVhwcnpGVGZwbituU3Q5U0Z2NHpuQ1Qxekp5UUdWbTZ3?=
 =?utf-8?B?N1dRb1NpUW9KV1FRWTIzS2xNRzVOOURFTnkzSExXQ1pvUWxOL0lXeU9ENHMr?=
 =?utf-8?B?WEhWVzJ6SjVxR29IWWZ0MW5INWJkaldnb0wybWw2VzdGZTgvbkNaeUgrUlJO?=
 =?utf-8?B?eENCVlFqTFFITWJEcFloUHdpZmQ2aG85cUM2djFnTjBqTFJNVWQ1RWZaSDRD?=
 =?utf-8?B?SGM1U0lkYTc4Wk53cmVCNHU5aVp3YjRvQ2RFVStKZWRtYWlER1l0RjNUL3kv?=
 =?utf-8?B?U3FGMHJ3UENGam41NG1qVC9KNGN4QktzZWlRMDE3bCs1bnJxZHJ1RFIvam9p?=
 =?utf-8?B?RStSenpCeHpJRUo3L1o5UXdYb0hIL3V6QVQ0WnkyRDhhQlhDTFlBblF3d2xE?=
 =?utf-8?B?cU1MNE5NTDZOTGRtcDB4K0VwV1FoeklxZEVsMXZYd0ZsOUtmN3V4b281Z1c5?=
 =?utf-8?B?RlY3S0Vka3lEajQ3RGpRMWZQY1BrZERSYy9MWURuQXhNa21iTUIrbllDSGQv?=
 =?utf-8?B?d2ZPWUdvUE1nRURHZE0xQVlDa3VEWXdXTDFSUkpGYnhhaFgzejZMcFJLKzlY?=
 =?utf-8?B?TlZ5T3VrTVVUc3l3ZkVNbjRNVVVmSExwcyt0L1F3ZDlKb3poeDBrQ0VWMlor?=
 =?utf-8?B?QXV1VThZS05UN25mSTU5aXZEMVU3Y3czVmZoUFIwOVpvS3J4a1l4Sk82RCtn?=
 =?utf-8?B?U3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EA0560DE0967624B87D7130CBB701770@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB6686.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39dfcb5f-b325-4b5b-ea15-08dabb0c93b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2022 06:53:11.7633
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bzhjman6LQRagDb1ckp69/3mEqDxaopSDfA1dB3YxMTAYTd6Ah2IQxXEBp+180oB6AcS3+4LTG13G9vUZrRZZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR03MB5784
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

SGkgUm9iLA0KDQpUaGFua3MgZm9yIHlvdXIgcmV2aWV3LCBJIHdpbGwgdXBkYXRlIHRoZW0gaW4g
VjMuDQoNClRoYW5rcywNClRyZXZvcg0KDQpPbiBNb24sIDIwMjItMTAtMjQgYXQgMTM6MzggLTA1
MDAsIFJvYiBIZXJyaW5nIHdyb3RlOg0KPiBPbiBGcmksIE9jdCAyMSwgMjAyMiBhdCAwNDoyNzox
OVBNICswODAwLCBUcmV2b3IgV3Ugd3JvdGU6DQo+ID4gQWRkIGRvY3VtZW50IGZvciBtdDgxODgg
Ym9hcmQgd2l0aCBtdDYzNTkuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogVHJldm9yIFd1IDx0
cmV2b3Iud3VAbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICAuLi4vYmluZGluZ3Mvc291bmQv
bXQ4MTg4LW10NjM1OS55YW1sICAgICAgICAgfCA2NA0KPiA+ICsrKysrKysrKysrKysrKysrKysN
Cj4gPiAgMSBmaWxlIGNoYW5nZWQsIDY0IGluc2VydGlvbnMoKykNCj4gPiAgY3JlYXRlIG1vZGUg
MTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb3VuZC9tdDgxODgtDQo+
ID4gbXQ2MzU5LnlhbWwNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL3NvdW5kL210ODE4OC0NCj4gPiBtdDYzNTkueWFtbCBiL0RvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb3VuZC9tdDgxODgtDQo+ID4gbXQ2MzU5LnlhbWwN
Cj4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiA+IGluZGV4IDAwMDAwMDAwMDAwMC4uOWM0OTNh
NjEwMWZmDQo+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9zb3VuZC9tdDgxODgtbXQ2MzU5LnlhbWwNCj4gPiBAQCAtMCwwICsxLDY0
IEBADQo+ID4gKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IChHUEwtMi4wLW9ubHkgT1IgQlNE
LTItQ2xhdXNlKQ0KPiA+ICslWUFNTCAxLjINCj4gPiArLS0tDQo+ID4gKyRpZDogDQo+ID4gaHR0
cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHA6Ly9kZXZpY2V0cmVlLm9yZy9zY2hlbWFzL3Nv
dW5kL210ODE4OC1tdDYzNTkueWFtbCpfXztJdyEhQ1RSTktBOXdNZzBBUmJ3IXdDZDB0cXptamtS
dWJOSzV2OVY4RDZ0X1J1UFlTYjhBS3FMUGJmSVRwclpULUkyVVZnbkZibTJONVp6anI2VzkxQSQN
Cj4gPiAgDQo+ID4gKyRzY2hlbWE6IA0KPiA+IGh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19o
dHRwOi8vZGV2aWNldHJlZS5vcmcvbWV0YS1zY2hlbWFzL2NvcmUueWFtbCpfXztJdyEhQ1RSTktB
OXdNZzBBUmJ3IXdDZDB0cXptamtSdWJOSzV2OVY4RDZ0X1J1UFlTYjhBS3FMUGJmSVRwclpULUky
VVZnbkZibTJONVp4YzlaWjlMQSQNCj4gPiAgDQo+ID4gKw0KPiA+ICt0aXRsZTogTWVkaWFUZWsg
TVQ4MTg4IEFTb0Mgc291bmQgY2FyZCBkcml2ZXINCj4gDQo+IERyb3AgJ2RyaXZlcicNCj4gDQo+
ID4gKw0KPiA+ICttYWludGFpbmVyczoNCj4gPiArICAtIFRyZXZvciBXdSA8dHJldm9yLnd1QG1l
ZGlhdGVrLmNvbT4NCj4gPiArDQo+ID4gK2Rlc2NyaXB0aW9uOg0KPiA+ICsgIFRoaXMgYmluZGlu
ZyBkZXNjcmliZXMgdGhlIE1UODE4OCBzb3VuZCBjYXJkLg0KPiANCj4gRHJvcCwgdGhlIGRlc2Ny
aXB0aW9uIGRvZXNuJ3QgYWRkIGFueXRoaW5nIHRoZSB0aXRsZSBkaWRuJ3Qgc2F5Lg0KPiANCj4g
PiArDQo+ID4gK3Byb3BlcnRpZXM6DQo+ID4gKyAgY29tcGF0aWJsZToNCj4gPiArICAgIGVudW06
DQo+IA0KPiBPbmx5IDEgZW50cnksIHVzZSAnY29uc3QnDQo+IA0KPiA+ICsgICAgICAtIG1lZGlh
dGVrLG10ODE4OF9tdDYzNTlfZXZiDQo+IA0KPiBzL18vLS8NCj4gDQo+ID4gKw0KPiA+ICsgIG1v
ZGVsOg0KPiA+ICsgICAgJHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvc3Ry
aW5nDQo+ID4gKyAgICBkZXNjcmlwdGlvbjogVXNlciBzcGVjaWZpZWQgYXVkaW8gc291bmQgY2Fy
ZCBuYW1lDQo+ID4gKw0KPiA+ICsgIGF1ZGlvLXJvdXRpbmc6DQo+ID4gKyAgICAkcmVmOiAvc2No
ZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9ucy9ub24tdW5pcXVlLXN0cmluZy1hcnJheQ0KPiA+
ICsgICAgZGVzY3JpcHRpb246DQo+ID4gKyAgICAgIEEgbGlzdCBvZiB0aGUgY29ubmVjdGlvbnMg
YmV0d2VlbiBhdWRpbyBjb21wb25lbnRzLiBFYWNoDQo+ID4gZW50cnkgaXMgYQ0KPiA+ICsgICAg
ICBzaW5rL3NvdXJjZSBwYWlyIG9mIHN0cmluZ3MuIFZhbGlkIG5hbWVzIGNvdWxkIGJlIHRoZSBp
bnB1dA0KPiA+IG9yIG91dHB1dA0KPiA+ICsgICAgICB3aWRnZXRzIG9mIGF1ZGlvIGNvbXBvbmVu
dHMsIHBvd2VyIHN1cHBsaWVzLCBNaWNCaWFzIG9mDQo+ID4gY29kZWMgYW5kIHRoZQ0KPiA+ICsg
ICAgICBzb2Z0d2FyZSBzd2l0Y2guDQo+ID4gKw0KPiA+ICsgIG1lZGlhdGVrLHBsYXRmb3JtOg0K
PiA+ICsgICAgJHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvcGhhbmRsZQ0K
PiA+ICsgICAgZGVzY3JpcHRpb246IFRoZSBwaGFuZGxlIG9mIE1UODE4OCBBU29DIHBsYXRmb3Jt
Lg0KPiA+ICsNCj4gPiArICBtZWRpYXRlayxkcHR4LWNvZGVjOg0KPiA+ICsgICAgJHJlZjogL3Nj
aGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvcGhhbmRsZQ0KPiA+ICsgICAgZGVzY3JpcHRp
b246IFRoZSBwaGFuZGxlIG9mIE1UODE4OCBEaXNwbGF5IFBvcnQgVHggY29kZWMgbm9kZS4NCj4g
PiArDQo+ID4gKyAgbWVkaWF0ZWssaGRtaS1jb2RlYzoNCj4gPiArICAgICRyZWY6IC9zY2hlbWFz
L3R5cGVzLnlhbWwjL2RlZmluaXRpb25zL3BoYW5kbGUNCj4gPiArICAgIGRlc2NyaXB0aW9uOiBU
aGUgcGhhbmRsZSBvZiBNVDgxODggSERNSSBjb2RlYyBub2RlLg0KPiA+ICsNCj4gPiArYWRkaXRp
b25hbFByb3BlcnRpZXM6IGZhbHNlDQo+ID4gKw0KPiA+ICtyZXF1aXJlZDoNCj4gPiArICAtIGNv
bXBhdGlibGUNCj4gPiArICAtIG1lZGlhdGVrLHBsYXRmb3JtDQo+ID4gKw0KPiA+ICtleGFtcGxl
czoNCj4gPiArICAtIHwNCj4gPiArDQo+ID4gKyAgICBzb3VuZDogbXQ4MTg4LXNvdW5kIHsNCj4g
PiArICAgICAgICBjb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE4OF9tdDYzNTlfZXZiIjsNCj4g
PiArICAgICAgICBtZWRpYXRlayxwbGF0Zm9ybSA9IDwmYWZlPjsNCj4gPiArICAgICAgICBwaW5j
dHJsLW5hbWVzID0gImRlZmF1bHQiOw0KPiA+ICsgICAgICAgIHBpbmN0cmwtMCA9IDwmYXVkX3Bp
bnNfZGVmYXVsdD47DQo+ID4gKyAgICAgICAgYXVkaW8tcm91dGluZyA9DQo+ID4gKyAgICAgICAg
ICAgICJIZWFkcGhvbmUiLCAiSGVhZHBob25lIEwiLA0KPiA+ICsgICAgICAgICAgICAiSGVhZHBo
b25lIiwgIkhlYWRwaG9uZSBSIiwNCj4gPiArICAgICAgICAgICAgIkFJTjEiLCAiSGVhZHNldCBN
aWMiOw0KPiA+ICsgICAgfTsNCj4gPiArDQo+ID4gKy4uLg0KPiA+IC0tIA0KPiA+IDIuMTguMA0K
PiA+IA0KPiA+IA0K
