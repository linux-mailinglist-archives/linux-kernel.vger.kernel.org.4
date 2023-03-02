Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 644DF6A8AFD
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 22:11:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjCBVLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 16:11:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjCBVLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 16:11:30 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 652775652A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 13:11:29 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id p3-20020a17090ad30300b0023a1cd5065fso339848pju.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 13:11:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tWAMygCylqh58NKKkBtb38EW2K6DR/A0BM3WbKZf+OY=;
        b=cy2wNkBN2aeiKS59LTkdCMsChPyapo+wQIWOqAZv9LNPB000DvBdhG31hinMrK8hvN
         ckCB6Cx5FhtPHDMDGj1ADfTyCZyAozwAidEWpin7TFZgy61f8RVOmwpSWoS6dRDlHtLA
         h0YTUOkWYUOYBS0IAkF3wnPJ+NJwLyMtqR78g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tWAMygCylqh58NKKkBtb38EW2K6DR/A0BM3WbKZf+OY=;
        b=nVf67CvyPsGSlON2NhdH02LVN5jgiWfGhpUQLncCncQQ0d2MY34UUReICUkwd60fNn
         g7TJwL5wXnyHuqz8fCamz47ndohyeVXqCJOYkHlG/z/sdaEvMgOMXO8wQkN8tmp6Ju1g
         ejbC3WgpSaH3Mvr7D0k/0M+2/oFhskuREyPZ4J/p7YtgL72ZMJWS+m/b/1xwg5ONRrg6
         EPiKzodAXLbywuAoZ5hfCVJrz/tPcXeVRkzhVaM3iPYZXO4Mg6FH5f7Zjmd9S0WLoGeT
         BfgVOCp5ePZNR5qd1J+b7x8qjcIQOoTii53pOOWd6kR+ICtXxdso1/VK4sGKJiVoro+X
         vEsw==
X-Gm-Message-State: AO0yUKW6dx1UhgFYFwb6urcnvjfiPT3Tg33aqySAVesQiDZF3jUKg3v8
        1yOUA8q8Rfy3Modh4Pr6OQbZbw==
X-Google-Smtp-Source: AK7set/xJdnBz4IH5r3UsMFm+w/ceYSD1Ngka0F0eGQIPMpan5wcxzkXfX0rmvum7RpjZ4/OCgiEAw==
X-Received: by 2002:a17:902:d2cd:b0:19d:af21:dc2f with SMTP id n13-20020a170902d2cd00b0019daf21dc2fmr13994381plc.33.1677791489075;
        Thu, 02 Mar 2023 13:11:29 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:a558:99c0:81e9:a93c])
        by smtp.gmail.com with ESMTPSA id a16-20020a170902b59000b00195f242d0a0sm114497pls.194.2023.03.02.13.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 13:11:28 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>, mka@chromium.org,
        swboyd@chromium.org, Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] arm64: dts: qcom: sc7180: Delete kingoftown-rev0
Date:   Thu,  2 Mar 2023 13:11:05 -0800
Message-Id: <20230302131031.v2.2.I68cbe5d5d45074428469da8c52f1d6a78bdc62fc@changeid>
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
In-Reply-To: <20230302211108.2129598-1-dianders@chromium.org>
References: <20230302211108.2129598-1-dianders@chromium.org>
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

The earliest kingoftown that I could find in my pile of boards was
-rev2 and even that revision looks pretty rough (plastics on the case
are very unfinished). Though I don't actually have details about how
many -rev0 devices were produced, I can't imagine anyone still using
one. Let's delete support.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- Get rid of kingoftown.dtsi and merge into dts (Konrad)

 arch/arm64/boot/dts/qcom/Makefile             |  3 +-
 .../dts/qcom/sc7180-trogdor-kingoftown-r0.dts | 38 -------------------
 .../dts/qcom/sc7180-trogdor-kingoftown-r1.dts | 17 ---------
 ...own.dtsi => sc7180-trogdor-kingoftown.dts} | 10 ++++-
 4 files changed, 10 insertions(+), 58 deletions(-)
 delete mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-kingoftown-r0.dts
 delete mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-kingoftown-r1.dts
 rename arch/arm64/boot/dts/qcom/{sc7180-trogdor-kingoftown.dtsi => sc7180-trogdor-kingoftown.dts} (95%)

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index a51060378ddc..3ce51093ed8f 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -83,8 +83,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-coachz-r3-lte.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-homestar-r2.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-homestar-r3.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-homestar-r4.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-kingoftown-r0.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-kingoftown-r1.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-kingoftown.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-lazor-r0.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-lazor-r1.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-lazor-r1-kb.dtb
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-kingoftown-r0.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-kingoftown-r0.dts
deleted file mode 100644
index 3abd6222fe46..000000000000
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-kingoftown-r0.dts
+++ /dev/null
@@ -1,38 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Google Kingoftown board device tree source
- *
- * Copyright 2021 Google LLC.
- */
-
-/dts-v1/;
-
-#include "sc7180-trogdor.dtsi"
-#include "sc7180-trogdor-ti-sn65dsi86.dtsi"
-#include "sc7180-trogdor-kingoftown.dtsi"
-
-/ {
-	model = "Google Kingoftown (rev0)";
-	compatible = "google,kingoftown-rev0", "qcom,sc7180";
-};
-
-/*
- * In rev1+, the enable pin of pp3300_fp_tp will be tied to pp1800_l10a
- * power rail instead, since kingoftown does not have FP.
- */
-&pp3300_fp_tp {
-	gpio = <&tlmm 74 GPIO_ACTIVE_HIGH>;
-	enable-active-high;
-
-	pinctrl-names = "default";
-	pinctrl-0 = <&en_fp_rails>;
-};
-
-&tlmm {
-	en_fp_rails: en-fp-rails-state {
-		pins = "gpio74";
-		function = "gpio";
-		drive-strength = <2>;
-		bias-disable;
-	};
-};
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-kingoftown-r1.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-kingoftown-r1.dts
deleted file mode 100644
index e0752ba7df11..000000000000
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-kingoftown-r1.dts
+++ /dev/null
@@ -1,17 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Google Kingoftown board device tree source
- *
- * Copyright 2021 Google LLC.
- */
-
-/dts-v1/;
-
-#include "sc7180-trogdor.dtsi"
-#include "sc7180-trogdor-parade-ps8640.dtsi"
-#include "sc7180-trogdor-kingoftown.dtsi"
-
-/ {
-	model = "Google Kingoftown (rev1+)";
-	compatible = "google,kingoftown", "qcom,sc7180";
-};
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-kingoftown.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-kingoftown.dts
similarity index 95%
rename from arch/arm64/boot/dts/qcom/sc7180-trogdor-kingoftown.dtsi
rename to arch/arm64/boot/dts/qcom/sc7180-trogdor-kingoftown.dts
index 315ac5eb5f78..36326ef972dc 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-kingoftown.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-kingoftown.dts
@@ -5,10 +5,18 @@
  * Copyright 2021 Google LLC.
  */
 
-/* This file must be included after sc7180-trogdor.dtsi */
+/dts-v1/;
+
+#include "sc7180-trogdor.dtsi"
+#include "sc7180-trogdor-parade-ps8640.dtsi"
 #include <arm/cros-ec-keyboard.dtsi>
 #include "sc7180-trogdor-lte-sku.dtsi"
 
+/ {
+	model = "Google Kingoftown";
+	compatible = "google,kingoftown", "qcom,sc7180";
+};
+
 &alc5682 {
 	compatible = "realtek,rt5682s";
 	/delete-property/ VBAT-supply;
-- 
2.40.0.rc0.216.gc4246ad0f0-goog

