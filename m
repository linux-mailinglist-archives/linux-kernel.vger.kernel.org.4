Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC0E46A73CE
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 19:50:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbjCASuk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 13:50:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbjCASug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 13:50:36 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B4D196A1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 10:50:35 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id l1so14326269pjt.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 10:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Rl4MXOgHLVry4oz9vlA930t08zmflDfyfREOeE2Q34=;
        b=Io4nCr0FvVKnFmQlugdrzL4PkzhrOpeHGSvFz/6Xgm7M+qoRurq0pAatZm7etSSoNA
         8QL4nSezHw9OmXdh3BQBfvMXRTYIPdFoo/QgKymilOUnod7ILBBfVyZC+0FOLeQVGBGG
         tyENgfAk4xIJvFqb/rOemVsV2NMijwV0c+fDE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Rl4MXOgHLVry4oz9vlA930t08zmflDfyfREOeE2Q34=;
        b=6DglH/HvOdtaiA5+VZmKmUUrwyNJFU9NOCO22JrPqDhIZBJsmmL9I0dS1c6E5Xgzc8
         53aWDG+fw11i0hxwirpAL/afDwV2jozPSD7n+1aYktc6e4WA8KNt0dEQxWFmv+fPLGHa
         CkXuCp9SzybLx/+/kV8sbFHcsk/o3TlEa9YWR1n6dYOKXVBsfAMXsI+6i83wK8uILyll
         a3ZQgvsiBFss+LfffajKteMV0Kke4rNfdoMXKFV4PrGU3b/Hz0fj0aHfnTWQ11Oh8FBk
         quokYUO0bdc9Fef5TalD1e0rQJB7KItXNxLSeTdMAmZtAUNoMWwQXKXfQE8hh1PUe4C/
         rEDw==
X-Gm-Message-State: AO0yUKUQzLK7SBhNOKY4syfgJdENCywuLqnSvEDU+JP48nvAOlLAZoBZ
        eeu8mkEdl7T+diUfSOWGpITTFg==
X-Google-Smtp-Source: AK7set/ErsWyPbDxwfCjDWNR050TZwD/oYsuvFjY6vP9Wk+gnQhF1bRILuOJP1U+w4Q9NgG5IunJ/w==
X-Received: by 2002:a17:902:e5ce:b0:19a:b754:4053 with SMTP id u14-20020a170902e5ce00b0019ab7544053mr9824366plf.26.1677696634786;
        Wed, 01 Mar 2023 10:50:34 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:f4ac:1f4d:6f3b:f98])
        by smtp.gmail.com with ESMTPSA id p5-20020a170902780500b0019a8530c063sm8761982pll.102.2023.03.01.10.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 10:50:34 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     mka@chromium.org, swboyd@chromium.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] arm64: dts: qcom: sc7180: Delete wormdingler-rev0
Date:   Wed,  1 Mar 2023 10:50:03 -0800
Message-Id: <20230301104859.1.Id0cd5120469eb200118c0c7b8ee8209f877767b4@changeid>
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

The earliest wormdingler I could find in my pile of hardware is
-rev1. I believe that -rev0 boards were just distributed as a pile of
components with no case. At this point I can't imagine anyone needing
to make wormdingler-rev0 work, so let's delete support for it.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 arch/arm64/boot/dts/qcom/Makefile             |  2 --
 .../sc7180-trogdor-wormdingler-rev0-boe.dts   | 22 -------------------
 .../sc7180-trogdor-wormdingler-rev0-inx.dts   | 22 -------------------
 3 files changed, 46 deletions(-)
 delete mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev0-boe.dts
 delete mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev0-inx.dts

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 31aa54f0428c..a51060378ddc 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -118,8 +118,6 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-pompom-r3.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-pompom-r3-lte.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-quackingstick-r0.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-quackingstick-r0-lte.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-wormdingler-rev0-boe.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-wormdingler-rev0-inx.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-wormdingler-rev1-boe.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-wormdingler-rev1-inx.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-wormdingler-rev1-inx-rt5682s.dtb
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev0-boe.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev0-boe.dts
deleted file mode 100644
index d6ed7d0afe4a..000000000000
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev0-boe.dts
+++ /dev/null
@@ -1,22 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Google Wormdingler board device tree source
- *
- * Copyright 2021 Google LLC.
- *
- * SKU: 0x10 => 16
- *  - bits 7..4: Panel ID: 0x1 (BOE)
- */
-
-/dts-v1/;
-
-#include "sc7180-trogdor-wormdingler-rev0.dtsi"
-
-/ {
-	model = "Google Wormdingler rev0 BOE panel board";
-	compatible = "google,wormdingler-rev0-sku16", "qcom,sc7180";
-};
-
-&panel {
-	compatible = "boe,tv110c9m-ll3";
-};
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev0-inx.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev0-inx.dts
deleted file mode 100644
index c03525ea64ca..000000000000
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler-rev0-inx.dts
+++ /dev/null
@@ -1,22 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Google Wormdingler board device tree source
- *
- * Copyright 2021 Google LLC.
- *
- * SKU: 0x0 => 0
- *  - bits 7..4: Panel ID: 0x0 (INX)
- */
-
-/dts-v1/;
-
-#include "sc7180-trogdor-wormdingler-rev0.dtsi"
-
-/ {
-	model = "Google Wormdingler rev0 INX panel board";
-	compatible = "google,wormdingler-rev0-sku0", "qcom,sc7180";
-};
-
-&panel {
-	compatible = "innolux,hj110iz-01a";
-};
-- 
2.39.2.722.g9855ee24e9-goog

