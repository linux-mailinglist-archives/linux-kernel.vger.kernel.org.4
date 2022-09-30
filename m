Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB815F09AB
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 13:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbiI3LNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 07:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbiI3LNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 07:13:02 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FADC17C237;
        Fri, 30 Sep 2022 03:50:54 -0700 (PDT)
X-UUID: cb7d386817bb4ad991fcc0b7743e9dac-20220930
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=3kMyFSoCq4nJTKZc4jYi223ZQvPeMuH6ty0BoBf9n68=;
        b=TWa+1q43ASoKfG0SSgy6gMN64EB4o0BW9LlgsvAsCZHelEwQxUuaZgAkQZKhO3pXrs5qBnIoGHtyi5cuhh0oSLFrjmTQRbBpk/9lrd22SpogiPlxWZ5nwv/OwpQkuVsXRpf7j6EO+xljM2t123GnhXTMC2fuqqAbRrwdchtYwrA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:326e8370-af92-405b-ac75-a3fac82f3dcc,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-INFO: VERSION:1.1.11,REQID:326e8370-af92-405b-ac75-a3fac82f3dcc,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:-5
X-CID-META: VersionHash:39a5ff1,CLOUDID:d01aa2a3-dc04-435c-b19b-71e131a5fc35,B
        ulkID:2209301850516L70S0OH,BulkQuantity:0,Recheck:0,SF:38|17|19|102,TC:nil
        ,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: cb7d386817bb4ad991fcc0b7743e9dac-20220930
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 245708261; Fri, 30 Sep 2022 18:50:50 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Fri, 30 Sep 2022 18:50:49 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Fri, 30 Sep 2022 18:50:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jsd9ocS1mSNDJ16Bx1HmZ0BWkXQi8KGnyPyRqIlRZughz7x0Iyfb/6rCO3WbQpVfQwNlNqao5hHAXySBR0GTAQRfIpgsAoP2I/T8VJ3ect346O89yF6FPogXLsTxPFap0yeoeYwUVQf3n3eEgp10CApZNYKQSid0N8ZnLvaANhftujuGAdx5Y/axIw2HGnQt8LN9JWHEsoOnANYyQjeIa2RtYLdTdPgurYTR0IXYdYoyR9rTBMlT1ZDpcqPOS9aWgp76FiIJqM7rFPCVR5dNERm0+302TjTmAuxEBNRLgadpu6e3CbNTDmMLn+5aVJRDagM8MxLBZLsHnrek20fujQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3kMyFSoCq4nJTKZc4jYi223ZQvPeMuH6ty0BoBf9n68=;
 b=WP52G5fatMnDcX1Ex0InRM9dhU7kFsoKbqQBSzMPZfgGHE0g2ivwkV4VO2DHWNfsPiXjbrlTwcBLuYgrVPWKKypvoi36kmoezqXFfv5n8v88EpJ2P/Tl+gpIkvUYkITg1g8Lx1BfOt5Cur1l48E23LDwGfPXkV4S+mvHzeQJs+hTBFlItpaJWfXxTpecWmPYPDv7l8yPYYLpfiNfTksRVW8/rzft8nIKW1Stpkaf6MTCwA5X9uMNHboe/0ZAIDT+mJMvl/Gy2hv5BYxG+8baB0nE5Ze6V+EVSBNH4lVl/BgT+5r7m5NLGap6JfOZI4SmKUfZn/vjPr0n8ZUwde0lgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3kMyFSoCq4nJTKZc4jYi223ZQvPeMuH6ty0BoBf9n68=;
 b=Ttp3Zm8yFrDz+pIetJiW9uCZm67PGS5El/48hx5RdL0GOp2Ismcdjs3KXABD9kQ1Ufp6yRcqkDesTotB39moVyySrXRX2lUN/v3HRmKDG/36qzjIRCwtekzSyM5J5E6035UXiHBOEF6fqaWBK+SdmlqLOSudkb4C7xk8BMDFOXo=
Received: from TYZPR03MB6919.apcprd03.prod.outlook.com (2603:1096:400:28c::9)
 by SG2PR03MB4734.apcprd03.prod.outlook.com (2603:1096:4:d7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.19; Fri, 30 Sep
 2022 10:50:46 +0000
Received: from TYZPR03MB6919.apcprd03.prod.outlook.com
 ([fe80::1334:39fc:7259:5f6a]) by TYZPR03MB6919.apcprd03.prod.outlook.com
 ([fe80::1334:39fc:7259:5f6a%3]) with mapi id 15.20.5676.014; Fri, 30 Sep 2022
 10:50:46 +0000
From:   =?utf-8?B?QWxsZW4tS0ggQ2hlbmcgKOeoi+WGoOWLsyk=?= 
        <Allen-KH.Cheng@mediatek.com>
To:     "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] arm64: dts: mt8192: Add vcodec lat and core nodes
Thread-Topic: [PATCH v3 2/2] arm64: dts: mt8192: Add vcodec lat and core nodes
Thread-Index: AQHY1AWDo+Jzhc37RkGI1A0Aqd2S4q33p8QAgAAlLIA=
Date:   Fri, 30 Sep 2022 10:50:46 +0000
Message-ID: <fae0c4ba15b1fc502f6e4b257e2959dadab2b422.camel@mediatek.com>
References: <20220929131309.18337-1-allen-kh.cheng@mediatek.com>
         <20220929131309.18337-3-allen-kh.cheng@mediatek.com>
         <08017725-7e32-1967-65ee-246b9e692a95@collabora.com>
In-Reply-To: <08017725-7e32-1967-65ee-246b9e692a95@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6919:EE_|SG2PR03MB4734:EE_
x-ms-office365-filtering-correlation-id: fc976db7-581f-474f-78ea-08daa2d1a126
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 907rDeCHb82J07qUabbBXkR3Ln/euA383A4CG1AcYYjnRsoP3ndwYWQH7Fw6NOeycaKN1X9AVDaT1g++42zLNIxr4WPqUeJ06pDB794jTvQwy6USPGRTKj7y4UTvOc31ME+3drUochckl4LveKcACNBNGKkqqesOhaSQX0Av/krbDv/6qGrIL8YHUgGAlQO8q0ys/nttAxbmh8C6vD1usmYukjyuk9tkDWcgEaU+A3bMBAFHwxpc+ZhcypGxk+LHu8B/4DWwZubBUDcnShEnUJe2Sn87JzYeOomnTncsZCy4PKSQ1EcpIaLmcSEZGJzi9cEem8LhaDDWieW3b5w1fzeYvz6wb+owDfZUqZ0tiX6ydQRfM7Sz0pspY07uZEI7Br0k/aYSFgUNg+lbbdOgQm1qYYtBoJLmZNT3gwuIiMAX8T2V8Ilnc8xZN5aDXjdcdmsqu+O5REfl+0Bk1JdP0b/9dKsm5j00dkaAa0GDrOLmOEHhjufn8pUajdXH8sVeHnGD2QTQ0LqtlfkMDmY7XBeP2ta0O2/oGB3U08AofXpas2z65fC/btxaAhahbPhURzyMd6cYEU55aPCgNIRd02J8X0soqOzLgxkxGrvL2l8tJKf/FicAZab8JlZOUQYnc8oHztE4cK+h0hy3JGH4kTM9ItOrD71WEC7cgNsfCqEdygj9A8u+pdzkxipSfpNVB6rdlgW76/wbRB+LxS4HBfa21oI20CfXUn0H6gqs3+Hdu+gzeDGPj5h4MG/XvT9qxhKSGzeQbjAg/KmuzeclOP6530meaXnFy+GyJxuGFimbHQCntyS6jhcPN+AaLi0L
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6919.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(396003)(366004)(376002)(136003)(451199015)(71200400001)(91956017)(6486002)(8936002)(110136005)(36756003)(66946007)(66556008)(66476007)(66446008)(64756008)(4326008)(7416002)(76116006)(41300700001)(8676002)(5660300002)(85182001)(54906003)(316002)(478600001)(38070700005)(38100700002)(186003)(86362001)(2616005)(122000001)(6506007)(26005)(6512007)(83380400001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MmJCdmNiTGdOM2IyT1U4ZkpxSU8xeU55MU9iZmtkWHVnb005Z0RQS1BZVnF1?=
 =?utf-8?B?NXM5K0xkcjNKTXltN1NkVzdGWXRRNDVnN1o4Q0ZZRHpoQitVTXR3YXBaVnNR?=
 =?utf-8?B?MjBvZ08rZ2p1dUNIb1RxMlJjWVRnNkZ2bkg5bXRjSmZCcEJFTTB3UUdwM2wx?=
 =?utf-8?B?MkYzcnM2UTVrR1A0ZkVJT25HZ2RidDJiSk5UeHVUSk1HTHc5ZHNhTHJWU2lx?=
 =?utf-8?B?QS9FY2VMak9SdHJ6OCtXY24wT3gzTnF2c2I4UXdGZ2JOclZLaDNvVDdEbXRp?=
 =?utf-8?B?Rk9oYytlK3F2NGNVM1lJY053REM5cWQ1dEQwMC9ISGQ4ZVJCNng5dEt5ZkZI?=
 =?utf-8?B?WHFucXcraVpsOG1ya1VLemJvTDJWN0tTZEt3NC9jQzVNaEN0c3JlOVNWZEhJ?=
 =?utf-8?B?S3gwRTZFYm9mbXc3OEZJSnBoNWdnNmtSMmNndnNkZDRKNW04S2JPangyaHha?=
 =?utf-8?B?b3ZaNUVwS2VnZmJFTURnTUtvMWttd1RQVXZyVTFHSkNWdURXUUQyazhIcGNK?=
 =?utf-8?B?UGYxazlxOW5HQkhSNWszRW9uNlVmcFlJSWt5TVN1NFdLc1BXcGV5SkQ0RGt1?=
 =?utf-8?B?SCt4QVBldit0Y1VDY0tjSmFMVDNFQ3lzYTQzdjVDZGhwVHpGdEhZY3prWTRm?=
 =?utf-8?B?cUMxdUhQNHByMS9RbEo2eTc3eWJwRVhXcEZ4engxRUR2Rm40c2hHV2JCU2t6?=
 =?utf-8?B?SldWaXpQVUNHMGhESU92bjMwdFRTYlVidWRrQnFtSHNUb1JQaGxvdGVacWEr?=
 =?utf-8?B?N01HYkdFcEQrSGFIdnc2OFFzQkgyMWFTc1BuNjUzSTc3a3BXRGluSytpTzdU?=
 =?utf-8?B?MzVDL25EQ3ZTdjk5UWt6TERLVEMwWUNCVk5BeEV3T05PUmVySmU5VGtzbTdm?=
 =?utf-8?B?Z1crd3g3SUNZakdzMEdWSU1SKzByeTV5SlNkMEVUdzA5ZkZGWllQSjIxRVZG?=
 =?utf-8?B?NnpGVmMyZmxxblpwOEpHNUh2TzBkdlJTakZrakp3cHFyc1lXNms4VU1aUHl2?=
 =?utf-8?B?ZzZtK0ROZzE0K2lnaSsydU9jQnkxMWU3WkwzaWdVdEpFOFkwbGJhRmlvR0lC?=
 =?utf-8?B?bEZlQTRUNkxmRmRVem5DZS94RzF0WXFiYm80d0RQSWtiR0cydVhpZnFiaVBR?=
 =?utf-8?B?UWF2UVY0VmpGb3BGWU55VnV0Q2Uzd0Z1UXRyajFialU1QnY0VmZEZkYzNVRS?=
 =?utf-8?B?RytrZk9sa28vNnZ6dkhXYjR3NGx2dkNjWUlkUGFqODVpeUc2YTNGQmk2Z3U4?=
 =?utf-8?B?aDgya1FVejFWZkJ2cFB2aUNkWHE1d0hDc0NXL0xnZHZ4WlYyVFd3dmlZOEho?=
 =?utf-8?B?Z1NhQ3I0V1Q5TEloMzRtTkJvNjVZNzVOM2xTek9EYkVvNUZVaFprK2RRcmhT?=
 =?utf-8?B?Qi85YktTWUh1UWViUjhTaE1LRnRiRUJzMGRMQVJ0bWx0cUF0V29NNWkwWFJm?=
 =?utf-8?B?N2I3Qm1sQzVDM2tHUXRxbkgyMmhIYXZpN0V0dDdQQk9TbnFwYkJNM2RsZ3ZD?=
 =?utf-8?B?eTBObEVOUXJ4TmgzZjJqNzdqdEsxUGtpT2pzTm5XaWZSeXo2OTMvTWdoUmJD?=
 =?utf-8?B?bW9TNHlXT1pLTzFwTUZVcTMxeVpsLzYvZkNGaEVCRUNZWGszTDFYVVRnbHll?=
 =?utf-8?B?bTN2cnNXWVdRT1Y4WXdWaE1pN0F1UW5wME00MTJra1MyVWl4ak1KUjJrbjha?=
 =?utf-8?B?SFczMXpJSC9PbXI1QmR3U0V0eHFzdEUwMnF5bHFWUDJZRGJaOVJBVWRDVXcw?=
 =?utf-8?B?Z2JyWXhyUnR4Y2lDbUlJRjZPcmxVZ2FLMkYyWFc4elBUekNsTmZEVFNxSkdm?=
 =?utf-8?B?Qy80d01sSFVnRFp0SlBVNm4rZzVua3kwN3NXOHFyNHBFOW42T3lkcUlFZ3Nz?=
 =?utf-8?B?aWc2WDFxSFRERzVOeXovMVE3Wm1YWGM3VUtyTjFubkpkUkpMWXlGRDJIVG84?=
 =?utf-8?B?M0tvdDdnWitJU3RTUGFMSXhtWFdWRjM1bDBJOGJEUWVrL0ViM1JJVUhMSVc5?=
 =?utf-8?B?TTdBMUczbFBhTFhUWmFWS1NaNkwwUUtNWURiZFZtQm12UFFFZXdWYkZIamtw?=
 =?utf-8?B?L0IvTk03VUhHUzJBNTlROTRrVTh0T2tRWjNGb01uazR5ZUR3U3NtNmlrU3or?=
 =?utf-8?B?bkttNSt5UFpqMkFKR1FlRTB3ZFZ0UDQyY3dVS1dGQXQyNmtQNUwwR0JudUQ1?=
 =?utf-8?B?TFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D78EAE5B95E97D4EBB284F914CDFF4B8@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6919.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc976db7-581f-474f-78ea-08daa2d1a126
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2022 10:50:46.1395
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 116z34Ihu8V2qU3qJyfEru5rrSYV5xW+Ze0CcSZPgYkBGOggN0l9HziphTHYXo7QuMUNijZqgt9J9yvKeFKaMF8+WrvICsKDE2YcdpNsAeg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR03MB4734
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY,URIBL_CSS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5nZWxvLA0KDQpPbiBGcmksIDIwMjItMDktMzAgYXQgMTA6MzcgKzAyMDAsIEFuZ2Vsb0dp
b2FjY2hpbm8gRGVsIFJlZ25vIHdyb3RlOg0KPiBJbCAyOS8wOS8yMiAxNToxMywgQWxsZW4tS0gg
Q2hlbmcgaGEgc2NyaXR0bzoNCj4gPiBBZGQgdmNvZGVjIGxhdCBhbmQgY29yZSBub2RlcyBmb3Ig
bXQ4MTkyIFNvQy4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBBbGxlbi1LSCBDaGVuZyA8YWxs
ZW4ta2guY2hlbmdAbWVkaWF0ZWsuY29tPg0KPiA+IFRlc3RlZC1ieTogQ2hlbi1ZdSBUc2FpIDx3
ZW5zdEBjaHJvbWl1bS5vcmc+DQo+ID4gLS0tDQo+ID4gICBhcmNoL2FybTY0L2Jvb3QvZHRzL21l
ZGlhdGVrL210ODE5Mi5kdHNpIHwgNjANCj4gPiArKysrKysrKysrKysrKysrKysrKysrKysNCj4g
PiAgIDEgZmlsZSBjaGFuZ2VkLCA2MCBpbnNlcnRpb25zKCspDQo+ID4gDQo+ID4gZGlmZiAtLWdp
dCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4MTkyLmR0c2kNCj4gPiBiL2FyY2gv
YXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4MTkyLmR0c2kNCj4gPiBpbmRleCA2YjIwMzc2MTkx
YTcuLmZkM2MzYWFlYWRiYSAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL21l
ZGlhdGVrL210ODE5Mi5kdHNpDQo+ID4gKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRl
ay9tdDgxOTIuZHRzaQ0KPiA+IEBAIC0xNDQ5LDYgKzE0NDksNjYgQEANCj4gPiAgIAkJCXBvd2Vy
LWRvbWFpbnMgPSA8JnNwbQ0KPiA+IE1UODE5Ml9QT1dFUl9ET01BSU5fSVNQMj47DQo+ID4gICAJ
CX07DQo+ID4gICANCj4gPiArCQl2Y29kZWNfZGVjOiB2aWRlby1jb2RlY0AxNjAwMDAwMCB7DQo+
ID4gKwkJCWNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTkyLXZjb2RlYy1kZWMiOw0KPiA+ICsJ
CQlyZWcgPSA8MCAweDE2MDAwMDAwIDAgMHgxMDAwPjsNCj4gPiArCQkJbWVkaWF0ZWssc2NwID0g
PCZzY3A+Ow0KPiA+ICsJCQlpb21tdXMgPSA8JmlvbW11MCBNNFVfUE9SVF9MNF9WREVDX01DX0VY
VD47DQo+ID4gKwkJCWRtYS1yYW5nZXMgPSA8MHgxIDB4MCAweDAgMHg0MDAwMDAwMCAweDANCj4g
PiAweGZmZjAwMDAwPjsNCj4gPiArCQkJI2FkZHJlc3MtY2VsbHMgPSA8Mj47DQo+ID4gKwkJCSNz
aXplLWNlbGxzID0gPDI+Ow0KPiA+ICsJCQlyYW5nZXMgPSA8MCAwIDAgMHgxNjAwMDAwMCAwIDB4
MjYwMDA+Ow0KPiA+ICsNCj4gPiArCQkJdmNvZGVjX2xhdDogdmlkZW8tY29kZWMtbGF0QDEwMDAw
IHsNCj4gDQo+IFRoZXJlJ3Mgb25seSBvbmUgbW9yZSB0aGluZzogd2h5IGRvIHdlIG5lZWQgdGhl
IGB2Y29kZWNfbGF0OmAgYW5kDQo+IGB2Y29kZWNfY29yZTpgDQo+IHBoYW5kbGVzIGhlcmU/DQo+
IA0KPiBQbGF0Zm9ybXMgdGhhdCBkbyBub3Qgc3VwcG9ydCB0aGUgdmNvZGVjIGNhbiBzaW1wbHkg
c2V0IGBzdGF0dXMgPQ0KPiBkaXNhYmxlZDtgIG9uDQo+IGB2Y29kZWNfZGVjYC4uLiBhcyBpdCBk
b2Vzbid0IG1ha2UgcmVhbCBzZW5zZSB0byBkaXNhYmxlIG9ubHkgTEFUIG9yDQo+IG9ubHkgQ09S
RS4NCj4gDQo+IFBsZWFzZSBkcm9wIHRoZXNlIHR3bywgYWZ0ZXIgd2hpY2g6DQo+IA0KPiBSZXZp
ZXdlZC1ieTogQW5nZWxvR2lvYWNjaGlubyBEZWwgUmVnbm8gPA0KPiBhbmdlbG9naW9hY2NoaW5v
LmRlbHJlZ25vQGNvbGxhYm9yYS5jb20+DQoNCkl0IG1ha2VzIHNlbnNlLg0KSSdsbCB1cGRhdGUg
aW4gdGhlIGZvbGxvd2luZyB2ZXJzaW9uLg0KDQpUaGFua3MsDQpBbGxlbg0KPiANCj4gDQo=
