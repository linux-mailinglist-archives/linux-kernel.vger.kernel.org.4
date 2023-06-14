Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6D4872F488
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 08:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243069AbjFNGOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 02:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234074AbjFNGO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 02:14:26 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE2301BC9;
        Tue, 13 Jun 2023 23:14:19 -0700 (PDT)
X-UUID: b03c92fc0a7a11ee9cb5633481061a41-20230614
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=QoxgQJy2YI9Q5mHiyfKCNyLFfGdjQLCSYGLDFIxxUPU=;
        b=uqmM5CAV8drufTdmhNss3emOO0GIOhbEHMfjlcdELXUYaB0lA2H3ik/nKlw5j4ZnmavqiFu1HTYNRV/y5cCrJ8lFCCjM2p0lP2tl2qxq7moX55W+4NGLL2AGIyrRGWvEou1Arqwtn5KZXDDrcZv3YNlVxjS1CJVZ7SPgCQWknuc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.26,REQID:98c80fbe-b856-45ca-b60b-c445fc814042,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:cb9a4e1,CLOUDID:3cb75f3e-de1e-4348-bc35-c96f92f1dcbb,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: b03c92fc0a7a11ee9cb5633481061a41-20230614
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1351022644; Wed, 14 Jun 2023 14:14:15 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 14 Jun 2023 14:14:14 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 14 Jun 2023 14:14:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L08ZLwzUR1Grb+1akbxQzreUk2CZFxVapYFJfAmOApedPGgGX5HL+OCvKy1YR1tTQsXjei7HyHhOcDLV1xy+9yxhKd3VvQpwbFnQNkaq+6uE3IrK7kxlRcqGLQOSlcYfoFRhcx9jlYDIWfIgtnxujc5UJYsic+HXALgrihhyJKLY1ivCp2vEVBc66hlM6WRX1HRkRM5OKEkdDQBpJXP7Rob3ms3nLGwuid9EABQXjkL/twpBkqBCk2Nu2M5bUmri3fsfUWlI2rTRhHrSPGylwDzcWkdM4R6FqHIsMnyxlTNl7lpUG/jYt2qdI/wp5aIYK1B7Qd7D778xeBqkzfnOmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QoxgQJy2YI9Q5mHiyfKCNyLFfGdjQLCSYGLDFIxxUPU=;
 b=AwwBtPobVBrwO9r3qwSjmxllUfw87l5wb90AYi3lvys8VGE0qorQfOdJ6awEnxTW6UKBGK7Updn4AunELIKFN+VhIRojiRTpixMERFA0wy67CgL3Zl4yUmfgW8K5KosFe4HNeLMtga1cJKcMBVHQNgUqWrpkmCebU8VyXxSdKdQsxSTL3l6UTlrLPNmVl0oUx51ISUpUWg3nTQQOcTNi8u7CEqOUNspNRJ4MfiGQHMHSIajb51hAW6FnoHBRRVcCpNgkAvc5YoxHhipd6U4qona7r9qOtIC1VC0WNEtZATPD0m7CupTtYDvlS86F/aFdtRzVhkdGIT90YP0ihvJCBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QoxgQJy2YI9Q5mHiyfKCNyLFfGdjQLCSYGLDFIxxUPU=;
 b=DvCn9OYJm91y506QZiag+FXQrFNam1hGlB1IW3QQAbrnwdagPNEvb8pSo4SzBtTr7cbTUURTbWSR430JES73YhaI1dU7E0fkYwMtKf33NPn0dWy4r64moXwykQmevTVkAsPOAhp2QHIhBWK376YokeLY/HlNaCeobhH0+0OeE7Q=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by KL1PR03MB6002.apcprd03.prod.outlook.com (2603:1096:820:8f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Wed, 14 Jun
 2023 06:14:11 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::6fdb:ba2c:bcfc:d5ed]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::6fdb:ba2c:bcfc:d5ed%6]) with mapi id 15.20.6455.037; Wed, 14 Jun 2023
 06:14:11 +0000
From:   =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "kishon@ti.com" <kishon@ti.com>,
        =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= 
        <Chunfeng.Yun@mediatek.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        =?utf-8?B?Sml0YW8gU2hpICjnn7PorrDmtpsp?= <jitao.shi@mediatek.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "granquet@baylibre.com" <granquet@baylibre.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?utf-8?B?TWFjIFNoZW4gKOayiOS/iik=?= <Mac.Shen@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        =?utf-8?B?U3R1YXJ0IExlZSAo5p2O57+wKQ==?= <Stuart.Lee@mediatek.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v4 8/8] drm/mediatek: dpi: Add mt8195 hdmi to DPI driver
Thread-Topic: [PATCH v4 8/8] drm/mediatek: dpi: Add mt8195 hdmi to DPI driver
Thread-Index: AQHZkjsyvHwO3emDJUeZVQxBoU19gq+J6mcA
Date:   Wed, 14 Jun 2023 06:14:11 +0000
Message-ID: <c8e937133b7fe112d34ad588ae6df2869ea08c20.camel@mediatek.com>
References: <20220919-v4-0-687f09a06dd9@baylibre.com>
         <20220919-v4-8-687f09a06dd9@baylibre.com>
In-Reply-To: <20220919-v4-8-687f09a06dd9@baylibre.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|KL1PR03MB6002:EE_
x-ms-office365-filtering-correlation-id: 1839e042-2eae-4a81-69a7-08db6c9e9227
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tc6M68oEZSwbmSjfTQOqw10fz0bAUXQ51Au7Tyq/+rGYHoW3cxiqgst4TrPb03p56fWWfDDkNJ68chsUqOW0JOgPX9syW3l5Es/np+Tak0VwS07B6mY3/5QiDlrhuo61iHIK4JVbsnZ7YEKOXM4JhCk/MG9IgU5Ke9uHabkPhk3gGvcxoF9IAWWYnX9JF+HnjuX1DrOAyCEEgnxsyfA79O0p2yuDUojk5k6/HWzy791+8pU5vPUYXeZYstZrKuzpSD1YrO7fjcBM5X+Wb5qj30SPyMDV3D19SXu+3rZeChMiTUpoS2Sw1ZEtsn8/ugnQLBo0cZ5MIUwd5zwwDUlQYYrOizLuuvQVdXp3TFlg/Rx1S3eDW3CXG8ypc0m3zcNpV4XWpHy2RlN9jDzI9XWuX6Hc+kTRlI92IfV82Y8jqcF8rC3hjgpi4Ydd2frw40a6p8yaaB4lRWdzB3X5UqxwelQyFMr8s8g18zEHW1vHyQqE7jfB6FmAodv7ZJvoYS6VSkZar4QmfElPUsdyAJdPJtK3Yv/BB6vDOfYZNghjvv7CozOl7vyS2qXrPlc07M811l1oCL7tWJyRDBUU69pYj1vDAY1WQVinH922bzN4ytF0pWvE6jk6sFXIxFa0yD3J
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(346002)(136003)(39860400002)(376002)(451199021)(85182001)(36756003)(86362001)(2906002)(38070700005)(7416002)(478600001)(5660300002)(186003)(83380400001)(6506007)(26005)(6512007)(122000001)(921005)(71200400001)(6486002)(110136005)(54906003)(66476007)(64756008)(38100700002)(66946007)(76116006)(2616005)(4326008)(66446008)(316002)(8676002)(66556008)(8936002)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QjE3U254bm1GbXFaSFFGditYQkpTaTkwTC94TnJJMVdJRk9TcTg0V3FYZmhC?=
 =?utf-8?B?OUpRL0xua3pzb0Zpb2dXaDFsL0I3NENPUzlmaEpRRDBkcFdDaWZadTM1ZHA3?=
 =?utf-8?B?eHc1bC90YTFiVzQwSUhTMld4RWEzTzVCQVZucFVtajJ1TjBDZ0JoSlVUUDVR?=
 =?utf-8?B?Zmd6SnVKVW9OejRBMXdnQkoyd2VJWGk3cmlJbzhJV2o4WlNJblpJNFRMcmhB?=
 =?utf-8?B?NVBBTXZvYkhaditNSnJNQklwdGV5WVNDNTFYMGk2UUszcnVJOTlaQVJqUitO?=
 =?utf-8?B?MVFpeXZqdXBPVVg2NjVHT3Y3MGZDR1N0aHBhZkIwdUpmQVROZnJUamdGeWJ3?=
 =?utf-8?B?MnI2NnZYcjJZd2NJK2ttT3AvOGNXNDhabEIvbkFsOTk1UmJtOTgxMVh1Vi93?=
 =?utf-8?B?eFUxQjJsNnZuTHRLU01Tb0JJb3hYcDF5bjFnaGxCVnMvMmxxWkFBbmJ6aHFK?=
 =?utf-8?B?Zldjdkd5SWJGaXZkMUlVNHlBcGJ5ME54Q2dYL3pOWHAzdk84cElvMytyQ1NU?=
 =?utf-8?B?OWUwMUxKN3BTYm1wcVJyV01KTWQvWDNRQm5FSWFJWm5vdWZWbHVUelc4NEc2?=
 =?utf-8?B?VW5Jb0ptWktERHlDOHd1UXFkRExKYVMyYlo1SC93anJnM1JrVGZxQVdSeWlE?=
 =?utf-8?B?LzhDYTFUV2I0QVdTNjdidWRaSzF0NjE3YnNLeVNKWG5BS2UrUlJudVpjbFM1?=
 =?utf-8?B?anQrNkc0M2hyMElxeFkxOFd4dDVpeGpGeXJuQWRMMUlaTFljdDZsd05tdkhH?=
 =?utf-8?B?L1NSbTgvNlN0ZXFxeUNzL1JoZlRoWGQxY015TGZGeEN6REFsZ2dmVkdCRnJO?=
 =?utf-8?B?QW5HYkMwTnlpTzB5L2E0N214dDBPODdibndZSHY2aFlRZUl0b25VczIrWjla?=
 =?utf-8?B?aGhiM0ZHelR2UDg2YmZPemY0WGlEZjdKQS9EY1I2N3c5NHBmaGlsM3BBVHh3?=
 =?utf-8?B?enhvWmdscVFHMG5pbTNlUDdLeDRpNEswWTZpU2IvSThBd2E5ZW9HWHc0QVZu?=
 =?utf-8?B?ekVkNVZic1huLzMzbzFIbzIrK0dLdWlsS1dRNFlsV2FnSUhIM3Q3RWY3ZnZL?=
 =?utf-8?B?enZiTXE4RTk2RndmZzlWdWoxTWZNMGlEUHRsL25ERlRSNnBVamxTL0pQbFd5?=
 =?utf-8?B?TlJBVDRmK1JmeWJ0OCtJWU51TFpTNDZVRlFYRzdPZk5MLzJFbzR6SFh4ditM?=
 =?utf-8?B?ZHZRRXVhZ0VXQ2dOcm11a1ZVSEt2VTBTWGpXTExZcUN5YXRBL0VxelRDSUs1?=
 =?utf-8?B?MFAvNHQrVkxpRDh5NkYxVFFCdUJDTFRkZ1ZQbUd5S3p0V2RMSUJ4TVNyWlp3?=
 =?utf-8?B?cS9IVzZSeXA5Wml1eGNpQllXUVg5SXZBVGJYVlFjd1UzdTNOcEdDSXA5R0Fj?=
 =?utf-8?B?TTNpaFFnUnZHWGdWT1R4Y1FDbFJNOFUwTEtvSFZmY3RCWlg3QWcrS2RpNE5a?=
 =?utf-8?B?UEhRRFByUzVzZVdFdlFncHlOcGp1MmdrVlVLemlTdzFhbXcyRldQMkFKWXk0?=
 =?utf-8?B?NFBXSnlJTCtKOVkzOURMN3FNWUZpeThtZkpVS28yUnBGcEZ4cVFLaFhrOVQz?=
 =?utf-8?B?dEVsNzRuaW02Y29pZmtiY3lsejVyWnNENHJkR1F6cS9IK3hEcDd4bVdnWVRI?=
 =?utf-8?B?UE5rTi9xTjNqRzNqM3NQL1R1ZTlHYjBOdjU3Nll3aDFQV1FKbW9jMkZCbFlQ?=
 =?utf-8?B?SzN3anNxQzZjVnNENGVFYmFKS0JzWHFsZ0xmSWJlR29mTDBpK3BFTVozVkEz?=
 =?utf-8?B?M3Y2QU1kcStXMjNoZ0U0aDNKS0ZBQ3hMMzZxMWkwaTJCWklBemZCdFlnbHo3?=
 =?utf-8?B?RlpyeTM4cWNuYkVjQk0xajR6eG50ZzBrZG5rTUROU2FzR3pWOUpBaGxEUXli?=
 =?utf-8?B?a0hCT25XNGlUTldDL3BvRVF0dFgyZDlzd0hWd3BJYnIrQlRaUjlkVDRndTIw?=
 =?utf-8?B?MnlrZG4xZ1dtRmtqb3hTeTU4TlJ5bUdUeGwvcVlScTEzQU9XUFNwMUo5MTRY?=
 =?utf-8?B?eGt4TUcvVnJwZEthSVphaWpETWx1empGMTIxbERKZTNyVVBJL1RKcW51WnVx?=
 =?utf-8?B?QVh5LzFraE9yTWVBWEs5eHlyWHZaUHlnNENZWVJuTjVWVWdpUDVEYUpkT1Vw?=
 =?utf-8?Q?guOcweYtpPnD2aF1f0mEIR1P0?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <34ED17C317EFCA4694DB8C221C6D1467@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1839e042-2eae-4a81-69a7-08db6c9e9227
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2023 06:14:11.5701
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hxWJ7MeIiPssXscm6n4xOGMxXFl8zFRctiPEXeKNdwMYiJm5+cMMDvqPS2yuL9DOta+Pm7/1jC+j5UaxQkXBZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB6002
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEd1aWxsYXVtZToNCg0KT24gTW9uLCAyMDIzLTA1LTI5IGF0IDE2OjMxICswMjAwLCBHdWls
bGF1bWUgUmFucXVldCB3cm90ZToNCj4gIAkgDQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRv
IG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZl
cmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRlbnQuDQo+ICBBZGQgdGhlIERQSTEgaGRtaSBw
YXRoIHN1cHBvcnQgaW4gbXRrIGRwaSBkcml2ZXINCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEd1aWxs
YXVtZSBSYW5xdWV0IDxncmFucXVldEBiYXlsaWJyZS5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9n
cHUvZHJtL21lZGlhdGVrL210a19kcGkuYyAgICAgIHwgMTIxDQo+ICsrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKy0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RwaV9yZWdz
LmggfCAgIDUgKysNCj4gIDIgZmlsZXMgY2hhbmdlZCwgMTE5IGluc2VydGlvbnMoKyksIDcgZGVs
ZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210
a19kcGkuYw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHBpLmMNCj4gaW5kZXgg
OTQ4YTUzZjFmNGIzLi5iODNhMzhlOGJkNjAgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9tZWRpYXRlay9tdGtfZHBpLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210
a19kcGkuYw0KPiBAQCAtOSwxMiArOSwxNSBAQA0KPiAgI2luY2x1ZGUgPGxpbnV4L2ludGVycnVw
dC5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L2tlcm5lbC5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L21l
ZGlhLWJ1cy1mb3JtYXQuaD4NCj4gKyNpbmNsdWRlIDxsaW51eC9tZmQvc3lzY29uLmg+DQo+ICAj
aW5jbHVkZSA8bGludXgvb2YuaD4NCj4gICNpbmNsdWRlIDxsaW51eC9vZl9kZXZpY2UuaD4NCj4g
ICNpbmNsdWRlIDxsaW51eC9vZl9ncmFwaC5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L3BpbmN0cmwv
Y29uc3VtZXIuaD4NCj4gICNpbmNsdWRlIDxsaW51eC9wbGF0Zm9ybV9kZXZpY2UuaD4NCj4gICNp
bmNsdWRlIDxsaW51eC9zb2MvbWVkaWF0ZWsvbXRrLW1tc3lzLmg+DQo+ICsjaW5jbHVkZSA8bGlu
dXgvcmVnbWFwLmg+DQo+ICsjaW5jbHVkZSA8bGludXgvcmVzZXQuaD4NCj4gICNpbmNsdWRlIDxs
aW51eC90eXBlcy5oPg0KPiAgDQo+ICAjaW5jbHVkZSA8dmlkZW8vdmlkZW9tb2RlLmg+DQo+IEBA
IC02NywxMSArNzAsMTQgQEAgc3RydWN0IG10a19kcGkgew0KPiAgc3RydWN0IGRybV9icmlkZ2Ug
Km5leHRfYnJpZGdlOw0KPiAgc3RydWN0IGRybV9jb25uZWN0b3IgKmNvbm5lY3RvcjsNCj4gIHZv
aWQgX19pb21lbSAqcmVnczsNCj4gK3N0cnVjdCByZXNldF9jb250cm9sICpyZXNldF9jdGw7DQo+
ICBzdHJ1Y3QgZGV2aWNlICpkZXY7DQo+ICBzdHJ1Y3QgZGV2aWNlICptbXN5c19kZXY7DQo+ICBz
dHJ1Y3QgY2xrICplbmdpbmVfY2xrOw0KPiArc3RydWN0IGNsayAqZHBpX2NrX2NnOw0KPiAgc3Ry
dWN0IGNsayAqcGl4ZWxfY2xrOw0KPiAgc3RydWN0IGNsayAqdHZkX2NsazsNCj4gK3N0cnVjdCBj
bGsgKmhkbWlfY2c7DQo+ICBpbnQgaXJxOw0KPiAgc3RydWN0IGRybV9kaXNwbGF5X21vZGUgbW9k
ZTsNCj4gIGNvbnN0IHN0cnVjdCBtdGtfZHBpX2NvbmYgKmNvbmY7DQo+IEBAIC0xMzgsNiArMTQ0
LDcgQEAgc3RydWN0IG10a19kcGlfeWNfbGltaXQgew0KPiAgICogQGNzY19lbmFibGVfYml0OiBF
bmFibGUgYml0IG9mIENTQy4NCj4gICAqIEBwaXhlbHNfcGVyX2l0ZXI6IFF1YW50aXR5IG9mIHRy
YW5zZmVycmVkIHBpeGVscyBwZXIgaXRlcmF0aW9uLg0KPiAgICogQGVkZ2VfY2ZnX2luX21tc3lz
OiBJZiB0aGUgZWRnZSBjb25maWd1cmF0aW9uIGZvciBEUEkncyBvdXRwdXQNCj4gbmVlZHMgdG8g
YmUgc2V0IGluIE1NU1lTLg0KPiArICogQGlzX2ludGVybmFsX2hkbWk6IFRydWUgaWYgdGhpcyBE
UEkgYmxvY2sgaXMgZGlyZWN0bHkgY29ubmVjdGVkDQo+IHRvIFNvQyBpbnRlcm5hbCBIRE1JIGJs
b2NrLg0KPiAgICovDQo+ICBzdHJ1Y3QgbXRrX2RwaV9jb25mIHsNCj4gIHVuc2lnbmVkIGludCAo
KmNhbF9mYWN0b3IpKGludCBjbG9jayk7DQo+IEBAIC0xNTcsNiArMTY0LDcgQEAgc3RydWN0IG10
a19kcGlfY29uZiB7DQo+ICB1MzIgY3NjX2VuYWJsZV9iaXQ7DQo+ICB1MzIgcGl4ZWxzX3Blcl9p
dGVyOw0KPiAgYm9vbCBlZGdlX2NmZ19pbl9tbXN5czsNCj4gK2Jvb2wgaXNfaW50ZXJuYWxfaGRt
aTsNCj4gIH07DQo+ICANCj4gIHN0YXRpYyB2b2lkIG10a19kcGlfbWFzayhzdHJ1Y3QgbXRrX2Rw
aSAqZHBpLCB1MzIgb2Zmc2V0LCB1MzIgdmFsLA0KPiB1MzIgbWFzaykNCj4gQEAgLTQ3MSw4ICs0
NzksMTQgQEAgc3RhdGljIHZvaWQgbXRrX2RwaV9wb3dlcl9vZmYoc3RydWN0IG10a19kcGkNCj4g
KmRwaSkNCj4gIHJldHVybjsNCj4gIA0KPiAgbXRrX2RwaV9kaXNhYmxlKGRwaSk7DQo+ICsNCj4g
K3Jlc2V0X2NvbnRyb2xfcmVhcm0oZHBpLT5yZXNldF9jdGwpOw0KPiArDQo+ICBjbGtfZGlzYWJs
ZV91bnByZXBhcmUoZHBpLT5waXhlbF9jbGspOw0KPiAgY2xrX2Rpc2FibGVfdW5wcmVwYXJlKGRw
aS0+ZW5naW5lX2Nsayk7DQo+ICtjbGtfZGlzYWJsZV91bnByZXBhcmUoZHBpLT5kcGlfY2tfY2cp
Ow0KPiArY2xrX2Rpc2FibGVfdW5wcmVwYXJlKGRwaS0+aGRtaV9jZyk7DQo+ICtjbGtfZGlzYWJs
ZV91bnByZXBhcmUoZHBpLT50dmRfY2xrKTsNCj4gIH0NCj4gIA0KPiAgc3RhdGljIGludCBtdGtf
ZHBpX3Bvd2VyX29uKHN0cnVjdCBtdGtfZHBpICpkcGkpDQo+IEBAIC00ODgsMTUgKzUwMiw0NCBA
QCBzdGF0aWMgaW50IG10a19kcGlfcG93ZXJfb24oc3RydWN0IG10a19kcGkNCj4gKmRwaSkNCj4g
IGdvdG8gZXJyX3JlZmNvdW50Ow0KPiAgfQ0KPiAgDQo+ICtyZXQgPSBjbGtfcHJlcGFyZV9lbmFi
bGUoZHBpLT50dmRfY2xrKTsNCj4gK2lmIChyZXQpIHsNCj4gK2Rldl9lcnIoZHBpLT5kZXYsICJG
YWlsZWQgdG8gZW5hYmxlIHR2ZCBwbGw6ICVkXG4iLCByZXQpOw0KPiArZ290byBlcnJfZW5naW5l
Ow0KPiArfQ0KPiArDQo+ICtyZXQgPSBjbGtfcHJlcGFyZV9lbmFibGUoZHBpLT5oZG1pX2NnKTsN
Cj4gK2lmIChyZXQpIHsNCj4gK2Rldl9lcnIoZHBpLT5kZXYsICJGYWlsZWQgdG8gZW5hYmxlIGhk
bWlfY2cgY2xvY2s6ICVkXG4iLCByZXQpOw0KPiArZ290byBlcnJfdHZkOw0KPiArfQ0KPiArDQo+
ICtyZXQgPSBjbGtfcHJlcGFyZV9lbmFibGUoZHBpLT5kcGlfY2tfY2cpOw0KPiAraWYgKHJldCkg
ew0KPiArZGV2X2VycihkcGktPmRldiwgIkZhaWxlZCB0byBlbmFibGUgZHBpX2NrX2NnIGNsb2Nr
OiAlZFxuIiwgcmV0KTsNCj4gK2dvdG8gZXJyX2hkbWlfY2c7DQo+ICt9DQo+ICsNCj4gIHJldCA9
IGNsa19wcmVwYXJlX2VuYWJsZShkcGktPnBpeGVsX2Nsayk7DQo+ICBpZiAocmV0KSB7DQo+ICBk
ZXZfZXJyKGRwaS0+ZGV2LCAiRmFpbGVkIHRvIGVuYWJsZSBwaXhlbCBjbG9jazogJWRcbiIsIHJl
dCk7DQo+ICBnb3RvIGVycl9waXhlbDsNCj4gIH0NCj4gIA0KPiArcmVzZXRfY29udHJvbF9yZXNl
dChkcGktPnJlc2V0X2N0bCk7DQo+ICsNCj4gK2lmIChkcGktPnBpbmN0cmwgJiYgZHBpLT5waW5z
X2RwaSkNCj4gK3BpbmN0cmxfc2VsZWN0X3N0YXRlKGRwaS0+cGluY3RybCwgZHBpLT5waW5zX2Rw
aSk7DQo+ICsNCj4gIHJldHVybiAwOw0KPiAgDQo+ICBlcnJfcGl4ZWw6DQo+ICtjbGtfZGlzYWJs
ZV91bnByZXBhcmUoZHBpLT5kcGlfY2tfY2cpOw0KPiArZXJyX2hkbWlfY2c6DQo+ICtjbGtfZGlz
YWJsZV91bnByZXBhcmUoZHBpLT5oZG1pX2NnKTsNCj4gK2Vycl90dmQ6DQo+ICtjbGtfZGlzYWJs
ZV91bnByZXBhcmUoZHBpLT50dmRfY2xrKTsNCj4gK2Vycl9lbmdpbmU6DQo+ICBjbGtfZGlzYWJs
ZV91bnByZXBhcmUoZHBpLT5lbmdpbmVfY2xrKTsNCj4gIGVycl9yZWZjb3VudDoNCj4gIGRwaS0+
cmVmY291bnQtLTsNCj4gQEAgLTU0MSw3ICs1ODQsNiBAQCBzdGF0aWMgaW50IG10a19kcGlfc2V0
X2Rpc3BsYXlfbW9kZShzdHJ1Y3QNCj4gbXRrX2RwaSAqZHBpLA0KPiAgZWxzZQ0KPiAgY2xrX3Nl
dF9yYXRlKGRwaS0+cGl4ZWxfY2xrLCB2bS5waXhlbGNsb2NrKTsNCj4gIA0KPiAtDQo+ICB2bS5w
aXhlbGNsb2NrID0gY2xrX2dldF9yYXRlKGRwaS0+cGl4ZWxfY2xrKTsNCj4gIA0KPiAgZGV2X2Ri
ZyhkcGktPmRldiwgIkdvdCAgUExMICVsdSBIeiwgcGl4ZWwgY2xvY2sgJWx1IEh6XG4iLA0KPiBA
QCAtNjA4LDcgKzY1MCwxNiBAQCBzdGF0aWMgaW50IG10a19kcGlfc2V0X2Rpc3BsYXlfbW9kZShz
dHJ1Y3QNCj4gbXRrX2RwaSAqZHBpLA0KPiAgaWYgKGRwaS0+Y29uZi0+c3VwcG9ydF9kaXJlY3Rf
cGluKSB7DQo+ICBtdGtfZHBpX2NvbmZpZ195Y19tYXAoZHBpLCBkcGktPnljX21hcCk7DQo+ICBt
dGtfZHBpX2NvbmZpZ18ybl9oX2ZyZShkcGkpOw0KPiAtbXRrX2RwaV9kdWFsX2VkZ2UoZHBpKTsN
Cj4gKy8qIERQSSBjb3VsZCBiZSBjb25uZWN0aW5nIHRvIGV4dGVybmFsIGJyaWRnZQ0KPiArICog
b3IgaW50ZXJuYWwgSERNSSBlbmNvZGVyLiAqLw0KPiAraWYgKGRwaS0+Y29uZi0+aXNfaW50ZXJu
YWxfaGRtaSkgew0KPiArbXRrX2RwaV9tYXNrKGRwaSwgRFBJX0NPTiwgRFBJX09VVFBVVF8xVDFQ
X0VOLA0KPiArICAgICBEUElfT1VUUFVUXzFUMVBfRU4pOw0KPiArbXRrX2RwaV9tYXNrKGRwaSwg
RFBJX0NPTiwgRFBJX0lOUFVUXzJQX0VOLA0KPiArICAgICBEUElfSU5QVVRfMlBfRU4pOw0KPiAr
fSBlbHNlIHsNCj4gK210a19kcGlfZHVhbF9lZGdlKGRwaSk7DQo+ICt9DQo+ICBtdGtfZHBpX2Nv
bmZpZ19kaXNhYmxlX2VkZ2UoZHBpKTsNCj4gIH0NCj4gIGlmIChkcGktPmNvbmYtPmlucHV0XzJw
aXhlbCkgew0KPiBAQCAtNzIzLDcgKzc3NCwxMCBAQCBzdGF0aWMgdm9pZCBtdGtfZHBpX2JyaWRn
ZV9kaXNhYmxlKHN0cnVjdA0KPiBkcm1fYnJpZGdlICpicmlkZ2UpDQo+ICB7DQo+ICBzdHJ1Y3Qg
bXRrX2RwaSAqZHBpID0gYnJpZGdlX3RvX2RwaShicmlkZ2UpOw0KPiAgDQo+IC1tdGtfZHBpX3Bv
d2VyX29mZihkcGkpOw0KPiAraWYgKGRwaS0+Y29uZi0+aXNfaW50ZXJuYWxfaGRtaSkNCj4gK210
a19kcGlfcG93ZXJfb2ZmKGRwaSk7DQo+ICtlbHNlDQo+ICttdGtfZHBpX2Rpc2FibGUoZHBpKTsN
Cj4gIA0KPiAgaWYgKGRwaS0+cGluY3RybCAmJiBkcGktPnBpbnNfZ3BpbykNCj4gIHBpbmN0cmxf
c2VsZWN0X3N0YXRlKGRwaS0+cGluY3RybCwgZHBpLT5waW5zX2dwaW8pOw0KPiBAQCAtNzcyLDE0
ICs4MjYsMTYgQEAgdm9pZCBtdGtfZHBpX3N0YXJ0KHN0cnVjdCBkZXZpY2UgKmRldikNCj4gIHsN
Cj4gIHN0cnVjdCBtdGtfZHBpICpkcGkgPSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsNCj4gIA0KPiAt
bXRrX2RwaV9wb3dlcl9vbihkcGkpOw0KPiAraWYgKCFkcGktPmNvbmYtPmlzX2ludGVybmFsX2hk
bWkpDQo+ICttdGtfZHBpX3Bvd2VyX29uKGRwaSk7DQo+ICB9DQo+ICANCj4gIHZvaWQgbXRrX2Rw
aV9zdG9wKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gIHsNCj4gIHN0cnVjdCBtdGtfZHBpICpkcGkg
PSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsNCj4gIA0KPiAtbXRrX2RwaV9wb3dlcl9vZmYoZHBpKTsN
Cj4gK2lmICghZHBpLT5jb25mLT5pc19pbnRlcm5hbF9oZG1pKQ0KPiArbXRrX2RwaV9wb3dlcl9v
ZmYoZHBpKTsNCj4gIH0NCj4gIA0KPiAgc3RhdGljIGludCBtdGtfZHBpX2JpbmQoc3RydWN0IGRl
dmljZSAqZGV2LCBzdHJ1Y3QgZGV2aWNlICptYXN0ZXIsDQo+IHZvaWQgKmRhdGEpDQo+IEBAIC04
NjQsNiArOTIwLDExIEBAIHN0YXRpYyB1bnNpZ25lZCBpbnQgbXQ4MTgzX2NhbGN1bGF0ZV9mYWN0
b3IoaW50DQo+IGNsb2NrKQ0KPiAgcmV0dXJuIDI7DQo+ICB9DQo+ICANCj4gK3N0YXRpYyB1bnNp
Z25lZCBpbnQgbXQ4MTk1X2NhbGN1bGF0ZV9mYWN0b3IoaW50IGNsb2NrKQ0KPiArew0KPiArcmV0
dXJuIDE7DQo+ICt9DQo+ICsNCj4gIHN0YXRpYyB1bnNpZ25lZCBpbnQgbXQ4MTk1X2RwaW50Zl9j
YWxjdWxhdGVfZmFjdG9yKGludCBjbG9jaykNCj4gIHsNCj4gIGlmIChjbG9jayA8IDcwMDAwKQ0K
PiBAQCAtOTg5LDYgKzEwNTAsMjQgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfZHBpX2NvbmYg
bXQ4MTkyX2NvbmYgPQ0KPiB7DQo+ICAuY3NjX2VuYWJsZV9iaXQgPSBDU0NfRU5BQkxFLA0KPiAg
fTsNCj4gIA0KPiArc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfZHBpX2NvbmYgbXQ4MTk1X2NvbmYg
PSB7DQo+ICsuY2FsX2ZhY3RvciA9IG10ODE5NV9jYWxjdWxhdGVfZmFjdG9yLA0KPiArLm1heF9j
bG9ja19raHogPSA1OTQwMDAsDQo+ICsucmVnX2hfZnJlX2NvbiA9IDB4ZTAsDQo+ICsub3V0cHV0
X2ZtdHMgPSBtdDgxODNfb3V0cHV0X2ZtdHMsDQo+ICsubnVtX291dHB1dF9mbXRzID0gQVJSQVlf
U0laRShtdDgxODNfb3V0cHV0X2ZtdHMpLA0KPiArLnBpeGVsc19wZXJfaXRlciA9IDEsDQo+ICsu
aXNfY2tfZGVfcG9sID0gdHJ1ZSwNCj4gKy5zd2FwX2lucHV0X3N1cHBvcnQgPSB0cnVlLA0KPiAr
LmRpbWVuc2lvbl9tYXNrID0gSFBXX01BU0ssDQo+ICsuaHZzaXplX21hc2sgPSBIU0laRV9NQVNL
LA0KPiArLmNoYW5uZWxfc3dhcF9zaGlmdCA9IENIX1NXQVAsDQo+ICsueXV2NDIyX2VuX2JpdCA9
IFlVVjQyMl9FTiwNCj4gKy5jc2NfZW5hYmxlX2JpdCA9IENTQ19FTkFCTEUsDQo+ICsuaXNfaW50
ZXJuYWxfaGRtaSA9IHRydWUsDQoNCm10ODE3MyBkcGkgaXMgYWxzbyBjb25uZWN0IHRvIGludGVy
bmFsIG10ODE3MyBoZG1pLg0KDQo+ICsuc3VwcG9ydF9kaXJlY3RfcGluID0gdHJ1ZSwNCj4gK307
DQo+ICsNCj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2RwaV9jb25mIG10ODE5NV9kcGludGZf
Y29uZiA9IHsNCj4gIC5jYWxfZmFjdG9yID0gbXQ4MTk1X2RwaW50Zl9jYWxjdWxhdGVfZmFjdG9y
LA0KPiAgLm1heF9jbG9ja19raHogPSA2MDAwMDAsDQo+IEBAIC0xMDQ2LDYgKzExMjUsMTIgQEAg
c3RhdGljIGludCBtdGtfZHBpX3Byb2JlKHN0cnVjdA0KPiBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYp
DQo+ICByZXR1cm4gcmV0Ow0KPiAgfQ0KPiAgDQo+ICtkcGktPnJlc2V0X2N0bCA9IGRldm1fcmVz
ZXRfY29udHJvbF9nZXRfb3B0aW9uYWxfZXhjbHVzaXZlKGRldiwNCj4gImRwaV9vbiIpOw0KPiAr
aWYgKElTX0VSUihkcGktPnJlc2V0X2N0bCkpIHsNCj4gK2Rldl9lcnIoZGV2LCAiRmFpbGVkIHRv
IGdldCByZXNldF9jdGw6ICVsZFxuIiwgUFRSX0VSUihkcGktDQo+ID5yZXNldF9jdGwpKTsNCj4g
K3JldHVybiBQVFJfRVJSKGRwaS0+cmVzZXRfY3RsKTsNCj4gK30NCj4gKw0KPiAgZHBpLT5lbmdp
bmVfY2xrID0gZGV2bV9jbGtfZ2V0KGRldiwgImVuZ2luZSIpOw0KPiAgaWYgKElTX0VSUihkcGkt
PmVuZ2luZV9jbGspKSB7DQo+ICByZXQgPSBQVFJfRVJSKGRwaS0+ZW5naW5lX2Nsayk7DQo+IEBA
IC0xMDU1LDcgKzExNDAsMjYgQEAgc3RhdGljIGludCBtdGtfZHBpX3Byb2JlKHN0cnVjdA0KPiBw
bGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICByZXR1cm4gcmV0Ow0KPiAgfQ0KPiAgDQo+IC1kcGkt
PnBpeGVsX2NsayA9IGRldm1fY2xrX2dldChkZXYsICJwaXhlbCIpOw0KPiArZHBpLT5oZG1pX2Nn
ID0gZGV2bV9jbGtfZ2V0X29wdGlvbmFsKGRldiwgImhkbWlfY2ciKTsNCg0KVGhpcyBjbG9jayBp
cyBub3QgZGVmaW5lZCBpbiBiaW5kaW5nIGRvY3VtZW50Lg0KDQo+ICtpZiAoSVNfRVJSKGRwaS0+
aGRtaV9jZykpIHsNCj4gK3JldCA9IFBUUl9FUlIoZHBpLT5oZG1pX2NnKTsNCj4gK2lmIChyZXQg
IT0gLUVQUk9CRV9ERUZFUikNCj4gK2Rldl9lcnIoZGV2LCAiRmFpbGVkIHRvIGdldCBoZG1pX2Nn
IGNsb2NrOiAlZFxuIiwgcmV0KTsNCj4gKw0KPiArcmV0dXJuIHJldDsNCj4gK30NCj4gKw0KPiAr
ZHBpLT5kcGlfY2tfY2cgPSBkZXZtX2Nsa19nZXRfb3B0aW9uYWwoZGV2LCAiY2tfY2ciKTsNCg0K
VGhpcyBjbG9jayBpcyBub3QgZGVmaW5lZCBpbiBiaW5kaW5nIGRvY3VtZW50Lg0KDQpSZWdhcmRz
LA0KQ0sNCg0KPiAraWYgKElTX0VSUihkcGktPmRwaV9ja19jZykpIHsNCj4gK3JldCA9IFBUUl9F
UlIoZHBpLT5kcGlfY2tfY2cpOw0KPiAraWYgKHJldCAhPSAtRVBST0JFX0RFRkVSKQ0KPiArZGV2
X2VycihkZXYsICJGYWlsZWQgdG8gZ2V0IGRwaSBjayBjZyBjbG9jazogJWRcbiIsDQo+ICtyZXQp
Ow0KPiArDQo+ICtyZXR1cm4gcmV0Ow0KPiArfQ0KPiArDQo+ICtkcGktPnBpeGVsX2NsayA9IGRl
dm1fY2xrX2dldF9vcHRpb25hbChkZXYsICJwaXhlbCIpOw0KPiAgaWYgKElTX0VSUihkcGktPnBp
eGVsX2NsaykpIHsNCj4gIHJldCA9IFBUUl9FUlIoZHBpLT5waXhlbF9jbGspOw0KPiAgaWYgKHJl
dCAhPSAtRVBST0JFX0RFRkVSKQ0KPiBAQCAtMTA2NCw3ICsxMTY4LDcgQEAgc3RhdGljIGludCBt
dGtfZHBpX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UNCj4gKnBkZXYpDQo+ICByZXR1cm4g
cmV0Ow0KPiAgfQ0KPiAgDQo+IC1kcGktPnR2ZF9jbGsgPSBkZXZtX2Nsa19nZXQoZGV2LCAicGxs
Iik7DQo+ICtkcGktPnR2ZF9jbGsgPSBkZXZtX2Nsa19nZXRfb3B0aW9uYWwoZGV2LCAicGxsIik7
DQo+ICBpZiAoSVNfRVJSKGRwaS0+dHZkX2NsaykpIHsNCj4gIHJldCA9IFBUUl9FUlIoZHBpLT50
dmRfY2xrKTsNCj4gIGlmIChyZXQgIT0gLUVQUk9CRV9ERUZFUikNCj4gQEAgLTExMzQsNiArMTIz
OCw5IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkDQo+IG10a19kcGlfb2ZfaWRz
W10gPSB7DQo+ICB7IC5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE5NS1kcC1pbnRmIiwNCj4g
ICAgLmRhdGEgPSAmbXQ4MTk1X2RwaW50Zl9jb25mLA0KPiAgfSwNCj4gK3sgLmNvbXBhdGlibGUg
PSAibWVkaWF0ZWssbXQ4MTk1LWRwaSIsDQo+ICsgIC5kYXRhID0gJm10ODE5NV9jb25mLA0KPiAr
fSwNCj4gIHsgfSwNCj4gIH07DQo+ICBNT0RVTEVfREVWSUNFX1RBQkxFKG9mLCBtdGtfZHBpX29m
X2lkcyk7DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RwaV9y
ZWdzLmgNCj4gYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RwaV9yZWdzLmgNCj4gaW5k
ZXggNjJiZDQ5MzFiMzQ0Li42NTNlZjRiOTNhOTcgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9tZWRpYXRlay9tdGtfZHBpX3JlZ3MuaA0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVk
aWF0ZWsvbXRrX2RwaV9yZWdzLmgNCj4gQEAgLTQzLDYgKzQzLDExIEBADQo+ICAjZGVmaW5lIERQ
SU5URl9ZVVY0MjJfRU5CSVQoMjQpDQo+ICAjZGVmaW5lIERQSU5URl9DU0NfRU5BQkxFQklUKDI2
KQ0KPiAgI2RlZmluZSBEUElOVEZfSU5QVVRfMlBfRU5CSVQoMjkpDQo+ICsjZGVmaW5lIERQSV9P
VVRQVVRfMVQxUF9FTkJJVCgyNCkNCj4gKyNkZWZpbmUgRFBJX0lOUFVUXzJQX0VOQklUKDI1KQ0K
PiArI2RlZmluZSBEUElfRVhUX1ZTWU5DX0VOQklUKDI2KQ0KPiArI2RlZmluZSBEUElfUkdCNTY1
X0VOQklUKDI3KQ0KPiArI2RlZmluZSBEUElfUkdCODgwX0VOQklUKDI4KQ0KPiAgDQo+ICAjZGVm
aW5lIERQSV9PVVRQVVRfU0VUVElORzB4MTQNCj4gICNkZWZpbmUgQ0hfU1dBUDANCj4gDQo+IC0t
IA0KPiAyLjQwLjANCj4gDQo+IA0K
