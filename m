Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD0E6275A6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 06:45:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235807AbiKNFpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 00:45:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235665AbiKNFpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 00:45:00 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55914175A5
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 21:44:49 -0800 (PST)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20221114054447epoutp0276d44c3b1711d245cf1364de316100e3~nXTlFuEO90439604396epoutp028
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 05:44:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20221114054447epoutp0276d44c3b1711d245cf1364de316100e3~nXTlFuEO90439604396epoutp028
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1668404687;
        bh=VUPNyPP65Q8amq2++YTPnc2vQJAOUVPlJkAD/OQoUfU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sq1fZjxREUnDsLoaYzr+5FbOh1O5o57K+ctas3UOlbl3q38VabqK9iwsMnEVFmMgl
         i9MUbPIVLC8BGv0g5UH+RRDMysMhxKgASXCF+kTSjAlo3yDd9d3uzTbt0+JcNP6QH+
         c/53H3+TOdwGuUA+xWt18WK/4ZI90SxTev9waiiE=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20221114054446epcas5p15bd51a449819ab9af6eb10c8d646e085~nXTkfPt-j1379513795epcas5p1Q;
        Mon, 14 Nov 2022 05:44:46 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.176]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4N9dYQ2jx3z4x9Q6; Mon, 14 Nov
        2022 05:44:42 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B3.CD.01710.AC5D1736; Mon, 14 Nov 2022 14:44:42 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20221114054053epcas5p1f88b41bce65d54f0f26d0b562e88f7d6~nXQLFMQno0126401264epcas5p1i;
        Mon, 14 Nov 2022 05:40:53 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20221114054053epsmtrp2c298815cafcfcbe1281022b7c78f8b5f~nXQLD6xEQ2028920289epsmtrp2U;
        Mon, 14 Nov 2022 05:40:53 +0000 (GMT)
X-AuditID: b6c32a49-c9ffa700000006ae-eb-6371d5ca3046
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        8D.A6.18644.5E4D1736; Mon, 14 Nov 2022 14:40:53 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20221114054049epsmtip20959451eee51877cbc97d0f06c258799~nXQHMqWrx2101521015epsmtip2O;
        Mon, 14 Nov 2022 05:40:49 +0000 (GMT)
From:   Aakarsh Jain <aakarsh.jain@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     m.szyprowski@samsung.com, andrzej.hajda@intel.com,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        ezequiel@vanguardiasur.com.ar, jernej.skrabec@gmail.com,
        benjamin.gaignard@collabora.com, krzysztof.kozlowski+dt@linaro.org,
        stanimir.varbanov@linaro.org, dillon.minfei@gmail.com,
        david.plowman@raspberrypi.com, mark.rutland@arm.com,
        robh+dt@kernel.org, krzk+dt@kernel.org, andi@etezian.org,
        alim.akhtar@samsung.com, aswani.reddy@samsung.com,
        pankaj.dubey@samsung.com, smitha.t@samsung.com,
        aakarsh.jain@samsung.com
Subject: [Patch v4 3/3] ARM: dts: exynos: Add new SoC specific compatible
 string for Exynos3250 SoC
Date:   Mon, 14 Nov 2022 11:16:55 +0530
Message-Id: <20221114054655.68090-4-aakarsh.jain@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221114054655.68090-1-aakarsh.jain@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VTfUxbVRzN7Xvta1lq3sqWXbrJWCMYYECrpd4aPhZl+PYRQ1w00cWUZ3kC
        obSlLeAWnVPHpmTgYEPlY92k4DIYMFpgHSsblCLKAsiAMZHqgHW0xI8N1IAC2tKi/53fOefe
        3++eey8XE0xxhNxstYHRqWmViBOEd/RGPh0zMJ6nFJvPC5DLWslG940dHGRammOhn0yLOLJb
        2gnUNlaNoUv93Wx0wTHERtd6ZnDU6vaqI5VOHM1daAbIU/UjB5W6pzFknr3LRqOdNRx0+mo7
        GzU5nASqnxhhoa/MKyxU2/47gYq6HARy2joAOnHSwdoDqSvGK4CyOusANVG3gFHXq5wEZbJ5
        WJS54RMONXXXxqEsde9TRX1/4VRpWwOgih0THGrRHEoN/LFIpPHfyEnIYugMRhfGqJWajGx1
        ZqLowCHFi4p4mVgSI5Gj50RhajqXSRSlHEyLSc1WeSMQhRXQqnwvlUbr9aK4pASdJt/AhGVp
        9IZEEaPNUGml2lg9navPV2fGqhnD8xKx+Jl4rzE9J8uzUodry3nv3Lp1EjsOnEQx4HEhKYXD
        tx+DYhDEFZA3ABysrQ4UC97i1BzhLxYBXJk8wdlY8qWrB/cLnQA+7B5l+wQBWcSC9ZMRxYDL
        5ZAxcPCaykdvIT8AcPZjg8+PkWU4/KHUjfmEYJKBjpJP1zFOhsOKkg+BD/PJRLg2UQn8zXbC
        xqvd6x4emQSnqmcw30aQ/IgH++sXAodIgTdvXMT8OBjO97cFeCFc/LUrMLUSztZ6Ah4VbLGd
        w/04GXaP1eC+oTEyErZ0xvnpJ2HFQDPLhzHyCVjy9wOWn+dDq3EDR8CaqSW2H++AvY31gZkp
        eLbVyfYHVOaNsWWSOANCq/5vcRGABhDCaPW5mYw+XitRM4X/3ZpSk2sG6888ap8VOO8/irUD
        FhfYAeRioi184w6NUsDPoI8cZXQahS5fxejtIN4bYBkm3KrUeP+J2qCQSOViqUwmk8qflUlE
        2/imL6KUAjKTNjA5DKNldBvrWFye8Dhr2zSWd5OT/Oe9n8/cGXKsvTBYM7/n3L7x15qHR2bG
        3hKeN94OH/7t0JtBo0O2gVcvDaVbyvq+d6eWe1xj4cc+u1xyirbKV8x1Ed8e2TUjn78jn1Y8
        csFfgsJthbs2xXh4xpyCioTop+TwZbdYtnR9+ii4nJLqwpaFzOFI65LLzUuezROtraqmHu9u
        61n9513Y5znYa7JUxH1OLUd8Q2inFT2NWPYm9bJ9PKN76wFL+cKx9NaQuaaRoAfvRdecJXTB
        hLbe/vZ8KP3daqNrc+/c16+EWbZvP12wv6ms9LApa2/RS/s3R7vCGZJ+uHcpoYgBhc07Xw8p
        r12hpfe64jqTdotwfRYticJ0evpfgtnVsW8EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRfSzUcRzH+/6e7ndXp9+QvlFst5WmEWr2XUUp1W9WVn/UWg/LxW8Ux3XX
        CcvD0tkyWWr+cHI9HOouFceJnKfrMC1h5LQ69IDOpkTloZtyqf9en/fDPp/tQ+PONwl3+mzC
        BU6WII4XUQKi5rnIy3ek73yU/6B2FRqpLSTRsLqGQprZMQwNaaYJZKoy8FB1XxGO7rc3k+i2
        +RWJnrZ8IFDl50W3p9BKoLHbjwGyqQYplPf5PY70H/tJ1PvsFoVyKwwkemS28lCppQdDZXo7
        hu4ZvvOQssHMQ1ZjDUBXss3YLsiWq8sBW2stAaylZApn61RWHqsx2jBWr7tKse/6jRRbVZLB
        KlvnCTavWgfYHLOFYqf1nuyLH9O8Q8Ljgh3RXPzZJE62OSRSEGuzlxDSG/zkpqZsPBNYeTmA
        T0NmK7w70kI42JmpBXC0Ubqkr4W/s9v+ZVygdmFskQWLmSwMmm1ziwWaphhf2Pk03qG7MkoA
        LdqrmGPAGS0B31bmYo62CxMFc8frSAcTzHpYcO0ycLCQCYYLlkKwtMELPqxoxh3MZ0Lgu6IP
        +NJFwfBG9wPiOnC6A5bpwBpOKpfESOQB0sAE7qKfXCyRKxJi/KISJXrw928+PrXAqJv0MwGM
        BiYAaVzkKlSvTYxyFkaLU1I5WeJpmSKek5uAB02IVgu7czpOOzMx4gtcHMdJOdl/F6P57plY
        yMw6xalQxlRfKklKP+ePwZ3ZE41lQSm9zedPunR12EcPHxo5UJYRuk25POtTW4bKT/AtLbTg
        5+C+iLdHvtjICI1xcoW3/PKbg10p96eVH1tUNeM/wzy3ux3Ndz86tPLYie+Vcb3Xkns6R6vt
        c27PkvcuTxKEMsXkxOupZu9L3ht+ZJFtD+bte4tnMqvr/V2nPObT9rwH/IaTmwt+L4RZfFce
        qXLpwfOHi6IV9ar9hk1x2qAzBmFdQPDB2WjDgKxPuSpvrH/OS52XM2rWmgLTX/4KfwJ3T8q2
        6MjOjanJxelMZMN4ROvXyDqPGUVR+ADVbtQMpDiVDovCVwhbzR1vRIQ8Vhzgg8vk4j/2GgaX
        JgMAAA==
X-CMS-MailID: 20221114054053epcas5p1f88b41bce65d54f0f26d0b562e88f7d6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221114054053epcas5p1f88b41bce65d54f0f26d0b562e88f7d6
References: <20221114054655.68090-1-aakarsh.jain@samsung.com>
        <CGME20221114054053epcas5p1f88b41bce65d54f0f26d0b562e88f7d6@epcas5p1.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit "752d3a23d1f68de87e3c" which adds MFC codec device node
for exynos3250 SoC. Since exynos3250.dtsi and exynos5420.dtsi are
using same compatible string as "samsung,mfc-v7" but their node
properties are different. As both SoCs have MFC v7 hardware module
but with different clock hierarchy and complexity.
Add new compatible string followed by mfc-v7 fallback for Exynos3250
SoC.

Reviewed-by: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
Suggested-by: Alim Akhtar <alim.akhtar@samsung.com>
Signed-off-by: Aakarsh Jain <aakarsh.jain@samsung.com>
---
 arch/arm/boot/dts/exynos3250.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
index 326b9e0ed8d3..1a29993fca0b 100644
--- a/arch/arm/boot/dts/exynos3250.dtsi
+++ b/arch/arm/boot/dts/exynos3250.dtsi
@@ -485,7 +485,7 @@
 		};
 
 		mfc: codec@13400000 {
-			compatible = "samsung,mfc-v7";
+			compatible = "samsung,exynos3250-mfc","samsung,mfc-v7";
 			reg = <0x13400000 0x10000>;
 			interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "mfc", "sclk_mfc";
-- 
2.17.1

