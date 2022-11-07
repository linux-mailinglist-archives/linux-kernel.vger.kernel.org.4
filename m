Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5349D61FE6F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 20:16:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232192AbiKGTPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 14:15:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232449AbiKGTPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 14:15:42 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3CA127B12
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 11:15:41 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id k15so11549652pfg.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 11:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MAGGpX4Ay77YkRb+5QXDL/dau2EPpYwvMkCbBNog/BI=;
        b=TjqUSgqnII0G0WZTI6p6Gd/CyWQFWrHl1hMxQohEpc1bkF0MU6XGVc3OOjReGoaOms
         PRI20021zPm29apZ1ts3/q7kxLscRoXetQPBWCKZKHNHcoMxTSw1MSgBcMv0Cc69/6/z
         KLL99x85K3owtxshucfwd+CAs/vbJVeg3ndzk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MAGGpX4Ay77YkRb+5QXDL/dau2EPpYwvMkCbBNog/BI=;
        b=iC2dovvt71VziggHcnlP+uePkVRET2E+B8cvlUR2zqaanLqFZhFKgnDDKCk0a9rsQ4
         ZaZjovgq2xRV0/ykvSGTeca418yJiXHo5WbyeK1EGGXYpeppKrFemHRljNTnkBqLqcj7
         9THB2QG7M5wQAdY8+OGceKNBMHYsZDQx1Uyq0qFgrdqqZo7rzmWBdL1jsDU5td/5OyiS
         QjD+G9ntMuAjmwMweCcq9bv6RaiVL6IFsRMAyNjh60/P47ayTnN1CYNxAMFkm6F90YWh
         5Xk4BZdMv2pwbJKtz4B9hhZsxCu4nJovF3TI0t04vG3PdT4qkE1j0iDYSPZ+Vd45Wm/j
         nXkg==
X-Gm-Message-State: ANoB5plpq77DhexkOm8Y4eCx8GIWFsu9y80N4ONe4lOaaHgFbHOdJhGF
        Ll4PeTub/fX30cOxqv/dZOzx9g==
X-Google-Smtp-Source: AA0mqf6DAWhYHCQXdGe8W8GD7+Ltdyot8QuSvT65ONDzi3yi0qOK21KX1BPtL78HniLAO08zYVjNAw==
X-Received: by 2002:a63:f353:0:b0:470:814c:f4ee with SMTP id t19-20020a63f353000000b00470814cf4eemr3188280pgj.8.1667848541273;
        Mon, 07 Nov 2022 11:15:41 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:11a:201:4652:3752:b9b7:29f9])
        by smtp.gmail.com with ESMTPSA id r11-20020a170902c60b00b001830ed575c3sm5306627plr.117.2022.11.07.11.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 11:15:40 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        linux-arm-msm@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>
Subject: [PATCH v2 2/2] arm64: dts: qcom: Fully describe fingerprint node on Trogdor
Date:   Mon,  7 Nov 2022 11:15:35 -0800
Message-Id: <20221107191535.624371-3-swboyd@chromium.org>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
In-Reply-To: <20221107191535.624371-1-swboyd@chromium.org>
References: <20221107191535.624371-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the fingerprint node on Trogdor to match the fingerprint DT
binding. This will allow us to drive the reset and boot gpios from the
driver when it is re-attached after flashing. We'll also be able to boot
the fingerprint processor if the BIOS isn't doing it for us.

Cc: Douglas Anderson <dianders@chromium.org>
Cc: Matthias Kaehlcke <mka@chromium.org>
Cc: Alexandru M Stan <amstan@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
index 4a5ea17a15ba..65601bea0797 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
@@ -894,13 +894,16 @@ ap_spi_fp: &spi10 {
 	cs-gpios = <&tlmm 89 GPIO_ACTIVE_LOW>;
 
 	cros_ec_fp: ec@0 {
-		compatible = "google,cros-ec-spi";
+		compatible = "google,cros-ec-fp", "google,cros-ec-spi";
 		reg = <0>;
 		interrupt-parent = <&tlmm>;
 		interrupts = <4 IRQ_TYPE_LEVEL_LOW>;
 		pinctrl-names = "default";
-		pinctrl-0 = <&fp_to_ap_irq_l>;
+		pinctrl-0 = <&fp_to_ap_irq_l>, <&fp_rst_l>, <&fpmcu_boot0>;
+		boot0-gpios = <&tlmm 10 GPIO_ACTIVE_HIGH>;
+		reset-gpios = <&tlmm 22 GPIO_ACTIVE_LOW>;
 		spi-max-frequency = <3000000>;
+		vdd-supply = <&pp3300_fp_tp>;
 	};
 };
 
@@ -1226,6 +1229,13 @@ en_pp3300_hub: en-pp3300-hub-state {
 		bias-disable;
 	};
 
+	fp_rst_l: fp-rst-l-state {
+		pins = "gpio22";
+		function = "gpio";
+		bias-disable;
+		drive-strength = <2>;
+	};
+
 	fp_to_ap_irq_l: fp-to-ap-irq-l-state {
 		pins = "gpio4";
 		function = "gpio";
@@ -1235,6 +1245,12 @@ fp_to_ap_irq_l: fp-to-ap-irq-l-state {
 		bias-disable;
 	};
 
+	fpmcu_boot0: fpmcu-boot0-state {
+		pins = "gpio10";
+		function = "gpio";
+		bias-disable;
+	};
+
 	h1_ap_int_odl: h1-ap-int-odl-state {
 		pins = "gpio42";
 		function = "gpio";
-- 
https://chromeos.dev

