Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25FE5705E57
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 05:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232049AbjEQDrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 23:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231772AbjEQDrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 23:47:20 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D49F4220;
        Tue, 16 May 2023 20:46:58 -0700 (PDT)
X-UUID: 76d84806f46511edb20a276fd37b9834-20230517
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=XJ5CJ97PE18OQhVmn+qtQ+suiOKt9/KpzE/+qVFMwEs=;
        b=pDfTm9EndXbIzhA7u7MWiwois3kz5qSKSeZnSFERrVEQ5aDBY31VtB/fQW/7a4gkKFaNtIXuLWCdx5m+0jKWjLO8eLJDafDM5B+eI6Ddatya+VO8RnTna5mZTu+d7z/crnDaAew/Klpi1W1D0mF/oz7vA4uBVNEDeyllojglzkE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:b8f78a3c-1f8f-43c1-be51-b3a44d43daac,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-10
X-CID-INFO: VERSION:1.1.25,REQID:b8f78a3c-1f8f-43c1-be51-b3a44d43daac,IP:0,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:-10
X-CID-META: VersionHash:d5b0ae3,CLOUDID:1fc80f6c-2f20-4998-991c-3b78627e4938,B
        ulkID:230517114655N6IQN3K9,BulkQuantity:0,Recheck:0,SF:38|17|19|102,TC:nil
        ,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:
        0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 76d84806f46511edb20a276fd37b9834-20230517
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1024865997; Wed, 17 May 2023 11:46:54 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 17 May 2023 11:46:52 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 17 May 2023 11:46:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HA0KqS04jiXhaeuwsvMT9+gzYiPGHnY0TGxnitc9YzgGsp8QWBSRlCAVKQYkIS05T9Y1M/LW8kMHtmL3kKfYZqG058cD7NFLz0gh04WWUkPswDVblMPQMeUaKU0kMTqMQMKgHOZwuM/r8RMV/qV9aFk09ytp7TEXFLt6oEoHwGKtOUOMkAAQtAhYJ18adMMEL7OVTKyXKjYKUOq7VCENUsCpJueIzZsjK7iIzPLJTP1RMHSprD5slBcE9dZKF45vqaak3VX/xDh+gn4J2d42Ia1v8ESi1dkDG+6ZGnPwfQziomf73UbXpExNXnenMLGKjqqOn6ESB8avH8X6dhsZOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XJ5CJ97PE18OQhVmn+qtQ+suiOKt9/KpzE/+qVFMwEs=;
 b=GGmuH81fjn21hiU/i2Axoh+CRAgxxgzqdCE3V6vignm6jKe29j8TXW6gGF/+qImEX/xgCJvq5KiJ8k8WMP/EqKiywy7vTt32xtAIWljRoxqX+bTyjQ/1GVJVifYF9el3+CPfO1DcGyrWQFLp0cmlJMgPeehpdB3FCZ+m4TRsMGmM1s+zHgjuWYPbVI2YvpOzl3rcl3bPh+tN/hL7DgLRNSK+hwuWKN6omdlmjhZ9tSkR2HaUyB5TbT2pfwDWcYSKP8inqgYY7PZ3RsvRY9vntV6vEvygNk2REnPgedKwoyvUyKQZWUW6WGwLy2M08ph92NqeXAgH8Kn94KCOYi2VOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XJ5CJ97PE18OQhVmn+qtQ+suiOKt9/KpzE/+qVFMwEs=;
 b=OyCvGrz3mUd4HdU9axAnBHXxckMeYPTYTfzvEc3X69XswWLszh0p1ZJePWVtRSVRwIST8mH1uNbx1OUBfNam7vL1zFaYQrwstamnFQvwN5iC3X84d5gEk5qoasY3zBTpp3u2o4hVswfc1Uhzf5Y3doEV57Ixv4ms1Hn0qqOU0R4=
Received: from SL2PR03MB4153.apcprd03.prod.outlook.com (2603:1096:100:4e::10)
 by TY0PR03MB6630.apcprd03.prod.outlook.com (2603:1096:400:207::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.34; Wed, 17 May
 2023 03:46:50 +0000
Received: from SL2PR03MB4153.apcprd03.prod.outlook.com
 ([fe80::506f:2b56:e564:ba5a]) by SL2PR03MB4153.apcprd03.prod.outlook.com
 ([fe80::506f:2b56:e564:ba5a%3]) with mapi id 15.20.6387.033; Wed, 17 May 2023
 03:46:50 +0000
From:   =?utf-8?B?WXVuZmVpIERvbmcgKOiRo+S6kemjnik=?= 
        <Yunfei.Dong@mediatek.com>
To:     "wenst@chromium.org" <wenst@chromium.org>,
        "nfraprado@collabora.com" <nfraprado@collabora.com>,
        "nicolas@ndufresne.ca" <nicolas@ndufresne.ca>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "benjamin.gaignard@collabora.com" <benjamin.gaignard@collabora.com>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "frkoenig@chromium.org" <frkoenig@chromium.org>,
        "stevecho@chromium.org" <stevecho@chromium.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "hsinyi@chromium.org" <hsinyi@chromium.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Subject: Re: [PATCH v4,0/8] media: mediatek: vcodec: Add debugfs file for
 decode and encode
Thread-Topic: [PATCH v4,0/8] media: mediatek: vcodec: Add debugfs file for
 decode and encode
Thread-Index: AQHZZs0RV8q0HUB7tUa1lM2sSyTFCa9eFtCA
Date:   Wed, 17 May 2023 03:46:50 +0000
Message-ID: <58f4512de969ff6657a0fdd27f700ca9b4a0d32f.camel@mediatek.com>
References: <20230404081102.30713-1-yunfei.dong@mediatek.com>
In-Reply-To: <20230404081102.30713-1-yunfei.dong@mediatek.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SL2PR03MB4153:EE_|TY0PR03MB6630:EE_
x-ms-office365-filtering-correlation-id: 47002637-af80-4b17-28ae-08db568958eb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s2LJhpOHavq717doblMA7czzefULQlkK97X09ufPkWQDBdoFOWp7/TQ4UGnJ0mBI08UOQ9V9KEIDzehWQpbPwrbYhRpVIq1k2XDdzd634rN8rxtCRJzhGkCxgO/25xKXctOamvFHRXaWhyWZgzS+AYz9YkvVE2V0tysdMPZZiphb7Id5uyGH3vbkDL/I/qnVDTEFttAyRICzEJPqwMZq5v6beIR1zjttlO6/sbCLDeLpyYbvb6Mwja59KkJjW8mF7QyzX1W9+xAamRnl+UPgIP8EhP3wGXiC11BGVzTOWEbcGjPQF/ygrvwY65Vq4hxv+Vh/G7mCPjKyQg7VXLs2xmdRU140xOLd0kLT65xzs9eh7Cy4qiX9iXccekkf8yYKw9AYCxfq2gfPkF4J4O9nau6RMSfnEAToG3TbdUHcbA/0M+QCG/SGGBOr/vPapwEqe02agq1Tpz/Tq86JL1Ven2dzcz8S92nvDhgic0T0bcFfgUFslwC1uPnic8XBe6yEFzM4jWfzg5DWPEgD3677LGi38KQ4+kRWsSbYdusYLzwAy7k1Z8DNux0Kf4cr2qJbQb9KdGFb7lT7vUKaM1Cukar8PSJ3nP3cQTPGWdwkVVc5WxarkJtKF+z8l3+LuTlptCxmKl7ldKY5vexzQBozTA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR03MB4153.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(39860400002)(366004)(376002)(451199021)(71200400001)(122000001)(38100700002)(2616005)(6506007)(186003)(26005)(83380400001)(7416002)(41300700001)(6512007)(8676002)(8936002)(5660300002)(2906002)(36756003)(85182001)(110136005)(38070700005)(478600001)(6486002)(66946007)(76116006)(64756008)(66446008)(66476007)(66556008)(316002)(4326008)(54906003)(91956017)(86362001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SFJvcnpIS1Q2Qnpmekl3THliYlJKcEtzVUUrMDF0V1ZpNDViSldrU3pvRDN0?=
 =?utf-8?B?OUlFbnJPTlZ5RTA2SkZuVzRWRFBzbDlId1VuTWlsZjk0Z3hMd0QzajEzYVAz?=
 =?utf-8?B?aEwvM3JVYU55bmdGZHc1cnlNTUcrTVB6MkIwOGtNQjNaMG82ZVpRT0JFM3NP?=
 =?utf-8?B?VlE3TXZ4bVVmc1JsOS90Zm03K0ZYS0VKaXhWcisrSlduRGM5MS9Fc3BOVkZ2?=
 =?utf-8?B?ODNOb2RQZmFmQXFZbXhML3l4TXlwd3NIQzlZc3RibkdEUG1KRWdvb1lDRXdZ?=
 =?utf-8?B?dUErQ1pnZzdTNlNtYVpyeEFPbWZFbmdqMDBvNEl4NUllNjBjbk5xTWpkUXNz?=
 =?utf-8?B?MmlJOGgzdjBCNDcycDZPNm0wT25aT3I3K1dMdUM2V25lVVpCU3VpVzgzKzk1?=
 =?utf-8?B?enZ3SFJZTTU4WjViTTZKMzZkQlZQN1V3R3gyQWtrNCtqSHMzamhPWWs3NDZN?=
 =?utf-8?B?Wm14a09sQzVSMXdsOTZ3dXArNWJXNTloanNaWmF1c2NjUjlBcnA0R2pGcEti?=
 =?utf-8?B?L212VnJXaWxyS0d0dE9ZU0FFUmhMYkdhTDhtV3p4QWxwSi9CaDdXOEk4K0tj?=
 =?utf-8?B?ZDJuSCtPclhldmhXalk1UVU1dXlpSXBEdHcvNTRna3VTN01CTUdqMmR1WmVG?=
 =?utf-8?B?SmJtcy9EVlBnbVVFVjIzL0tUUFVZWHBpeTRaNTN5SFVCU2MwNFUxcyttQTZx?=
 =?utf-8?B?RTM5Nlh6ZytQeEtvL2Z0b3ZEdFRGQjhzOGhKLys2YUw4eks3VjZySm41d3Bw?=
 =?utf-8?B?YldseS9oUW5ockQyeUZBMGVXQ2dEdWs3Mk1hbFNBMHprZDRkU3ZzMWdWVTRn?=
 =?utf-8?B?OWlkcFIraHN2MjBLSnlVeDhSN0dhandXM3JsdnpWanNXUWJib1ltVGNrSHpF?=
 =?utf-8?B?cnVkaXh1Q2dFZkFPdjVnbGpRaFNwcWVNNEdtemI2dVJ0b3ArTEVxa1B3QVhJ?=
 =?utf-8?B?T2x1QzJFN1R3M3daakN5bjdIQ3hYMi9YTi9JMTZ6QzFBSWJFZVc5ZHJjS2I5?=
 =?utf-8?B?NjZCUS8rTENmWUpQc0RURklxSnJlUHdhM0NUb21ZSDNhemdvSENqeFlSUEYv?=
 =?utf-8?B?bVZJaXB0RG1Nd2VIdWZrWVJWekdQNzBQSVg0TFNiQXZlNjA2TWFrQW95a1N4?=
 =?utf-8?B?TXJLSkw2Nkp4cTU4WlpRd2NJVW9VUUx1Y1FsazJrYXdsVHJxaWIwd3hTYnRV?=
 =?utf-8?B?Yk5DY2ZXR2FvTjBVUU8xblV0R29BeFYzay9HQWJZbitSNlFVcldYNE5FWFFZ?=
 =?utf-8?B?WVcxMDJ0K3RpQUpGRk9LRlNQMFlUbE5KTkd5US9WMkVPcVlGc0ZiY01kcnEz?=
 =?utf-8?B?ckV2YVhod3BnWFdBNXhWMC9UbU1mT2NhRElTUlNvVzNQVUloaGdNWUxLeElW?=
 =?utf-8?B?UHhLb2t4bWdLWWhyWTE4MW56RkJYSTEvZ2lobjVmRVdGU1NYTE1EcTRyaytJ?=
 =?utf-8?B?eE41SHFjdGFZdUpDN1ljWWFyM0xEZWx4bUsxdmxKOFh3QllQK2VrZzI1aEtq?=
 =?utf-8?B?OHMxaElUVS84b2w2L3NFT2R5WWQxMjV3NjQ0eG1zLys1U3phVjlWNGMxcmkx?=
 =?utf-8?B?MkhKUWdWeE1Cb1RMWjEyVTlBSGpWT2lvdmhYQk9aMkt3U3l4MUczYVZmN20x?=
 =?utf-8?B?ajQvWGJEdUMzM0tCWUZHYkl1SzhJZGRaTGlqMWhleVNiN012bGdkSSswN3pH?=
 =?utf-8?B?c2dHenNQMlRHbnhtWUNtQzNVUEZldVFEeFJNVTVmVEVuZ2hmeTM5SEFKS0VP?=
 =?utf-8?B?ZVhsSWtiYm5VbFhDNEFRNlZ6ZnZOZnBpSkZUY09wZUxVQ3dGaGZ4SmJkcDdw?=
 =?utf-8?B?MmxVNERDU0dCemR2N0k5VWd2MkNTVHh2V25GTzBWYkFYZ3N3OHYwVS8zcFRR?=
 =?utf-8?B?cE44Y3JKZGZRUllxYVBTQVUwVkVNZVVkWU1QUnQwNGhUNW9hMjVCZU8wUWZ2?=
 =?utf-8?B?YWdPMnN4T2FjUjQ1SEtsdGZnR2l2bTUyQktONndmMWdHYTBOQXlGY3ZrWjRZ?=
 =?utf-8?B?N1ZURFBtOFRhRGdhZy9tZjN3THRPZG1YS3RSNE9nZzU2YU9DN0MrWEhaSlU3?=
 =?utf-8?B?ejR6RnU1ejRESHdsSi9SOWVqRmlielZVdGRZY3dKS0ZNQlZ2VHMvQjkxWkRo?=
 =?utf-8?B?WEpFYTN4bC9zamRRd3Bwd3Q1NU8xL3hqem5vUi9iY0lPR1V3NDk2THRieG1l?=
 =?utf-8?B?SWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <77DC5BE0F3009D4AB03D4478FC5BBB9D@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2PR03MB4153.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47002637-af80-4b17-28ae-08db568958eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2023 03:46:50.4840
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EImUPUEIWRm0kkvxF+BvHhQKRf35K4bJtJ1UB5kJswKX3mFFJoEdMOAI/gg9P7OetVJLDKRMfDzrfI55css2uMkSgfaQ37AheTyk1EyHXjk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB6630
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RGVhciBIYW5zLA0KDQpTb3JyeSB0byBkaXN0dXJiIHlvdSBhZ2Fpbi4NCg0KQ291bGQgeW91IHBs
ZWFzZSBoZWxwIHRvIHJldmlldyAmIG1lcmdlIHRoaXMgcGF0Y2ggc2VyaWVzIHdoZW4geW91IGFy
ZQ0KZnJlZT8NCg0KQmVzdCBSZWdhcmRzLA0KWXVuZmVpIERvbmcNCg0KT24gVHVlLCAyMDIzLTA0
LTA0IGF0IDE2OjEwICswODAwLCBZdW5mZWkgRG9uZyB3cm90ZToNCj4gTmVlZCB0byBjaGFuZ2Ug
a2VybmVsIGRyaXZlciB0byBvcGVuIGRlY29kZSBhbmQgZW5jb2RlIGRlYnVnIGxvZyBhdA0KPiBj
dXJyZW50IHBlcmlvZCwNCj4gaXQncyB2ZXJ5IHVucmVhc29uYWJsZS4gQWRkaW5nIGRlYnVnZnMg
Y29tbW9uIGludGVyZmFjZSB0byBzdXBwb3J0DQo+IGRlY29kZSBhbmQgZW5jb2RlLA0KPiB1c2lu
ZyBlY2hvIGNvbW1hbmQgdG8gY29udHJvbCBkZWJ1ZyBsb2cgbGV2ZWwgYW5kIGdldHRpbmcgdXNl
ZnVsDQo+IGluZm9ybWF0aW9uIGZvciBlYWNoDQo+IGluc3RhbmNlLg0KPiANCj4gcGF0Y2ggMSBh
ZGQgZGJnZnMgY29tbW9uIGludGVyZmFjZS4NCj4gcGF0Y2ggMn41IHN1cHBvcnQgZGVjb2RlLg0K
PiBwYXRjaCA2fjcgc3VwcG9ydCBlbmNvZGUNCj4gcGF0Y2ggOCBhZGQgaGVscCBmdW5jdGlvbg0K
PiAtLS0NCj4gY2hhbmdlZCB3aXRoIHYzOg0KPiAtIGFkZCBoZWxwIGZ1bmN0aW9uIGZvciBwYXRj
aCA4DQo+IC0gcmVtb3ZlIGFwcGVuZCAnXDAnIGFuZCBlbmxhcmdlIGJ1ZmZlciBzaXplIGZvciBw
YXRjaCA0DQo+IGNoYW5nZWQgd2l0aCB2MjoNCj4gLSB1c2luZyBwcl9kZWJ1ZyBhbmQgZGV2X2Ri
ZyBpbnN0ZWFkIG9mIHByX2luZm8gZm9yIHBhdGNoIDIuDQo+IC0gZml4IHdvcmQgZmFpbDogaW5m
b3JtYXRpYW9pbiAtPiBpbmZvcm1hdGlvbiBmb3IgcGF0Y2ggMy4NCj4gLSB1c2VkIHRvIHByaW50
IGVhY2ggaW5zdGFuY2UgZm9ybWF0IGluZm9ybWF0aW9uIGZvciBwYXRjaCA1Lg0KPiBjaGFuZ2Vk
IHdpdGggdjE6DQo+IC0gYWRkIG5ldyBwYXRjaCA0IGFuZCA1Lg0KPiAtIHVzaW5nIGNtZCAnY2F0
IHZkZWMnIHRvIHNob3cgZGVidWcgaW5mb3JtYXRpb24gaW5zdGVhZCBvZiBwcl9pbmZvDQo+IGRp
cmVjdGx5Lg0KPiAtLS0NCj4gWXVuZmVpIERvbmcgKDgpOg0KPiAgIG1lZGlhOiBtZWRpYXRlazog
dmNvZGVjOiBBZGQgZGVidWdmcyBpbnRlcmZhY2UgdG8gZ2V0IGRlYnVnDQo+ICAgICBpbmZvcm1h
dGlvbg0KPiAgIG1lZGlhOiBtZWRpYXRlazogdmNvZGVjOiBBZGQgZGVidWcgcGFyYW1zIHRvIGNv
bnRyb2wgZGlmZmVyZW50IGxvZw0KPiAgICAgbGV2ZWwNCj4gICBtZWRpYTogbWVkaWF0ZWs6IHZj
b2RlYzogQWRkIGEgZGVidWdmcyBmaWxlIHRvIGdldCBkaWZmZXJlbnQgdXNlZnVsDQo+ICAgICBp
bmZvcm1hdGlvbg0KPiAgIG1lZGlhOiBtZWRpYXRlazogdmNvZGVjOiBHZXQgZWFjaCBjb250ZXh0
IHJlc29sdXRpb24gaW5mb3JtYXRpb24NCj4gICBtZWRpYTogbWVkaWF0ZWs6IHZjb2RlYzogR2V0
IGVhY2ggaW5zdGFuY2UgZm9ybWF0IHR5cGUNCj4gICBtZWRpYTogbWVkaWF0ZWs6IHZjb2RlYzog
Q2hhbmdlIGRiZ2ZzIGludGVyZmFjZSB0byBzdXBwb3J0IGVuY29kZQ0KPiAgIG1lZGlhOiBtZWRp
YXRlazogdmNvZGVjOiBBZGQgZW5jb2RlIHRvIHN1cHBvcnQgZGJnZnMNCj4gICBtZWRpYTogbWVk
aWF0ZWs6IHZjb2RlYzogQWRkIGRiZ2ZzIGhlbHAgZnVuY3Rpb24NCj4gDQo+ICAuLi4vbWVkaWEv
cGxhdGZvcm0vbWVkaWF0ZWsvdmNvZGVjL01ha2VmaWxlICAgfCAgIDYgKw0KPiAgLi4uL21lZGlh
dGVrL3Zjb2RlYy9tdGtfdmNvZGVjX2RiZ2ZzLmMgICAgICAgIHwgMjE2DQo+ICsrKysrKysrKysr
KysrKysrKw0KPiAgLi4uL21lZGlhdGVrL3Zjb2RlYy9tdGtfdmNvZGVjX2RiZ2ZzLmggICAgICAg
IHwgIDcyICsrKysrKw0KPiAgLi4uL21lZGlhdGVrL3Zjb2RlYy9tdGtfdmNvZGVjX2RlY19kcnYu
YyAgICAgIHwgICA0ICsNCj4gIC4uLi9wbGF0Zm9ybS9tZWRpYXRlay92Y29kZWMvbXRrX3Zjb2Rl
Y19kcnYuaCB8ICAgNCArDQo+ICAuLi4vbWVkaWF0ZWsvdmNvZGVjL210a192Y29kZWNfZW5jX2Ry
di5jICAgICAgfCAgIDIgKw0KPiAgLi4uL21lZGlhdGVrL3Zjb2RlYy9tdGtfdmNvZGVjX3V0aWwu
YyAgICAgICAgIHwgICA4ICsNCj4gIC4uLi9tZWRpYXRlay92Y29kZWMvbXRrX3Zjb2RlY191dGls
LmggICAgICAgICB8ICAyNiArKy0NCj4gIDggZmlsZXMgY2hhbmdlZCwgMzM1IGluc2VydGlvbnMo
KyksIDMgZGVsZXRpb25zKC0pDQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQNCj4gZHJpdmVycy9tZWRp
YS9wbGF0Zm9ybS9tZWRpYXRlay92Y29kZWMvbXRrX3Zjb2RlY19kYmdmcy5jDQo+ICBjcmVhdGUg
bW9kZSAxMDA2NDQNCj4gZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9tZWRpYXRlay92Y29kZWMvbXRr
X3Zjb2RlY19kYmdmcy5oDQo+IA0KPiAtLSANCj4gMi4xOC4wDQo+IA0K
