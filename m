Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 134C46588B0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 03:46:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232946AbiL2CqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 21:46:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbiL2CqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 21:46:17 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C30EABF72;
        Wed, 28 Dec 2022 18:46:10 -0800 (PST)
X-UUID: 391ae993fa1f41f6ab894c32dd2d2c53-20221229
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=tlisHqxuRow8ZxX/U9KU0J0bzQyBlwjZdOZw/miEPBE=;
        b=M8XYDruJEG+UnQV89Afny1DISPjHZUxw1F2qRE55hcjwItnPusxHbPcPOalfWS3Cq+Hvf65jN58huJEaUx8zGRYS4Sndpdf/9bmDGuuKMZEgz5LudkPTTGCYl1T+/qOQqs+2bJZ4y467wypAnwrkqUeSRAKTdwrbErgKVsbqmSk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:ed766764-3fd1-4ab4-99a6-bafc04212d98,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-INFO: VERSION:1.1.14,REQID:ed766764-3fd1-4ab4-99a6-bafc04212d98,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:-5
X-CID-META: VersionHash:dcaaed0,CLOUDID:ffc6b08a-8530-4eff-9f77-222cf6e2895b,B
        ulkID:221229001402FY3ZDSJB,BulkQuantity:21,Recheck:0,SF:17|19|102,TC:nil,C
        ontent:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0
X-UUID: 391ae993fa1f41f6ab894c32dd2d2c53-20221229
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <biao.huang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 34348179; Thu, 29 Dec 2022 10:46:03 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 29 Dec 2022 10:46:02 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Thu, 29 Dec 2022 10:46:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mjNDObO0HbYsuV/TX7EgFG7AxoYdo6J2b4mvQIJ6jZrw9PHvZAmPJzkpYUfNZdgnCZZXHHU4+rJVrY/CcCDKRYi40N36rIBtLxCXsBhNmuQiOE3RXx6/ZrSM2dZKOqSVrT4MQa6BguIPSeTQH2+rS/W1uJwlreWUTRTf03LcUKu1u8hezjC23n2SvlfZoXNawPCAHzOiL5QPTCJ8XfcQFW71miTDAl0f+XYxzHZ8TYamGj009ki3r5INDbG5BbGMqYNUSmzNu2NpLBMMlI6jRT0Y501Cgaf3Hxhw6BRrIkm6c+e2+5qgmuGlo2G+SmcRNaDfPR1gRowY8ATQTWdzNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tlisHqxuRow8ZxX/U9KU0J0bzQyBlwjZdOZw/miEPBE=;
 b=OLXz3orM5w1mizbVjWTmsFSzNKAgMcodoufO1CgCNwGt+EuIFqvlzTZDLTAG6ghs4ZVJ0RZlsOg9BDCVxhQ9ctHn1SwONMhqzRsig3Hw8gx/s9m6zpA12gUx+guShdxwbOzCsOafqhfK/Xcqg2KOHCYdtMaD+sLrFlmtePX/Kn3ixJw1XycYfPFS/yqozi9dZkJybolGunCmt2Moj3mfu0LlSMNDLxtlAEDrY4MEZUUTMu8dWuHvjfZGtcUZsuxfCT8A7QIdnIC2C3LWAroSP8gYwUBrhoPPUPbrxbxzSyY/Eax7TOJxtAEPOi3RJUEqWnJ6R1fVh71mtyKNwkRvwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tlisHqxuRow8ZxX/U9KU0J0bzQyBlwjZdOZw/miEPBE=;
 b=H019SeHaEiHQY0NEZ+UNWnwmEKUQjWQraA3LERe0g8GRO0JSAQ94yA+1yF5RdgxT/mvTVPJrLgBzhAuAwC4ApLxsd95qo0iH+bAIM5fN4oSyDy39vocDkGpP8W60rApYPwnnOiuf8+v00bkEeqiZ0/mJLeSe90HQF1atXMhTfAc=
Received: from PS2PR03MB3877.apcprd03.prod.outlook.com (2603:1096:300:39::13)
 by KL1PR03MB6114.apcprd03.prod.outlook.com (2603:1096:820:91::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.16; Thu, 29 Dec
 2022 02:46:00 +0000
Received: from PS2PR03MB3877.apcprd03.prod.outlook.com
 ([fe80::6937:eb54:1588:eb56]) by PS2PR03MB3877.apcprd03.prod.outlook.com
 ([fe80::6937:eb54:1588:eb56%6]) with mapi id 15.20.5944.018; Thu, 29 Dec 2022
 02:46:00 +0000
From:   =?utf-8?B?QmlhbyBIdWFuZyAo6buE5b2qKQ==?= <Biao.Huang@mediatek.com>
To:     "andrew@lunn.ch" <andrew@lunn.ch>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "peppe.cavallaro@st.com" <peppe.cavallaro@st.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "joabreu@synopsys.com" <joabreu@synopsys.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "alexandre.torgue@foss.st.com" <alexandre.torgue@foss.st.com>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "richardcochran@gmail.com" <richardcochran@gmail.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        =?utf-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?= 
        <Macpaul.Lin@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v6 2/2] arm64: dts: mt8195: Add Ethernet controller
Thread-Topic: [PATCH v6 2/2] arm64: dts: mt8195: Add Ethernet controller
Thread-Index: AQHZGoaQLWNCbcEVOESuvZ0VXpAHRK6DeaUAgACOA4CAAAbrgIAAG44A
Date:   Thu, 29 Dec 2022 02:46:00 +0000
Message-ID: <5b4df04a2b99c3a09820608c3382f2ddc82e5eda.camel@mediatek.com>
References: <20221228063331.10756-1-biao.huang@mediatek.com>
         <20221228063331.10756-3-biao.huang@mediatek.com> <Y6xrNAyvJhP22RdF@lunn.ch>
         <a3959ffb49cd8ab2f3b0fad5149c222b08fc2032.camel@mediatek.com>
         <Y6zoI3XYnFFbN/Z5@lunn.ch>
In-Reply-To: <Y6zoI3XYnFFbN/Z5@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PS2PR03MB3877:EE_|KL1PR03MB6114:EE_
x-ms-office365-filtering-correlation-id: 25c7cdda-ca1d-4756-83b4-08dae946d1a8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b77HAsSDApWkQZPSf2+5gazdW8BV2AZLya2esiwNijZDXQjArc3cCfRXcIghMbkPEaYj/ZGTCr4JT/D9j8WazW8mVFqf+XsRk3zqA9NyZbmWjgxesTx+2fFt8jZMUVF61+aEitbPsoCYAX3Do5PfAGS0VaLcw35pikD/XyeESGrhYyrwO1WRu53mGEW98pM4B7IVsYM5BRdRnlCiMhJ/QW+2WDq6pGupJHPraeDN9jcYay50K80sEV8GpnRGJoxxWJtHuAr1m7WSsm1b7V7vGljwmtwBhmws7579vBowTwhMi8OHxdPyyJG8LrQWcYoYC2WRLt7N47Cg7ck1N3aNKS5Pw6t2oKMNUFXUIE9Kf8cfx5+zSaKUoG8SFfo4iDDHchIWpwMzfXStQMWs/DctHMPednQiC1l3uIHfYW/d9BnpTxNOGnUt33wRxaClC7PDId0Nsl6ykqDHiFkVe09XEaecb4s6AZkhpb8O7gcsDoZ9bsb+suguby6aa7QdnSQWxw/UsbdiveD8ZkGDu9g5j/n0H6ORDjGIz2GEMEZC9NXWDtuNv2IJZPRoc7iN7AkQEHLztbWhbtHqimsfb1D4Eg97ZMafRlnbX9wxusyGgy/rwT4VAsWKfgo75ha3sTyrk+yMW9w27kefIyglzzeDLDU4EREegzp5iDT7gFdUm1evgVjik4tt0DTH50yyPQEYQAwFDHaOdXaWR7kSoo37tQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PS2PR03MB3877.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(39860400002)(366004)(346002)(136003)(451199015)(6916009)(54906003)(2616005)(316002)(36756003)(6486002)(6506007)(85182001)(478600001)(26005)(186003)(6512007)(71200400001)(41300700001)(86362001)(38070700005)(76116006)(38100700002)(66556008)(91956017)(66476007)(64756008)(8676002)(66446008)(66946007)(122000001)(4326008)(2906002)(4001150100001)(83380400001)(8936002)(4744005)(7416002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NVhmMWRKcDZ0NUZidWtOcVMyZW1XQlAyemdJZnU0dW1QalFCZ1FSUTcwci94?=
 =?utf-8?B?WHE1SklXblkrOFZNWmRCamwzYWxNc0VDanRoQjFGOUwvTi9SdUl1SnFYd3pk?=
 =?utf-8?B?enFaSHdiclJJYm00dHRxSXI5MU95UXhlODRaTktqT0N3L01UVGZXVzJuRTNQ?=
 =?utf-8?B?akNLNVNseUdPa2tDUTZFeGlQZlhJRklQaXJKbndNUDlsNlUzclQ4U2ZzV3Qv?=
 =?utf-8?B?V1lrdEZqampuVlNzd0VhRUlvd3l4anNLR2FGK0ZxdDhJT3oxSFN2a2hPVmpJ?=
 =?utf-8?B?L1Z2dTRMdWwzK3N2MUpKcGRsQVNHUWVhMzZMaXQ5Z25OZkRlNGJHR2Q4SmZP?=
 =?utf-8?B?OU82eUU0Znc1U1BabjY4UW1jeWdUb0hFbEIySEZpYjJhS0syWitxUVNuRzJw?=
 =?utf-8?B?Y0Z6a1FWTEthV2lBejN3Z0NYRlJPVGdneloyeklWdHNvYk83Yytnb1o4UWtw?=
 =?utf-8?B?aTlhOS9XaFAwRzA0d2JPellteEtCbzhUdUlDSStQeUNKNWk1eHZrMnQ1MVdI?=
 =?utf-8?B?RlNZQmdGemEwNjJVTVBWekRJLzJQQUtnQ1NMUmU3ajRoVSsyMjFzOUN3YTlz?=
 =?utf-8?B?d0hST0RDNFprQUFDUXFIWHBVUTYzVW1KYm01dzZHVVNxZkJkQWJRTTFwUFF1?=
 =?utf-8?B?dWNnVWw0TzVEcG5VcjBJVXBrajJZMHd0Vkg0aU8rYlFSVllycUhwbVU0VU8v?=
 =?utf-8?B?R2tqM25GUkRMK2I3azNwZlJ4UndPMUN2WEFSWmxFY1RVRUlUTGlQYUhPNUVy?=
 =?utf-8?B?ZVNHeFRvbEhYczBMWnJLRHNwOEp4Rnd6WnFnRVF1V1I1eEJ4UDRWQndpRkJS?=
 =?utf-8?B?OFFNMzRYQmpYR3BRN3RmZGwycE5FY1Zmbzl4ak1ERldoNHpwZEtjVXJObll4?=
 =?utf-8?B?NjJ5STdBOGoveEwzV2t3d1NEK3g2THdhVk9OaWNHaUh6U0ZPakY5TVYwbmJD?=
 =?utf-8?B?d1JXY1RSL2VZd21vaGtxSXY5R2ZtUld2TUpWWE9qZkkyNFRPdjhiMnp1c1Rt?=
 =?utf-8?B?TnRPRVkvNGFGU0VEUFZ6OXplNEk4clVpcExjV3lFQTZDbVNLZnN2Rm15QTlD?=
 =?utf-8?B?dWw3Z05XanBFaHpNbVEyRUlpWlp6SmRBTzRjZ3JYUHM3WVhZdEpnQ01oaXZW?=
 =?utf-8?B?SzBhdXRWSUtzbDcrUC9la3Y1anJtTlhNUFd1TTdRRGxMbWtVbVc2SURqemdW?=
 =?utf-8?B?eHlZcCtPMkFONzdRUnIzcFNlSzhFbi9VeFRwUHpjRHI0MEVqWVdlYkE1dDgz?=
 =?utf-8?B?MStBMUlkUHdva2RXa2krM1VvLzkzdmlUbE9UNU1JN2phN25FeGRFZGVmYm51?=
 =?utf-8?B?aDVUVXpRMEdWZUxOWlNOZSt0SlN3WlRyelNtcjZQVEUxbGJjQnhBUXE4STR2?=
 =?utf-8?B?WXVRWks1Q29KRXRzWlJaVHNXd0ZOZXRueXdUMTN1bG5zbmpSM3ZmYWV0ZEZM?=
 =?utf-8?B?UTRPYnRNWjlJbEJkR2ZsNUxxZnNvMUhBZG8yRWtJQkxYQ3Y5d2tyQzkwT1Uv?=
 =?utf-8?B?d1o2d1J6cG04TUU1QUJoWCsyVytKeWJqZzhtSmZDallkS0xiaDNHZFg0OG0z?=
 =?utf-8?B?S21HUEtNWHFMUkdYTk9mcHBxajYwOXZFN0hJbDJEMTR1RGFjWGxYYzBzS2Rj?=
 =?utf-8?B?dERiTk82MDdVR1VEODVlNWNCZHVZRlFqSUVMd2FWUU5RaHJ5a3dLcWhnTldv?=
 =?utf-8?B?N213M0lYb29HL0JYMi9MV3NjMVRBT1JBWjJ4WXM0ckdod011b0VUL0Q3TmQy?=
 =?utf-8?B?Ykgxd3FRTGcrY3JEL0FSeXUvcVlPT0ZERWRLN0MwTVE0cnpNT3dvYWtZTFFk?=
 =?utf-8?B?M0tjNzhiSE9YbXJrSlhKd3ROcVk0ZnhVd3hBd0N1WEYxeHdESXZ6S3dCb1JI?=
 =?utf-8?B?TjQyQTNzc2NRTlBBVWRBWk42bUVzMVdrRkNnYjJTQnAvRjdOSkRVMGprT0ZH?=
 =?utf-8?B?RmJCeDVDekNSOThablZEbTNpeGRvSkhZc21uc3ByRkZ0SXJ1NVNrYTFZSzFY?=
 =?utf-8?B?dEtSVG5CQkEzNnF5ejlKS2VlbElIaXZXOUJMblI5VXl4T1cxWjIvRXBWeHcz?=
 =?utf-8?B?bHVqNTZzQUpSUnlwZ0g0djJvV0JDcjRSaDRkRHhtWXQ0WWVFTTlWOGlIRFdM?=
 =?utf-8?B?VS95MS92ekJCbVBtcUF2MWRPbHN6c1hxQ09IWGlwdFhkYWFScytRazJNU0hu?=
 =?utf-8?B?VHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3310C9269571064ABE34563247AAB744@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PS2PR03MB3877.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25c7cdda-ca1d-4756-83b4-08dae946d1a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Dec 2022 02:46:00.0498
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G8pRwS+qu4PUMQMiq1N7BmVZJqnwv2tz7vRCC8NKA7rtMuQWdRCOj3Lh83lskFaBVn0AvolH6PINNfsCim50yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB6114
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIyLTEyLTI5IGF0IDAyOjA2ICswMTAwLCBBbmRyZXcgTHVubiB3cm90ZToNCj4g
PiA+IElzIHRoZSBQSFkgaW50ZWdyYXRlZCBpbnRvIHRoZSBTb0MsIG9yIG9uIHRoZSBib2FyZD8N
Cj4gPiANCj4gPiBUaGUgUEhZIGlzIG9uIHRoZSBib2FyZCwgYW4gZXh0ZXJuYWwgZGV2aWNlIGFz
IHRvIFNvQy4NCj4gPiA+IA0KPiA+ID4gWW91IGFsc28gZG9uJ3QgbmVlZCB0aGUgY29tcGF0aWJs
ZSwgaWYgdGhlIFBIWSBjb3JyZWN0bHkNCj4gPiA+IGltcGxlbWVudHMNCj4gPiA+IHRoZSBJRCBy
ZWdpc3RlcnMuDQo+ID4gDQo+ID4gQnV0IHdpdGhvdXQgdGhlIGNvbXBhdGlibGUsIGl0IHNlZW1z
IFBIWSBkcml2ZXIgd2lsbCBub3QgYmUNCj4gPiBhdHRhY2hlZC4NCj4gPiBIb3cgc2hvdWxkIEkg
ZG8/IFRoYW5rcyBpbiBhZHZhbmNlLg0KPiANCj4gQ2hlY2sgd2hhdCBoYXBwZW5zIGluIG1kaW9i
dXNfc2NhbigpIGFuZCBnZXRfcGh5X2RldmljZSgpLiBXaGVuIGl0DQo+IHJlYWRzIHJlZ2lzdGVy
cyAyIGFuZCAzLCBkb2VzIGl0IGdldCB2YWxpZCBJRCByZWdpc3RlciBjb250ZW50cz8NClllcywg
SSB0cmllZCByZW1vdmUgdGhlIGNvbXBhdGlibGUsIGFuZCBQSFkgZHJpdmVyIGlzIGF0dGFjaGVk
IGFzDQpleHBlY3RlZC4gSSdsbCByZW1vdmUgdGhlIHBoeSBjb21wYXRpYmxlIGluIG5leHQgc2Vu
ZC4NCj4gDQo+ICAgICAgIEFuZHJldw0KQXMgdG8gdGhlICJDb25maWRlbnRpYWxpdHkgTm90aWNl
IiwgSSBoYXZlIGFza2VkIG91ciBJVCB0byBoYW5kbGUgaXQuDQpIb3BlIG5vIHN1Y2ggbm90aWNl
IG5vdy4NCg0KQmVzdCBSZWdhcmRzIQ0KQmlhbw0K
