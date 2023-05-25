Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B85371036A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 05:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235902AbjEYDpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 23:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjEYDpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 23:45:14 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E4BDE2;
        Wed, 24 May 2023 20:45:12 -0700 (PDT)
X-UUID: 89f4697afaae11edb20a276fd37b9834-20230525
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=JKuzERODJHfjdgM50bqhz9NysaWpESBKkOTdyB8XWag=;
        b=FI8/1TENhWLyL2mghegnXALntF0BtBUJimHnOriDla0d8RIL2opUU7CGpTkPg18BWk3FHGqqtNTkIoHUqfjOsOJchC6nHjjuiK6e2/b0VWQuowg55PdOdFgN1h0qKVnKRqSScQVSMAeeACCURbP1i+Ch6bY6IbUgRJOaIGgTnrA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:9a26e4ba-b807-46dc-a1cb-726d9e4afb7d,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:d5b0ae3,CLOUDID:f3a8ef6c-2f20-4998-991c-3b78627e4938,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: 89f4697afaae11edb20a276fd37b9834-20230525
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1330496857; Thu, 25 May 2023 11:45:06 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 25 May 2023 11:45:06 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 25 May 2023 11:45:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WADUXvfWrKdXJwZvIQP/zJfaXzKF+lC/l8XaDw6pd0mtMb1ibw0QK7U+PX7sTYDJgSJEP78S2CMZqmIbqfSJ3pZYenmPDamslHeT7bqUK6huQrMe4p9tsBqLsqD2+1tuWDFTvhOFU6DB54jTsr0o9HjZkulsjCtdWgCW7m8KCFZRNT6LDwMx1HQGW0U5WNy8NlB6EKefFqKNyGfKcWlwrjM1FbloDROeJaO2589t2WKtn5fNfjQgJ+VZdhKLA8LtXU1FfkLMfcYjR6td3N7/6Ixa/Nt1dOXAJf5a6E/B7z+2NKq1y43/OTCA6dN3V/MhqghzieF4dgQ0mT3TVTfUGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JKuzERODJHfjdgM50bqhz9NysaWpESBKkOTdyB8XWag=;
 b=dXLkrGe4sPa4TUGlNYWAd117V7K+1MxarYw1kU6d8OX0MYkj2OBupkW5D4USwwZzhAur/un536WjuiUaNp95ueBFCjt8VdUPiWf5+b+xEt71ueirZvCmeiYQV3cLRAHj/x+W3cpyQluDgo9p1ebmMeNfU0K9w2R1R1aENvPyNu/YMlCgc2+LiP4EGP4NlyEQX3wVfVLsAygI42na99o7UUMPbEpgmj5jBVs722D9MrXx0cZ19DhnTWzJ5tatQp9ojM+uT+5ZnRY/85PeNQbAu8ixf1a3dKRQ1aGDWPSBUOLcbmIvq3V19RtasNJEOHAal5RacWMDLfZ0mjKN590ptA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JKuzERODJHfjdgM50bqhz9NysaWpESBKkOTdyB8XWag=;
 b=sYHc5CfK4x/0yQ8IixBRZ8xkfBZ09nXeqohfbTfTVO0PhIMuauJYWABpvqrwqgWO/qNzgKP9SX+pwq9LOaLfBo0nuE7stzRmRO6PjVsmq2GT6un2JkDp2cqMhNDPUCcx89kyvQYbuTxKYB6sYelF/o3G23LoatopDXtlYPqeuy0=
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com (2603:1096:4:1e9::14)
 by SEZPR03MB7539.apcprd03.prod.outlook.com (2603:1096:101:132::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21; Thu, 25 May
 2023 03:44:13 +0000
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::bfa:5a41:b6e1:63de]) by SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::bfa:5a41:b6e1:63de%3]) with mapi id 15.20.6411.031; Thu, 25 May 2023
 03:44:13 +0000
From:   =?utf-8?B?VHJldm9yIFd1ICjlkLPmlofoia8p?= <Trevor.Wu@mediatek.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "amergnat@baylibre.com" <amergnat@baylibre.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 6/7] ASoC: mediatek: mt8188-mt6359: support new board
 with nau88255
Thread-Topic: [PATCH v2 6/7] ASoC: mediatek: mt8188-mt6359: support new board
 with nau88255
Thread-Index: AQHZjR0mTJnqdVdbcEqKOkQb0Svk7a9plQ8AgADHDQA=
Date:   Thu, 25 May 2023 03:44:12 +0000
Message-ID: <d7ecf746a3db31cad53d068acff6dd1746644a58.camel@mediatek.com>
References: <20230523021933.3422-1-trevor.wu@mediatek.com>
         <20230523021933.3422-7-trevor.wu@mediatek.com>
         <dcd5050b-8459-e7cc-b5ad-eb435aba6e84@baylibre.com>
In-Reply-To: <dcd5050b-8459-e7cc-b5ad-eb435aba6e84@baylibre.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB6686:EE_|SEZPR03MB7539:EE_
x-ms-office365-filtering-correlation-id: 28099888-e66b-415f-9862-08db5cd24e5e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YG8kb4z2vMgAr759w146Ofub9h6F/IdCkxFoxg2HxCTlSbJOWvZTr2ImhFJQ9x3HWldxk0oLT5xRLLuz57WiYv2fxQtriGrKNF9gFNQaHEPQ5X2zYo+XYNlGqni0H8ivA6uNoFOP0fkBE+q83xQkXuQAJnBSuGZyA1sx1EoPA3jXghrBQuWHjN4gPjpyYpDBIVekZZFZhtXENYajdz7ScewDIFCkl/p7nw+67pDNgodxwF1oX6b7wCnCXCsY63pxyEX7EoAMArLGlbHI78l1J7owBpKPFueVwlsCgw1RGcfprWlJN3YhREkJwKFiY3rujoAabxANYO9btfDTrH45v7O7ipORQyYEL+fRVoxVYJNaFzdj+RwEUmyf3Wr3dg+OHuvWY86YwRAI0PstX9T3siEP/hLHOk/9fv9SWDurTVgc1uWmFBJea+WMsftk5S2Yi3QpRzdC1pn3cWqgbYfVzHlQxg/ysq4TXlOVGVYe2k+OC+I2tStpR+4Y1udvsS4KJyiqnlKXEoHfCP45zwH7+dYIFKplnOyD8uc3AYzAgKiXHJkCOekFe9UN3FhuSjIYNUVHI++UlbXldXKIw0UVnQV8OnY4flV7yeceuQXm9/BK5u/R/ljlADPztVjYkh4w5+11xwtvCJokwMfvpttBpw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB6686.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(366004)(396003)(376002)(346002)(451199021)(71200400001)(7416002)(6486002)(8936002)(8676002)(53546011)(2906002)(85182001)(36756003)(122000001)(6512007)(38100700002)(186003)(26005)(921005)(6506007)(86362001)(54906003)(110136005)(478600001)(2616005)(83380400001)(316002)(4326008)(38070700005)(41300700001)(64756008)(66556008)(76116006)(66476007)(66946007)(66446008)(91956017)(5660300002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S0tzVk9YbGFJZmJlTUlndisveGU1MUpVTzFCbnVRM1dNdHl2b1VsMHplOXdQ?=
 =?utf-8?B?NzRMOHRPeklZQ0tUamJtU1ZDeE5EMDdVVjFDNm5YblpNbTVHTFVzdnFYM0w0?=
 =?utf-8?B?K3B3NTM0WkJHSlEwcWFqVmh3TFNrblpldXNkSHBENWQ0K0lJUDVGZkt1KzFB?=
 =?utf-8?B?dENTNC9ReDU3dk1qcDlNYTdMaFp5L2t3bCtNcmExOVRuejFBVGU3STVxSkJ5?=
 =?utf-8?B?ekxFeE5TOE9CWERGRzFHVXJvbkoxUXRTS2dsVXplNHF3VklNd1lKN2g1elBi?=
 =?utf-8?B?OWxRMEhnaTczSGhRVFpVbTltTG9BZEdpaHByUUJ0aWNsbW01NXVvdWlmUnVh?=
 =?utf-8?B?NGFoTXIxZkVBdGlFblIrYTZtY1lMaTRGclNXbkFncDV1UWhlUDJUbzlpZHJ0?=
 =?utf-8?B?RVFZSm5nWDdCZGQwcldNY2RDWXRFdks4OWRKdmZ1SlRYdGdZOUMzY0NpMmpm?=
 =?utf-8?B?NEhGaGl5VWVIZVAvMWIzY3o3b1JwWElKdFJMM2djZEIyQWQ1RjlWUTdhWUh6?=
 =?utf-8?B?RW1GY2lCRVRsN0RUaGFIR2dnSG5FTmdVSkdabUtnWXdDSWVxUG1IMC9CeUlo?=
 =?utf-8?B?Wi9qcmx1ODE1Vndxa0Eyd0syelIxcWtueUorUjBXcmZTVnZuNDFDaXk5OVc3?=
 =?utf-8?B?bmhTbHFzcE5MZERsbUhLVHBpeDN0Q3IyVXRibmM4MHU1eWRJOStDSDZpU2pa?=
 =?utf-8?B?VVYwNisybHN0MWtNYzNlRTRjK0RWOXF0SFdrRE40aFkwNXU4aGlsanYweHlm?=
 =?utf-8?B?TWdYZ1JOK3phRUgyZ2ZhSHpDaWh0c1BiemFvNkhzblZVaW5CRUZmSE1qNWFT?=
 =?utf-8?B?OUpTa2VWNkpKa0Q4NkRIQWlnSWw0V1BlR2V4SHllc1VodGhmc1llR0N3SGFU?=
 =?utf-8?B?b3lSUmR1VWxQNmdUdEY1L2RmU1FmZ21nNWxxS3U4Q2YzRm03c2REcW9xTlMv?=
 =?utf-8?B?MVhnSks3NmtKdHR3c2owMi9FTlBYMG9KVGpJd2szbW9sSkZ0bEdLWVI2VHNs?=
 =?utf-8?B?U0VzdnhJdXZ0a3Y0SXBDQmF2Qm1GbDRJOTVCc3Q1WUJFaW9IZ0xKcE5hWUds?=
 =?utf-8?B?VnBjY2s4Z2FwQWRETTk2V3BkQWozN0h1dWE3bUxhMTBlcXVmckpNSm14MTk3?=
 =?utf-8?B?TUxSalNFbitram15M0pJalp2eHR1aVFaUno0N0pXS0t0VDBMdzh3TzVHUmt6?=
 =?utf-8?B?OE1aSGhQaE9FRXo0T09LV1g3bm9kSmFMMEpwSHlNTVVFazJaSTgzVXNNQVlU?=
 =?utf-8?B?TEpMdlNkKzgreEorM0hmVGhPM0wwU2dRVFU5OXFVaFBlNEkrL1NXWUlCOFRl?=
 =?utf-8?B?dHFZbzl4dHczaW9TdStlMUNreHJTNnBmQ0hLUHhyVHRKRGdKN04xdW5aU05u?=
 =?utf-8?B?Z3hEZW1YeUtJKzdzWjdFbC9vTEsyRjB3cWtJajZNTmxDU2g5L2k5UnlXeGVp?=
 =?utf-8?B?NmlWWkIwMHJHYTlDdUNVY2k0bUlxNGluSTVWbnkxTjB6eFcveS9vZVNHTEoy?=
 =?utf-8?B?L1VUY2FJcFVCUUtzTVpwQlRxNzlsNlVtcUxNVzB0ZldHaGtwRjNUdE03TG9R?=
 =?utf-8?B?aFZ1WnpRMks1NDlDZUJ1b044QkRXbE5DeThOd2lFNThUV2ZHTGYvTWUvZklt?=
 =?utf-8?B?eFF6YUdMRHBoQW4vZnYvRFVNV2Exd1N2RHFzUlVmU0Y2MWpidkR0TUFtakxH?=
 =?utf-8?B?UXI1R2ZEY0hBYVFTdjNKdGwwV1M0WklrZC9Zc1l3REk4NXNYQ25TZHZzdW1I?=
 =?utf-8?B?d29wSVp4M1RreXQzL2hmVTRJaWd6T3hNbGFxWXpoS3ZtaHJPR1dUNFlQZm1N?=
 =?utf-8?B?N28rdnR6ZG9GbERVS2lqbXRFSGR6RFhMS3M0ci80K1Q0Vzc5VHZvQlJiNy9U?=
 =?utf-8?B?Zkh6NWJVTTc5YWpIbk1CQklPamlVNW9SY3lYQXN2R3FFQy82THU5azhzNUoy?=
 =?utf-8?B?QThhaWJ2UVlsbnkzclFaS1JFS2VLQjM0MDFZemdZQUxxVEcyc0s1NTZGNnU4?=
 =?utf-8?B?dHBOVUtKOTc3Q3ZiSzYxalE0RENwWHA5bnNtbXFvWmZsNERIUFBJQ2JpVk9D?=
 =?utf-8?B?dmlHTVRUVlo3QS9lekVZSDZZKy83eDhaZUZ2NGQ5b3pDQUNSblBPMXNBMWdz?=
 =?utf-8?B?YWl5akl0RjE5aEVLdlVCMkM2M3J6bWg4ZFJNWDJEeWl1dytlV2FqTDVYWE8w?=
 =?utf-8?B?TVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7289679E30371547ACF710F1D4974F6C@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB6686.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28099888-e66b-415f-9862-08db5cd24e5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2023 03:44:13.0163
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TjUB2253MJEdY8MoTcrlYAdXm6ng7nhdvDiBa1sx/iADGarf2NCPGwQAnUv09F9/hhqABJNzXxFarlz9VA334w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7539
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTA1LTI0IGF0IDE3OjUxICswMjAwLCBBbGV4YW5kcmUgTWVyZ25hdCB3cm90
ZToNCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4g
YXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUg
Y29udGVudC4NCj4gDQo+IA0KPiBPbiAyMy8wNS8yMDIzIDA0OjE5LCBUcmV2b3IgV3Ugd3JvdGU6
DQo+ID4gICAgICAgY2FyZF9kYXRhID0gKHN0cnVjdCBtdDgxODhfY2FyZF9kYXRhDQo+ID4gKilv
Zl9kZXZpY2VfZ2V0X21hdGNoX2RhdGEoJnBkZXYtPmRldik7DQo+ID4gQEAgLTc3Niw5ICsxMDY2
LDM4IEBAIHN0YXRpYyBpbnQgbXQ4MTg4X210NjM1OV9kZXZfcHJvYmUoc3RydWN0DQo+ID4gcGxh
dGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRh
aV9saW5rLT5pbml0ID0gbXQ4MTg4X210NjM1OV9pbml0Ow0KPiA+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGluaXRfbXQ2MzU5ID0gdHJ1ZTsNCj4gPiAgICAgICAgICAgICAgICAgICAg
ICAgfQ0KPiA+ICsgICAgICAgICAgICAgfSBlbHNlIGlmIChzdHJjbXAoZGFpX2xpbmstPm5hbWUs
ICJFVERNMV9PVVRfQkUiKSA9PQ0KPiA+IDAgfHwNCj4gPiArICAgICAgICAgICAgICAgICAgICAg
ICAgc3RyY21wKGRhaV9saW5rLT5uYW1lLCAiRVRETTJfT1VUX0JFIikgPT0NCj4gPiAwIHx8DQo+
ID4gKyAgICAgICAgICAgICAgICAgICAgICAgIHN0cmNtcChkYWlfbGluay0+bmFtZSwgIkVURE0x
X0lOX0JFIikgPT0gMA0KPiA+IHx8DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgIHN0cmNt
cChkYWlfbGluay0+bmFtZSwgIkVURE0yX0lOX0JFIikgPT0NCj4gPiAwKSB7DQo+ID4gKyAgICAg
ICAgICAgICAgICAgICAgIGlmICghc3RyY21wKGRhaV9saW5rLT5jb2RlY3MtPmRhaV9uYW1lLA0K
PiA+IE1BWDk4MzkwX0NPREVDX0RBSSkpIHsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBkYWlfbGluay0+b3BzID0gJm10ODE4OF9tYXg5ODM5MF9vcHM7DQo+ID4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgaWYgKGluaXRfbWF4OTgzOTApDQo+ID4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBjb250aW51ZTsNCj4gDQo+IEkgcHJlZmVyIHRoYXQg
eW91IGRvIGxpa2UgeW91ciBwYXRjaCBbUEFUQ0ggdjIgMS83XSB0byBiZSBjb25zaXN0ZW50DQo+
IGFuZCBlYXN5IHRvIHJlYWQuDQoNCk9LLCBJIHdpbGwgdW5pZnkgdGhlIHN0eWxlIGluIHYzLg0K
DQo+IA0KPiArICAgICAgICAgICAgICAgICAgICAgICBpZiAoIWluaXRfbXQ2MzU5KSB7DQo+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZGFpX2xpbmstPmluaXQgPSBtdDgxODhfbXQ2
MzU5X2luaXQ7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaW5pdF9tdDYzNTkg
PSB0cnVlOw0KPiArICAgICAgICAgICAgICAgICAgICAgICB9DQo+IA0KPiA+ICsNCj4gPiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBkYWlfbGluay0+aW5pdCA9DQo+ID4gbXQ4MTg4X21h
eDk4MzkwX2NvZGVjX2luaXQ7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaW5p
dF9tYXg5ODM5MCA9IHRydWU7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgIH0gZWxzZSBpZiAo
IXN0cmNtcChkYWlfbGluay0+Y29kZWNzLQ0KPiA+ID5kYWlfbmFtZSwgTkFVODgyNV9DT0RFQ19E
QUkpKSB7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZGFpX2xpbmstPm9wcyA9
ICZtdDgxODhfbmF1ODgyNV9vcHM7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
aWYgKGluaXRfbmF1ODgyNSkNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGNvbnRpbnVlOw0KPiANCj4gZGl0dG8NCj4gDQo+ID4gKw0KPiA+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGRhaV9saW5rLT5pbml0ID0NCj4gPiBtdDgxODhfbmF1ODgyNV9jb2Rl
Y19pbml0Ow0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRhaV9saW5rLT5leGl0
ID0NCj4gPiBtdDgxODhfbmF1ODgyNV9jb2RlY19leGl0Ow0KPiA+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGluaXRfbmF1ODgyNSA9IHRydWU7DQo+ID4gKyAgICAgICAgICAgICAgICAg
ICAgIH0gZWxzZSB7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaWYgKHN0cmNt
cChkYWlfbGluay0+Y29kZWNzLQ0KPiA+ID5kYWlfbmFtZSwgInNuZC1zb2MtZHVtbXktZGFpIikp
IHsNCj4gDQo+IFNob3VsZG4ndCBiZSB3aXRoIGEgTk9UIG9wZXJhdG9yICgiISIpID8NCj4gKyBp
ZiAoIXN0cmNtcChkYWlfbGluay0+Y29kZWNzLT5kYWlfbmFtZSwgInNuZC1zb2MtZHVtbXktZGFp
IikpIHsNCj4gDQoNCnN0cmNtcCByZXR1cm5zIDAgd2hlbiB0aGUgY29udGVudHMgb2YgYm90aCBz
dHJpbmdzIGFyZSBlcXVhbC4gVGhlDQpkZWZhdWx0IGNvZGVjIG5hbWUgaXMgInNuZC1zb2MtZHVt
bXktZGFpIi4gV2hlbiB0aGUgY29kZWMgaXMgc3BlY2lmaWVkDQpmcm9tIGR0cywgdGhlIHJldHVy
biB2YWx1ZSBvZiBzdHJjbXAgd2lsbCBiZSBub24temVybyBhbmQgdGhpcyBpcyB0aGUNCmNhc2Ug
SSB3YW50IHRvIGFzc2lnbiBpbml0IGZ1bmN0aW9uLiBUaGVyZWZvcmUsIGl0IGRvZXNuJ3QgcmVx
dWlyZSBhDQpOT1Qgb3BlcmF0b3IgaGVyZS4NCg0KVGhhbmtzLA0KVHJldm9yDQoNCj4gDQo=
