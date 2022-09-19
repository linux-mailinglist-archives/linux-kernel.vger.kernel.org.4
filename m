Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00CC65BD460
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 20:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbiISSGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 14:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbiISSGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 14:06:32 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B0815A23;
        Mon, 19 Sep 2022 11:06:31 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id k9so487185wri.0;
        Mon, 19 Sep 2022 11:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=fcEevRZ0SucZvq2o64TKWJQCCIRt2vtZIyxf3obxZMg=;
        b=HfS/6FMh6neVb+T6OTZCfaSlL8cB27aeX4f9r2OY+3iNRBtPLN6jI12mENcwQg5rub
         RT9sQXQ91VkjWWDDarsun4W1I6nWh5Sdpg5zDqIIChwxbriksgWV19M7lm69sRUsbUgQ
         wrkLAGtpRk/ct1cHA4GJ0TpTul5VDdo1msejkWFQdrpzCT8PyiRCp1jV+Tj6VaEtci1L
         cUIcx6qRbg6fjNeUaW5KHbq6B4CehHTYf8FzJpTho0fxRciWpSglFAV2Pz6feTYqGcG3
         yiq0HL04G++9opyRL4veXfPZNI9u78ZjJd4WEHjoHjfyWwaR2MkDQ/o2out8pkLknjiF
         S4cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=fcEevRZ0SucZvq2o64TKWJQCCIRt2vtZIyxf3obxZMg=;
        b=X7fDVsoWp0LYJ1DKPSz6F4AUZw1QKVeToakE13p3LwkMTzOkqMBw2dnuBlZwjeRvuP
         6Af3J1fq2MegbqxaPwXmr2w+ReDR5s/hAPc+p5Bz/rfbPOr1WeWBd9OX+o8Dp9kJolv5
         i7To4/wpR7lKWUWQ1aRgzN1sZO4t07DDCvpConDP/6SCTyywn2sitB0A1xwD+OLSCv3B
         xvuXasAjm8yfltW3MNGMX1nqGzWuhxVxwPIw1Hr7oOP7UALuGFXXTY8REdogXCiNQdzo
         PEs0P5pJdZg7cva5ya3Y3I/i1QH1QAAKiWhQPFerlGoduhyKTKyOGL1kNIngBsAEDn5E
         PhIA==
X-Gm-Message-State: ACrzQf1Nldwo3xfmt+g67yXdbNVyodlrOI+/vyEGfqA1vAdAmPTP/pPT
        cJ2jfLR8W+ybYryxHWgXEuI=
X-Google-Smtp-Source: AMsMyM6xCLp+Ifwl03CPU6QtAwUp+0S4UvqUhhukFRjzmHlMERNv08HcepYTx1GCWMCiE7OqY7e2gA==
X-Received: by 2002:a5d:628e:0:b0:228:6961:aa6f with SMTP id k14-20020a5d628e000000b002286961aa6fmr11998172wru.36.1663610790045;
        Mon, 19 Sep 2022 11:06:30 -0700 (PDT)
Received: from localhost ([77.78.20.135])
        by smtp.gmail.com with ESMTPSA id l3-20020a5d4bc3000000b002238ea5750csm17227126wrt.72.2022.09.19.11.06.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Sep 2022 11:06:29 -0700 (PDT)
From:   Iskren Chernev <iskren.chernev@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/8] dt-bindings: ufs: qcom: Add sm6115 binding
Date:   Mon, 19 Sep 2022 21:06:11 +0300
Message-Id: <20220919180618.1840194-2-iskren.chernev@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220919180618.1840194-1-iskren.chernev@gmail.com>
References: <20220919180618.1840194-1-iskren.chernev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SM6115 UFS to DT schema.

Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/ufs/qcom,ufs.yaml     | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
index f2d6298d926c..b517d76215e3 100644
--- a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
+++ b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
@@ -28,6 +28,7 @@ properties:
           - qcom,msm8998-ufshc
           - qcom,sc8280xp-ufshc
           - qcom,sdm845-ufshc
+          - qcom,sm6115-ufshc
           - qcom,sm6350-ufshc
           - qcom,sm8150-ufshc
           - qcom,sm8250-ufshc
@@ -178,6 +179,31 @@ allOf:
           minItems: 1
           maxItems: 1
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sm6115-ufshc
+    then:
+      properties:
+        clocks:
+          minItems: 8
+          maxItems: 8
+        clock-names:
+          items:
+            - const: core_clk
+            - const: bus_aggr_clk
+            - const: iface_clk
+            - const: core_clk_unipro
+            - const: ref_clk
+            - const: tx_lane0_sync_clk
+            - const: rx_lane0_sync_clk
+            - const: ice_core_clk
+        reg:
+          minItems: 2
+          maxItems: 2
+
     # TODO: define clock bindings for qcom,msm8994-ufshc
 
 unevaluatedProperties: false
-- 
2.37.3

