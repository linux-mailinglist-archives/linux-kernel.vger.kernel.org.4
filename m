Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CCAD6194F0
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 11:57:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbiKDK5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 06:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiKDK5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 06:57:43 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B98F12B63E;
        Fri,  4 Nov 2022 03:57:36 -0700 (PDT)
X-UUID: fc97aaf43a3f46a7a7ab07dd608b5a2d-20221104
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=ekpc+kkSPBZJbrvo4I23E9sejUB0sj86hTbhVAa5sJs=;
        b=ftVjQincwRfZMNdBkGQ5kHGDl0N3OIeuyOiCquf00tI1YUiEz6LzeWtsV66e7u9O4RdtOgh1vIZz/k4AmcnhZA1OKAupoGpgFGXIPK2hhQluNQKTPYIYhiFL6DvbD75vEfXqn2VeyBEAM+wS0TvgzzhoaaK/QlIpDjovJXAZi1Y=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:10d223ae-9bc8-4a93-be63-ed8be2d890b0,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:62cd327,CLOUDID:bfaf9b90-1a78-4832-bd08-74b1519dcfbf,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: fc97aaf43a3f46a7a7ab07dd608b5a2d-20221104
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <nancy.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1172555540; Fri, 04 Nov 2022 18:57:31 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Fri, 4 Nov 2022 18:57:30 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Fri, 4 Nov 2022 18:57:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=domgjQuzVLi8U7bRWpoAGEg6lsFKgycoAaZlCXVNJdHSvoFzr9EjstkJWnWNblEiHMs9uYTgSilZVymVd2ODsW9/hfS6xzj3nnua2WKFfS5Xb5fTu/hDvD/weku/ur9phb/P4DlKE8yozvvt7AC0HUKGsdhei2DkNNpD+rDmmicv4GNkqNpLaMuS2lLzOSAEbKuc3cFfMRiRkwCoqGXQYBW+2DkOhYd7b14E2ZoNQjD88Ips5R2jdjO7rbpSXY1e/JGHGp623ZDjmu7tR1Bby6oJWtvyf0rfotHjcEBaiW4MyyJLbmpTgz9evDfT84tHWFFvOpryTZlClVRYCGUU7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ekpc+kkSPBZJbrvo4I23E9sejUB0sj86hTbhVAa5sJs=;
 b=j5QjiqLw5JlG9xi0kTgTDq8h5NXUa1x2syohrL1ib0uiq3GE5ey9Cj0Gnx8ib/6WzgqPHhSScANPKgqOWq4jZz2EYD1mS6i4cUaNtIw5q6mMiIBm451DO3xXefBL1g/7IBfUa1gZuWYsyhCrgHN9qD7/cA8FesfoREPzdqFQZJL/RN2iuoXPgVV4WWXJKvuW9kO6Dt2vSRAhLD8Z7aVJ197ZIJio/w39ChQz1fsWaRSotBSZllja2O8H58znQ6+kEqY2xnOifRGqAfz8hKeWwWP1Gl2/sV1P3V0gMy1e1Nn5KszJ/DT8EvBwxvrwkKL2kEF1zcYvNBulF3VhbP6eKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ekpc+kkSPBZJbrvo4I23E9sejUB0sj86hTbhVAa5sJs=;
 b=AKJQd3YoNHBUA7D2E+UP8xw0e07bx+fD5soNa1gV+pirYhiMCP2z3vhDXvc/NguoHt2e1Ln4O6LJJdmj0hLWlaCbY7BD/lXGpW9g8D61JbAn9mVJ6LAOe/kfACukRZduhXggk43HfK8gKBzMDztQC4VG0oVKeYLiDybgM1A2QSU=
Received: from KL1PR03MB5175.apcprd03.prod.outlook.com (2603:1096:820:8::11)
 by SI2PR03MB5353.apcprd03.prod.outlook.com (2603:1096:4:10e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Fri, 4 Nov
 2022 10:57:28 +0000
Received: from KL1PR03MB5175.apcprd03.prod.outlook.com
 ([fe80::8cda:5c09:3c2e:19]) by KL1PR03MB5175.apcprd03.prod.outlook.com
 ([fe80::8cda:5c09:3c2e:19%7]) with mapi id 15.20.5791.020; Fri, 4 Nov 2022
 10:57:28 +0000
From:   =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>
To:     "nfraprado@collabora.com" <nfraprado@collabora.com>
CC:     "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        =?utf-8?B?WW9uZ3FpYW5nIE5pdSAo54mb5rC45by6KQ==?= 
        <yongqiang.niu@mediatek.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        =?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        "nathan@kernel.org" <nathan@kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>
Subject: Re: [PATCH v27 6/7] drm/mediatek: add drm ovl_adaptor sub driver for
 MT8195
Thread-Topic: [PATCH v27 6/7] drm/mediatek: add drm ovl_adaptor sub driver for
 MT8195
Thread-Index: AQHY7zQjsuueUcpoK0yAZQbxvWc0mq4tt+MAgADiJwA=
Date:   Fri, 4 Nov 2022 10:57:28 +0000
Message-ID: <82f99ec0d0150d7625e87fe6d5aba58382c8aec4.camel@mediatek.com>
References: <20221103032610.9217-1-nancy.lin@mediatek.com>
         <20221103032610.9217-7-nancy.lin@mediatek.com>
         <20221103212800.43nxlxpconqkasvc@notapiano>
In-Reply-To: <20221103212800.43nxlxpconqkasvc@notapiano>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB5175:EE_|SI2PR03MB5353:EE_
x-ms-office365-filtering-correlation-id: 300360fa-b34e-4b64-2826-08dabe535d2c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KtVhDEw9s8uU2cNWWA+vCis/BziQy+0B3GoGL5wsk/gJVsq/4KqgDay09UJUPMhq+u1dwG3UXs4v8iiNxzrKUSnExxEcm1vIldUduy1GjaDlaUBkMj0dqwHs2VJwULgsAreiWykzkuaqNikVgXPft/WvOiru5g3u7PuITyuZjJMTssBkmSCcOq/va8LL7EkcJawYamMd4CLDCHfAOBi8Kh7HllkzV211Vbrnn14hccaW54cG2fs9faFa3P+SxtKofJk+JxGJFJ87O+qrXc3JQGoH1JrciLEDziOM0VOuOnXZaWpwospxNxABk+7OcqSsjy6ia6eWM1GV1PD824gQXs6TPUdBF9en7vO5RhqueHpO/+t719UFJiLuX/3oH9dLHIyCLnD0tBA4QL3DxGGY5/Ll1ExaLhdZNqoJiD1tqfYvAFtAdfUAAVAipuoVE50S0gDGu7cZVZ5qQ1kJUUwwE70y5Ekwd/eDXKfgg7M2DjUCSuXti7wrFsrRhOUvbBi+3suctVdUNJx/9OrkijTLFSvgfjoxKil5jWopQT7y04ghSg1Xhqdu2hlZFSI/jnrafcGl5Kwz5027PogXyBWG9mTtn8feU16j/s9eQUjdnd+GZvem3+aBwjwkoElvM4GBpheU0eBrQdAu0IZyf4SVL3aeAwKzii5TyvtFpQ5X0VJVHfgM9KLPRchm+tTmG9AWBquV6zmZ+igsJpXT01qWffB8zXjLr9EEvsS78hMb/yeUmaqlvYCJdEHRWo482Pkl+Gy5QX5NVVCA7j3jLRdB0iYvVauN6dgIjg53DE+EW7U4XjPSptoe9MZKWNPdQjfphZgcvJBVjpM61gx3oE3VRqm6cluaEhFJr65dRVJr2vwCw3mLj3K2UxwpYlIU00RHfvek0cCEzKE4xYooT0278Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5175.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(136003)(366004)(346002)(376002)(451199015)(7416002)(38100700002)(6506007)(6916009)(6512007)(26005)(122000001)(316002)(54906003)(85182001)(86362001)(66946007)(66556008)(66446008)(8676002)(66476007)(4326008)(8936002)(36756003)(478600001)(5660300002)(6486002)(966005)(76116006)(41300700001)(91956017)(71200400001)(38070700005)(64756008)(83380400001)(2616005)(186003)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bjJ0YVhKUUtIL1d3L0FYb3k2eWJ6eHpRU0hVb0xKUmFGZEZ1ZGZPeGUyalM4?=
 =?utf-8?B?YnJ3eldXMzRBRlhXZkpTTDFTOEh5Qmd4L1lKdVliYTFRaXkrTStzejNXNGJz?=
 =?utf-8?B?aTRBRjcxYURsZi8zMFNyNDB2c0twODdWUlRWb01wbitla2hGa3NycmhlT1N5?=
 =?utf-8?B?VGVVLzRMWXMrWkY1OHQ5WDdORnh0aHRBc2xPMjlsdk9LdjFGQzZVc09hb3hl?=
 =?utf-8?B?Q1ErUFA4M3dVeGE2c1ArcFVlVlBsZ090Ri9uNTdaaUVPd0orS1BqZTlaL0NS?=
 =?utf-8?B?bXoxa0JuZjN2RjhaOWhmSWhIcjRUSkgra054RlRGalE2WVgyb0FzWUM0UWF2?=
 =?utf-8?B?eXhpYWRqd1RlN3lKVjhiUm1PdjR1K1VIbm1rZys2YjVLb3FvY1l0SmlNUC9Z?=
 =?utf-8?B?Yjc0YWJsNHh3dEtTdnFvbEk2a1YzRzhaVHdGZnczZ0pycGFiNFdKM2JhYnVk?=
 =?utf-8?B?b0xQNTQ1dE03dlBUKzYzYjA1c2NXM1lrUTNtVEZNRVdqR3JINXNiYkw1RkVi?=
 =?utf-8?B?ZThpSFphaFR2QVlqVEtjd0x1QUVnLzlDeGIwbWdiWVczMTEvWGQ0d28xa1Ix?=
 =?utf-8?B?MDlwUzU1czMvZ0E4YVRsdVZZWFRyNTN5QVgvcDRabmpzN3NKNlFCQTkrcWho?=
 =?utf-8?B?ajNXMHRiVStlZXJsRlhkMndIcFlrZDV2V3I1ODd1OVVEbkRocmo2SG1tcndO?=
 =?utf-8?B?MTg1NHZMWW05a0Fib3Q0NnZNKzdtVkJ3U1lEMDg3RGJXNk5rSkZnS0pCMFNi?=
 =?utf-8?B?S2FmT1NRY1EyQUM4UkRrUUhGanhNaDZsWVhTVGg3RG83ZGZ6NngrMmd4RXIr?=
 =?utf-8?B?RjFPQzFPQ1p6cUtpOENXM2VsWXlSb1k1c2VZanYvUGYveGhjMys4UkNKa3pG?=
 =?utf-8?B?NkNicHI1VDVCR0FWTWhUVUFNaVhpTlBUR0gveWxNaFlBR0RzMG1FSDNsbnpM?=
 =?utf-8?B?azF3TmNIVXZuTlVuNEY5dHpTMDkvblBWbUpkamc4MGtocTlqK09sNWZrUXdy?=
 =?utf-8?B?YWF2bzVMUTBxMVFEcll0dkpZZUc2WDN3QTVDSFF3TW9yb29sM0xUYjFPc1dH?=
 =?utf-8?B?bG1jZjFlV3JOVTA0azg1RFdwR2ZhOTVObERzdCsyVXlkWnNnWXNCeDEzMFFs?=
 =?utf-8?B?eUY0cUQyWGIxclN2dGs5SXNhRjFxUEZLblB0ZDFub2l6dTk0US80VGpNYmlk?=
 =?utf-8?B?dVFnUFgyYkd0d3NlWmtRQ2pKc0N4b0R6S2xWUWlVTy9JUVVzQktyenRQL1RL?=
 =?utf-8?B?SmJxV1JWVkpENitoSWZxczJuSW04ZkpqbVU1UFhxRlNaL0grd3liTHk2RER6?=
 =?utf-8?B?MEVsa3ZiS1hnYTZDZjRJMlJGNGNtbGNJMUR3d0gyaisxNVZJTVhlNjhCY2s0?=
 =?utf-8?B?OFNPNy9STk0wb0V3K3psOWpqeTljdXVDRy92alNQeXh0bU4xNjRBSTgxOEJH?=
 =?utf-8?B?Uk9zTFlYblgvSFlVVUVHendBd2pDV0JxSGR6VFVCT0Faam43UWpUZ1h2bytl?=
 =?utf-8?B?di94SjJ2Y1NSbmVjMXJjdCs1M1VoOFBpdW0xUkNlc2swdXhGYU00NGZLOFRL?=
 =?utf-8?B?ZWdkSUR3K0drRVFRYTZYNFZTMHRsUUZPdmVlKy80Y3d2QlJUWkgyamFxclJ3?=
 =?utf-8?B?T2JyRXN5WGZlZ1JYZ1dqK1NXZUR0ZkFab0dvQmkyWjdQcExhUG9RMU9HYUNz?=
 =?utf-8?B?YlVPekhraXpkeThVVXVLS0NKdFlJdHlCUzdhRWJFNHNmTUpSVXd1SnZyeW5a?=
 =?utf-8?B?Vkpoc29VUzhyWWlpSHlRZE1BOVdNTGZKb3FrdWVsaHBlYlpTekwrOXQ2bjVX?=
 =?utf-8?B?cjlLR3dvYVdIUkpGSUFDekl2SVhNeXE4NWV5dTBnd0NmMUNvL1FlTkVOam9O?=
 =?utf-8?B?cW1VZzdCUjFzMXFBRGRuQlFURFdLK0t0QWZ2UEpMVm5ubHY0STA4NlNvNU1s?=
 =?utf-8?B?VnhQVHQwQ2QrelRjbFZUVXlsaTJVbUcrVlpxYk8xMm1DOWlXc05BeURYeUda?=
 =?utf-8?B?Mi9zT29mYzVpSlVndlRnWjhydFY0ZXpiRDhkRmxTb093Q3dETDVLenRFMW1U?=
 =?utf-8?B?SnRNOW5IWm9oakZEZ01DKzI2dDNwOU0wekpLcjZtRUV5VGMxQTRscmdFZ2pB?=
 =?utf-8?B?cjl1K05DVVhkdkJFNE10dEJUcThtbGRGN2d0ZzJIU294OHA0aHFjSGNrc0NO?=
 =?utf-8?B?bVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C9B0A5DC185506448FD08D2695CFFD3C@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5175.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 300360fa-b34e-4b64-2826-08dabe535d2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2022 10:57:28.0928
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /S1QMyKV344emPqDKwXRQRhvXywMlhx+hKvi6sNfXuaQl3T9d/HzufvYByuv7803VHhJrgDrX4aWiDlebLhZUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB5353
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RGVhciBOaWNvbGFzLA0KDQpUaGFua3MgZm9yIHRoZSByZXZpZXcuDQoNCk9uIFRodSwgMjAyMi0x
MS0wMyBhdCAxNzoyOCAtMDQwMCwgTsOtY29sYXMgRi4gUi4gQS4gUHJhZG8gd3JvdGU6DQo+IE9u
IFRodSwgTm92IDAzLCAyMDIyIGF0IDExOjI2OjA5QU0gKzA4MDAsIE5hbmN5LkxpbiB3cm90ZToN
Cj4gPiBBZGQgZHJtIG92bF9hZGFwdG9yIHN1YiBkcml2ZXIuIEJyaW5nIHVwIG92bF9hZGFwdG9y
IHN1YiBkcml2ZXIgaWYNCj4gPiB0aGUgY29tcG9uZW50IGV4aXN0cyBpbiB0aGUgcGF0aC4NCj4g
PiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBOYW5jeS5MaW4gPG5hbmN5LmxpbkBtZWRpYXRlay5jb20+
DQo+ID4gUmV2aWV3ZWQtYnk6IEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vIDwNCj4gPiBhbmdl
bG9naW9hY2NoaW5vLmRlbHJlZ25vQGNvbGxhYm9yYS5jb20+DQo+ID4gUmV2aWV3ZWQtYnk6IENL
IEh1IDxjay5odUBtZWRpYXRlay5jb20+DQo+ID4gVGVzdGVkLWJ5OiBBbmdlbG9HaW9hY2NoaW5v
IERlbCBSZWdubyA8DQo+ID4gYW5nZWxvZ2lvYWNjaGluby5kZWxyZWdub0Bjb2xsYWJvcmEuY29t
Pg0KPiA+IFRlc3RlZC1ieTogQm8tQ2hlbiBDaGVuIDxyZXgtYmMuY2hlbkBtZWRpYXRlay5jb20+
DQo+ID4gVGVzdGVkLWJ5OiBOw61jb2xhcyBGLiBSLiBBLiBQcmFkbyA8bmZyYXByYWRvQGNvbGxh
Ym9yYS5jb20+DQo+ID4gQ2hhbmdlLUlkOiBJMDUwMWYzYzgwZTc4ZWM4Mjc5MzY2Y2JhOWMxMzdh
MmVkZDdhODUyZQ0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Ry
bV9jcnRjLmMgICAgIHwgIDYxICsrKystLS0tLQ0KPiA+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0
ZWsvbXRrX2RybV9jcnRjLmggICAgIHwgICAyICstDQo+ID4gIGRyaXZlcnMvZ3B1L2RybS9tZWRp
YXRlay9tdGtfZHJtX2RkcF9jb21wLmMgfCAxMjkgKysrKysrKysrKysrLS0NCj4gPiAtLS0tLS0N
Cj4gPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZGRwX2NvbXAuaCB8ICA1MCAr
KysrKysrLQ0KPiA+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kcnYuYyAgICAg
IHwgIDc4ICsrKysrKy0tLS0tLQ0KPiA+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Ry
bV9kcnYuaCAgICAgIHwgIDEyICstDQo+ID4gIDYgZmlsZXMgY2hhbmdlZCwgMjA5IGluc2VydGlv
bnMoKyksIDEyMyBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0Yy5jDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vbWVk
aWF0ZWsvbXRrX2RybV9jcnRjLmMNCj4gPiBpbmRleCAzMGRjYjY1ZDhhNWEuLmNlNTYxN2FkMDRj
YiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9jcnRj
LmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9jcnRjLmMNCj4g
DQo+IFsuLl0NCj4gPiAgaW50IG10a19kcm1fY3J0Y19jcmVhdGUoc3RydWN0IGRybV9kZXZpY2Ug
KmRybV9kZXYsDQo+ID4gLQkJCWNvbnN0IGVudW0gbXRrX2RkcF9jb21wX2lkICpwYXRoLCB1bnNp
Z25lZCBpbnQNCj4gPiBwYXRoX2xlbiwNCj4gPiArCQkJY29uc3QgdW5zaWduZWQgaW50ICpwYXRo
LCB1bnNpZ25lZCBpbnQNCj4gPiBwYXRoX2xlbiwNCj4gDQo+IEhpIE5hbmN5LA0KPiANCj4gd2h5
IGlzICdlbnVtIG10a19kZHBfY29tcF9pZCcgYmVpbmcgY2hhbmdlZCB0byAndW5zaWduZWQgaW50
Jw0KPiB0aHJvdWdob3V0IHRoaXMNCj4gcGF0Y2g/IFdhcyB0aGlzIGludGVudGlvbmFsPw0KPiAN
Cj4gSSBzYXcgdGhhdCB0aGlzIGNoYW5nZSBoYXBwZW5lZCBiZXR3ZWVuIHYxNiBbMV0gYW5kIHYx
NyBbMl0sIGJ1dCBJDQo+IGRpZG4ndCBzZWUNCj4gYW55IHJlcGx5IG9yIG1lbnRpb24gYWJvdXQg
dGhpcyBpbiB0aGUgY29tbWl0IG1lc3NhZ2Ugb3IgY292ZXINCj4gbGV0dGVyLg0KPiANCj4gVGhh
bmtzLA0KPiBOw61jb2xhcw0KPiANCj4gWzFdIA0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9h
bGwvMjAyMjAzMTgxNDIwMDkuMjc5Ni0yMS1uYW5jeS5saW5AbWVkaWF0ZWsuY29tLw0KPiBbMl0g
DQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDIyMDQxNjAyMDc0OS4yOTAxMC0yMC1u
YW5jeS5saW5AbWVkaWF0ZWsuY29tLw0KDQoNClRoZSBjaGFuZ2UgaXMgZm9yIHRoZSByZXZpZXcg
aW4gWzFdIHRvIGV4cG9zZSBlYWNoIG1vZCBpbnN0ZWFkIG9mIG92bA0KYWRhcHRvciB0byBtdGtf
bXV0ZXguDQpPdmwgYWRhcHRvciBpcyBhbiBhcHBsaWNhdGlvbiB0aGF0IGNvbWJpbmUgdGhlc2Ug
bW9kIHRvIGFjaGlldmUgb3ZsDQpmdW5jdGlvbiwgYW5kIGl0J3Mgbm90IGEgcmVhbCBjb21wb25l
bnQgaW4gbXRrX21tc3lzL210a19tdXRleC4NCg0KRm9yIHRoZSBhYm92ZSBjb21tZW50LCBJIGRp
c2N1c3NlZCB0aGUgc29sdXRpb24gd2l0aCBNZWRpYVRlayBEUk0NCnJldmlld2VyIENLLkh1IGlu
dGVybmFsbHkuDQoxLiByZW1vdmUgdGhlIEREUF9DT01QT05FTlRfT1ZMX0FEQVBUT1IgaW4gZW51
bSBtdGtfZGRwX2NvbXBfaWR7fSAgKHJlZg0KWzJdKQ0KMi4gYWRkIERSTSBkcml2ZXIgY29tcG9u
ZW50IGRlZmluZSAiRERQX0NPTVBPTkVOVF9EUk1fT1ZMX0FEQVBUT1IiIGluDQptdGtfZHJtX2Ry
di5oIChyZWZbM10pDQozLiByZXBsYWNlIG1tc3lzIGNvbXBvZW50IEREUF9DT01QT05FTlRfT1ZM
X0FEQVBUT1Igd2l0aCBEUk0gZHJpdmVyDQpjb21wb2VudCBERFBfQ09NUE9ORU5UX0RSTV9PVkxf
QURBUFRPUiBpbiBkcm0gbXQ4MTk1X210a19kZHBfZXh0W10gcGF0aA0KYXJyYXkuIChyZWZbM10g
LSBtdGtfZHJtX2Rydi5jKQ0KICAgDQogICAgc3RhdGljIGNvbnN0IHVuc2lnbmVkIGludCBtdDgx
OTVfbXRrX2RkcF9leHRbXSA9IHsNCgkJRERQX0NPTVBPTkVOVF9EUk1fT1ZMX0FEQVBUT1IsDQoJ
CUREUF9DT01QT05FTlRfTUVSR0U1LA0KCQlERFBfQ09NUE9ORU5UX0RQX0lOVEYxLA0KICAgIH07
DQpCZWNhdXNlIHRoZSBERFBfQ09NUE9ORU5UX0RSTV9PVkxfQURBUFRPUiBpcyBub3QgYSByZWFs
IG1tc3lzDQpjb21wb25lbnQsIGNoYW5nZSB0byB1c2UgInVuc2lnbmVkIGludCIgaW5zdGVhZCBv
ZiAiZW51bQ0KbXRrX2RkcF9jb21wX2lke30iDQoNCg0KWzFdIA0KaHR0cHM6Ly9wYXRjaHdvcmsu
a2VybmVsLm9yZy9wcm9qZWN0L2xpbnV4LW1lZGlhdGVrL3BhdGNoLzIwMjIwMzE4MTQyMDA5LjI3
OTYtMTAtbmFuY3kubGluQG1lZGlhdGVrLmNvbS8NClsyXSANCmh0dHBzOi8vcGF0Y2h3b3JrLmtl
cm5lbC5vcmcvcHJvamVjdC9saW51eC1tZWRpYXRlay9wYXRjaC8yMDIyMDMxODE0MjAwOS4yNzk2
LTUtbmFuY3kubGluQG1lZGlhdGVrLmNvbS8NClszXSANCmh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5l
bC5vcmcvcHJvamVjdC9saW51eC1tZWRpYXRlay9wYXRjaC8yMDIyMTEwMzAzMjYxMC45MjE3LTct
bmFuY3kubGluQG1lZGlhdGVrLmNvbS8NCg0KVGhhbmtzLA0KTmFuY3kNCg0K
