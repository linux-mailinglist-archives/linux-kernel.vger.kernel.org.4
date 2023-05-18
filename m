Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 393527077C5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 04:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjERCCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 22:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjERCCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 22:02:38 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10032D7B;
        Wed, 17 May 2023 19:02:30 -0700 (PDT)
X-UUID: 0766964cf52011edb20a276fd37b9834-20230518
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=Xa4w/3QETHUWUG/OgI6MhqmjQ7CA6Y5FIl/ParTd7oI=;
        b=Cq/rcnu6eLPPabH+yhqq+KPe9iWgagE5WL2lPPbyJvjc6gaCxFGYYRZFzGSfHm03PogjoFgtWBv6rxo9NGSYvXwrhe/CsTvH/yaqiV9MDprXwkd+OfURFuCh1L7D/78WiII6qnbs03N6rViNh9M3h1WUvPC+j107IBAFpT/rPgM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:24999063-3961-4245-ba8e-9924d7686afa,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:d5b0ae3,CLOUDID:9b9133c1-e32c-4c97-918d-fbb3fc224d4e,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 0766964cf52011edb20a276fd37b9834-20230518
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 302718179; Thu, 18 May 2023 10:02:23 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 18 May 2023 10:02:21 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 18 May 2023 10:02:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=guqzSNvCV1BomrCkNX0Ryjx/9XYQs2mp45flAG/m/wrtb1lGtKCNpD4HwSPeLKDR1y//e4QfpjOzBdV4sxjSnMbmeYq5biUADDpa/rTAEAE0QP67dD6rQEeCHBDe3ROaKEZe+ISi/mgKcSJG2JYO48CCPDj8BUFaWQDvcSN/msAeHEhL0ZI/Ks5GwM6Nsd6VT6qfa7SpVqbOmwudBx2l6F797uY+LXRM4pgUuqmxBw4ADn+RvRj40gMo1UpS8wB6evXswIKFqZi44+vHpqnAiHhwkKat/CAZ0kkNw51YuhkUNYhnThJCJ7pDGGU3fpr1cSP7TlkiORN410VVmVtpeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xa4w/3QETHUWUG/OgI6MhqmjQ7CA6Y5FIl/ParTd7oI=;
 b=EE7RqNeqsB3lk2L+/TOojj6yyCSDc7ydjO1PS2lEJtJ/79p0+0CVSLdWg1wmxWzmQTfBnkJ73zZQ0cfdZAzOBDELSGEfuhDKJ3RzYdt4g1ZSqytheuKu+KYoNXtj6P5+soBWUEhWCxkHTqdRl0I66Jt2pKWqCqqkwL4KNMrPtybO3HSD5g0zl72Hj2KnrwEi0Y/I2OthjVlVv9RxfeSlS/uxoU/IzNa4JCVpa6+YG2GAz5iXKqcWUxYfwxQrDDBHqeQLjeYFwz21ggvNQjDT4IaG7Ybr6ElX8t5P2hfvae3VrU3B/mEPUw84t4y/kOugoPHr9fJcPDpn4Bt3vVj/oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xa4w/3QETHUWUG/OgI6MhqmjQ7CA6Y5FIl/ParTd7oI=;
 b=sKzbykIYzNU5LnXQgqVNEG0NLLGBxLlKd2fuLpl1e3nyugqZZhT78e81eEKUOFUJ6x9TlE74Y7QuU+1FhjaQs4Y/RB+Sz9ixUDWgv/dGRfUCe/EghiwwYLLRAxwbD1FXfyjGQ4+Ymn9ve9EdRjf/CH4/cnY/P+v1ZRn5fgGwlsY=
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com (2603:1096:4:1e9::14)
 by SEZPR03MB7441.apcprd03.prod.outlook.com (2603:1096:101:136::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.34; Thu, 18 May
 2023 02:01:18 +0000
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::bfa:5a41:b6e1:63de]) by SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::bfa:5a41:b6e1:63de%3]) with mapi id 15.20.6411.019; Thu, 18 May 2023
 02:01:18 +0000
From:   =?utf-8?B?VHJldm9yIFd1ICjlkLPmlofoia8p?= <Trevor.Wu@mediatek.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "tiwai@suse.com" <tiwai@suse.com>,
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
Subject: Re: [PATCH 2/5] ASoC: mediatek: mt8188-mt6359: register hdmi/dp jack
 pins
Thread-Topic: [PATCH 2/5] ASoC: mediatek: mt8188-mt6359: register hdmi/dp jack
 pins
Thread-Index: AQHZiLDrSjRN9q3j/Uq705XMnwebEK9eVN0AgAAKwACAADJWAIAAte6A
Date:   Thu, 18 May 2023 02:01:18 +0000
Message-ID: <a9901a21d8e1e9ff91c98f98125bfd4dad798e87.camel@mediatek.com>
References: <20230517111534.32630-1-trevor.wu@mediatek.com>
         <20230517111534.32630-3-trevor.wu@mediatek.com>
         <154497b3-f5c7-45d6-edd5-729642b80be5@collabora.com>
         <9685a64561fc90d592481ae5e95d1e849fe3c55b.camel@mediatek.com>
         <aee5f540-4f8b-f087-57d4-bfdafa4a0568@collabora.com>
In-Reply-To: <aee5f540-4f8b-f087-57d4-bfdafa4a0568@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB6686:EE_|SEZPR03MB7441:EE_
x-ms-office365-filtering-correlation-id: 69e6fd98-244f-4205-4738-08db5743c509
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /f5pEPIaXvD9WswbVm6wd5mdmjc6pNd2ig9a8iGbrvjvcemnVFERt/9CMr0ljoXd0jJGh3eDyzTDAWhydnqVhBTCq7i11PqP7xAHTI6xHo1bVPJjSiMCL1BSP100/uSaB+YpJU27XTOgR85+k410tBgQxxcFddvydirjjDqDxylYtkVyX+TkTnwVYfFFY3WjuW/udFyV8zsOsVXYyXMwkvKd4+kgER09gKWJJIanzUHz7cUWFX1FDf2+8LYblBMo7tQAmuOFagUpWlzF4hOpIdWC5cm9VbwPgu8+w5ZAjWC94OiRR1nsd7HbfIluFD39AxPKPRVt46M0bBmhMJoIE08A2fznFfKkBEXDNg7mtbur/pH5ZA1XATQyetW4Dn7krQ0MHIQyp7i+gukzUSN8G1ZJP8imC4nIxPDMseGTt6Xp3kauIuwGncGsaeKt2TDOdDJ1d3/R+ycXhwVwvrSUNBQB6KgVPJJ+xMUW1FqAet42yZbIS1otjlEcOmvMRue6QtrmTdNsXSIY3qwvaR97Vs48Kmss8EPR63qutbetfaVY0Qy64LmgvocV9BInwBFvUIhekaCjeG4UUuNPpfLl7iPQHNl2uMv+1TyH9vwUfqZHCxVyRAjFGMbTXhCwvT/o
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB6686.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(396003)(39860400002)(136003)(376002)(451199021)(316002)(66946007)(41300700001)(54906003)(76116006)(66476007)(66446008)(64756008)(4326008)(66556008)(91956017)(110136005)(6512007)(26005)(478600001)(71200400001)(6506007)(6486002)(8936002)(7416002)(966005)(5660300002)(8676002)(86362001)(38100700002)(186003)(83380400001)(85182001)(38070700005)(122000001)(2616005)(2906002)(36756003)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NGdOalgvaDZxV1A0eHNFK1NiREhZMDQxRjlmMUZrR2piKzlicXN1TkJQYzNQ?=
 =?utf-8?B?UytwczZPK3pHSDVrY1FLVzVOY1BHY1daRk9HbDZBVGNtTFFRUk4yZHBJUEk2?=
 =?utf-8?B?VTU4ajk2M0FOdDc2dndyWVFoV3haWDdsdTVpMVM0elVoUGQ4MFB1bHdicGVB?=
 =?utf-8?B?TkliVTlVcmZQd1dVcEhlQ2FaeTJlQ3MxSnIvRm5CUUU4amlka2xsZWFJZTg0?=
 =?utf-8?B?SkpOdkdwTHAwclppazdRK29vUWovQVJCYitXUUI4RklCUHE0c1BUbGJ0RlI5?=
 =?utf-8?B?Z0ZNdWV1TkJkLzVZOWJsaTBmZENxSCtIYXVPV2NPRTB1anhza2JZTEV6MHJx?=
 =?utf-8?B?dzJPWDZhb01EdnpkNjIwbVpGVTkyUzBNUkNUZWFLUVQ3V3p6cDVFWDFrLzZ4?=
 =?utf-8?B?cFF2Z1pvQ3hpd3NyRXhWZHoyNEg5d0k3MWNqRkFKNTgvcEF5VG5FRVJHV0FJ?=
 =?utf-8?B?UEhqM2lMaHEzcWJsWjlNNlh0N0RzMmRZTXFCSm9ZaUpENW40RmhvMTJ6TjMy?=
 =?utf-8?B?TEtlQTMxa0ltc3I3L1d5YVRLSW4xWE0xWlgyQnFScXVYUmRQbmNXUk4wVmVw?=
 =?utf-8?B?N3ExMHhUdkR6L3AwZGRWZHZHNjBYQVhIOFoyZVVHMVdGREFMNkE1OCtoVHl0?=
 =?utf-8?B?YzlQdXdLZUxvbDc3SXlFc0hPSVY1ZXk5ZHpjVDdWUjF0WUxlOE5PdDZ6UEpC?=
 =?utf-8?B?dm4vNlVmcXZqTzZDQUpzNWhNUjM3K1AvOURwbHF0WWZDSklOZVYyQlhyY09s?=
 =?utf-8?B?dDBoak1nci9OUTk3VUxScGw3SlRCOWtwSFY5WUJSYlJxNzBYMHRldHhreTNl?=
 =?utf-8?B?VFZvVU5LTXhwOTBaL3ZyWHBHYkExeHZ6NnFuL0dsc1ZqTVNrZEtJYmhIL0xs?=
 =?utf-8?B?UzhlZStwQzB5Z2t0V1haSlpTNGNScGdCQjZ5M3gxWEpqK2FCM2NNL1Jka0s3?=
 =?utf-8?B?clhtcktuUW0zTU9PdEFtSVpZVjhuMjIrR2dCVU5QWDNRT3BocVh3VTdmYWU4?=
 =?utf-8?B?OUU0Qk1TZ2hWOFpHeTIvUWxYS2g4c1ZSY1RlUDVIVjk1c2F6dENCa0RZUFIr?=
 =?utf-8?B?OHZIRFJiTlNtVUhOdFVPemUvZS93VG5tTUZ1NG1PRVhkeHRjajZCN014TGRB?=
 =?utf-8?B?ZmVzRS9MMFd4aS8rVmJ5MU41WGVaYUkzNjA4Z3Z6dmVYc2RDczdob3ZxR0JG?=
 =?utf-8?B?MzRyc2MvYkJwUDlMNEExMW9zOFBrOU1mNitLSzR1Y1dtUmVML2xqMnpSQzlk?=
 =?utf-8?B?MkNsQ1BtTEMrUXpEM2JnQVNuYmp5SUFUeG1NdFlFb2ZTTXV2UUpoRW4yajBx?=
 =?utf-8?B?YUZ1ZTd6eTZoVERjdTFRNE5sYk1qQUYwNXNhTTQ1and3QUZRY2FoS29LSUZy?=
 =?utf-8?B?amllc1ZwbFR3MDF4WlBzZ2JUSEFTQUZhTC9mV1NOYUt1VlFZS2JCcC93WWlr?=
 =?utf-8?B?Zm81Snc5N1NQL1NZdHl3YUhwQldMODdQTUtJdzM4dXMzcm82M25NMFg3M3Ax?=
 =?utf-8?B?VmNtOFVpcGgrS0lOdHprOEcxTEpQbHNiNzBrc1R6cU5GeGhqQ1h3NUVOL1pj?=
 =?utf-8?B?U2xRUTdzRm5HUkwwaUlyYmJyOUFocDJyekxoVHZnd2Q4SWFGYkxPbGgxU0E1?=
 =?utf-8?B?OTZQT2RpUmdKUkRmcDB2TUU5TFBtcnl1MzM3dEJoTTBFVW9FOVJPczlKNkpu?=
 =?utf-8?B?ajNsUFhNdTVFQnZQcFJiU2ZZK0pIcWY5VFZObXdkVmkvUXdrSlFIQjlGeFhn?=
 =?utf-8?B?NUprRmdab01ZS3g1NUY0aG4wZmNZa1pSVUlISVRuaHRCYnpwOWdwZUJDMlV4?=
 =?utf-8?B?TGc5cnpoVzhXc3VGMHN2dG5qS3lKU2w4Rjk2MVZqcG9SKzUyRzZodkpsVjBQ?=
 =?utf-8?B?OVhERTBIT2lEMzNjc0dUVmU4b2U5RXVxTnBLamxTc0JoMGtUYXpJZFhQZ2dI?=
 =?utf-8?B?UHJmbGRINkZCbTVqc2NGdWFaU0o2ZU43YTBWUHpSaXlJRElQdWhrNWd4SXVE?=
 =?utf-8?B?RzRIVXR6ZTJRd1lwcVBPRUhsRllNcHU5c1BiNk96M2ZYSXhudE9MSURVZEZh?=
 =?utf-8?B?cXAvWGp5c3VzSXBvZUFlUTdTZjFQeDc0REtsaUYzVUsyTytCQmhYMFRGMEVJ?=
 =?utf-8?B?TysvZ1ZjUzBpT3hRZ0JlOWtZdGppTDd5N1d2NzRTekdDaFRYUW5LZzN6WDhE?=
 =?utf-8?B?cWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5901772C91254E4FB2F48D06C955E255@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB6686.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69e6fd98-244f-4205-4738-08db5743c509
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2023 02:01:18.3059
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /NpXHIXG3cN2w4b/RjGQcup+D3vv8CdNIO82M6M7v0/Qpwpwgy+IWT79IBwh+d3+N2rmmNCCu+FqwfGn8exBOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7441
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTA1LTE3IGF0IDE3OjEwICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRl
ciBvciB0aGUgY29udGVudC4NCj4gDQo+IA0KPiBJbCAxNy8wNS8yMyAxNDoxMCwgVHJldm9yIFd1
ICjlkLPmlofoia8pIGhhIHNjcml0dG86DQo+ID4gT24gV2VkLCAyMDIzLTA1LTE3IGF0IDEzOjMx
ICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBSZWdubw0KPiA+IHdyb3RlOg0KPiA+ID4gRXh0
ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVu
dHMNCj4gPiA+IHVudGlsDQo+ID4gPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRo
ZSBjb250ZW50Lg0KPiA+ID4gDQo+ID4gPiANCj4gPiA+IElsIDE3LzA1LzIzIDEzOjE1LCBUcmV2
b3IgV3UgaGEgc2NyaXR0bzoNCj4gPiA+ID4gU29tZSB1c2Vyc3BhY2UgYXBwbGljYXRpb25zIG5l
ZWQgamFjayBjb250cm9sIGV2ZW50cywgc28NCj4gPiA+ID4gcmVnaXN0ZXINCj4gPiA+ID4gaGRt
aQ0KPiA+ID4gPiBhbmQgZHAgamFjayBwaW5zIHRvIGFjdGl2YXRlIGphY2sgY29udHJvbCBldmVu
dHMuDQo+ID4gPiA+IA0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBUcmV2b3IgV3UgPHRyZXZvci53
dUBtZWRpYXRlay5jb20+DQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiAgICBzb3VuZC9zb2MvbWVkaWF0
ZWsvbXQ4MTg4L210ODE4OC1tdDYzNTkuYyB8IDI3DQo+ID4gPiA+ICsrKysrKysrKysrKysrKysr
KystLS0tDQo+ID4gPiA+ICAgIDEgZmlsZSBjaGFuZ2VkLCAyMyBpbnNlcnRpb25zKCspLCA0IGRl
bGV0aW9ucygtKQ0KPiA+ID4gPiANCj4gPiA+ID4gZGlmZiAtLWdpdCBhL3NvdW5kL3NvYy9tZWRp
YXRlay9tdDgxODgvbXQ4MTg4LW10NjM1OS5jDQo+ID4gPiA+IGIvc291bmQvc29jL21lZGlhdGVr
L210ODE4OC9tdDgxODgtbXQ2MzU5LmMNCj4gPiA+ID4gaW5kZXggODMzYmMzNjJkYWQyLi42YzNm
MzZlMmZmZmQgMTAwNjQ0DQo+ID4gPiA+IC0tLSBhL3NvdW5kL3NvYy9tZWRpYXRlay9tdDgxODgv
bXQ4MTg4LW10NjM1OS5jDQo+ID4gPiA+ICsrKyBiL3NvdW5kL3NvYy9tZWRpYXRlay9tdDgxODgv
bXQ4MTg4LW10NjM1OS5jDQo+ID4gPiA+IEBAIC0xNTEsNiArMTUxLDIwIEBAIHN0cnVjdCBtdDgx
ODhfbXQ2MzU5X3ByaXYgew0KPiA+ID4gPiAgICAgICAgc3RydWN0IHNuZF9zb2NfamFjayBoZG1p
X2phY2s7DQo+ID4gPiA+ICAgIH07DQo+ID4gPiA+IA0KPiA+ID4gPiArc3RhdGljIHN0cnVjdCBz
bmRfc29jX2phY2tfcGluIG10ODE4OF9oZG1pX2phY2tfcGluc1tdID0gew0KPiA+ID4gPiArICAg
ICB7DQo+ID4gPiA+ICsgICAgICAgICAgICAgLnBpbiA9ICJIRE1JIiwNCj4gPiA+IA0KPiA+ID4g
IkhETUkgSmFjayIgaXMgbW9yZSBjb25zaXN0ZW50IHdpdGggdGhlIHNuZF9zb2NfamFja19uZXdf
cGlucygpDQo+ID4gPiBjYWxsDQo+ID4gPiBwZXJmb3JtZWQNCj4gPiA+IGxhdGVyLg0KPiA+IA0K
PiA+IEhpIEFuZ2VsbywNCj4gPiANCj4gPiBJIHNlZSBqYWNrX2tjdGxfbmFtZV9nZW4oKSB3aWxs
IGFwcGVuZCAiSmFjayIgdG8gdGhlIG5hbWUgaWYgSQ0KPiA+IGRvbid0DQo+ID4gbmFtZSB0aGUg
cGluICJIRE1JIEphY2siLiBEbyB5b3UgbWVhbiB0aGF0IEkgY291bGQgZGlyZWN0bHkgdXNlDQo+
ID4gIkhETUkNCj4gPiBKYWNrIiBiZWNhdXNlIEFMU0EgdXNlcyB0aGUgbmFtZSBmaW5hbGx5Pw0K
PiA+IA0KPiANCj4gWW91J3JlIHJpZ2h0IGFuZCBJIGp1c3QgY2hlY2tlZDsgdGhlIGNvbW1lbnQg
ZXZlbiBzYXlzDQo+ICdyZW1vdmUgcmVkdW5kYW50ICIgSmFjayIgZnJvbSBzcmNfbmFtZScNCj4g
DQo+IFNvIHllcywgdGhlIGN1cnJlbnQgbmFtZXMgYXJlIGZpbmUuIFNvcnJ5IGFib3V0IHRoYXQu
DQo+IA0KPiBSZWdhcmRzLA0KPiBBbmdlbG8NCg0KSSBjaGVja2VkIHRoZSBvcmlnaW5hbCBjb21t
aXRbMV0gZm9yIHRoZSBmdW5jdGlvbi4gVGhlIHB1cnBvc2Ugb2YNCmphY2tfa2N0bF9uYW1lX2dl
bigpIGlzIHRvIGVuc3VyZSBvbmx5IG9uZSAiSmFjayIgc2hvd24gaW4ga2N0cmxfbmFtZS4NCklm
ICJKYWNrIiBpcyBhbHJlYWR5IGZvdW5kIGluIHNyY19uYW1lLCBkb24ndCBhcHBlbmQgIkphY2si
IGFnYWluLg0KDQpJJ20gbm90IHN1cmUgd2hpY2ggaXMgYmV0dGVyIGZvciBwaW4gbmFtZSwgYnV0
IGl0J3MgY2VydGFpbiB0aGV5IGdldA0KdGhlIHNhbWUga2N0cmxfbmFtZSBmaW5hbGx5Lg0KDQpb
MV0gDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMTQzMDE0MDg2Mi0xNzIwNy0zLWdpdC1z
ZW5kLWVtYWlsLXlhbmcuamllQGludGVsLmNvbQ0KDQoNClRoYW5rcywNClRyZXZvcg0K
