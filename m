Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F60B62B77A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 11:16:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233134AbiKPKP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 05:15:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236891AbiKPKPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 05:15:33 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A2E2B276
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 02:15:27 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id j15so29125757wrq.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 02:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JFNBqUbq7QtJBrTFvdvHZDXMUJZQ6lA9hFG9lR0t9+Q=;
        b=EronlhrHxpZss+/Nij6KcTtyp8A6x7b6YP/pXKReUcgy4hEcDUH2YkNvOH4YPIInVa
         bcMaf87KToLk8RI8N9e4YCVGWkcotshZZjYgHvb5Qs1ABk3gXGbGNuxkWGKsHr2F/yAv
         vQ8HVsYfTnfRUYxp5C77jmE7w+WddGZwUP3NI+HI2STQWv1DtJgDPZhAZHLGVNtLlxiF
         B7klhlWB8ZxhqstTZr2hY3mslv1kipyOeaXiHVlU5Rn5Fmbx1Rky/Q7lTzLYCQ7oWFkx
         T3z9rIlPcNiDyfaWTKyE9q9GTO6JUhtTEdqe8eY5A39Fy05eFUMzJ0kX0gJzLFdPqaNE
         5zYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JFNBqUbq7QtJBrTFvdvHZDXMUJZQ6lA9hFG9lR0t9+Q=;
        b=6T2CST7gypTpERBf9slWWydAgv+ETzrU5KXPAzBHXm7OyyOkTRPyum1Qx3wgLV7yRq
         t3kOkJABG6ydUibZC43sjKDVrtiAeivPMfiJUmOVZHf1YTsJ+OuiW9VKZlHm3NIkr1Ub
         WCe7xMp1+zTTD4igYowne575773YdUP9g6a+hlqd50v/E7YGhlstwzxdPiA07P6NRINJ
         hROwbaWAUFxxQ1XFgo0N9gcVDfKidDSauyrQIiertwzGV52RkOWy/SNzKha+YjQBeFtD
         vrgbRSLAJmQCXtVTpbmTunCx80a/FvPxEc5WXqaT8rHr6mHEQTyag6K6HnCnBje2RzxO
         PErA==
X-Gm-Message-State: ANoB5pmxt1oSNTBjaqeHENRrPUtpn1lrhpOV1AwsLS+gXQwIU3hBXUL2
        cuxZy6Ba0qREeicNXz34zxE3lQ==
X-Google-Smtp-Source: AA0mqf7lEtfuHhZttiInCJa3i7vFKG84cjr+0N93WM/sR9X8A3fops/U1IJS2YSJlTTFA38xzfW7qw==
X-Received: by 2002:adf:dc09:0:b0:236:7180:6ccc with SMTP id t9-20020adfdc09000000b0023671806cccmr13581889wri.573.1668593726318;
        Wed, 16 Nov 2022 02:15:26 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id e17-20020a05600c4e5100b003cfa81e2eb4sm1718366wmq.38.2022.11.16.02.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 02:15:25 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 16 Nov 2022 11:15:24 +0100
Subject: [PATCH] dt-bindings: mmc: sdhci-msm: Document the SM8550 compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221114-narmstrong-sm8550-upstream-sdhci-v1-0-797864a30e71@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.10.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Abel Vesa <abel.vesa@linaro.org>

Document the compatible for SDHCI on SM8550.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
To: Ulf Hansson <ulf.hansson@linaro.org>
To: Rob Herring <robh+dt@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
To: Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc: linux-mmc@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Abel Vesa <abel.vesa@linaro.org>
---
 Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
index fc8a6b345d97..f0b7e6d0ecbf 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
+++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
@@ -49,6 +49,7 @@ properties:
               - qcom,sm8150-sdhci
               - qcom,sm8250-sdhci
               - qcom,sm8450-sdhci
+              - qcom,sm8550-sdhci
           - const: qcom,sdhci-msm-v5 # for sdcc version 5.0
 
   reg:

---
base-commit: 3c1f24109dfc4fb1a3730ed237e50183c6bb26b3
change-id: 20221114-narmstrong-sm8550-upstream-sdhci-1ae5ac4924e5

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>
