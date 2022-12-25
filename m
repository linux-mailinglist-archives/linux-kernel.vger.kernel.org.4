Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47932655D27
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Dec 2022 13:07:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbiLYMHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Dec 2022 07:07:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbiLYMGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Dec 2022 07:06:51 -0500
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.216])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 333422DD1;
        Sun, 25 Dec 2022 04:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=lYD3w
        XNUFmWhBTXZjF8aH8HBuUSp1esXXHCXlQj+fyE=; b=IcoUKgmsGm8ucyKR4cN+B
        8QK0lLQE+SwzwGYuZkxT9BVLBdegzV7bh2gwTEoZmfqX15BkA8H0czvOYPEN3EmE
        eqk7xhnN6ak33aP1xYi32BpoY8dnSIPIBiGa1zuZXBLRphahExjSaGCoCU8AY7pE
        jgePJqc/XiiKcgSvY9ePXU=
Received: from ProDesk.. (unknown [58.22.7.114])
        by zwqz-smtp-mta-g4-1 (Coremail) with SMTP id _____wC3jPniOKhjahJ1AA--.53952S2;
        Sun, 25 Dec 2022 19:49:58 +0800 (CST)
From:   Andy Yan <andyshrk@163.com>
To:     heiko@sntech.de, krzysztof.kozlowski+dt@linaro.org,
        piotr.oniszczuk@gmail.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
Cc:     Andy Yan <andyshrk@163.com>
Subject: [PATCH 2/2] arm64: dts: rockchip: Enable wifi module AP6398s for rk3566 box demo
Date:   Sun, 25 Dec 2022 19:49:53 +0800
Message-Id: <20221225114953.3518595-1-andyshrk@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221225114915.3518502-1-andyshrk@163.com>
References: <20221225114915.3518502-1-andyshrk@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wC3jPniOKhjahJ1AA--.53952S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJF15Xw47Jr4rWr1kKF18uFg_yoW8AFWrpa
        sxCrZYgr1kCr4jganxXrn5Xrn5C395ta1vkwnrua4fKr1S9a1kGF1Uurn5AFn8WF48Xa1Y
        9rs8Aa43Wrs2qw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zMKZXNUUUUU=
X-Originating-IP: [58.22.7.114]
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/1tbivBriXmASacxd7AABs9
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_SORBS_WEB,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a AP6398s wifi/bt module on this board.
Fix the sdmmc1 dt node to make wifi work.

Fixes: 2e0537b16b25 ("arm64: dts: rockchip: Add dts for rockchip rk3566 box demo board")

Signed-off-by: Andy Yan <andyshrk@163.com>
---

 .../boot/dts/rockchip/rk3566-box-demo.dts     | 26 ++++++++++++++++---
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3566-box-demo.dts b/arch/arm64/boot/dts/rockchip/rk3566-box-demo.dts
index d956496d5221..6c0c24226b52 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-box-demo.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3566-box-demo.dts
@@ -324,8 +324,12 @@ wifi_enable_h: wifi-enable-h {
 			rockchip,pins = <2 RK_PB1 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
 
+		wifi_host_wake_h: wifi-host-wake-l {
+			rockchip,pins = <2 RK_PB2 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
 		wifi_32k: wifi-32k {
-			rockchip,pins = <0 RK_PB0 2 &pcfg_pull_none>;
+			rockchip,pins = <2 RK_PC6 1 &pcfg_pull_none>;
 		};
 	};
 
@@ -391,16 +395,30 @@ &sdmmc0 {
 };
 
 &sdmmc1 {
+	/* WiFi & BT combo module AMPAK AP6398S */
+	#address-cells = <1>;
+	#size-cells = <0>;
 	bus-width = <4>;
+	clock-frequency = <150000000>;
+	cap-sdio-irq;
 	cap-sd-highspeed;
-	disable-wp;
+	sd-uhs-sdr104;
+	keep-power-in-suspend;
 	mmc-pwrseq = <&sdio_pwrseq>;
 	non-removable;
 	pinctrl-names = "default";
 	pinctrl-0 = <&sdmmc1_bus4 &sdmmc1_cmd &sdmmc1_clk>;
-	vmmc-supply = <&vcc_3v3>;
-	vqmmc-supply = <&vcca_1v8>;
 	status = "okay";
+
+	brcmf: wifi@1 {
+		compatible = "brcm,bcm4329-fmac";
+		reg = <1>;
+		interrupt-parent = <&gpio2>;
+		interrupts = <RK_PB2 GPIO_ACTIVE_HIGH>;
+		interrupt-names = "host-wake";
+		pinctrl-names = "default";
+		pinctrl-0 = <&wifi_host_wake_h>;
+	};
 };
 
 &spdif {
-- 
2.25.1

