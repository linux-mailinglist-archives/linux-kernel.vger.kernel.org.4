Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0801D6DFEEB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 21:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjDLTqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 15:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjDLTqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 15:46:15 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 399D81718
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 12:46:14 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id r27so16193298lfe.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 12:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681328772; x=1683920772;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N4kTVSMXSwyC6bo9qzkKhgpiPoowje+aIZSZ/vV/bAc=;
        b=zWzoQ6dX2JAKA2j4dLDWKS1dbYRopx+EAMlpKfSqpLxDhwF20KnINJTVf581xvVqOY
         Yp1g7chdDoNPmEIELY1Ey/B9bQiivsYSeE4+4QDfvJlbPzRmjNx9DUBBjWLOukurTkN5
         RHDM1qOFEb6/FgaZU49kGm+gU70plR4+GDSq1TSSCrrmmCC22lgmw1JqkLPMHsa9Vkt3
         eqcw/z2ATZ3fa9oqLE3EeeSL8Fz9D+oJ+gPw+cF2EFOjwwPU1GT38bg1Z9+yS2sn6v/d
         1iU/5CRTlyyCp0SpaI9VQMXeaXaq/SM8noBTw3JsYWRv3UY2nEomYEn6hD5LKzpcLXPu
         p9JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681328772; x=1683920772;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N4kTVSMXSwyC6bo9qzkKhgpiPoowje+aIZSZ/vV/bAc=;
        b=jwZonH73UA6Cs4YanY0Qce28VPUnl9WUvSOsYIESHs1xsRw7udherkc2X/pBioNln7
         QJ9E4uCdBH3e1jRyeHrIXj7Oye+kMBB+yS6yJHToNui4LfB0qFyypcAA7PGsi3GHyFEz
         6KMW0X2zxmVqOYdNJl1B70HjL+EdDO3gQzmxvob3w+LCWm7vDwDMn4aveXl1dlr+1CWa
         kSL3XdUcO8s5XEONwmZz59dNRtbTSSQgPFwNoiTZACM9Ew80rmxb0JsdtH9MGYfRgK1h
         dUGt+yPTugLjLBYJ8bQmqiWRHP4QhRvDwbNIHjmIAl77YJX7XbQdxk/bqqXY2ZpdotIg
         jmAQ==
X-Gm-Message-State: AAQBX9fChk6XKyOVeuZ0syp5d46/U6+irgpvS1ZVmgcdLPzCRh2PxcF/
        wLYaQiVeN3gNFWD2NcTDZRyhIg==
X-Google-Smtp-Source: AKy350a95ArQuowl/wgW6TW1gFmnTZp8BouUqK6Ak3W824KKp1HQBcg1kwwWGKQBMJhbR/Nj5V6cuA==
X-Received: by 2002:a05:6512:75:b0:4d5:c96f:f7c7 with SMTP id i21-20020a056512007500b004d5c96ff7c7mr16214lfo.23.1681328772621;
        Wed, 12 Apr 2023 12:46:12 -0700 (PDT)
Received: from [192.168.1.101] (abxj23.neoplus.adsl.tpnet.pl. [83.9.3.23])
        by smtp.gmail.com with ESMTPSA id x2-20020ac25dc2000000b004ec8de8ab3fsm1205865lfq.132.2023.04.12.12.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 12:46:12 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 12 Apr 2023 21:45:59 +0200
Subject: [PATCH 2/5] dt-bindings: display: panel: nt36523: Add Lenovo J606F
 panel
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230412-topic-lenovopanel-v1-2-00b25df46824@linaro.org>
References: <20230412-topic-lenovopanel-v1-0-00b25df46824@linaro.org>
In-Reply-To: <20230412-topic-lenovopanel-v1-0-00b25df46824@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1681328765; l=1417;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=+xuQ62lO6qldIvMcfFbmsAJ1YwYhA8kqM8Kbhmig26M=;
 b=VAQKU+1GcrDese/v3mivE+sj/edg3KZBLnVeAboGxoCDRzkc+tnluTjVHCMq/TYmUmu8FRog0BrC
 yagNztnNCDXbf+S0nW0yjovosEYVTjZOapZnZ8EJ9FmB5agUnrEU
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some Lenovo J606F tablets come with a 2K (2000x1200) 60Hz 11" 5:3
video mode display. Document it and allow rotation while at it (Lenovo
mounted it upside down!).

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

