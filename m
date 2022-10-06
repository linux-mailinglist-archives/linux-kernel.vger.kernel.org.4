Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67BD45F6527
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 13:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbiJFLYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 07:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231567AbiJFLYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 07:24:18 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D909C235;
        Thu,  6 Oct 2022 04:24:14 -0700 (PDT)
X-UUID: e71aa2ab78304fbba1f1faee0cf575cf-20221006
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=IGXsbuf1e43iNA2bJZpyvrST1OOaUkAVxd6DNgweEo0=;
        b=NxaZsAFmGrdE0G+lywspUfKluqa7MEFBQt38MigHdUjNpD3Cxlk1XEW8uoSWX/CJDRT1DUCvmlqQCV52zpa0rpi5/NBXEJ0DKrUD4gbQ37Js7PHq40Q8ED8c81PUV0L4LvL0u8T5oB83FyDh8OYUKTvJsHEsP/oB+OZeQYs0DCM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:17355f97-6612-4d79-9d4c-ff08e9e1ba14,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:1,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:1
X-CID-INFO: VERSION:1.1.11,REQID:17355f97-6612-4d79-9d4c-ff08e9e1ba14,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:1,FILE:0,BULK:0,RULE:Release_Ham,ACTION:re
        lease,TS:1
X-CID-META: VersionHash:39a5ff1,CLOUDID:0f1ab9b8-daef-48a8-8c50-40026d6a74c2,B
        ulkID:221006192411PM3OFJZ1,BulkQuantity:0,Recheck:0,SF:38|17|19|102,TC:nil
        ,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: e71aa2ab78304fbba1f1faee0cf575cf-20221006
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <johnson.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 463415905; Thu, 06 Oct 2022 19:24:10 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 6 Oct 2022 19:24:09 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Thu, 6 Oct 2022 19:24:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M66ktOHlRpusN+b/w702y2zjqUHkyUN150i99mJGYWVXtc0mRhZU5jxXHaYONRkMa95ZicbUwSboa1DR5aXZ4tPft+N6EOd/QeyaA68wHXrpdp3HfDCW0J1CL3FVXxrmPC55OxqEnP/cmsXByd5kXaLEnCiVCNqgL2LbI/PcbPKv3kFwf7LjgrPh62CaiJf66elELOQEe4C8bhxSUmooHcW90fbUfrF+MYTqF+dlqv88HHOM/Tx9w7ZRARSzGrvKoGhZmSbYMGXi/BGiz9PsSCH+mxH3wEzoyPtIaEpaCfIYgqgJqvkRozdUb2K9y3XKnS++SI4hn+m4x+AY48K2Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IGXsbuf1e43iNA2bJZpyvrST1OOaUkAVxd6DNgweEo0=;
 b=nq7HoeMedlUamKIkxnwN8A9EseIrRGTEDKX3C0MKvEYXuwkW1pcmwB6bFgtGWfORpCgez4Ypx9Mic6m3LoIcAnJHxaxhF1F2mRb3RksKByWZXVbCTGfeJ4B8GRMPbpVLQaR2JZ4Bx7Elw3PwI6J+JbXuOi2K5br2543dAuTL2QllpafIa87IPjXAnkMkX6yhovrRSq4QICVoB7vkLxdQe2Fo1iR0F8sTBNluOV3q7GIuvM1v/tkhsY3b1nUocziMpeGB7sJSd+NVrSb1aromYcq26q1pVk6fH1hZZcVsBv3QSy1y3UEiRVflh6m5qvCRsSYU3AdqFpmMdycYudV6CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IGXsbuf1e43iNA2bJZpyvrST1OOaUkAVxd6DNgweEo0=;
 b=DX8aTSq4tT2uCAE8BvGkOTHeMTkzG3d1L1i7NxX6HrSV5p0FBFdoJ3lFQXtAVPJpQzRKwYwTXeZ1RPNOVHXedX7/0y1G4FdXuAggNngXQ4ldspWIKJtuEn1LpeCNeMDsFx29d/amUz4nvzEghHHkRBi+PyYiyNnzECoWs9dqqUQ=
Received: from TY0PR03MB6274.apcprd03.prod.outlook.com (2603:1096:400:142::9)
 by KL1PR03MB5761.apcprd03.prod.outlook.com (2603:1096:820:76::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.10; Thu, 6 Oct
 2022 11:24:06 +0000
Received: from TY0PR03MB6274.apcprd03.prod.outlook.com
 ([fe80::691d:c9be:8a6f:5e85]) by TY0PR03MB6274.apcprd03.prod.outlook.com
 ([fe80::691d:c9be:8a6f:5e85%9]) with mapi id 15.20.5709.010; Thu, 6 Oct 2022
 11:24:06 +0000
From:   =?utf-8?B?Sm9obnNvbiBXYW5nICjnjovogZbpkasp?= 
        <Johnson.Wang@mediatek.com>
To:     "sboyd@kernel.org" <sboyd@kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?S3Vhbi1Ic2luIExlZSAo5p2O5Yag5pawKQ==?= 
        <Kuan-Hsin.Lee@mediatek.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        =?utf-8?B?WXUtQ2hhbmcgV2FuZyAo546L54Wc5qifKQ==?= 
        <Yu-Chang.Wang@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        =?utf-8?B?RWR3YXJkLUpXIFlhbmcgKOaliuWTsue2rSk=?= 
        <Edward-JW.Yang@mediatek.com>
Subject: Re: [PATCH v3 1/4] clk: mediatek: Export PLL operations symbols
Thread-Topic: [PATCH v3 1/4] clk: mediatek: Export PLL operations symbols
Thread-Index: AQHY0/lJgxT9blZ1BkSiYGXLMkwgJK32YQWAgArjUYA=
Date:   Thu, 6 Oct 2022 11:24:06 +0000
Message-ID: <4a365d5915b60ed0e16840f1e4ae1ab5dd4e562a.camel@mediatek.com>
References: <20220929114624.16809-1-johnson.wang@mediatek.com>
         <20220929114624.16809-2-johnson.wang@mediatek.com>
         <7dff6595-f3e1-5a2e-0a81-2f3bf1903f12@collabora.com>
In-Reply-To: <7dff6595-f3e1-5a2e-0a81-2f3bf1903f12@collabora.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY0PR03MB6274:EE_|KL1PR03MB5761:EE_
x-ms-office365-filtering-correlation-id: 7a8dfc1c-2b5f-46df-78e4-08daa78d47c2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CfZW1A/mnQtUHlSmr9BjZ7Ylj64mL0FrukZeFS4G3qKSeuKIPIMhYvV1gqUF8+Iq73mJ8l6qZ7p85OoI8Vc6FYcyC3kWAVQjAoUiz85IPuqLqayOhFzcPV7+icFQNlcWFD+u6S8MSJEozkzpE2RQUf91c6y4qH+0Cva8la3+o1+a7OCGNB5qZ50ipEEKOxmWlO6Qpac/0KkAF6i4KzQrpZNCr9EtHuRK+PBPq4fsf1BRqGwYu7QyOuwFrxhDM+qOI0le918UpOR53AFgPn9eC2ordtSv2T2KfFED/yWCV4zAcRtxr20gg4IYG5iMF4H1y7Y0PkRDzAkz/MlYztfik76eNqHDtW31FmC6Xe0XYWghMgtByZ7I7gSaEHoP1JiJtw5Uq7rEz1F4XbGG/aZ3JGSiglsvPZY/SvgU9hnn6cPqAWexM1RbKMtIgMuyawYeX6XE9CeleOZffFOgevIVksa9jCwUg1UyXfroeVDkbj5ORd6O3EnsVMX0SjwVecnx8yloOm6rr92ZaHdtu8QS7CaAK28FzkwiJtSXry/E0RU3VKVQ1/14AUCcJOP2YYfGXemezNwxh3ra1ATAsTEEGZOPrufbxNFV5n7wKKS+PA67w56Y6EtIEIPpxwNAi6VCKPtCmv0WuR3fS2ljsmFIqtGiYB6Sa/bDK73vhQPXBvhZrNpnAU3nnHyG+gALxEGdHl6BdSCCeLHe/qc2AbejnT+zRDAiV8Bn8zWzPJo/oYjglNTCupNkJ0v6u1gsRp90+UP7llecxcUUkPWsx9MTCQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY0PR03MB6274.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(39860400002)(396003)(346002)(376002)(451199015)(36756003)(110136005)(54906003)(6506007)(8936002)(26005)(85182001)(6512007)(41300700001)(86362001)(2906002)(2616005)(6486002)(71200400001)(38100700002)(66446008)(66476007)(66556008)(316002)(5660300002)(66946007)(76116006)(83380400001)(64756008)(186003)(122000001)(478600001)(4326008)(8676002)(107886003)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eS9RbVFhRXViS3NUaGdvRHJsWWpGMnhMK0YwTlhqVkJTbCtEeUZISzc1L3pw?=
 =?utf-8?B?TDQ1WGlTUDZvSlBYVHl2RFBOV2swMGhqT3JiUUlrSHBVOHMzSlh4ZFhZdUhJ?=
 =?utf-8?B?WVdONGZMSFhOdHA0b3BFVHN6ZzhDUW1hTm9ueURhZWk1RHVDT1F6YjBlTDhM?=
 =?utf-8?B?TmYyc2JNSlhxYmhsWWVsY0xpbHFmSmVSTFo4MkE3bkx3eXkvaHJlcHZPUFpF?=
 =?utf-8?B?VnViY2JTVlZIZFd4RTBtVnlPaHdqQUtPbDNyTHpLWlA2TG1MMkQwUmJ3bWJq?=
 =?utf-8?B?WGk4YVFVZ21YUlFPekEzenVpdm5keVFmS3JvTFhqRlRET3pKY1IvN0FhaDNB?=
 =?utf-8?B?TU5VK2VaUjRSSkZpZ0JxNm90b2VHK3VMTmwxeDgwVDlGamlxdUdFZGljQXZn?=
 =?utf-8?B?blp3aE1PL0w1Q0dKaTEzckk5ckRBaUV2a0NScmVibUJOWkw5dU8vSVVrNDNU?=
 =?utf-8?B?U1hseXRqakxESE5PUmpQQW9SRHZyMUtsbTdYUTFVWno5TEdzZERwbkc5d1Jz?=
 =?utf-8?B?Qm45S0FZVmR1bFJUVU91U1M0dFN1OVBDUnJTR3JlbFJVQytnNXd0SlZBQkZK?=
 =?utf-8?B?UFlrMnBsNi9LWHF6SWk3dExPWWtlaHRFblV1ZENrY1BoZHJ4R1ZQL2w1a2NV?=
 =?utf-8?B?ZVJoeEZxR3laL0dqTGhqejFRRU9MUzNWVVdjUjhiaHBrSmg4TUNqMWZQUmlx?=
 =?utf-8?B?NUpMV3djRmJURVFQQXBxdnJ5bnpabHpmdjZEYmp6MFRDM3ZxVFdjWXFLL2w4?=
 =?utf-8?B?WUZsWVVERnJIOTVUL0F1MGVWZ1dWYXh0WTlVWncvSnBlWFhmZUtsajhjTS8v?=
 =?utf-8?B?djFpelJIdURLemF4dVNVQk85UnFIbStHUzhDV2pPNzNJQUczNTV2SUsxQnIx?=
 =?utf-8?B?MG1vN00rSFZtSi9zSlM1b1R2elVJcVIzU2RwQVVmK2MyVFJUK0EwZTBSTCth?=
 =?utf-8?B?UkxmZ3ZNdlVSUGZhcm53eTgvQXlnSkl0MFhwQ29BSG1BSTZmOGpZUlJPYWpq?=
 =?utf-8?B?cW5UQ1prSEZjbjdBYlJQcFExVlNVanFTdVVIU25oUnZNMmNGYXVmcEtCVnFG?=
 =?utf-8?B?Rjk2Ly8zWXRNQmJGRWMrVkRsMXg0U1BUYmpLbWJ6UnFLcllOMS9yM1pFRmZx?=
 =?utf-8?B?NVg4ZldmQmJsL0lLNFkvMmprS3J0QUJ6emp6Q3IzUUx4M2xnTnk0VVJBYmpr?=
 =?utf-8?B?bUF2V2VrN3RZbGV2Mkc5VUZyQlIrVVE1TWMwRThkOUpaaElnL0pmRERoeXpC?=
 =?utf-8?B?TFJPa083SmM3RU1PRzZ4NnAyTkFHREtQU2tlN0s4VFdJU1AwYjhnWERncmh5?=
 =?utf-8?B?cjhCbWZ1clBaNHdQdUdwMUxMUHB2RUVSZXBrMW1QSXRZeW02U0xHcW5GNHVp?=
 =?utf-8?B?THY1QnVnejFoZ0RHb2Zydisvei92b2tCV2hEYVkrcHMrUml0WThSVUhmZVhW?=
 =?utf-8?B?ZVBXTWpjOU50YlVwTEUrSmpXa0thdE5DOHN4WnBwMjA4dmFVbkpTUzJhV3I3?=
 =?utf-8?B?MU1WbGh4MjZLdDU0TW9BVlpQQjBlTmluazk5YWdLbGlWSHVsUVBHQkVJczZl?=
 =?utf-8?B?WlcwR042Z0RqOHk2cTV5Mk90UWd0VEFSM0VhRjJQcTh0VFZ2UEgvR3R5OEhX?=
 =?utf-8?B?OExZWk9qREtJLys1Ykd1RElIeXBKMXR5MWQ5OXNzYms3bkFMWTVuRGJMd3p0?=
 =?utf-8?B?QmRjeDVvWmlhYlgxQkVZVDY3bnBRbWdkeE9ibFg3VGJJWlB4T09sanJ5bDVt?=
 =?utf-8?B?bzJ6bCs3NkcybElFM2d2UjdpZDV3RFVVQlI5bzU2L2t1Tk1CM0lZRXpmbjk2?=
 =?utf-8?B?N0JqeHZOZk94bUJYZkR1eWtwcWRyUmJWUnI5RjlJNk45Q3hwb1ZsNElLNE4r?=
 =?utf-8?B?Qi9pOHd6M1g4QXJaemhQYXRJOE1rdGFIaTRzV2pEZWoyQWROenloQzhianps?=
 =?utf-8?B?OEp4VUFCdHdPaW4xdlZRRFcvZ0E5cFlreDJENGF1UDBWTGhWZG5hTkF4MENs?=
 =?utf-8?B?TFQrZTgxRFAvKzlSM2xBN3pvbFBGc3ZQcGNmbkJqYVhiaHh5QVNLVXM4RmFm?=
 =?utf-8?B?V3FwWnhzUytxT3c0V1lVbEdZQnh5blZXSldxVGo3bTZaaHhRSzZrNklkMkI1?=
 =?utf-8?B?c2JpWTVidXZpRVRzUmR2TGhvL3lrNXN0d3pMT2lHMXBKa1lFMGlmSXJuZUZ4?=
 =?utf-8?B?REE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2AB2DD1736CB1E47A4A6A1A806748445@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY0PR03MB6274.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a8dfc1c-2b5f-46df-78e4-08daa78d47c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2022 11:24:06.1876
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xwqVfK/pYewizBCdizRlJVxw5MzThpmVia42oYPIPvzludG1TPzaoejDtWrAcvGhReZpC/lTncuLfJLhIKzrnribEWbd9GeJcdJWqMxhf7w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB5761
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY,URIBL_CSS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIyLTA5LTI5IGF0IDE1OjA3ICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gSWwgMjkvMDkvMjIgMTM6NDYsIEpvaG5zb24gV2FuZyBoYSBzY3JpdHRv
Og0KPiA+IEV4cG9ydCBQTEwgb3BlcmF0aW9ucyBhbmQgcmVnaXN0ZXIgZnVuY3Rpb25zIGZvciBk
aWZmZXJlbnQgdHlwZQ0KPiA+IG9mIGNsb2NrIGRyaXZlciB1c2VkLg0KPiA+IA0KPiA+IENvLWRl
dmVsb3BlZC1ieTogRWR3YXJkLUpXIFlhbmcgPGVkd2FyZC1qdy55YW5nQG1lZGlhdGVrLmNvbT4N
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBFZHdhcmQtSlcgWWFuZyA8ZWR3YXJkLWp3LnlhbmdAbWVkaWF0
ZWsuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEpvaG5zb24gV2FuZyA8am9obnNvbi53YW5nQG1l
ZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMvY2xrL21lZGlhdGVrL2Nsay1wbGwu
YyB8IDg0ICsrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tDQo+ID4gLS0tLS0NCj4gPiAgIGRy
aXZlcnMvY2xrL21lZGlhdGVrL2Nsay1wbGwuaCB8IDU2ICsrKysrKysrKysrKysrKysrKysrKysr
DQo+ID4gICAyIGZpbGVzIGNoYW5nZWQsIDkwIGluc2VydGlvbnMoKyksIDUwIGRlbGV0aW9ucygt
KQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Nsay9tZWRpYXRlay9jbGstcGxsLmMN
Cj4gPiBiL2RyaXZlcnMvY2xrL21lZGlhdGVrL2Nsay1wbGwuYw0KPiA+IGluZGV4IDU0ZTZjZmQy
OWRmYy4uYTRlY2E1ZmQ1MzljIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvY2xrL21lZGlhdGVr
L2Nsay1wbGwuYw0KPiA+ICsrKyBiL2RyaXZlcnMvY2xrL21lZGlhdGVrL2Nsay1wbGwuYw0KPiA+
IEBAIC0yNywzNyArMjcsMTAgQEANCj4gPiAgIA0KPiA+ICAgI2RlZmluZSBBVURQTExfVFVORVJf
RU4JCUJJVCgzMSkNCj4gPiAgIA0KPiA+IC0jZGVmaW5lIFBPU1RESVZfTUFTSwkJMHg3DQo+ID4g
LQ0KPiA+ICAgLyogZGVmYXVsdCA3IGJpdHMgaW50ZWdlciwgY2FuIGJlIG92ZXJyaWRkZW4gd2l0
aCBwY3dpYml0cy4gKi8NCj4gPiAgICNkZWZpbmUgSU5URUdFUl9CSVRTCQk3DQo+ID4gICANCj4g
PiAtLyoNCj4gPiAtICogTWVkaWFUZWsgUExMcyBhcmUgY29uZmlndXJlZCB0aHJvdWdoIHRoZWly
IHBjdyB2YWx1ZS4gVGhlIHBjdw0KPiA+IHZhbHVlIGRlc2NyaWJlcw0KPiA+IC0gKiBhIGRpdmlk
ZXIgaW4gdGhlIFBMTCBmZWVkYmFjayBsb29wIHdoaWNoIGNvbnNpc3RzIG9mIDcgYml0cyBmb3IN
Cj4gPiB0aGUgaW50ZWdlcg0KPiA+IC0gKiBwYXJ0IGFuZCB0aGUgcmVtYWluaW5nIGJpdHMgKGlm
IHByZXNlbnQpIGZvciB0aGUgZnJhY3Rpb25hbA0KPiA+IHBhcnQuIEFsc28gdGhleQ0KPiA+IC0g
KiBoYXZlIGEgMyBiaXQgcG93ZXItb2YtdHdvIHBvc3QgZGl2aWRlci4NCj4gPiAtICovDQo+ID4g
LQ0KPiA+IC1zdHJ1Y3QgbXRrX2Nsa19wbGwgew0KPiA+IC0Jc3RydWN0IGNsa19odwlodzsNCj4g
PiAtCXZvaWQgX19pb21lbQkqYmFzZV9hZGRyOw0KPiA+IC0Jdm9pZCBfX2lvbWVtCSpwZF9hZGRy
Ow0KPiA+IC0Jdm9pZCBfX2lvbWVtCSpwd3JfYWRkcjsNCj4gPiAtCXZvaWQgX19pb21lbQkqdHVu
ZXJfYWRkcjsNCj4gPiAtCXZvaWQgX19pb21lbQkqdHVuZXJfZW5fYWRkcjsNCj4gPiAtCXZvaWQg
X19pb21lbQkqcGN3X2FkZHI7DQo+ID4gLQl2b2lkIF9faW9tZW0JKnBjd19jaGdfYWRkcjsNCj4g
PiAtCXZvaWQgX19pb21lbQkqZW5fYWRkcjsNCj4gPiAtCWNvbnN0IHN0cnVjdCBtdGtfcGxsX2Rh
dGEgKmRhdGE7DQo+ID4gLX07DQo+ID4gLQ0KPiA+IC1zdGF0aWMgaW5saW5lIHN0cnVjdCBtdGtf
Y2xrX3BsbCAqdG9fbXRrX2Nsa19wbGwoc3RydWN0IGNsa19odw0KPiA+ICpodykNCj4gPiAtew0K
PiA+IC0JcmV0dXJuIGNvbnRhaW5lcl9vZihodywgc3RydWN0IG10a19jbGtfcGxsLCBodyk7DQo+
ID4gLX0NCj4gPiAtDQo+ID4gLXN0YXRpYyBpbnQgbXRrX3BsbF9pc19wcmVwYXJlZChzdHJ1Y3Qg
Y2xrX2h3ICpodykNCj4gPiAraW50IG10a19wbGxfaXNfcHJlcGFyZWQoc3RydWN0IGNsa19odyAq
aHcpDQo+ID4gICB7DQo+ID4gICAJc3RydWN0IG10a19jbGtfcGxsICpwbGwgPSB0b19tdGtfY2xr
X3BsbChodyk7DQo+ID4gICANCj4gPiBAQCAtMTYxLDggKzEzNCw4IEBAIHN0YXRpYyB2b2lkIG10
a19wbGxfc2V0X3JhdGVfcmVncyhzdHJ1Y3QNCj4gPiBtdGtfY2xrX3BsbCAqcGxsLCB1MzIgcGN3
LA0KPiA+ICAgICogQGZpbjoJVGhlIGlucHV0IGZyZXF1ZW5jeQ0KPiA+ICAgICoNCj4gPiAgICAq
Lw0KPiA+IC1zdGF0aWMgdm9pZCBtdGtfcGxsX2NhbGNfdmFsdWVzKHN0cnVjdCBtdGtfY2xrX3Bs
bCAqcGxsLCB1MzIgKnBjdywNCj4gPiB1MzIgKnBvc3RkaXYsDQo+ID4gLQkJdTMyIGZyZXEsIHUz
MiBmaW4pDQo+ID4gK3ZvaWQgbXRrX3BsbF9jYWxjX3ZhbHVlcyhzdHJ1Y3QgbXRrX2Nsa19wbGwg
KnBsbCwgdTMyICpwY3csIHUzMg0KPiA+ICpwb3N0ZGl2LA0KPiA+ICsJCQkgdTMyIGZyZXEsIHUz
MiBmaW4pDQo+ID4gICB7DQo+ID4gICAJdW5zaWduZWQgbG9uZyBmbWluID0gcGxsLT5kYXRhLT5m
bWluID8gcGxsLT5kYXRhLT5mbWluIDogKDEwMDANCj4gPiAqIE1IWik7DQo+ID4gICAJY29uc3Qg
c3RydWN0IG10a19wbGxfZGl2X3RhYmxlICpkaXZfdGFibGUgPSBwbGwtPmRhdGEtDQo+ID4gPmRp
dl90YWJsZTsNCj4gPiBAQCAtMTk4LDggKzE3MSw4IEBAIHN0YXRpYyB2b2lkIG10a19wbGxfY2Fs
Y192YWx1ZXMoc3RydWN0DQo+ID4gbXRrX2Nsa19wbGwgKnBsbCwgdTMyICpwY3csIHUzMiAqcG9z
dGRpdiwNCj4gPiAgIAkqcGN3ID0gKHUzMilfcGN3Ow0KPiA+ICAgfQ0KPiA+ICAgDQo+ID4gLXN0
YXRpYyBpbnQgbXRrX3BsbF9zZXRfcmF0ZShzdHJ1Y3QgY2xrX2h3ICpodywgdW5zaWduZWQgbG9u
ZyByYXRlLA0KPiA+IC0JCXVuc2lnbmVkIGxvbmcgcGFyZW50X3JhdGUpDQo+ID4gK2ludCBtdGtf
cGxsX3NldF9yYXRlKHN0cnVjdCBjbGtfaHcgKmh3LCB1bnNpZ25lZCBsb25nIHJhdGUsDQo+ID4g
KwkJICAgICB1bnNpZ25lZCBsb25nIHBhcmVudF9yYXRlKQ0KPiA+ICAgew0KPiA+ICAgCXN0cnVj
dCBtdGtfY2xrX3BsbCAqcGxsID0gdG9fbXRrX2Nsa19wbGwoaHcpOw0KPiA+ICAgCXUzMiBwY3cg
PSAwOw0KPiA+IEBAIC0yMTEsOCArMTg0LDcgQEAgc3RhdGljIGludCBtdGtfcGxsX3NldF9yYXRl
KHN0cnVjdCBjbGtfaHcgKmh3LA0KPiA+IHVuc2lnbmVkIGxvbmcgcmF0ZSwNCj4gPiAgIAlyZXR1
cm4gMDsNCj4gPiAgIH0NCj4gPiAgIA0KPiA+IC1zdGF0aWMgdW5zaWduZWQgbG9uZyBtdGtfcGxs
X3JlY2FsY19yYXRlKHN0cnVjdCBjbGtfaHcgKmh3LA0KPiA+IC0JCXVuc2lnbmVkIGxvbmcgcGFy
ZW50X3JhdGUpDQo+ID4gK3Vuc2lnbmVkIGxvbmcgbXRrX3BsbF9yZWNhbGNfcmF0ZShzdHJ1Y3Qg
Y2xrX2h3ICpodywgdW5zaWduZWQgbG9uZw0KPiA+IHBhcmVudF9yYXRlKQ0KPiA+ICAgew0KPiA+
ICAgCXN0cnVjdCBtdGtfY2xrX3BsbCAqcGxsID0gdG9fbXRrX2Nsa19wbGwoaHcpOw0KPiA+ICAg
CXUzMiBwb3N0ZGl2Ow0KPiA+IEBAIC0yMjcsOCArMTk5LDggQEAgc3RhdGljIHVuc2lnbmVkIGxv
bmcgbXRrX3BsbF9yZWNhbGNfcmF0ZShzdHJ1Y3QNCj4gPiBjbGtfaHcgKmh3LA0KPiA+ICAgCXJl
dHVybiBfX210a19wbGxfcmVjYWxjX3JhdGUocGxsLCBwYXJlbnRfcmF0ZSwgcGN3LCBwb3N0ZGl2
KTsNCj4gPiAgIH0NCj4gPiAgIA0KPiA+IC1zdGF0aWMgbG9uZyBtdGtfcGxsX3JvdW5kX3JhdGUo
c3RydWN0IGNsa19odyAqaHcsIHVuc2lnbmVkIGxvbmcNCj4gPiByYXRlLA0KPiA+IC0JCXVuc2ln
bmVkIGxvbmcgKnByYXRlKQ0KPiA+ICtsb25nIG10a19wbGxfcm91bmRfcmF0ZShzdHJ1Y3QgY2xr
X2h3ICpodywgdW5zaWduZWQgbG9uZyByYXRlLA0KPiA+ICsJCQl1bnNpZ25lZCBsb25nICpwcmF0
ZSkNCj4gPiAgIHsNCj4gPiAgIAlzdHJ1Y3QgbXRrX2Nsa19wbGwgKnBsbCA9IHRvX210a19jbGtf
cGxsKGh3KTsNCj4gPiAgIAl1MzIgcGN3ID0gMDsNCj4gPiBAQCAtMjM5LDcgKzIxMSw3IEBAIHN0
YXRpYyBsb25nIG10a19wbGxfcm91bmRfcmF0ZShzdHJ1Y3QgY2xrX2h3DQo+ID4gKmh3LCB1bnNp
Z25lZCBsb25nIHJhdGUsDQo+ID4gICAJcmV0dXJuIF9fbXRrX3BsbF9yZWNhbGNfcmF0ZShwbGws
ICpwcmF0ZSwgcGN3LCBwb3N0ZGl2KTsNCj4gPiAgIH0NCj4gPiAgIA0KPiA+IC1zdGF0aWMgaW50
IG10a19wbGxfcHJlcGFyZShzdHJ1Y3QgY2xrX2h3ICpodykNCj4gPiAraW50IG10a19wbGxfcHJl
cGFyZShzdHJ1Y3QgY2xrX2h3ICpodykNCj4gPiAgIHsNCj4gPiAgIAlzdHJ1Y3QgbXRrX2Nsa19w
bGwgKnBsbCA9IHRvX210a19jbGtfcGxsKGh3KTsNCj4gPiAgIAl1MzIgcjsNCj4gPiBAQCAtMjcz
LDcgKzI0NSw3IEBAIHN0YXRpYyBpbnQgbXRrX3BsbF9wcmVwYXJlKHN0cnVjdCBjbGtfaHcgKmh3
KQ0KPiA+ICAgCXJldHVybiAwOw0KPiA+ICAgfQ0KPiA+ICAgDQo+ID4gLXN0YXRpYyB2b2lkIG10
a19wbGxfdW5wcmVwYXJlKHN0cnVjdCBjbGtfaHcgKmh3KQ0KPiA+ICt2b2lkIG10a19wbGxfdW5w
cmVwYXJlKHN0cnVjdCBjbGtfaHcgKmh3KQ0KPiA+ICAgew0KPiA+ICAgCXN0cnVjdCBtdGtfY2xr
X3BsbCAqcGxsID0gdG9fbXRrX2Nsa19wbGwoaHcpOw0KPiA+ICAgCXUzMiByOw0KPiA+IEBAIC0z
MDEsNyArMjczLDcgQEAgc3RhdGljIHZvaWQgbXRrX3BsbF91bnByZXBhcmUoc3RydWN0IGNsa19o
dw0KPiA+ICpodykNCj4gPiAgIAl3cml0ZWwociwgcGxsLT5wd3JfYWRkcik7DQo+ID4gICB9DQo+
ID4gICANCj4gPiAtc3RhdGljIGNvbnN0IHN0cnVjdCBjbGtfb3BzIG10a19wbGxfb3BzID0gew0K
PiA+ICtjb25zdCBzdHJ1Y3QgY2xrX29wcyBtdGtfcGxsX29wcyA9IHsNCj4gPiAgIAkuaXNfcHJl
cGFyZWQJPSBtdGtfcGxsX2lzX3ByZXBhcmVkLA0KPiA+ICAgCS5wcmVwYXJlCT0gbXRrX3BsbF9w
cmVwYXJlLA0KPiA+ICAgCS51bnByZXBhcmUJPSBtdGtfcGxsX3VucHJlcGFyZSwNCj4gPiBAQCAt
MzEwLDE4ICsyODIsMTUgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBjbGtfb3BzIG10a19wbGxfb3Bz
ID0gew0KPiA+ICAgCS5zZXRfcmF0ZQk9IG10a19wbGxfc2V0X3JhdGUsDQo+ID4gICB9Ow0KPiA+
ICAgDQo+ID4gLXN0YXRpYyBzdHJ1Y3QgY2xrX2h3ICptdGtfY2xrX3JlZ2lzdGVyX3BsbChjb25z
dCBzdHJ1Y3QNCj4gPiBtdGtfcGxsX2RhdGEgKmRhdGEsDQo+ID4gLQkJdm9pZCBfX2lvbWVtICpi
YXNlKQ0KPiA+ICtzdHJ1Y3QgY2xrX2h3ICptdGtfY2xrX3JlZ2lzdGVyX3BsbF9vcHMoc3RydWN0
IG10a19jbGtfcGxsICpwbGwsDQo+ID4gKwkJCQkJY29uc3Qgc3RydWN0IG10a19wbGxfZGF0YQ0K
PiA+ICpkYXRhLA0KPiA+ICsJCQkJCXZvaWQgX19pb21lbSAqYmFzZSwNCj4gPiArCQkJCQljb25z
dCBzdHJ1Y3QgY2xrX29wcyAqcGxsX29wcykNCj4gPiAgIHsNCj4gPiAtCXN0cnVjdCBtdGtfY2xr
X3BsbCAqcGxsOw0KPiA+ICAgCXN0cnVjdCBjbGtfaW5pdF9kYXRhIGluaXQgPSB7fTsNCj4gPiAg
IAlpbnQgcmV0Ow0KPiA+ICAgCWNvbnN0IGNoYXIgKnBhcmVudF9uYW1lID0gImNsazI2bSI7DQo+
ID4gICANCj4gPiAtCXBsbCA9IGt6YWxsb2Moc2l6ZW9mKCpwbGwpLCBHRlBfS0VSTkVMKTsNCj4g
PiAtCWlmICghcGxsKQ0KPiA+IC0JCXJldHVybiBFUlJfUFRSKC1FTk9NRU0pOw0KPiA+IC0NCj4g
PiAgIAlwbGwtPmJhc2VfYWRkciA9IGJhc2UgKyBkYXRhLT5yZWc7DQo+ID4gICAJcGxsLT5wd3Jf
YWRkciA9IGJhc2UgKyBkYXRhLT5wd3JfcmVnOw0KPiA+ICAgCXBsbC0+cGRfYWRkciA9IGJhc2Ug
KyBkYXRhLT5wZF9yZWc7DQo+ID4gQEAgLTM0Myw3ICszMTIsNyBAQCBzdGF0aWMgc3RydWN0IGNs
a19odw0KPiA+ICptdGtfY2xrX3JlZ2lzdGVyX3BsbChjb25zdCBzdHJ1Y3QgbXRrX3BsbF9kYXRh
ICpkYXRhLA0KPiA+ICAgDQo+ID4gICAJaW5pdC5uYW1lID0gZGF0YS0+bmFtZTsNCj4gPiAgIAlp
bml0LmZsYWdzID0gKGRhdGEtPmZsYWdzICYgUExMX0FPKSA/IENMS19JU19DUklUSUNBTCA6IDA7
DQo+ID4gLQlpbml0Lm9wcyA9ICZtdGtfcGxsX29wczsNCj4gPiArCWluaXQub3BzID0gcGxsX29w
czsNCj4gPiAgIAlpZiAoZGF0YS0+cGFyZW50X25hbWUpDQo+ID4gICAJCWluaXQucGFyZW50X25h
bWVzID0gJmRhdGEtPnBhcmVudF9uYW1lOw0KPiA+ICAgCWVsc2UNCj4gPiBAQCAtMzYwLDcgKzMy
OSwyMiBAQCBzdGF0aWMgc3RydWN0IGNsa19odw0KPiA+ICptdGtfY2xrX3JlZ2lzdGVyX3BsbChj
b25zdCBzdHJ1Y3QgbXRrX3BsbF9kYXRhICpkYXRhLA0KPiA+ICAgCXJldHVybiAmcGxsLT5odzsN
Cj4gPiAgIH0NCj4gPiAgIA0KPiA+IC1zdGF0aWMgdm9pZCBtdGtfY2xrX3VucmVnaXN0ZXJfcGxs
KHN0cnVjdCBjbGtfaHcgKmh3KQ0KPiA+ICtzdHJ1Y3QgY2xrX2h3ICptdGtfY2xrX3JlZ2lzdGVy
X3BsbChjb25zdCBzdHJ1Y3QgbXRrX3BsbF9kYXRhDQo+ID4gKmRhdGEsDQo+ID4gKwkJCQkgICAg
dm9pZCBfX2lvbWVtICpiYXNlKQ0KPiA+ICt7DQo+ID4gKwlzdHJ1Y3QgbXRrX2Nsa19wbGwgKnBs
bDsNCj4gPiArCXN0cnVjdCBjbGtfaHcgKmh3Ow0KPiA+ICsNCj4gPiArCXBsbCA9IGt6YWxsb2Mo
c2l6ZW9mKCpwbGwpLCBHRlBfS0VSTkVMKTsNCj4gPiArCWlmICghcGxsKQ0KPiA+ICsJCXJldHVy
biBFUlJfUFRSKC1FTk9NRU0pOw0KPiA+ICsNCj4gPiArCWh3ID0gbXRrX2Nsa19yZWdpc3Rlcl9w
bGxfb3BzKHBsbCwgZGF0YSwgYmFzZSwgJm10a19wbGxfb3BzKTsNCj4gPiArDQo+ID4gKwlyZXR1
cm4gaHc7DQo+ID4gK30NCj4gPiArDQo+ID4gK3ZvaWQgbXRrX2Nsa191bnJlZ2lzdGVyX3BsbChz
dHJ1Y3QgY2xrX2h3ICpodykNCj4gPiAgIHsNCj4gPiAgIAlzdHJ1Y3QgbXRrX2Nsa19wbGwgKnBs
bDsNCj4gPiAgIA0KPiA+IEBAIC00MjMsOCArNDA3LDggQEAgaW50IG10a19jbGtfcmVnaXN0ZXJf
cGxscyhzdHJ1Y3QgZGV2aWNlX25vZGUNCj4gPiAqbm9kZSwNCj4gPiAgIH0NCj4gPiAgIEVYUE9S
VF9TWU1CT0xfR1BMKG10a19jbGtfcmVnaXN0ZXJfcGxscyk7DQo+ID4gICANCj4gPiAtc3RhdGlj
IF9faW9tZW0gdm9pZCAqbXRrX2Nsa19wbGxfZ2V0X2Jhc2Uoc3RydWN0IGNsa19odyAqaHcsDQo+
ID4gLQkJCQkJICBjb25zdCBzdHJ1Y3QgbXRrX3BsbF9kYXRhDQo+ID4gKmRhdGEpDQo+ID4gK19f
aW9tZW0gdm9pZCAqbXRrX2Nsa19wbGxfZ2V0X2Jhc2Uoc3RydWN0IGNsa19odyAqaHcsDQo+ID4g
KwkJCQkgICBjb25zdCBzdHJ1Y3QgbXRrX3BsbF9kYXRhICpkYXRhKQ0KPiA+ICAgew0KPiA+ICAg
CXN0cnVjdCBtdGtfY2xrX3BsbCAqcGxsID0gdG9fbXRrX2Nsa19wbGwoaHcpOw0KPiA+ICAgDQo+
ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL21lZGlhdGVrL2Nsay1wbGwuaA0KPiA+IGIvZHJp
dmVycy9jbGsvbWVkaWF0ZWsvY2xrLXBsbC5oDQo+ID4gaW5kZXggZmUzMTk5NzE1Njg4Li5lODdh
YjA4ZWVhOWIgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9jbGsvbWVkaWF0ZWsvY2xrLXBsbC5o
DQo+ID4gKysrIGIvZHJpdmVycy9jbGsvbWVkaWF0ZWsvY2xrLXBsbC5oDQo+ID4gQEAgLTcsNiAr
Nyw3IEBADQo+ID4gICAjaWZuZGVmIF9fRFJWX0NMS19NVEtfUExMX0gNCj4gPiAgICNkZWZpbmUg
X19EUlZfQ0xLX01US19QTExfSA0KPiA+ICAgDQo+ID4gKyNpbmNsdWRlIDxsaW51eC9jbGstcHJv
dmlkZXIuaD4NCj4gPiAgICNpbmNsdWRlIDxsaW51eC90eXBlcy5oPg0KPiA+ICAgDQo+ID4gICBz
dHJ1Y3QgY2xrX29wczsNCj4gPiBAQCAtMjAsNiArMjEsNyBAQCBzdHJ1Y3QgbXRrX3BsbF9kaXZf
dGFibGUgew0KPiA+ICAgDQo+ID4gICAjZGVmaW5lIEhBVkVfUlNUX0JBUglCSVQoMCkNCj4gPiAg
ICNkZWZpbmUgUExMX0FPCQlCSVQoMSkNCj4gPiArI2RlZmluZSBQT1NURElWX01BU0sJMHg3DQo+
IA0KPiBXaGlsZSBtb3ZpbmcgdGhpcywgY2FuIHlvdSBwbGVhc2UgYWxzbyBmaXh1cCBkZWNsYXJp
bmcgdGhpcyBtYXNrIGFzDQo+IEdFTk1BU0soKT8NCj4gDQo+ICNkZWZpbmUgUE9TVERJVl9NQVNL
CUdFTk1BU0soMiwgMCkNCj4gDQo+ID4gICANCj4gPiAgIHN0cnVjdCBtdGtfcGxsX2RhdGEgew0K
PiA+ICAgCWludCBpZDsNCj4gPiBAQCAtNDgsMTAgKzUwLDY0IEBAIHN0cnVjdCBtdGtfcGxsX2Rh
dGEgew0KPiA+ICAgCXU4IHBsbF9lbl9iaXQ7IC8qIEFzc3VtZSAwLCBpbmRpY2F0ZXMgQklUKDAp
IGJ5IGRlZmF1bHQgKi8NCj4gPiAgIH07DQo+ID4gICANCj4gPiArLyoNCj4gPiArICogTWVkaWFU
ZWsgUExMcyBhcmUgY29uZmlndXJlZCB0aHJvdWdoIHRoZWlyIHBjdyB2YWx1ZS4gVGhlIHBjdw0K
PiA+IHZhbHVlIGRlc2NyaWJlcw0KPiA+ICsgKiBhIGRpdmlkZXIgaW4gdGhlIFBMTCBmZWVkYmFj
ayBsb29wIHdoaWNoIGNvbnNpc3RzIG9mIDcgYml0cyBmb3INCj4gPiB0aGUgaW50ZWdlcg0KPiA+
ICsgKiBwYXJ0IGFuZCB0aGUgcmVtYWluaW5nIGJpdHMgKGlmIHByZXNlbnQpIGZvciB0aGUgZnJh
Y3Rpb25hbA0KPiA+IHBhcnQuIEFsc28gdGhleQ0KPiA+ICsgKiBoYXZlIGEgMyBiaXQgcG93ZXIt
b2YtdHdvIHBvc3QgZGl2aWRlci4NCj4gPiArICovDQo+ID4gKw0KPiA+ICtzdHJ1Y3QgbXRrX2Ns
a19wbGwgew0KPiA+ICsJc3RydWN0IGNsa19odwlodzsNCj4gPiArCXZvaWQgX19pb21lbQkqYmFz
ZV9hZGRyOw0KPiA+ICsJdm9pZCBfX2lvbWVtCSpwZF9hZGRyOw0KPiA+ICsJdm9pZCBfX2lvbWVt
CSpwd3JfYWRkcjsNCj4gPiArCXZvaWQgX19pb21lbQkqdHVuZXJfYWRkcjsNCj4gPiArCXZvaWQg
X19pb21lbQkqdHVuZXJfZW5fYWRkcjsNCj4gPiArCXZvaWQgX19pb21lbQkqcGN3X2FkZHI7DQo+
ID4gKwl2b2lkIF9faW9tZW0JKnBjd19jaGdfYWRkcjsNCj4gPiArCXZvaWQgX19pb21lbQkqZW5f
YWRkcjsNCj4gPiArCWNvbnN0IHN0cnVjdCBtdGtfcGxsX2RhdGEgKmRhdGE7DQo+ID4gK307DQo+
ID4gKw0KPiA+ICsNCj4gDQo+IFBsZWFzZSBkcm9wIHRoaXMgZXh0cmEgbmV3bGluZS4NCj4gDQo+
IFRoYW5rcywNCj4gQW5nZWxvDQoNCkhpIEFuZ2VsbywNCg0KVGhhbmtzIGZvciB5b3VyIHN1Z2dl
c3Rpb24uDQpJIHdpbGwgaW1wcm92ZSB0aGlzIGluIHRoZSBuZXh0IHZlcnNpb24uDQoNCkJScywN
CkpvaG5zb24gV2FuZw0K
