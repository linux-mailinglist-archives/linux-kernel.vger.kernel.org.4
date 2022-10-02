Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDEE55F2255
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 11:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbiJBJ2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 05:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiJBJ2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 05:28:38 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 741B53D5B5;
        Sun,  2 Oct 2022 02:28:34 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 5CE2E32008FB;
        Sun,  2 Oct 2022 05:28:31 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sun, 02 Oct 2022 05:28:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        tom-fitzhenry.me.uk; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1664702910; x=1664789310; bh=o4YZVV66nFlu/Ivg+JUF8MHi6wK7LZJ8ljN
        xD8TAngo=; b=Om3/r7JinO6Vdm0SovcvEVyrIeO7eOyiYs5icSZX2fbe2bJLD5F
        HRMkOyHvvcDMDeoh6N1yjISEejau0w6+HSI5aTUf6XZTk7snAWytpfhbAlvnP8Ti
        zvoYk1bRNfcS4kXT+0stj5MQbPO77Mh+itoDRWguyRb2m4w6GxGKdknZv+t4e9Wz
        UyVzGY57v9iMX3uq1afNQXg7ChyI/hbZBvg0AaU+wr9AJTwoMzm721n04R9lsBwD
        pw2x9eaALxmH595QroH2SaXu8zDRRoDbTOrVktrJW6OtpTbup0n/B/sUv45FeNQE
        G/kBU1Vk3tMug3Ty3kpFJ9i5xW+5QkSZRNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1664702910; x=1664789310; bh=o4YZVV66nFlu/
        Ivg+JUF8MHi6wK7LZJ8ljNxD8TAngo=; b=enNGwLxAIwmVqkIYRXEUMN3GkDFDa
        iF61ssUyYJml5oxleHED9YCI8iMRb/5+6yH+DDptE8dyo3wMN6ejwZNhDgVPD/0T
        5eut+C7SzbxMfjB1mFuHFve0G6eb8R6D0eXXNXxKapVWlygeSP0I+sAiitVhIFnh
        dJQByo4Li5v/nuTzQfYeSu50zrJtDg/Nj6nfon2cauQjD+VYI0UBJmeuuc3FuDdL
        N23zPMS8FQ34o9hxiN2sVbnCvvZhVfJpN0HHs7clDGcTj/Zx57RYx4jKXtiORCxQ
        fFTbOtvM1qPLExbZibf+p9OXwHt4zLUP5qYdQ2QVXwpQan6hOsGUuJLnQ==
X-ME-Sender: <xms:vlk5Y-UyEvoTehqxgtAwOTSWLwJCEhTGg4ISP4g-4yIEtjNxVJve6w>
    <xme:vlk5Y6mFi5xaqD4xg4VGOMKoWwnjQCBfdhS8XzvgIieTv6OAHYw6WZzkPunp1l1pM
    V2C4ONRfb5bbkfI8g>
X-ME-Received: <xmr:vlk5YyYXqr6n8Lh6Yl5MFw8bgIfUI3XS1lDHVQvLG804oHA8x9kUyCuegpWhFReb7c1hzbQvFW552rO58HcZXhRkI-SV6DQ47vI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeehjedgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofggtgfgsehtkeertdertdejnecuhfhrohhmpefvohhmucfh
    ihhtiihhvghnrhihuceothhomhesthhomhdqfhhithiihhgvnhhrhidrmhgvrdhukheqne
    cuggftrfgrthhtvghrnheptdfgteduheeljeeiieduveehhffgfeelvedvjefhudetudeh
    udffleefffeuheeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepthhomhesthhomhdqfhhithiihhgvnhhrhidrmhgvrdhukh
X-ME-Proxy: <xmx:vlk5Y1VrI4_fi5Q19lQ0Hw4TPR7PJkB4dL8vYXWOLuzE2pwDjfPgng>
    <xmx:vlk5Y4nVIqlpq9zHkeRUdRNBfm3z-p9dqj-JkyAAi9SMfhvXuyhxWQ>
    <xmx:vlk5Y6ed4Hi4omPmwWE8t9CoIpt7HMtheUzvADOW3lp0WU2lRJZYuQ>
    <xmx:vlk5Yz_mHpNnIXR4WCp97kPB9h4N5rk7VaILPOQ8z39OptJ6I6-I7w>
Feedback-ID: iefc945ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 2 Oct 2022 05:28:27 -0400 (EDT)
From:   Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Ondrej Jirman <megi@xff.cz>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org,
        Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
Subject: [PATCH v2] arm64: dts: rockchip: add BT/wifi nodes to Pinephone Pro
Date:   Sun,  2 Oct 2022 20:28:09 +1100
Message-Id: <20221002092809.451501-1-tom@tom-fitzhenry.me.uk>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pinephone Pro includes a AzureWave AW-CM256SM wifi (sdio0) and
bt (uart0) combo module, which is based on Cypress
CYP43455 (BCM43455).

The CYP43455 datasheet ("Power-Up Sequence and Timing") documents:
* needing to wait 10ms between consecutive WL_REG_ON toggles
* needing to wait 110ms between power-on and SDIO access.

Signed-off-by: Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
Reviewed-by: Ondřej Jirman <megi@xff.cz>
---
Changes since v1:
* changed wifi power delays according to datasheet
* renamed sdio_pwrseq node to wifi_pwrseq
* reorder nodes alphabetically
---
 .../dts/rockchip/rk3399-pinephone-pro.dts     | 76 +++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
index 2e058c315025..04403a76238b 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
@@ -81,6 +81,27 @@ vcc1v8_codec: vcc1v8-codec-regulator {
 		regulator-max-microvolt = <1800000>;
 		vin-supply = <&vcc3v3_sys>;
 	};
+
+	wifi_pwrseq: sdio-wifi-pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		clocks = <&rk818 1>;
+		clock-names = "ext_clock";
+		pinctrl-names = "default";
+		pinctrl-0 = <&wifi_enable_h_pin>;
+		/*
+		 * Wait between power-on and SDIO access for CYP43455
+		 * POR circuit.
+		 */
+		post-power-on-delay-ms = <110>;
+		/*
+		 * Wait between consecutive toggles for CYP43455 CBUCK
+		 * regulator discharge.
+		 */
+		power-off-delay-us = <10000>;
+
+		/* WL_REG_ON on module */
+		reset-gpios = <&gpio0 RK_PB2 GPIO_ACTIVE_LOW>;
+	};
 };
 
 &cpu_l0 {
@@ -360,11 +381,45 @@ vsel2_pin: vsel2-pin {
 		};
 	};
 
+	sdio-pwrseq {
+		wifi_enable_h_pin: wifi-enable-h-pin {
+			rockchip,pins = <0 RK_PB2 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
 	sound {
 		vcc1v8_codec_en: vcc1v8-codec-en {
 			rockchip,pins = <3 RK_PA4 RK_FUNC_GPIO &pcfg_pull_down>;
 		};
 	};
+
+	wireless-bluetooth {
+		bt_wake_pin: bt-wake-pin {
+			rockchip,pins = <2 RK_PD2 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		bt_host_wake_pin: bt-host-wake-pin {
+			rockchip,pins = <0 RK_PA4 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		bt_reset_pin: bt-reset-pin {
+			rockchip,pins = <0 RK_PB1 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+};
+
+&sdio0 {
+	bus-width = <4>;
+	cap-sd-highspeed;
+	cap-sdio-irq;
+	disable-wp;
+	keep-power-in-suspend;
+	mmc-pwrseq = <&wifi_pwrseq>;
+	non-removable;
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdio0_bus4 &sdio0_cmd &sdio0_clk>;
+	sd-uhs-sdr104;
+	status = "okay";
 };
 
 &sdmmc {
@@ -393,6 +448,27 @@ &tsadc {
 	status = "okay";
 };
 
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_xfer &uart0_cts &uart0_rts>;
+	uart-has-rtscts;
+	status = "okay";
+
+	bluetooth {
+		compatible = "brcm,bcm4345c5";
+		clocks = <&rk818 1>;
+		clock-names = "lpo";
+		device-wakeup-gpios = <&gpio2 RK_PD2 GPIO_ACTIVE_HIGH>;
+		host-wakeup-gpios = <&gpio0 RK_PA4 GPIO_ACTIVE_HIGH>;
+		max-speed = <1500000>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&bt_host_wake_pin &bt_wake_pin &bt_reset_pin>;
+		shutdown-gpios = <&gpio0 RK_PB1 GPIO_ACTIVE_HIGH>;
+		vbat-supply = <&vcc3v3_sys>;
+		vddio-supply = <&vcc_1v8>;
+	};
+};
+
 &uart2 {
 	status = "okay";
 };

base-commit: b985063870727be3e94747b1c929219d04e77665
-- 
2.37.3

