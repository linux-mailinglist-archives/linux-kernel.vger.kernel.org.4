Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7ACC6A8B03
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 22:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbjCBVLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 16:11:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjCBVLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 16:11:32 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F49757D1C
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 13:11:31 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id l1so471297pjt.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 13:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z9/zdJNe6aueqSUbF+UGkGcF94Cd9g+WCPu4qV/+rtY=;
        b=Ygnbv3S0KORQNasKbAblivXK049eL6zzuPJPUgGw6LS46kcdxOXLwmMhmLKiBaxF0e
         bOES/IH62GURIeAuj1PQUYpp/B6gBpenM9Jif898wnRwCTwslFdZ1ANRT3CFXHvigUrj
         KaaWJdJnzXoqPWx/YZXXhWpy4hq/Zyzfky0/g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z9/zdJNe6aueqSUbF+UGkGcF94Cd9g+WCPu4qV/+rtY=;
        b=5lPlQtmpuEdQ2qd7KLEHvY672BaGAm2P3sgnklYDA+uZuMJGk284j+h5rPKV+EUNXy
         G9rw9Y2oCWvbpIYZRmM2G5kSYYhpKRDlkJoMKX0yvDA0HwkIXr8ggZFoh7bEC7ojEiAR
         QX+NbWu6fPg9miEqNu8w25kd4VNdxJb+xA3G8v0V0wUvvL3qXMLnPTsxcDyib3kB++Ok
         vggW850SC3YsA1g9FGFnaMkwfGlq9dzYllwDCb7JSQOGKhgoJ+P0TXJoY00nnJ2n4yXt
         np2kLg3f3sOtxxWaB3u/l2pcFLxyYMo+A47pH8jq8UhYUKKDRaYY0pb4DrELdHN4Cc9c
         M91A==
X-Gm-Message-State: AO0yUKWMA8GsE0v3rzYcWibACNdNpgWD+c/eVi3Pn3wxVoxoMGPZNDsp
        yQfwECZejq1ranIJB9bFOLTkXQ==
X-Google-Smtp-Source: AK7set8b+qVTvYDZRJM3PUk3fV+3oIui5Ivxb9b/N39OWwjbPT7V9aq6d3POcwN5mYdldAv8AdOxrw==
X-Received: by 2002:a17:903:228c:b0:19c:92f5:ab4e with SMTP id b12-20020a170903228c00b0019c92f5ab4emr11561863plh.18.1677791490538;
        Thu, 02 Mar 2023 13:11:30 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:a558:99c0:81e9:a93c])
        by smtp.gmail.com with ESMTPSA id a16-20020a170902b59000b00195f242d0a0sm114497pls.194.2023.03.02.13.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 13:11:30 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>, mka@chromium.org,
        swboyd@chromium.org, Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] arm64: dts: qcom: sc7180: Delete lazor-rev0
Date:   Thu,  2 Mar 2023 13:11:06 -0800
Message-Id: <20230302131031.v2.3.I30128a6f4b60b096770186430036afb40ede6f70@changeid>
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
In-Reply-To: <20230302211108.2129598-1-dianders@chromium.org>
References: <20230302211108.2129598-1-dianders@chromium.org>
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

lazor-rev0 was a pile of parts. While I kept the pile of parts for
lazor running on my desk for longer than I usually do, those days are
still long past. Let's finally delete support for lazor-rev0.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---

(no changes since v1)

 arch/arm64/boot/dts/qcom/Makefile             |  1 -
 .../boot/dts/qcom/sc7180-trogdor-lazor-r0.dts | 34 -------------------
 2 files changed, 35 deletions(-)
 delete mode 100644 arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r0.dts

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 3ce51093ed8f..e4190a648335 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -84,7 +84,6 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-homestar-r2.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-homestar-r3.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-homestar-r4.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-kingoftown.dtb
-dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-lazor-r0.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-lazor-r1.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-lazor-r1-kb.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-lazor-r1-lte.dtb
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r0.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r0.dts
deleted file mode 100644
index d49de65aa960..000000000000
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r0.dts
+++ /dev/null
@@ -1,34 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Google Lazor board device tree source
- *
- * Copyright 2020 Google LLC.
- */
-
-/dts-v1/;
-
-#include "sc7180-trogdor.dtsi"
-#include "sc7180-trogdor-ti-sn65dsi86.dtsi"
-#include "sc7180-trogdor-lazor.dtsi"
-
-/ {
-	model = "Google Lazor (rev0)";
-	compatible = "google,lazor-rev0", "qcom,sc7180";
-};
-
-&sn65dsi86_out {
-	/*
-	 * Lane 0 was incorrectly mapped on the cable, but we've now decided
-	 * that the cable is canon and in -rev1+ we'll make a board change
-	 * that means we no longer need the swizzle.
-	 */
-	lane-polarities = <1 0>;
-};
-
-&usb_hub_2_x {
-	 vdd-supply = <&pp3300_l7c>;
-};
-
-&usb_hub_3_x {
-	 vdd-supply = <&pp3300_l7c>;
-};
-- 
2.40.0.rc0.216.gc4246ad0f0-goog

