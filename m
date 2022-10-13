Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E94C5FD6CC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 11:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbiJMJOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 05:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbiJMJNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 05:13:44 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A88615E0F0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 02:13:37 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id m15so1682052edb.13
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 02:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+dzrAn+aBg/5KVcVy/4aX4joCWNIa7ky5mt/LVd7Cts=;
        b=EpOkGGCsgHYv53DtFoFfROkk3L70Tad3Fr98hzdLPuGpB67l/RLNzEBfk6W4b2EshY
         heegHPUgBEw1hcrGaYOATLKXTKvem4g5S6Lb3RMMoJufXUlAxAamcbyAY13lmYodkLeX
         u6SHw0M8I7LxbQAztnvDt2hOo8zLTOKUeT3zGoM3n/MiiwU1TLm72iCfKo3Btj9qeuSr
         SBtQffQhJawJuoSnXkJ1hYdSEIdN4zYqlp7AE4TyZ6Uby+P2Wr9cbdnQTBDBexZGQ/AZ
         Jd7XJ53v38BYyjY0H+QHMPGtwcluNUpf4di0GT/wReLKc0mWX74+PHtfMGqv0efLG7Bo
         t5yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+dzrAn+aBg/5KVcVy/4aX4joCWNIa7ky5mt/LVd7Cts=;
        b=XUjyxDDBohJk/nUHZwFIX5FQkn59w0OYLhd/I6DT9NF7854H4RYIxY+kSQOn44vH96
         9oRtEl4Zl0Ar06R5ey1wGkbhNK4Je1KquHjTk/c8v32uVbaQP/bzHEJR+h8No8YvFGk3
         qLJmxRPPMS3dP6I0OtSqjHkALTHRLeHJeA9vgegvv0RrJjGcEEMC33viSTLgls4/3uBx
         XS9NaKaYD829r067p68+02p4eEBgoegPn8MxM/g8GHrj+PDly6Nks8Bcc14GbsojQDJr
         cjKQMPZAlF0ogThT6zuuBKJ7VAUROB1q0GvFfcS2yH5zwCNu8911e8jDrScSLd5J4jF2
         Yyug==
X-Gm-Message-State: ACrzQf2qTHwULmmQ4B7S7wsJn5oeDo4/VnJcs+6VuFVqkiaTfUoFAcl5
        L54ZehPO7rSpAQVJ3znakrwGlA==
X-Google-Smtp-Source: AMsMyM5p8hsyMuf8fEG6NDPh7dYuTrJBp5jGeer89w4o0UR99iwkf54abNti1vvH5DL5t0oMqY+4Dw==
X-Received: by 2002:a05:6402:5510:b0:459:5ea:9bc0 with SMTP id fi16-20020a056402551000b0045905ea9bc0mr30068091edb.152.1665652416151;
        Thu, 13 Oct 2022 02:13:36 -0700 (PDT)
Received: from otso.. (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id ti5-20020a170907c20500b0073dd1ac2fc8sm2582725ejc.195.2022.10.13.02.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 02:13:35 -0700 (PDT)
From:   Luca Weiss <luca.weiss@fairphone.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Luca Weiss <luca.weiss@fairphone.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH] dt-bindings: qcom,pdc: Add missing compatibles
Date:   Thu, 13 Oct 2022 11:12:08 +0200
Message-Id: <20221013091208.356739-1-luca.weiss@fairphone.com>
X-Mailer: git-send-email 2.38.0
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

Document the compatibles that are already in use in the upstream Linux
kernel to resolve dtbs_check warnings.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 .../devicetree/bindings/interrupt-controller/qcom,pdc.yaml    | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
index b6f56cf5fbe3..94791e261c42 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
@@ -28,11 +28,15 @@ properties:
       - enum:
           - qcom,sc7180-pdc
           - qcom,sc7280-pdc
+          - qcom,sc8280xp-pdc
           - qcom,sdm845-pdc
+          - qcom,sdx55-pdc
+          - qcom,sdx65-pdc
           - qcom,sm6350-pdc
           - qcom,sm8150-pdc
           - qcom,sm8250-pdc
           - qcom,sm8350-pdc
+          - qcom,sm8450-pdc
       - const: qcom,pdc
 
   reg:
-- 
2.38.0

