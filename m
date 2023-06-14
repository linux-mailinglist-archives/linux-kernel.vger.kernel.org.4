Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A87767306F5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 20:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240595AbjFNSFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 14:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236115AbjFNSEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 14:04:50 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 879E92686
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 11:04:46 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f764e9295dso1827307e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 11:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686765885; x=1689357885;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8XUok3dbfSBKK4OnUZpMrrh2fJAxKXR9JHbUiXx4CDw=;
        b=aN2mbhjoi0R0yZHc18kKZl+9mthA8tK+nD1YxdGpaaP6NrH+Ea6is9vFNBLf9ttzHR
         z0qv3ZjpfHAsO5U7UDuL8SjLPUzuEfAoczzCwfp7ne2WxOOtNuWhEJQt23+L/pSaJTIk
         Evv91O9oKLXuAn1Fnz3Uq69VaLe20aYxZ1Cts/JlFHtFCTF3sx9pTH2cGwVd7BkIeWf7
         u2Z2HLXSM2TzghN48WMqmDpkOsyrxl65057waJTReuS1Fjpu1LuyaqdtCWmnplUxDdc4
         1oOJdlbKAEqAmZp5JnAgDGX8kAxU5ANfv14rSnzX3O35PCalX2MKwLT8OETO07dpp/Ej
         a3Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686765885; x=1689357885;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8XUok3dbfSBKK4OnUZpMrrh2fJAxKXR9JHbUiXx4CDw=;
        b=d9OEexTyMFaBmzqBFkMOFulF6M4mOEehaPG5Yj92/RPiVM5zNvawuVNqaPN9uvhJwr
         sm74CLsalr0zUlSUAobvTQMy+HqOLKqgLYEW9LHJ+yfgMSj5FaodLo7Wk0nlUIS608eF
         z7PjcNpffCg18ahvRfB9IhgervIsTi6kDHHWY6gPqgQt4ajDXHYrACD8LTLbYKz3Ajt1
         Q2yJe7OH1A6tC4fTNAKDl6EsrKpR3myhI8qOZvOkGgcrWQvcO/ph6mdjGIaV9G5yrS37
         WsJOZRuWLRktIuFog9DbL5BIFqperYS2J8G/YUR7lRVvowdQi0c7Ua1QmmRjpXhy4d3u
         Kqqg==
X-Gm-Message-State: AC+VfDwUnB73fxUiaNBv3tfGVBc6IRHZmxysbdS+vfEYZ7PRFXK3KJ1v
        JZSGgf1hVLXTOjHJaI6/C0JNyw==
X-Google-Smtp-Source: ACHHUZ6lOc5/Wr+8/U1HtMmXOyxrDpCCHUq8E1D4j31612slS7CUKQEtQs1RVy9W7FpF6xhUZqjVlw==
X-Received: by 2002:a19:6601:0:b0:4f6:5bf2:63bc with SMTP id a1-20020a196601000000b004f65bf263bcmr7705909lfc.3.1686765884831;
        Wed, 14 Jun 2023 11:04:44 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id l18-20020a19c212000000b004eff1f7f206sm2224053lfc.9.2023.06.14.11.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 11:04:44 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 14 Jun 2023 20:04:26 +0200
Subject: [PATCH v6 07/22] interconnect: qcom: Add missing headers in
 icc-rpm.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230526-topic-smd_icc-v6-7-263283111e66@linaro.org>
References: <20230526-topic-smd_icc-v6-0-263283111e66@linaro.org>
In-Reply-To: <20230526-topic-smd_icc-v6-0-263283111e66@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686765872; l=3985;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=cyjuO3H/NwWuCUlv2vJ6Jn9ceZQeEKzsmbMZaK77x5A=;
 b=nzv+1Ar7IMMFT418Xy6pUo4GIYhu3uf2Bg3gE7654/sVi0xe1701cdSvjgJ/p6vvKBQ8YTN9U
 whxFQ0ai4GoBXbSp0SMh1k2aKY+tlf6U0zgiE+9TUD7L/lWkrrWg+MK
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
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

