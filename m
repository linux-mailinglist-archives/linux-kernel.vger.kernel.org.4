Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5848C6A73D0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 19:50:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbjCASun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 13:50:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjCASui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 13:50:38 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A144D610
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 10:50:37 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id a2so4582728plm.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 10:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RP9FrgqNQaeNofvRfVHHkZnngHHL0TDN12M7kvtBOo4=;
        b=eq6OyecIb7kmMZCRU1+fDFronDX6DA+uoeVzcElhLVIton+n+MJA31hE9IG3MVdV1j
         U1950gg7Zup//bgJW/TNmrN206/rV8zKLsOWKboURYz37rNbiu1bMiPv2DaYtASMcou/
         AhqSKfG3z4Ck1rk1/x8yP6A6xhFQ6fzIuBkuA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RP9FrgqNQaeNofvRfVHHkZnngHHL0TDN12M7kvtBOo4=;
        b=zoSsxO5k+9Vi3cTKfLBrmAPL5eiO3kw38gaJO+Y9VICUFERRhX0KBlc6av76otg/bA
         K11rL+fGr/wVYhhtqWoR9Q2r0a2NoDFjEcP5kpt3mkYep/0DdbP/OQNjajqdYtjo/PMQ
         63JTM1CXUTLwGB7tWUX2wWliEo3CyaXeE05PEcgtwTHceSQC43zqr+54CETS+WgyPv7H
         ydljr9DPgO5EY+iR6Ok1Yp6kUbY2+Zf7GJdNpNixcbBOmn+D9Mbu+Iq09tIC5xB0mYTz
         VVylKiZWFmtMwmUliX6lvSqMyG++BqTsZ9e2O2B0ZGblEJux66kjfmbq7tglmIBaOKWL
         qw8g==
X-Gm-Message-State: AO0yUKUJ92AnAELGdOFt7k8QUQFKFLRpjLlfEy8wFHnoi7PLSEn9IOTu
        S5v7UiTl1ntTGJuglE1XX155GQ==
X-Google-Smtp-Source: AK7set82ucyBImDl/02D6W4i0FvhHcd9KANE8nbMECIh5g0t2HpdmGFmVu7f9fb1fGOtUUJX9JZBtA==
X-Received: by 2002:a17:903:40cf:b0:19c:d457:ff21 with SMTP id t15-20020a17090340cf00b0019cd457ff21mr7036557pld.54.1677696636565;
        Wed, 01 Mar 2023 10:50:36 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:f4ac:1f4d:6f3b:f98])
        by smtp.gmail.com with ESMTPSA id p5-20020a170902780500b0019a8530c063sm8761982pll.102.2023.03.01.10.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 10:50:36 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     mka@chromium.org, swboyd@chromium.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] arm64: dts: qcom: sc7180: Delete kingoftown-rev0
Date:   Wed,  1 Mar 2023 10:50:04 -0800
Message-Id: <20230301104859.2.I68cbe5d5d45074428469da8c52f1d6a78bdc62fc@changeid>
X-Mailer: git-send-email 2.39.2.722.g9855ee24e9-goog
In-Reply-To: <20230301185007.1101006-1-dianders@chromium.org>
References: <20230301185007.1101006-1-dianders@chromium.org>
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

 arch/arm64/boot/dts/qcom/Makefile             |  3 +-
 .../dts/qcom/sc7180-trogdor-kingoftown-r0.dts | 38 -------------------
 ...n-r1.dts => sc7180-trogdor-kingoftown.dts} |  0
 3 files changed, 1 insertion(+), 40 deletions(-)
 delete mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-kingoftown-r0.dts
 rename arch/arm64/boot/dts/qcom/{sc7180-trogdor-kingoftown-r1.dts => sc7180-trogdor-kingoftown.dts} (100%)

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
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-kingoftown-r1.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-kingoftown.dts
similarity index 100%
rename from arch/arm64/boot/dts/qcom/sc7180-trogdor-kingoftown-r1.dts
rename to arch/arm64/boot/dts/qcom/sc7180-trogdor-kingoftown.dts
-- 
2.39.2.722.g9855ee24e9-goog

