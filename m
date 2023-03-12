Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF4A26B69FD
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 19:20:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbjCLST7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 14:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbjCLSTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 14:19:31 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A425BCA5
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 11:12:33 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id h3so10389075lja.12
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 11:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678644650;
        h=cc:to:subject:date:from:in-reply-to:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=THHnNubc2+UuqNjcDLN8j6le5gzsAvvJJbRATCHsptA=;
        b=ccKQLWr93RGmfubqUbqId0AfsjKGIWsmNmOtAct8evWFaaGC1sS0rwruRbRA1mZYhG
         6vyaqykBtOSPHEmQgq8QkJv9E1xPJ39eHzM01arkGgexNszZljEFrhPPcumRMFoIrFw1
         /mKC7wGWEhVKDIIU83xjltWs4W+dwF4QuaI5eY7K+xuNf3AQFidvq5MLbr6Z5cw+RGCo
         YjU39WN9VzPQV72shLSMwMwAl6MhZILcNAzWdLYG3L7zoQwlkQoTf/r1tIFC+b2ufPqC
         TPTa9w2X1bBSNJ42X+zJ0K5Y0v/q/xZtpPS4FleghA0rJuour0zwRsIdxx2zpv0WltDs
         YpGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678644650;
        h=cc:to:subject:date:from:in-reply-to:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=THHnNubc2+UuqNjcDLN8j6le5gzsAvvJJbRATCHsptA=;
        b=GqHjA2J7wodwKp57d55afJ6y/QZHpm4Pt5M95VC58FVaQUu/sdbwmfQsq7ptGE3jiV
         M6fmzY6Xk+Y7RLR1Aj1dwo59lrhneUHrvt3UXtQElQM1Q7byo2QwMCZTx4jgzFNBgzO3
         DyQQMybkULeJlOOR8SIF0m3oAawZiDo2PgFeLm6RRurGMtl2+k8+v9njwbsXCNe+Anhm
         cUby8IdY2n/w6fjN0FR+zhc+FsixmL6HMth3nNVQ2zitmVjLIjvGLqOCDiVCHejVIasK
         TIE4uJ17OwHPN1RCW2AdOGBTck/J/T7wgU8/8yWmNNMqTjWwhVRTdq7YKLl5f9b4s8YY
         XYig==
X-Gm-Message-State: AO0yUKV9EMgbaklW+/YNHhE/RKixeRcQ97J3XBW3Te1WfwO9qzkvDkSS
        VCstNt9OTPiHfUWkI+FgKZ7RUVdHEhTw1JGW
X-Google-Smtp-Source: AK7set8eGYF5qmFsidkRuu7YaFndZOYl4nAShVPyrc9czFhErwRDah6/bDBns0+6znvwQm/Er5Jkhg==
X-Received: by 2002:a2e:b70e:0:b0:28f:265d:11da with SMTP id j14-20020a2eb70e000000b0028f265d11damr2545828ljo.13.1678644650269;
        Sun, 12 Mar 2023 11:10:50 -0700 (PDT)
Received: from 0001-dt-bindings-exynos-dw-mshc-common-add-exynos7885-var.patch (46-138-144-249.dynamic.spd-mgts.ru. [46.138.144.249])
        by smtp.gmail.com with ESMTPSA id z14-20020a2eb52e000000b002945bbb83b9sm721350ljm.89.2023.03.12.11.10.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 11:10:50 -0700 (PDT)
Message-Id: <1678644516.665314-1-sleirsgoevy@gmail.com>
In-Reply-To: <1678644516.665314-0-sleirsgoevy@gmail.com>
From:   Sergey Lisov <sleirsgoevy@gmail.com>
Date:   Sun, 12 Mar 2023 20:58:50 +0300
Subject: [PATCH v5 1/3] dt-bindings: exynos-dw-mshc-common: add exynos7885
 variants
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Jaehoon Chung <jh80.chung@samsung.com>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some Samsung Exynos boards using the arm64 architecture have DW MMC
controllers configured for a 32-bit data bus but a 64-bit FIFO. On these
systems the 64-bit FIFO registers must be accessed in two 32-bit halves.

Add two new compatible strings, "samsung,exynos7885-dw-mshc" and
"samsung,exynos7885-dw-mshc-smu" respectively, to denote exynos7885
boards that need this quirk. But it's very possible that all
"samsung,exynos7-dw-mshc" boards are actually affected.
---
 .../devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml         | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml b/Documentation/devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml
index fdaa18481..3eebaed2c 100644
--- a/Documentation/devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml
+++ b/Documentation/devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml
@@ -22,6 +22,8 @@ properties:
       - samsung,exynos5420-dw-mshc-smu
       - samsung,exynos7-dw-mshc
       - samsung,exynos7-dw-mshc-smu
+      - samsung,exynos7885-dw-mshc
+      - samsung,exynos7885-dw-mshc-smu
       - axis,artpec8-dw-mshc
 
   reg:
-- 
2.38.3


