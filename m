Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C786D6DFEE7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 21:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjDLTqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 15:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjDLTqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 15:46:13 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA3D1718
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 12:46:12 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id q26so3936888lfe.9
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 12:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681328771; x=1683920771;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DEAnat5PSJjsxQAWB7/SpZ+xwfK/Fj2JlbHtk3HNvoA=;
        b=YXwiyLzg4ji60X8cpHNlrFIzDmyZJKGB81F6A+ebWz+GR6NY5Iw6oTV86QwTK8VLlE
         6JFyxipHfmjVM1joCgbYab5wEgc/NJyR1AJYa6JO8xP9LPl+ocaSmy4rQnc+SdPbnh/C
         8tyxBZkFJ+js6MrlXgfSsQzD7u7/idqTlgloJP5dzbipQLlNRkjMLXU3cGd0T8Nc2N/B
         YuGgoV4RzSig1n7Rt3siwcaHYmf2mezeVij+xLS+fEPcYfcwznC2fX6aChJB27I6KJFt
         DZQWDCkyPETH8zshyG34lInJ17jBpHrxZBLHCp5PYc6fWwVwkrwwPWOGXMK9lPsqAJ/x
         8WRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681328771; x=1683920771;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DEAnat5PSJjsxQAWB7/SpZ+xwfK/Fj2JlbHtk3HNvoA=;
        b=IHhA9KSw6MGK9NWPz5OQFVGEKFBWU+EJ5uqTwPJAORtKOnYRSxwul4m0xRLMTVPiqh
         6KDCdsiJe0f70YfjXnXktJygzeVHL7CdGwGpk6aOjqME3hCzAd6PzzXmAzFgFwydOcDI
         vpq11eLa1fSwOC2G1NRTaSy26e1oq5n8AqI6DjSKCmjGBFUJfPRNKZjsKOvYYoxPawCC
         EbXKRGkI/IsAETEEYKpS4NGrfxD4K63f7CPNCUDK9wV6/19SmFvQzx076N+tvnWjCk2G
         vhgoT9arSDoNgCkEAMrumiCs0J/tL1AoSvHQt9LSK+P9EibKxi99uvkaeuAU1YS/BB/k
         6gCA==
X-Gm-Message-State: AAQBX9cYTt0TS6n8B4Cm8ukum5tc1Bzybys4fOh9ypvjBLCuXSOf+lnw
        Q7zVeoRfcjakKtx+RdEHC3hwpg==
X-Google-Smtp-Source: AKy350ZQO4wDtrSkqQilMkiMX1DJXlr0CW0RCxaddDxjo+a6jr9yxnIMURGU7xelCIuFm0ODAe3xcA==
X-Received: by 2002:ac2:544c:0:b0:4ec:9f36:9b5c with SMTP id d12-20020ac2544c000000b004ec9f369b5cmr2723lfn.68.1681328771108;
        Wed, 12 Apr 2023 12:46:11 -0700 (PDT)
Received: from [192.168.1.101] (abxj23.neoplus.adsl.tpnet.pl. [83.9.3.23])
        by smtp.gmail.com with ESMTPSA id x2-20020ac25dc2000000b004ec8de8ab3fsm1205865lfq.132.2023.04.12.12.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 12:46:10 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 12 Apr 2023 21:45:58 +0200
Subject: [PATCH 1/5] dt-bindings: display: panel: nt36523: Allow 'port'
 instead of 'ports'
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230412-topic-lenovopanel-v1-1-00b25df46824@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1681328765; l=1187;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=FMgShhUTMaYzSy2Me7Gv1xSXp92sIQsWFZ0aqhhoJn8=;
 b=9TbzELnlWNU1kmoa3o/rXyhwMOM4rjVKSxHPyH/watUFxTLNRkHx8vvXq4FZZfrwU4sEibR9V1Uw
 0SXo1Q/nB7+4KemAltiOcAA+ADHzcKumbeSaLNwxSdI89adYyaP2
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

