Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53F576F25FD
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 21:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbjD2Tdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 15:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbjD2Tdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 15:33:43 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D7201731;
        Sat, 29 Apr 2023 12:33:40 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-50bc0ced1d9so301419a12.0;
        Sat, 29 Apr 2023 12:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682796819; x=1685388819;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ls6sJL2aXmHZRlo+OUGjxcr6tdIOlt1Pi83WHloB3a0=;
        b=faXO8NUymK5E53jWFOewVxALmZ6qGoRHJWr1xH4xeSQK4XaamPKc8l6kcmgw+KGo5X
         dcv8+tTHlJZXmgvIgUweUvg0uvNlG6WFDV4djL4pc5mYdyF1jqXKPWJbJYukSasps/2t
         s1/0MWpOZEJcDNgugEEhdH10F2bmTp+u0ZNzYMlMZFbhL+eUgqOiHTE03iy+H2XgXwyl
         wBek6hzvrWiP7m1D/nJjcmWgXFHfho12EoapDTJG6ILuanhVSGRSeMujgYG0TBXeLW/A
         70KH3oThaTY4l85lGjInGOZX0px8rTkzrngel56W5TabPiotf21M5nMoqUPR4CoC9iSv
         mfew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682796819; x=1685388819;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ls6sJL2aXmHZRlo+OUGjxcr6tdIOlt1Pi83WHloB3a0=;
        b=eQbt6R7u1JWivktwS071u1jMPVpjPQX00fnYryifzmsx+DaoZ69yCOkgnP5ZLnwQHx
         fMv3zwlACjyGrNjeJJishQtJS+9yf0ks+3OIdXMrT4PvFldNsQC109SCf7uy4rVapZRw
         Lx2YIkkf7ZbrGL4SZbHK+YaPk5dRMBQalyk0y5pICKY0c76I86ubpW4TNdUSIbp2/ImB
         2GeXrk+LFfA8pYIvwjsICBeEfNqdJl6z6Z+a5DgPlKBUewhk7DFGmjLYbxIb/VOmdwV4
         L5MglPk5/CtHyza5a8NZO6MU0luT1UZDHflKfMV2aEkYpmjfWdR8HmRdHvRi2eyl+X4B
         HWUA==
X-Gm-Message-State: AC+VfDy2kVs+3w6+OKKckVdWExuUqUZCXlMeH1Vt0H/U1/LZKQDP9qAI
        SY9vz104xdg/k3go6MLdlmN1TqtAHyXkjQ==
X-Google-Smtp-Source: ACHHUZ7esGM0uWrCMqTjKfWnChxjuRKwrHMofdgZ1MWGHjdpiSto6JwDLGZBsB0qERDJ7IFwIgQO+w==
X-Received: by 2002:a05:6402:b09:b0:506:b209:edb with SMTP id bm9-20020a0564020b0900b00506b2090edbmr1898590edb.38.1682796818673;
        Sat, 29 Apr 2023 12:33:38 -0700 (PDT)
Received: from fedora.. ([188.252.220.213])
        by smtp.googlemail.com with ESMTPSA id q19-20020a1709060f9300b0094f1fe1696bsm12832126ejj.216.2023.04.29.12.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Apr 2023 12:33:38 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH 1/2] dt-bindings: arm: qcom,ids: Add IDs for IPQ5018 family
Date:   Sat, 29 Apr 2023 21:33:35 +0200
Message-Id: <20230429193336.600629-1-robimarko@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SOC IDs for the IPQ5018 family.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 include/dt-bindings/arm/qcom,ids.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/dt-bindings/arm/qcom,ids.h b/include/dt-bindings/arm/qcom,ids.h
index 802495b20276..c1283bad81e1 100644
--- a/include/dt-bindings/arm/qcom,ids.h
+++ b/include/dt-bindings/arm/qcom,ids.h
@@ -216,6 +216,9 @@
 #define QCOM_ID_SM8350			439
 #define QCOM_ID_QCM2290			441
 #define QCOM_ID_SM6115			444
+#define QCOM_ID_IPQ5010			446
+#define QCOM_ID_IPQ5018			447
+#define QCOM_ID_IPQ5028			448
 #define QCOM_ID_SC8280XP		449
 #define QCOM_ID_IPQ6005			453
 #define QCOM_ID_QRB5165			455
@@ -229,6 +232,9 @@
 #define QCOM_ID_SM8450_3		482
 #define QCOM_ID_SC7280			487
 #define QCOM_ID_SC7180P			495
+#define QCOM_ID_IPQ5000			503
+#define QCOM_ID_IPQ0509			504
+#define QCOM_ID_IPQ0518			505
 #define QCOM_ID_SM6375			507
 #define QCOM_ID_IPQ9514			510
 #define QCOM_ID_IPQ9550			511
@@ -236,6 +242,7 @@
 #define QCOM_ID_IPQ9570			513
 #define QCOM_ID_IPQ9574			514
 #define QCOM_ID_SM8550			519
+#define QCOM_ID_IPQ5016			520
 #define QCOM_ID_IPQ9510			521
 #define QCOM_ID_QRB4210			523
 #define QCOM_ID_QRB2210			524
@@ -243,6 +250,7 @@
 #define QCOM_ID_QRU1000			539
 #define QCOM_ID_QDU1000			545
 #define QCOM_ID_QDU1010			587
+#define QCOM_ID_IPQ5019			569
 #define QCOM_ID_QRU1032			588
 #define QCOM_ID_QRU1052			589
 #define QCOM_ID_QRU1062			590
-- 
2.40.1

