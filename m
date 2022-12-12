Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FBED649893
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 06:05:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbiLLFFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 00:05:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiLLFFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 00:05:46 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2105.outbound.protection.outlook.com [40.107.8.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56DF86167;
        Sun, 11 Dec 2022 21:05:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=leAzRYqj0hmzJwbeTmwnjnQHsmqCBAqSpPAvcfexoRiBzRaZlU3OXpu9XPLS9ilQ77V9vuk1CPFyLE2SF91R+3gX1uPnBmnw0PFom3QHAIhe3XDvYyaDlC0kxNnx0STqFbC5JnIlsp8rm6HRlYm0OqmREU4gBnMK385EZzDqESauI4Tp39nUkX34FCLEqBaVZAp2PvjGrC2G0kMkHBaGYZgtdxCZZGbWZ8Ng4zC6WbXbY5XKVWwFPO4xa4TDrbtGO5xBK8oWSC10mtV9iNy1o6aEo8Mco/+6ng1EHAAoDJ5vajFQ0SbcYmbD+kChbqj8I3d5Sp+xWSegGytcAMAuzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d6pHoerHKmLhHWXFvMKJoUji1a5Xi9hXM5lsdZnYzco=;
 b=iJCN2+0hVYqdfEPlxsWNdMudGwxmENlo78HRDZSZk3JefOEyKZnyr+stjcGdrJPFsCGH5sSJTGMKzdmuBGwKQzm4C6baOn9lZ9+ARoxRqlFOP50Jpa+6gfpvAgeMiEdIB6l8kB/IP9EeoBu4+07FL4kdpVXQQhWlqqmAbKNfDaHO1a77H9XDDjnV/9lS48rm7mVNJ5N+k4K8A7KSomuIdpN7UyGioncuXgm3oyXjcNKbJnGGEav553gHyVG/pcxjPTo4PKt0piRn65akbsUTrlYthtiWaE82HRz/Pa0f2mVMyuWL2+tu9EdYPMHJVJufkhMPcsbRvI8gB1E5d/GqLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass action=none
 header.from=leica-geosystems.com.cn; dkim=pass
 header.d=leica-geosystems.com.cn; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d6pHoerHKmLhHWXFvMKJoUji1a5Xi9hXM5lsdZnYzco=;
 b=lsUj+qmQSGW0Xe64hUFQpMD+T2LMgbD0IlstztiUy4ISgEujAOYUrFoh5BumxOMP6hK/ZJ0XAx5tuQTvQZhqVPZWNwyR/xVclvHIuaDPsI/qpIt55M1fVMHkWYzCvcMyHU4qEKgw50fdfrG+EVvUgzGUnSpFCE1Oi6ideS9py50=
Received: from AS8PR06MB7432.eurprd06.prod.outlook.com (2603:10a6:20b:319::19)
 by AM6PR06MB5704.eurprd06.prod.outlook.com (2603:10a6:20b:9e::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Mon, 12 Dec
 2022 05:05:40 +0000
Received: from AS8PR06MB7432.eurprd06.prod.outlook.com
 ([fe80::3c7c:3751:6bd0:3098]) by AS8PR06MB7432.eurprd06.prod.outlook.com
 ([fe80::3c7c:3751:6bd0:3098%5]) with mapi id 15.20.5880.019; Mon, 12 Dec 2022
 05:05:40 +0000
From:   LI Qingwu <qing-wu.li@leica-geosystems.com.cn>
To:     Stephen Boyd <sboyd@kernel.org>,
        "abelvesa@kernel.org" <abelvesa@kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "18701859600@163.com" <18701859600@163.com>
Subject: RE: [PATCH V1] clk: imx8mp: Alias M7 SRC/DIV to M7 CORE
Thread-Topic: [PATCH V1] clk: imx8mp: Alias M7 SRC/DIV to M7 CORE
Thread-Index: AQHZChNpSxxdW3iOOUiYQI8TADNdwa5l472AgAOkt7A=
Date:   Mon, 12 Dec 2022 05:05:40 +0000
Message-ID: <AS8PR06MB743285AC3F7A48CB4E084532D7E29@AS8PR06MB7432.eurprd06.prod.outlook.com>
References: <20221207081042.3897128-1-Qing-wu.Li@leica-geosystems.com.cn>
 <20221209182754.030F9C433EF@smtp.kernel.org>
In-Reply-To: <20221209182754.030F9C433EF@smtp.kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=leica-geosystems.com.cn;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR06MB7432:EE_|AM6PR06MB5704:EE_
x-ms-office365-filtering-correlation-id: 32f72a72-9551-40fc-b23a-08dadbfe83e5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tT+5NF/Yp5T1ElErV3Z0iPmp7MW1mcYy+CA6gvVBOwbEUYJOUC9Da6N8fP+jY1/9YmBifSBzds2gjQccE208t+o1QSZlZX71erBUoVMG2KCuzZOlozb+H3+/M4c/+Z9MQKFF/yyeusUqAicuqlSBN6ygKIikQfmLgIOlyET4iUT6rRzNoSMv/y7GUrZmyRmofI5HkoRH0umuXhU1TYTXBBrRews/2NuGMVzzw4OlotKVax0FZmZYbjHAfoxkkFr65syPvXuwsGL+L4wrM+eDe0dG2Ym04t2Qy0Q2R+yPWlu1aX6pQbEM3k5EwaNQwj5cT3Z4/nhgQBNKJMfvsOUUsjCrqayCZ4BalJMiYfODs2JhS8mAt0PGTceVf27yTFf/lgrrgpK+lRZP/H9kOCqNAy1s4b+YJFzm2xDB0UagToJaY16218tj0+FsJiMPY1Ij2yqZJA8IPy08UAnXivQjL0ES7QGAoJg4vn/JBh6HVe1Ga+kiSV4m2plhoMf2mT6DLv1MEPUTSkJ9w7F94ZdGsgXZ97rNXfWCuIAqyURrM+YyO9m+cxw1FFp0AMIGG7L8INTIWdUY+jItUDfm55g6YnfosX8+6pkDGFB9jcEV9rAkGAdObh8zzZmdRGybZiW+3wFz1ULt+Ct0EvUDxlKZenIFGEX4GDx3/qRxZgyMFXh2jsBwS4HbR+uaJYR8Zxa9nQTPD4eEoMsHq2EbjSMbl1AgyiPfqPkpOjGYNwd1O2xvBFQFTrHedUj/kh3sy5XR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR06MB7432.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(396003)(346002)(376002)(39860400002)(451199015)(83380400001)(7416002)(4744005)(5660300002)(38100700002)(33656002)(52536014)(8936002)(55016003)(6506007)(186003)(41300700001)(478600001)(2906002)(64756008)(66446008)(8676002)(86362001)(9686003)(122000001)(71200400001)(4326008)(76116006)(66556008)(66946007)(7696005)(66476007)(53546011)(921005)(38070700005)(26005)(110136005)(316002)(32563001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eh0vlSk39reTeQRlbXLi5Xzgc/R+XIINasChhB8kfETwVXipy/Ys5NP64ABH?=
 =?us-ascii?Q?nzGALdmRoVCKOHnUOEWVbOdUdWJVVqX/j6rTQNyEHVWd5yxyuZtvU3OlDMU2?=
 =?us-ascii?Q?DeLQApJruqRJyxyy3DJBnFTVcyg345BjgBR4poAdGlXAq08GKdJL9I0GEbpP?=
 =?us-ascii?Q?adVzUN6C4/qKHrzWqQPDhTopUSG+cki1y7sFnhhgD1RiLlw/v2iyn/2j94t5?=
 =?us-ascii?Q?eAXkeKnX/KRhUVWQ8FWgXAUxw1dT0eS4emIWhjrhGemXVsRgJK3S0g11HKpU?=
 =?us-ascii?Q?rPCHu4hTv3bfS0JlZi680rQQmGGXCqbdM2R8QYLp4a7Sd2kLZ7T9J9UelA1/?=
 =?us-ascii?Q?B4kT77HWGew3eJLxVKY6pvyJrZ52hwwMYSO0V218VFBGF1lFv0239sgDCRV8?=
 =?us-ascii?Q?4Dk7kw/l/QKr2qU1q+x6k5kfCzwKxwsyfGhTyuOwjn3u2IgWgJcMZ0purNUw?=
 =?us-ascii?Q?9NE1P+NqWN7v724d7FInZJmVVGEvZVLw3j1wVi6HHrzQ7/Q6rgoZHSD1xKHJ?=
 =?us-ascii?Q?MlY7pXhHykpKXhi8WqlooSUTtAwmZSLt7NoUqBnJK4piEaGN4RZWPh05UyFV?=
 =?us-ascii?Q?SKNGTbLNp1GeB4qDah+IC7CAFJakGLRefTnb/2CY6w+P7rDStzdznUJGSuWI?=
 =?us-ascii?Q?N2rceHcOVJ3zF9rLPERcgh7S7Buo3zbPTbgTwni1P/yrwMFXNwwb7knr2osn?=
 =?us-ascii?Q?RhaMec/hYEBpMzU2iap2CSAHj1I4l02QxCwqcVVHBtKoWiZnFiDcx8CX2nS+?=
 =?us-ascii?Q?UnkygpgHBVzM+qV/7zhFZ4jVUD+3se8SfMOIikogXdvi2yIiaXd7807F6UFk?=
 =?us-ascii?Q?CH9Hx6eSfQmctdVDy3avxFMHxwFUJW/+HaGi4BDusBtsM0ioF7i2vR/SFNhI?=
 =?us-ascii?Q?dfmwlvtsg2JSrasFBEMblDcf0XL+wzdnuBaSzCuwkQA/5ZKiWlJYHZikk4f2?=
 =?us-ascii?Q?8jVQFqr3FPtFhNRdQLjaLCrxSQ1ScmMoJkTAwtEoX864SIo6WLmGTUClD91w?=
 =?us-ascii?Q?TZM8p5u0PJYE6kHQyF1hyG++vPd6UdhpAKzO9vUKsqY62Iiaek7NUV+8Ih9z?=
 =?us-ascii?Q?CUzFavEX9kCly2i+pWmm8JXRdPHv/OuguvdW0acPPECbwnTZlbKzTdQHE6SL?=
 =?us-ascii?Q?QUpakmuF1p6qkH49cF1FrNkQXqWY30J7fGPbu1yFg6Z+/R4bUmG88A2d/dJV?=
 =?us-ascii?Q?km9yOOFUnwe/W4+qpg2TylP20DmdzppVBsDVGRsR1WdYIaHw6T1VwFT7gLDe?=
 =?us-ascii?Q?rOMN9E5niUnYSsST8dzkT6f9qujeIs5ozRbPpOSHZET8N3Q7tbq0KObbiSAZ?=
 =?us-ascii?Q?Qmu7TOjgkAUKtVqSWOJygqmfzGrbQFnKSMizuAT+Ky2Z8q5MgLMiu1EfmPiM?=
 =?us-ascii?Q?uTo5Odt2YtaU+EC89+0mRmkDuLz6AQmdfKkZ49s7KtFzBwjdfLOogQP9GHDf?=
 =?us-ascii?Q?9FQZY6DvGGOUaoo6BSwZEIACKMLIikhuzuL8RP3fXCD1tMX0gdaxNOJURWV0?=
 =?us-ascii?Q?i1FGZeVuzWOMALEnMmyVbpnrqnVltchLT7cHr5MmYAynzJ1XSVPDXUe2hq2y?=
 =?us-ascii?Q?BFsJp/H8t0x/D2hjwpRD83GZbosyVIBGv658Cv7bQApnkM/jBcZa7IQt/75j?=
 =?us-ascii?Q?17HQzP1IHkKPm8nGLfY1JhE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR06MB7432.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32f72a72-9551-40fc-b23a-08dadbfe83e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2022 05:05:40.6922
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CnQuQa/gcTOiMQT4/ye7NMpbI8vsZXoKH6XxWQiGP2rnQ3eGXagiaQZ0r0W8MrM++KWdgWDmE7grgNHpsdO0rkwWsb4Cd8oh0cQn1DViTnkphMViB9z9R3cZko4QVk8a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR06MB5704
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Stephen Boyd <sboyd@kernel.org>
> Sent: Saturday, December 10, 2022 2:28 AM
> To: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>; abelvesa@kernel.org;
> festevam@gmail.com; kernel@pengutronix.de;
> linux-arm-kernel@lists.infradead.org; linux-clk@vger.kernel.org;
> linux-imx@nxp.com; linux-kernel@vger.kernel.org; mturquette@baylibre.com;
> s.hauer@pengutronix.de; shawnguo@kernel.org
> Cc: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>;
> 18701859600@163.com
> Subject: Re: [PATCH V1] clk: imx8mp: Alias M7 SRC/DIV to M7 CORE
>=20
> Quoting LI Qingwu (2022-12-07 00:10:42)
> > Defined IMX8MP_CLK_M7_SRC and IMX8MP_CLK_M7_DIV in imx8mp-clock.h
> but
> > never assigned. It will cause the system to hang if using it.
> > Alias IMX8MP_CLK_M7_SRC and IMX8MP_CLK_M7_DIV to
> IMX8MP_CLK_M7_CORE
> > for backward compatibility.
> >
> > Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
>=20
> Any Fixes tag?

Thanks, I will and Fixes in V2
Fixes: 8c83a8ff4dd9 (clk: imx8mp: use imx8m_clk_hw_composite_core to simpli=
fy code)
