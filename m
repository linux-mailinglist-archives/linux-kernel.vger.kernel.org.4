Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 606F864B52D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 13:29:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235713AbiLMM3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 07:29:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235689AbiLMM3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 07:29:14 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8192F1E735
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 04:29:09 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id q71so10305789pgq.8
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 04:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LBSaUOf/FOXjpduzpGni2TWWI73cP1UCmnduItbfteY=;
        b=M6jdbx3UEtOLNv1TCQ8ZU7Ltuxquu9wznOHIL5W+g/fR6wb2li11OuoOKwHQUGb2R1
         0DnWBPtlmw4QR01QGd8ydt+yddvN4oeGU9oruEqujsjwlSWjjfz6WAEu79APGb7YLazD
         S6g7MfgB/rqC1QK1Mc18NqtrIFE2MdbJSXtzlLn53BtBAW1eUQNXavGo7hXk80evtram
         2krFJcndbreobqQCm/3hCztVTX/az8x2qPTtaxyDk6HdkRtGR8f8e/4l//4NZBZ2Zfwh
         eW1pXjmeXsJ8uDS86yBcuQXo08kHgdtIxPnto6s1z9re3Ekx1PBN7nZbSLDtjAO78Rpk
         H8XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LBSaUOf/FOXjpduzpGni2TWWI73cP1UCmnduItbfteY=;
        b=htPNYL9DsRz6hRQJRKePLwerud49OtZddNbaGh7+5V2e4YfNZSuUtUzRv9ChzgdMkD
         xueZL+cbUab9ejlp6HEBv730lvmCptEnev/PH2RD/uMj3v8LrN7OYoc7lNzzkclPvWtp
         reu1V4PEMQwLvE9JnC0m1wblJV5c9bR7AuPo1q2B90a/H1M2plR1C/l/SOEZMDSCnp6b
         2WTe56i6CIDLwwmExt2kQ1zjYSQBvXF3Sw8UT6MgemPe3KnzvHpeQ7DAZ34GRB7+lKFg
         lUXxvWN1xqiqpPXCGJMHIDtazIuUlZ5co5ZwudTzTLrIk2g4HLTJPABi4gra/D4kEI7H
         NgAA==
X-Gm-Message-State: ANoB5pm9ZcAWg36ZUirw2fnyQ8SugVME4zIYlst8W2St8cV6RNjmqJis
        qwyZl2QCjDp9+yH0kdShg9aAkg==
X-Google-Smtp-Source: AA0mqf7BO1EVW5IGhG8M4Hn3DldsiAJ5jDyFLHGbHZKjQ+RphrRMyysb1i88RjapbbhyVL32nVyxrg==
X-Received: by 2002:a05:6a00:1c89:b0:576:e33e:cd63 with SMTP id y9-20020a056a001c8900b00576e33ecd63mr18521486pfw.30.1670934549180;
        Tue, 13 Dec 2022 04:29:09 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:1c60:4bad:5c3:ab51:3d81:6264])
        by smtp.gmail.com with ESMTPSA id y10-20020aa793ca000000b0057555d35f79sm7602468pff.101.2022.12.13.04.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 04:29:08 -0800 (PST)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     vkoul@kernel.org, linux-phy@lists.infradead.org
Cc:     shawn.guo@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, agross@kernel.org,
        bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski@linaro.org, andersson@kernel.org,
        konrad.dybcio@somainline.org
Subject: [PATCH 1/3] dt-bindings: phy: qcom,qmp-usb: Add SM6115 / SM4250 USB3 PHY
Date:   Tue, 13 Dec 2022 17:58:41 +0530
Message-Id: <20221213122843.454845-2-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221213122843.454845-1-bhupesh.sharma@linaro.org>
References: <20221213122843.454845-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dt-bindings for USB3 PHY found on Qualcomm SM6115 / SM4250 SoC.

Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 .../devicetree/bindings/phy/qcom,msm8996-qmp-usb3-phy.yaml     | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-usb3-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-usb3-phy.yaml
index 0c6b3ba7346b9..e81a38281f8c5 100644
--- a/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-usb3-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-usb3-phy.yaml
@@ -30,6 +30,7 @@ properties:
       - qcom,sdm845-qmp-usb3-uni-phy
       - qcom,sdx55-qmp-usb3-uni-phy
       - qcom,sdx65-qmp-usb3-uni-phy
+      - qcom,sm6115-qmp-usb3-phy
       - qcom,sm8150-qmp-usb3-phy
       - qcom,sm8150-qmp-usb3-uni-phy
       - qcom,sm8250-qmp-usb3-phy
@@ -253,6 +254,7 @@ allOf:
           contains:
             enum:
               - qcom,qcm2290-qmp-usb3-phy
+              - qcom,sm6115-qmp-usb3-phy
     then:
       properties:
         clocks:
@@ -321,6 +323,7 @@ allOf:
               - qcom,sc8180x-qmp-usb3-phy
               - qcom,sdx55-qmp-usb3-uni-phy
               - qcom,sdx65-qmp-usb3-uni-phy
+              - qcom,sm6115-qmp-usb3-phy
               - qcom,sm8150-qmp-usb3-uni-phy
               - qcom,sm8250-qmp-usb3-phy
     then:
-- 
2.38.1

