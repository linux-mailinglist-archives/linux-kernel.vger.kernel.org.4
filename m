Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C03EE612C11
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 18:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbiJ3R5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 13:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJ3R5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 13:57:11 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8CD0AE6E;
        Sun, 30 Oct 2022 10:57:09 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id z97so14618750ede.8;
        Sun, 30 Oct 2022 10:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7mapbQ6IvGqWah0HR/O13e7IZQPvJmBvQBO0mfMDvXs=;
        b=fSfeZZGSaA0jvuVeMSVBagWEBerWxkzJjbzbDAQ72PMUHkGer604u9HFOPlo86qVJ0
         BWwa4d6WyorKEuRzzAqULGy2gbaTvhqzym+AX/JVmm8sV1hTmyx3fm79VEI5CbmTQJK2
         1qYFVOmQiYW8/vWqEUNbpcZfLvYSdOkt2O+b+ozWNITk0gY4DFpXzf9hcleXZJZfyzOh
         i6czL+EAzPV5/2TwDfnUwOG95yhIhahGLp3ZZMGYzV/XeMxfgNd12Q+qoLTMmVfTg/fV
         X/dRoKBdx40cCUO2xEB1QuMd82efAXlswE+hEtNuydysc2r9VGz1l3P/kXrGha4rrzDl
         Sw4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7mapbQ6IvGqWah0HR/O13e7IZQPvJmBvQBO0mfMDvXs=;
        b=GwGIcgBnyMI7lvuaQcksecDv8XzIuY6iR+Il3Q8auB1djHYfHzZ7sZ3xFlvf4ouXKy
         1TshsMG8obnI9gaApBZMwzDUCQ14yIjYawfK27d5eaX9Ndlpp7vNqAtVSJXsp4u15BaT
         VVD+3OpAWsVM5D+0ExEjY0FLyIFtLvmbCue5J779ACw1v7n52R3PXHpQfhEhfqUUsfqL
         EOFEyJ9a7MPFcieou02p739VmNLXVaoTypAoGlCIvybdogfrhIqB3CH94lZk+AajK1m3
         226O0rI23QyQW8zJYVVXN7ow0hii9fi3VwbJHgNzQbq80QBngPDq/qwAEKyZEHDy1eTz
         HV4Q==
X-Gm-Message-State: ACrzQf3wZtXQniYMJaxV7RZTKGjLGZXuhXtTyTKL0f45t2GEwsYEiuWd
        ALqWAwuDFyGs17sH+Y19ETg=
X-Google-Smtp-Source: AMsMyM5O//C43EyghhM9u3buQBAuZXj8tQTff4943Ui07aJ2mx4diCtpy0nqWT5c9DFlANjzbjVFRA==
X-Received: by 2002:a05:6402:2409:b0:456:f97b:3794 with SMTP id t9-20020a056402240900b00456f97b3794mr9747412eda.145.1667152628436;
        Sun, 30 Oct 2022 10:57:08 -0700 (PDT)
Received: from fedora.. (dh207-98-142.xnet.hr. [88.207.98.142])
        by smtp.googlemail.com with ESMTPSA id b24-20020a17090630d800b0073de0506745sm2053029ejb.197.2022.10.30.10.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Oct 2022 10:57:08 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@somainline.org, mturquette@baylibre.com,
        sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, tdas@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH 2/3] dt-bindings: clocks: qcom,gcc-ipq8074: allow XO and sleep clocks
Date:   Sun, 30 Oct 2022 18:57:02 +0100
Message-Id: <20221030175703.1103224-2-robimarko@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221030175703.1103224-1-robimarko@gmail.com>
References: <20221030175703.1103224-1-robimarko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow passing XO and sleep clocks to the IPQ8074 to avoid having to do
a global matching by name.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 .../devicetree/bindings/clock/qcom,gcc-ipq8074.yaml    | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-ipq8074.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-ipq8074.yaml
index ac6711ed01ba..a190523a8c25 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gcc-ipq8074.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc-ipq8074.yaml
@@ -24,6 +24,16 @@ properties:
   compatible:
     const: qcom,gcc-ipq8074
 
+  clocks:
+    items:
+      - description: board XO clock
+      - description: sleep clock
+
+  clock-names:
+    items:
+      - const: xo
+      - const: sleep_clk
+
 required:
   - compatible
 
-- 
2.38.1

