Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81EFD648777
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 18:13:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbiLIRNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 12:13:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbiLIRNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 12:13:23 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AC1943AF3
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 09:13:18 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d7so5526825pll.9
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 09:13:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O0omoS8MV63r00CQ4nuB53paFZYXNiG9HsPf+U2WQ9E=;
        b=Wa3jW/P9medwAOfYN+2bRU1Hjp4n13rmgrVGmNkpXpDZ5AJ/m/CDI1UUbBHuFWxEeV
         BNNwxa4pcUfpOKFrrP6JMOlXHoy5lL0aMJ+Uk8pEeJsVlrk4F2e8aFElg4RT+Q0V/fIP
         HQaJVOXN93/MKQfO+r//lld8GalJy+iueSUeM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O0omoS8MV63r00CQ4nuB53paFZYXNiG9HsPf+U2WQ9E=;
        b=JZbxQh2XzjEqXxOQF+ef2fODM2M1Mc2bxyWVeOiVA4p5BlXolaoQ/UGZjMYNrMR47z
         ++HDNbkVD8PME4EFN6hd3SkVgx/47Mb6LuoZft9Yx5ZL3gt8jIfW0OBzZwLFPlvXcKcN
         Ea8Z+ZsVBuVjdKJci8NBneU1HODJmgucm0/kU5rbIc3yuyXHZETDpwY2r2wc/ShtZ/vw
         D/7b82cFa5KFQqSAFfEOaklio4G9ttJk5SZZ1uMEqaHgwVoXRtcbl0cw4D3x1uF/HTMU
         sFERfZofPqsdpW6WoZXN9OuFwR0CU3jiZJX3A7g524Y//G5DDybBLByGve9pdW1N2SAM
         kfKQ==
X-Gm-Message-State: ANoB5pkFH1d7sgbxsLhcKEVHg16ObdlldXcCJp3O7lBU00QAyQqt+VfL
        FF6FfkVOR2wpqnoh0iB3Gl/3lAy+CQXjG7SLZfU=
X-Google-Smtp-Source: AA0mqf6ZtgLHPj4NhOyuuvRDjQRR086RdrEvLK+eXM+foVAogAE/mboLX+EJgIcSCS6q7yR3RrMSOg==
X-Received: by 2002:a17:902:aa91:b0:189:b8a2:27ed with SMTP id d17-20020a170902aa9100b00189b8a227edmr6005390plr.57.1670605998225;
        Fri, 09 Dec 2022 09:13:18 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:9a82:7898:7bf4:b4f])
        by smtp.gmail.com with ESMTPSA id j16-20020a170902da9000b00189c62eac37sm1597503plx.32.2022.12.09.09.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 09:13:17 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     swboyd@chromium.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        mka@chromium.org, Yunlong Jia <ecs.beijing2022@gmail.com>,
        linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-input@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/4] arm64: dts: qcom: sc7180: Start the trogdor eDP/touchscreen regulator on
Date:   Fri,  9 Dec 2022 09:12:39 -0800
Message-Id: <20221209091234.v3.3.I7050a61ba3a48e44b86053f265265b5e3c0cee31@changeid>
X-Mailer: git-send-email 2.39.0.rc1.256.g54fd8350bd-goog
In-Reply-To: <20221209171240.1614904-1-dianders@chromium.org>
References: <20221209171240.1614904-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we've added the `off-on-delay-us` for the touchpanel
regulator, we can see that we're actually hitting that delay at
bootup. I saw about 200 ms of delay.

Let's avoid that delay by starting the regulator on. We'll only do
this for eDP devices for the time being.

NOTE: we _won't_ do this for homestar. Homestar's panel really likes
to be power cycled. It's why the Linux driver for this panel has a
pm_runtime_put_sync_suspend() when the panel is being unprepared but
the normal panel-edp driver doesn't. It's also why this hardware has a
separate power rail for eDP vs. touchscreen, unlike all the other
trogdor boards. We won't start homestar's regulator on. While this
could mean a slight delay on homestar, it is probably a _correct_
delay. The bootloader might have left the regulator on (it does so in
dev and recovery modes), so if we turned the regulator off at probe
time and we actually hit the delay then we were probably violating T12
in the panel spec.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
---

(no changes since v1)

 .../boot/dts/qcom/sc7180-trogdor-homestar.dtsi | 18 ++++++++++++++++++
 .../dts/qcom/sc7180-trogdor-parade-ps8640.dtsi |  8 ++++++++
 .../dts/qcom/sc7180-trogdor-ti-sn65dsi86.dtsi  |  8 ++++++++
 3 files changed, 34 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi
index d3cf64c16dcd..b3ba23a88a0b 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi
@@ -85,6 +85,24 @@ map1 {
 	};
 };
 
+/*
+ * ADDITIONS TO FIXED REGULATORS DEFINED IN PARENT DEVICE TREE FILES
+ *
+ * Sort order matches the order in the parent files (parents before children).
+ */
+
+&pp3300_dx_edp {
+	/*
+	 * The atna33xc20 really likes to be power cycled to keep it from
+	 * getting in a bad state. This is the reason that the touchscreen
+	 * rail and eDP rails are separate from each other on homestar (but
+	 * not other trogdor devices) Make sure it starts "off" at bootup.
+	 */
+	/delete-property/ regulator-boot-on;
+};
+
+/* ADDITIONS TO NODES DEFINED IN PARENT DEVICE TREE FILES */
+
 ap_ts_pen_1v8: &i2c4 {
 	status = "okay";
 	clock-frequency = <400000>;
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-parade-ps8640.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-parade-ps8640.dtsi
index e27a769f8cd4..5aa7949b5328 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-parade-ps8640.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-parade-ps8640.dtsi
@@ -34,6 +34,14 @@ pp3300_brij_ps8640: pp3300-brij-ps8640-regulator {
 
 &pp3300_dx_edp {
 	off-on-delay-us = <500000>;
+
+	/*
+	 * It's nicer to start with this regulator enabled. The
+	 * bootloader may have left it on and it's nice not to cause an
+	 * extra power cycle of the touchscreen and eDP panel at bootup.
+	 * This should help speed bootup because we have off-on-delay-us.
+	 */
+	regulator-boot-on;
 };
 
 /* ADDITIONS TO NODES DEFINED IN PARENT DEVICE TREE FILES */
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-ti-sn65dsi86.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-ti-sn65dsi86.dtsi
index 3188788306d0..e52b8776755d 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-ti-sn65dsi86.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-ti-sn65dsi86.dtsi
@@ -15,6 +15,14 @@
 
 &pp3300_dx_edp {
 	off-on-delay-us = <500000>;
+
+	/*
+	 * It's nicer to start with this regulator enabled. The
+	 * bootloader may have left it on and it's nice not to cause an
+	 * extra power cycle of the touchscreen and eDP panel at bootup.
+	 * This should help speed bootup because we have off-on-delay-us.
+	 */
+	regulator-boot-on;
 };
 
 /* ADDITIONS TO NODES DEFINED IN PARENT DEVICE TREE FILES */
-- 
2.39.0.rc1.256.g54fd8350bd-goog

