Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 320BC638E9F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 17:51:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbiKYQvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 11:51:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiKYQve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 11:51:34 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3048CD2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 08:51:32 -0800 (PST)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20221125165130epoutp0266a51542d4ca68248e44e2fd50f1223e~q4f2LT2h-3090930909epoutp02F
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 16:51:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20221125165130epoutp0266a51542d4ca68248e44e2fd50f1223e~q4f2LT2h-3090930909epoutp02F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1669395091;
        bh=d1s1jJqFUh3kbOkzVYukJ1VSRn270NBYZB3OeRmUG2w=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=o4WK2tomHJyX//ZJMLrjnCznMznZ4M39WeS1J0P/75PeUynrVq/Cpq6iIDX/OBUxF
         UJ9TRHFc8N3M5cFaHDh2jPzpevN8DyoK7civOxHo7Wbwsk1dOXi0Y48bvllmY9YM9G
         xoO3sXopeNqLpZV7EYxxN0mSmoYj4pS0Si/lUJTg=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20221125165130epcas5p49bd74a1484f00fc42020417a8c4f2edb~q4f1of7lt1944819448epcas5p4n;
        Fri, 25 Nov 2022 16:51:30 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.177]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4NJgqh6Hfmz4x9Pp; Fri, 25 Nov
        2022 16:51:28 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        53.DB.01710.092F0836; Sat, 26 Nov 2022 01:51:28 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20221125165128epcas5p235e5a7e6e8cedb4d2bd8b4b3b665287a~q4fz0Be0n1344413444epcas5p2H;
        Fri, 25 Nov 2022 16:51:28 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20221125165128epsmtrp1bbde73e660ca66ad9748d2ec7d6750ee~q4fzywBQg0665006650epsmtrp1K;
        Fri, 25 Nov 2022 16:51:28 +0000 (GMT)
X-AuditID: b6c32a49-a41ff700000006ae-e1-6380f2906602
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        34.78.18644.092F0836; Sat, 26 Nov 2022 01:51:28 +0900 (KST)
Received: from alimakhtar03 (unknown [107.122.12.5]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20221125165126epsmtip12f351d4d00071f23e5cea131268fb25b~q4fyGLcua2544025440epsmtip1n;
        Fri, 25 Nov 2022 16:51:26 +0000 (GMT)
From:   "Alim Akhtar" <alim.akhtar@samsung.com>
To:     "'Krzysztof Kozlowski'" <krzysztof.kozlowski@linaro.org>,
        "'Lee Jones'" <lee@kernel.org>,
        "'Rob Herring'" <robh+dt@kernel.org>,
        "'Krzysztof Kozlowski'" <krzysztof.kozlowski+dt@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>
Cc:     "'Sriranjani P'" <sriranjani.p@samsung.com>,
        "'Chanho Park'" <chanho61.park@samsung.com>,
        "'Sam Protsenko'" <semen.protsenko@linaro.org>
In-Reply-To: <20221125112201.240178-1-krzysztof.kozlowski@linaro.org>
Subject: RE: [PATCH 1/4] arm64: dts: exynos: add dedicated SYSREG
 compatibles to Exynos5433
Date:   Fri, 25 Nov 2022 22:21:25 +0530
Message-ID: <01a301d900ee$296c9a60$7c45cf20$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQEl57WeJxIID+RuA0nkUAo6PXiBwQIt87tfr6SbseA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJJsWRmVeSWpSXmKPExsWy7bCmpu6ETw3JBneP6Vtc3q9tMf/IOVaL
        vhcPmS32vt7KbrGjbSGLxabH11gtLu+aw2Yx4/w+JovWvUfYLZ73AVm336xjdeD22LSqk83j
        zrU9bB6bl9R79G1ZxejxeZNcAGtUtk1GamJKapFCal5yfkpmXrqtkndwvHO8qZmBoa6hpYW5
        kkJeYm6qrZKLT4CuW2YO0GFKCmWJOaVAoYDE4mIlfTubovzSklSFjPziElul1IKUnAKTAr3i
        xNzi0rx0vbzUEitDAwMjU6DChOyMjW9+sRRcEa5oPvefrYHxlkAXIweHhICJRHszRxcjF4eQ
        wG5GiT0zJ7JDOJ8YJZoWv2PpYuQEcj4zSsw8VgFigzQs2gESBynaxSixYWk3M4TzklFi2vYL
        jCBVbAK6EjsWt7GBJEQELjFJvHs7gRXEYRboY5RY9XoR2FxOAVeJ3jVrWEFsYYFYiZapnewg
        R7EIqEpMOiUEEuYVsJToPNjKBGELSpyc+QSslVlAXmL72znMECcpSPx8uowVIi4u8fLoEXYQ
        W0TASmL+7AZWiJodHBLTexUhbBeJ3/OfQfUKS7w6voUdwpaSeNnfxg4JFw+JRX+kIMIZEm+X
        r2eEsO0lDlyZwwJSwiygKbF+lz7EVj6J3t9PmCA6eSU62oQgqlUlmt9dZYGwpSUmdnezwgz/
        8sBlAqPiLCRvzULy1iwkr8xC2LWAkWUVo2RqQXFuemqxaYFhXmo5PLKT83M3MYLTrJbnDsa7
        Dz7oHWJk4mA8xCjBwawkwptwvCFZiDclsbIqtSg/vqg0J7X4EKMpMKgnMkuJJucDE31eSbyh
        iaWBiZmZmYmlsZmhkjjv4hlayUIC6YklqdmpqQWpRTB9TBycUg1MJXH9obPSlY/fe7GacWrA
        kiOvlPa2OnVd/3fba43xnEfPtlc+bH7I1/n+FBPD3AdzJfyclHYsSO/eJbLsNt/lzKk6N7eF
        aCoZ3VvqOiPh6BLDYpW2DWffPqsJNE7zEzH1l6i7cWJOB6Pe3vtaE7gmOqtdOhVwZ/p5gTkL
        DPXPzfhgbrt5Te2P9g4BcfW7L//Na9dbcu97cuQ/Jofiy0/8WiMOlIsdutKwky0nrvebsdiu
        kPXZs06Z6x2a+CY7s2HJlsLG1btbzr330v91NrNKY4/q/L47LnUr/Zd69YicfbyEWWS76i8Z
        MZ4TTs9m6sqJfFtQtvKk2dLnn89M0xNjXTZP6BG33k/ddva9ghPd9iuxFGckGmoxFxUnAgBw
        XBPbPAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMIsWRmVeSWpSXmKPExsWy7bCSnO6ETw3JBl1HBCwu79e2mH/kHKtF
        34uHzBZ7X29lt9jRtpDFYtPja6wWl3fNYbOYcX4fk0Xr3iPsFs/7gKzbb9axOnB7bFrVyeZx
        59oeNo/NS+o9+rasYvT4vEkugDWKyyYlNSezLLVI3y6BK2Pjm18sBVeEK5rP/WdrYLwl0MXI
        ySEhYCKxaMc7li5GLg4hgR2MElNOfWWDSEhLXN84gR3CFpZY+e85O0TRc0aJpz82sIAk2AR0
        JXYsbmMDSYgI3GCSmL3mFtgoZoEJjBLbFnxkBKkSEpjGKPHspR2IzSngKtG7Zg1rFyMHh7BA
        tMS5m0IgJouAqsSkU0IgFbwClhKdB1uZIGxBiZMzn7CAlDAL6Em0bQQbyCwgL7H97RxmiNsU
        JH4+XcYKEReXeHn0CNjNIgJWEvNnN7BOYBSehWTSLIRJs5BMmoWkewEjyypGydSC4tz03GLD
        AqO81HK94sTc4tK8dL3k/NxNjOB409Lawbhn1Qe9Q4xMHIyHGCU4mJVEeBOONyQL8aYkVlal
        FuXHF5XmpBYfYpTmYFES573QdTJeSCA9sSQ1OzW1ILUIJsvEwSnVwLRd/IuCmm1+acRqd+H7
        W7bl2s8vzb2sESn67PfdU088ZrQXW1Y9KuyacfuM3ULDo1FcPg4lFnPtmb8n3b/FJP0rQGjh
        rWS5639ies2SjJ6uzZl7yTn9q0+P5Pfzqmpuhp3zr53xWKWaFNw72UWqdkn3pE3uax70aG+a
        +FozON/fc02nuTOftHxdISuT9FkN487ph9JPTpnwW/qIYolg/TzpGZ7L500L990RYx9QsP3J
        lynCAvr65vuenQx2/ZczRXvOVbkX3G9u70qr/aWbFH1treTCA3vrHty78PUu91cdi8ehdk1C
        3H1bLz3knbImnmtSS/qW6FUKuTNy3k0PVzNdy39gv0UG38utYv4XWpRYijMSDbWYi4oTAUuN
        ZmcmAwAA
X-CMS-MailID: 20221125165128epcas5p235e5a7e6e8cedb4d2bd8b4b3b665287a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221125112237epcas5p1e5bc397a2fe207c6b8f5864f89d9b991
References: <CGME20221125112237epcas5p1e5bc397a2fe207c6b8f5864f89d9b991@epcas5p1.samsung.com>
        <20221125112201.240178-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>-----Original Message-----
>From: Krzysztof Kozlowski [mailto:krzysztof.kozlowski@linaro.org]
>Sent: Friday, November 25, 2022 4:52 PM
>To: Lee Jones <lee@kernel.org>; Rob Herring <robh+dt@kernel.org>;
>Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>; Alim Akhtar
><alim.akhtar@samsung.com>; devicetree@vger.kernel.org; linux-
>kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
>samsung-soc@vger.kernel.org
>Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>; Sriranjani P
><sriranjani.p@samsung.com>; Chanho Park <chanho61.park@samsung.com>;
>Sam Protsenko <semen.protsenko@linaro.org>
>Subject: [PATCH 1/4] arm64: dts: exynos: add dedicated SYSREG compatibles
>to Exynos5433
>
>Exynos5433 has several different SYSREGs, so use dedicated compatibles for
>them.
>
>Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>

Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>
>---
>
>Cc: Sriranjani P <sriranjani.p@samsung.com>
>Cc: Chanho Park <chanho61.park@samsung.com>
>Cc: Sam Protsenko <semen.protsenko@linaro.org>
>---
> arch/arm64/boot/dts/exynos/exynos5433.dtsi | 12 ++++++++----
> 1 file changed, 8 insertions(+), 4 deletions(-)
>
>diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
>b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
>index bd6a354b9cb5..6976e45aa769 100644
>--- a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
>+++ b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
>@@ -1118,22 +1118,26 @@ hdmiphy: hdmiphy@13af0000 {
> 		};
>
> 		syscon_disp: syscon@13b80000 {
>-			compatible = "samsung,exynos5433-sysreg", "syscon";
>+			compatible = "samsung,exynos5433-disp-sysreg",
>+				     "samsung,exynos5433-sysreg", "syscon";
> 			reg = <0x13b80000 0x1010>;
> 		};
>
> 		syscon_cam0: syscon@120f0000 {
>-			compatible = "samsung,exynos5433-sysreg", "syscon";
>+			compatible = "samsung,exynos5433-cam0-sysreg",
>+				     "samsung,exynos5433-sysreg", "syscon";
> 			reg = <0x120f0000 0x1020>;
> 		};
>
> 		syscon_cam1: syscon@145f0000 {
>-			compatible = "samsung,exynos5433-sysreg", "syscon";
>+			compatible = "samsung,exynos5433-cam1-sysreg",
>+				     "samsung,exynos5433-sysreg", "syscon";
> 			reg = <0x145f0000 0x1038>;
> 		};
>
> 		syscon_fsys: syscon@156f0000 {
>-			compatible = "samsung,exynos5433-sysreg", "syscon";
>+			compatible = "samsung,exynos5433-fsys-sysreg",
>+				     "samsung,exynos5433-sysreg", "syscon";
> 			reg = <0x156f0000 0x1044>;
> 		};
>
>--
>2.34.1


