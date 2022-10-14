Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFA0F5FECFB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 13:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbiJNLLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 07:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbiJNLKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 07:10:37 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA01BE6F53
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 04:10:32 -0700 (PDT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20221014111031epoutp02d13f91a29b45f99505f0d3a440b7de34~d6wIOCt9Y1905819058epoutp02S
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 11:10:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20221014111031epoutp02d13f91a29b45f99505f0d3a440b7de34~d6wIOCt9Y1905819058epoutp02S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1665745831;
        bh=Zbx76mlzHBJ+S/AAz4sVRGbKx8JIYIBvPvxtvlSsvBk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CqWW08GRSZ+HMULqxhlPtB0aZheCBxHNsceS021v/pi6wIdAWSv0fzn+UH0ylYXeY
         eTNfz68Xz/bjKT1zYonKMLmc1aNkoAU/FcjY1fmKnpKb3tH55GaG6T7X/S1HkXY4lV
         b9TN9848kNy/6Nsz+N2Jrdlg3+JhSMjUd0di/3ss=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20221014111030epcas5p13c3443954d01d1f884580c2a7b9071ff~d6wHXc6LT1571915719epcas5p1T;
        Fri, 14 Oct 2022 11:10:30 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.182]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4MpkFb02Npz4x9Pq; Fri, 14 Oct
        2022 11:10:27 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        98.4E.56352.2A349436; Fri, 14 Oct 2022 20:10:26 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20221014104911epcas5p394100ff6ed53be32c4d64c7e23e48833~d6dglrHlO0568205682epcas5p30;
        Fri, 14 Oct 2022 10:49:11 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20221014104911epsmtrp2b379d1c4e5d136384898960bb0364c24~d6dgkyXTs0248602486epsmtrp2I;
        Fri, 14 Oct 2022 10:49:11 +0000 (GMT)
X-AuditID: b6c32a4b-383ff7000001dc20-53-634943a26bdf
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        FD.2C.18644.7AE39436; Fri, 14 Oct 2022 19:49:11 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20221014104909epsmtip13267170eacab96b4dd5fca0afa5e559d~d6deZpfIO0142901429epsmtip1X;
        Fri, 14 Oct 2022 10:49:09 +0000 (GMT)
From:   Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, s.nawrocki@samsung.com,
        perex@perex.cz, tiwai@suse.com, pankaj.dubey@samsung.com,
        alim.akhtar@samsung.com, rcsekar@samsung.com,
        aswani.reddy@samsung.com
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
Subject: [PATCH 5/6] arm64: dts: fsd: Add I2S DAI node for Tesla FSD
Date:   Fri, 14 Oct 2022 15:51:50 +0530
Message-Id: <20221014102151.108539-6-p.rajanbabu@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221014102151.108539-1-p.rajanbabu@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSfUwbdRjH87u214Ok5Cx7+VmVdaebrgvQjhaPQZkLZDmGGCbJ4jZjd7YX
        wJZr7RXH/MMB8j5lEOncat10akc65aUDxCK4tAgEFYqFCep0RTKlViIyR3wbtrTof5/n+X2/
        eV5+D8YTv4FKsFLWwphZ2kCg8fw+766Hky/l5Gnl7V8oyZsX+lByesqDkJ6rvULSGlhAyYvD
        EwKy+acAj7wz3YCQfrcdJc9NDiHkp91F5KXe20Ky0X1GQNp8/QKydnBYSHpD9QKya/UD8BhO
        da1Uo9RHthtCyuVsRKlvr3+MUkO/OFCquccJqM6eGT614koqxI7qs0oYWseYpQyrNepK2WI1
        kV+kydGo0uWKZEUG+SghZekyRk3kPl6YfKDUEJ6AkL5AG8rDqUKa44jU7CyzsdzCSEuMnEVN
        MCadwaQ0pXB0GVfOFqewjGWvQi7fowoLj+tLFt2v8U1VkorLn1jRSlC3uQnEYRBXwqDPAZpA
        PCbGBwAMXHGh0eA3ABtWBwTRYAXA2RuVgg1L3dL5mMoNYLf/6vqDGK9FYP0r5gijuAo67VXr
        7k14NQLrQq38SMDDuwH8bCSANAEMS8RzYceAOmLg4zug9+waiLAIV8PaFiuIVtsGr3Rd40U4
        Ds+GP9ZUx7p4G4PBNUWUc+Fd2100yokwONojjLIEriwNxvJGeHb55RhXwLrlLiTK++C1aTs/
        0g4P3wU73anR9APQOt6xLuHhCfDVvxZichHsv7DBO2DnZVeszfvg0FeDMabgm30OYXRBrQDO
        jX0vaAFJtv9LvAWAE9zLmLiyYoZTmdJY5sR/v6Y1lrnA+pXK8vvB/M1fUzwAwYAHQIxHbBL9
        TORpxSIdffJFxmzUmMsNDOcBqvD+WnmSzVpj+MxZi0ahzJAr09PTlRlp6Qpiq+idczKtGC+m
        LYyeYUyMecOHYHGSSgTk2bPkD1WpyWX/U/3L+afYlhrb7q2OZt/+AWvneFoByBK0HZFdzBzp
        nU/4s/pp62LOYotGMZKxRZx95JlQUmbymHGur83nz45T8kYFswXe/V9LmPuZP17attZ40Lhn
        5szhmsQFdah96lBB2unU69gTFd3k7OTO0KFC/fyHx9cSmjsm4pW3l1qknGj3TIP2G2bf67nZ
        efGB4A9tvr05q9+9j/+ecFj7nmS7vbFXs2XqzghYoYap7fm3/LXn/zE977hn55yhBqV74k8f
        O3XwEecxW+aDJyY7h299fpLDn/NO4PXv+sZ6iaPtWs/ck+NFSl2hbA1+OTEkG/s7oH/WMhok
        +FwJrZDxzBz9L2ctMB8uBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrILMWRmVeSWpSXmKPExsWy7bCSnO5yO89kg1nNqhYP5m1js7hy8RCT
        xaHNW9ktpj58wmYx/8g5Vou+Fw+ZLb5d6WCyuLxrDpvFjPP7mCyObgy2WLT1C7tF565+VotZ
        F3awWrTuPcJucfhNO6vFhu9rGR0EPDZ8bmLz2DnrLrvHplWdbB53ru1h89j3dhmbR9+WVYwe
        67dcZfH4vEkugCOKyyYlNSezLLVI3y6BK+PlrsksBY1SFcv3T2VrYGwT7WLk5JAQMJFoezeT
        DcQWEtjBKHHmsS1EXFpiev8eNghbWGLlv+fsXYxcQDXNTBIzLyxjBEmwCZhKrJrTyAqSEBGY
        wCRx8t0xFpAEs8BWRompn426GDk4hAVcJNbtBhvKIqAqcXjaf7BeXgFbidYJUxkhFshLrN5w
        gBnE5hSwk3je0sQKcZCtxPPz7xgnMPItYGRYxSiZWlCcm55bbFhglJdarlecmFtcmpeul5yf
        u4kRHOpaWjsY96z6oHeIkYmD8RCjBAezkgjvayXPZCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8
        F7pOxgsJpCeWpGanphakFsFkmTg4pRqYzDY0v9HXWrtapvfgLcY7Gu3LubtLop3+Gt9/4XGs
        aeKfk268j7QW2zI++dhX3X/N17iVsYBJ3Kj99F7XhTKr7yvu7uU44r+oP+hiZs6B/TP3nZHb
        xmjacmlSm/2P6t2Fq7Yx1zI9DXN7fWp36oOaKzHtcplX+Z9xz5xdHTkvWFT1pRjzQya22gOr
        NF85fptjZiiYlJCb/2WRd8tmxedCJVLWrhJxpxbHlSkLWfax7l7WvvGvXbj//0PmoqxOs9eX
        ++W1TNsb8DOpyCp8wwXRyQs+cK21Wy+2a0vTYR1F/kPhxdrrS+qd3vDPv1ShV1amkLfpztmf
        uQyPGuY93cRTI+2pJ/7j5oIv9mv/B/oqsRRnJBpqMRcVJwIAi4U8quQCAAA=
X-CMS-MailID: 20221014104911epcas5p394100ff6ed53be32c4d64c7e23e48833
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221014104911epcas5p394100ff6ed53be32c4d64c7e23e48833
References: <20221014102151.108539-1-p.rajanbabu@samsung.com>
        <CGME20221014104911epcas5p394100ff6ed53be32c4d64c7e23e48833@epcas5p3.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree node for I2S0 and I2S1 CPU DAI instances for Tesla
FSD board

Signed-off-by: Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
---
 arch/arm64/boot/dts/tesla/fsd-evb.dts      |  8 +++++
 arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi | 14 ++++++++
 arch/arm64/boot/dts/tesla/fsd.dtsi         | 38 ++++++++++++++++++++++
 3 files changed, 60 insertions(+)

diff --git a/arch/arm64/boot/dts/tesla/fsd-evb.dts b/arch/arm64/boot/dts/tesla/fsd-evb.dts
index 1db6ddf03f01..c0a4509499ab 100644
--- a/arch/arm64/boot/dts/tesla/fsd-evb.dts
+++ b/arch/arm64/boot/dts/tesla/fsd-evb.dts
@@ -41,3 +41,11 @@
 &ufs {
 	status = "okay";
 };
+
+&tdm_0 {
+	status = "okay";
+};
+
+&tdm_1 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi b/arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi
index e3852c946352..ff6f5d4b16dd 100644
--- a/arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi
+++ b/arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi
@@ -339,6 +339,20 @@
 		samsung,pin-pud = <FSD_PIN_PULL_UP>;
 		samsung,pin-drv = <FSD_PIN_DRV_LV4>;
 	};
+
+	i2s0_bus: i2s0-bus {
+		samsung,pins = "gpd1-0", "gpd1-1", "gpd1-2", "gpd1-3", "gpd1-4";
+		samsung,pin-function = <FSD_PIN_FUNC_2>;
+		samsung,pin-pud = <FSD_PIN_PULL_DOWN>;
+		samsung,pin-drv = <FSD_PIN_DRV_LV4>;
+	};
+
+	i2s1_bus: i2s1-bus {
+		samsung,pins = "gpd2-0", "gpd2-1", "gpd2-2", "gpd2-3", "gpd2-4";
+		samsung,pin-function = <FSD_PIN_FUNC_2>;
+		samsung,pin-pud = <FSD_PIN_PULL_DOWN>;
+		samsung,pin-drv = <FSD_PIN_DRV_LV4>;
+	};
 };
 
 &pinctrl_pmu {
diff --git a/arch/arm64/boot/dts/tesla/fsd.dtsi b/arch/arm64/boot/dts/tesla/fsd.dtsi
index f35bc5a288c2..5decad45a1b6 100644
--- a/arch/arm64/boot/dts/tesla/fsd.dtsi
+++ b/arch/arm64/boot/dts/tesla/fsd.dtsi
@@ -32,6 +32,8 @@
 		spi0 = &spi_0;
 		spi1 = &spi_1;
 		spi2 = &spi_2;
+		tdm0 = &tdm_0;
+		tdm1 = &tdm_1;
 	};
 
 	cpus {
@@ -809,6 +811,42 @@
 			status = "disabled";
 		};
 
+		tdm_0: tdm@140e0000 {
+			compatible = "samsung,exynos7-i2s";
+			reg = <0x0 0x140E0000 0x0 0x100>;
+			interrupts = <GIC_SPI 206 IRQ_TYPE_LEVEL_HIGH>;
+			dmas = <&pdma1 14>, <&pdma1 13>, <&pdma1 12>;
+			dma-names = "tx", "rx", "tx-sec";
+			#clock-cells = <1>;
+			#sound-dai-cells = <1>;
+			clocks = <&clock_peric PERIC_HCLK_TDM0>,
+				 <&clock_peric PERIC_HCLK_TDM0>,
+				 <&clock_peric PERIC_PCLK_TDM0>;
+			clock-names = "i2s_opclk0", "i2s_opclk1", "iis";
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2s0_bus>;
+			samsung,sec-dai-id = <0>;
+			status = "disabled";
+		};
+
+		tdm_1: tdm@140f0000 {
+			compatible = "samsung,exynos7-i2s";
+			reg = <0x0 0x140F0000 0x0 0x100>;
+			interrupts = <GIC_SPI 207 IRQ_TYPE_LEVEL_HIGH>;
+			dmas = <&pdma1 17>, <&pdma1 16>, <&pdma1 15>;
+			dma-names = "tx", "rx", "tx-sec";
+			#clock-cells = <1>;
+			#sound-dai-cells = <1>;
+			clocks = <&clock_peric PERIC_HCLK_TDM1>,
+				 <&clock_peric PERIC_HCLK_TDM1>,
+				 <&clock_peric PERIC_PCLK_TDM1>;
+			clock-names = "i2s_opclk0", "i2s_opclk1", "iis";
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2s1_bus>;
+			samsung,sec-dai-id = <1>;
+			status = "disabled";
+		};
+
 		timer@10040000 {
 			compatible = "tesla,fsd-mct", "samsung,exynos4210-mct";
 			reg = <0x0 0x10040000 0x0 0x800>;
-- 
2.17.1

