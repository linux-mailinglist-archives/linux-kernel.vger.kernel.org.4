Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFCB3643F4C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 10:05:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234510AbiLFJE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 04:04:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234508AbiLFJEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 04:04:52 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 645492BFD;
        Tue,  6 Dec 2022 01:04:48 -0800 (PST)
X-UUID: 5d87f4c4fa9a4773804ce7790090da43-20221206
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=zFMceN8kwkFqKklgIHaq7tODIhf8qu6TPH3smNbxQ3k=;
        b=J+PcoIaurpaIkmxiK6C2KedtZUHn18E8oq7spPi17ACQWJUR7BwNugJbfmeSsPcMNps1Hvo2eARuYczH3x3J4Qh5apHrVUZoTBwUoRrkalTJCfAwNrOlVf2Km6giLen0HGGTizRH3EL66f+uzVTLUfkzcSGCt72udF0nomkeCk0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:f6a6afe3-6ed1-4b2c-ba7b-b0aa27f400d7,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:dcaaed0,CLOUDID:ec3bc9d1-652d-43fd-a13a-a5dd3c69a43d,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 5d87f4c4fa9a4773804ce7790090da43-20221206
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <xiangsheng.hou@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1666900101; Tue, 06 Dec 2022 17:04:42 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 6 Dec 2022 17:04:41 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Tue, 6 Dec 2022 17:04:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eQeyZRFNN9a94NU1ozNwiWOb6bi5i0h8LIcE+h6Fh3Nj6OfVohNsz7cPjBBuhNBTCwsoXf3rP8jwYaCWxMF+lqDszkawfioZoFXpQuNCit0iabF375FknpRJaFS+B7Tmbt1mAlQDRjfKaGUdTS60RS05qG+dqihZ8YjlLn6xzPjZfxZa+zhSfNiwtbpoXOwEIzVAyyECjX0yvQQy0DiQaGbEuXoHvVR6VdjwhpQEI7jqnxATObMreMAJ8AuQTINfBK57AITS+RDVfTpwkEcJQmJoj+twlVHPR53YHVmFpi9SuL+UWF8W3KdPO42DjGpZZk6bJEKGkldVpMheyhuICA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zFMceN8kwkFqKklgIHaq7tODIhf8qu6TPH3smNbxQ3k=;
 b=IkDcsCcmLINXLUPjyfAEinrKLy5c/uABX2wyWPyFaR1r+iL72ACttBRbb+x+Z7HzHV02hnT67RpO9bvVY+eBcyzWnGAdSX2qaNan5UPyGdAeCzBP+aX9HtomMsZsbc00SLvOyafEXcPshBkPdcXp2twLn8W2J+Xs5JyQgY6fgDoHvVuiNwZFg7or4/dBTxjMmGsbkcvN4oECKHsOfRDrFkA47z0mOx2AcBkH3pjr8eiNfNbom8Mgnz7U+JgivhE9o/QGLhIWjPiaKP07YdRoynZJZtingyEjiltMYzj/mlbgZrC2R/p/PM8lNXkDxdVY+E3jRi4cVH5xgsCa0ztZ5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zFMceN8kwkFqKklgIHaq7tODIhf8qu6TPH3smNbxQ3k=;
 b=KK5lGsTnR1wTnVwre+jupDxr/YUyGKM4k88uuPPGHJHVZ+B2kOzTVyreuEWBbBbLjk34tGECca5xUMEudXrCb34FCW7eL58cQGqYuqGe06DXLgmEoDMGFUhSbu3M8523KIfNFQCVnM4UGkn7MI/lqSTYzsSgGtzTwpTGYwisYAg=
Received: from SG2PR03MB4565.apcprd03.prod.outlook.com (2603:1096:4:84::10) by
 PUZPR03MB6159.apcprd03.prod.outlook.com (2603:1096:301:ba::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.14; Tue, 6 Dec 2022 09:04:39 +0000
Received: from SG2PR03MB4565.apcprd03.prod.outlook.com
 ([fe80::3d3b:d288:88e3:59c7]) by SG2PR03MB4565.apcprd03.prod.outlook.com
 ([fe80::3d3b:d288:88e3:59c7%6]) with mapi id 15.20.5880.014; Tue, 6 Dec 2022
 09:04:39 +0000
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
Subject: Re: [PATCH v2 4/9] mtd: nand: ecc-mtk: Add ECC support fot MT7986 IC
Thread-Topic: [PATCH v2 4/9] mtd: nand: ecc-mtk: Add ECC support fot MT7986 IC
Thread-Index: AQHZCHbyAHieoWCHukSx2RlxcIaKz65fWMOAgAE52AA=
Date:   Tue, 6 Dec 2022 09:04:39 +0000
Message-ID: <149100d0dc205a317ed352cdfb391f2147a2afab.camel@mediatek.com>
References: <20221205065756.26875-1-xiangsheng.hou@mediatek.com>
         <20221205065756.26875-5-xiangsheng.hou@mediatek.com>
         <50ede482-7f03-ff55-5ad0-aa6249027cbe@collabora.com>
In-Reply-To: <50ede482-7f03-ff55-5ad0-aa6249027cbe@collabora.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR03MB4565:EE_|PUZPR03MB6159:EE_
x-ms-office365-filtering-correlation-id: 5bc39a1c-9049-41bc-34de-08dad768e7ff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GADdXYFs6k0clwfufA5ivrhvDKs4za6hF5UJbbYqGX7N46SUCnYxvuiMLiFQsezREsylpYX4BqyqacZr5F41tyPyuOWtxCyb7ufv+63l2oIqvlHKT34dTznqgrFAviZubpTqLgthOxCwcycYreOXk1yG0/PEYvSo0f3/pAuNPpQsHZFxobBrijRjKsF8MSTx7rV64/htY91vA+xeg9gd+MaxmmqjtxkE+5yLGJAiwOF3VTt3tWmOYaFZvWofcJ+1cBAAJKhgqa1f/e06NSIFx5MMYFP3zg64rfkORRKdz4pY++4zYLqt403dAsNykfwgt0faFyYuUZ69VNuw1WyhuEp/JTNQ3+PSUPKmIyNSwS44ZkCfMMC6/n66lPDPcj8pbkpGUyxJuGvCQJGGnldq9DGcNcuYyDIuxsXCH7dwPN80aJBbOqrVqVr8OGvYHTuAjRBcW6fOV9Qlyp11BJMBWgTdm5EKkNPHA+KYdqMSkUpzM0O91YKY9PkU5vUE68gFJgxgE7fOYyFeF+NZsPs86058467j8RZbtCftCrhmn555fzFO7Q44mW/LF+6OgB2eOaep0VE+oN6aBuP5JDvNK0ykel7fPCJSCcUuz/deYnIpkXV0GFxGW3dVE1luKmlssJaeAJVog/dQ5s43FgpPShNJ3cfDN3pxFLk81cJE6wI0dxC/1uPKwCJSJ0vkouvQPVEQzLfI6KfVnCwkQ/NuSA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB4565.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(451199015)(5660300002)(7416002)(186003)(110136005)(6512007)(26005)(8936002)(54906003)(478600001)(71200400001)(38070700005)(86362001)(316002)(41300700001)(2906002)(107886003)(6486002)(38100700002)(6506007)(36756003)(8676002)(122000001)(66476007)(66446008)(66556008)(64756008)(66946007)(85182001)(2616005)(76116006)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bE5HUWw3RnBuZ3BGNGNoeEQveWhYK2pxUHVRV0pzQXVaV29LeHpveFliQWF3?=
 =?utf-8?B?enNJaGR0cFRTTnBmVXMyNGxPRmhaTi81eU90Q1kzL0dQb3FGUDBiMXovV2d1?=
 =?utf-8?B?cXVyMmJpOEh0S2pER1F3S1F1N2tiNVovRlk2dU13UjVyMDA5T3IzOWREb0pX?=
 =?utf-8?B?UUsxLzVab2NiQUQ5NEcwUkVmOWtlT2xzcmkwOXlSbDdxYUNLT2tpRU5KK3Zy?=
 =?utf-8?B?bEZpTmNsclpZSlo0OTloTVRRZG5oUjNKLzFWem9EekpDenFyOWZyOWNBSGJs?=
 =?utf-8?B?NXg1QklhemsvTkx0L0k3b0dHK3Bmc1pFdUtqUVpIZUxsUG5NclcyQ0xnRnBi?=
 =?utf-8?B?djBQTzBRVG1ZaURsWksvWU96K0tHL2g5R2tzdXJlZXh3TkpxaTVjSEZyd0Rh?=
 =?utf-8?B?anNIMVl0RlNxellYc1NRUEZkUXZiYlhhWmRYN0ZUbUJqeFBBM21Yc1RSTWZO?=
 =?utf-8?B?UkQzOGMyUHkza3ZKL0pzdzh4bVFtaFk3d2pmdnVvOVMyaWliZ2xVd0JwdUlp?=
 =?utf-8?B?WUVrdElLaVZZbGwrOHcyWFlFdWJWQ0RuWmdKL05zNmdvZGtDSUdlM3UxSGc2?=
 =?utf-8?B?YlFTaGU2REY4Z3BNdWYweDVISlFHS1RFRVpTM0lFS1YrMndyN2dRTks0cE1U?=
 =?utf-8?B?WFZGREdXNklHVS9KMjJZeUpCZU05ZmV4K1Y2WHZzRHN2REQ0SWlRUzBqazRV?=
 =?utf-8?B?a0tHcFdZdWpYYXBZUDd1TUc0aWRyVFV6d2RlenhwM3dYb09nYzV1OTZ3c0Q2?=
 =?utf-8?B?d2JtZ0VGblk1UU5pUldWNGlFcHJsR0hzN2ZjTWVTcFhVbnZUYisyVzlQOUxZ?=
 =?utf-8?B?UkNiQUlDOTMxeFd6MVYxdGpURDZ1cXgvZ0xybmRROThRK0tPWGxGV2lhOHZN?=
 =?utf-8?B?OXZFL0xLSTVlZ1MwS1hjUzdKeXNCOXBxeGU5dnFtUnVTUjBBeERGckU0OVVN?=
 =?utf-8?B?Z3V1bmR0bzdiSGZjckJKTG1ZTENEaWxRbi9GeFovTlZRVU92MWphSmVpNXpW?=
 =?utf-8?B?Mm9KZ2VwWk41V3F1am1SNnBybkRReXc3OVB5QmRvUDhzMzVVN3QxK2VNdnVp?=
 =?utf-8?B?bFozOXFKNjZRRjlZbDI3U2ZhMkJoZTBBM0RGeXZmZDhhWUNCbDdvNXA4ZXQy?=
 =?utf-8?B?SVo2REd3c0lHNUhSZXp1SUpraUpzNSt6MnBpR1F0cDJMUllVTUQxM01EWGZN?=
 =?utf-8?B?cjFyeFN1K0l5QjRweDV5VGZvTmNHYm1hT0JnN0hlbTZyTXg3NnAyMGIrSlRD?=
 =?utf-8?B?N0FGNWtIVjlMbkhObExwUlBrTlhJVmNoRUlCazRRbzFzdlYwcGdHQTRYZmYx?=
 =?utf-8?B?VlkvVEtpVlR1aWdqS3FTWUdRL3QveUpjUGR4UUJ0cUJRakdXbUV1N3ljZHQ0?=
 =?utf-8?B?TFhuUThCR2JJUU9ZNTZZWEIwYmQxNGpwVTJXQ0tUcXBaM0x5aHpHUTFqbVo5?=
 =?utf-8?B?QzJIU3h3U2REZG02bVF1U0xqMHp2cHpWUjJ0eUg4cXExV1BJVmI3U2hnNDBY?=
 =?utf-8?B?V1NOTFRDK2c4Q25GRE03YjZ1aEltdUlqMVlVYzJ3V2RYaUJXZnl0YmhUbHVp?=
 =?utf-8?B?cXFIeU53emhCM0ViRUFaUHcvT29sZ2RoTnBGNm1qeStiSVBRVXBabUwwaStq?=
 =?utf-8?B?MzI0Q0tuR2NpcG0wZkZ2cy9PT25DbFc2c2h3QW1kRXVPT3BJbFlvckNxZzVO?=
 =?utf-8?B?LzBzcS96RXVuWWkrUTdzTzBoRHJ6ejB4RWJXUlFUMWFCUExrOU0zd1dueGIy?=
 =?utf-8?B?NEt2THc5enJDSEFvVkNsZlV5ckRaa2QrTFZ4VXQzSytCMTlqSjllclNSNGZ4?=
 =?utf-8?B?MENuelA5Z2dFS3EySERJejkwak9QTDZLK0piNllnL0ZJK2RpbnpNN3lQSDVE?=
 =?utf-8?B?MmJXZFU0cGxjc2t2VmU3aEVRZHNUK21rVWlzcGh3TDJ6ZFRtWnRObHlFSUdM?=
 =?utf-8?B?V0tHc0s2UlZlYWRrb3BwQUNYM1NiQW0zYThJdTVETmZ5ZzE2dXozZHdaSk5l?=
 =?utf-8?B?Y3R1WjdDM2VZdDJKbHl0U0c4NVo3d3JsZHpIQUY0ZEtTZU91WWh1Q0VQZ3ZM?=
 =?utf-8?B?aDMvVDUrdmFGQno1L0dNNFdjUTN3bzRFUitLd1gzSmtTeDZvSFJJQUcrL0RR?=
 =?utf-8?B?ZFNLRC9SK1JIVVFxeDV6aS9oejNuT0RUZTdxL3NJbENwR3ZaWUtqUzQwRXIy?=
 =?utf-8?Q?CevJ62yxtUPQtP6GcLmAXtk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <83F5F72ABE20C74BAED4067445A0F728@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB4565.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bc39a1c-9049-41bc-34de-08dad768e7ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2022 09:04:39.5022
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2cl6HOe5+4m3JeZdChXrJbyDXTKX1kbfZ2PVrf6hlbaqfB/f5246F5VhB9WUg6myqaQuTPtqyDO0fBfbdAava5xYX39f4M61DyDPQDnOR4Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR03MB6159
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5nZWxvLA0KDQpPbiBNb24sIDIwMjItMTItMDUgYXQgMTU6MjEgKzAxMDAsIEFuZ2Vsb0dp
b2FjY2hpbm8gRGVsIFJlZ25vIHdyb3RlOg0KPiBJbCAwNS8xMi8yMiAwNzo1NywgWGlhbmdzaGVu
ZyBIb3UgaGEgc2NyaXR0bzoNCj4gPiBBZGQgRUNDIHN1cHBvcnQgZm90IE1UNzk4NiBJQy4NCj4g
PiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBYaWFuZ3NoZW5nIEhvdSA8eGlhbmdzaGVuZy5ob3VAbWVk
aWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVycy9tdGQvbmFuZC9lY2MtbXRrLmMgfCAx
OCArKysrKysrKysrKysrKysrKysNCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAxOCBpbnNlcnRpb25z
KCspDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbXRkL25hbmQvZWNjLW10ay5jIGIv
ZHJpdmVycy9tdGQvbmFuZC9lY2MtDQo+ID4gbXRrLmMNCj4gPiBpbmRleCA5ZjliMjAxZmU3MDYu
LmMyZjZjZmE3NmEwNCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL210ZC9uYW5kL2VjYy1tdGsu
Yw0KPiA+ICsrKyBiL2RyaXZlcnMvbXRkL25hbmQvZWNjLW10ay5jDQo+ID4gQEAgLTc5LDYgKzc5
LDEwIEBAIHN0YXRpYyBjb25zdCB1OCBlY2Nfc3RyZW5ndGhfbXQ3NjIyW10gPSB7DQo+ID4gICAJ
NCwgNiwgOCwgMTAsIDEyDQo+ID4gICB9Ow0KPiA+ICAgDQo+ID4gK3N0YXRpYyBjb25zdCB1OCBl
Y2Nfc3RyZW5ndGhfbXQ3OTg2W10gPSB7DQo+ID4gKwk0LCA2LCA4LCAxMCwgMTIsIDE0LCAxNiwg
MTgsIDIwLCAyMiwgMjQNCj4gPiArfTsNCj4gPiArDQo+ID4gICBlbnVtIG10a19lY2NfcmVncyB7
DQo+ID4gICAJRUNDX0VOQ1BBUjAwLA0KPiA+ICAgCUVDQ19FTkNJUlFfRU4sDQo+ID4gQEAgLTQ4
Myw2ICs0ODcsMTcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfZWNjX2NhcHMNCj4gPiBtdGtf
ZWNjX2NhcHNfbXQ3NjIyID0gew0KPiA+ICAgCS5wZ19pcnFfc2VsID0gMCwNCj4gPiAgIH07DQo+
ID4gICANCj4gPiArc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfZWNjX2NhcHMgbXRrX2VjY19jYXBz
X210Nzk4NiA9IHsNCj4gPiArCS5lcnJfbWFzayA9IDB4MWYsDQo+IA0KPiBDYW4ndCB3ZSB1c2Ug
R0VOTUFTSygpIHRvIGRlZmluZSBlcnJfbWFzayBpbnN0ZWFkPw0KPiANCj4gI2RlZmluZSBNVDc5
ODZfRVJSTlVNCUdFTk1BU0soNCwgMCkNCj4gDQo+IFAuUy46IERpZCBJIGdldCB0aGF0IHJpZ2h0
PyBJcyB0aGF0IHJlZmVycmVkIHRvIHRoZSBFUlJOVU0oeCkgYml0cw0KDQpZZXMsIHlvdSBhcmUg
cmlnaHQuDQpJIHdpbGwgY2hhbmdlIGxpa2UNCiNkZWZpbmUgRUNDX0VSUk1BU0soeCkgR0VOTUFT
Syh4LCAwKSwNCnNpbmNlIG90aGVyIElDIGRyaXZlciBkYXRhIHdpbGwgdXNlIDB4M2YgYW5kIDB4
N2YgZXJyX21hc2suDQoNCg0KVGhhbmtzDQpYaWFuZ3NoZW5nIEhvdQ0K
