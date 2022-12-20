Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 999ED651899
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 02:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232767AbiLTB7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 20:59:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231987AbiLTB7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 20:59:46 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4532526F2;
        Mon, 19 Dec 2022 17:59:40 -0800 (PST)
X-UUID: 2c3c767a8ed84c4a847cceb957ed6be3-20221220
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=Rxq5GbgXkwqoTxsnfUluTCBpYdkufBZKnqiG84oXhOA=;
        b=EbzrGyXEXpdjgFRH31FolXaUnhiOjJP5DtqVYKqsmNbuDHpHhs18WAzYXGFHeCYiZm3THHvWbyuB3s41az7/TgVEgmwXnQb2xTxHtiE9IjqAlX/56AsD3c+X/ZJ4A573z42SlpM38KiQIaG87bi3yaVOQ5wZ19tIOyBc9v2cCxg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:2da35630-b176-4ee3-8e30-201ad18cdb9b,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:22,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:22
X-CID-INFO: VERSION:1.1.14,REQID:2da35630-b176-4ee3-8e30-201ad18cdb9b,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:22,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:22
X-CID-META: VersionHash:dcaaed0,CLOUDID:e04862f3-ff42-4fb0-b929-626456a83c14,B
        ulkID:221219233844PTTB111N,BulkQuantity:9,Recheck:0,SF:28|100|17|19|48|101
        |102,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,
        COL:0
X-UUID: 2c3c767a8ed84c4a847cceb957ed6be3-20221220
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <xiangsheng.hou@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1576411882; Tue, 20 Dec 2022 09:59:34 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 20 Dec 2022 09:59:32 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Tue, 20 Dec 2022 09:59:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=feGf5eY/2cP2U+qpucr4Q025DXfXl6ludv1J830/Fwn4nhaOJDmAKNFRWCwcMDp8FN65hAvLiMcnx4QyOxeFTxWv4jHTdm+CZySBnhj/11momBvyu+Fm7gWNVH42XuHUR/6VYHREng88fhWDIq7eqJScBy4TspGnA9ija4s5T+yuyt71gyIyyX0bVZR7hHH2wf7g8WN3dEFrHmZ3ExA6UXVIYLdxA2T3ylPP4KONY97hDlr0EyxxrvMm20sdEWahAEBP4ngS4BKWyT6MdzNSXYkMaJmEb7xXFA/Cki0xiirTJlwRu4/yeA7Ci+Wch3JOfLBkDsRecn9LSwcrqztAaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rxq5GbgXkwqoTxsnfUluTCBpYdkufBZKnqiG84oXhOA=;
 b=bUWA+Smm/OpL/f33zTdOx9afD+J/XNCFp9luNg2GmTzCw5nrQz+jvFq66omm9IOIRHDJXaDxDZNMPsLLRI0nhCBFV+rw9/Mfm3E3jr7/sjlvfX6H6SPOeODdLdhPdql1ZgKfyfvZE7IxNULegNRbtSN4sf+VbEoo024c3lTmUXNIcXI5qCgOgtI74qQUMeiF9fugrJB0I9HwiWiLeTkpu28vhgkKY0cnQMguASJt1jF7K2bpdAYYEXRUUz8Hb6gbyz23hXXh+i8yrq8/1/h94hE6g7BW4HYeas4fP2KDFUYZLYxbBG+Op8ggQsfyUTfEmlwBh81C+KX39Ke3E1nUfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rxq5GbgXkwqoTxsnfUluTCBpYdkufBZKnqiG84oXhOA=;
 b=LDSJH/VYuiV1ePtkxAb5KrB2wzdNxYQaLUmkmSvvS9FLWC17XLhT7Ugige9ga3w/lvYJkcKKJXNDSoT3md0J+iRh8UeAhC5Z883/m9hnqjDCypmQKigGKJBcuC0dTA50zYVM5mx0PT2GfgqKGX0X6xKf6LhlbVdKAi0DyeRCXuQ=
Received: from SG2PR03MB4565.apcprd03.prod.outlook.com (2603:1096:4:84::10) by
 TYZPR03MB6766.apcprd03.prod.outlook.com (2603:1096:400:202::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Tue, 20 Dec
 2022 01:59:31 +0000
Received: from SG2PR03MB4565.apcprd03.prod.outlook.com
 ([fe80::3d3b:d288:88e3:59c7]) by SG2PR03MB4565.apcprd03.prod.outlook.com
 ([fe80::3d3b:d288:88e3:59c7%6]) with mapi id 15.20.5924.016; Tue, 20 Dec 2022
 01:59:31 +0000
From:   =?utf-8?B?WGlhbmdzaGVuZyBIb3UgKOS+r+elpeiDnCk=?= 
        <Xiangsheng.Hou@mediatek.com>
To:     "robh@kernel.org" <robh@kernel.org>
CC:     "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?QmVubGlhbmcgWmhhbyAo6LW15pys5LquKQ==?= 
        <Benliang.Zhao@mediatek.com>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        =?utf-8?B?QmluIFpoYW5nICjnq6Dmlowp?= <bin.zhang@mediatek.com>,
        "gch981213@gmail.com" <gch981213@gmail.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "richard@nod.at" <richard@nod.at>
Subject: Re: [PATCH v5 06/10] dt-bindings: spi: mtk-snfi: Add read latch
 latency property
Thread-Topic: [PATCH v5 06/10] dt-bindings: spi: mtk-snfi: Add read latch
 latency property
Thread-Index: AQHZE1NlW1LZ/Cebdk+J+RhG49Nd1a51WUWAgACteQA=
Date:   Tue, 20 Dec 2022 01:59:31 +0000
Message-ID: <9ec0b502a15bfe5717a5659b3c597b6dd6f0b629.camel@mediatek.com>
References: <20221219024019.31974-1-xiangsheng.hou@mediatek.com>
         <20221219024019.31974-7-xiangsheng.hou@mediatek.com>
         <20221219153837.GA1426412-robh@kernel.org>
In-Reply-To: <20221219153837.GA1426412-robh@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR03MB4565:EE_|TYZPR03MB6766:EE_
x-ms-office365-filtering-correlation-id: 645d9a69-608f-4e3f-f06c-08dae22dd5ac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PB0qkL0VlOiNaf++ew3UVf9OuT+nMgjSAe+VfXvrXX00vW8msnVAY+IFE1rIoinXyl4Irv0UNN++P4E3XsaUOwjUFeSMzp31H8Q+eSLDl3ONPvNtK0WvfoixHAqIQpkKrBwCc5VvOUJ5VAEt9Qt0SGUcjStYJsgWQ8cV8n3p6aRZhgf0MWDhU7j3S/W0MCNJqIJwWxwi1xKhaiKgjY/ZktIfathmlSFN3qzCq0hyghz+rybpCgxj9B0nDU+KgaQfjg5ORIBw/lTDvLptvs3biabSO+7EGfkVORR4Y4OxJMeXr3U8cLKTyn32CPI+RwxJ19KN4JvVyFSCB9/GISYh8Wn6CCzmq8NnypnN8h5KwcKilzGjEDSxDGP+esEwFDVGShNFWTLLxRjxfrZK0Wzq4zVpUaPxSReFwYDahY1aptdTAIVOUhX/RdYfdQWV8A9HQtrezLtvMMLI9k5kBbv59LvY9m1ZpU1dwsEDhMVfcKhPAgZRDamQQypn4nsT1wogK3JzWz4pdUhVy22YgfDchj47G17NW5YoC8wEkid8o7/WQY0qiOEYG8QcIaEMSYCaMNss+TfnhjrcDcBA3VpqgTG1O9sKhFVY+2nT2zhfplwsruuYss2YEwdbIUIMA1TpvIc8miYo4PA+1pZByCAySejjpfKAzAPafe4fJt6fsZxoeLXUPV0K0G37NhDGAUzmipGUWTzYelR3vYMvn1NqRA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB4565.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(376002)(366004)(346002)(136003)(451199015)(478600001)(6486002)(6506007)(26005)(6512007)(186003)(4326008)(66946007)(316002)(66476007)(66446008)(91956017)(66556008)(8676002)(6916009)(54906003)(76116006)(71200400001)(64756008)(122000001)(38100700002)(2616005)(41300700001)(2906002)(4001150100001)(7416002)(8936002)(5660300002)(85182001)(86362001)(36756003)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZjVjWVZTSVM2YzdGejloMTc3aGR1RjdIanA4d0I1d0lORW16MGIxMWNXVzdW?=
 =?utf-8?B?cTcxbzB4Ym9Fc3BPZnl3NE1ieVdzWXpNRENUMlFQYzJPM1hid0x1N3R1UVJI?=
 =?utf-8?B?azlzaXFsUjZVeXYxS3B4UVk0cFBqc0FWVmorbzU4aDdPcHRCd1FvRTVZNkRQ?=
 =?utf-8?B?Y2xVNkowSVFQZ3h4b2syNjVxWVdkRXc2SktKWHdrUHoyWWZWV2tDOTVqOVIz?=
 =?utf-8?B?RmNOVlNKNjlIZU9SY3BudzJrS3JnYmgyK2ZLaFBzQ2pvdzB6cU91NFJUdUNW?=
 =?utf-8?B?QVpWdjcxKzBkc0RBM2tsa2g1Y0R4WUtadCsrMSthK0ZkMXZ6RnVYakJKUG44?=
 =?utf-8?B?REFSU09nU3B0amV3aEc3Q0hESEN1bHVyVmgzQlNTWXhxYUtSem0yOEJtdXdX?=
 =?utf-8?B?S0dBay9HcHRmQ0dkSG9KcGJaTjlvUU9sd3VFNDZyY0NRRGxkR0xwRlVrVUQ3?=
 =?utf-8?B?aXNzZGcybHgvTVc3VGc3a2haYmQ5WWZiN3ZaUmY3ZWFIZjdBZXROb2FqZkF1?=
 =?utf-8?B?eTdHYWlYOUMrWERWZjJFb3NNdDRjOHVlRXlCQTk4QU9lUE9mQTBmVm5HS0Fo?=
 =?utf-8?B?Mk1OdEo1Z3hrbzNPMHZDQTlGbkdMK1NKMTUwSlpsNGZLRm1CY2ZrU1pmS0Jx?=
 =?utf-8?B?S3ZIVkVxc2p6Y1kwQVRFSzl3RkdZOGRZRE02NG1lUDNuTk1wbSt4eUVLV0ZE?=
 =?utf-8?B?NyszU29nc1pHNUdUU1RGd1dFemJOYmJrMTdITDNYMFFqUEp3alVPNjZQaDNK?=
 =?utf-8?B?cFRwMVFsY1pYN0gwUkdkUDFZQzc0c05FRU5HVHJudndOUzFzbm1qSk5Odndl?=
 =?utf-8?B?Sm4ySi9QcUhaaTUzL05UZXl5ejY3ZDk3STdJSDU4ZTdRdDVtM0JUMlk4RXV4?=
 =?utf-8?B?OTNpVHdYR2lwZTR4S2FXLzZVcXpiVFFSK2hndTkzNStnaFZkNVdGMGxQV2Fq?=
 =?utf-8?B?UWxzaXdRbzVobGx3aXpybllrUHh2dVYvT25adDJselVPbjJHZldqU1dOeUVC?=
 =?utf-8?B?UDFuZnNidkxrbmtBeVFQTWlLRXBCdFBZRjBTSExhV0Z3MVNCNnM2Uk1rdDk5?=
 =?utf-8?B?VGJUcEduNG54ZTF5ejFMa1hLdXFIQWJEOVBoclcwZFU5RHlXb1NpVjRXU2c3?=
 =?utf-8?B?NFZZdVpabXdXWGR2Nldqb054L1NwdG5MLytwUXhJaE1UdUE3b3Ftb0pqRFhn?=
 =?utf-8?B?Y2tONkM3ZXg1RndpT2FLM0k0dVZTN0R4SGpsekNSRzVHRStuT0d3TVdIMGMy?=
 =?utf-8?B?QUw2dHZyb3I4bnpXd3h3ZkFyaVZMaDJUVGplYXB6ZG9LYUE5SXNsUDVleVJK?=
 =?utf-8?B?eXRtL3c2Qnp4a05YU3ZkV2lJdGdhV0laRTNRQm85MHpSazkwRmluSG54MndU?=
 =?utf-8?B?Njl4UlRDZmhWanl6QzZrQWtzVnFlbkxvQlF3VTlPcEhCa3J4U2RwdG91NVgr?=
 =?utf-8?B?YnhZRnFCTTlZT2lBTytrRFZQOGJYNkFjdXhVaTZ0MDhUTzlVWlVmT1VwVmVM?=
 =?utf-8?B?YlloY2hvVGcrc2xQQ1dsa2U1R1JjVE9XZnFMRklZZUVod2J4SUJPbS9Fb3dz?=
 =?utf-8?B?dlJzMXhLeWhVTlNKalpMMTh0WWVPOWpjTm1hTUJZTWFRMHlNZ0E3NytqZG52?=
 =?utf-8?B?ZjdlWEhYWHNlOUdDUGFUTU1qVEYwZ3l1YTFsdWM3ZFBLM1pHT1QvRU1QSzVk?=
 =?utf-8?B?bCtmOVcwYXdHMWd1bGFVb0JEc0s3TUNmbC9KYnMxaHJiYWxLQkZERlJpMlow?=
 =?utf-8?B?b3BSZ0RvV3JEWFN5WCtnTXZZdjU3N2pJK3RxS0wvdkRjTWFNclNBek1Jb2x1?=
 =?utf-8?B?L1huYnY2MTF1YjExMG41Y01GbDZIOGE4K1ZFMHpnZXNJRXgvZzQrcVNMUHJz?=
 =?utf-8?B?cGVJcGtMNk1kekcxYytwSmRSL0Z1REdOUnl4U29aNEZvbXN3ZmVsWjRuUWZE?=
 =?utf-8?B?M2hpalIyTzZ3ZDAzMjBPK0NOeEU1RWJYS3JoaHZ0eS9VaVFwNTFkMGs0dlpY?=
 =?utf-8?B?WXVyWnhrM3U0a1FjVTNZWGUyMTZ3Y3Vra081cGtwc2RQS25GZ3Zvbjh2SEla?=
 =?utf-8?B?UEZEc292MlhCcnNQSnRrczU5cStjWVFjd2gxZU5GZWJCL2VVd1RGc1pHNjZQ?=
 =?utf-8?B?M3lGSEhNaUo1YlV6djBlUGlzKzZoZnhHRHlFM255WXB4Rm9aOTBKUTNmSzRl?=
 =?utf-8?Q?O0iDlNbvwaeLE0cMgcIWz74=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <21B9D70D938D13438A8137B012F905C1@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB4565.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 645d9a69-608f-4e3f-f06c-08dae22dd5ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2022 01:59:31.2007
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kHSp5yxP/8U4VWLNcF/o9irI/IKN/UxbkRAMpSymVwi7n/Uvm255ClIKePpPEUNPL8xFjYCMifkQmHwLXmqi+5KvZ42LXE+Bjl2KUtKAQFA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB6766
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUm9iLA0KDQpPbiBNb24sIDIwMjItMTItMTkgYXQgMDk6MzggLTA2MDAsIFJvYiBIZXJyaW5n
IHdyb3RlOg0KPiBPbiBNb24sIERlYyAxOSwgMjAyMiBhdCAxMDo0MDoxNUFNICswODAwLCBYaWFu
Z3NoZW5nIEhvdSB3cm90ZToNCj4gPiBBZGQgbWVkaWF0ZWsscngtbGF0Y2gtbGF0ZW5jeS1ucyBw
cm9wZXJ0eSB3aGljaCBhZGp1c3QgZGF0YSByZWFkDQo+ID4gbGF0Y2ggbGF0ZW5jeSBpbiB0aGUg
dW5pdCBvZiBuYW5vc2Vjb25kcy4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBYaWFuZ3NoZW5n
IEhvdSA8eGlhbmdzaGVuZy5ob3VAbWVkaWF0ZWsuY29tPg0KPiA+IEFja2VkLWJ5OiBLcnp5c3p0
b2YgS296bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmc+DQo+ID4gUmV2aWV3
ZWQtYnk6IEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vIDwNCj4gPiBhbmdlbG9naW9hY2NoaW5v
LmRlbHJlZ25vQGNvbGxhYm9yYS5jb20+DQo+ID4gLS0tDQo+ID4gIC4uLi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL3NwaS9tZWRpYXRlayxzcGktbXRrLXNuZmkueWFtbCAgICAgICAgIHwgMw0KPiA+ICsr
Kw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspDQo+ID4gDQo+ID4gZGlmZiAt
LWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zcGkvbWVkaWF0ZWssc3Bp
LQ0KPiA+IG10ay1zbmZpLnlhbWwgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
c3BpL21lZGlhdGVrLHNwaS0NCj4gPiBtdGstc25maS55YW1sDQo+ID4gaW5kZXggYmFiMjNmMWIx
MWZkLi4xZTVlODlhNjkzYzMgMTAwNjQ0DQo+ID4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL3NwaS9tZWRpYXRlayxzcGktbXRrLQ0KPiA+IHNuZmkueWFtbA0KPiA+ICsr
KyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zcGkvbWVkaWF0ZWssc3BpLW10
ay0NCj4gPiBzbmZpLnlhbWwNCj4gPiBAQCAtNDUsNiArNDUsOSBAQCBwcm9wZXJ0aWVzOg0KPiA+
ICAgICAgZGVzY3JpcHRpb246IGRldmljZS10cmVlIG5vZGUgb2YgdGhlIGFjY29tcGFueWluZyBF
Q0MgZW5naW5lLg0KPiA+ICAgICAgJHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlv
bnMvcGhhbmRsZQ0KPiA+ICANCj4gPiArICBtZWRpYXRlayxyeC1sYXRjaC1sYXRlbmN5LW5zOg0K
PiA+ICsgICAgZGVzY3JpcHRpb246IERhdGEgcmVhZCBsYXRjaCBsYXRlbmN5LCB1bml0IGlzIG5h
bm9zZWNvbmRzLg0KPiANCj4gRG9lc24ndCB0aGUgY29tbW9uICdyeC1zYW1wbGUtZGVsYXktbnMn
IHdvcmsgZm9yIHlvdT8NCg0KVGhlIGRyaXZlciBuZWVkIHR3byB0aW1pbmcgcmVsYXRlZCBwYXJh
bWV0ZXIsIG9uZSBmb3Igc2FtcGxlIGRlbGF5DQp3aGljaCBoYXZlIGJlZW4gdXNlZCBieSByeC1z
YW1wbGUtZGVsYXktbnMuIEFub3RoZXIgaXMgcmVhZCBsYXRlbmN5LA0KanVzdCBpbnRyb2R1Y2Ug
dGhpcyBwcml2YXRlIHRpbWluZyBwcm9wZXJ0eSBzaW5jZSB0aGUgY29tbW9uIHNwaS1yeC0NCmRl
bGF5LXVzIGlzIG1pY3Jvc2Vjb25kIGluIHVuaXQuDQoNClRoYW5rcw0KWElhbmdzaGVuZyBIb3UN
Cg==
