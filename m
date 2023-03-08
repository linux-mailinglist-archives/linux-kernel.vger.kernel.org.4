Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 735516AFC4A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 02:27:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbjCHB1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 20:27:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbjCHB13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 20:27:29 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E39AA8E8B
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 17:27:22 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id j11so19420761lfg.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 17:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678238841;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BxX6ytF5vV2haMBbbATopMPJpuCTfp4xoThhVoED6NY=;
        b=XsPWrb7qwg36X8gOAdk5nbSCwjCLoldidAMWJ8y6YOntnYTAx8awHSyBiIeUJoo6Sb
         rknI5p+z/5gt0IQN7jAAbyvxJIY+CP8C0bsCNNzknae7wL4UqfBg4NhpQgfkEf/qZsZu
         UYyQGYjNieH0S+hnanQ4kb6j7zzZKLn9g2kzLs4mRUbuYc0ffkb7B4FG69sTw6HrG52k
         Ak6JmelRWqMFCEPTbpOaqEvkznXfQkNqb8WWjFMgR8ZCKw86xETdSOKHibTa2YK408VD
         Txex4E2BoQnXG5cVsPI5qzuDJHaiLAeSaBvfA/57h2k/VXmTlWUpU+bo+60PUayitN9+
         EJhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678238841;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BxX6ytF5vV2haMBbbATopMPJpuCTfp4xoThhVoED6NY=;
        b=352Lsqe67+S9YCOa/BlgXQyukSSpM5rtlMwK8dNO/U99CnEgDb5Sl4zietySVQSsy7
         6Dsm1BigK79a1SzrWgCXtLA6VYqkzzCYSG30fxaYfg4qgacpHx5z0iKv1ksG+eotr446
         NTGkOmgfpPoKhptaXBJ11t5FagOWVnoz639Opwv8i5eZvE+NyTVtE06vx/AKa7xtUUUr
         bJzN7slmPDd0hm8F9s4BkdNmxr+Q0Fds62t4XOS17xl5b+S2MiT9klJ6xfvksZW9ws3J
         FQN8Zzsi8YAqd5eG7fyg6JOJarJMWwUuJ0AkLaDGoN6EEMe075TXw7cHKLo8xa7qCklP
         gCpQ==
X-Gm-Message-State: AO0yUKWxnkw7yBtcTZc0WhBzAxGPFioR1YZN3N7i2hjQlAT/s7HJou/X
        GnpWE+NP+WzwL4vbwFi/8dxTUw==
X-Google-Smtp-Source: AK7set8nRqG/zwqw3xWTMNg4s7YVV/J+U18SMn5hQzgi1tYo0aIKS7l4ZMSSx7D1QVf79vJsvzNbrA==
X-Received: by 2002:ac2:5ec4:0:b0:4db:964:51b5 with SMTP id d4-20020ac25ec4000000b004db096451b5mr4774505lfq.41.1678238840930;
        Tue, 07 Mar 2023 17:27:20 -0800 (PST)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id o24-20020a056512051800b004a2c447598fsm2182944lfb.159.2023.03.07.17.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 17:27:20 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 08 Mar 2023 02:27:00 +0100
Subject: [PATCH 3/8] dt-bindings: cpufreq: cpufreq-qcom-hw: Add QCM2290
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230308-topic-cpufreq_bindings-v1-3-3368473ec52d@linaro.org>
References: <20230308-topic-cpufreq_bindings-v1-0-3368473ec52d@linaro.org>
In-Reply-To: <20230308-topic-cpufreq_bindings-v1-0-3368473ec52d@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678238834; l=1444;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=9z2kHs8CdaeUIwacH8QH3r7HmNxGQcozLnq7wS2qkKI=;
 b=oP67/Bvk4tJn5AV4vlOb6nR8o+XJy2Y2Uei5CEApKAObX7B/p8XJaTToI+9OxaJCl7bBj1tLNhRf
 V3BPavRbDEzZ0vy9jV/Peg+qnmtueF4/9qf9zwcUls8ane8t+flb
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the OSM CPUFREQ_HW present on QCM2290, featuring just one
lonely frequency domain.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../bindings/cpufreq/cpufreq-qcom-hw.yaml          | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
index 6f97e2effaca..dc4e497b15ac 100644
--- a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
+++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
@@ -21,6 +21,7 @@ properties:
       - description: v1 of CPUFREQ HW
         items:
           - enum:
+              - qcom,qcm2290-cpufreq-hw
               - qcom,sc7180-cpufreq-hw
               - qcom,sdm845-cpufreq-hw
               - qcom,sm6115-cpufreq-hw
@@ -92,6 +93,29 @@ required:
 additionalProperties: false
 
 allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,qcm2290-cpufreq-hw
+    then:
+      properties:
+        reg:
+          minItems: 1
+          maxItems: 1
+
+        reg-names:
+          minItems: 1
+          maxItems: 1
+
+        interrupts:
+          minItems: 1
+          maxItems: 1
+
+        interrupt-names:
+          minItems: 1
+
   - if:
       properties:
         compatible:

-- 
2.39.2

