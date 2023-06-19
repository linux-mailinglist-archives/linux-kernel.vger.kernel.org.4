Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 228D57357C6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 15:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbjFSNFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 09:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231550AbjFSNEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 09:04:46 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6454E72
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 06:04:43 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f762b3227dso4130562e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 06:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687179882; x=1689771882;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8XUok3dbfSBKK4OnUZpMrrh2fJAxKXR9JHbUiXx4CDw=;
        b=esMlbAcwqyiD5Iy4ol0t2Jj658NeZJ9sOFPpsTq6KhjEWG9GqnyTD7154rimUcN/TS
         IsN0zQkTuwePg6cHAbG0Nz4DUgpzF6K68C35bR/zJha1VXGdid3rZ75P1Pgo4O1j3hbF
         8cmtFMjduQTjOnvYI0oOoI3hnqUWWBR1JTrYgDplQ0PvQpREVxZhVfn7/BBktmsLwm3J
         I8nwoVID3Yl5fciFA5WqpVMb0S5op7UziuhkvwMw0JcdzaNruiyMsB5MSuvZckUWX3y+
         uNspeGAO47pQyy5jVnwXul7AW/EOJKsayZ3TdxZxwtm/M5MTqiM/05g01wSP1CUUD00s
         Afyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687179882; x=1689771882;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8XUok3dbfSBKK4OnUZpMrrh2fJAxKXR9JHbUiXx4CDw=;
        b=gBsa7fXRQHVftlqKSoOD2lPPSCW19g7gHcEVst5OtAJQIeCvaPn+D7sZvzneUNmkFu
         CgLo2kS7UyGVqqs/2IrX61NB1rcSnMa9jDSSODfQp5Wy90xPoAxy80FBIey5YbfHi3f3
         3N/9pJdPR14z4t2/BO2OnVOT62GP6++H94HBovBcgwWiORo24QB7aF4Mn6ScWRek6KhL
         hzAyt6jFmWMQYEVtFYJbNjZhilIcHz39KRJn5vQtJhqkli3+XKYwhdUsv1W1G/vhFN3L
         wu0iaK7E00lvlWukPtJTb7mvUSM9NT0Kvc68J29jvNnOqOZ48dXrfFR7kS777IVheT+R
         LCWg==
X-Gm-Message-State: AC+VfDwa+GMbP5mmRrT4ZtAlf51clLUYaN7iBPgBXjIoOgpR6Och68qk
        sXF6FQrKqMBihSwWASIB7gmhLA==
X-Google-Smtp-Source: ACHHUZ4dY/eatnbSyIXrIxHmPDKFG2H2+I6ckChSswjscgYMJlbOpaKl4HLlNQjrC17KZ6i/+UN9Og==
X-Received: by 2002:a05:6512:47a:b0:4f8:7505:93f4 with SMTP id x26-20020a056512047a00b004f8750593f4mr521043lfd.1.1687179882309;
        Mon, 19 Jun 2023 06:04:42 -0700 (PDT)
Received: from [192.168.1.101] (abyl242.neoplus.adsl.tpnet.pl. [83.9.31.242])
        by smtp.gmail.com with ESMTPSA id q28-20020ac25a1c000000b004f643664882sm4256489lfn.147.2023.06.19.06.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 06:04:42 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 19 Jun 2023 15:04:32 +0200
Subject: [PATCH v7 07/22] interconnect: qcom: Add missing headers in
 icc-rpm.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230526-topic-smd_icc-v7-7-09c78c175546@linaro.org>
References: <20230526-topic-smd_icc-v7-0-09c78c175546@linaro.org>
In-Reply-To: <20230526-topic-smd_icc-v7-0-09c78c175546@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687179869; l=3985;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=cyjuO3H/NwWuCUlv2vJ6Jn9ceZQeEKzsmbMZaK77x5A=;
 b=vVKdhIpT8zh776dyaLFvbOhdmou4OfunfkD1ERwmJLOtDlMX/gpZmyVADao3lVQDAY73Wg9HB
 3WYU2wbGVgzDCaCGafu+fmypeoplDTMR8jnIHVwYQSdMYjLBJk5omiJ
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the header does not provide all the required dependencies.
Fix it.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/icc-rpm.c | 1 -
 drivers/interconnect/qcom/icc-rpm.h | 3 +++
 drivers/interconnect/qcom/msm8916.c | 1 -
 drivers/interconnect/qcom/msm8939.c | 1 -
 drivers/interconnect/qcom/msm8996.c | 1 -
 drivers/interconnect/qcom/qcm2290.c | 1 -
 drivers/interconnect/qcom/qcs404.c  | 1 -
 drivers/interconnect/qcom/sdm660.c  | 1 -
 8 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
index 863e8ba1daa2..80409f59b2c8 100644
--- a/drivers/interconnect/qcom/icc-rpm.c
+++ b/drivers/interconnect/qcom/icc-rpm.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2020 Linaro Ltd
  */
 
-#include <linux/clk.h>
 #include <linux/device.h>
 #include <linux/interconnect-provider.h>
 #include <linux/io.h>
diff --git a/drivers/interconnect/qcom/icc-rpm.h b/drivers/interconnect/qcom/icc-rpm.h
index d2c04c400cad..899e75e8ebaf 100644
--- a/drivers/interconnect/qcom/icc-rpm.h
+++ b/drivers/interconnect/qcom/icc-rpm.h
@@ -7,6 +7,9 @@
 #define __DRIVERS_INTERCONNECT_QCOM_ICC_RPM_H
 
 #include <dt-bindings/interconnect/qcom,icc.h>
+#include <linux/clk.h>
+#include <linux/interconnect-provider.h>
+#include <linux/platform_device.h>
 
 #define RPM_BUS_MASTER_REQ	0x73616d62
 #define RPM_BUS_SLAVE_REQ	0x766c7362
diff --git a/drivers/interconnect/qcom/msm8916.c b/drivers/interconnect/qcom/msm8916.c
index 5c4ba2f37c8e..518f4b40ecc2 100644
--- a/drivers/interconnect/qcom/msm8916.c
+++ b/drivers/interconnect/qcom/msm8916.c
@@ -4,7 +4,6 @@
  * Author: Georgi Djakov <georgi.djakov@linaro.org>
  */
 
-#include <linux/clk.h>
 #include <linux/device.h>
 #include <linux/interconnect-provider.h>
 #include <linux/io.h>
diff --git a/drivers/interconnect/qcom/msm8939.c b/drivers/interconnect/qcom/msm8939.c
index caf0aefad668..a7398c3c7411 100644
--- a/drivers/interconnect/qcom/msm8939.c
+++ b/drivers/interconnect/qcom/msm8939.c
@@ -5,7 +5,6 @@
  * With reference of msm8916 interconnect driver of Georgi Djakov.
  */
 
-#include <linux/clk.h>
 #include <linux/device.h>
 #include <linux/interconnect-provider.h>
 #include <linux/io.h>
diff --git a/drivers/interconnect/qcom/msm8996.c b/drivers/interconnect/qcom/msm8996.c
index 20340fb62fe6..733213a0b8c1 100644
--- a/drivers/interconnect/qcom/msm8996.c
+++ b/drivers/interconnect/qcom/msm8996.c
@@ -5,7 +5,6 @@
  * Copyright (c) 2021 Yassine Oudjana <y.oudjana@protonmail.com>
  */
 
-#include <linux/clk.h>
 #include <linux/device.h>
 #include <linux/interconnect-provider.h>
 #include <linux/io.h>
diff --git a/drivers/interconnect/qcom/qcm2290.c b/drivers/interconnect/qcom/qcm2290.c
index a29cdb4fac03..95ea1f6d25ba 100644
--- a/drivers/interconnect/qcom/qcm2290.c
+++ b/drivers/interconnect/qcom/qcm2290.c
@@ -7,7 +7,6 @@
  */
 
 #include <dt-bindings/interconnect/qcom,qcm2290.h>
-#include <linux/clk.h>
 #include <linux/device.h>
 #include <linux/interconnect-provider.h>
 #include <linux/io.h>
diff --git a/drivers/interconnect/qcom/qcs404.c b/drivers/interconnect/qcom/qcs404.c
index fae155344332..9292f8ac01b8 100644
--- a/drivers/interconnect/qcom/qcs404.c
+++ b/drivers/interconnect/qcom/qcs404.c
@@ -4,7 +4,6 @@
  */
 
 #include <dt-bindings/interconnect/qcom,qcs404.h>
-#include <linux/clk.h>
 #include <linux/device.h>
 #include <linux/interconnect-provider.h>
 #include <linux/io.h>
diff --git a/drivers/interconnect/qcom/sdm660.c b/drivers/interconnect/qcom/sdm660.c
index 7ffaf70d62d3..904014a9fd32 100644
--- a/drivers/interconnect/qcom/sdm660.c
+++ b/drivers/interconnect/qcom/sdm660.c
@@ -5,7 +5,6 @@
  */
 
 #include <dt-bindings/interconnect/qcom,sdm660.h>
-#include <linux/clk.h>
 #include <linux/device.h>
 #include <linux/interconnect-provider.h>
 #include <linux/io.h>

-- 
2.41.0

