Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5034672B237
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 16:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233907AbjFKOFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 10:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233888AbjFKOFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 10:05:03 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D854635A2
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 07:04:19 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f736e0c9a8so25077945e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 07:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686492247; x=1689084247;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RvfQYL4A20SJQDyiK6aToGAElH2kc3t49iTWsilqcPE=;
        b=Ru4X/SLWgl1KG2MLwTZZiclshlnPZS/CxKmis33VctIkQZcLq/p2yj0O53Doypn+pS
         XYcTXSmGj2+xGzCaOt2Ziw1ZqOb0vD/wLitKqUtCuk/oI2Etml68wTvl5VAKw8+5+Wdz
         eNr3v1GGCETLlGuGIllgGELKTwV5lLCnxHUGta0sEl2lM8m5cOM7SKP0GPzKu7C2FEMh
         ti0Syg2ixNB/Pa8IpmOM19Gf7NaPchjcE3s/P0Q/qfpkAO0SBhVcELlnQV77zYCDlCCM
         DkruC/Z5jAeB+qEWfIMEJaq9/EDj/QILKHK6oH6braydubic4zVAJE5oPYBR0DR/Rg7D
         tJJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686492247; x=1689084247;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RvfQYL4A20SJQDyiK6aToGAElH2kc3t49iTWsilqcPE=;
        b=SppxkXT/vABBl75Ee7PdEye8+VBwBgOHITF07HuhV+C992NHbk1NsMRjykEZ/o0kju
         B5UMtEmcuWzZDfv4YUzDuIyP3xoIDkk4sGeED9llhVJu7CI12t8owOZhGo/bZXqnWJyY
         3eOS9akgQ9VcDyyExuJiuNlIQ04zHYCsDeZsjNCsJ9JIuE333ME1xc1m3fbdt4dmpK0G
         faB5P+BNQyKakDlqwIRaHWPI4SwDCUHc6ocmRHQ28iuoOIpHHo3zUhmlxkTigDydKJuA
         cTLelBumY+mwLwYDgtrHuUbHWI7oco+uyHnXLDGbedzFsBaj6RhXSTQyErmpgxRm5ng2
         aqCQ==
X-Gm-Message-State: AC+VfDxyJq3O/jnZQyFHOOLE0KAEZr358+epsmQa3TPSG0GBS6IlNNUS
        +IyJi/M3ljNM57oPLYyXYD2SdA==
X-Google-Smtp-Source: ACHHUZ5PbGStByBIKspEWp4m2COCe6FboeglIlXAvfQ3tOH1PN58bxFg0UgFuUMqP+FtgLyCpPOiiQ==
X-Received: by 2002:a05:600c:2059:b0:3f6:2ce:caa8 with SMTP id p25-20020a05600c205900b003f602cecaa8mr4453695wmg.29.1686492247131;
        Sun, 11 Jun 2023 07:04:07 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id h17-20020a05600c28d100b003f080b2f9f4sm8567222wmd.27.2023.06.11.07.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jun 2023 07:04:06 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 17/26] dt-bindings: nvmem: socionext,uniphier-efuse: drop unneeded address/size-cells
Date:   Sun, 11 Jun 2023 15:03:21 +0100
Message-Id: <20230611140330.154222-18-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230611140330.154222-1-srinivas.kandagatla@linaro.org>
References: <20230611140330.154222-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Referenced nvmem.yaml schema already defines address/size-cells, so
remove redundant entries.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../devicetree/bindings/nvmem/socionext,uniphier-efuse.yaml    | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/nvmem/socionext,uniphier-efuse.yaml b/Documentation/devicetree/bindings/nvmem/socionext,uniphier-efuse.yaml
index b8bca0599c45..efccc5aacbe0 100644
--- a/Documentation/devicetree/bindings/nvmem/socionext,uniphier-efuse.yaml
+++ b/Documentation/devicetree/bindings/nvmem/socionext,uniphier-efuse.yaml
@@ -14,9 +14,6 @@ allOf:
   - $ref: nvmem.yaml#
 
 properties:
-  "#address-cells": true
-  "#size-cells": true
-
   compatible:
     const: socionext,uniphier-efuse
 
-- 
2.25.1

