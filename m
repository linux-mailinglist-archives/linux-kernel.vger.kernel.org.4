Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DEA161299D
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 10:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbiJ3Jnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 05:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbiJ3JnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 05:43:11 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F37BE0C;
        Sun, 30 Oct 2022 02:43:09 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id bs21so12098086wrb.4;
        Sun, 30 Oct 2022 02:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0isp5Nh3x+mDnBNT4ggWZavrByNMZ7wrWYq2EVps+II=;
        b=Dfq/bh4RgZANe0vsFxdIhIGHHIbNWcDBM21/QAw+9BtrXEcrpOd/T6c/addGO1YvxX
         AYMHUfZ5PdkhbHsPKgOwmBfT3rgwaXvl80Jk1VMoKORWlxCaxsOhUFGYjG4JXdoSZbRo
         zzxdqgDQsHV/AQ8yFw0vYGgrZm4cw/UWyS1PtPwGKA8GP8fbUChR9/vbtMaNY3JBwKZL
         oBMIJXHs2ffZSY6NKbhxubPywxnqmiXZ5YnB9x0xVv12P4ZO4rseF5NOo4/oreWMwc2S
         O+zsICOwmhRF3TeUDEBopYym/NdEE+zWWy+8mJKb/4gdyy1Gl3blLlvpWYOCbRnhBQTT
         MqOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0isp5Nh3x+mDnBNT4ggWZavrByNMZ7wrWYq2EVps+II=;
        b=yOp+9uBuv6YKFjDCneBbhbEQ57rOB6WLM3NQ4MpF1iCTXfVTU/ayp2iDu0tTccmch3
         ogjNX55etlZHFUm85JMdydIoMBcsMNka6ZJtwG3kXSnXwThE5eqHN0xSSOdWjoqSBpMV
         WwWEXquUSnzhqJsghrXj6wk+x3ii7eJOKaMcFRp8M1Ptzd0JUQUvQ2/Mjs9XlJoQeXd5
         jPKg0escVb5ZadM6930QHVo4I36PICwxjURCMQGuv1RBzculA9W2eDn1OQUxUSmYABYI
         NkG8DrMHnT4vvIdsnCPmI/bEGj2GUC5MqNLM2t7ETTt9m24oferWehwvcLiG759Elmbo
         zh6g==
X-Gm-Message-State: ACrzQf3oUmz7s+Ydxf1+rWtd9bLnPELDd4TxCgjLWCMafKeUVeIDNAKB
        N9OT/7PV9tg6u8HOmeSQ3lw=
X-Google-Smtp-Source: AMsMyM4spSBKDGj4gqKe2xs0zuyHoPmOMeM1DEguUXfMZg7fr2quzYCaI2CVyHcxCjPfahuFVEad+g==
X-Received: by 2002:adf:d1ea:0:b0:236:777d:74fd with SMTP id g10-20020adfd1ea000000b00236777d74fdmr4561526wrd.657.1667122988268;
        Sun, 30 Oct 2022 02:43:08 -0700 (PDT)
Received: from localhost ([77.78.20.135])
        by smtp.gmail.com with ESMTPSA id bg14-20020a05600c3c8e00b003b497138093sm4068150wmb.47.2022.10.30.02.43.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Oct 2022 02:43:07 -0700 (PDT)
From:   Iskren Chernev <iskren.chernev@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Caleb Connolly <caleb@connolly.tech>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/8] dt-bindings: arm: qcom: Add compatible for oneplus,billie2 phone
Date:   Sun, 30 Oct 2022 11:42:52 +0200
Message-Id: <20221030094258.486428-3-iskren.chernev@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221030094258.486428-1-iskren.chernev@gmail.com>
References: <20221030094258.486428-1-iskren.chernev@gmail.com>
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

oneplus,billie2 (OnePlus Nord N100) is based on QualComm Snapdragon
SM4250 SoC.

Add support for the same in dt-bindings.

Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Caleb Connolly <caleb@connolly.tech>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 207e28260206..7048a1fd77a7 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -54,6 +54,8 @@ description: |
         sdm845
         sdx55
         sdx65
+        sm4250
+        sm6115
         sm6125
         sm6350
         sm7225
@@ -708,6 +710,11 @@ properties:
               - xiaomi,polaris
           - const: qcom,sdm845
 
+      - items:
+          - enum:
+              - oneplus,billie2
+          - const: qcom,sm4250
+
       - items:
           - enum:
               - sony,pdx201
-- 
2.38.1

