Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA5907327C5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 08:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233051AbjFPGkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 02:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244128AbjFPGkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 02:40:14 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 350FE272D;
        Thu, 15 Jun 2023 23:40:07 -0700 (PDT)
X-UUID: 7eda5b780c0e11eeb20a276fd37b9834-20230616
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=D8lDYuJOhB4Xzr2EpR9DNTCHUGtkNVtL6/Y0i4L9LNM=;
        b=k4SblA6e3W64jTUnR1Ruyizp+dqFfFnnXxy0iYuSLCpNfUMXt9iYILyuc00eRSr3YwJc/lNmXdycKX+FkjRGM9rZuSZWVAANDPBFygArRd20vPm1DilrweXZIxiw0guPWvRSwXhZC8DhE6mJp+0bGfElCAe38ju4w1Dp0A2aCP0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.26,REQID:45c408f2-e2f0-408c-a560-d57148aa4e08,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:40
X-CID-INFO: VERSION:1.1.26,REQID:45c408f2-e2f0-408c-a560-d57148aa4e08,IP:0,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:40
X-CID-META: VersionHash:cb9a4e1,CLOUDID:3e6a436f-2f20-4998-991c-3b78627e4938,B
        ulkID:230616142451VEZ340EF,BulkQuantity:0,Recheck:0,SF:17|19|48|38|29|28|1
        02,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,C
        OL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_SDM,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-UUID: 7eda5b780c0e11eeb20a276fd37b9834-20230616
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <shuijing.li@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 867713453; Fri, 16 Jun 2023 14:24:49 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 16 Jun 2023 14:24:47 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 16 Jun 2023 14:24:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A6kdyB5dCczyGj76cHVn9DqPHwdAWEFNPsamTDSBcqDewC0NHCa5YdJG2yNgai4mDh3Fx+bFLczWHMz4XFzKAXf/dU1pzFtY6jQeubgrI3bwVPvmgRhJzyXXO8frNFLkUCjxdiTLO91J6sFKSTnm+mGXF664GX9240UMmNcm4ImBuIunrtW7odGfMxGlEAhaORDsZG40/H45zT3nN7RD4IDs7QF9bXFIjVuH2x8uLEGbl1zF3X2VNSw8HK1/D9B8rX11BH0g9eYw8dv7XJlqHJp497/a8302qEWre6/Qp/URXznd0IOwe6hgCk2lqXkXuPTSbOIuBFNK8J8zqLEqfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D8lDYuJOhB4Xzr2EpR9DNTCHUGtkNVtL6/Y0i4L9LNM=;
 b=n301XgkR0PM2aQyLYSXROa94YrkHOVbC4gEX+SUhdnZZ0nvjs4K2xRYUA3D9zoDABbbmsaCtmLYo2QstMjpPzmgCkIvwm1XB77cRjFAirUmCGHg2Od3L/PS64yeDP+Z8hZPtCFOlyjTOLBeTXh4zahTwmmJH1lJjsb4ZVMBS2oqaOhCZEfWED+STb8TGfXrYJf9vtYLTTl4mJBWU2yUQHgeKeqZg5JU6Wl1X+9QBvJk6wPUix1FCDzoO9hQHtVtejATeND6vUW3VBvJyOFNUYqAGXDCzr01tARfUvm2iqXFqeq6EgFqzdHi+aS8jZq/AxbneCa375cu9DCrYdatqKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D8lDYuJOhB4Xzr2EpR9DNTCHUGtkNVtL6/Y0i4L9LNM=;
 b=cFLgW/cU/rMxSs9v20xAEtyca4YgU31QO6lQ9h7wbQaUfrWtwffWDyg1pnXfwjwr6h1xTDhmjWzLxPHx8G412JkwDBwxn1mjg50MRHpHxDZcuuh7gSYaBeFY1fbaxzH3LN9NzfYcDqC8Yblc0uj2ctVQUDvfSvLWxj7MklTqgAc=
Received: from SG2PR03MB4165.apcprd03.prod.outlook.com (2603:1096:4:3d::11) by
 SEYPR03MB7728.apcprd03.prod.outlook.com (2603:1096:101:14a::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.44; Fri, 16 Jun 2023 06:24:42 +0000
Received: from SG2PR03MB4165.apcprd03.prod.outlook.com
 ([fe80::d741:b0af:5075:b7d4]) by SG2PR03MB4165.apcprd03.prod.outlook.com
 ([fe80::d741:b0af:5075:b7d4%3]) with mapi id 15.20.6500.029; Fri, 16 Jun 2023
 06:24:41 +0000
From:   =?utf-8?B?U2h1aWppbmcgTGkgKOadjuawtOmdmSk=?= 
        <Shuijing.Li@mediatek.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        =?utf-8?B?Sml0YW8gU2hpICjnn7PorrDmtpsp?= <jitao.shi@mediatek.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        =?utf-8?B?WGlubGVpIExlZSAo5p2O5piV56OKKQ==?= 
        <Xinlei.Lee@mediatek.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        =?utf-8?B?UmV4LUJDIENoZW4gKOmZs+afj+i+sCk=?= 
        <Rex-BC.Chen@mediatek.com>
CC:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [PATCH 3/3] drm/mediatek: dsi: Add dsi cmdq_ctl to send panel
 initial code
Thread-Topic: [PATCH 3/3] drm/mediatek: dsi: Add dsi cmdq_ctl to send panel
 initial code
Thread-Index: AQHZbc6dGP+8UZnx5EOtJItjghrVOa8o1zQAgGSDxgA=
Date:   Fri, 16 Jun 2023 06:24:41 +0000
Message-ID: <de5e5267b26191b99874cca582ca9dcb44ac85fa.camel@mediatek.com>
References: <1681366162-4949-1-git-send-email-xinlei.lee@mediatek.com>
         <1681366162-4949-4-git-send-email-xinlei.lee@mediatek.com>
         <ef7019930edfbdea53042437818a401f5f50ecd6.camel@mediatek.com>
In-Reply-To: <ef7019930edfbdea53042437818a401f5f50ecd6.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR03MB4165:EE_|SEYPR03MB7728:EE_
x-ms-office365-filtering-correlation-id: 7e139679-5936-41d6-4363-08db6e325e8c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Stf5TY8sVBxaPY9SqdiVQJ+/xjdddmzs/R696pbw3FWCfJwRaHxu4a+r2k0DVmabj+tuEvd1WAhVjN1thCySPuV+aSCFdDipd6t4ucwKpUWIlw3h19IYsSPOWLkYBXrTLRidR4sQOvM5MR3BNmlUJ/e4Cz7LK3AWXTZZhktTvNqAkX58Xpzh2bTxx2yQAHg0/1Ku3oQdLx2HWzS3SMkhSIZY9vKaEKl6AeuPpeYCSWvjXEstrcb3QfF0q2vhFkfrOW/tvz5aX0oW1PoAZUV9a+a1wqL3+UlmQpK43n2VzCGxpHfQcddmlL/tmKifl81LN+IMpY9lH1rdmbxIpLK5nTPtmDYK8X3grhx3MuQaF4Rwg74wKpBaKN/FqoD7IIH4AQVUUx6ltmzcNoyUBZsf7A+Co/+NbjKwWXVKmt9bHU3YssS2JDWQBZ06PuhVWD6vR7D741RBlxVrrqlqYHxCqWizaBqYBkg4F4M0u7wuEq9zcHbkjOjgwlryo03mKpsjvB2hTttGHz7d3sCLyKMfjy/kSb9zwoYVlsAZ2OUxbTlZBG6pFkEgR6f+nLaR8PcAAuDDxUw96XjDNzIpqk0H+b6pP0JdOe+Gdo/0BE9ky8CBMcuLIRo/UNdcqlpBtiQycTRqZK8aUDWtHJYlW328ugOU7bGt8VcSQufC5cawS5AEt4achN8b1uWeK+xLH5rb
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB4165.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(39860400002)(396003)(136003)(366004)(451199021)(6486002)(107886003)(36756003)(2616005)(85182001)(38100700002)(86362001)(38070700005)(26005)(122000001)(6512007)(6506007)(921005)(186003)(41300700001)(110136005)(54906003)(2906002)(4326008)(66476007)(76116006)(6636002)(64756008)(8676002)(66446008)(66556008)(66946007)(316002)(91956017)(5660300002)(71200400001)(478600001)(7416002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Vzl4S2FCUDRuZVJwYTV5a0xGSkMwU1p5R1I4NkxJOVQyMHliTjZiSXUzOE9H?=
 =?utf-8?B?RzhlSlFUMkdkM0tsNnl0Yi9QendVREExdG9KeUt6RStNSUZpbWo4L0k1RlN1?=
 =?utf-8?B?eWVRSGRHNXRBV3F4NExCSDVwNDRIdHBJallETkVCZ2paaERrVUNmcXJhWjFN?=
 =?utf-8?B?YXVsNVdXZ1VaTHJrdHB5cVFzZWxDNnJlTEVHQ3BpUUR4RDR0VHlPKy9haUlN?=
 =?utf-8?B?eXFuTUNMcGQzdzE1ZnFxTWpsdFZjaGxseExjQjYyOEt5ZzlDSnR4dGhBS1Fp?=
 =?utf-8?B?K0prSDRma1EwbWY5NG9MUzUyeXVRN1J2ZHh1RkNjcW9UTUJYRjhhcHhpUU9Y?=
 =?utf-8?B?ZTFxQ1c1VjI0a2d4QnRZalprQlFEeXBEdFN3Q2JKaXpsOGR6L1F3bDFlOVEx?=
 =?utf-8?B?Z2lrckpEQ2MyRWpmUjFTaWZVYnB5NXV1U1BQOUhnNnFEcm5abklicWZBOHZF?=
 =?utf-8?B?NVY5dGpMbWpSYzB4Vmp6MnlOZXFUdUxqelNSSVlkVUtMdGFnWm1pbzBOZkJ0?=
 =?utf-8?B?RytReWN3OGFzN01YQk1Nb3pNcGlyZHlVTnRoQ3ZucHNMVS9wOWk1VXJnY3lj?=
 =?utf-8?B?R284OGpndFFEdDFvUGdCMzdXcElEYnhmUFN0YzN6elJkZFZqSnRRRjRsVkRp?=
 =?utf-8?B?Y2VGVmRqTGNCVkwvNmhNQzJPS1QvekpVN01rVExOM1hNR1R3VGRJK2FnR1J2?=
 =?utf-8?B?MjNHeG1jN3N3bUtpeHk1azAya0xKMThScVladDVNOWRnangxVEtwOGl2NkR4?=
 =?utf-8?B?a3pNWHpJR1NFU1NWRkxYZ3M0Z05sY2ZlMHhJaEtOVndSekZvL0JVdEpZbTVO?=
 =?utf-8?B?UUYyajZyWnlUUlRGd0dFNVFwa2J0TkprcW1IYnp1SzhhODlreW1oNFNYSmxk?=
 =?utf-8?B?MFZLaENZdUFuYjlOcXpEVHRYUTM3RHVKOUNpT29SYmErZGd1Z2VGektOWlRi?=
 =?utf-8?B?bGxicTIvYWxHdXJVUitKcitSSHAyUHlxS2xQbXJha2NzbU56UW1vaVpXNTJw?=
 =?utf-8?B?T0RrdFZDN1Z1eUp6SzFISHJaRkdybmhBOGxnYzNyb0hjQXhaVTRLUERFbGVT?=
 =?utf-8?B?NEx5bEVoV3gxMFJPSHgveFdyTnBJNDJNREVsTlVoNy9QWmxacDR4QndCKy9N?=
 =?utf-8?B?LzBZNnFyWHBHeVVvNlFTNGd2bjhEcmFWT0tZc1JFeUtBTThqTjRFdFRYOEN6?=
 =?utf-8?B?S252SW1rcFVsWXQ0cHJHMURWRFJPSnkxUTE4d1dGaWErWE1oUXduK2JPcTJU?=
 =?utf-8?B?K2JRN2hxd2RQb0RXK3FodmEzSzIxb2dXUFJISjl3eUJ3cVNRZVZsend1ZjA5?=
 =?utf-8?B?SmdxakpXa1A2TmJMWEJRNnk1SFVGQjVkMVZlS0ZVRWdhbzN3Umdzbkx6VVp1?=
 =?utf-8?B?KzF1QXBzOUxDYTR2UHFLb1BJdHZUNW4xSmRFck40VUZzWk1YZEw4YkN2L0pV?=
 =?utf-8?B?cG13VlRXZDJubXVLUXZtSzZDSXFrV1EyRXJNU0NvR1dhWXNoN3hOVVlud1NU?=
 =?utf-8?B?OFdwRHQrS3Q3TFp6SnBMcWQvaGJXWjZ3b0FjRk1JS2JZYlZvNTN4enN3Sjhm?=
 =?utf-8?B?eHcxYnN2WkRqYnZzWWZwSkRBWEE4RnlIRDlKbHIrVGVGZldJQTUwdXB5UEpm?=
 =?utf-8?B?Rkx0TzZXNmRZbG1GeTlnVi9TMDlxYmpOZVdVQldqdlYweUtkTDdBMjQyYlI3?=
 =?utf-8?B?RFJ1TGJuMmZBaFNWRERxMDU2aU1NdXlpWXN2UzZxOVZWQ3hyK3ZCQkZJUGVC?=
 =?utf-8?B?ZkhGclMycEZJZGRtbjlIM1ltUXhQcjVOK3c4OU83b2x1Q0xrT2Uyb0lqcUg5?=
 =?utf-8?B?Z2grYVkyczV5UlhCOE9nNEpvT2orWWsyMkdVNEV5bEV1VUY3Q01oU2YyZno1?=
 =?utf-8?B?NXBENGZ0YU1UbGRqNVB1MHo3Rmt5RnBkVkhnV1VBdWpqTDNvL1h5b0ZLN2Z4?=
 =?utf-8?B?MjNmSVdiOHJNV1J2YkdvaTR4SXdzTTlnRXZEb2dtWi9Gb1lyeVdad1VqY0VY?=
 =?utf-8?B?WnNmcGJXdXhkU2UxajRhQzV6azJUYnlTdEFZY05wYXQwTGdka2pBSkhFMys3?=
 =?utf-8?B?bUVZcUhybFdDNnNMNzVUdDR6UVBEUzRtam9XNlZ5SG9ta0N6aERmOEpMS3dn?=
 =?utf-8?B?OFhUNlVqL0dxMjBBbENXdkZMRFg5b0RydkVJdjg1L1pqOEhVWUQyQWk2NHpF?=
 =?utf-8?B?a3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B85DFEA2840FD9439051EA0BFEA2D546@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB4165.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e139679-5936-41d6-4363-08db6e325e8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2023 06:24:41.6550
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YPpj/ERbA7N74zse2Cseaz5kBQZpBJdmsK0iymmwouivUqTz2jOR6VEcpx1rF+cIePXRkoLimo+XZvNweOL3PKIrbB/vCjVl5L4KwDihFYc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7728
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUmV4LUJDLA0KDQpbMi8zXSBpcyB0byBhZGQgdGhlIGRyaXZlciBkYXRhIG9mIDgxODgsIFsz
LzNdIGlzIHRoZSBjb21tb24gY29udGVudCBvZg0KODE4Myw4MTg2IGFuZCA4MTg4LiBTbyB3ZSB0
aGluayBpdCBzaG91bGQgYmUgZGl2aWRlZCBpbnRvIHR3byBwYXRjaGVzLg0KDQpCUnMsDQpTaHVp
amluZw0KDQpPbiBUaHUsIDIwMjMtMDQtMTMgYXQgMDc6MjcgKzAwMDAsIFJleC1CQyBDaGVuICjp
mbPmn4/ovrApIHdyb3RlOg0KPiBIZWxsbyBYaW5sZWksDQo+IA0KPiBJTU8sIFsyLzNdIGlzIHdl
aXJkIGJlY2F1c2UgdGhlIGRyaXZlcl9kYXRhIGZvciBtdDgxODYgYW5kIG10ODE4OCBhcmUNCj4g
dGhlIHNhbWUgaW4gWzIvM10uIFNvIEkgdGhpbmsgWzIvM10gY291bGRlIGJlIHNxdWFzaGVkIGlu
dG8gdGhpcw0KPiBwYXRjaC4NCj4gDQo+IEJScywNCj4gQm8tQ2hlbg0KPiANCj4gT24gVGh1LCAy
MDIzLTA0LTEzIGF0IDE0OjA5ICswODAwLCB4aW5sZWkubGVlQG1lZGlhdGVrLmNvbSB3cm90ZToN
Cj4gPiBGcm9tOiBYaW5sZWkgTGVlIDx4aW5sZWkubGVlQG1lZGlhdGVrLmNvbT4NCj4gPiANCj4g
PiBGb3IgbXQ4MTg4LCBhZGQgZHNpIGNtZHEgcmVnIGNvbnRyb2wgdG8gc2VuZCBsb25nIHBhY2tl
dHMgdG8gcGFuZWwNCj4gPiBpbml0aWFsaXphdGlvbi4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5
OiBYaW5sZWkgTGVlIDx4aW5sZWkubGVlQG1lZGlhdGVrLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5
OiBKaXRhbyBTaGkgPGppdGFvLnNoaUBtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZl
cnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHNpLmMgfCAxMiArKysrKysrKysrKysNCj4gPiAgMSBm
aWxlIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKykNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kc2kuYw0KPiA+IGIvZHJpdmVycy9ncHUvZHJtL21l
ZGlhdGVrL210a19kc2kuYw0KPiA+IGluZGV4IDUwMGEzMDU0MjgyZC4uY2JmZTVkZjQ2NDdjIDEw
MDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHNpLmMNCj4gPiAr
KysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RzaS5jDQo+ID4gQEAgLTg2LDYgKzg2
LDcgQEANCj4gPiAgDQo+ID4gICNkZWZpbmUgRFNJX0NNRFFfU0laRQkJMHg2MA0KPiA+ICAjZGVm
aW5lIENNRFFfU0laRQkJCTB4M2YNCj4gPiArI2RlZmluZSBDTURRX1NJWkVfU0VMCQkJQklUKDE1
KQ0KPiA+ICANCj4gPiAgI2RlZmluZSBEU0lfSFNUWF9DS0xfV0MJCTB4NjQNCj4gPiAgDQo+ID4g
QEAgLTE3OCw2ICsxNzksNyBAQCBzdHJ1Y3QgbXRrX2RzaV9kcml2ZXJfZGF0YSB7DQo+ID4gIAlj
b25zdCB1MzIgcmVnX2NtZHFfb2ZmOw0KPiA+ICAJYm9vbCBoYXNfc2hhZG93X2N0bDsNCj4gPiAg
CWJvb2wgaGFzX3NpemVfY3RsOw0KPiA+ICsJYm9vbCBjbWRxX2xvbmdfcGFja2V0X2N0bDsNCj4g
PiAgfTsNCj4gPiAgDQo+ID4gIHN0cnVjdCBtdGtfZHNpIHsNCj4gPiBAQCAtOTY1LDYgKzk2Nywx
MSBAQCBzdGF0aWMgdTMyIG10a19kc2lfcmVjdl9jbnQodTggdHlwZSwgdTgNCj4gPiAqcmVhZF9k
YXRhKQ0KPiA+ICAJcmV0dXJuIDA7DQo+ID4gIH0NCj4gPiAgDQo+ID4gK3N0YXRpYyB2b2lkIG10
a19kc2lfY21kX3BhY2tldF9jdGwoc3RydWN0IG10a19kc2kgKmRzaSkNCj4gPiArew0KPiA+ICsJ
bXRrX2RzaV9tYXNrKGRzaSwgRFNJX0NNRFFfU0laRSwgQ01EUV9TSVpFX1NFTCwgQ01EUV9TSVpF
X1NFTCk7DQo+ID4gK30NCj4gPiArDQo+ID4gIHN0YXRpYyB2b2lkIG10a19kc2lfY21kcShzdHJ1
Y3QgbXRrX2RzaSAqZHNpLCBjb25zdCBzdHJ1Y3QNCj4gPiBtaXBpX2RzaV9tc2cgKm1zZykNCj4g
PiAgew0KPiA+ICAJY29uc3QgY2hhciAqdHhfYnVmID0gbXNnLT50eF9idWY7DQo+ID4gQEAgLTk5
Niw2ICsxMDAzLDggQEAgc3RhdGljIHZvaWQgbXRrX2RzaV9jbWRxKHN0cnVjdCBtdGtfZHNpICpk
c2ksDQo+ID4gY29uc3Qgc3RydWN0IG1pcGlfZHNpX21zZyAqbXNnKQ0KPiA+ICANCj4gPiAgCW10
a19kc2lfbWFzayhkc2ksIHJlZ19jbWRxX29mZiwgY21kcV9tYXNrLCByZWdfdmFsKTsNCj4gPiAg
CW10a19kc2lfbWFzayhkc2ksIERTSV9DTURRX1NJWkUsIENNRFFfU0laRSwgY21kcV9zaXplKTsN
Cj4gPiArCWlmIChkc2ktPmRyaXZlcl9kYXRhLT5jbWRxX2xvbmdfcGFja2V0X2N0bCkNCj4gPiAr
CQltdGtfZHNpX2NtZF9wYWNrZXRfY3RsKGRzaSk7DQo+ID4gIH0NCj4gPiAgDQo+ID4gIHN0YXRp
YyBzc2l6ZV90IG10a19kc2lfaG9zdF9zZW5kX2NtZChzdHJ1Y3QgbXRrX2RzaSAqZHNpLA0KPiA+
IEBAIC0xMjAwLDE4ICsxMjA5LDIxIEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2RzaV9kcml2
ZXJfZGF0YQ0KPiA+IG10ODE4M19kc2lfZHJpdmVyX2RhdGEgPSB7DQo+ID4gIAkucmVnX2NtZHFf
b2ZmID0gMHgyMDAsDQo+ID4gIAkuaGFzX3NoYWRvd19jdGwgPSB0cnVlLA0KPiA+ICAJLmhhc19z
aXplX2N0bCA9IHRydWUsDQo+ID4gKwkuY21kcV9sb25nX3BhY2tldF9jdGwgPSBmYWxzZSwNCj4g
PiAgfTsNCj4gPiAgDQo+ID4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2RzaV9kcml2ZXJfZGF0
YSBtdDgxODZfZHNpX2RyaXZlcl9kYXRhID0gew0KPiA+ICAJLnJlZ19jbWRxX29mZiA9IDB4ZDAw
LA0KPiA+ICAJLmhhc19zaGFkb3dfY3RsID0gdHJ1ZSwNCj4gPiAgCS5oYXNfc2l6ZV9jdGwgPSB0
cnVlLA0KPiA+ICsJLmNtZHFfbG9uZ19wYWNrZXRfY3RsID0gZmFsc2UsDQo+ID4gIH07DQo+ID4g
IA0KPiA+ICBzdGF0aWMgY29uc3Qgc3RydWN0IG10a19kc2lfZHJpdmVyX2RhdGEgbXQ4MTg4X2Rz
aV9kcml2ZXJfZGF0YSA9IHsNCj4gPiAgCS5yZWdfY21kcV9vZmYgPSAweGQwMCwNCj4gPiAgCS5o
YXNfc2hhZG93X2N0bCA9IHRydWUsDQo+ID4gIAkuaGFzX3NpemVfY3RsID0gdHJ1ZSwNCj4gPiAr
CS5jbWRxX2xvbmdfcGFja2V0X2N0bCA9IHRydWUsDQo+ID4gIH07DQo+ID4gIA0KPiA+ICBzdGF0
aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBtdGtfZHNpX29mX21hdGNoW10gPSB7DQo=
