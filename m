Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E71885E9D7E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 11:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234586AbiIZJYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 05:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiIZJXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 05:23:00 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC6740E3B
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 02:21:14 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id t16so2683208ljh.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 02:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=0G2pbMxU8vGCC1MMlZuYFhTpkIFxDx19WgX6rPr/Aq0=;
        b=dvT0+gy0gmXjfCOmVfyF+XOnuISRIkYwxuW/cPRzpwz6ya4Bh+2E+vBc85iHv3oVln
         wf62LaofBHFVuX8n+Ch3sjfmCv8UxK9gYWWWakbSykQ61hoiN5e6ckY6C3SlF34vqSCG
         ZDqlslm0GTYNNGh/01q6rtmn3vvBClfh7yS26KV6kLS42mOgp7Bo1bKn7ujzuGqlwy2Q
         70g20UtQ3BLMC1+Qd5DQUvW2BO7/+eR8r9qK6aH00SJOUr+CEjwJmtRtJ9t46zcCJ2w6
         bS2CKkFePvgzUZ4+c3/z62OsIDcDanWKkC2riji2Vm22+m0PDAY2RKJPgYtNDJT5EFIY
         LnDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=0G2pbMxU8vGCC1MMlZuYFhTpkIFxDx19WgX6rPr/Aq0=;
        b=thNfqQtm08bVLoJFFnhQVLtHRvJIbVw5X0fo5A2ew6D2o+kqGyIRmyYsBw9RVyPqVS
         s2072dKdTS8LVRysRebZM8Cr/AcIcvwAZ3Mqr1aGsWqEEI8zVQg9uXkK4TaNfElL8bNz
         4dnfxPPFKx8swvJXvlz5YaOyFwTwVl4fdV6Ku/gXu+yY4xJsvSqBk7y2LsnAs2GvAYlw
         m/Cdd2GDs4WlhI1n+vJHmoQ9idEV6rVdu4Zp+oKMGy2y2m4B15gUHdluGWkF6pJaDNIU
         3ouiPXHf45FqsR+/6+6UdxvSJU99XpaeG44L1k4SfSSvEXw5z2A6tMYZAbcy+LOKq8LZ
         dLEA==
X-Gm-Message-State: ACrzQf3hnLB5qv+OpdeHwqQYRAJN69p+0yNBcdhb4uxmAJHIj0n17BF8
        PRNITXx8Jq1+kPawIhPvr8tpAg==
X-Google-Smtp-Source: AMsMyM5LZhPk4x5xA55E1XcpUjJ9qGHyCMPoGm7JGcnCwlwkniuiSTH0OyvWbq7Gezhq+c0rIiUqsQ==
X-Received: by 2002:a2e:3010:0:b0:261:bc8f:81e9 with SMTP id w16-20020a2e3010000000b00261bc8f81e9mr6924154ljw.61.1664184072471;
        Mon, 26 Sep 2022 02:21:12 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id g8-20020a2ea4a8000000b0026c3ecf9a39sm2325600ljm.38.2022.09.26.02.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 02:21:11 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [RESEND PATCH v2 1/4] dt-bindings: soc: qcom: smd-rpm: add PMIC regulators nodes
Date:   Mon, 26 Sep 2022 11:21:01 +0200
Message-Id: <20220926092104.111449-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Qualcomm RPM over SMD contains devices for one or two PMIC
regulators - already used in several DTS files.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>

---

Changes since v1:
1. Add Ack
---
 Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml
index 09d5bfa920f2..deccc637b6d4 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml
@@ -61,6 +61,11 @@ properties:
     items:
       - const: rpm_requests
 
+patternProperties:
+  "^regulators(-[01])?$":
+    $ref: /schemas/regulator/qcom,smd-rpm-regulator.yaml#
+    unevaluatedProperties: false
+
 if:
   properties:
     compatible:
-- 
2.34.1

