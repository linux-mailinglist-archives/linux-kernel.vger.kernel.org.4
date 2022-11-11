Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E875D6252A4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 05:34:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232867AbiKKEec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 23:34:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232746AbiKKEeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 23:34:21 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E57146A747
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 20:34:19 -0800 (PST)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20221111043418epoutp025c5b2a13721585e2b7b6e53b083942e6~mbaLhLfAU1351913519epoutp02e
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 04:34:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20221111043418epoutp025c5b2a13721585e2b7b6e53b083942e6~mbaLhLfAU1351913519epoutp02e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1668141258;
        bh=I1h3AraRZ5r0FizcGhsBmyj3WZa0LneUyzoFvuYazag=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bMctFOEmVIirdLB6pw6Ytxi7Si92ejCzXJ4OQsnmIt5b2Ds1vjZM3e3bjh6f3PHxV
         ZHYI3jwnSUBFSGWI5jN95LdB8D3vWwD07457bXFvbCjWQ+dOhY0t9wz5tC4W+7k1t2
         ppf3qqBCa0R7vabhDHKf1Jd19PwchFMJeKdbOiHI=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20221111043417epcas5p3508ab32bacdab06dc2223b70480f3996~mbaK0CCOL1477014770epcas5p3E;
        Fri, 11 Nov 2022 04:34:17 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.176]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4N7m7W1L0gz4x9Px; Fri, 11 Nov
        2022 04:34:15 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F1.68.01710.4C0DD636; Fri, 11 Nov 2022 13:34:12 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20221111031718epcas5p3df130145b4bb99424fd5aa4addf77ba5~maW8sG4Fs1781417814epcas5p3j;
        Fri, 11 Nov 2022 03:17:18 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20221111031718epsmtrp11550ca1c28a9507a68d4a1c04c0cb522~maW8k_oTj2207322073epsmtrp1L;
        Fri, 11 Nov 2022 03:17:18 +0000 (GMT)
X-AuditID: b6c32a49-a41ff700000006ae-a5-636dd0c48426
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        2B.92.14392.DBEBD636; Fri, 11 Nov 2022 12:17:17 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20221111031714epsmtip12d4106982a2f53c6403255619ba13135~maW5UK0Of2921529215epsmtip1D;
        Fri, 11 Nov 2022 03:17:14 +0000 (GMT)
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
Subject: [Patch v3 3/3] ARM: dts: exynos: Rename compatible string property
 from version to SoC specific
Date:   Fri, 11 Nov 2022 08:53:37 +0530
Message-Id: <20221111032337.79219-4-aakarsh.jain@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221111032337.79219-1-aakarsh.jain@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VTbUxTVxjeube9LUrnXVE5Q6d4jXMQC62W7kCgMj/mndMFQ/aHZetquSuM
        9rZpi/MrGY6POFQYqQSoDDZBSPgeUKgIGWAbgkwygqNjs1A+ppSRqcDEIUvWUnT/nvM+z/M+
        b95zDh8X/kaE8FNZE2NglRqKWMdpux0WJrL/rFWJf3y8Bf1hK+Eid1kbgSqePcTQeMUCB/W2
        WHmo9d41HFX3dXNRuX2Qi9p7JjnohxkvO1Ti4qCH5Q0AeSxjBMqbmcBR89QIFw13lBLocpOV
        i+rtLh664RzCUFXzCoauWxd5KLvLzkOuzjaAsnLsWDyk68rqAG1zVQLaWTmP0zctLh5d0enB
        6Oaarwn6/kgnQbdUfklnO5Y5dF5rDaBz7U6CXmjeRt/5e4GXIEhKi01hlMmMIZRhVbrkVFYd
        R72fqDioiJKJJSJJNHqbCmWVWiaOOnQsQfRuqsa7Air0lFKT7i0lKI1GKlIea9Clm5jQFJ3R
        FEcx+mSNXqqPMCq1xnRWHcEyphiJWLw3yiv8NC3F9lOifol/2jXvABnAwcsFAXxISmHngxKQ
        C9bxheQtAPMty6uEkJwHsGxI5CeeAjj+dOyl49/JUa6f6AJworyY4z9kY7C9f4DIBXw+QYrg
        3XaNz7CRvADg1EWTT4OTBRz4e94M7iOCyM+hJXsF+DCH3AX/6Vrk+bwCMg46zBv8YdthbVP3
        qjyAlEN3deNqFiQzA+D8t9e4ftEhuNzmwfw4CM72ta5NGgI9+TlrWAWnrntwP9bAxs6rHD/e
        D7vvlXJ8uTgZBhs7Iv3lN2DhnYbVljj5KrzyfHqtvQDayl7gN2Hp/WdrI2yFt2tvAD+m4ZWi
        grWVFgCYUW3FvgHbLP9HfAdADXid0Ru1asYYpZewzBcv70yl0zaD1Uce/p4NuNyPI3oBxge9
        APJxaqNg/VtpKqEgWXnmLGPQKQzpGsbYC6K8+yvAQzapdN5fwpoUEmm0WCqTyaTR+2QSKlhQ
        URyuEpJqpYlJYxg9Y3jhw/gBIRmYZGB4J3a3ipnUNlAZMtE7FZPHAztYS2y0IPPwyc2FFy7K
        FFtmLx2/XPNxmuBg0WcfxIePqx1Nv9wyb04Un5140Od2RFVT4TEaTZZs+swGZy2bTXQ/GmjZ
        7zR0y+XfBw+GiJjDdR6F5HykvGmlqNyQ9NXzpZ3KRT1lHbaZ8pde21efMVOfIxhd+vPDV67W
        n8wszWqcUyeV1J5yPjFbpqeHd0j3YIXzc4GRR3+dlVcl7jnRL3Cvf6SutFk/2XpzV29MT+Kx
        oz27tXk7zJuetJuL9duPROj/Sk5i5RNz0Xm7Lw22OAOPtJSdOHB6LKFj5KNzZia+vwg/b3Xt
        PScMCnaPFlEcY4pSEo4bjMr/AOY1xeJtBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIIsWRmVeSWpSXmKPExsWy7bCSnO7efbnJBvs2Wlo83TGT1eLBvG1s
        Fot/PGeyuL/4M4vFoc1b2S22XJnNbLH8+AFWi/lHzrFabD/4iMVi4wug7MWZd1ksns9fx2jx
        ctY9Nou+Fw+ZLTY9vsZqcXnXHDaLng1bWS3WHrnLbrH0+kUmi2Wb/jBZLNr6hd2ide8Rdou7
        e7YxWrS0HWFykPBYM28No8eOu0sYPa4v+cTssXPWXXaPxXteMnlsWtXJ5nHn2h42j81L6j1a
        j/5i8ejbsorRo+vIdTaPz5vkPE59/cwewBvFZZOSmpNZllqkb5fAlbHjTHDBd46Ku5+OMjYw
        HmXvYuTkkBAwkfj76CZrFyMXh5DAbkaJk3u72SASMhL/245BFQlLrPz3nB2iqJlJ4lf7TaYu
        Rg4ONgFdibPbc0DiIgKtjBLXV3YygTjMAitZJG5v7GEC6RYWyJBoPnuXGcRmEVCV+Ln3CztI
        M6+ArcTRyfwQC+QlVm84AFbCKWAn8WD5ehaQEiGgkva/WhMY+RYwMqxilEwtKM5Nzy02LDDM
        Sy3XK07MLS7NS9dLzs/dxAiONS3NHYzbV33QO8TIxMF4iFGCg1lJhJdbIztZiDclsbIqtSg/
        vqg0J7X4EKM0B4uSOO+FrpPxQgLpiSWp2ampBalFMFkmDk6pBiYd2Sqt7hz+vfbrL/x27Zrw
        tqfL5t/VU9erzD0Fnp98kB7uf7xX4ch2p5sN4VOWcZSae8QmOf7arLD2TX7g9s0lxhU+l+Wi
        Hxrsybu8Z3GcRZNz/LeauHedqxUdQneUnldR2x326t3P2w9Dj+s5Hyl362daYhzJm5l46vKh
        pkl62+zu2y6fI/1ftPXivROBf7U+FXyYa9YRZPuNqVigNUVHafPppQsXzDBjvjK7cddSvRcH
        z2q0bV6zy8LF+/MjoQm7VW5Mr7i194dw5M6l4Z6NfE8uH5rgVHj0Sqrr9AUFSU9kbK1mV/ZG
        bikR07pvKb1E7UBHkqpqf/vP1Xoufez6NXKHlmyJ13cUy9IoOa7EUpyRaKjFXFScCAAtVpTc
        JAMAAA==
X-CMS-MailID: 20221111031718epcas5p3df130145b4bb99424fd5aa4addf77ba5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221111031718epcas5p3df130145b4bb99424fd5aa4addf77ba5
References: <20221111032337.79219-1-aakarsh.jain@samsung.com>
        <CGME20221111031718epcas5p3df130145b4bb99424fd5aa4addf77ba5@epcas5p3.samsung.com>
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
using same compatible string as "samsung,mfc-v7" but their
node properties are different.As both SoCs have MFC v7 hardware
module but with different clock hierarchy and complexity.
So renaming compatible string from version specific to SoC based.

Reviewed-by: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
Suggested-by: Alim Akhtar <alim.akhtar@samsung.com>
Signed-off-by: Aakarsh Jain <aakarsh.jain@samsung.com>
---
 arch/arm/boot/dts/exynos3250.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
index 326b9e0ed8d3..98105c64f7d9 100644
--- a/arch/arm/boot/dts/exynos3250.dtsi
+++ b/arch/arm/boot/dts/exynos3250.dtsi
@@ -485,7 +485,7 @@
 		};
 
 		mfc: codec@13400000 {
-			compatible = "samsung,mfc-v7";
+			compatible = "samsung,exynos3250-mfc";
 			reg = <0x13400000 0x10000>;
 			interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "mfc", "sclk_mfc";
-- 
2.17.1

