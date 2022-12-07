Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B30586451A2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 03:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbiLGCAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 21:00:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbiLGCAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 21:00:37 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C532E532F1;
        Tue,  6 Dec 2022 18:00:31 -0800 (PST)
X-UUID: 4e868de8b86449adabed5eef82f82c95-20221207
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=tLcsdQttYtBjvNgPbYCqz8lYylBy7mROqOeoE3qwbrY=;
        b=Okh9tfI1S0g3PCr2tJVXkA7Fexxig5fln5myHlsU4GcM5ZdaZkR8RJjcjYRsQu7MetrwWuWJXv/ja6LtaSHx26KZk/1YT2Ks/7mvHRzcXrsdfLe7CxABgPI03Cs6TiHG9sNIQfd0rJTdPUWsLeDbdAulcSOxqaDH/QsrMOkh4xM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:f07e7650-3234-445f-bc93-270aaa95e6c5,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:dcaaed0,CLOUDID:0c36bf16-b863-49f8-8228-cbdfeedd1fa4,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 4e868de8b86449adabed5eef82f82c95-20221207
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <xiangsheng.hou@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 347497002; Wed, 07 Dec 2022 10:00:24 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Wed, 7 Dec 2022 10:00:20 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Wed, 7 Dec 2022 10:00:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ISosMI9/bPAtE3+as9+Pu/zAy7mmV0R3Ne+YjKHropqF9kSnnrvcZHslZqtRoXaMdRhcbYhGwVzb73AgxmSEMJdhZhpxivUqUzNYp382OJxqMLlRo2nkLHQwT2stzdVfYkO894fgfLVQ7M2n30mDOLNccqZZl2hxDIb9c8QS1vv1TLCuubx8WJpNLgF4wBgjFnSpHqC2wVnYR4j+rbgnfzDZV2rGvHaJtjBO1Y6BChOo2W2C2SlXGTI1Ys86K0rIdwJR+bkfx+p/8uz+SQweGbgTwpYnLVb1fMi1JOJ/eUQZEydliNqJfhjEyfwx7CoYgkXiur5A/qI8+ZV+nv4R1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tLcsdQttYtBjvNgPbYCqz8lYylBy7mROqOeoE3qwbrY=;
 b=a8Kj1onSv3x9Gv/STYQeN61HL9+7hqdZ+gS5Fyd32ADiICMf6m+g3Z4RQs2MS5w3Npj6x+shNfmh1tF8wyhniNetoDx67ZprF8/eLFZEh7AfXm3vwFGwNSj8aKaUvKaiiogVePsbJNBxWwu7jt2sOgZVCtzQPU6de+jp47mhHc0D6zik86Bk2sacsWMAeT30+oTeqhEpCr+4vvnD3rmX0Mu+Yqel8KMWIKmSwgIPxVIpQF56yjAUYWChSRj4QSz3trSJNruaTJyOPAkuzHOvyH+0fwH1TOHAJKNsxYXEr03sB69hYmC0Uc62+FVCwjdQRa3AOJT70Ig6n5qbaBzubA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tLcsdQttYtBjvNgPbYCqz8lYylBy7mROqOeoE3qwbrY=;
 b=WmB+Sv9cQnp4/GmFQZwZwNHF2gtJLWyT4NB97cO8JOhoJd4t1IQ9VZHCB193p63mHfuY9+eUklb9kkl4ChNbaIDVvRnIhtKBLK91nSF5BxW//IM9ViybbgAI0+essFA8C4zP9KfahqEgrJe10BjzH1jPIB0Yp8cRAjkSYIFe+O4=
Received: from SG2PR03MB4565.apcprd03.prod.outlook.com (2603:1096:4:84::10) by
 KL1PR0302MB5201.apcprd03.prod.outlook.com (2603:1096:820:44::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 02:00:18 +0000
Received: from SG2PR03MB4565.apcprd03.prod.outlook.com
 ([fe80::3d3b:d288:88e3:59c7]) by SG2PR03MB4565.apcprd03.prod.outlook.com
 ([fe80::3d3b:d288:88e3:59c7%6]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 02:00:18 +0000
From:   =?utf-8?B?WGlhbmdzaGVuZyBIb3UgKOS+r+elpeiDnCk=?= 
        <Xiangsheng.Hou@mediatek.com>
To:     "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "gch981213@gmail.com" <gch981213@gmail.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "richard@nod.at" <richard@nod.at>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?QmVubGlhbmcgWmhhbyAo6LW15pys5LquKQ==?= 
        <Benliang.Zhao@mediatek.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        =?utf-8?B?QmluIFpoYW5nICjnq6Dmlowp?= <bin.zhang@mediatek.com>
Subject: Re: [PATCH v2 7/9] dt-bindings: spi: mtk-snfi: Add read latch latency
 property
Thread-Topic: [PATCH v2 7/9] dt-bindings: spi: mtk-snfi: Add read latch
 latency property
Thread-Index: AQHZCHcIWFb1SQ8l7UecaYFwLXxxLa5fWMwAgAE5uQCAADahgIAA5TqA
Date:   Wed, 7 Dec 2022 02:00:17 +0000
Message-ID: <e2ccf42f94152ccacad3a2eaec234ae0566474ec.camel@mediatek.com>
References: <20221205065756.26875-1-xiangsheng.hou@mediatek.com>
         <20221205065756.26875-8-xiangsheng.hou@mediatek.com>
         <ce449a0c-efcc-0ac1-fb8e-c2b4148a5bc1@collabora.com>
         <a8f706b37f5decf91bfa9a9ac8cf04be4346dd85.camel@mediatek.com>
         <9992c9a5-059a-9396-32ce-7ed63cd12a96@collabora.com>
In-Reply-To: <9992c9a5-059a-9396-32ce-7ed63cd12a96@collabora.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR03MB4565:EE_|KL1PR0302MB5201:EE_
x-ms-office365-filtering-correlation-id: 6f42e044-b26b-4b0d-9479-08dad7f6ca32
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6FfU7HoKHAwFSLu++P40Dkhwxd1wUMvwgAgIS9erVT6aqQMaMIbeO/WAqTpXxoP9PywVD5nhh4i0L4036YdLzGJzNY0wkUzwhSL3hcLb+yiDCIfPQh99ZdYoUYzGXdqjSOcH/N4yYSFz/o9+Fth/CtJGxZm6LtZ2g1/hhg6DfdoZKmr8YR4SPFO9h4EhCZ5Bqs+E0lyms4Sef5IUdK5JJsmo0HMhd1hjVD3t9iFpqTu/TWvG0kVmG1mfiXthtDUyUP38Tj8Fok16i3fOWqXdXMljW4XlISLsr+lii8WN2ZgaJn4HQNPdmF04lByNA9N4kHo/cglxQvdJFXO3KJ6AyfX74UksW+D6t1tC2BIYMaPhIEOIYxo4LivKFvduzHtqHJ7oG31H8w1dUKwZCgtHddeO/UT8Ik3O4iPoW/tYdTIrBR3YA6pqsrTA2q6RqJcF9hUTTBUzLpPYK2jeAriPxzn9GodKuewXXZ5VrAIc9EfPqGN60T86/dUVUniF+GWCgDs6kbBLvWYijp5/ZjSA92G+ozQsmLWhIKjqAU2LEenFWEKRqGk2DV2LeaWEasCy0mxFsCFJMDvS7cw/CtVQcHykunPb2kVqudwEoTsqp485AulejTDH6ggmND/R4OaiZDhoENiIlX3dlkKzv70WrSRQlkrNsYEnyKLN0tj9tciDWp0YR/kYgJT4/tHLUvh0I77IGo0ImTyMFZKTU3Y5l28heURYhnKzmtq6UVXIjHmizp/SY431u2hyMpHmD7qj
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB4565.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(39860400002)(366004)(376002)(136003)(451199015)(122000001)(83380400001)(38100700002)(7416002)(66476007)(8936002)(4326008)(38070700005)(86362001)(66946007)(64756008)(2906002)(76116006)(66446008)(41300700001)(66556008)(8676002)(478600001)(5660300002)(26005)(71200400001)(6512007)(6506007)(107886003)(186003)(316002)(2616005)(110136005)(6486002)(54906003)(36756003)(85182001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U0VnZ3VkT2c4MkFSc3MrbFp1Ym5ram9GOFh1RExQNXN2aGdSUDVjcGxWOHha?=
 =?utf-8?B?MUhXRkhpS29ycEo1akUyeFc4ekVvTmJjTUdDVVlGaTFSdFNCRTlIbjdRcmlK?=
 =?utf-8?B?cEQ2Ym5UOEduT043RDd0Z2V4bnp2RzZpTHd5aHJpdTdFVzUzd09LOXBvQ3p4?=
 =?utf-8?B?UWtyS3Fhd0tLdE5qQk9Pa3UrN1JNQTRRb0cwN2k1bWM4RFZDNHdWYkpWVklC?=
 =?utf-8?B?WXpYdUJSZGpCS01xYzZMaDZ5YW1WK2ZvbStmTVlMc2JkY3BVa1Mwb094N0s0?=
 =?utf-8?B?SDRLb0ZHRndIcXA3S0p3UEhIVUV5b04raUFrbzlJcVp6aDZrV0NucUVXeFlX?=
 =?utf-8?B?TVczaFY1ZGs1UWdXUWQ2S0hjTUJCL2dHVFVGT3E2NDhabDdUM2xyNDFPc1lB?=
 =?utf-8?B?QThYbm5NUUJXZFdIRGZ0SEgvUnhnTEVDdFdqM1diNVY3SEpqQkZkUFNWalVy?=
 =?utf-8?B?N2J2Vmt0eFBOU001aTlDc0xwdE1jM2wzcGxDTlZQajN1dnRISEJxdEFIbmh0?=
 =?utf-8?B?aE1rV0ZuZ2ZvNXZEYTB6a1ZLbDA5aHpTTk8vVUxWZEM2S0N6cE1YK2tCNkRa?=
 =?utf-8?B?aVFVcEhWUzMrUGFuU0FCdzdobFJCeklORmJyOERRNS9CemhPTTdjZE5rTXRm?=
 =?utf-8?B?SjN1ZFBCTUlMbHFraVJ5Q0pBZmZ4aGN4dUVvcXJ1SjhWV2Z2ZVhZR2tweXE3?=
 =?utf-8?B?Sy9nVGJZWmZaeS9oVUE5b3RkWTBQYnhRWEVUUjFPT3FKcmxmSGhlVHRrSkRU?=
 =?utf-8?B?d01IREVuVCtXZU03bExaeTZWeFJrKzdTT0lkb0RETnNKK2wyUDdnbzc4dDF1?=
 =?utf-8?B?RlJjQnV1QWx1Qkt5UTVKUnZXWkhjUXAxemNobExRSEhKTm8rUmdkOFVnbEFv?=
 =?utf-8?B?UVhCT29jVVFTSFpTRGttblJpYU5LZVhhMGx5ZXJBS2hKUkd1ZFd0eHYzS3Yv?=
 =?utf-8?B?amFCUUFzdXR6NHlCSXVQbFpxcFJka0s5K08yYXBZUm9QZ1RGQ1ZiamRJb0Fp?=
 =?utf-8?B?Z0J1em9ldldyVE8rMWRpbHd3K1FIOGJCN3k1M3MrSTk4TDhsZXBIdzFvbmNs?=
 =?utf-8?B?V3J0emVBNlg3Z2RnRlk4algrcjAzRllXT0NGdi90YUFQTmtTb1RNYk5wL2FI?=
 =?utf-8?B?cG9LSlFLUHJwMkRFSEtvMEhNU2ZOV1doc1BETjZKRkI3YW5hR0ZweWZiUVp3?=
 =?utf-8?B?LzhLaHhKazM5T3V2Wm1qdXozdnlMK1ZxZDE4aW1CYkhad05jOTgrei9kV3J0?=
 =?utf-8?B?TW5oRmJhUnlkY2NsakJLN2Y0WXZBcGswWFNWa0tMQTlVRExreThHRXRkUDhr?=
 =?utf-8?B?bzNZU0pvMDdzcWZZdlBTVDRhS0dBWUxuL0t4dWtucjI4eWk0ZGVoREpvbHFE?=
 =?utf-8?B?d252cEtJWmY4STBCNWhTajBRMXZKNlJ2UGM2Q3d0NVRSbWlBYXJKOE5zK2lT?=
 =?utf-8?B?NGI4UGFRcldMeE1QSmJ6ZWpCWk14N09vYllGUHRtUkxFbHRZN2hxYkI0eG1y?=
 =?utf-8?B?WlRURTd4eVhUSEZZUDNISUU2bkx2YlR6VENPdDNpcEtzRGdUd0cydGNGNHVS?=
 =?utf-8?B?cWxzaUhjQlYyVklCK0ROTHVkUEY3VDdaYjJsMURYUURIOFFzUmU3cUQvZFpv?=
 =?utf-8?B?U3RzTFN4Ui9qeEpMZEw0SEpRc0gxMVZTb3dKOUptZmtMcVRUL2l2QU5SU0I3?=
 =?utf-8?B?Yk45dVNDYmdqaXF6Y3FqcHpmOTg4QzNkalQyVEhpUnh0Ry9uSUNmM0Jkb2tZ?=
 =?utf-8?B?STZTdGJOUzBWazBRZ1JzcEd6SHBWemhRU21PRHJkUDJBVmJES2tIV1B0TXNY?=
 =?utf-8?B?dWxrSWhQRzI0c3VXSHQvd2UzYm9OenFXVFdrbmY2ZmNQMXBMVXlYamlmYlVB?=
 =?utf-8?B?UERtL1RtZGxzczFXU2I2dXhTWFFLbndXazlnL2JneXBkVGQreTlKbzJXT280?=
 =?utf-8?B?c0ZIbzVrL0tjWk41OGtHRGIwVjNGU000Zzh2c3RORVQ2N1l5clFZWDRlMW0x?=
 =?utf-8?B?N2wwc2hNZUZkVVI2UHVsN2FEc3ozL2ptd0NIOHRWUlhUb1B1bm11MU5DYlJt?=
 =?utf-8?B?cmxZdFVtamcycVNqOGVWVzVTaG56bFJVa3BURFlmV2JKeE1OR1NnWjZLZFhK?=
 =?utf-8?B?aVVWL2V3MjBPd1RrTFQ4MTBhMFlYZHNtSkEvdUR5VDlEeFR5am9UU25Pa3NK?=
 =?utf-8?Q?I8KRjTAbSRaxUqBBF2jDuB4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <020B1A5085A28E46B9BA99C5C762A7DE@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB4565.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f42e044-b26b-4b0d-9479-08dad7f6ca32
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2022 02:00:17.9960
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XPY0TXyKxGvDBbltYrfr/qwkM/k1hr+eR9HP0MMkwy6uvdNHly8Lzs6RXHwsaCxz4uplw5IgC9hIWJHxVedY14rRD+61KxALjBHwHm0MYJ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0302MB5201
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5nZWxvLA0KDQpPbiBUdWUsIDIwMjItMTItMDYgYXQgMTM6MTkgKzAxMDAsIEFuZ2Vsb0dp
b2FjY2hpbm8gRGVsIFJlZ25vIHdyb3RlOg0KPiA+ID4gPiBkaWZmIC0tZ2l0DQo+ID4gPiA+IGEv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NwaS9tZWRpYXRlayxzcGktDQo+ID4g
PiA+IG10ay1zbmZpLnlhbWwNCj4gPiA+ID4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3Mvc3BpL21lZGlhdGVrLHNwaS0NCj4gPiA+ID4gbXRrLXNuZmkueWFtbA0KPiA+ID4gPiBp
bmRleCBiYWIyM2YxYjExZmQuLjZlNmZmOGQ3M2ZjZCAxMDA2NDQNCj4gPiA+ID4gLS0tIGEvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NwaS9tZWRpYXRlayxzcGktbXRrLQ0KPiA+
ID4gPiBzbmZpLnlhbWwNCj4gPiA+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL3NwaS9tZWRpYXRlayxzcGktbXRrLQ0KPiA+ID4gPiBzbmZpLnlhbWwNCj4gPiA+ID4g
QEAgLTQ1LDYgKzQ1LDEzIEBAIHByb3BlcnRpZXM6DQo+ID4gPiA+ICAgICAgICBkZXNjcmlwdGlv
bjogZGV2aWNlLXRyZWUgbm9kZSBvZiB0aGUgYWNjb21wYW55aW5nIEVDQw0KPiA+ID4gPiBlbmdp
bmUuDQo+ID4gPiA+ICAgICAgICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9u
cy9waGFuZGxlDQo+ID4gPiA+ICAgIA0KPiA+ID4gPiArICBtZWRpYXRlayxyeC1sYXRjaC1sYXRl
bmN5Og0KPiA+ID4gPiArICAgIGRlc2NyaXB0aW9uOiBSeCBkZWxheSB0byBzYW1wbGUgZGF0YSB3
aXRoIHRoaXMgdmFsdWUsIHRoZQ0KPiA+ID4gPiB2YWx1ZQ0KPiA+ID4gPiArICAgICAgICAgICAg
ICAgICB1bml0IGlzIGNsb2NrIGN5Y2xlLg0KPiA+ID4gDQo+ID4gPiBDYW4ndCB3ZSB1c2UgbmFu
b3NlY29uZHMgb3IgbWljcm9zZWNvbmRzIGFzIGEgdW5pdCBoZXJlLCBpbnN0ZWFkDQo+ID4gPiBv
Zg0KPiA+ID4gY2xvY2sgY3ljbGVzPw0KPiA+IA0KPiA+IFRoZSBjbG9jayBjeWNsZSB3aWxsIGJl
IHZhcmlvdXMgd2l0aCBNZWRpYVRlayBTUEkgTkFORCBjb250cm9sbGVyDQo+ID4gd2hpY2gNCj4g
PiBjbG9jayBmcmVxdWVuY3kgY2FuIHN1cHBvcnQgMjYvNTIvNjgvODEvMTA0TUh6Li4uDQo+ID4g
SXRgcyBtYXkgYmUgZWFzeSB0byBjb25maWd1cmUgYW5kIHVuZGVyc3RhbmQgd2l0aCBjbG9jayBj
eWNsZSBpbg0KPiA+IHVuaXQuDQo+ID4gDQo+IA0KPiBZZXMsIGJ1dCB3aGF0ZXZlciBjbG9jayBm
cmVxdWVuY3kgd2UgdXNlLCB0aGUgdGFyZ2V0IGlzIHRvIGFsd2F5cw0KPiB3YWl0IGZvcg0KPiBY
IG5hbm9zZWNvbmRzLCByaWdodD8NCj4gDQo+IFdhaXRpbmcgZm9yIDUgY2xvY2sgY3ljbGVzIGF0
IDEwNE1IeiBpcyBvYnZpb3VzbHkgbm90IHRoZSBzYW1lIGFzDQo+IHdhaXRpbmcNCj4gZm9yIHRo
ZSBzYW1lIDUgY2xvY2sgY3ljbGVzIGF0IDI2TUh6OiBpbiB0aGF0IGNhc2UsIGV4cHJlc3Npbmcg
dGhlDQo+IHZhbHVlDQo+IGluIG5hbm9zZWNvbmRzIG9yIG1pY3Jvc2Vjb25kcyB3b3VsZCBtYWtl
IHRoYXQgaW5kZXBlbmRlbnQgZnJvbSB0aGUNCj4gY29udHJvbGxlcidzIGNsb2NrIGZyZXF1ZW5j
eSBhcyB0aGUgY2FsY3VsYXRpb24gZnJvbSBgdGltZWAgdG8NCj4gYGN5Y2xlc2ANCj4gd291bGQg
YmUgcGVyZm9ybWVkIGluc2lkZSBvZiB0aGUgZHJpdmVyLg0KDQpUaGVyZSBoYXZlIHR3byByeCBy
ZWxhdGVkIHRpbWluZyBwcm9wZXJ0aWVzIGluIHNwaS1wZXJpcGhlcmFsLXByb3BzLg0KVGhlIHJ4
LXNhbXBsZS1kZWxheS1ucyBoYXZlIGJlZW4gdXNlZCBpbiBNZWRpYXRlayBzbmZpIGRyaXZlciB0
byBhZGp1c3QNCmNvbnRyb2xsZXIgc2FtcGxlIGRlbGF5Lg0KSG93ZXZlciBhbm90aGVyIHNwaS1y
eC1kZWxheS11cyBpcyBpbiBtaWNyb3NlY29uZHMuIFRha2UgNTJNSHogZm9yDQpleGFtcGxlLCB0
aGUgY2xvY2sgY3ljbGUgd2lsbCBiZSAxOS4yM25zIHdoaWNoIGxvd2VyIHRoYW4gMXVzLiBUaGlz
IG1heQ0Kbm90IGVhc3kgdG8gYnkgb25lIGNsb2NrIGN5Y2xlLg0KDQpUaGFua3MNClhpYW5nc2hl
bmcgSG91DQo=
