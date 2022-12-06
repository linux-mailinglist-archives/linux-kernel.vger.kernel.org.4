Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0987644444
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 14:13:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234232AbiLFNN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 08:13:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232910AbiLFNNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 08:13:23 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37446FE8
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 05:13:19 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id n20so6196882ejh.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 05:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=waK5wVs7Hxj63T++mcTd6rjgYYGu6Rza9RGnKsblQEs=;
        b=niKqtwuaWlQb3rLWh9RCIXwrWcM1X7wcXX8sFCXeWKEo2+cknQEezsEReW0rkqCXs4
         uOiLGajNxPH+lCyHXsjAC/5PlFFEfI4UYYNfhRW+tX+dBojTu/OvBsLd7S0BKjn7KmdN
         q0JL58Cn4h1WZk3ICAducmE7gAJOAm2HgAcv77Li421Lp1HrlUsss75jRPMWhbdpx+HY
         AX0VHjdTzmGB+iRLxCOLnEBc1Ee6+p/FYoC5Ow87TzSTiRKhzXUeCStA1qBMR498ajDr
         m/WwuHCmqDaguzQUzrehyr2/u49galDzxR4lWHH1Gu8nlAtgRvuRTpvVx8fwlH8anw/Z
         I+DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=waK5wVs7Hxj63T++mcTd6rjgYYGu6Rza9RGnKsblQEs=;
        b=rkn0PW0exAwZcovgG1QCGQwnwuiTbghGq1lRGBlvQMUajrzSZGlJijPuLC1Y8Mpdqh
         4SNLUsTl4Chz/X0XPLrXOaSQtvLJhKsyRK9qSrHGPdD6fYNKQcLqhpl8uAsmZZMutt3C
         /9q05E+zK6BACRz2qU6VhNbwKmDWzEbSyvAKBGBuZYmktzb2NkzSF6ZB3UOWHNqDtyv4
         Woj1Ukst36I7QpQKuvdNZw4rks6tgCuxAA4dv7APTy6+ZeChPT1gCm7nz8CRnx2Qzp1b
         7TLDqDEAg7tkVYPGDLC8NxdjjYL0c9+TYu3aY8FhCiO6eOcKPzbt646NhqGVPHwg9DnG
         /7GA==
X-Gm-Message-State: ANoB5pkBH+rs0DOA06m02tPwj5m2IOfmsvc2G5BUpUV8vg79Dh8a694s
        PPTWiepg0chI6SiHMQUlKnH2CA==
X-Google-Smtp-Source: AA0mqf7GQks6TOa/S7MfS8ycM00S8bWeX9oR/ff5ocCZZtQhgemy1sWKDGWB5bfR1MDzlr242+1POQ==
X-Received: by 2002:a17:906:99ca:b0:7c0:a087:152d with SMTP id s10-20020a17090699ca00b007c0a087152dmr22320661ejn.681.1670332397760;
        Tue, 06 Dec 2022 05:13:17 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id u2-20020a1709061da200b007b8a8fc6674sm7345775ejh.12.2022.12.06.05.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 05:13:17 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v6 01/10] dt-bindings: arm: qcom: Document SM8550 SoC and boards
Date:   Tue,  6 Dec 2022 15:12:43 +0200
Message-Id: <20221206131252.977369-2-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221206131252.977369-1-abel.vesa@linaro.org>
References: <20221206131252.977369-1-abel.vesa@linaro.org>
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

Document the SM8550 SoC binding and the MTP board.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 463509f0f23a..4f0aa06402bf 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -68,6 +68,7 @@ description: |
         sm8250
         sm8350
         sm8450
+        sm8550
 
   The 'board' element must be one of the following strings:
 
@@ -819,6 +820,11 @@ properties:
               - sony,pdx223
           - const: qcom,sm8450
 
+      - items:
+          - enum:
+              - qcom,sm8550-mtp
+          - const: qcom,sm8550
+
   # Board compatibles go above
 
   qcom,msm-id:
-- 
2.34.1

