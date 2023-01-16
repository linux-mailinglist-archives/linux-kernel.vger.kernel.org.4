Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFADB66B86F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 08:51:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbjAPHvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 02:51:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231839AbjAPHvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 02:51:44 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2E726B6
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 23:51:41 -0800 (PST)
X-UUID: 99162886957211ed945fc101203acc17-20230116
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=gi6bOG2kitwcUAfKHd1CjU3v6VZQ65o289qqNEbn9iY=;
        b=RltAjyNKB7c0diWPRs+69JLnibL8wkI0tJ6FOrrVM5OnH3u4vm2+iRlO7vLiUNHWQUzM0zoxdXD4UeYMyPsYLrOB/MzGfAZSI2Dy6qZvJbKoC9ekpkBDCN60YjLr6x9Vc8hwi4qlvxO0xPlO/Jnh+Iq6OecxhuIxdl+HkMWMRxU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.17,REQID:7775febc-b9e5-4ba8-b15e-003eac8e9ef3,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:543e81c,CLOUDID:33485e8c-8530-4eff-9f77-222cf6e2895b,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
X-CID-BVR: 0,NGT
X-UUID: 99162886957211ed945fc101203acc17-20230116
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 522530010; Mon, 16 Jan 2023 15:51:34 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Mon, 16 Jan 2023 15:51:33 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Mon, 16 Jan 2023 15:51:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kB8B8o5RVv675nDc7WOIENoxEODrHzGLrerZHqKQ6XqJqZ1WR1P5OZlJ6NX6prlrB4KqEacUm+cxsL3CN0h1nP9xrk66fGrSg1CRxBATFMOArUxKo0po+kRrWz9wR/3UbqGFlEX7zmXN/TMdYvLRX/1H7GQSRXlKrm61bX0laydv/6e9v6+oc5m8aHdxE4y8XkXmBc6lsdhEiptLx6CIyEcWQ/4uGlZ/bE7k9n9O92Z12Gvui++R6WT1+NsuFno8ZhZM7Gzal22VdtyIWJF5+iWjJPkTrlH9ugqTQ3ulhMV/JlIy7jbNU0fvwj4DNu4LD5joIhcj/USghVCKMY/xHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gi6bOG2kitwcUAfKHd1CjU3v6VZQ65o289qqNEbn9iY=;
 b=g8fWKHC+1/znp/AqpA+BPilPKogcuyqJNkAAWs8G3PENMRhyhT/Co/mAq+PjhvjVHnV6b5LghnlTrD+SdO8mk1Khlom4y+oWDK6BGfuWgk3T/QYl0Lw4P4DiNPILrgtxveplEQcBbExhU760CIGJRk/Zafrs45eMgOVaR7iHyX1vf0NJS3T3/a9Z4PVx1oaYjxn2DoQaI6oy7rkRQiLGE49nPsOQ/7UYq96xGxvvTLuI17/3E6E2TMsB061KMxiGe0RsU1Jx03kgCw9OuD/WBJx4Nvx1S+C2uAzuIhRmFaOsg+BsLtUpPWo8lawp1Lz0DMtvPwkG3yJ4p0Gk7hjHmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gi6bOG2kitwcUAfKHd1CjU3v6VZQ65o289qqNEbn9iY=;
 b=uD/OyL+BvDPwC12LLw4Q/0Qsewm62z2LUrLEEPtdnYq6h2w1Mq2S/AryQ7jPnYB9P99mrH7yteGuwvHpwQJF1GL+3ZbKEfgQRcziTc+1dNYl3Rtqg4h87l3RnrOtZUd+Udge66zgg6OCyQ1krnWXkDDg5otG3yS8kfdcdW7acnI=
Received: from KL1PR03MB5062.apcprd03.prod.outlook.com (2603:1096:820:1a::22)
 by TY0PR03MB6533.apcprd03.prod.outlook.com (2603:1096:400:21f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Mon, 16 Jan
 2023 07:51:29 +0000
Received: from KL1PR03MB5062.apcprd03.prod.outlook.com
 ([fe80::5e9b:f4cf:8d7f:60d1]) by KL1PR03MB5062.apcprd03.prod.outlook.com
 ([fe80::5e9b:f4cf:8d7f:60d1%3]) with mapi id 15.20.5986.023; Mon, 16 Jan 2023
 07:51:29 +0000
From:   =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= 
        <Chunfeng.Yun@mediatek.com>
To:     "ndesaulniers@google.com" <ndesaulniers@google.com>
CC:     "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lkp@intel.com" <lkp@intel.com>,
        "nathan@kernel.org" <nathan@kernel.org>,
        "kishon@kernel.org" <kishon@kernel.org>,
        =?utf-8?B?RWRkaWUgSHVuZyAo5rSq5q2j6ZGrKQ==?= 
        <Eddie.Hung@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "trix@redhat.com" <trix@redhat.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v6 1/3] phy: mediatek: fix build warning caused by clang
Thread-Topic: [PATCH v6 1/3] phy: mediatek: fix build warning caused by clang
Thread-Index: AQHZIEA7g6q5Ep2afU2pWWp4HJGwLq6cu2OAgAQCygA=
Date:   Mon, 16 Jan 2023 07:51:29 +0000
Message-ID: <c657222a816d95b09d220569db1fdde2be747e7f.camel@mediatek.com>
References: <20230104132646.7100-1-chunfeng.yun@mediatek.com>
         <CAKwvOdnMF4LRhTnQ3Rg+q3hd7jm2tS0aTHmwU6isKJHL2u9Q-g@mail.gmail.com>
In-Reply-To: <CAKwvOdnMF4LRhTnQ3Rg+q3hd7jm2tS0aTHmwU6isKJHL2u9Q-g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB5062:EE_|TY0PR03MB6533:EE_
x-ms-office365-filtering-correlation-id: 924fb9c0-b8d0-4da5-368d-08daf7967a25
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xYTwfCeEleqSPOqoEtaE3RBt6rAkhT6fTZqB+VbSp7ANdYF29oPxUNO9aGtsScWd11KQbUnrX1lcBM3N6/B6IuQFomF2+AOYEgD0Kb1O25LBKbSHC/g1WEnTUe2tftsguMObBoEmH049xRnwwk6Bqv0ruZClgpA11Jpu+Wt2MRiW+sMwuauc7izwEjz9+8dlhy6a+qPqm7hmZDLmL6Bu7KYSuOWpj8dVRgDdirNxAUHPuCLJQ5CtDss9BQ8UPGdv9Wqvq8VLUWY40Ur/MG0UU1m3aQilL6ccqsgovE1JpW6UKmkJYo8B4dKfCYLIPmw9fKj8hur88N8MubX+s7PGRpMq1coSnzmbvTlLyRlY1NKmRMkWH3/oHUHnpeKUDe8t35T7QzPQ7TDyyje4nv+ZLxsCztgVEZeSy0yOffu1VC+xLSZ0Qt/3LPRr3lO54WooP05qdLdHsBtv6YIcZMHs+eY1AMrm3g3uAi3G1vTWPCeageeTW3dAQf6ftB8vplZNLOc0B2txnmwA8bwVAe3bX/uf8vAYTsZatLdP4cg7G3bF5Pvx2sbuLxi2qKlMZW4UPxBoj1R5VtvHg3A+Zq2ly3Fp2cH7Ut/9dVXDhkp9wpm13xn/zECm2Kx9gHrCnPwJB7+U1XdR0SuXzMhwv73Xoqhty1LMt9Ufsqrcly1DP43anQg2yvXaxCLwar4Fe5XNNvGQHw+A18uXHb0ZOQTJ7OzfcQhVCRYOSkGUwYHHIb8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5062.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(376002)(346002)(396003)(39860400002)(451199015)(86362001)(36756003)(85182001)(6512007)(26005)(186003)(4326008)(6916009)(8676002)(64756008)(53546011)(66446008)(76116006)(66556008)(66946007)(41300700001)(2616005)(66476007)(6506007)(316002)(71200400001)(54906003)(478600001)(6486002)(122000001)(7416002)(38100700002)(38070700005)(2906002)(83380400001)(5660300002)(8936002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QXE1d1hCTFJ5ZGl3Q1N0WDhhQkM5T3N3Sko0QkE5YUdzanNrTDlhNzEvMktT?=
 =?utf-8?B?bS9rOE94RVozK3IwTXJwRW9xSTUrVW1zV2Z6THUraVNLVW9JT3JFeUNBR3Bl?=
 =?utf-8?B?R0hwL1I4RVcyNFUyTjhEZHlicjVEWGpteFM0aDlueDJ3bFQxWFdzRG8wUFlN?=
 =?utf-8?B?OXdZa0R1NnAzYUQzY01ZMDB3bkpuc0xqdyt4THo2anZPTTFVUlpWYUdGT296?=
 =?utf-8?B?Z0FpVVM2bUxTVFYrYm9Nam52VlNWWEo4TWNla2NEZSttNENHVERQY1dXM1FT?=
 =?utf-8?B?ZFYrRTJJeDZkSEdWOWZzM2FGbks2NXN0UlZYeWxnRzNmN0FaeUlFRXBXczVI?=
 =?utf-8?B?QVhzV0owUmNXb3FINC9ock1IUXBuY1pYM2hsRzNLU2RmdldWVFNTR3h4M0VJ?=
 =?utf-8?B?WDFtVkYvb1BIQ044VUE3d2lRempKQjNMVGFJaUR6RkpIRGgvckVBMm53MG9y?=
 =?utf-8?B?NGgzQXhPL052cXVyL0JaVnd3Q292dXFQd3diU2VrdkgyWDczajJULzhxM05C?=
 =?utf-8?B?MGRWemRwd2xPWmRNbkZLM096ZENEUkFhOThBM0Rab0lNR0RUV092TXhGK0tY?=
 =?utf-8?B?Uk90cDBJWUkvMUNzcUE0MGN2bGJRcUhLR2VlNThGTGtUZS9VNGNBdE8zNUR3?=
 =?utf-8?B?dXA4cDBTNG9YRFFKdkw5L3VuODJlOGhrTTRzUGNHalBBdlNVaktwMXpqNjh6?=
 =?utf-8?B?VnE0TjlkMCtHZlZ6ODRaanVIR3g2WTlaeGVUaThvRHkxemlteHZZbmIzZmlY?=
 =?utf-8?B?VzNXaTU1d2R4OTdvK2laQ0Y4OWlFUTRkcEtOU08yTWFVblo0Q09lenVuV1Zh?=
 =?utf-8?B?WnhOYTRxbUw4L0N1RnZmaXYrYW1QdDczdkVlUHBla3pNTmIweHdNUzRxYUlv?=
 =?utf-8?B?aERWRzVIODR0UDZhV2xHYm5qRGdRZDc0Q3JsZ0VyY01hSjArMzE5V0pCOFUw?=
 =?utf-8?B?dHFzVDhVLzhZRVhwTXpsNzB3Sm5FQm9VejFuUDlhS1FEWXJpa2hhSnhtTVBH?=
 =?utf-8?B?T1RpZEVqZFdvUnBPbjVtTXBHaGsyZExvbGhFdm9tV20yS2htcjdEeXRIMzEz?=
 =?utf-8?B?cmJ5RVgwNTlrenRiM0pSd3BYcVdyTkZxc0pheUhOUkZLZnlZYlZzQlJ3TTN1?=
 =?utf-8?B?UlRtNkdmNnRyS2xtRkNUZElWZjRWNmttUGhsUytYMCsyKzV5WFZFZFFqQkYy?=
 =?utf-8?B?bW1RNFF5SFQ0ZHZXNGpwdk85VGdONVFYZnNpSTNSMW9SRVhyZFVMbXo0aHR4?=
 =?utf-8?B?eGVSL3lWVDJQNjZVTG9udHh0M1BPMStNenlsQmVONmJHUWtCOFBnbG1WMExP?=
 =?utf-8?B?KzlqWUNyVTVzcFhkRXdEY2hxUFk2NmdNdDc2SG5Ed2dJUktZNmVFSkpCUXdr?=
 =?utf-8?B?SDlaa3ozUnRGNldvZWJqYUxOV1NmalRGbWpKWHIyaUlTeXN4eXlDMXc2Z3FG?=
 =?utf-8?B?ekdQck5aTldwc01Ua1lweXpGTzJpT2ZFNUE3c1krZ1k2NUJ0bDVSaXFmRnND?=
 =?utf-8?B?Zm1aaTBsNHZ5TStZdnFHM3RBbWR2U01TelBFMk80YTZOSExJeTIxYTRxSWpH?=
 =?utf-8?B?ZHBqamVSOFN1dmk5dmNwek8yaDV1N0VrazJ5Uk5UTlJRNFB3RFArOUZhcytG?=
 =?utf-8?B?UHRKUFFoblZPK0FXRVh2aWVSRUMxemRHVzZwcFE0alA5NGxLdDEvbSttZUhO?=
 =?utf-8?B?Q0M1VGlNcnFtUEFIQWZSK1VMczN4NkdXQlBEbFJrU2l1elF6clVnRDBiRnVk?=
 =?utf-8?B?VmlZNzlOcVdwQTYxZVJVVTF5VjNHNkxUc2tqVExkZGlEdXJ2ZlhRQVU0Qms5?=
 =?utf-8?B?MTkyOUNkaG1PajZseFRpUUJ3b2JHR1ZVUzlsSDZQbEpNSVFDWDFFZ3d4T1pO?=
 =?utf-8?B?ZC9QQVBzcUs2TUlZL0EwOFVrNW5NWmxPaCtPbXovdFFmMFM2THpBRGN2SlV1?=
 =?utf-8?B?eWszbVJlYVF2WjdkUm5PU050bmI4UlVpOUt2TUtNVTU5OUY0R0padkN2N2Fs?=
 =?utf-8?B?RDhWeFJGa3g4bm9keVBYVGhyc0ZYbHpxMnVlVGduSGg3M01odTBJNGNyWkZQ?=
 =?utf-8?B?UzVIS29qTVJSWHhEWVU2SzhIQjV1Q3NjSTFqdjBGWElzZnA4TzhDNDJKeFY1?=
 =?utf-8?B?SlFacTVkVUI2ZUExQlJwc3d0NFJhS0ErNEdDMno5cHE5bEZyN1VXWlFPTlZT?=
 =?utf-8?B?Mmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D73C3348F969C6408E6AC51D06B089F3@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5062.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 924fb9c0-b8d0-4da5-368d-08daf7967a25
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2023 07:51:29.2135
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9mvipQQ8pinVfH92T62NjZHwAooev8sWTVEMYAwRaZnreuU8ZjkfZxpTANvSBfDEzasmye01exiO0LwKgfYERQseDL0UN6CakzTOPoz9OW8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB6533
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIzLTAxLTEzIGF0IDEwOjM2IC0wODAwLCBOaWNrIERlc2F1bG5pZXJzIHdyb3Rl
Og0KPiBPbiBXZWQsIEphbiA0LCAyMDIzIGF0IDU6MjYgQU0gQ2h1bmZlbmcgWXVuIDwNCj4gY2h1
bmZlbmcueXVuQG1lZGlhdGVrLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gUmVtb3ZlIHRoZSB0ZW1w
b3JhcnkgQG1hc2tfLCB0aGlzIG1heSBjYXVzZSBidWlsZCB3YXJuaW5nIHdoZW4gdXNlDQo+ID4g
Y2xhbmcNCj4gPiBjb21waWxlciBmb3IgcG93ZXJwYywgYnV0IGNhbid0IHJlcHJvZHVjZSBpdCB3
aGVuIGNvbXBpbGUgZm9yDQo+ID4gYXJtNjQuDQo+ID4gdGhlIGJ1aWxkIHdhcm5pbmcgaXMgLVd0
YXV0b2xvZ2ljYWwtY29uc3RhbnQtb3V0LW9mLXJhbmdlLWNvbXBhcmUsDQo+ID4gYW5kDQo+ID4g
Y2F1c2VkIGJ5DQo+ID4gIkJVSUxEX0JVR19PTl9NU0coX19iZl9jYXN0X3Vuc2lnbmVkKF9tYXNr
LCBfbWFzaykiDQo+IA0KPiBDYW4geW91IHBsZWFzZSBpbmNsdWRlIHRoZSB0ZXh0IG9mIHRoZSBv
YnNlcnZlZCB3YXJuaW5nPw0KT2ssIHdpbGwgYWRkIG1vcmUgbG9ncw0KDQo+IA0KPiA+IA0KPiA+
IEFmdGVyIHJlbW92aW5nIEBtYXNrXywgdGhlcmUgaXMgYSAiQ0hFQ0s6TUFDUk9fQVJHX1JFVVNF
IiB3aGVuIHJ1bg0KPiA+IGNoZWNrcGF0Y2gucGwsIGR1ZSB0byBAbWFzayBpcyBjb25zdGFudCwg
bm8gcmV1c2UgcHJvYmxlbSB3aWxsDQo+ID4gaGFwcGVuLg0KPiA+IA0KPiA+IEZpeGVzOiA4NDUx
M2VjY2Q2NzggKCJwaHk6IG1lZGlhdGVrOiBmaXggYnVpbGQgd2FybmluZyBvZg0KPiA+IEZJRUxE
X1BSRVAoKSIpDQo+IA0KPiBVaCwgd2h5IHdhcyA4NDUxM2VjY2Q2Nzggc2VudC9yZXZpZXdlZC9t
ZXJnZWQgaWYgaXQgZGlkbid0IGZpeCB0aGUNCj4gaXNzdWUgY29ycmVjdGx5IGluIHRoZSBmaXJz
dCBwbGFjZT8NClNvcnJ5LCBJIGNhbid0IHJlcHJvZHVjZSBpdCwgYnV0IG1ha2Ugc3VyZSBubyBz
dWNoIGlzc3VlIGhhcHBlbnMgb24gYXJtDQphcmNoIHVzaW5nIGdjYy9jbGFuZy4gTVRLIG9ubHkg
dXNlcyBhcm0vbWlwcyBhcmNoLCBpdCdzIGRpZmZpY3VsdCBmb3INCm1lIHRvIHNldCB1cCBjbGFu
ZyBjcm9zcyBjb21waWxlciBmb3Igb3RoZXIgYXJjaHMgaW4gb2ZmaWNlLiANCg0KPiANCj4gSXMg
dGhlIGlzc3VlIHBlcmhhcHMgdGhhdCB5b3VyIG1hc2sgaXNuJ3Qgd2lkZSBlbm91Z2ggaW4gdGhl
IGZpcnN0DQo+IHBsYWNlLCBhbmQgc2hvdWxkIGJlPyANCnRoZSBtYXNrcyBhcmUgdXN1YWxseSBj
cmVhdGVkIGJ5IEdFTk1BU0sgbWFjcm87DQoNClRoZXJlIGlzIG5vIHdhcm5pbmcgd2hlbiBidWls
ZCBmb3IgYXJtNjQgdXNpbmcgY2xhbmcuDQoNCj4gIFNlZToNCj4gY29tbWl0IGNmZDZmYjQ1Y2Zh
ZiAoImNyeXB0bzogY2NyZWUgLSBhdm9pZCBvdXQtb2YtcmFuZ2Ugd2FybmluZ3MNCj4gZnJvbSBj
bGFuZyIpDQo+IGZvciBpbnNwaXJhdGlvbi4NCk9rLCBJJ2xsIGRvIGl0DQo+IA0KPiA+IFJlcG9y
dGVkLWJ5OiBrZXJuZWwgdGVzdCByb2JvdCA8bGtwQGludGVsLmNvbT4NCj4gDQo+IENhbiB5b3Ug
cGxlYXNlIGluY2x1ZGUgdGhlIExpbms6IHRhZyB0byB0aGUgbG9yZSBVUkwgb2YgdGhlIHJlcG9y
dD8NCk9rLCB0aGFua3MgYSBsb3QNCg0KPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBDaHVuZmVuZyBZ
dW4gPGNodW5mZW5nLnl1bkBtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4gdjY6IG1vZGlmeSB0
aGUgdGl0bGUNCj4gPiB2NTogbm8gY2hhbmdlcw0KPiA+IHY0IG5ldyBwYXRjaCwgSSdtIG5vdCBz
dXJlIGl0IGNhbiBmaXggYnVpbGQgd2FybmluZywgZHVlIHRvIEkgZG9uJ3QNCj4gPiBjcm9zcyBj
b21waWxlDQo+ID4gICAgIGl0IGZvciBwb3dlcnBjIHVzaW5nIGNsYW5nIGluIG9mZmljZS4NCj4g
PiAtLS0NCj4gPiAgZHJpdmVycy9waHkvbWVkaWF0ZWsvcGh5LW10ay1pby5oIHwgNCArKy0tDQo+
ID4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ID4g
DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGh5L21lZGlhdGVrL3BoeS1tdGstaW8uaA0KPiA+
IGIvZHJpdmVycy9waHkvbWVkaWF0ZWsvcGh5LW10ay1pby5oDQo+ID4gaW5kZXggZDIwYWQ1ZTVi
ZTgxLi41OGYwNmRiODIyY2IgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9waHkvbWVkaWF0ZWsv
cGh5LW10ay1pby5oDQo+ID4gKysrIGIvZHJpdmVycy9waHkvbWVkaWF0ZWsvcGh5LW10ay1pby5o
DQo+ID4gQEAgLTM5LDggKzM5LDggQEAgc3RhdGljIGlubGluZSB2b2lkIG10a19waHlfdXBkYXRl
X2JpdHModm9pZA0KPiA+IF9faW9tZW0gKnJlZywgdTMyIG1hc2ssIHUzMiB2YWwpDQo+ID4gIC8q
IGZpZWxkIEBtYXNrIHNoYWxsIGJlIGNvbnN0YW50IGFuZCBjb250aW51b3VzICovDQo+ID4gICNk
ZWZpbmUgbXRrX3BoeV91cGRhdGVfZmllbGQocmVnLCBtYXNrLCB2YWwpIFwNCj4gPiAgKHsgXA0K
PiA+IC0gICAgICAgdHlwZW9mKG1hc2spIG1hc2tfID0gKG1hc2spOyAgICBcDQo+ID4gLSAgICAg
ICBtdGtfcGh5X3VwZGF0ZV9iaXRzKHJlZywgbWFza18sIEZJRUxEX1BSRVAobWFza18sIHZhbCkp
OyBcDQo+ID4gKyAgICAgICBCVUlMRF9CVUdfT05fTVNHKCFfX2J1aWx0aW5fY29uc3RhbnRfcCht
YXNrKSwgIm1hc2sgaXMgbm90DQo+ID4gY29uc3RhbnQiKTsgXA0KPiA+ICsgICAgICAgbXRrX3Bo
eV91cGRhdGVfYml0cyhyZWcsIG1hc2ssIEZJRUxEX1BSRVAobWFzaywgdmFsKSk7IFwNCj4gPiAg
fSkNCj4gPiANCj4gPiAgI2VuZGlmDQo+ID4gLS0NCj4gPiAyLjE4LjANCj4gPiANCj4gDQo+IA0K
