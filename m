Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1DEC61762E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 06:30:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbiKCFaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 01:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbiKCF3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 01:29:52 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE0018B0C
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 22:29:50 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20221103052948epoutp049cf598c9261f3105980b14aac9cc3f64~j-AXKtia32023520235epoutp04S
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 05:29:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20221103052948epoutp049cf598c9261f3105980b14aac9cc3f64~j-AXKtia32023520235epoutp04S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1667453388;
        bh=4qBUx2QDAhX1kh6nWGZRrxqRso5GJ9KFQ9asXvnAyPw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TCf1eeLb/cphCZsdXUjB5YhbZmH5OEB0fdWgNx1eFWbS/dW2ADxVKJw4zYu1Ddg7T
         mpbaV+2IB4gVuJAXkh1cpKfNr7WuTCgWEfvPdlqgetHJnLZN5mJuNpPfjIh2wLoK1g
         4ZE0fn0YdXzZlBT8Wd32+GmClgxhjcMoUTq183YI=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20221103052948epcas5p4fdbc03d2b51af6b5a457ec218d039a24~j-AWbyKkz2152821528epcas5p47;
        Thu,  3 Nov 2022 05:29:48 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.174]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4N2slB1Z6lz4x9Q5; Thu,  3 Nov
        2022 05:29:42 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        5D.9B.56352.4C153636; Thu,  3 Nov 2022 14:29:40 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20221102125816epcas5p23e16fefd6b820e7dd7d9a93f0d48f40d~jxeo9kLch3082130821epcas5p2t;
        Wed,  2 Nov 2022 12:58:16 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20221102125816epsmtrp2841e089a1f09752becc1a2fcd866e6ff~jxeo8XqlW1846518465epsmtrp2n;
        Wed,  2 Nov 2022 12:58:16 +0000 (GMT)
X-AuditID: b6c32a4b-5f7fe7000001dc20-1e-636351c4b7b0
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F5.04.14392.86962636; Wed,  2 Nov 2022 21:58:16 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20221102125813epsmtip1dad99ce1b696e3f0129399b84bed9246~jxel4p4wh2204122041epsmtip1w;
        Wed,  2 Nov 2022 12:58:13 +0000 (GMT)
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
Subject: [PATCH 3/3] arm64: dts: exynos: Rename compatible string property
 from version to SOC specific
Date:   Wed,  2 Nov 2022 18:36:02 +0530
Message-Id: <20221102130602.48969-3-aakarsh.jain@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221102130602.48969-1-aakarsh.jain@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WTf0xbVRTHve+1r2VJ2RNw3qGM2o05MLB2tPWyAPMHmS9iIgtZpkwHj/IC
        jP5KX3E6MQwnzoEg3YbKj3SGHy4yfpaf7WBltDgyhckkoLGFCSOj4HAUGYu4aWnZ/O9z7vme
        8z05914+HuAggvnZaj2jU9NKEbGJ02ULD4+0H1AoxPbTz6PZngouumnsIlDt/dsYmqpd5qCB
        9k4e6hirwtGFq/1cdN4+wkXdV6Y5qG3Okx2tcHLQ7fPNALkqJwlUOvc7jkwz41z0s6WaQJ+3
        dnJRk93JQ/UToxj61vQPhmo6/+Khwj47Dzl7uwD65FM79hKkGo2NgOpx1gFqos6NU+ZKJ4+q
        7XVhlKnhNEE5xnsJqr0unyoc/JtDlXY0AKrIPkFQy6Zt1LWVZV6SICUnNouhMxidkFErNBnZ
        6sw4UWJy6qupMrlYEimJQS+KhGpaxcSJEt5IityfrfSsQCR8j1bmeo6SaJYV7Y6P1Wly9Yww
        S8Pq40SMNkOplWqjWFrF5qozo9SMfq9ELN4j8wjTcrJKrBWY9iH//cliI+cEGOQVAT8+JKXw
        Qd9JUAQ28QPISwBaVy9wfIEbwHutbYQvuAdg2czI45KqW0PYOgeQfQAWNDI+USEGv+xq9VTw
        +QQZCYe7leuaILIAwJnP9OsanDRw4G+lc/h6IpDMhsVflXgbccgweP1ug9dAQMbBjxe/x31m
        ofBia7+X/ch4uPprkXdWSP7Lhw7bNOYTJUBb9yrHx4Fw/mrHxqTBcHmxj/CxAs7UuDaaKmFL
        77kN/T7YP1bNWR8aJ8Nhi2W37zgEll9r9rbHSX9YsnZrw0oAe4yPeCesdtzn+vhZaLtYD3xM
        weXVIa5vKQYAG69M4WVgW+X/Ft8A0AC2MlpWlcmwMm20mjn2+NYUGpUJeJ95RGIPmL55N2oA
        YHwwACAfFwUJ8ocPKwIEGfQHxxmdJlWXq2TYASDzLNCABz+l0Hj+iVqfKpHGiKVyuVwaEy2X
        iJ4W1H4doQggM2k9k8MwWkb3qA7j+wWfwKp2pi3tSSwZNAfLXNb0j96xVO+fY+U7lpbWaDAw
        fybeanMLi7Gyhu3H9lrXDJOgX7s1fSRv0OxfrhgOfHvKvch9+SfZ0aJdB85SjifNhWHtK9Gn
        Di0s1BQmpJf8EpEoVje/6U/XZAsFE/nFZfrra7uMl17fkTpkGzuqL7icYXGGza9aD4pTjpyq
        C3nQPR5U/2HtEWOoS0CEzQ5/McS0bD5cVvDdjYdRubPl9Xkr7gXpnRvyUdVbm59pyjuk6GvV
        /ek2O9rOvJCywDZZDMLLSPNKwROT50LOhqruGM3bf3jOteXgjyrDa6FhseZ3ccnIyag/0rYk
        5+8z6ZOPM5axyYl0EYfNoiURuI6l/wPUiL67bwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCIsWRmVeSWpSXmKPExsWy7bCSnG5GZlKyweJDehZPd8xktXgwbxub
        xeIfz5ks7i/+zGJxaPNWdostV2YzWyw/foDVYv6Rc6wW2w8+YrHY+AIoe3HmXRaL5/PXMVq8
        nHWPzaLvxUNmi02Pr7FaXN41h82iZ8NWVou1R+6yWyy9fpHJYtmmP0wWi7Z+Ybdo3XuE3eLu
        nm2MFi1tR5gcJDzWzFvD6LHj7hJGj+tLPjF77Jx1l91j8Z6XTB6bVnWyedy5tofNY/OSeo/W
        o79YPPq2rGL06Dpync3j8yY5j1NfP7MH8EZx2aSk5mSWpRbp2yVwZfTun8lU8I+j4l73PJYG
        xqPsXYycHBICJhKzn5xg6mLk4hAS2M0osWXuPSaIhIzE/7ZjUEXCEiv/PWeHKGpmkpix8yJj
        FyMHB5uArsTZ7TkgcRGBVkaJ6ys7wSYxC6xkkbi9sQdskrBAusTedZ0sIDaLgKrE+Q+rwKby
        CthKNL07xgyxQV5i9YYDYDangJ3E95tdjCC2EFDNxp7rzBMY+RYwMqxilEwtKM5Nzy02LDDM
        Sy3XK07MLS7NS9dLzs/dxAiOOC3NHYzbV33QO8TIxMF4iFGCg1lJhLf+bHSyEG9KYmVValF+
        fFFpTmrxIUZpDhYlcd4LXSfjhQTSE0tSs1NTC1KLYLJMHJxSDUzrnd8vDtdntam0iT/k85RP
        XVH3/67fUZ8k8wPcw54X9D4933VpRuUWU/Yz2lr1G97Fbf7y1HUxh4BheuLWAKZlR+9fNfr+
        hT/voKsx07u/p46K3GB8ntV+RWa1vP46SV7jw6vvJ+fZm1xfu8Vn8//f9w8XX1dhXc0qOJHv
        yYfGjAc8Mg83i+svv6fmWGvNG7cks+pZGcvxhZ6qVw7psAfn23PPrmpN674qzrLNwEzxx/1u
        3V+SSnKqRuJBTPNqnp71budiF+xnPLGToWZ6AXtB+5HkhFmZFoKfxS+X3/l85PPqYzHz+57y
        ls5zrO9sfBzwg99UVvlC+Ha56bdU3/u+iHPp+tNeKcib0njYXImlOCPRUIu5qDgRAMv2evAn
        AwAA
X-CMS-MailID: 20221102125816epcas5p23e16fefd6b820e7dd7d9a93f0d48f40d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221102125816epcas5p23e16fefd6b820e7dd7d9a93f0d48f40d
References: <20221102130602.48969-1-aakarsh.jain@samsung.com>
        <CGME20221102125816epcas5p23e16fefd6b820e7dd7d9a93f0d48f40d@epcas5p2.samsung.com>
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit "752d3a23d1f68de87e3c" which adds MFC codec device node
for exynos3250 SOC. Since exynos3250.dtsi and exynos5420.dtsi are
using same compatible string as "samsung,mfc-v7" but their
node properties are different.As both SoCs have MFC v7 hardware
module but with different clock hierarchy and complexity.
So renaming compatible string from version specific to SOC based.

Suggested-by: Alim Akhtar <alim.akhtar@samsung.com>
Fixes: 752d3a23d1f6 ("ARM: dts: add MFC codec device node for exynos3250")
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

