Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 000EC64A43B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 16:35:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232032AbiLLPfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 10:35:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiLLPfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 10:35:02 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E44764F;
        Mon, 12 Dec 2022 07:34:56 -0800 (PST)
X-UUID: fdf63a8b674145e7b79f8fa8d30a0151-20221212
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=G86F2MMuhDJuV0dd3OQk7rMZqIajNxDwg6CSfmnA4i0=;
        b=jIEtCYPtdyjd1ZeHURL6nbjjCCUQUpdgCOxDwLpqneDSEtbuvUwAmfUioy6M4xIB5Qul8mlHkX4f/JQ9jC/Dn3nxS6Se5JbnAEzRwm3cb9fpd1iT91uy98QQ2OqFHfJ4KXKri1FEuLq+/lcirLveqJfyqMeq/QwmbZ4KYgbj72c=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:9ef52fb4-8e7d-4ae7-8301-2596216b7dd7,IP:0,U
        RL:0,TC:0,Content:2,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:2
X-CID-META: VersionHash:dcaaed0,CLOUDID:d1fb60d2-652d-43fd-a13a-a5dd3c69a43d,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:4,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: fdf63a8b674145e7b79f8fa8d30a0151-20221212
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1298250604; Mon, 12 Dec 2022 23:34:49 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Mon, 12 Dec 2022 23:34:48 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Mon, 12 Dec 2022 23:34:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mCoTZ/ED1vSZz+omqziAOjT1jBuHoPSIFS4V8PLx4BWPv5zE5KNvcqVJoGKawqWBDQq1rj7TpO8e4wph8feA327hhoY3yyJ+oXrt98uls90chdhBl3q7IdEeNmlAkRvAl3hacFIZdPwS/eRutQw2vRlc1kbak+R6CQV32990I+kCIzL9JAkfeYZMnqUGJHYmH46rIS+lDcSnUQxk7xmTFpMb+hts8mLQEWDPFc7tc0//E46S/Wk11dXVH2/mZ7xNnqF18/QgWO4Gj/gV4w2/LTZitJhrw93RsL2w4tk6gHZtyd5ghzK5Ftv5yRy9Dlje+ExNyP2cmLPYOVrq1lJsZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G86F2MMuhDJuV0dd3OQk7rMZqIajNxDwg6CSfmnA4i0=;
 b=dBzCxa1XDNHM7ddjqIac1DIOsrlAJJIHhqgmBtSz6AXVzz9+t4TsPsXX+P946YkKXlp6FnBo4xZHCvlvZv55rGHb8jKnSx3FSeIV8OEFWGNhs7oxKyKLwHqGl2O9TBYhv8S5Kpvn5rw0Mv6YG7HTCsg0Mz238Ps0yJuyjowHd1pnzFE0rjozaC6v8WTAKNDOvadKbtQt2BH6FYqEw6DhFogfDaxLE1hkMNoonlVeg36lJeTuPkt3PVKsTI6xCxN9LpzmxbpVTILrHTeJ03DTxJPr4m8Ctafdi8MXAedISD4FDdjl/2q320A9r8xgZVs/YNOVvVMG4QK2IPo9O8trfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G86F2MMuhDJuV0dd3OQk7rMZqIajNxDwg6CSfmnA4i0=;
 b=mz9QOm5vFedq7YNU4ixhjWvLhaEToJetCj1DMnTpOC4D8u82Vd+7Al7iqn0bYkaa01RKoO1v3Ac5PgIbiAnW9NxhjvBivqj6qj/9pLXkEQfY4NRGJkOkOoVLBvwFN4a8mUbcNb938OfTWVhcXyiHWE11kUIAxrxZqY9ov9uHvW8=
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com (2603:1096:4:1e9::14)
 by SEYPR03MB7023.apcprd03.prod.outlook.com (2603:1096:101:d0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Mon, 12 Dec
 2022 15:34:45 +0000
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::789f:a595:931d:b4dc]) by SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::789f:a595:931d:b4dc%7]) with mapi id 15.20.5880.019; Mon, 12 Dec 2022
 15:34:45 +0000
From:   =?utf-8?B?VHJldm9yIFd1ICjlkLPmlofoia8p?= <Trevor.Wu@mediatek.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 12/12] dt-bindings: mediatek: mt8188: add mt8188-mt6359
 document
Thread-Topic: [PATCH v3 12/12] dt-bindings: mediatek: mt8188: add
 mt8188-mt6359 document
Thread-Index: AQHZCrW7BVlvtev2eU+SJbgHaiWs365lWdGAgAUPRIA=
Date:   Mon, 12 Dec 2022 15:34:45 +0000
Message-ID: <aeb2bbac8ad5ede2396408a20ff8c8942029451a.camel@mediatek.com>
References: <20221208033148.21866-1-trevor.wu@mediatek.com>
         <20221208033148.21866-13-trevor.wu@mediatek.com>
         <6350def8-bb1f-8aeb-4c98-4d02a4c59aed@linaro.org>
In-Reply-To: <6350def8-bb1f-8aeb-4c98-4d02a4c59aed@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB6686:EE_|SEYPR03MB7023:EE_
x-ms-office365-filtering-correlation-id: d1d9ec86-f909-4c47-c1e3-08dadc566588
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6Ei8cJKKGpfCpKG1ZwIMfF9tah6qrgjf/BVhHsFW5tW51ga4x51YsqgmSKm+Nez9/3QQJoXfAf9Q7gvnBetFvZ0VyUYGNwpYUEMqv2CODZnuZMvb+5b6Fz/ThynogyW6fyxRCIs+ltLK3QP508TvjJaMz8Ppde8AadLGc/wRGeqM4SGxvYdjP8JzcxPAQUbirmtlKFxvDl9MVbl/CEu1wtAufKG2ZrhWLBJ8CTyynSnq3GqYJxlbH/5q3IIdTd6MUlqFnIX52k1G77vNHTs17yqxXTMwtI2wDUPbMdpl8gLEsldH14GmHZy3Uyvetp+AdeZQP+/6xnqEroHJy6H5y/QysRt1DFFl7l/6mF3CsT4tVkTWY7gZCe8boOnce4n+aWYdm1VR7xSmzr+B4RJ6ECoyDX3xsGypetMJyiipo1HcCMsuWtQgzBlWyKzlctvJykY472mBVlOMRg4s+ZlttTY8wLOA8YgCMi0Z9saS8tTJAavDL+kY7vhfGvjaRct40gwAO4KUHK5xHmVF+DGANRW3MmewQWV+ftaKVEztjwadiAFy/ZO8NGrX006/n00nBfa6pGInz0KWBWNmIjXGjcj/sVtyrW+ddr6pC0S+GSxnTbEbtGUn2R//qDcV6MinZCq1vS+THcg8vYA4dtHnV4mSDW7QYaH12BwDy+Vn6L4cB9ve1ozC0+ND8F4raYiB2DmzvNGc2YSOU/8RQ1CCKh88gkgdG1IKy2nLzgEqPVObXRWXaaYQ9hwzOCQGwoFdH/piV8JRCbraiLE9/qq2S48ivvRow+UTGba3qhwUsCM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB6686.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(136003)(376002)(346002)(366004)(451199015)(36756003)(66476007)(85182001)(4326008)(38070700005)(66946007)(122000001)(76116006)(2906002)(66446008)(110136005)(66556008)(38100700002)(54906003)(316002)(8676002)(64756008)(86362001)(26005)(53546011)(6506007)(186003)(7416002)(8936002)(5660300002)(41300700001)(478600001)(71200400001)(966005)(6486002)(2616005)(6512007)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OE54ODVLUy9jREJhY2cwZ2F6eFlGd2xjMlk3SCtQUlVKMGFMT2U1bmorQkdw?=
 =?utf-8?B?RWp1TXNwQzRjR2kveXFGWXhibUtoN282dHY2OHlvTXp5QVhJUDhqZ292SDZW?=
 =?utf-8?B?Q0xmQndDQ2dTMk1leWNreE95bmxIRDFSN2R1b3YzYUEvR1lXcWdPUVUraEFt?=
 =?utf-8?B?cUNKb2c3aFE4bURpcWI2RmxFeSs2OWU0bzlsYTZQcVFyNXBRNEZCOU1zbGU3?=
 =?utf-8?B?SVB4Z3pyYm5Ec2lhL0dFZEZ4aUtoNEIwUitGSjZXQk5rTnBBa05UUzU5bk1L?=
 =?utf-8?B?VlQwSCsvNGQrdldObTdPcjdiTldxSnJ2Lzk0QXJBMjIzd1BOQnF0bGc2dFBU?=
 =?utf-8?B?R0JDUGRzNUdER3RBYW9qM080eHd1UDJSdC80M0gxNjk1eUE5RUtScmE0MUta?=
 =?utf-8?B?N1JRMGZDdE4yY05KMVdBWWMxNWFXMyt0alMxQjhoUXlQWW9LcWRyYzRHRTVW?=
 =?utf-8?B?WWxlN01VaGtSbmR2MW5vVEtnOGxIbnhjU2hZTys2a2l4OGNhd0xNYThFYmx2?=
 =?utf-8?B?SUsvL0hxcEVXOXdFSC94Y2FaSG9qTngrS1pLd2pqcm1aQlRaVnI1clpVUUNB?=
 =?utf-8?B?bUFoeU9tb3c5UkZ5L3FJZXovUGhWMjhrMlY4S3dEa3E1bE5sb2ZxcVI4VWp1?=
 =?utf-8?B?VWVHQnpkOFJpK3NWSi9WVzYxdXZZOEtpNlk2Y1M4ZGxxMXpISkN6V01UN055?=
 =?utf-8?B?SUs3R2lMR2JYWnZOMmUvaU9OZGRFL3hDdkM2MFJZazlYdlZleWgzaS9WbDRs?=
 =?utf-8?B?LzlPR1E1eW5uQklhejJxeGFzelVLSHRyUTRVY0dxRXVtNEhIeVJOd096TklT?=
 =?utf-8?B?K05JUVNvT3NNdWE3VGFKTXRJSC9hT0l0dk9kakxzcjZlODRwaFg5by9palRj?=
 =?utf-8?B?d0dyb0NmTE41ZUpuVWp0TlNuVHpKbTdhdzE0TkhvYWF1LzZXQk00TGFBM2Y3?=
 =?utf-8?B?SkRQeTl1SkpjTEg0bCthTCt0L3JPWGJIZElSNXZ0cmVwaTlnM3ZMT3lQT3FM?=
 =?utf-8?B?MmVpKzZRVXNmZU5IeWZUWm51d1JaYzFoSjFsVk1nQmprK21taXl1b0J5RnRG?=
 =?utf-8?B?dWVkZkFBN280YncvTndJOGphdEprcjQ0QWxSYVlXRjY0TXhuMnIzSzRGeW1h?=
 =?utf-8?B?SDZvRnU2cDVtc2t3d3FyanRzakp5RDZtM0ZDb2RnR3JPYmI3VmI5TWM1N3lN?=
 =?utf-8?B?MGlQcGVUUDBDdVlGOU9VOGNoWXNNdFlTL0MwMHBDT244V1ZrcTREdTVJUlZH?=
 =?utf-8?B?M0pVbjJiU1pzTDltUGZxNnhtMjgxY3N2dXhra25aeUppSGIyUkpNTm43RUFK?=
 =?utf-8?B?eVdDd3VVUHpTZVFlZmVvSGVBTWJ2TlJKbDR6SFRwdzJwY0NKUUZQMmEwNWJ1?=
 =?utf-8?B?eXFjUTIvTWt2TTJtMlVGb25RcnFGR2N1T1dnc2lVWEZ0Q0pXZEVlS09vQ2xM?=
 =?utf-8?B?a1oybm5wcFB3Q1FuNnVtQkhIb216WExxeXFGM0JHaVdpR2FiZGZUTmdsSmQ1?=
 =?utf-8?B?Yi9SRTczcWM2cEcyVXVMRGxSaTJBUk96K0lBeWJ6bTc0VWxvK204eTM5VWJk?=
 =?utf-8?B?K2N0c1VRZStDSEFZVDB0YUFVZ0Y5aUVQa2YzWmc5d3Mrc0lZbzZqb2pJbUpU?=
 =?utf-8?B?VVJibURseXdqVWFQWXFrZVNBWFBPVkErOXgvUDIvQnRwYXJSaVIvNHE0WFkz?=
 =?utf-8?B?OXhKOHZRUi9TZnYxeHVSOE9oc3RBSEpPTFA2bS8zaVdrcllXMEREUWo4Nk9u?=
 =?utf-8?B?dlJneDJjL0RxZW9hbWNQWGw4d1B3QWdZRkdaaW5HelVmeVVPc1cybzZzaVVC?=
 =?utf-8?B?d1h5TXVENHJHUmtCTTNFL2JzSG9QMTZZZWJzcm9IRG1nQlh0OTZ5aEdJanZn?=
 =?utf-8?B?L2hrVGZ5WlE0dFJsYlhjVG9oUjVBY0N6TEtkUFhsZndSRStvN08xQVdHZzRW?=
 =?utf-8?B?TGNZbnJFaFUvM2ZmRDJzV1lXbTNvOUNBZXByditVOGFVV3pwN3MzYWN3ZVVp?=
 =?utf-8?B?WU13T0FRT0xUeVMyZk1NWG5LVER1Y01BQzhNb1MxM3V5V25zZWxVNU50SVNw?=
 =?utf-8?B?WGI0VkxnUFVGN2N5UkJRYVU2L2EwSGVoVExBNDByaFZuTDBqL2pLYlM3ZU5k?=
 =?utf-8?B?Q2RXTWpmTWU4UHRVOFllbG9Na05paHQvSHhsYlVyZ2o0WTJ4aXpoR3IyVjlX?=
 =?utf-8?B?Mmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <45DF87A4376A164B9025E99E0EDC1819@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB6686.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1d9ec86-f909-4c47-c1e3-08dadc566588
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2022 15:34:45.4481
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mDLv2Y5yoUq2oNYbuZpSY7mktXKCcDRKC1RWxnBrw4mat6dZsd8DhpYbYWy0s4d7mbsqfesciZKt9dghSoBPLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7023
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

T24gRnJpLCAyMDIyLTEyLTA5IGF0IDExOjE4ICswMTAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiBPbiAwOC8xMi8yMDIyIDA0OjMxLCBUcmV2b3IgV3Ugd3JvdGU6DQo+ID4gQWRkIGRv
Y3VtZW50IGZvciBtdDgxODggYm9hcmQgd2l0aCBtdDYzNTkuDQo+ID4gDQo+ID4gU2lnbmVkLW9m
Zi1ieTogVHJldm9yIFd1IDx0cmV2b3Iud3VAbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICAu
Li4vYmluZGluZ3Mvc291bmQvbXQ4MTg4LW10NjM1OS55YW1sICAgICAgICAgfCA2MA0KPiA+ICsr
KysrKysrKysrKysrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDYwIGluc2VydGlvbnMoKykN
Cj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9zb3VuZC9tdDgxODgtDQo+ID4gbXQ2MzU5LnlhbWwNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvdW5kL210ODE4OC0NCj4gPiBtdDYz
NTkueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb3VuZC9tdDgxODgt
DQo+ID4gbXQ2MzU5LnlhbWwNCj4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiA+IGluZGV4IDAw
MDAwMDAwMDAwMC4uZWFjMWM4N2I2OTNhDQo+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ICsrKyBiL0Rv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb3VuZC9tdDgxODgtbXQ2MzU5LnlhbWwN
Cj4gDQo+IE1pc3NpbmcgdmVuZG9yIHByZWZpeC4gWW91IGdvdCBjb21tZW50cyBmb3IgaXQgYWxy
ZWFkeS4NCkhpIEtyenlzenRvZiwNCg0KSSB3aWxsIGNvcnJlY3QgaXQgaW4gVjQuDQoNCj4gDQo+
ID4gQEAgLTAsMCArMSw2MCBAQA0KPiA+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiAoR1BM
LTIuMC1vbmx5IE9SIEJTRC0yLUNsYXVzZSkNCj4gPiArJVlBTUwgMS4yDQo+ID4gKy0tLQ0KPiA+
ICskaWQ6IA0KPiA+IGh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwOi8vZGV2aWNldHJl
ZS5vcmcvc2NoZW1hcy9zb3VuZC9tdDgxODgtbXQ2MzU5LnlhbWwqX187SXchIUNUUk5LQTl3TWcw
QVJidyFud19PekJJUmxYckVQNktfRXR4RVdBSVp6dXZuRDNEbV9LRHV2OGdwTFJxbG5uU2ZWTGtz
TmZLcU1tZVlpRmxFVlZ5NkYyQlh3bVhCOG9Ra0RQZUJ1RVhNdGZMWDJ3JMKgDQo+ID4gIA0KPiA+
ICskc2NoZW1hOiANCj4gPiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cDovL2Rldmlj
ZXRyZWUub3JnL21ldGEtc2NoZW1hcy9jb3JlLnlhbWwqX187SXchIUNUUk5LQTl3TWcwQVJidyFu
d19PekJJUmxYckVQNktfRXR4RVdBSVp6dXZuRDNEbV9LRHV2OGdwTFJxbG5uU2ZWTGtzTmZLcU1t
ZVlpRmxFVlZ5NkYyQlh3bVhCOG9Ra0RQZUJ1RVhvZEZvQ0pBJMKgDQo+ID4gIA0KPiA+ICsNCj4g
PiArdGl0bGU6IE1lZGlhVGVrIE1UODE4OCBBU29DIHNvdW5kIGNhcmQNCj4gPiArDQo+ID4gK21h
aW50YWluZXJzOg0KPiA+ICsgIC0gVHJldm9yIFd1IDx0cmV2b3Iud3VAbWVkaWF0ZWsuY29tPg0K
PiA+ICsNCj4gPiArcHJvcGVydGllczoNCj4gPiArICBjb21wYXRpYmxlOg0KPiA+ICsgICAgY29u
c3Q6IG1lZGlhdGVrLG10ODE4OC1tdDYzNTktZXZiDQo+ID4gKw0KPiA+ICsgIG1vZGVsOg0KPiA+
ICsgICAgJHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvc3RyaW5nDQo+ID4g
KyAgICBkZXNjcmlwdGlvbjogVXNlciBzcGVjaWZpZWQgYXVkaW8gc291bmQgY2FyZCBuYW1lDQo+
ID4gKw0KPiA+ICsgIGF1ZGlvLXJvdXRpbmc6DQo+ID4gKyAgICAkcmVmOiAvc2NoZW1hcy90eXBl
cy55YW1sIy9kZWZpbml0aW9ucy9ub24tdW5pcXVlLXN0cmluZy1hcnJheQ0KPiA+ICsgICAgZGVz
Y3JpcHRpb246DQo+ID4gKyAgICAgIEEgbGlzdCBvZiB0aGUgY29ubmVjdGlvbnMgYmV0d2VlbiBh
dWRpbyBjb21wb25lbnRzLiBFYWNoDQo+ID4gZW50cnkgaXMgYQ0KPiA+ICsgICAgICBzaW5rL3Nv
dXJjZSBwYWlyIG9mIHN0cmluZ3MuIFZhbGlkIG5hbWVzIGNvdWxkIGJlIHRoZSBpbnB1dA0KPiA+
IG9yIG91dHB1dA0KPiA+ICsgICAgICB3aWRnZXRzIG9mIGF1ZGlvIGNvbXBvbmVudHMsIHBvd2Vy
IHN1cHBsaWVzLCBNaWNCaWFzIG9mDQo+ID4gY29kZWMgYW5kIHRoZQ0KPiA+ICsgICAgICBzb2Z0
d2FyZSBzd2l0Y2guDQo+ID4gKw0KPiA+ICsgIG1lZGlhdGVrLHBsYXRmb3JtOg0KPiA+ICsgICAg
JHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvcGhhbmRsZQ0KPiA+ICsgICAg
ZGVzY3JpcHRpb246IFRoZSBwaGFuZGxlIG9mIE1UODE4OCBBU29DIHBsYXRmb3JtLg0KPiA+ICsN
Cj4gPiArICBtZWRpYXRlayxkcHR4LWNvZGVjOg0KPiA+ICsgICAgJHJlZjogL3NjaGVtYXMvdHlw
ZXMueWFtbCMvZGVmaW5pdGlvbnMvcGhhbmRsZQ0KPiA+ICsgICAgZGVzY3JpcHRpb246IFRoZSBw
aGFuZGxlIG9mIE1UODE4OCBEaXNwbGF5IFBvcnQgVHggY29kZWMgbm9kZS4NCj4gPiArDQo+ID4g
KyAgbWVkaWF0ZWssaGRtaS1jb2RlYzoNCj4gPiArICAgICRyZWY6IC9zY2hlbWFzL3R5cGVzLnlh
bWwjL2RlZmluaXRpb25zL3BoYW5kbGUNCj4gPiArICAgIGRlc2NyaXB0aW9uOiBUaGUgcGhhbmRs
ZSBvZiBNVDgxODggSERNSSBjb2RlYyBub2RlLg0KPiANCj4gV2h5IHlvdSBkbyBub3QgdXNlIERB
SSBsaW5rcyBmb3IgYWxsIHRoZXNlPw0KDQpBcmUgdGhlIGZvbGxvd2luZyBleGFtcGxlcyAiREFJ
IGxpbmtzIiB5b3UgbWVhbj8NCg0KaGRtaS1kYWktbGluayB7DQogICAgICAgICAgICBsaW5rLW5h
bWUgPSAiSERNSSBQbGF5YmFjayI7DQogICAgICAgICAgICBjcHUgew0KICAgICAgICAgICAgICAg
IHNvdW5kLWRhaSA9IDwmcTZhZmVkYWkgVEVSVElBUllfTUkyU19SWD47DQogICAgICAgICAgICB9
Ow0KDQogICAgICAgICAgICBwbGF0Zm9ybSB7DQogICAgICAgICAgICAgICAgc291bmQtZGFpID0g
PCZxNnJvdXRpbmc+Ow0KICAgICAgICAgICAgfTsNCg0KICAgICAgICAgICAgY29kZWMgew0KICAg
ICAgICAgICAgICAgIHNvdW5kLWRhaSA9IDwmbHQ5NjExX2NvZGVjIDA+Ow0KICAgICAgICAgICAg
fTsNCiAgICAgICAgfTsNCg0Kb3INCg0KaGVhZHNldC1jb2RlYyB7DQoJCXNvdW5kLWRhaSA9IDwm
cnQ1Njgycz47DQp9Ow0KDQoNCkFzIGZhciBhcyBJIGtub3csIG9ubHkgIm1lZGlhdGVrLHBsYXRm
b3JtIiB3YXMgdXNlZCBhdCB0aGUgYmVnaW5uaW5nLg0KTmV4dCwgaGRtaS1jb2RlYyB3YXMgaW50
cm9kdWNlZCwgYW5kIGl0IGZvbGxvd2VkIHRoZSBzYW1lIHN0eWxlIHRvIGdldA0KcGhhbmRsZS4g
RmluYWxseSwgaXQgYmVjYW1lIHRocmVlIHByb3BlcnRpZXMgaW4gbXQ4MTk1LCBhbmQgdGhlDQpp
bXBsZW1lbnRhdGlvbiBvZiBtdDgxODggd2FzIGluaGVyaXRlZCBmcm9tIG10ODE5NS4NCg0KSSBq
dXN0IGdsYW5jZWQgb3ZlciB0aGUgdXNhZ2Ugb2YgZGFpIGxpbmtzLg0KQXMgSSBzZWUgaXQsIEkg
d2lsbCByZXBsYWNlIHRoZSBjb2RlYyBwYXJ0cyB3aXRoIGRhaSBsaW5rIHN0cnVjdHVyZQ0KbGlr
ZSB0aGUgZXhhbXBsZSBhYm92ZSBmaXJzdC4gSXQgc2VlbXMgdG8gYmUgZWFzaWVyIHRvIGV4dGVu
ZCBtb3JlDQpjb2RlY3Mgd2l0aCB0aGUgc2FtZSB0eWxlLg0KDQpGb3IgcGxhdGZvcm0gcGFydCwg
SSBuZWVkIG1vcmUgdGltZSB0byBjaGVjayBpZiBpdCBpcyBiZXR0ZXIgdG8ga2VlcA0KdGhlIG9y
aWdpbmFsIGltcGxlbWVudGF0aW9uLCBiZWNhdXNlIHdlIHN0aWxsIGhhdmUgdG8gdGFrZSBTT0Yg
cmVsYXRlZCANCmltcGxlbWVudGF0aW9uIGludG8gY29uc2lkZXJhdGlvbi4NCg0KDQo+IA0KPiA+
ICsNCj4gPiArYWRkaXRpb25hbFByb3BlcnRpZXM6IGZhbHNlDQo+ID4gKw0KPiA+ICtyZXF1aXJl
ZDoNCj4gPiArICAtIGNvbXBhdGlibGUNCj4gPiArICAtIG1lZGlhdGVrLHBsYXRmb3JtDQo+ID4g
Kw0KPiA+ICtleGFtcGxlczoNCj4gPiArICAtIHwNCj4gPiArDQo+IA0KPiBEcm9wIGJsYW5rIGxp
bmUuDQo+IA0KT0ssIEkgd2lsbCBmaXggaXQgaW4gVjQuDQoNCj4gPiArICAgIHNvdW5kOiBtdDgx
ODgtc291bmQgew0KPiANCj4gRHJvcCBsYWJlbCwgbm90IHVzZWQuIFVzZSBnZW5lcmljIG5vZGUg
bmFtZXMsIHNvIGp1c3QgInNvdW5kIi4NCj4gDQpPSywgSSB3aWxsIGZpeCBpdCBpbiBWNC4NCg0K
VGhhbmtzLA0KVHJldm9yDQoNCj4gPiArICAgICAgICBjb21wYXRpYmxlID0gIm1lZGlhdGVrLG10
ODE4OC1tdDYzNTktZXZiIjsNCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQo+IA0K
