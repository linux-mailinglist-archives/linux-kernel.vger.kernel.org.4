Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7316E0B18
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 12:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbjDMKKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 06:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbjDMKKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 06:10:01 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325118A74
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 03:09:50 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id bx15so12904834ljb.7
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 03:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681380588; x=1683972588;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DEAnat5PSJjsxQAWB7/SpZ+xwfK/Fj2JlbHtk3HNvoA=;
        b=ltTzPvxhvo3ZlgIQh10MfEpSaxyzcEAkSMAeImGiz864Hk+fEhbQ0LBYTl2tPSAMzv
         ab1LF0jIAHCyWSFQHQAPE5RsNQrBf7QUL10601PtdgwXHZgXZX6SmagLER5KjFeycGbU
         Tn1zqwIgboWmT5uTM98zj+zv1iLv4EQv3BV3StMfIXzzjTyE/rb3qRcf8zYfu6JtIPSk
         zSZ7/Jy0lHHCEV12vsYu00BDiERMME3VWk+g53uOSCfATYHP4XEKxgzEMZqCPinFLuSr
         QkXOAnq24uM2s1mGb3lQYwPpkeH1uS6wRGzzQeqmXaHWp9Czo7eQ2hzQ8vxjX6l4hEmf
         Rnug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681380588; x=1683972588;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DEAnat5PSJjsxQAWB7/SpZ+xwfK/Fj2JlbHtk3HNvoA=;
        b=OFIQV83sRnyPo0lEgUiPVGn6U64RwlwIfzkF2QjKw2PnQrGK9gf6F9Pit7xa5xd6hw
         p+l2nMvxSz4Bo0Knfa7/r6lkghkdaG+QmOoMzI/8mwQQfKPwR8kqeFxbZRIA278+4dlQ
         0diFsHcEjZe5NElEixFhG2kQRUtfxfVggBAkSD1nhxustBjM1G+cXkgjoI6VaqMUhek1
         b+ngwf/r+IJBkgdfLE2zd4Lm1rQjyRsc4O0MwRgCxY0w+eNVZQOQWm8x3fWKTEGb4Lf4
         xSkoy4dU06F+1bLsHtCioWz0x6DRRcrYaeSU/jvOBzhOXOyg7Y0kKSuRW355kVP3g52h
         xpRA==
X-Gm-Message-State: AAQBX9cf066TLy4m1LeH3YhZ3nJtKE2iwGyJOFqWU4zwvQHA90yE6/GI
        /DnRUvUY96X0o7yqvQgQIVZX7w==
X-Google-Smtp-Source: AKy350asL51EeQDLbOK2ZbUFavRJIn/bPYE8P0PHMi+LSEUZ/Jv99YCh3KyhcP4BfchERSh094e26A==
X-Received: by 2002:a2e:9e19:0:b0:29b:d471:c80f with SMTP id e25-20020a2e9e19000000b0029bd471c80fmr907501ljk.36.1681380588424;
        Thu, 13 Apr 2023 03:09:48 -0700 (PDT)
Received: from [192.168.1.101] (abyl123.neoplus.adsl.tpnet.pl. [83.9.31.123])
        by smtp.gmail.com with ESMTPSA id t20-20020a2e9d14000000b002a2e931fc48sm200482lji.140.2023.04.13.03.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 03:09:48 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Thu, 13 Apr 2023 12:09:35 +0200
Subject: [PATCH v2 1/5] dt-bindings: display: panel: nt36523: Allow 'port'
 instead of 'ports'
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230412-topic-lenovopanel-v2-1-055c3649788e@linaro.org>
References: <20230412-topic-lenovopanel-v2-0-055c3649788e@linaro.org>
In-Reply-To: <20230412-topic-lenovopanel-v2-0-055c3649788e@linaro.org>
To:     Jianhua Lu <lujianhua000@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1681380585; l=1187;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=FMgShhUTMaYzSy2Me7Gv1xSXp92sIQsWFZ0aqhhoJn8=;
 b=9J88Z5LuF95gqkV+HSGcOJ5UC/2WCV8vVvuzNlssYzVIvrv/8ehvUa53oIMtzftb/pqyOx/rHMmu
 dOWMlYA7DWmYNYzxksbhUTQJ36XooRkA8E19xmPb9BFG36Q4wp1V
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using 'port' instead of 'ports' for single-DSI usecases allows for saving
a couple of DTS LoC, including a level of indentation. Allow that.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../bindings/display/panel/novatek,nt36523.yaml           | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/panel/novatek,nt36523.yaml b/Documentation/devicetree/bindings/display/panel/novatek,nt36523.yaml
index 0039561ef04c..38f4f986aef1 100644
--- a/Documentation/devicetree/bindings/display/panel/novatek,nt36523.yaml
+++ b/Documentation/devicetree/bindings/display/panel/novatek,nt36523.yaml
@@ -33,15 +33,26 @@ properties:
     description: regulator that supplies the I/O voltage
 
   reg: true
-  ports: true
   backlight: true
 
+oneOf:
+  - allOf:
+      - properties:
+          ports: true
+      - required:
+          - ports
+
+  - allOf:
+      - properties:
+          port: true
+      - required:
+          - port
+
 required:
   - compatible
   - reg
   - vddio-supply
   - reset-gpios
-  - ports
 
 unevaluatedProperties: false
 

-- 
2.40.0

