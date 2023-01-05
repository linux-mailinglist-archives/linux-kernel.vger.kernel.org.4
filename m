Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7389065EA16
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 12:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbjAELmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 06:42:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbjAELmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 06:42:35 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CCCC5275B;
        Thu,  5 Jan 2023 03:42:29 -0800 (PST)
X-UUID: 7f7d7b42849a42b98ad6cdb60b9144e8-20230105
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=y7FiNjQPvBZWDMquvAACZH+FZUvH1HZr570pOOB5MWg=;
        b=f/p8PuS5iqsYjzZQQzIYyKUHs58vVNGreuGbfANkXPRma/pkKs4rpb/xsuwPSsv8G+v0q3MPX4+xWMyo+/KN0fZs0T4161lwsxKpsxz8L4hueC09Y7a2DFqO4KAplMuYo4YHi8WCFiZMUIqeaSkyB4MGN3O3VMPgx8w6LOt3CRc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.17,REQID:3c1b7d8d-420e-41bd-b6da-4dadcf184bb6,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:543e81c,CLOUDID:59e0e8f4-ff42-4fb0-b929-626456a83c14,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
X-CID-BVR: 0
X-UUID: 7f7d7b42849a42b98ad6cdb60b9144e8-20230105
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
        (envelope-from <xiangsheng.hou@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 76706732; Thu, 05 Jan 2023 19:42:21 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 5 Jan 2023 19:42:20 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 5 Jan 2023 19:42:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HIGvVxq/2E90ihpLu+MsLuGVGrmXLPSbTrztzv2Avnzg4fNtnN/3y8DqgOwVLFrAuY8Czfb4B4+EjRYa+XSpk+6KUvjtBOon3pfuzLK4FeEq+8QxRZTfoq3zj/oewV8iEiewIkdqCVQxxjLGe9rlR2tgRSM99rxio+w29+XVT/4veEoZSIJCiRVAOhE4yVepNJj8ODUHiefRvjz7QeHO7G3RTz0R9npSLdOcgfAKDYFQzK8OFz2pVKeG2z/XTI1ry5QHpMw+H10CWL902sMYbUCdyyoQ1+syjvCZQoi266lOdtLAUX4ApjPxgwXR1vOEHTN4Ip6youbom8Lsh3coKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y7FiNjQPvBZWDMquvAACZH+FZUvH1HZr570pOOB5MWg=;
 b=mg9yWQlhiDUlaGU6/SHO3Zfgx/sKNjyvddRuS1gRAnFKiCyvDvRgh/+EutkCUY2S7u10TGuKZNz7i2xgTJraiewnlitBaZcABO0F+NCfg0DVlKf0bbuOIT4HjxJ74suDd25xd7MFdOfdxYRfTXlcB8NqishesQ7Nv6XycuzmNa5GprQI0jIGuwbI77Z8bQd9MFd+Nu8FGYt8MGlBEL/xPKm6E95UqeCbE392kFR2r7xOrEAJnPmri2OTWDU6yOdNnJV7Myw6pDrM07oLoz94Cmn7ILYZZ16Sw9fEVMyoH2Hmy527I5F+jrAwoE8oM3z0LOBA0XR3HptvenmUiV/Lug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y7FiNjQPvBZWDMquvAACZH+FZUvH1HZr570pOOB5MWg=;
 b=XSDxq4lqJzBk+ariKeDMlb2NjzP/o69Z8ssZSPVcphYvdMMLE8IZI8ht+ks2I7TiHSVLiIdJG9RTdXcv1CL/NPrYUTWuaiqJRi7jhf4//qzAy1L/VTdb/0eKvXd7l8f4hvpYACsrauG7vk6x8j3hl1Q3tw1RjKu/OU3zEksmc7Q=
Received: from SG2PR03MB4565.apcprd03.prod.outlook.com (2603:1096:4:84::10) by
 SG2PR03MB6502.apcprd03.prod.outlook.com (2603:1096:4:1c6::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5944.19; Thu, 5 Jan 2023 11:42:18 +0000
Received: from SG2PR03MB4565.apcprd03.prod.outlook.com
 ([fe80::e708:8bc4:ed9d:4037]) by SG2PR03MB4565.apcprd03.prod.outlook.com
 ([fe80::e708:8bc4:ed9d:4037%3]) with mapi id 15.20.5944.019; Thu, 5 Jan 2023
 11:42:18 +0000
From:   =?utf-8?B?WGlhbmdzaGVuZyBIb3UgKOS+r+elpeiDnCk=?= 
        <Xiangsheng.Hou@mediatek.com>
To:     "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "mbrugger@suse.com" <mbrugger@suse.com>,
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
Subject: Re: [PATCH v5 01/10] spi: mtk-snfi: Change default page format to
 setup default setting
Thread-Topic: [PATCH v5 01/10] spi: mtk-snfi: Change default page format to
 setup default setting
Thread-Index: AQHZE1NHYiEe8abswEW4177v2fHgHq51VwMAgAC0FACAGcPIgA==
Date:   Thu, 5 Jan 2023 11:42:18 +0000
Message-ID: <9dc8560088529c8599406a2d7c6f1f2c8e771c47.camel@mediatek.com>
References: <20221219024019.31974-1-xiangsheng.hou@mediatek.com>
         <20221219024019.31974-2-xiangsheng.hou@mediatek.com>
         <5ebaf98b-a77e-3c5a-3e08-bbb0119558a2@gmail.com>
         <b9295291171dad0a455928cdb44a8ca91782532d.camel@mediatek.com>
In-Reply-To: <b9295291171dad0a455928cdb44a8ca91782532d.camel@mediatek.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR03MB4565:EE_|SG2PR03MB6502:EE_
x-ms-office365-filtering-correlation-id: ed6aba5c-716a-4cc8-54e8-08daef11e66d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CQUYyvvHea1ioVeaUrnA+LKHDjR/FLyiawU47PrQPvo0T/L51K+1NhSK143EgabVeRUtjjUQ3vv8lD+0lTukskrQ9fyeD0es1veJXMdqoLMw32uRF5JBBnOf0wrGgNFPrQkQl3Bwdz4rZmF7nswAYwUQfEaIDAbGub50tcX/Qmtu6ORVkoKYYcGsKDf6qONo1a3oR05DGfdiceGQiIEE8LhnIwZ+2mK1JU5xcZNCbEcZAxbL1ELJCeZHiGnY0jLi74eWoCLLk8/DZR5M3DWUIqYbQCtN+hW/Z3eIKXU4S7r8XLJAYO8LTU98kS37edlOtrfxKp8JWEr9WIV0vboCyPNGOPjTJKehn426MCDaIyPaWN7dszP6PD2qWTKzaS/Kw6URkm9IiJPKlgx5mAe7Ut+hYyV6UwNxRt2npLbfV7s9yd6guhwczcxVvvaNOiOGPjDjxrOQd5OmrgTmthMMdUWnXtE4ieL6+IIgFTNzxAM0La+YWaBM7IBFBIQBISJGG16bMB2fXOn9RsrzpWHzBDhqulVyKXDLZ3HW5eJJrUcdWJlsxhaG/LUdhrQcHsmGlW5HtH+mIqRlv0b4Jmtd34g5hw0N3VMBW8TmVCc8xwxoB9LjVlZ1N+KuLSP4z2lKMXCtAezfIukCsmR6yb/y0B5z/nipu5v8L6LhH3s2HGa4E2q5UQtVWlxfJP0Amva8v57iqF+F8+is7ZrL6m6Ijw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB4565.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(366004)(136003)(346002)(39860400002)(451199015)(6512007)(54906003)(122000001)(53546011)(316002)(107886003)(71200400001)(186003)(110136005)(26005)(478600001)(66556008)(66476007)(8676002)(66446008)(64756008)(76116006)(66946007)(4326008)(2616005)(6486002)(6506007)(91956017)(41300700001)(5660300002)(7416002)(4001150100001)(8936002)(83380400001)(2906002)(36756003)(85182001)(38100700002)(38070700005)(86362001)(921005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QmZsYUNSNi9SdGx2TEFzZmdoNGpnbStEQm12dWl5dGNxRGxhdGdoWlVVdUI1?=
 =?utf-8?B?blVyb1VWR01rRFdTODNKZkUxR2xaK1NLL2hVU3hJZnRJSEk2bXdJL3pBSmYw?=
 =?utf-8?B?aFpudktNeDl6eU5CKzhyMlhrYUpQMGp3a0tTeXNiWDhDSURTRG9JdUcrUmRF?=
 =?utf-8?B?VlMreHNSVjgyaG4zQWg5UW0yaWNBQjFUSVZVMWlXeVdqbXJUcEV1cmpsd0Uw?=
 =?utf-8?B?M1o4Sm5WdXJHYXdBbmdXTkNraFVRSzVVa2oxM0xvcnl2RmNlVVpSY015ZDUy?=
 =?utf-8?B?a1pXSVlBYkRmREViR0xVVEZtTlFCNTEyQVJJY3VOaE1aQ25pcHZycUVHdWdT?=
 =?utf-8?B?S0RTQ3ZNSXhpaEl2dVF4ZFV1RW4xTWowdVkxNFlncTBVbTArcXdXRjdobnh5?=
 =?utf-8?B?NytMeitqSGtYVitjY1ZxMFM3eStRaXpzZG43NUhINkF5RFNhMHhpSHZZQ01Y?=
 =?utf-8?B?NFBIWHJkVGs1aG9laXMyY0xUZ2xnY1pVYm5ib0xRVkEvT3dCMGFCRkdHRzJz?=
 =?utf-8?B?MmNaaHZrVUN4LzNkR01MOXNVUFRaTXJIeFlsNVB6VkNzb1hpNThOY205Zm9X?=
 =?utf-8?B?L1pWeHNmVWZ0TDc3c3ArR3RIMEJraWNNdmNaenhCcnFYeHQ0VW5XSnRsU3NQ?=
 =?utf-8?B?WkY3a2tSSEpBZWRMSHBwdU9SanZKZEg1UGczYktxR1JQK3hHb3l3N1h5SWRn?=
 =?utf-8?B?ZFlQOXJPeTVzZTFUZEZsTlI4dmE2cjIzdkY1MFNBdEVGTTRITUFYckpadUxx?=
 =?utf-8?B?QXlORXY3T08rbjd0YytBZ3pibmVRUHFDWTJlckdNTTIyZ3AzZEVXeWdmTHhx?=
 =?utf-8?B?SFJKSXVkZ0ltQUJXZi8vdFN3TFgwNy9Ha3loc0lKeXVEK3ZQL3NzZWNYeGd3?=
 =?utf-8?B?MjBPeDk3bXRoNG5DWDBwdkQ1NU5JSjgwaFRoRWF4U1lqOHVJMmEyQWVmQlpu?=
 =?utf-8?B?RjN0M29rRmZTL1hBclM5STMxTnduR0lzaXowQjU5YXBQeis0aHhYdVY1QXVs?=
 =?utf-8?B?QTI3SytoVHRHWmxOZzBydFNMMmZsTjFjY0dqSENTdXEwOFdHUWFVOUdNSjFm?=
 =?utf-8?B?cnJPVjBEbjJMc0hRaXFnanB1UjNYdEZHbWFUU1piZGFzWVV5Y3N6SHNDWXZW?=
 =?utf-8?B?V0JpOUtzcFF0R0RuVzV4V3cwSFBWV3JDS0JFRHZKa3MwK1pyRjFTSU9pdC9u?=
 =?utf-8?B?TUlEZEpBcEx4QTBKamI2clZuajRiQkgrd29EUHV0YnFSK2NWNVJ5cUMzM1RG?=
 =?utf-8?B?RHBUUERpL2lwKzdpRTlZY3ZCK0R6QytiV1F1OG5OTHAzV2dFdWlxeEtOeFl1?=
 =?utf-8?B?QVh6UWppTnNIWjgxR2ZrTEJIalEzazJ4QjhJK1Q5dWI0MkQ4Qk0yZzJXeHpa?=
 =?utf-8?B?em82MGt6VzVFZlpQVDMvUnJuaDM0UzRpcVQ3N2cvdHpQalRreHNBRVkxZWFq?=
 =?utf-8?B?YXRFcU83ekJ6bVpiV0pVdFlqbXdGb2Z4V2VLcDVZRkNmRnpOY2JwYTEvbWQ1?=
 =?utf-8?B?UElYaE9PNVVCSTl5NGd0THNzQmVVUDYvRWU4RnpQdFdPQ09vTTVic00yRHpT?=
 =?utf-8?B?YVpDbTJRU1dwdzIyYk9xWHhpdXRsNkhLUGlBVzk0ejErVXMzZlZjZ29obmkz?=
 =?utf-8?B?V054czdoTE5SbVVRemtXSWRpTEIrUEJaTEVvZi84ZFpqbDAyc09YNUoySVhX?=
 =?utf-8?B?cEk2QVE4cGc3amsrdGZReUJlQzd3d05ScHdKSHBlSzFvOVA5bjk2cWE0RVNa?=
 =?utf-8?B?Z2JKMzFaQWliVVdkK1VJWFpRK2RyYWJZT0dUK081WW1XelBOTE1WT1BLbWxH?=
 =?utf-8?B?V0xZRlhaOTVEK2NPYWtZbkhSTUFXcVIyQUV3ZFNhSjBQY0RhTjA1RXpxRyt5?=
 =?utf-8?B?eHBNUzBXRG84b0VueXc5OHZuS01XTFZHM2Q3d08xVEdZOUhFMHZ3MlE3OG8r?=
 =?utf-8?B?SkVET3FubTFrYlZDOHdXeXpzejhYME5TY09aZ1BKS2NlZGxVM0d1WUkreGtL?=
 =?utf-8?B?ZmM1YzhGek14bkR3NDBqenRuWEZDcGVsN0xMaWI3WEZLYmQ2R3RhNG1VTzZE?=
 =?utf-8?B?dk1VaFFSZUh5K0taRUtQUVhxM0V6WVAvcEZwRTBRQ2ZjR3JTUHNZVzJjRGMw?=
 =?utf-8?B?eHZYTXlaTEsza3Jtby9HTzNiL01HVTZyU0lzZEZPQlB1R0tPOXJOVU5zRTNH?=
 =?utf-8?B?N3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E506107BE794B6499A18DC7FA0CA663E@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB4565.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed6aba5c-716a-4cc8-54e8-08daef11e66d
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2023 11:42:18.5128
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R+ynJE8wy0fIoJ4VJVKJjrbbbNl9c1SHPnFrUNf4wAigHzo7Ra5JzL5Ior7o+sztvpesQ68xzAEkJnyQ0LJDd72ukfaPr4zMtKcsnohS4NU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR03MB6502
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,RDNS_NONE,
        SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIyLTEyLTIwIGF0IDEwOjE1ICswODAwLCB4aWFuZ3NoZW5nLmhvdSB3cm90ZToN
CkhpIE1hdHRoaWFzLCBBbmdlbG8NCj4gDQo+IE9uIE1vbiwgMjAyMi0xMi0xOSBhdCAxNjozMCAr
MDEwMCwgTWF0dGhpYXMgQnJ1Z2dlciB3cm90ZToNCj4gPiBUaGFua3MgZm9yIHlvdXIgcGF0Y2gh
IFRoZXJlIGlzIHNvbWV0aGluZyB0byBpbXByb3ZlIHBsZWFzZSBzZWUNCj4gPiBiZWxvdy4NCj4g
PiANCj4gPiBPbiAxOS8xMi8yMDIyIDAzOjQwLCBYaWFuZ3NoZW5nIEhvdSB3cm90ZToNCj4gPiA+
IENoYW5nZSBkZWZhdWx0IHBhZ2UgZm9ybWF0IHRvIHNldHVwIGRlZmF1bHQgc2V0dGluZyBzaW5j
ZSB0aGUNCj4gPiA+IHNlY3Rvcg0KPiA+ID4gc2l6ZSAxMDI0IG9uIE1UNzk4NiB3aWxsIGxlYWQg
dG8gcHJvYmUgZmFpbC4NCj4gPiA+IA0KPiA+ID4gU2lnbmVkLW9mZi1ieTogWGlhbmdzaGVuZyBI
b3UgPHhpYW5nc2hlbmcuaG91QG1lZGlhdGVrLmNvbT4NCj4gPiA+IC0tLQ0KPiA+ID4gICBkcml2
ZXJzL3NwaS9zcGktbXRrLXNuZmkuYyB8IDMgKy0tDQo+ID4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAx
IGluc2VydGlvbigrKSwgMiBkZWxldGlvbnMoLSkNCj4gPiA+IA0KPiA+ID4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvc3BpL3NwaS1tdGstc25maS5jIGIvZHJpdmVycy9zcGkvc3BpLW10ay0NCj4gPiA+
IHNuZmkuYw0KPiA+ID4gaW5kZXggZmE4NDEyYmEyMGUyLi43MTlmYzZmNTNhYjEgMTAwNjQ0DQo+
ID4gPiAtLS0gYS9kcml2ZXJzL3NwaS9zcGktbXRrLXNuZmkuYw0KPiA+ID4gKysrIGIvZHJpdmVy
cy9zcGkvc3BpLW10ay1zbmZpLmMNCj4gPiA+IEBAIC0xNDMwLDggKzE0MzAsNyBAQCBzdGF0aWMg
aW50IG10a19zbmFuZF9wcm9iZShzdHJ1Y3QNCj4gPiA+IHBsYXRmb3JtX2RldmljZSAqcGRldikN
Cj4gPiA+ICAgDQo+ID4gPiAgIAkvLyBzZXR1cCBhbiBpbml0aWFsIHBhZ2UgZm9ybWF0IGZvciBv
cHMgbWF0Y2hpbmcNCj4gPiA+IHBhZ2VfY2FjaGVfb3ANCj4gPiA+IHRlbXBsYXRlDQo+ID4gPiAg
IAkvLyBiZWZvcmUgRUNDIGlzIGNhbGxlZC4NCj4gPiA+IC0JcmV0ID0gbXRrX3NuYW5kX3NldHVw
X3BhZ2VmbXQobXMsIG1zLT5jYXBzLT5zZWN0b3Jfc2l6ZSwNCj4gPiA+IC0JCQkJICAgICAgbXMt
PmNhcHMtPnNwYXJlX3NpemVzWzBdKTsNCj4gPiA+ICsJcmV0ID0gbXRrX3NuYW5kX3NldHVwX3Bh
Z2VmbXQobXMsIFNaXzJLLCBTWl82NCk7DQo+ID4gDQo+ID4gQ291bGRuJ3QgeW91IGp1c3Qgc2V0
IHNlY3Rvcl9zaXplIGluIG10Nzk4Nl9zbmFuZF9jYXBzPw0KPiANCj4gVGhlIGZ1bmN0aW9uIG10
a19zbmFuZF9zZXR1cF9wYWdlZm10IG5lZWQgdXNlIHBhZ2UgYW5kIE9PQiBzaXplIG9mDQo+IE5B
TkQNCj4gZGV2aWNlIHRvIHNldHVwIHBhZ2VmbXQuDQo+IFRoZSBjb250cm9sbGVyIHBhZ2Ugc2l6
ZSBjYW4gc3VwcG9ydCA1MTIvMWsvMmsvNGsuLi4sIHRoZSBzZWN0b3Igc2l6ZQ0KPiAxayBoYXZl
IGJlZW4gc2V0IGluIG10Nzk4Nl9zbmFuZF9jYXBzLiBIb3dldmVyIHRoaXMgd2lsbCBhbHNvIGxl
YWQgdG8NCj4gZmFpbCBpbiB0aGlzIGZ1bmN0aW9uIHNpbmNlIHRoZSAxayBwYWdlIHNpemUgd2ls
bCBub3QgYmUgc3VwcG9ydGVkLg0KPiBKdXN0IHVzZSBwYWdlIHNpemUgMmsgYW5kIE9PQiBzaXpl
IDY0IGFzIGRlZmF1bHQgcGFyYW1ldGVyIHNpbmNlIHRoaXMNCj4gY2FuIGJlIHN1cHBvcnRlZCBi
eSBhbGwgSUNzIHdpdGggdGhpcyBjb250cm9sbGVyLg0KDQpDb3VsZCB5b3UgcGxlYXNlIGhlbHAg
dG8gcmV2aWV3IHRoaXMgcGF0Y2guDQoNCkJlc3QgUmVnYXJkcywNClhpYW5nc2hlbmcgSG91DQo=
