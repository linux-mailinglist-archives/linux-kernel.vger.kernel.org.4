Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31570653A6A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 02:56:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234730AbiLVB42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 20:56:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiLVB40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 20:56:26 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD2924BE8;
        Wed, 21 Dec 2022 17:56:24 -0800 (PST)
X-UUID: 1c61585237964125be3826791360529d-20221222
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=PI9eaY7bO1OImrw1dtRTC8Z8NFvz4pK4gXxYM5YsLgw=;
        b=lys2QVnBeGpHdVcOt0qDMDCg54UDiHDI6vRUCV4NrjCOviMn0ST6A0hgr9ClmrOK8GxWhZ9gcAkT1IbdSuAHqJ5Zxp3LEDHqTuXIjS23S2yZVsO5rGFuI6leNX9NYajJyWo5UgB3Ox7PwfTMhOnUXl6k1fSEQtFdYKTBafcRvDs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:396827e5-bfae-46c1-91a0-c38e780f12b0,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:dcaaed0,CLOUDID:5f259cf3-ff42-4fb0-b929-626456a83c14,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 1c61585237964125be3826791360529d-20221222
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <biao.huang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 653180477; Thu, 22 Dec 2022 09:56:20 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 22 Dec 2022 09:56:19 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 22 Dec 2022 09:56:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CMWoAbSIA3oi8djA8kDH7x76RdZMWbVT+SFGbE0r0rMHNZDIR8uXr8gAtyq5VsZkUzAWdwFsv/nEj7InktTssaA+1mv3NDrmSRAr4GtBliIuNRwUdjqd+dSSjN/FfOnnjt0fMzuOsBNTBMdx0inVSEb9Kkk15J/yuI4QhKTi6YsQOXLIr59N8gQzamlkyJF041Iaphzt0UAfpHuR5PerzyrjtkvFWDaYe5z5zMvE4w9LbWbtxj6pszx1EaPuYIu2L6f5xZ5KcxYRcdIsrlERH9+yfK5rs0S4OT/OmTAgK9GzpnnixPpmHLkrmZooZAwYyVdBir4dq5PfkRdxiy/3Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PI9eaY7bO1OImrw1dtRTC8Z8NFvz4pK4gXxYM5YsLgw=;
 b=dklGHBKXWTfNTRKJng60mihOiynGbCL3BS7eCPZ02hyJVWzoddbkdGz5UBP9O3InW4opvLXXMcjvuKEKkhTm2WsFYfz4Ei2iwf5aX+ydJOPtv298OBmiJ9GkFBT87kz2Gk4Fm//I1fqnoqgl1H1xmtJdsYZiEtM0YEcVuj3wkqLcL4+OCoMX9tcecOGUtb9tZ27eIDkoJnEkjv+GxZB7FEgXoqxz9V5704PYXYmiYBOoGTnjkFI+AoQEX7gnkBSzAdrI06qmgjV4dUfOEBkum0EdlbloZs6jaZu8Mz6TAmaB/3Itu+9bhenOreiJZBNbIDc/E6CFoOCrlfF1HjVCmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PI9eaY7bO1OImrw1dtRTC8Z8NFvz4pK4gXxYM5YsLgw=;
 b=oADVam9V9S4w9aS/00ovdzL53oaD/8OPxVp/I5z++eOYoP+lcJ/LnrvWynkiLIcNCdbEOKydCfYjISpwi2CH5V+PZiNbgM+aDZU/HwHk19HwxDnOXC1+83gmF/YdEx26gOKs6RAu++kN//QC0x4k5Ya9Gwoh4SHxBVLbzvqRrZo=
Received: from PS2PR03MB3877.apcprd03.prod.outlook.com (2603:1096:300:39::13)
 by TYZPR03MB6527.apcprd03.prod.outlook.com (2603:1096:400:1f8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.6; Thu, 22 Dec
 2022 01:56:17 +0000
Received: from PS2PR03MB3877.apcprd03.prod.outlook.com
 ([fe80::6937:eb54:1588:eb56]) by PS2PR03MB3877.apcprd03.prod.outlook.com
 ([fe80::6937:eb54:1588:eb56%6]) with mapi id 15.20.5924.016; Thu, 22 Dec 2022
 01:56:17 +0000
From:   =?utf-8?B?QmlhbyBIdWFuZyAo6buE5b2qKQ==?= <Biao.Huang@mediatek.com>
To:     "andrew@lunn.ch" <andrew@lunn.ch>
CC:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?= 
        <Macpaul.Lin@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [RESEND PATCH v4] arm64: dts: mt8195: Add Ethernet controller
Thread-Topic: [RESEND PATCH v4] arm64: dts: mt8195: Add Ethernet controller
Thread-Index: AQHZFOOb0x1W2WHEIE+aRd0M35H4Q654UzEAgADULAA=
Date:   Thu, 22 Dec 2022 01:56:16 +0000
Message-ID: <60dcfa4084fc1d2aefb5bdaa8d2a7eef35d94970.camel@mediatek.com>
References: <20221221022523.8458-1-biao.huang@mediatek.com>
         <20221221022523.8458-2-biao.huang@mediatek.com> <Y6MHQnUcfBjibA8C@lunn.ch>
In-Reply-To: <Y6MHQnUcfBjibA8C@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PS2PR03MB3877:EE_|TYZPR03MB6527:EE_
x-ms-office365-filtering-correlation-id: 152f36d6-ee3c-4d1c-21d1-08dae3bfb6ab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ySYYjMF4PfGgMkl2uYnO5DStnunj7WQG5khSZL2F6jxzhtuZI24PQF42G0K5ansdYNhBLRUdlBNS+F/rur1rArJnlLT072D9dJTwvEaG2+Cjp1Kp2QxdQSh2j0dCbMPIDUykZJFZvsbpGFUylgJhzu3YlhrDZNdiff2YkCJmNIAbTRmw7jpneHQrr1gLJ+2FjP/mtk5uTauh+syDxqKwb9XoTszhA8dm36+/UopphDags7yfBPtjkCMKo4liUIzuLRxoLeVJydpOeS4T7oA8u2NvbqCkyUEa/V/0LH/K0ygHReTMylyvQvjV3Cvz6CJuSopV3Whu9XVjpSF88V5rraM2H9PV5kSJ58waQx9BHot2QfAManB2ypCeoRdPJcaWI8Dt4xcwutWeETfeapqrfokCRnOr4F0nrvwJ7JvGAFd2idPVEbrYs+XgvXNfixAOH60mrF/tSWGaGAv7wjK8BUR32BANZd2BK4RrEWJUx2WtdK1nycFNg5gPK3OeIZqWUWVT8fBdrxcOrwpuRNWyHmIhp8VvKK15rYA/CV/7ZvAAiZgB29CTbcWzDzMZnuyMp7ntL6OWV70j9CqBw/0PcaSMKtAKMF1dNNZGnOVxp6tZAj5Gw53WkDVfKhSC/Q8qaGQCySoQPC8OHEWXrFuN+qUZFllVP9zP6HmF9u0J1034rvvF6QLdHHAYBJTlV38CZ8YbR//vUI1CCPrfi+xr/S4Z4jl/J2ZiEpwOqjqe5w48VKUZ/MWZR1ObJnq+73NO
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PS2PR03MB3877.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(39860400002)(136003)(396003)(346002)(451199015)(64756008)(8676002)(4326008)(41300700001)(66446008)(5660300002)(66556008)(76116006)(66946007)(66476007)(8936002)(91956017)(316002)(36756003)(85182001)(2906002)(6916009)(54906003)(4001150100001)(86362001)(6486002)(478600001)(71200400001)(38070700005)(38100700002)(6506007)(26005)(186003)(6512007)(2616005)(122000001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eVZZVVdib1piVk5VcEZLSkpFME9iZ0RzMWpKNXQyWCtUYkZRYWp3bE1PYVh1?=
 =?utf-8?B?K3R5Zk43QnorR25mRzhVUUFYTGxpblBnUjVuQTR4SkJwVEdML3lldTdSQjBu?=
 =?utf-8?B?WmVjNmdZZzQ1dlk1RTBZRDJRbmx1M1Jlems0Q3hsOVltb0RLSkU3eWRCNVpk?=
 =?utf-8?B?clZ1Z2lsMlltRmFWeitmSExKd0tPZzcveG1HOGZNRXhSbEE1UFcvS096U1ZK?=
 =?utf-8?B?anZCWEs2clRkWjM3Z29QMnhWY0JCRVRDd2MxS1V0VWtjdldtbDdDWmNnZ3BX?=
 =?utf-8?B?OHpkcXdkUUJTOXpjWTVCTk96NngrdGliTi9xbnVXZGhXWk94eWlhdTRmbzdD?=
 =?utf-8?B?cmdkbGwwbUp1TkFoVjgrQmtZVHY2dE1lOUV1V1JURkxjUWxYMnM4YkJhQ3FK?=
 =?utf-8?B?ZWJMRFJCbVpCenUzRFF6VVNveG9LelFBVXZzRXJEaW9pRWl1N25hYitzNXlj?=
 =?utf-8?B?SUZNQyttV0V3WGIwa3p4ZWdteVlGQ3JoWnJSaVk3bXRFN0FGVFNGa0wzUkpW?=
 =?utf-8?B?TFd5Rm5BTTVBdlU5ckpUTDZMT1MzRWc4Slp1VUFkUFhGSlB6WEFrWjBjMm4y?=
 =?utf-8?B?L3JRczRzRW94QlZLZldRc05pQnBSdDNUc0tXdG5wVFdZMTE5TWVIcTBQbWtS?=
 =?utf-8?B?dVNSOU9Md3JsWUhRSStVYkZlNW9lVzFWYWozVldIaUZNSkFNeXlwK3RUZ21Z?=
 =?utf-8?B?QzFSdUhJMWhkSEM2ZGt3U0dHb2kxK3dCU1g5emJMRmpNbjlGQmFFZDBldSs4?=
 =?utf-8?B?RnpXSFFtaDBJY3pTZ29saHp2SW1lOWZjR0hVczgveTlzTzhaRG9EU1hYTVl0?=
 =?utf-8?B?Y2U4YmsxM3oyUXQ3a2NHUzVxZWtWMXJ5aHI0OFh3ODVkNjRVQmh0K3ZHMDRY?=
 =?utf-8?B?dEtvV200R0ZDTDBPQzZnVFZDYjB0TW0wNTdxaVZpcU9xb2tZclVjdXQrVHBt?=
 =?utf-8?B?dXhBUGtsQ1hIcW1hVUlnd2htbDRxallpYVhvK1F4N2c2TEJBOHpMang2VmxK?=
 =?utf-8?B?RVBWRUxWdEhCMktNdmVhUUZ4QjdHSDZvTVZzSHcydnJqRkltbWhRa2FEYVNZ?=
 =?utf-8?B?QktUU2h0TXB0Q3hpVGVpQU1mUnFGSFk5S0lwR2JiQlFGczQyRU11dWhOSkYr?=
 =?utf-8?B?bGhoRnBzTXpjaEVEUXUwZmsrZnVKWW9MWHFCYnEzVmhTSVJaUy9LQU1DdUxN?=
 =?utf-8?B?NVUrWEZFcHpLNEViVDYrT0FwMGFoYzBHbDRybjd4RnFmZDJuK3g5S3gzL0NO?=
 =?utf-8?B?L3NMY3VGSUJmTjVTZVdaNHZKZDRZZG56Zm1zaTd3dlpKSVJFWTQ5VFJ6YktT?=
 =?utf-8?B?OC9TRVpvUklXYXJYVndHQ21sN1ZIS3hXUjlPQms4QW1lVUZDcnd6VU1wNnNE?=
 =?utf-8?B?Y3E0Z1NwTklRODY0WnFkaTZ1b0RTWVpXb1k5MnpaTXlRLzBHVTNIMHFPaWh4?=
 =?utf-8?B?SEFhVXo3N1IyOEhLU3p5N3VkQlRRSXRlTldZVjA1aDY3bzU1K1djV29weDFh?=
 =?utf-8?B?USs3cWVnNm03a2JpeVBsUE8vV095SnFLL1JEWU1kdk1TZEczYkhwdDhjMnc5?=
 =?utf-8?B?dVdMVGNJeDNHOHRDQytSdDA2cy8rb1IxUUR3SDNZSDhPSitUOXBvMGVvNUFi?=
 =?utf-8?B?UXZxaDRNbXZEOE96YkoyTmlOYjA4eUlaUGprYlVJNC9KOWZaL0tsZ0lwWG1s?=
 =?utf-8?B?U1M4YzhBVEdOT1E1VVNMYnZySkdLbG94emlMK3RQempIWVdWZmxMcnpnTW5j?=
 =?utf-8?B?dE5XOCtpYmNyTEFLd1l2UzM2TEFpcExqTmV2MjYzTEVsclNvRjNSN0Eya1Vk?=
 =?utf-8?B?VG55NWNMNkM2d2REbUxxaWFxRjc1SEpqNHJzT2ZkZVM0ZzBRaTFIejRxQk9C?=
 =?utf-8?B?ZnpHM3B2QlZUOWVJNFhTL2NGclV6TWV5WXpzWGVKRHpPZzhmc1Bad3BHaVlW?=
 =?utf-8?B?SmxjSlVLRm5xZzMyelRPNFJYWmdncW93cTZ5dGcrdFg1MTA1R0NadzIzRlFn?=
 =?utf-8?B?STAxSCtNa0hrVGttQUdLa0NxdG1UREV4L0xRMkF5MXZYZ2haWng0KzcxMDRq?=
 =?utf-8?B?V2ZBeWhFTDRpRXdwcVhBb0F2ZGl4WHk4QThiMDFDVkFkazhuYU0rL2swbkFo?=
 =?utf-8?B?c1JqNlZxek43T2VYUzFmclhCRnRyZ244SCttU2lUSytXUnRWUEpXWXdNdDdS?=
 =?utf-8?B?dnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9DE3122116622F4C974619C648AFE334@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PS2PR03MB3877.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 152f36d6-ee3c-4d1c-21d1-08dae3bfb6ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2022 01:56:16.8648
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xS25hzcFvrx0ehCCRp4D+pz7LVecJjV9w5LWTGvlzz3MxzzQfOSuHoiSv48vUWuCJym+WquqVoShcz2bDeEtJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB6527
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RGVhciBBbmRyZXcsDQoJVGhhbmtzIGZvciB5b3VyIGNvbW1lbnRzfg0KDQpPbiBXZWQsIDIwMjIt
MTItMjEgYXQgMTQ6MTYgKzAxMDAsIEFuZHJldyBMdW5uIHdyb3RlOg0KPiA+ICsmZXRoIHsNCj4g
PiArCXBoeS1tb2RlID0icmdtaWktcnhpZCI7DQo+IA0KPiBUaGF0IGlzIHByZXR0eSB1bnVzdWFs
LiBZb3UgZG9uJ3Qgc2VlIHJ4aWQsIG9yIHR4aWQgdmVyeSBvZnRlbiwgaXQgaXMNCj4gbm9ybWFs
bHkgcmdtaWksIG9yIHJnbWlpLWlkLg0KV2UgZGlkbid0IG5vdGljZSB0aGF0LCBhbmQgaW4gb3Vy
IGRlc2lnbiwgd2UgY2FuIGVuc3VyZSAybnMgZGVsYXkgaW4gdHgNCmRpcmVjdGlvbiwgc28gd2Ug
cGljayByZ21paS1yeGlkLg0KVGhlb3JldGljYWxseSwgd2Ugc2hvdWxkIHN1cHBvcnQgYWxsIHRo
ZSBjYXNlcywgYW5kIHdlJ2xsIHNldCBwaHktbW9kZQ0KdG8gInJnbWlpLWlkIiBpbiBuZXh0IHNl
bmQuDQo+IA0KPiA+ICsJcGh5LWhhbmRsZSA9IDwmZXRoZXJuZXRfcGh5MD47DQo+ID4gKwlzbnBz
LHJlc2V0LWdwaW8gPSA8JnBpbyA5MyBHUElPX0FDVElWRV9ISUdIPjsNCj4gPiArCXNucHMscmVz
ZXQtZGVsYXlzLXVzID0gPDAgMTAwMDAgMTAwMDA+Ow0KPiA+ICsJbWVkaWF0ZWssdHgtZGVsYXkt
cHMgPSA8MjAzMD47DQo+IA0KPiBIb3cgaW1wb3J0YW50IGlzIHRoZSAzMCBoZXJlPw0KQXMgZG9j
dW1lbnRlZCBpbiB5YW1sLCAiRm9yIE1UODE4OC9NVDgxOTUgUkdNSUkvUk1JSS9NSUkgaW50ZXJm
YWNlLA0KQWxsb3dlZCB2YWx1ZSBuZWVkIHRvIGJlIGEgbXVsdGlwbGUgb2YgMjkwLCBvciB3aWxs
IHJvdW5kIGRvd24uIFJhbmdlDQowfjMxKjI5MC4NCiINCnNvIHRoZSAyMDMwIGlzIGNob3NlbiBo
ZXJlLg0KPiANCj4gWW91IGFwcGVhciB0byBoYXZlIHRoZSBQSFkgZG9pbmcgdGhlIFJYIGRlbGF5
LCBhbmQgdGhlIE1BQyBkb2luZyB0aGUNCj4gVFggZGVsYXkuIE5vcm1hbGx5IHdlIGhhdmUgdGhl
IFBIWSBkbyBib3RoLiBDYW4geW91IGFjdHVhbGx5IGRvDQo+IA0KPiBwaHktbW9kZSA9ICJyZ21p
aS1pZCIsIGFuZCBtZWRpYXRlayx0eC1kZWxheS1wcyA9IDwzMD4gPyBUaGF0IHdvdWxkDQo+IHRo
ZW4gaGF2ZSB0aGUgUEhZIGRvaW5nIHRoZSBiYXNpYyAybnMgZGVsYXksIGFuZCB0aGUgTUFDIGRv
aW5nIHRoZQ0KPiBmaW5lIHR1bmluZyBuZWVkZWQgZm9yIFRYPw0KWWVzLCB3ZSBjYW4gZG8gcGh5
LW1vZGUgPSAicmdtaWktaWQiLg0KRFRTIGFuZCBkcml2ZXIgbW9kaWZpY2F0aW9uIHdpbGwgc2Vu
ZCB0b2dldGhlciBpbiBuZXh0IHNlbmQuDQpUaGFua3MgZm9yIHlvdXIgdmFsdWFibGUgY29tbWVu
dHN+DQo+IA0KPiAgICAgIEFuZHJldw0K
