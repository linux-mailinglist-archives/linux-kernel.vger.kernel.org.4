Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C01E85FAD17
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 08:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbiJKGzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 02:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiJKGzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 02:55:49 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F3A180497;
        Mon, 10 Oct 2022 23:55:41 -0700 (PDT)
X-UUID: b5f5745943a94d4caa74b486f70cc336-20221011
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=P1NEkxkKRDguscn/sHfswQORmxbENxw1lT6Da1xVBdM=;
        b=ed24F0JL2VS7Sm5php7Ssu0LWv6tk6wF75SaqHoYSynsmeNMQS6ulx2Usss1ImrWrXDtJ0Y2bwGDpKoJ4H/TYOltwGhOR4dvLXwAb0UGBe6ElyBhmH53BzRu7w2Pp3TuEgVpny2ZcqTJubGm1C/rP1bzhsOptSgFHVegG42Osq8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:a7b40738-7c0c-4c82-9fbe-d0d7dc28da71,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:39a5ff1,CLOUDID:76edddfe-ee8c-4ff7-afe9-644435e96625,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: b5f5745943a94d4caa74b486f70cc336-20221011
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <johnson.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1354734399; Tue, 11 Oct 2022 14:55:38 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Tue, 11 Oct 2022 14:55:37 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Tue, 11 Oct 2022 14:55:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PaEFZtJwWRTPpqUZk07QX757ZcpOpwYWxpe4bLzJJqCd0U7QhgZooRlmFqFeWSz0v83klcmmdPbXTB1xBPGIfLdAE1zuRuy+rUU14Sr70Q/WPepKUeYywkUeLFUUA/JAdjjMqYYUvYl2Yhd9K6B5b/5tuRTX/hxHSR7nSeOkpZSBqCCNwwVGpgJesWxDEYosp8eaSczEWU6Zu7yiLuWQHw9BYS6jXmJ8wSQoGxNLVrTMQpSkEeBgFQXUeHzjQET02aNc0FYVeJd1rBCbvEcq0B+G/y1GCsGwkC7Z2pvDMZXpeIonEA66uL+FSV6ZNLNNkhkvBIazBpyDVuEqxPaILA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P1NEkxkKRDguscn/sHfswQORmxbENxw1lT6Da1xVBdM=;
 b=hDs7TvIxVWswinBvAF0mSLRRxwjpbq0Eu7BNez3OjZuLXPf6HPtF+PbN7rbDSbfcKKnTXjgjGnvssgzkL1QO3fECCdqeTgLIARZY4cbf53URRke2r4KdOzBV4RuuH7RQGHl0bhFpK5UjsQWF3VwexqpVhV/lKHtEx6EGHoNeYkzSToPkknR5Bm8LSPPjpWltFbX9KWBWQT3PZ5PrWTYIDIJAwBzORKjlvM8dBbatY0hzTaPaR6q9vJIfyxQuamMZ/8jI0/d8C8Fg35RGp0i2CCLeUhVVWFIM2EAh1gP/xK4lmZsApmZ14iL+/Y+gAS5zWB1fP+Uu34z+VV67Jsay0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P1NEkxkKRDguscn/sHfswQORmxbENxw1lT6Da1xVBdM=;
 b=uWkHs1w/YQUhYQxRLaaDcXvSK7stlQu81WFFPr056MeViLbj32M0I5esFTB2MskOh8Q+6xUhH1J7HmE32a3eafwWjPDdaKo4do7/iQ0Q0VyfG6bO05L0SBpzIVTvvY5xR1umSQVS5z2qLK8QxbA5x9ttJyNBn0EFrnK76PqzKi4=
Received: from TY0PR03MB6274.apcprd03.prod.outlook.com (2603:1096:400:142::9)
 by TYUPR03MB7164.apcprd03.prod.outlook.com (2603:1096:400:357::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.9; Tue, 11 Oct
 2022 06:55:32 +0000
Received: from TY0PR03MB6274.apcprd03.prod.outlook.com
 ([fe80::691d:c9be:8a6f:5e85]) by TY0PR03MB6274.apcprd03.prod.outlook.com
 ([fe80::691d:c9be:8a6f:5e85%9]) with mapi id 15.20.5723.009; Tue, 11 Oct 2022
 06:55:32 +0000
From:   =?utf-8?B?Sm9obnNvbiBXYW5nICjnjovogZbpkasp?= 
        <Johnson.Wang@mediatek.com>
To:     "robh@kernel.org" <robh@kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?S3Vhbi1Ic2luIExlZSAo5p2O5Yag5pawKQ==?= 
        <Kuan-Hsin.Lee@mediatek.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        =?utf-8?B?WXUtQ2hhbmcgV2FuZyAo546L54Wc5qifKQ==?= 
        <Yu-Chang.Wang@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        =?utf-8?B?RWR3YXJkLUpXIFlhbmcgKOaliuWTsue2rSk=?= 
        <Edward-JW.Yang@mediatek.com>
Subject: Re: [PATCH v3 2/4] dt-bindings: arm: mediatek: Add new bindings of
 MediaTek frequency hopping
Thread-Topic: [PATCH v3 2/4] dt-bindings: arm: mediatek: Add new bindings of
 MediaTek frequency hopping
Thread-Index: AQHY0/lIndFmLtg+lkiFTv0K/xrn3K32YQCAgAH2s4CACOyWAIAAE5WAgAd9F4A=
Date:   Tue, 11 Oct 2022 06:55:32 +0000
Message-ID: <b14822d9cdac1a4e61474d8c55ef3b9b2165bb03.camel@mediatek.com>
References: <20220929114624.16809-1-johnson.wang@mediatek.com>
         <20220929114624.16809-3-johnson.wang@mediatek.com>
         <ed723cb2-ba79-55d7-7869-abf153e4af0a@collabora.com>
         <20220930190703.GA657929-robh@kernel.org>
         <5b84c81d0d7f71bb83fcbef860433e4704ae5c72.camel@mediatek.com>
         <8fd7c872-fadb-5dc2-6bc1-5b59a9a3b133@collabora.com>
In-Reply-To: <8fd7c872-fadb-5dc2-6bc1-5b59a9a3b133@collabora.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR03MB6274:EE_|TYUPR03MB7164:EE_
x-ms-office365-filtering-correlation-id: fa1a30cf-4e1d-4d46-b587-08daab55975a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kDtSvNxPbtGUqdXxwOb3WBya6IOZj58epBnDKp9E4pRL/tG15MHySORrtm0FXJwLG82O/Gt1Z7TZZuiRikbdb2Y3rBefdpPP/dNBEcJsytPVkAc/qQ0fffxPMNaI4vHO6hto3XF0hgcS/S9uJklFzyrwiiKbyV7BuyqBnj6f0GFwzb5Ug7z9RMdwON7guOmDUuFM0EaWQyqPwe5hTT6KGv220hnlOi8haSa49HK841/IW9nmZjsQycff7jX7Wc21Gf/VKCD+7MwcnQHhta5OAHapIokAAYJUutq4I7FZhD2klsRjKIyMbdzIQOUma141Shy3Ah/MmyPM1MR9QSOCPjvABKDRMKZj8jxRJUjDyQKduTq54TilUopuI0XGLfI8FLnd1KO8cl+LK63nyUGSmBljK9EMXFJ+VTIwX+H2+vVdH1VvrFEbsWUchHqzSgficfAhZLDnnFnBkr2Tz9itAG4xsi3BOCRhiTjlkKNJag55JQ3K3QTL1himwNJtB7ctXggA1uptzjjapMmT/p+PjNG3B/YMy4PfG0n5arTh1rr3XNxJ/cd8oh6I8S979na60uIL3b08WuaeV/vvmEK5WhattwSnU+tPl58+0ARSnpdWbfgvYRv7DOsHNSigMTvsm2EgmQdO3EWnaOGXK8rAr9rwK44zRcTu1vK03zAmHQaLFc1+Kw85/OgXv5mLzLAzZW+f1qqM3Z75r7Lqo0ZMXHkuXrGHjzpL7cxslRQ9HlEKfAWmYRyCodKiTf4yc6rh6PKq0CC18Mw6ljcQlngVL9GD/4XsxiCiD0KQZzq7apwloqIZS3YEp6hyqR/48zrw0yhwtyTXjGrhCcPeSorBSg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR03MB6274.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(366004)(396003)(136003)(346002)(451199015)(8676002)(6512007)(76116006)(478600001)(4326008)(71200400001)(91956017)(6506007)(26005)(38100700002)(122000001)(107886003)(186003)(66946007)(66556008)(110136005)(54906003)(2616005)(86362001)(316002)(83380400001)(64756008)(2906002)(36756003)(66446008)(66476007)(6486002)(8936002)(38070700005)(41300700001)(5660300002)(966005)(85182001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y3I5a2VlZE9QVkhPQzZ0ZXZnUFZmSjdxaFV4YVMxeXZ1aVJ2K2IxVlpZeFB6?=
 =?utf-8?B?WkRXK1ZYaTlTVUVWemt6dndOeFBBaUJ6R2NZTUtaYytSa21jd1NHVXdUcFZI?=
 =?utf-8?B?VWI4SUhkTEwwUitmTnh6Vk5BbFJIbE1ZSW5JT1czODlyYkxhWFkzamNDTklP?=
 =?utf-8?B?Vm93ZnBaZkl3UFc3TGpncmJmS1JZa003cC8wYWdGa1hhR1U1NEpzNnJvZEQ0?=
 =?utf-8?B?VDduM2FLVzRYc21rQnZ6VWpxSWNVOGpUeFErNmR1ZDR0OWxaVHk0UHhQbmpW?=
 =?utf-8?B?emc3M1MwNzBKd3NkU2NBRUlKN0pzbXp6U3FkOGoxeTJYYTVoVlVGbUpjbkRi?=
 =?utf-8?B?dUdoNytpd1lCQndGQ2pBS0JkMUpiMmVFemNOY2FlNWZaQTRqOUdOSE95Y01G?=
 =?utf-8?B?d3lPWGFIa3QyYXYwbzFHcVk1MHZoT3BabVc3U1paN3hCSDlpeDZnZ2hKVHVW?=
 =?utf-8?B?aHpnTS9neEVXQzk2VkNUaXVZQndwMWlxRHZNWXRXVnhZcjNYbjU2M2k5Y1hx?=
 =?utf-8?B?VGNlSEJWbFFXdDFGdWw5Y0ZwZWRiWitLS0FVVWtFbFMvQUE4VjcyZUpMeTZL?=
 =?utf-8?B?dFJQZndKVkJoeXZDNTFtdnVIbzNmK3lsd2NJZHd1RnlGcFc4U1dueGRpQ3Rt?=
 =?utf-8?B?TEdaUElEQUltbVBWYlVCYjhwS1F2V2pDWHBqZmc4TDhyRk12YkhtOCtnK2JP?=
 =?utf-8?B?RnJ4cXRsU2hFQmVtTkVrZ1Y2TVNMWHNocGFrRmJGOFpnYnE1dXdTUjhGOFcx?=
 =?utf-8?B?eVM4bnYrNWR6SWZGbmlPUHN2bDhzWHlPTm9zdHkweHl1cUpNamVwUTZlTEdn?=
 =?utf-8?B?eVJ5Yk95WWoxWDBtWUlObEM2TWc2QmJpQ1pkWlFGeE9HaVlaeUV0elBuR3Ft?=
 =?utf-8?B?N2U1Y1A1cmNyUHg2ZXFFRjJ5cGt0L0lZc28vZ2FiUnZoMTRwSERNTW9MdEpN?=
 =?utf-8?B?cTFQNUlBOWowVEN6U1RsSnBOL1pJSGJ1cmhkSVV4QlM5OU52bHlIMFlzVjAz?=
 =?utf-8?B?N3JhZk52TXl3K3M1NjFJVi9mTjJOVHZLbDZqSUVQRzRkODY5MU4rNzY1ak5K?=
 =?utf-8?B?c0FBYUwxcnJmcEJNZHA4RmRSODdrazJUTmpqTlNMdnhJeEtaUStRUmlXaHhZ?=
 =?utf-8?B?bldjV1lNUWFMeERPWTVSdUFVRnIwQ0dvV2wxdW5vTng5alRhc1JyNDRHWXpx?=
 =?utf-8?B?aWp0My92YUZSUE5odGtSM21OMkR0Z1Rhd01Ndngyd3V5RHJEVElvb3JOZ0g0?=
 =?utf-8?B?TFNERkt2cS9JcFp3dFhCWjNTK2IvTXpla0dTejhBOUpUSVpvWWt3YTNvcnVp?=
 =?utf-8?B?UjltUlNkS1BmUGtJd0xEM1pnUEtlQWFhdzZ0WFNsdXdyU3M2a3NaMDVsVGd4?=
 =?utf-8?B?L3ZpcjRZVHp6SXdGYmQ0UUpjOXlSeVJpb2FoNEFaTGN5Zlh2TmdKU2lWWHJq?=
 =?utf-8?B?OHNlNG1YRFlZOEJqV2RwOWtlbW55d0FSYVZhMHRwM3B0a0FiN3FHZittTHdi?=
 =?utf-8?B?ZUxkVFl5NG1MMWxMT3RxNklLRjJzVzJaSHRnRnNHNG5FRmZpeFN1MlgzVldR?=
 =?utf-8?B?MlIvZTVqV25DUHdTckdmejJ4eFlGWHlUK3VqVWF1Q3VUK1Nob2JnYnYyRUlz?=
 =?utf-8?B?TDdXazkwbFVxM3Y4aThQYTdXMHJCcFJCSE9rdVV1RXVIRTZpNHVIOXpaS2Jk?=
 =?utf-8?B?cGhaTzNRSSttRDM3UXhmM2YzT0dzdVl5R04yaFFqaVBmZUx5bTFsc0hia3RT?=
 =?utf-8?B?R0Z0KzhEUXFaSTU5RGVvMUt5WElqWVNOUTcxQzRPcUIxOVdCNWg2eGt2MmRI?=
 =?utf-8?B?djg5UnlWSnZzZjZVUWhZQUJGMkxDWVpENHIvUDhOb0syZ2VBYm1QdVpqVlk0?=
 =?utf-8?B?aHlQQVdVY0JBYVM3NUFuYXhBbTVVWXZHVGlvanpGTjBEeGpuNmF5UDJ5TklW?=
 =?utf-8?B?eUpkMkFYb0U5VVNJZUtGODhIKzZ0OE9xRmF3Q3NuZlp6bmtqcm92ZmMrY0w0?=
 =?utf-8?B?cnl4dmUyRW93NXIzdzZvQ0xkYVA2MURvRDNyVDdYNTZsTXlFSFU3YXJaUnpM?=
 =?utf-8?B?c29WNkExYUR4L3V5bHBKRjRnbXVOb0EzRFlmSUl3VUdjOXZIaHlLdHY1aUNX?=
 =?utf-8?B?UkNhRUpCdDJVMFdlaWF5c3dpeW5kNml2UEUzUEZXM2IzM2ZTWllWUlptZFBD?=
 =?utf-8?B?b2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6CAFCE0CC36D9E48866C1CAC455071B9@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR03MB6274.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa1a30cf-4e1d-4d46-b587-08daab55975a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2022 06:55:32.5737
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T89CDmf/csYcr72AyTwJu61/lnoWF/y/JTfXBwY3vn5ojjlnp2OXkiY2bgL0Sl7prSoAqRalPDVXOYYwILIzVZN6WqEFtQPe2MnFb+CyHN8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR03MB7164
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_CSS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIyLTEwLTA2IGF0IDE0OjMzICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gSWwgMDYvMTAvMjIgMTM6MjMsIEpvaG5zb24gV2FuZyAo546L6IGW6ZGr
KSBoYSBzY3JpdHRvOg0KPiA+IE9uIEZyaSwgMjAyMi0wOS0zMCBhdCAxNDowNyAtMDUwMCwgUm9i
IEhlcnJpbmcgd3JvdGU6DQo+ID4gPiBPbiBUaHUsIFNlcCAyOSwgMjAyMiBhdCAwMzowNzo0OVBN
ICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbA0KPiA+ID4gUmVnbm8NCj4gPiA+IHdyb3RlOg0K
PiA+ID4gPiBJbCAyOS8wOS8yMiAxMzo0NiwgSm9obnNvbiBXYW5nIGhhIHNjcml0dG86DQo+ID4g
PiA+ID4gQWRkIHRoZSBuZXcgYmluZGluZyBkb2N1bWVudGF0aW9uIGZvciBNZWRpYVRlayBmcmVx
dWVuY3kNCj4gPiA+ID4gPiBob3BwaW5nDQo+ID4gPiA+ID4gYW5kIHNwcmVhZCBzcGVjdHJ1bSBj
bG9ja2luZyBjb250cm9sLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IENvLWRldmVsb3BlZC1ieTog
RWR3YXJkLUpXIFlhbmcgPGVkd2FyZC1qdy55YW5nQG1lZGlhdGVrLmNvbT4NCj4gPiA+ID4gPiBT
aWduZWQtb2ZmLWJ5OiBFZHdhcmQtSlcgWWFuZyA8ZWR3YXJkLWp3LnlhbmdAbWVkaWF0ZWsuY29t
Pg0KPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEpvaG5zb24gV2FuZyA8am9obnNvbi53YW5nQG1l
ZGlhdGVrLmNvbT4NCj4gPiA+ID4gPiAtLS0NCj4gPiA+ID4gPiAgICAuLi4vYXJtL21lZGlhdGVr
L21lZGlhdGVrLG10ODE4Ni1maGN0bC55YW1sICAgfCA1Mw0KPiA+ID4gPiA+ICsrKysrKysrKysr
KysrKysrKysNCj4gPiA+ID4gPiAgICAxIGZpbGUgY2hhbmdlZCwgNTMgaW5zZXJ0aW9ucygrKQ0K
PiA+ID4gPiA+ICAgIGNyZWF0ZSBtb2RlIDEwMDY0NA0KPiA+ID4gPiA+IERvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vbWVkaWF0ZWsvbWVkaWF0ZWssbXQ4MTgNCj4gPiA+ID4g
PiA2LQ0KPiA+ID4gPiA+IGZoY3RsLnlhbWwNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBkaWZmIC0t
Z2l0DQo+ID4gPiA+ID4gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL21l
ZGlhdGVrL21lZGlhdGVrLG10OA0KPiA+ID4gPiA+IDE4Ni0NCj4gPiA+ID4gPiBmaGN0bC55YW1s
DQo+ID4gPiA+ID4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL21lZGlh
dGVrL21lZGlhdGVrLG10OA0KPiA+ID4gPiA+IDE4Ni0NCj4gPiA+ID4gPiBmaGN0bC55YW1sDQo+
ID4gPiA+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gPiA+ID4gPiBpbmRleCAwMDAwMDAwMDAw
MDAuLjI1OGRmZjdjZTZiYw0KPiA+ID4gPiA+IC0tLSAvZGV2L251bGwNCj4gPiA+ID4gPiArKysN
Cj4gPiA+ID4gPiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vbWVkaWF0
ZWsvbWVkaWF0ZWssbXQ4DQo+ID4gPiA+ID4gMTg2LQ0KPiA+ID4gPiA+IGZoY3RsLnlhbWwNCj4g
PiA+ID4gPiBAQCAtMCwwICsxLDUzIEBADQo+ID4gPiA+ID4gKyMgU1BEWC1MaWNlbnNlLUlkZW50
aWZpZXI6IChHUEwtMi4wIE9SIEJTRC0yLUNsYXVzZSkNCj4gPiA+ID4gPiArJVlBTUwgMS4yDQo+
ID4gPiA+ID4gKy0tLQ0KPiA+ID4gPiA+ICskaWQ6DQo+ID4gPiA+ID4gDQpodHRwczovL3VybGRl
ZmVuc2UuY29tL3YzL19faHR0cDovL2RldmljZXRyZWUub3JnL3NjaGVtYXMvYXJtL21lZGlhdGVr
L21lZGlhdGVrLG10ODE4Ni1maGN0bC55YW1sKl9fO0l3ISFDVFJOS0E5d01nMEFSYncheFZ0NzNm
OFBhUUtwaDhuMGZmR0hIbVFJeGR6b29VdEdyMHhETlZxeV82VjB2d2NzNWstRkxybWtCM1BadXBT
dTFjaUMkDQo+ID4gPiA+ID4gICANCj4gPiA+ID4gPiArJHNjaGVtYToNCj4gPiA+ID4gPiANCmh0
dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwOi8vZGV2aWNldHJlZS5vcmcvbWV0YS1zY2hl
bWFzL2NvcmUueWFtbCpfXztJdyEhQ1RSTktBOXdNZzBBUmJ3IXhWdDczZjhQYVFLcGg4bjBmZkdI
SG1RSXhkem9vVXRHcjB4RE5WcXlfNlYwdndjczVrLUZMcm1rQjNQWnVsWHdCQUNrJA0KPiA+ID4g
PiA+ICAgDQo+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ICt0aXRsZTogTWVkaWFUZWsgZnJlcXVlbmN5
IGhvcHBpbmcgYW5kIHNwcmVhZCBzcGVjdHJ1bQ0KPiA+ID4gPiA+IGNsb2NraW5nDQo+ID4gPiA+
ID4gY29udHJvbA0KPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiArbWFpbnRhaW5lcnM6DQo+ID4gPiA+
ID4gKyAgLSBFZHdhcmQtSlcgWWFuZyA8ZWR3YXJkLWp3LnlhbmdAbWVkaWF0ZWsuY29tPg0KPiA+
ID4gPiA+ICsNCj4gPiA+ID4gPiArZGVzY3JpcHRpb246IHwNCj4gPiA+ID4gPiArICBGcmVxdWVu
Y3kgaG9wcGluZyBjb250cm9sIChGSENUTCkgaXMgYSBwaWVjZSBvZiBoYXJkd2FyZQ0KPiA+ID4g
PiA+IHRoYXQNCj4gPiA+ID4gPiBjb250cm9sDQo+ID4gPiA+ID4gKyAgc29tZSBQTExzIHRvIGFk
b3B0ICJob3BwaW5nIiBtZWNoYW5pc20gdG8gYWRqdXN0IHRoZWlyDQo+ID4gPiA+ID4gZnJlcXVl
bmN5Lg0KPiA+ID4gPiA+ICsgIFNwcmVhZCBzcGVjdHJ1bSBjbG9ja2luZyAoU1NDKSBpcyBhbm90
aGVyIGZ1bmN0aW9uDQo+ID4gPiA+ID4gcHJvdmlkZWQgYnkNCj4gPiA+ID4gPiB0aGlzIGhhcmR3
YXJlLg0KPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiArcHJvcGVydGllczoNCj4gPiA+ID4gPiArICBj
b21wYXRpYmxlOg0KPiA+ID4gPiA+ICsgICAgY29uc3Q6IG1lZGlhdGVrLG10ODE4Ni1maGN0bA0K
PiA+ID4gPiA+ICsNCj4gPiA+ID4gPiArICByZWc6DQo+ID4gPiA+ID4gKyAgICBtYXhJdGVtczog
MQ0KPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiArICBjbG9ja3M6DQo+ID4gPiA+ID4gKyAgICBkZXNj
cmlwdGlvbjogUGhhbmRsZXMgb2YgdGhlIFBMTCB3aXRoIEZIQ1RMIGhhcmR3YXJlDQo+ID4gPiA+
ID4gY2FwYWJpbGl0eS4NCj4gPiA+ID4gPiArICAgIG1pbkl0ZW1zOiAxDQo+ID4gPiA+ID4gKyAg
ICBtYXhJdGVtczogMzANCj4gPiA+ID4gPiArDQo+ID4gPiA+ID4gKyAgbWVkaWF0ZWssaG9wcGlu
Zy1zc2MtcGVyY2VudDoNCj4gPiA+ID4gPiArICAgIGRlc2NyaXB0aW9uOiBUaGUgcGVyY2VudGFn
ZSBvZiBzcHJlYWQgc3BlY3RydW0gY2xvY2tpbmcNCj4gPiA+ID4gPiBmb3INCj4gPiA+ID4gPiBv
bmUgUExMLg0KPiA+ID4gPiA+ICsgICAgbWluSXRlbXM6IDENCj4gPiA+ID4gPiArICAgIG1heEl0
ZW1zOiAzMA0KPiA+ID4gPiA+ICsgICAgaXRlbXM6DQo+ID4gPiA+ID4gKyAgICAgIGRlZmF1bHQ6
IDANCj4gPiA+ID4gPiArICAgICAgbWluaW11bTogMA0KPiA+ID4gPiA+ICsgICAgICBtYXhpbXVt
OiA4DQo+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ICtyZXF1aXJlZDoNCj4gPiA+ID4gPiArICAtIGNv
bXBhdGlibGUNCj4gPiA+ID4gPiArICAtIHJlZw0KPiA+ID4gPiA+ICsgIC0gY2xvY2tzDQo+ID4g
PiA+ID4gKw0KPiA+ID4gPiA+ICthZGRpdGlvbmFsUHJvcGVydGllczogZmFsc2UNCj4gPiA+ID4g
PiArDQo+ID4gPiA+ID4gK2V4YW1wbGVzOg0KPiA+ID4gPiA+ICsgIC0gfA0KPiA+ID4gPiA+ICsg
ICAgI2luY2x1ZGUgPGR0LWJpbmRpbmdzL2Nsb2NrL210ODE4Ni1jbGsuaD4NCj4gPiA+ID4gPiAr
ICAgIGZoY3RsOiBmaGN0bEAxMDAwY2UwMCB7DQo+ID4gPiA+ID4gKyAgICAgICAgY29tcGF0aWJs
ZSA9ICJtZWRpYXRlayxtdDgxODYtZmhjdGwiOw0KPiA+ID4gPiA+ICsgICAgICAgIHJlZyA9IDww
eDEwMDBjMDAwIDB4ZTAwPjsNCj4gPiA+ID4gPiArICAgICAgICBjbG9ja3MgPSA8JmFwbWl4ZWRz
eXMgQ0xLX0FQTUlYRURfTVNEQ1BMTD47DQo+ID4gPiA+ID4gKyAgICAgICAgbWVkaWF0ZWssaG9w
cGluZy1zc2MtcGVyY2VudCA9IDwzPjsNCj4gPiA+ID4gPiArICAgIH07DQo+ID4gPiA+IA0KPiA+
ID4gPiANCj4gPiA+ID4gLi4uLiBhIG1vcmUgcmVhbGlzdGljIGV4YW1wbGU6DQo+ID4gPiANCj4g
PiA+IE9uZSBvciAyIGNlbGxzIGlzIHJlYWxseSBvdXRzaWRlIHRoZSBzY29wZSBvZiB0aGUgYmlu
ZGluZyBhcw0KPiA+ID4gZWl0aGVyDQo+ID4gPiBpcw0KPiA+ID4gdmFsaWQuIElmIHRoZSBwYXJl
bnQgYnVzIG9ubHkgaGFzIDMyLWJpdHMgb2YgYWRkcmVzcyBzcGFjZSwNCj4gPiA+IHRoZXJlJ3MN
Cj4gPiA+IGxpdHRsZSByZWFzb24gdG8gdXNlIDIgY2VsbHMuDQo+ID4gPiANCj4gPiANCj4gPiBI
aSBSb2IsDQo+ID4gDQo+ID4gVGhhbmtzIGZvciB0aGUgZXhwbGFuYXRpb24uDQo+ID4gDQo+ID4g
VGhlbiBJIHdpbGwga2VlcCB0aGlzIGV4YW1wbGUgdGhlIHNhbWUgaW4gdGhlIG5leHQgdmVyc2lv
bi4NCj4gDQo+IFRoYXQgd2FzIGp1c3QgdG8gaGF2ZSBpdCAxOjEgd2l0aCBob3cgaXQnbGwgYmUg
d3JpdHRlbiBpbiB0aGUNCj4gZGV2aWNldHJlZS4uLi4NCj4gLi4uLmluIGFueSBjYXNlLCBKb2hu
c29uLCB0aGVyZSdzIGEgZGlzY3JlcGFuY3kgaW4gdGhlIGlvc3BhY2U6DQo+IDEwMDBjZTAwIHZz
IDBjMTAwMGMwMDAgLSB0aGF0IGhhcyB0byBiZSBmaXhlZCBhbnl3YXkuDQo+IA0KPiBDaGVlcnMs
DQo+IEFuZ2Vsbw0KDQpIaSBBbmdlbG8sDQoNClRoYW5rIHlvdSBmb3IgcmVtaW5kaW5nIG1lLg0K
SSBkaWRuJ3Qgbm90aWNlIHRoZSBpb3NwYWNlIHR5cG8gaW4gdGhlIGV4YW1wbGUuDQoNCkkgd2ls
bCBmaXggaXQgaW4gdGhlIG5leHQgdmVyc2lvbi4NCg0KQlJzLA0KSm9obnNvbiBXYW5nDQo+IA0K
PiA+IA0KPiA+IEJScywNCj4gPiBKb2huc29uIFdhbmcNCj4gPiA+ID4gDQo+ID4gPiA+ICAgICAg
I2luY2x1ZGUgPGR0LWJpbmRpbmdzL2Nsb2NrL210ODE4Ni1jbGsuaD4NCj4gPiA+ID4gDQo+ID4g
PiA+ICAgICAgc29jIHsNCj4gPiA+ID4gICAgICAgICAgI2FkZHJlc3MtY2VsbHMgPSA8Mj47DQo+
ID4gPiA+ICAgICAgICAgICNzaXplLWNlbGxzID0gPDI+Ow0KPiA+ID4gPiANCj4gPiA+ID4gICAg
ICAgICAgZmhjdGw6IGZoY3RsQDEwMDBjZTAwIHsNCj4gPiA+ID4gICAgICAgICAgICAgIGNvbXBh
dGlibGUgPSAibWVkaWF0ZWssbXQ4MTg2LWZoY3RsIjsNCj4gPiA+ID4gICAgICAgICAgICAgIHJl
ZyA9IDwwIDB4MTAwMGMwMDAgMCAweGUwMD47DQo+ID4gPiA+ICAgICAgICAgICAgICBjbG9ja3Mg
PSA8JmFwbWl4ZWRzeXMgQ0xLX0FQTUlYRURfTVNEQ1BMTD47DQo+ID4gPiA+ICAgICAgICAgICAg
ICBtZWRpYXRlayxob3BwaW5nLXNzYy1wZXJjZW50ID0gPDM+Ow0KPiA+ID4gPiAgICAgICAgICB9
Ow0KPiA+ID4gPiAgICAgIH07DQo+ID4gPiA+IA0KPiA+ID4gPiBBZnRlciB3aGljaC4uLg0KPiA+
ID4gPiANCj4gPiA+ID4gUmV2aWV3ZWQtYnk6IEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vIDwN
Cj4gPiA+ID4gYW5nZWxvZ2lvYWNjaGluby5kZWxyZWdub0Bjb2xsYWJvcmEuY29tPg0KPiA+ID4g
PiANCj4gDQo+IA0K
