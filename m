Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6EA5F9EF2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 14:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbiJJMzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 08:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231381AbiJJMzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 08:55:03 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83FAA12D26
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 05:54:45 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20221010125436epoutp02c73236468e8992e85ed6bbc758892a90~ctl3QnoNu1019510195epoutp02q
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 12:54:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20221010125436epoutp02c73236468e8992e85ed6bbc758892a90~ctl3QnoNu1019510195epoutp02q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1665406476;
        bh=uhZUqSHM1OkD2STn6iiHOS3OrMAeke5u19oEvKdXy7A=;
        h=From:To:Cc:Subject:Date:References:From;
        b=di2vtfSAtJIheXgHifaVlV0jVTo+8/5/AYqOd4F9vmPF13RbUw7WLNI8GQvNILfVM
         iPqPUzhvun1s7iPWGvpET8VYXmrBTWCQXM0cSaDd5YD6o0I1VqiWClgQN45J/76YR2
         fTfmWhtpk8G0hQkQq/sW2+QOWulpVPG/ChpOh6lw=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20221010125434epcas5p3c17bca9f9f70cc8a05bc487c8f41e42c~ctl2C-dL_0513405134epcas5p3Y;
        Mon, 10 Oct 2022 12:54:34 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.179]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4MmJlW082pz4x9Pq; Mon, 10 Oct
        2022 12:54:31 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D4.67.26992.60614436; Mon, 10 Oct 2022 21:54:30 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20221010123120epcas5p3ba947a3a982bc6a78310472c2a65ebfe~ctRjnLaGX1905819058epcas5p3t;
        Mon, 10 Oct 2022 12:31:20 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20221010123120epsmtrp111ed3f91492b7f843e5178a4c2702a0c~ctRjmTHB30109301093epsmtrp1L;
        Mon, 10 Oct 2022 12:31:20 +0000 (GMT)
X-AuditID: b6c32a49-0c7ff70000016970-b3-634416060b51
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        90.AF.18644.89014436; Mon, 10 Oct 2022 21:31:20 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20221010123118epsmtip16f4638aee7e30ed55157c944a9120248~ctRh3qoMg1939519395epsmtip1h;
        Mon, 10 Oct 2022 12:31:18 +0000 (GMT)
From:   Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        alim.akhtar@samsung.com, chanho61.park@samsung.com,
        linus.walleij@linaro.org, pankaj.dubey@samsung.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
Subject: [PATCH] arm64: dts: fix drive strength macros as per FSD HW UM
Date:   Mon, 10 Oct 2022 17:34:37 +0530
Message-Id: <20221010120438.80680-1-p.rajanbabu@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFKsWRmVeSWpSXmKPExsWy7bCmpi6bmEuywfHr5hYP5m1js7i8X9ti
        /pFzrBZ9Lx4yW0z5s5zJ4vKuOWwWM87vY7I4ujHYYtHWL+wWrXuPsDtweWxa1cnmcefaHjaP
        vi2rGD0+b5ILYInKtslITUxJLVJIzUvOT8nMS7dV8g6Od443NTMw1DW0tDBXUshLzE21VXLx
        CdB1y8wBOkdJoSwxpxQoFJBYXKykb2dTlF9akqqQkV9cYquUWpCSU2BSoFecmFtcmpeul5da
        YmVoYGBkClSYkJ3RMFG3oEunYseF1SwNjDNVuhg5OSQETCRO71/DCGILCexmlFj3Q7CLkQvI
        /sQocWnyVUYI5zOjxKL551lgOm4d6maFSOxilNh89g5UVSuTxJLO62wgVWwCphKr5jSCVYkI
        LGWU+P9pEVgVs8AURomt226AbRQWcJfYeukXK4jNIqAq8efxCeYuRg4OXgEbiW1bRCHWyUus
        3nCAGaRXQmAXu0Tn5C6oO1wkHm7sYYOwhSVeHd/CDmFLSbzsb4Oy8yWmfWyGqqmQaPu4gQnC
        tpc4cGUOC8guZgFNifW79CHCshJTT60DK2EW4JPo/f0EqpxXYsc8GFtVYv3yTYwQtrTEvut7
        GUHGSAh4SNy6zwMJx1iJr+9vMk1glJ2FsGABI+MqRsnUguLc9NRi0wLDvNRyeDwl5+duYgQn
        Mi3PHYx3H3zQO8TIxMF4iFGCg1lJhJdxvlOyEG9KYmVValF+fFFpTmrxIUZTYIhNZJYSTc4H
        ptK8knhDE0sDEzMzMxNLYzNDJXHexTO0koUE0hNLUrNTUwtSi2D6mDg4pRqYlktbX6opKjXt
        yhOe9m7/ru37L/0Uu8bwPcOx8pi6w6GLJ+0V71nyXNBZ37n0uMWbWe1na0pMxaaI/Kh2z65l
        LnBwrGXuuy2TllWzaNER2eiIzR/r0xgd/V1Eu59I/mktTvkdktmasqDWO+aRkfG7hU0ffr6T
        qt3tbl3aonjw8pZtPq8X6WZaxvgtTKwrnJc65QKzqcnup5c+pWcGf9LtV1eVSij+89rmyPoT
        vB22xq51rw4cWjNHd1JPmpR24Lyq07qbLMSyvC2On14sr2Htq5RdZtTTkSxoHb7vyt+ESzMf
        66WeLVpd13nf1JXne9RWz+sxXuZsPj/vCL/bbZsdZfJjZp3537tXXIxm1ymxFGckGmoxFxUn
        AgDfVDt57QMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjluLIzCtJLcpLzFFi42LZdlhJTneGgEuywYL5WhYP5m1js7i8X9ti
        /pFzrBZ9Lx4yW0z5s5zJ4vKuOWwWM87vY7I4ujHYYtHWL+wWrXuPsDtweWxa1cnmcefaHjaP
        vi2rGD0+b5ILYInisklJzcksSy3St0vgymiYqFvQpVOx48JqlgbGmSpdjJwcEgImErcOdbN2
        MXJxCAnsYJTobOtjhUhIS0zv38MGYQtLrPz3nB2iqJlJYt3VB0wgCTYBU4lVcxrBukUEVjNK
        fO5vB+tgFpjGKLFraj2ILSzgLrH10i+wqSwCqhJ/Hp9g7mLk4OAVsJHYtkUUYoG8xOoNB5gn
        MPIsYGRYxSiZWlCcm55bbFhglJdarlecmFtcmpeul5yfu4kRHFRaWjsY96z6oHeIkYmD8RCj
        BAezkggv43ynZCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8F7pOxgsJpCeWpGanphakFsFkmTg4
        pRqYJvhmXTGeuN8u0/DzYf6c5SdKgl5Ml/UPs9r7csqT4h2TCtPFFlef/TT1x+UCqW9nvlrs
        OXH03YMDqhMlebMmaJ1uZBOK/P9i8vrWZmujml+v9279c3n2/J/yWjuqVFkOl32y/razrZ7r
        Y9Dfm5NeLg90+nAh4sAb9RdhM9cFauzf5W3368XxUg6Grdd/s2uFTTo8sVnFVqNusuW22MSt
        zVLSbMxvvNafcpfTf1/jMV+ijqXjqH7CW5Xr1Qb/tt5Y7LzQ81yP0v38dItdq63N1KfHb+mI
        tvOpuLTHhaEr56ZLVqOXXYjIFguXU7FMM5irpkWs1poq81XEIDhQ9LXpCnaWhEnTNG9cu5Kh
        kl65TomlOCPRUIu5qDgRAHaQ/b6ZAgAA
X-CMS-MailID: 20221010123120epcas5p3ba947a3a982bc6a78310472c2a65ebfe
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221010123120epcas5p3ba947a3a982bc6a78310472c2a65ebfe
References: <CGME20221010123120epcas5p3ba947a3a982bc6a78310472c2a65ebfe@epcas5p3.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In FSD pinctrl implementation, the pinctrl driver is using drive strength
MACROs, which are deviating from the actual values specified in FSD HW UM

This patch adds the right pinctrl drive strength values for FSD SoC. This
patch also ensures that the peripherals are using right drive strength
MACROs in-order to function as expected

Signed-off-by: Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
---
 arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi | 34 +++++++++++-----------
 arch/arm64/boot/dts/tesla/fsd-pinctrl.h    |  6 ++--
 2 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi b/arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi
index d0abb9aa0e9e..e3852c946352 100644
--- a/arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi
+++ b/arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi
@@ -55,14 +55,14 @@
 		samsung,pins = "gpf5-0";
 		samsung,pin-function = <FSD_PIN_FUNC_2>;
 		samsung,pin-pud = <FSD_PIN_PULL_NONE>;
-		samsung,pin-drv = <FSD_PIN_DRV_LV2>;
+		samsung,pin-drv = <FSD_PIN_DRV_LV4>;
 	};
 
 	ufs_refclk_out: ufs-refclk-out-pins {
 		samsung,pins = "gpf5-1";
 		samsung,pin-function = <FSD_PIN_FUNC_2>;
 		samsung,pin-pud = <FSD_PIN_PULL_NONE>;
-		samsung,pin-drv = <FSD_PIN_DRV_LV2>;
+		samsung,pin-drv = <FSD_PIN_DRV_LV4>;
 	};
 };
 
@@ -239,105 +239,105 @@
 		samsung,pins = "gpb6-1";
 		samsung,pin-function = <FSD_PIN_FUNC_2>;
 		samsung,pin-pud = <FSD_PIN_PULL_UP>;
-		samsung,pin-drv = <FSD_PIN_DRV_LV2>;
+		samsung,pin-drv = <FSD_PIN_DRV_LV4>;
 	};
 
 	pwm1_out: pwm1-out-pins {
 		samsung,pins = "gpb6-5";
 		samsung,pin-function = <FSD_PIN_FUNC_2>;
 		samsung,pin-pud = <FSD_PIN_PULL_UP>;
-		samsung,pin-drv = <FSD_PIN_DRV_LV2>;
+		samsung,pin-drv = <FSD_PIN_DRV_LV4>;
 	};
 
 	hs_i2c0_bus: hs-i2c0-bus-pins {
 		samsung,pins = "gpb0-0", "gpb0-1";
 		samsung,pin-function = <FSD_PIN_FUNC_2>;
 		samsung,pin-pud = <FSD_PIN_PULL_UP>;
-		samsung,pin-drv = <FSD_PIN_DRV_LV1>;
+		samsung,pin-drv = <FSD_PIN_DRV_LV4>;
 	};
 
 	hs_i2c1_bus: hs-i2c1-bus-pins {
 		samsung,pins = "gpb0-2", "gpb0-3";
 		samsung,pin-function = <FSD_PIN_FUNC_2>;
 		samsung,pin-pud = <FSD_PIN_PULL_UP>;
-		samsung,pin-drv = <FSD_PIN_DRV_LV1>;
+		samsung,pin-drv = <FSD_PIN_DRV_LV4>;
 	};
 
 	hs_i2c2_bus: hs-i2c2-bus-pins {
 		samsung,pins = "gpb0-4", "gpb0-5";
 		samsung,pin-function = <FSD_PIN_FUNC_2>;
 		samsung,pin-pud = <FSD_PIN_PULL_UP>;
-		samsung,pin-drv = <FSD_PIN_DRV_LV1>;
+		samsung,pin-drv = <FSD_PIN_DRV_LV4>;
 	};
 
 	hs_i2c3_bus: hs-i2c3-bus-pins {
 		samsung,pins = "gpb0-6", "gpb0-7";
 		samsung,pin-function = <FSD_PIN_FUNC_2>;
 		samsung,pin-pud = <FSD_PIN_PULL_UP>;
-		samsung,pin-drv = <FSD_PIN_DRV_LV1>;
+		samsung,pin-drv = <FSD_PIN_DRV_LV4>;
 	};
 
 	hs_i2c4_bus: hs-i2c4-bus-pins {
 		samsung,pins = "gpb1-0", "gpb1-1";
 		samsung,pin-function = <FSD_PIN_FUNC_2>;
 		samsung,pin-pud = <FSD_PIN_PULL_UP>;
-		samsung,pin-drv = <FSD_PIN_DRV_LV1>;
+		samsung,pin-drv = <FSD_PIN_DRV_LV4>;
 	};
 
 	hs_i2c5_bus: hs-i2c5-bus-pins {
 		samsung,pins = "gpb1-2", "gpb1-3";
 		samsung,pin-function = <FSD_PIN_FUNC_2>;
 		samsung,pin-pud = <FSD_PIN_PULL_UP>;
-		samsung,pin-drv = <FSD_PIN_DRV_LV1>;
+		samsung,pin-drv = <FSD_PIN_DRV_LV4>;
 	};
 
 	hs_i2c6_bus: hs-i2c6-bus-pins {
 		samsung,pins = "gpb1-4", "gpb1-5";
 		samsung,pin-function = <FSD_PIN_FUNC_2>;
 		samsung,pin-pud = <FSD_PIN_PULL_UP>;
-		samsung,pin-drv = <FSD_PIN_DRV_LV1>;
+		samsung,pin-drv = <FSD_PIN_DRV_LV4>;
 	};
 
 	hs_i2c7_bus: hs-i2c7-bus-pins {
 		samsung,pins = "gpb1-6", "gpb1-7";
 		samsung,pin-function = <FSD_PIN_FUNC_2>;
 		samsung,pin-pud = <FSD_PIN_PULL_UP>;
-		samsung,pin-drv = <FSD_PIN_DRV_LV1>;
+		samsung,pin-drv = <FSD_PIN_DRV_LV4>;
 	};
 
 	uart0_data: uart0-data-pins {
 		samsung,pins = "gpb7-0", "gpb7-1";
 		samsung,pin-function = <FSD_PIN_FUNC_2>;
 		samsung,pin-pud = <FSD_PIN_PULL_NONE>;
-		samsung,pin-drv = <FSD_PIN_DRV_LV1>;
+		samsung,pin-drv = <FSD_PIN_DRV_LV4>;
 	};
 
 	uart1_data: uart1-data-pins {
 		samsung,pins = "gpb7-4", "gpb7-5";
 		samsung,pin-function = <FSD_PIN_FUNC_2>;
 		samsung,pin-pud = <FSD_PIN_PULL_NONE>;
-		samsung,pin-drv = <FSD_PIN_DRV_LV1>;
+		samsung,pin-drv = <FSD_PIN_DRV_LV4>;
 	};
 
 	spi0_bus: spi0-bus-pins {
 		samsung,pins = "gpb4-0", "gpb4-2", "gpb4-3";
 		samsung,pin-function = <FSD_PIN_FUNC_2>;
 		samsung,pin-pud = <FSD_PIN_PULL_UP>;
-		samsung,pin-drv = <FSD_PIN_DRV_LV1>;
+		samsung,pin-drv = <FSD_PIN_DRV_LV4>;
 	};
 
 	spi1_bus: spi1-bus-pins {
 		samsung,pins = "gpb4-4", "gpb4-6", "gpb4-7";
 		samsung,pin-function = <FSD_PIN_FUNC_2>;
 		samsung,pin-pud = <FSD_PIN_PULL_UP>;
-		samsung,pin-drv = <FSD_PIN_DRV_LV1>;
+		samsung,pin-drv = <FSD_PIN_DRV_LV4>;
 	};
 
 	spi2_bus: spi2-bus-pins {
 		samsung,pins = "gpb5-0", "gpb5-2", "gpb5-3";
 		samsung,pin-function = <FSD_PIN_FUNC_2>;
 		samsung,pin-pud = <FSD_PIN_PULL_UP>;
-		samsung,pin-drv = <FSD_PIN_DRV_LV1>;
+		samsung,pin-drv = <FSD_PIN_DRV_LV4>;
 	};
 };
 
diff --git a/arch/arm64/boot/dts/tesla/fsd-pinctrl.h b/arch/arm64/boot/dts/tesla/fsd-pinctrl.h
index 6ffbda362493..c397d02208a0 100644
--- a/arch/arm64/boot/dts/tesla/fsd-pinctrl.h
+++ b/arch/arm64/boot/dts/tesla/fsd-pinctrl.h
@@ -16,9 +16,9 @@
 #define FSD_PIN_PULL_UP			3
 
 #define FSD_PIN_DRV_LV1			0
-#define FSD_PIN_DRV_LV2			2
-#define FSD_PIN_DRV_LV3			1
-#define FSD_PIN_DRV_LV4			3
+#define FSD_PIN_DRV_LV2			1
+#define FSD_PIN_DRV_LV4			2
+#define FSD_PIN_DRV_LV6			3
 
 #define FSD_PIN_FUNC_INPUT		0
 #define FSD_PIN_FUNC_OUTPUT		1
-- 
2.17.1

