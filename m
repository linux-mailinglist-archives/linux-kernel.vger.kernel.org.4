Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD97366D4C8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 03:57:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235626AbjAQC5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 21:57:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235432AbjAQC4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 21:56:37 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83EA4301A2;
        Mon, 16 Jan 2023 18:53:26 -0800 (PST)
X-UUID: 16896fd6961211eda06fc9ecc4dadd91-20230117
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=1bOryErHHas6KO1DZeKIGmGj0PTSG0NX70/7CZiRPTg=;
        b=U0TphKA3C294TMbYLISM1E0p2wjN/EOmTXglIjfZVcb7tZAgQiWFem0DDO+RxjGj655+9N4PFYH6lINPlxG3RU8+dmXN0GqFLZ2Z5u/ceZoiMdxmBlk6Thn106AE7LCAdcnkHtiYHHjKmb5EFUhN2MIfmL40+nkCnUNhH96uwic=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.18,REQID:61634132-bd45-487b-a3e7-b76253ee0ba4,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-INFO: VERSION:1.1.18,REQID:61634132-bd45-487b-a3e7-b76253ee0ba4,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:-5
X-CID-META: VersionHash:3ca2d6b,CLOUDID:75fd00f6-ff42-4fb0-b929-626456a83c14,B
        ulkID:23011617472178OHAI9X,BulkQuantity:29,Recheck:0,SF:38|17|19|102,TC:ni
        l,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:
        0,OSA:0
X-CID-BVR: 0
X-UUID: 16896fd6961211eda06fc9ecc4dadd91-20230117
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 392969136; Tue, 17 Jan 2023 10:53:15 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 17 Jan 2023 10:53:13 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Tue, 17 Jan 2023 10:53:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BOBPFc6D+ebMZnzMkbTFbjc0pk3GXh0iSX1vvarqhGV7PDZv8rQp6OZteFcz08/y4vIVRaoo1g5Z+Sdx7dl+9YGI9p+0aoKrt3jfPj0//cSj5OZwLFOrQ4+pFuau+fyWe5YP6qi0i4TjYeGQIsjg8b5K1MxOeqewhq3+SAHbpbOwa4eViPz2UnDE063QiYZAjzD+jc8EzoiZhLA2MK09J35NJiyzAVeYrpOsE0oyq86GsQ7/VDGHxI33f01uY9V7OQwoTUjHRDAXUqsRvJmu4mFgGD066MPRpMBQ96VNxErFe2lxZU1/gm3t9X6fZ144ITSk8iQW9HAwNeCgGrOR3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1bOryErHHas6KO1DZeKIGmGj0PTSG0NX70/7CZiRPTg=;
 b=B+o98OdKY7681U+B2r0fGGJnLbDVsba/jL2WmPm8HQOIS1SaXzAKqu/FSzW08GZ5wNNbpouRiyExHbooYm/89b4k2WlriBfyN2t05jD01ypIyyT8dYDBI5ynJDLxweCBppOJ66p762sn6PK77AKTssBYdukStH0cu7mcJ/u8rD1cchJBxI+KMkXpF0Aj2xjr2lURFTxQ3YKtFWh+6kICTsfxoiITYaW08K2cZNvJga+7+lNkd1wBjg5rPx+tNO3gwwxFC5x4YawgseKSo40bDc+BuGyf5BVPpZiwYY5FRsdQF1JPATKP4WMTKghD8j7jK1lPRLKKF2iXmGwzlYZ+1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1bOryErHHas6KO1DZeKIGmGj0PTSG0NX70/7CZiRPTg=;
 b=Ww1OGKrOh/glz0BjkOXggspaMKkKIimgawiRWFEwmPtARbsJ5q0+CFfXja+xfIbeBspx8PpWFnoqmn4I4dSp3NfoGVjD6FYdrdClV0HqzG1h2YaJE/UJyMBMtZTz7tCN7TVppX/T6u3RUB2erSBXtpVeAqO3chH3s1Hwpyw/3j4=
Received: from SI2PR03MB5885.apcprd03.prod.outlook.com (2603:1096:4:142::7) by
 PUZPR03MB6073.apcprd03.prod.outlook.com (2603:1096:301:b5::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.12; Tue, 17 Jan 2023 02:53:12 +0000
Received: from SI2PR03MB5885.apcprd03.prod.outlook.com
 ([fe80::4139:bb22:3bf9:f1e3]) by SI2PR03MB5885.apcprd03.prod.outlook.com
 ([fe80::4139:bb22:3bf9:f1e3%6]) with mapi id 15.20.5986.023; Tue, 17 Jan 2023
 02:53:11 +0000
From:   =?utf-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?= <Yong.Wu@mediatek.com>
To:     "joro@8bytes.org" <joro@8bytes.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?WW91bGluIFBlaSAo6KO05Y+L5p6XKQ==?= 
        <youlin.pei@mediatek.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?QW5hbiBTdW4gKOWtmeWuieWuiSk=?= <Anan.Sun@mediatek.com>,
        =?utf-8?B?TGlibyBLYW5nICjlurfliKnms6Ip?= <Libo.Kang@mediatek.com>,
        "kyrie.wu@mediatek.corp-partner.google.com" 
        <kyrie.wu@mediatek.corp-partner.google.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "hverkuil@xs4all.nl" <hverkuil@xs4all.nl>,
        =?utf-8?B?Q2hlbmdjaSBYdSAo6K645om/6LWQKQ==?= 
        <Chengci.Xu@mediatek.com>,
        =?utf-8?B?WXVuZmVpIERvbmcgKOiRo+S6kemjnik=?= 
        <Yunfei.Dong@mediatek.com>,
        =?utf-8?B?WUYgV2FuZyAo546L5LqR6aOeKQ==?= <YF.Wang@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        =?utf-8?B?TWluZ3l1YW4gTWEgKOmprOm4o+i/nCk=?= 
        <Mingyuan.Ma@mediatek.com>, "will@kernel.org" <will@kernel.org>,
        "nfraprado@collabora.com" <nfraprado@collabora.com>
Subject: Re: [PATCH 07/10] iommu/mediatek: Add a gap for the iova regions
Thread-Topic: [PATCH 07/10] iommu/mediatek: Add a gap for the iova regions
Thread-Index: AQHZJxTOuH8NMp5lsEGAJuHBVALjHa6g0JcAgAEe6QA=
Date:   Tue, 17 Jan 2023 02:53:11 +0000
Message-ID: <fc4be21af5408832f3b92927a1aeb57ebc1f8a01.camel@mediatek.com>
References: <20230113060133.9394-1-yong.wu@mediatek.com>
         <20230113060133.9394-8-yong.wu@mediatek.com>
         <1a9a09d5-58e2-badc-6d1c-fe2008c305f9@collabora.com>
In-Reply-To: <1a9a09d5-58e2-badc-6d1c-fe2008c305f9@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5885:EE_|PUZPR03MB6073:EE_
x-ms-office365-filtering-correlation-id: 3571a7b9-8cf1-4d16-d3c3-08daf835f8b6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iInz2U+tJg8Q9uI8JiijuOCv2elE9LP9KcQGhbzjS3WVGtkVitHzGTXXKeY6X1x4wEgcvtxGOUjaRJUGnlWJ178F3X5xsuShc5k0aIk3gCKkilbyUea/Kw4r/g2W/a3f4XukqJAmTAMsoZmaLXMHbtp+3HQ3ZH+nhrruEPg+2MOmopq4QjN9L15vO71O2JwNCcYNH4aThARm+a+Z+ezoU9zJ8u0lq7unDFLOSwKWwVfzar2mk9JVEwduE/5ZTolh3sMJbrAIGQvshCpomS2sOPMODgIhsjRXpHtV0rXuO7qgiT0xyaN5E7odZYYtrDKn5OVpwbNUOA3ZC43hZHGDS/sGuF1GtTg/qpvoxboZ2mBLjPxmM7NO9dQ0fb2vKGjHUNtoCsJ/USCgWja3hH4LT2UxG1DopNxlkQ1oK978w0WbrmS4BCXQ0bHVVu//ar+s1ecsdAh94Zrmjs+DohhJnFBRvnc737VSlPvSggl+kPSQBn8iul0F+9l8EjJVVHXVIM2BnCFohqqRvcOiN9VOS/iVrVucb+ZYY4zdDy/B0o15IE3sxTaDer1aOFrQbm+jYBIlgU5eCs8nWkRqyoS+/h7K/Sl4EjRBrYnl/1t+MjtAOfFGGBj/VuM1xQbqwIqIn5ptq+qt1AP4Eyas5vNJLq2zQvvT4PiDFfXI2nPEwDgde2QhKIrfMWJ6U1yJCRpjfL3JEPmLyRzMOZuYzvZshsreAFYX1ghvpRP3JvX0825bsjveL9sIWR0Ir/kk8ofgucwKy2qyriCkoF7zagKxHw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5885.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(346002)(376002)(39860400002)(366004)(451199015)(6486002)(478600001)(85182001)(71200400001)(36756003)(2906002)(38100700002)(86362001)(6512007)(2616005)(83380400001)(6506007)(26005)(122000001)(186003)(66946007)(66446008)(5660300002)(64756008)(4326008)(76116006)(66476007)(7416002)(91956017)(41300700001)(66556008)(8676002)(110136005)(316002)(8936002)(54906003)(38070700005)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SHN5VHhiWlE3R2x2d3NNTmxBLzVKNzVMQjNDazJvUVR5dDhYMlBXOHdzSXp4?=
 =?utf-8?B?bjIzZkIya011S2lPdmZFdDFVSDV4dks2cnAxMHowcVVXOVlaN1FDYlBRMm5L?=
 =?utf-8?B?cnRIdTBJZG03dUZGaGw1TVJZTGpBaVRaeFpLMkd4cXdiZ3Q3QzlYVGxkRnZi?=
 =?utf-8?B?TnNNMC9MblY5TnFZMUsxMjYvOEFWSU5ReUlMSTNCRzRyUnltMjRrNmdPMytp?=
 =?utf-8?B?VDZBUmx0Tkl4a3dkVXdXMmMrVkN0U01DQzlzclgrWDYzMFRoVVRHbHQ0aVhl?=
 =?utf-8?B?VGtXL1pBNm9CRU41TjhId2JtdVBFN3F0bkg2K3EwL3Zub3RVTU1LTVRrN2xi?=
 =?utf-8?B?bGh5SDVDOVpudHRYNE9WVk0rQ2M0cnAzL0F6aStqcG53WEV5bTJScUpwS2dH?=
 =?utf-8?B?cy81WU1HTzdKZ2FreW5Mb1p0dU5CandmbHM2bEE3WFVQaENsWHplRURRd0dn?=
 =?utf-8?B?ZDZidTRHa1V0N3d6c2p6VmxWeGlvMmRHVnYrYVpqbVN0RVl0RjAxVTMzdjFS?=
 =?utf-8?B?ZGQvcy9ERHVqRmlSZ2Jhamh4MXlJTjNrdjJqUUczOXRHWXF1YjMzRVIrTG1X?=
 =?utf-8?B?dzBxZXZ0Z1l3cW5sTklOd3U1RUpqQ21ZTE45TE41ZEZLSnYrQU1HRTJ2dDZl?=
 =?utf-8?B?RG5WQ1JxdDF1UHo0dTJUQjU2VWdDNGc2MjdFbGtDcmpkQTF0b1EvTFFuK2dG?=
 =?utf-8?B?WFFsWG5wdnVKYmJsZHNTVjJhZmJHREVvQTZ5TWd3YnpTOS84Z0M4aExDUElN?=
 =?utf-8?B?UmlvckFHb21icUZ4WlJKUDJFUGRuanMwd3BPRTRtaW5SS29pU0tOcCtGd29a?=
 =?utf-8?B?eUdpM0JscG96N2xWTVBTL0hSejlTSkkxNkVWM3pDRzZSL0pySSt6ZzhhTktj?=
 =?utf-8?B?dWpzWW5XT3dPdnVmMWhIa0RySmZiWjBUVEpZaDZHR3dCM2VWRHFUWG4xOFFq?=
 =?utf-8?B?amxrZC9iTE51TTUzQUxOeTY5OEZZa0NwTWh2ZUtMdXhYdEhSWWtRTFc0U3d3?=
 =?utf-8?B?STlxY0FaVmgvOVVlT3g2YWcwRUV3UjRINVFBUEVlSVZDcGNsM0VrR3hEYk9Y?=
 =?utf-8?B?UDlaaHkweDl5eFBHcUlpUk1Fenh6WFpPeVBGaFJ1MCtXMVF1TlFxN0lwc3Vm?=
 =?utf-8?B?Rm5HWkE2OGUveHNIUjNtU1djN2VWZHVvaS9ESFNxQ1VVSVdLUldqRTBTQ3lG?=
 =?utf-8?B?dVpvOXpxSkZ0SFRUTzNqc0lId1VSVHUrQXExaEw0OWgrSjZKYnh5U2hKUi9x?=
 =?utf-8?B?M0RLaDR4djhiY1lBN3QybWNRc0hZVFhUM1MwdHJYMGlQOUtBWXlEdkdZMXUz?=
 =?utf-8?B?SzYvNGxvK2kycEk3STBrb0ZBa2FhQnp6dTgwWW5mNnAzbmtTbDZKY2ZDT0Jv?=
 =?utf-8?B?RjVWdUtiZmlGQXZnZXVJRHMzRVlOcEIvSHZLVHBrK0tKZHh6Ny96d2U1UGV4?=
 =?utf-8?B?aEw2dlord01xU3hnbmcvejM0YlpLcDJuNVZQSmVMdVUraFo2SjRwVSt4RFJi?=
 =?utf-8?B?bnA4QWNsVGxOM3c2U2ltalBLTGlWWDQ1bkVtTnIvazdya1htUnMvYXlNdlVq?=
 =?utf-8?B?WU1LTTFNT2pYWWRHbkFtSUV1aDdVdnBVZG84TDIwa0NYMlFnU1hoNDVxcmJ5?=
 =?utf-8?B?RmEyMzgwc1R4eXU2ci9CclhuUVc3R29FN2dtcjdWb2gyUkNWVk1LWTgrdlZP?=
 =?utf-8?B?VHVhRHNhTm5oanNoZVczN253VE9IUEJFSWlkZ1RnWjBkQkRCRkRHU0Jra2Fi?=
 =?utf-8?B?OGdIWDlaRXByYmhqM1M0WFpILzVCcXZLOXdtZ0RpZkt3RGowQnJQalU3QzV3?=
 =?utf-8?B?dmNhcGJuTWdxMS91RnVFcjdlZFdWTEF1VU5TTGs2VXE4cVBoVkF4VWdjUzJs?=
 =?utf-8?B?eGZWcXVJbS9RWHFIZlhvVCtLQjRKRlBiTmIzZmRlMkZERDFXZVJxTnVHYU16?=
 =?utf-8?B?bWZJUG4rUWQ1REFFWEdZSHlxNng5U1EwZmxwc0xCK2dKQzlDc0NCTGdTMnpr?=
 =?utf-8?B?SkhSN3hwZmVGaHc1ZFViU0NZcklLd2NQOUtMZWRZM3ZzbnhaNkdaZWM0S1RO?=
 =?utf-8?B?STJ1OEtiYUcxTWR6eFpqSFVKSnUrbW9iWnBHd1A1a0tqTXVCOS9GZ0VjWWF4?=
 =?utf-8?B?NVp2TUpQc2l5WC9oRG9vYXhhVEMvazVSVFJIUGQyYkZzZVV4Mlc5YmhDSDgw?=
 =?utf-8?B?Mmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3C317E409FC89B4B9DFE4158BD6B4C18@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5885.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3571a7b9-8cf1-4d16-d3c3-08daf835f8b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2023 02:53:11.5564
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: weyPVrpQ4ic9SmmRl6XI+z83nuYDfmJdNL4FkjX8U40ut2eZ3FX3lhy8UNfbqkXRva/+4MJk/gAYJD6LYVr6dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR03MB6073
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,T_SPF_TEMPERROR,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTAxLTE2IGF0IDEwOjQ2ICswMTAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gSWwgMTMvMDEvMjMgMDc6MDEsIFlvbmcgV3UgaGEgc2NyaXR0bzoNCj4g
PiBDdXJyZW5seSBtYXN0ZXJzIGNhbiBub3QgaW5kaWNhdGUgaXRzIHNwZWNpYWwgZG1hLXJhbmdl
cy4gUHJlcGFyZQ0KPiA+IGZvciB2Y29kZWMuIHNvbWUgdmNvZGVjIGVuZCBhZGRyZXNzIGlzIGFk
ZHJlc3MgKyBzaXplLCBpZiBvdXIgc2l6ZQ0KPiA+IGlzIDRHLCB0aGUgZW5kIGFkZHJlc3MgbWF5
IGJlIDB4Ml8wMDAwXzAwMDAuIGFuZCB0aGUNCj4gPiByZWdpc3RlciBpcyB1MzIsIHRoZW4gaXQg
bWF5IGdldCB6ZXJvLiB0aHVzIGFkZCBhIGdhcCg4TSkgZm9yDQo+ID4gYWxsIHRoZSByZWdpb25z
Lg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IFlvbmcgV3UgPHlvbmcud3VAbWVkaWF0ZWsuY29t
Pg0KPiANCj4gSSBkZWZpbml0ZWx5IGFncmVlIG9uIHRoZSBmYWN0IHRoYXQgd2UgZG8gKm5lZWQq
IHRoaXMgc2VyaWVzLi4uIA0KDQpUaGFua3MgdmVyeSBtdWNoIGZvciB5b3VyIHJldmlldy4NCg0K
PiBidXQgdGhpcyBwYXJ0aWN1bGFyIGNvbW1pdCBsb29rcyBsaWtlIGEgaGFjay4NCj4gDQo+IEkn
bSBub3QgY29udmluY2VkOiBJIGhhdmUgYSBodW5jaCB0aGF0IHRoaXMgb25lIHdpbGwgc29vbmVy
IG9yIGxhdGVyDQo+IGJhY2tmaXJlDQo+IG9uIHVzIGFuZCBicmVhayB0aGluZ3MgYWdhaW4uLi4g
YXQgdGhlIHNhbWUgdGltZSwgSSdtIG5vdCBzdXJlIGhvdyB0bw0KPiBkbyB0aGlzDQo+IHByb3Bl
cmx5IGF0IHRoaXMgcG9pbnQgKEkgZGlkbid0IGRvIGFueSByZXNlYXJjaCwgYW55d2F5KS4NCg0K
SSBnb3QgYSByZWFsIHZjb2RlYyBpc3N1ZSBkZXNjcmliZWQgaW4gdGhlIGNvbW1pdCBtZXNzYWdl
LiBBcyB5b3UgbWF5DQpzZWUgaW4gdGhlIHZjb2RlYydzIGR0LWJpbmRpbmcgZXhhbXBsZVsxLzEw
XSBvciB0aGUgZHRzIG5vZGVbOS8xMF0sDQp0aGVpciBsZW5ndGggaXMgMHhmZmYwMDAwMCB0aGF0
IG1lYW5zIHRoZXkgdXNlIDFNIGFzIHRoZSBnYXAuIFZjb2RlYw0KdXNlIHRoaXMgZm9yIGEgbG9u
ZyB0aW1lLiBBZnRlciB0aGlzIHBhdGNoc2V0LCB0aGlzIHByb3BlcnR5IGlzIHVudXNlZCwNCnRo
ZW4gSSBoYXZlIHRvIHRha2UgY2FyZSBvZiB0aGlzIGluIHRoZSBpb21tdSwgdGhlcmVmb3JlIHRo
aXMgcGF0Y2ggaXMNCnJlcXVpcmVkLCBhbmQgSSBqdXN0IGdpdmUgYSBiaWdnZXIgZ2FwKDhNKSBo
ZXJlLg0KDQo+IA0KPiBJZGVhcz8NCj4gDQo+IFJlZ2FyZHMsDQo+IEFuZ2Vsbw0KPiANCg==
