Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6362662B777
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 11:15:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233485AbiKPKPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 05:15:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232882AbiKPKPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 05:15:15 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E3F31F2ED
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 02:14:49 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id g12so28872261wrs.10
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 02:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/9lifyfXA295mihX2r7vWA6JAuXbVFTG/mVbl2IkBKU=;
        b=KMkZzUofwqTd9LIIitc8I0NW6vOWh6qpfD/qHYkkIUNJLA2CRW3QWmjDE/htYfH/cJ
         kTHTtufaDXfuTf6tScKzbujOzseqjn9ApuFTvUq83EqQHBYQDfREO1E2UrWpPMK44seF
         32NHqFDEojsnbD8rOH6HjYSPTT9kZwqQXrcegs5gaLzOYVGugHbu6lxFBzYFwmJtoWgT
         HVVbnYgirsvZPsX+HtuI7bqjq5xBRrluuPy/4/UrXHFlQfGO7rOztnfe0HYS6N3Pd4ws
         6CbV8k8B50nSdB5Y/ztC/5Z1oLd2a9Ysjya0BRuEUs6z0Awj5aX9W8h/ekI8xPkru7Dx
         Ad8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/9lifyfXA295mihX2r7vWA6JAuXbVFTG/mVbl2IkBKU=;
        b=q/+24mVB0VYzGTQ7a2yaMYLCYY0ZL92pEix2CasbWSNP6HYQfaIJpgyUEesR3Efh6n
         JNfztAD2Zw2TQnG+ggqP6KzQGGufgT1uFWE9z2hC/vWvFlhnlTivb9WwfhntklBApStc
         kwIaqekxbleSWQCsWnCvCtI/9hn3wLzf8M1Xy+joTIq/3kKTF8Tow306xrCf7lP1aXwr
         Poc/h5y/9jNjstKYXYjOrekjS3chRN4u9oclSbw6D1Ktelgv7opbjHaWcogpMPblmsn/
         hDtjV69NvXIf0rMDxJJ3bST9xtou++hFYpOTVp8mtOWe1ALMtUY0XYfwx4mlSpgPtHMm
         eaIA==
X-Gm-Message-State: ANoB5pkT881pVppUu4alFSPXfFpCkl5bRCMiroXJKUQW8VgPe4q1nn6c
        3Z/6Sba1BmdrQH1oIekG6NZUQg==
X-Google-Smtp-Source: AA0mqf4e4tYIJodK7l0wsRLg5MahI7aiIc6YIhTLZrAkqE183FudMIcJ/Jxj3OoiNP3lMP1xqYeQ9Q==
X-Received: by 2002:adf:f211:0:b0:23a:43b7:cdd5 with SMTP id p17-20020adff211000000b0023a43b7cdd5mr13193768wro.387.1668593687630;
        Wed, 16 Nov 2022 02:14:47 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id f23-20020a1c6a17000000b003c65c9a36dfsm1454970wmc.48.2022.11.16.02.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 02:14:47 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 16 Nov 2022 11:14:45 +0100
Subject: [PATCH] dt-bindings: interconnect: qcom-bwmon: document SM8550
 compatibles
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221114-narmstrong-sm8550-upstream-bwmon-v1-0-b6dd08927f35@linaro.org>
To:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        Georgi Djakov <djakov@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.10.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This documents the compatibles used to describe the Bandwidth Monitors
present on the SM8550 platform.

A BWMON v4 IP monitors the CPU bandwidth, and a v5 does the LLCC
bandwidth monitoring.

This is described this by adding "llcc" and "cpu" into the compatible
strings to differentiate the BWMON IPs.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Andy Gross <agross@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@somainline.org>
To: Georgi Djakov <djakov@kernel.org>
To: Rob Herring <robh+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-pm@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 .../devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml         | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
index be29e0b80995..00b635662697 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
@@ -26,8 +26,13 @@ properties:
           - enum:
               - qcom,sc7280-cpu-bwmon
               - qcom,sdm845-bwmon
+              - qcom,sm8550-cpu-bwmon
           - const: qcom,msm8998-bwmon
       - const: qcom,msm8998-bwmon       # BWMON v4
+      - items:
+          - enum:
+              - qcom,sm8550-llcc-bwmon
+          - const: qcom,sc7280-llcc-bwmon
       - const: qcom,sc7280-llcc-bwmon   # BWMON v5
       - const: qcom,sdm845-llcc-bwmon   # BWMON v5
 

---
base-commit: 3c1f24109dfc4fb1a3730ed237e50183c6bb26b3
change-id: 20221114-narmstrong-sm8550-upstream-bwmon-a7c6227fab6d

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>
