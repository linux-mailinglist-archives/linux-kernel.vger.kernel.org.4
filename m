Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1CF65BAD0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 07:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236811AbjACGmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 01:42:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236836AbjACGls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 01:41:48 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BCA3DE91
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 22:41:30 -0800 (PST)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230103064128epoutp02f5418d6e6881921589f07333eff8748b~2uVWVKZy32497624976epoutp02T
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 06:41:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230103064128epoutp02f5418d6e6881921589f07333eff8748b~2uVWVKZy32497624976epoutp02T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1672728088;
        bh=uz2RrYKqw72bCs+O+RwVxl6BiuB0/WR6dbYm96RZj8s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pPtSkjR4aMC0Wmh8FcnaGLHfnhV2WsuU9WUF9zwQlSP7mVWckyO6hDjEJhjSd1kiJ
         eUO4pbn86U9Qd61bc7QV8zWOutfNf4H+/S+OCX64ckeKd8tazIby8hD58QE3Wxa1oS
         JXZyDVwDkGAM3Uccd9ZrYwfknvt1pan2UC5rI1sg=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20230103064128epcas5p3f8539d92293aaac136b704625a9decfb~2uVV0iccF1851818518epcas5p3P;
        Tue,  3 Jan 2023 06:41:28 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.179]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4NmNRp2zG3z4x9Py; Tue,  3 Jan
        2023 06:41:26 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        BC.69.03362.41EC3B36; Tue,  3 Jan 2023 15:41:24 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20230103045659epcas5p322e2f3ad2b43e5a22f43135dc3e46f75~2s6HxhQ571607816078epcas5p3r;
        Tue,  3 Jan 2023 04:56:59 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230103045659epsmtrp1305e27189ab1c9ac781931dffa423431~2s6Hwi3iq0133401334epsmtrp1n;
        Tue,  3 Jan 2023 04:56:59 +0000 (GMT)
X-AuditID: b6c32a4b-287ff70000010d22-8a-63b3ce14d0c7
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        95.94.02211.B95B3B36; Tue,  3 Jan 2023 13:56:59 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230103045656epsmtip2287665068d9df70f118a9654dd493b86~2s6FM6DVi3202032020epsmtip23;
        Tue,  3 Jan 2023 04:56:56 +0000 (GMT)
From:   Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, s.nawrocki@samsung.com,
        perex@perex.cz, tiwai@suse.com, pankaj.dubey@samsung.com,
        alim.akhtar@samsung.com, rcsekar@samsung.com,
        aswani.reddy@samsung.com
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
Subject: [PATCH v2 3/5] arm64: dts: fsd: Add I2S DAI node for Tesla FSD
Date:   Tue,  3 Jan 2023 10:26:11 +0530
Message-Id: <20230103045613.100309-4-p.rajanbabu@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230103045613.100309-1-p.rajanbabu@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHJsWRmVeSWpSXmKPExsWy7bCmpq7Iuc3JBl9ncVk8mLeNzeLKxUNM
        Foc2b2W3mPrwCZvF/CPnWC36Xjxktvh2pYPJ4vKuOWwWM87vY7I4ujHYYtHWL+wWnbv6WS1m
        XdjBatG69wi7xeE37awWG76vZXQQ8NjwuYnNY+esu+wem1Z1snncubaHzWPf22VsHn1bVjF6
        rN9ylcXj8ya5AI6obJuM1MSU1CKF1Lzk/JTMvHRbJe/geOd4UzMDQ11DSwtzJYW8xNxUWyUX
        nwBdt8wcoA+UFMoSc0qBQgGJxcVK+nY2RfmlJakKGfnFJbZKqQUpOQUmBXrFibnFpXnpenmp
        JVaGBgZGpkCFCdkZ02e3MxUckaxY8nE5cwPjC5EuRk4OCQETiaP3t7J3MXJxCAnsZpRYt+Uv
        G4TziVHiftN5VgjnG6PE5gn3GWFa7t75xQKR2Mso8evpDKj+ViaJKc/OM4FUsQmYSqya0wjW
        LiLQxCTR9mYiWAuzwEZGidPHHoJVCQu4S8yacoQVxGYRUJV4d/EYmM0rYCtx70A/O8Q+eYnV
        Gw4wg9icAnYSfzouMIEMkhBYyiHxbs0KqCIXiV3/vzFB2MISr45vgYpLSbzsb4Oy8yWmfWxm
        g7ArJNo+boCqt5c4cGUO0HUcQNdpSqzfpQ8RlpWYemodWAmzAJ9E7+8nUOW8EjvmwdiqEuuX
        b4KGi7TEvut7oWwPiZeLV0EDbyKjRP/r9WwTGOVmIaxYwMi4ilEytaA4Nz212LTAOC+1HB5x
        yfm5mxjBCVXLewfjowcf9A4xMnEwHmKU4GBWEuGd9GJTshBvSmJlVWpRfnxRaU5q8SFGU2AA
        TmSWEk3OB6b0vJJ4QxNLAxMzMzMTS2MzQyVx3tSt85OFBNITS1KzU1MLUotg+pg4OKUamHgd
        Du0snrbGyvtnzZGUhVsPTjRzu5Xz/ET7jjTlbkP1sJdSPbNTa8M7oiMfH7A3nfZoKvuEI++c
        36is+Ph47bKIBGunqmmvDl0NYtt7Q+PW6nW/Pv4SvfzotMjjRk8GXknOMMO1TExpSx2Eohq3
        fPK0eWBhnt45X8WXta1irf3S1ihbgVIJGckZ7+PkGJ7Ptgh5rcTzwK7ikqHypYk5FuzLbf6+
        /FzOced3ddGpz7/qHzK8ZItY/8v82uvLsU+MRbSDWRaslvhs+0vtmfA/7RX1k0uZXh1geH13
        1co1e/4w3vp3Nmhzc/LJRX/eTzk7pfjq/83/e/muXjk3yb1k/frjT6uOdclkHn6wMvTkhoDr
        SizFGYmGWsxFxYkAsrjaTDEEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMLMWRmVeSWpSXmKPExsWy7bCSvO7srZuTDTauULV4MG8bm8WVi4eY
        LA5t3spuMfXhEzaL+UfOsVr0vXjIbPHtSgeTxeVdc9gsZpzfx2RxdGOwxaKtX9gtOnf1s1rM
        urCD1aJ17xF2i8Nv2lktNnxfy+gg4LHhcxObx85Zd9k9Nq3qZPO4c20Pm8e+t8vYPPq2rGL0
        WL/lKovH501yARxRXDYpqTmZZalF+nYJXBnTZ7czFRyRrFjycTlzA+MLkS5GTg4JAROJu3d+
        sXQxcnEICexmlNi55T0LREJaYnr/HjYIW1hi5b/n7BBFzUwSU6c/YgdJsAmYSqya08gKkhAR
        mMAkcfLdMbBuZoGtjBJTPxuB2MIC7hKzphxhBbFZBFQl3l08BmbzCthK3DvQzw6xQV5i9YYD
        zCA2p4CdxJ+OC0wgthBQzfaGT8wTGPkWMDKsYpRMLSjOTc8tNiwwzEst1ytOzC0uzUvXS87P
        3cQIDnctzR2M21d90DvEyMTBeIhRgoNZSYR30otNyUK8KYmVValF+fFFpTmpxYcYpTlYlMR5
        L3SdjBcSSE8sSc1OTS1ILYLJMnFwSjUwHRHnvL3mpor8ZPGtN3iUX1963fuHjfXwpDq3uyVp
        CxbN+ib44MSbbVMa9rbp/+Y42np+gZhChLie2cT/tU+ixDknHVvfEXdoB/O+WVp2Fbx7FBTj
        nx37tFQ0TZMpytXj4d9rrHyy06qPJYj2rQ39yS4grXUxekb5U517Mey3V2QebdvJrfNLa8cy
        s4w7i6sXxV/p+6y3aeOKZBHrs/EcgisTv0a9nMFzq3z1rL2dbP7VS+c0TxXUvBPbVLXg6e6u
        ds7Z5579XO4xq0RWekmr1Ny+C1JVp37+fOH9wNFgi8qP47/v3P5w+eexdSel7bm0XDqrj2rL
        O8s/vC0wdWvKU8Od+Txll//tEzI/LizDya/EUpyRaKjFXFScCABx9RwH5gIAAA==
X-CMS-MailID: 20230103045659epcas5p322e2f3ad2b43e5a22f43135dc3e46f75
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230103045659epcas5p322e2f3ad2b43e5a22f43135dc3e46f75
References: <20230103045613.100309-1-p.rajanbabu@samsung.com>
        <CGME20230103045659epcas5p322e2f3ad2b43e5a22f43135dc3e46f75@epcas5p3.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree node for I2S0 and I2S1 CPU DAI instances for Tesla
FSD platform.

FSD SoC has 2 I2S instances driving stereo channel audio playback
and capture with external DMA support.

Signed-off-by: Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
---
 arch/arm64/boot/dts/tesla/fsd-evb.dts      |  8 +++++
 arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi | 14 +++++++++
 arch/arm64/boot/dts/tesla/fsd.dtsi         | 34 ++++++++++++++++++++++
 3 files changed, 56 insertions(+)

diff --git a/arch/arm64/boot/dts/tesla/fsd-evb.dts b/arch/arm64/boot/dts/tesla/fsd-evb.dts
index 1db6ddf03f01..cf5f2ce4d2a7 100644
--- a/arch/arm64/boot/dts/tesla/fsd-evb.dts
+++ b/arch/arm64/boot/dts/tesla/fsd-evb.dts
@@ -38,6 +38,14 @@
 	status = "okay";
 };
 
+&i2s_0 {
+	status = "okay";
+};
+
+&i2s_1 {
+	status = "okay";
+};
+
 &ufs {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi b/arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi
index e3852c946352..6b51e31afcff 100644
--- a/arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi
+++ b/arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi
@@ -339,6 +339,20 @@
 		samsung,pin-pud = <FSD_PIN_PULL_UP>;
 		samsung,pin-drv = <FSD_PIN_DRV_LV4>;
 	};
+
+	i2s0_bus: i2s0-bus-pins {
+		samsung,pins = "gpd1-0", "gpd1-1", "gpd1-2", "gpd1-3", "gpd1-4";
+		samsung,pin-function = <FSD_PIN_FUNC_2>;
+		samsung,pin-pud = <FSD_PIN_PULL_DOWN>;
+		samsung,pin-drv = <FSD_PIN_DRV_LV4>;
+	};
+
+	i2s1_bus: i2s1-bus-pins {
+		samsung,pins = "gpd2-0", "gpd2-1", "gpd2-2", "gpd2-3", "gpd2-4";
+		samsung,pin-function = <FSD_PIN_FUNC_2>;
+		samsung,pin-pud = <FSD_PIN_PULL_DOWN>;
+		samsung,pin-drv = <FSD_PIN_DRV_LV4>;
+	};
 };
 
 &pinctrl_pmu {
diff --git a/arch/arm64/boot/dts/tesla/fsd.dtsi b/arch/arm64/boot/dts/tesla/fsd.dtsi
index f35bc5a288c2..3e7265a41e37 100644
--- a/arch/arm64/boot/dts/tesla/fsd.dtsi
+++ b/arch/arm64/boot/dts/tesla/fsd.dtsi
@@ -738,6 +738,40 @@
 			status = "disabled";
 		};
 
+		i2s_0: i2s@140e0000 {
+			compatible = "tesla,fsd-i2s";
+			reg = <0x0 0x140e0000 0x0 0x100>;
+			interrupts = <GIC_SPI 206 IRQ_TYPE_LEVEL_HIGH>;
+			dmas = <&pdma1 14>, <&pdma1 13>, <&pdma1 12>;
+			dma-names = "tx", "rx", "tx-sec";
+			#clock-cells = <1>;
+			clocks = <&clock_peric PERIC_PCLK_TDM0>,
+				 <&clock_peric PERIC_HCLK_TDM0>,
+				 <&clock_peric PERIC_HCLK_TDM0>;
+			clock-names = "iis", "i2s_opclk0", "i2s_opclk1";
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2s0_bus>;
+			#sound-dai-cells = <1>;
+			status = "disabled";
+		};
+
+		i2s_1: i2s@140f0000 {
+			compatible = "tesla,fsd-i2s";
+			reg = <0x0 0x140f0000 0x0 0x100>;
+			interrupts = <GIC_SPI 207 IRQ_TYPE_LEVEL_HIGH>;
+			dmas = <&pdma1 17>, <&pdma1 16>, <&pdma1 15>;
+			dma-names = "tx", "rx", "tx-sec";
+			#clock-cells = <1>;
+			clocks = <&clock_peric PERIC_PCLK_TDM1>,
+				 <&clock_peric PERIC_HCLK_TDM1>,
+				 <&clock_peric PERIC_HCLK_TDM1>;
+			clock-names = "iis", "i2s_opclk0", "i2s_opclk1";
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2s1_bus>;
+			#sound-dai-cells = <1>;
+			status = "disabled";
+		};
+
 		pinctrl_pmu: pinctrl@114f0000 {
 			compatible = "tesla,fsd-pinctrl";
 			reg = <0x0 0x114f0000 0x0 0x1000>;
-- 
2.17.1

