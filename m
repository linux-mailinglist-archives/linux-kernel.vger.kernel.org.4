Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E22C6E0B1C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 12:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbjDMKKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 06:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbjDMKKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 06:10:01 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65FEA9027
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 03:09:51 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id j11so2408529ljq.10
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 03:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681380589; x=1683972589;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bSIW3m6ouiUh4MBy/iPcO3038yiahaw6SCZrZmXoL8c=;
        b=s2aepwa18IqdU0SyKMtM8jAoCQnaWRTpqSkvN7201r1i0T84x5U2A//m+sbAcDUY/h
         bIiDy6rekYmG6rNaS1GUtUrLIjmERQ/aWcasLBXJrb3f5xP8+Cy2JScNMxy6od9iC/MB
         7i/0wMUpzGXDxnO7SaEBTv90z1Cm00CrZurSL82Rv1xj8WW/tvrrzwI6fX0vsYxaSdNe
         eIDmzsQiVKeVrX9UKxSMxtZNcln6avoeEn11sokQ6rOTBf1YjXPvJbKZzmmmCBIAOk2F
         oLv2O4sjH9mOq8ymbTMucigojP13caE7qM32yysFQDphq2hC8KNebM8DwDCcJu1oF3tH
         Nkaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681380589; x=1683972589;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bSIW3m6ouiUh4MBy/iPcO3038yiahaw6SCZrZmXoL8c=;
        b=gtXcWUSOF+APCj773h+0cV1mkIKGJRNEBq+FxuIUAQ87ig7SZhxYThFrPSTa6JiyzS
         Iijw9eqB+fU/BYm7CarB28N+Vjz6mJ8ouIcDmi0e4d/2vdQQoUZhtID0LwJANTCq+8oA
         xkitQYshszN+QBcoqr3W15qSDbVZaRrRZWP+YbeNRSHD9ks/LiAljzmcUhrc3+GljmdZ
         FRPBlHUGplCGFa5FBqJkg1ytzGo04iCVno1G5D1kBARtqrFO1Z5HI0i9JRTlVhXWk83h
         eiVZ1pEFMXzHU4trH9mGnzagWHei0ECW3fwuP8aVyC5IIqHyR7+vGSZhk7dFtnttHU4r
         FtrA==
X-Gm-Message-State: AAQBX9dOF6u4xl5odivhjiwrAC+y65tpW2mcI8vuu5S8rRZQS+qr5x56
        ok8JVXGKJLkdIIPNttAmwkIvDg==
X-Google-Smtp-Source: AKy350akt3tf+m5dnagc6WlGIUG8b2dlWdEiOD0/YEcV1QE/n9GCXFU+ey43oGfBADr3OnNThMPwMQ==
X-Received: by 2002:a2e:2418:0:b0:2a6:8a:d0f5 with SMTP id k24-20020a2e2418000000b002a6008ad0f5mr578207ljk.23.1681380589691;
        Thu, 13 Apr 2023 03:09:49 -0700 (PDT)
Received: from [192.168.1.101] (abyl123.neoplus.adsl.tpnet.pl. [83.9.31.123])
        by smtp.gmail.com with ESMTPSA id t20-20020a2e9d14000000b002a2e931fc48sm200482lji.140.2023.04.13.03.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 03:09:49 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Thu, 13 Apr 2023 12:09:36 +0200
Subject: [PATCH v2 2/5] dt-bindings: display: panel: nt36523: Add Lenovo
 J606F panel
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230412-topic-lenovopanel-v2-2-055c3649788e@linaro.org>
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
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1681380585; l=1472;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=n3Ug6o2RQm9MRwfNsS0ku9LYCJEX/SEVYNXH8b0uEzs=;
 b=7k3RzLmzF5mXo80xwIEgbS38OpViZfugrSV/p8xZjzFY6LLzX8bSGoCa5fzFIkaUzU3qAqdZhOrL
 xZd5o7mhAfUxWxAQTY7QYr+XMn+hZJmlPjzk32hAPTHJlIpKfczq
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

Some Lenovo J606F tablets come with a 2K (2000x1200) 60Hz 11" 5:3
video mode display. Document it and allow rotation while at it (Lenovo
mounted it upside down!).

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../bindings/display/panel/novatek,nt36523.yaml          | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/panel/novatek,nt36523.yaml b/Documentation/devicetree/bindings/display/panel/novatek,nt36523.yaml
index 38f4f986aef1..fda74d5bd89e 100644
--- a/Documentation/devicetree/bindings/display/panel/novatek,nt36523.yaml
+++ b/Documentation/devicetree/bindings/display/panel/novatek,nt36523.yaml
@@ -19,11 +19,16 @@ allOf:
 
 properties:
   compatible:
-    items:
-      - enum:
-          - xiaomi,elish-boe-nt36523
-          - xiaomi,elish-csot-nt36523
-      - const: novatek,nt36523
+    oneOf:
+      - items:
+          - enum:
+              - xiaomi,elish-boe-nt36523
+              - xiaomi,elish-csot-nt36523
+          - const: novatek,nt36523
+      - items:
+          - enum:
+              - lenovo,j606f-boe-nt36523w
+          - const: novatek,nt36523w
 
   reset-gpios:
     maxItems: 1
@@ -33,6 +38,7 @@ properties:
     description: regulator that supplies the I/O voltage
 
   reg: true
+  rotation: true
   backlight: true
 
 oneOf:

-- 
2.40.0

