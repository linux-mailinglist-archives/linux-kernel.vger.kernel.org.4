Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEA14666E87
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 10:44:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjALJou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 04:44:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240041AbjALJnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 04:43:43 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F8851331
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 01:41:39 -0800 (PST)
X-UUID: 4e19a32a925d11eda06fc9ecc4dadd91-20230112
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=/5VwqV3hPLkDkuMfxdl5ciVhvo0wHmzf81yvra6Dwuw=;
        b=Dp5JPqVLY6P0HBCOU5bBsE0Yt3M97NSB50S1PQWxbsi+otNm6euCvBnysK0DcEQOndhuywcNJGWfknWNmQJYz3wR8Owo/ID99gr1oZ3cpQKTt9QD0o2inh3Q+MtzvlFcoZcfUqnZebYlFQ3qAtH8YqrV7++t73ECRiLFBDyraCU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.17,REQID:bdf6c8ff-3ba8-4f84-a8b9-3e1c4bae8024,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:543e81c,CLOUDID:0717108c-8530-4eff-9f77-222cf6e2895b,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
X-CID-BVR: 0
X-UUID: 4e19a32a925d11eda06fc9ecc4dadd91-20230112
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
        (envelope-from <xinlei.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1141210047; Thu, 12 Jan 2023 17:41:35 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 12 Jan 2023 17:41:35 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 12 Jan 2023 17:41:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OBllu3JsOqzbShWmgb2+Huezn4fePziTZEMru9rnftQar8TUp9/44f6fFvzWAouUHVowbt2KU24qMRYc+JcHr3Xbp21x1jgIRvgp7gQfmu8odgLuXmubJ5fDe0r+J1qqx3AYoAJ3Edm9Z6l8NQGnm9VzAL7WkeMGVHdpujNOpQPqEhxOt6r6Rff9IR6McfXnTlksgJORQ21Hm7UhJ1BKfz0+VBXszExlRxNNWBgeWq4H2WTS1ySwDMNpBfl9lCDre7dCJG1YN14tMg72OsHurWw2JoX6dNK95AapmLj3bxVBTdJzU2eRx4JU+wveDfZCygWSVOWSYc18ww/quH4iag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/5VwqV3hPLkDkuMfxdl5ciVhvo0wHmzf81yvra6Dwuw=;
 b=Yb9xVj7dviQOhPkwEn6jKWAow9wkFFusK+tD7P1kQ3BAwd0/mEBtAYZpmmUMgUpdO/TphlGz80CvkL3Y+gyD01YSGL/urNzfJi26VABrgHf9YgpvkmaU1HxyQKTHayj6FrmFtHqcrnkHXUADnG8+/nhUbB+FazM++TnNIs6w2QGhUtY6j4BCmAWJOM9JS5jHz8oQkkA/088jLIjibZudLPNKoyycDBPxMSJRu7arWh9/L0AH3NEA3Geg2kuRQwfPeWejGGxhss3BsLeR/SQOdd+voQYqpwFm+/6+O5+oz+Qol6R6DjWpKr44L4/VOB9mEOoFZrXwnA/srIDny2aRsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/5VwqV3hPLkDkuMfxdl5ciVhvo0wHmzf81yvra6Dwuw=;
 b=DPnEawXKUX6s0xJq4Ulh3RvH982WUZMAm+G/u/QUY1ICpxa2tiDX2HfaKik+EYQ+gAPeVEn1eKgEqnOlFcQeH8ESCJGJbgL4vWla4sKfYAv92ohYBCHVlo35uNZyJbsx1eqhi2y/Jtq+rSSK1eNseEg1AiAkhwxerj13lyeNAbc=
Received: from SI2PR03MB5339.apcprd03.prod.outlook.com (2603:1096:4:105::9) by
 TYZPR03MB7201.apcprd03.prod.outlook.com (2603:1096:400:337::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Thu, 12 Jan
 2023 09:41:33 +0000
Received: from SI2PR03MB5339.apcprd03.prod.outlook.com
 ([fe80::dae4:f894:f81f:7a2b]) by SI2PR03MB5339.apcprd03.prod.outlook.com
 ([fe80::dae4:f894:f81f:7a2b%8]) with mapi id 15.20.6002.012; Thu, 12 Jan 2023
 09:41:33 +0000
From:   =?utf-8?B?WGlubGVpIExlZSAo5p2O5piV56OKKQ==?= 
        <Xinlei.Lee@mediatek.com>
To:     "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "sam@ravnborg.org" <sam@ravnborg.org>,
        =?utf-8?B?Sml0YW8gU2hpICjnn7PorrDmtpsp?= <jitao.shi@mediatek.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [PATCH v2 2/3] drm/panel: boe-tv101wum-nl6: Reduce lcm_reset to
 send initial code time
Thread-Topic: [PATCH v2 2/3] drm/panel: boe-tv101wum-nl6: Reduce lcm_reset to
 send initial code time
Thread-Index: AQHZJLhKCJztQSAqiUyYj6GyN/qS3K6XYBkAgAMqmwA=
Date:   Thu, 12 Jan 2023 09:41:33 +0000
Message-ID: <476d3b25346c440d31db3704f7ba79185a94d6db.camel@mediatek.com>
References: <1673330093-6771-1-git-send-email-xinlei.lee@mediatek.com>
         <1673330093-6771-3-git-send-email-xinlei.lee@mediatek.com>
         <3b6c19a9-66ac-a18c-cb3b-144066077bd1@collabora.com>
In-Reply-To: <3b6c19a9-66ac-a18c-cb3b-144066077bd1@collabora.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5339:EE_|TYZPR03MB7201:EE_
x-ms-office365-filtering-correlation-id: dee1d215-9f64-4ab1-c6df-08daf48130cb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NInUcDGaLYbvve/J0kuak95MC3Jybrez5LDUZ/qXTTUBMCPVFeZbvtcIYcwmD0Rw8rSFOBtXZFmQia7Pd5dgi91maQ7YPmOEIFT05WrAweUeGvSaleInvNSfB50U8BJEJT6/bQiEZKxQJLdrfe0F+CHRVzFi4G2S6hfQqdKiFNs9sc3nAWejZTgxwdOulD58+LO6CSkcfkOn0RvsAbaPLTihWxG6qnTMmzvwS2cctJ8K+vKHWzxAgfv7QSh6M2GztztiOJspef+GJc8d28iE5TAqcDkNNs77/B8AsaO/l8ccY75L37fosn/aGhJ8ZMZ4nosPeMU3t85weW5d8GaUE0SX01d7+hUGeaTHZuyKP+Nj1tt9ApC/BAU4gyAxFs6QgoDODkNd6EaX3kM7i/Nbmg6AJ9yPQJM5p9kfcOKxygh0/2Ujb/8EAKIMzcmB977oq4Ym3oa8k5pRHuucURjxrgxGQNmNk+AQd1kMQ8e8xfgCD0+vZltRS2KqfwcrI1n4BQ9dftljuSWAvkPYO4Y6tWJLE8GDmjeLYQzCz9vVx9soOF7lek7HKLEkgO8vC8QSb29BTUHfTK5q5WRKYPAc7NOOHXoFcut3H/6Oargtngg/pADoNq9CNyzAl5ciSBHC3q0fjgkmuHDExixbVGI3LQ43TpMBp/L1Iu44JpdNWRZz4lgHO4UQa0C6p1ikj3+vdN2AA5kxyTkrqs42dHOU0W3HQ3MHc77RCDDu+gMecT4bE0X47m+3rPkPMsjvooFH
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5339.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(346002)(366004)(396003)(39860400002)(451199015)(8936002)(26005)(5660300002)(2906002)(71200400001)(41300700001)(7416002)(4744005)(66446008)(66556008)(4326008)(316002)(8676002)(76116006)(64756008)(66946007)(66476007)(85182001)(110136005)(54906003)(38070700005)(6512007)(122000001)(38100700002)(2616005)(86362001)(186003)(107886003)(36756003)(6506007)(478600001)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K1daVlpTSUEva2JZanpqT0VQVm91Q0VKOUZXTXVQckNUcEhWNGZuakhELy9D?=
 =?utf-8?B?ejc5Wjh4MG9VK1Q5N2g5c2RtaTczT2dBVmZpa0xXVnhDdnF6cTh3RVJvZDE0?=
 =?utf-8?B?dGFEVU56SWFKeHBIRGdPeXVFeDB5Z092OGRBVnJERXBuNHFnNk1sV2l5Yktt?=
 =?utf-8?B?UDhwelpYVzU5Z2F6QlpkcmFFa2xmU0FGbUI2M1puY0Q4MHBIS1ZieTlHa0Yy?=
 =?utf-8?B?TWFQU0pPR05zM0I0cHR2d1dZcU5nQ2J0eWRVUHQ5U1hvSTBnOXdVV0hRS2I5?=
 =?utf-8?B?QUlYbXBhZVJGK3VjWXNoMDh6ZnJTS1lVbzVPakswY2NVbnZGdkVNYXdoWUc2?=
 =?utf-8?B?TEpsd3dXV2FpSkJvcllhT1V1T1ZoMFpVOU8xYVZzVlBSMFFaVnNZbHFGRGhK?=
 =?utf-8?B?a2grckt0R2Z5OUpRWlVVVUVZTG45WG83b0t5eWNFeHRmbWh1Q1RnQ3pGTWhw?=
 =?utf-8?B?eTZ1a2FDdzlEem1obkRNRFlUYnJaSFRRNTIzb2d6RHpYVkhpYnFGSzVFczBh?=
 =?utf-8?B?QnZZZGYzUGlPTkp4MFdqRFNhZFFBTlVUYkk2OE9CWTROQmpRaTFOTjhDRzJU?=
 =?utf-8?B?RHg3VVd0d0pyeUU1a3NRcWNOY09MYlB1eXFtY2Frdzk0OGlKb25rYUNzVEZL?=
 =?utf-8?B?MHdac3libkJ4YjhSeHRId1QzZEF2NkNyaGdiWUUvcWhwMFg3L1dkR1gxUGV4?=
 =?utf-8?B?T25HV3J0K2RIR0ZQSVQyaGpGTEV6SGpWMWJ4UFNvNVA2V3I2bWlYK2ZyUCtH?=
 =?utf-8?B?ckJRdGt1WFRwZncwN2dmMFg1Ykhoa2M1REFaQ05DWVZQS2t4MFE4RWFEOE1y?=
 =?utf-8?B?UEpzeGdzOFlMVFExTGh5VVc2WHdFOFlTZ3RiZHpWYWhJcml3MWRMM3cxUkE4?=
 =?utf-8?B?eld5R3lqcndVelZvRlBzU2Mwdi9LcVV0b3JZbEt4SU9NVENBRlB0UXN4QWkw?=
 =?utf-8?B?YTdoY3JNc2Q3OXZLOFZlVEZETXlSRm5IZ29KYW9YMjlwNEVFZ1BGNTJVSStF?=
 =?utf-8?B?NHVsS2h3ZUs2WkVqb0h5Z3B3S0pHZVpkVHk5V0RpdVByYjRQbUphdldEN3c2?=
 =?utf-8?B?RFlSUXI2bmZUSlJzaXRDcDlpRkRpUGJndnBZeGhYRVR6RjFqaEZEc1lCNUtH?=
 =?utf-8?B?K0JRY1NxOERaaktyRFM0akx5amlUbDYyQUFFcFkzai9BRjB2YW14emorMnEw?=
 =?utf-8?B?MzFGV09IR2srKzJHYUR0Vysvak8yQ2Q4M2tRaXltY2JXYzRhTmpEZFNUYXVi?=
 =?utf-8?B?bzI1ak85UUQwQXk3Ty80M1AzSnpMS1hQMnFxN3V1T2hXc2hOWFBTdjc4bk1B?=
 =?utf-8?B?VXVMbTk5MjBTcmhkOEt3REZtKytNeWp2eGMvUUQ5UnhydzR1QTU0TWxaM2RE?=
 =?utf-8?B?OTdvblAvTldrVTNKeFpWTFNPRlFIdk5VRFF6eWpGN0hBdlJBY0NvUW9tWlEz?=
 =?utf-8?B?MDRWTEVpMGErcDk2ZFZwSnB2djdZYTcrQm9BYU14U3o3TUFrS003V1hjWEF2?=
 =?utf-8?B?ekFXVys1dk16YnJreGtkdkFNNUlocXhEQTdsNWJKK2JFMDRERUlQazJjMDVt?=
 =?utf-8?B?V1BtRWtweGdWQnJMd2h1VVF1dXgzL3BOU1RkOHFLNDhQdDFmSWFBRzJOUnlm?=
 =?utf-8?B?MWFURzNlTnlheDQ3cUcwT05TZGlwT09Rc0Z0bDRmM2E5US9vVjg4bWNjNWtx?=
 =?utf-8?B?bFBmRnVRa1Y1R3NLUi81NFBZVmtmajQrb3FyMllsYk8wdUQ5Vy8wT0loK2dI?=
 =?utf-8?B?dVpxcUEzNXRRd29qMloreGJDL2o1RE9mY056bGd1Mk80Z2VvNnN1WmRHVndM?=
 =?utf-8?B?cFFQUmpueko3Y2RZNjdTNHl2NHpmZUpLN0pwU0NVaktMWG5DUU9McEdXUTh5?=
 =?utf-8?B?cnZ2NDAwWjAyRFo4MitON2xiRjExUUlIL2dMYmhwUi9HaHc3bkRtVklQVkRT?=
 =?utf-8?B?cXpGeWQydXFHVFlqNm5Fc24xdnRsL3pHYnVGb0h4dEs4NzhQZzJha0svMzNS?=
 =?utf-8?B?K24vdEs0MGZOUmJFNHU0YjlNM1BHSFZTdEoxMkN6bHFvajlHY3JQNk5NT01T?=
 =?utf-8?B?bTdRNXhHUXIvYy9IL212RGFtMmgxWUN2ei9mL1dmYmFVa242c2tzOFB2UHFN?=
 =?utf-8?B?T0kvS296QWJ1QVFiVmhwZGlPQ2RIeXI5Q0NSQUNHV0JwQk5KYnI5dWIyZ0Y5?=
 =?utf-8?B?aFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0A8DE63FAE968843A9CC95D43F9A0DDE@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5339.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dee1d215-9f64-4ab1-c6df-08daf48130cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2023 09:41:33.2497
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p1Y0G++cHn4pOelnOtRegpH7539VeKm6zeGaXDX84w66ittzXRpqev9E+gbpgxzNfFsCaLXRzK8WHnyRE6YSwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7201
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIzLTAxLTEwIGF0IDEwOjIwICswMTAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gSWwgMTAvMDEvMjMgMDY6NTQsIHhpbmxlaS5sZWVAbWVkaWF0ZWsuY29t
IGhhIHNjcml0dG86DQo+ID4gRnJvbTogWGlubGVpIExlZSA8eGlubGVpLmxlZUBtZWRpYXRlay5j
b20+DQo+ID4gDQo+ID4gU2luY2UgdGhlIHBhbmVsIHNwZWMgc3RpcHVsYXRlcyB0aGF0IHRoZSB0
aW1lIGZyb20gbGNtX3Jlc2V0IHRvIERTSQ0KPiA+IHRvDQo+ID4gc2VuZCB0aGUgaW5pdGlhbCBj
b2RlIHNob3VsZCBiZSBncmVhdGVyIHRoYW4gNm1zIGFuZCBsZXNzIHRoYW4NCj4gPiA0MG1zLA0K
PiA+IHNvIHJlZHVjZSB0aGUgZGVsYXkgYmVmb3JlIHNlbmRpbmcgdGhlIGluaXRpYWwgY29kZSBh
bmQgYXZvaWQgcGFuZWwNCj4gPiBleGNlcHRpb25zLg0KPiANCj4gUGxlYXNlIGNoYW5nZSB0aGUg
Y29tbWl0IHRpdGxlIHRvIGRlc2NyaWJlIHdoYXQgeW91J3JlIGRvaW5nLg0KPiANCj4gZHJtL3Bh
bmVsOiBib2UtdHYxMDF3dW0tbmw2OiBSZW1vdmUgZXh0cmEgZGVsYXkgaW4gaW5pdCBjb21tYW5k
cw0KPiANCj4gDQo+IC4uLi5hbmQgdGhlIGNvbW1pdCBkZXNjcmlwdGlvbiBzaG91bGQgYWxzbyBj
b250YWluIHNvbWV0aGluZyBsaWtlDQo+IA0KPiBSZWR1Y2UgdGhlIGRlbGF5IGFmdGVyIExDTSBy
ZXNldCBieSByZW1vdmluZyBhbiBleHRyYSBkZWxheSBpbiB0aGUNCj4gaW5pdGlhbGl6YXRpb24g
Y29tbWFuZHMgYXJyYXkuIFRoZSByZXF1aXJlZCBkZWxheSBvZiBhdCBsZWFzdCA2bXMNCj4gYWZ0
ZXINCj4gcmVzZXQgaXMgZ3VhcmFudGVlZCBieSBib2VfcGFuZWxfcHJlcGFyZSgpLg0KPiANCj4g
UmVnYXJkcywNCj4gQW5nZWxvDQo+IA0KDQpIaSBBbmdlbG86DQoNClRoYW5rcyBmb3IgeW91ciBz
dWdnZXN0aW9ucyBhbmQgY2FyZWZ1bCByZXZpc2lvbnMsIEkgd2lsbCByZXZpc2UgbXkNCmNvbW1p
dCBkZXNjcmlwdGlvbi4NCg0KQmVzdCBSZWdhcmRzIQ0KeGlubGVpDQo=
