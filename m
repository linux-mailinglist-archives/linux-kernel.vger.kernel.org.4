Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE4515BF575
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 06:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231325AbiIUEii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 00:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbiIUEiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 00:38:17 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF0E77D1E4;
        Tue, 20 Sep 2022 21:38:15 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id p1-20020a17090a2d8100b0020040a3f75eso4533306pjd.4;
        Tue, 20 Sep 2022 21:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=1ZAgs0EUhexlFlK2MZMbzZ6IVMi8WJy1viUVzYD9emk=;
        b=B9gRFLcUiPoQdLfXFk+lUJ+OgOkhVQf7e/z8hihQoXI4Y4l3r6KEMurIuznQ1TwjXT
         oNs8yHJiKyt14M/2LgG+gqEMwJsiWGKHuwVwzHuEJcYxenjIn9SMvYpJ8X0Ot7fwUtLb
         HeuiqZb3EQbrVFYGTUYs7VfGkz5HxrOHWjQiK9YBpLBhWxrpBYwgCJ2KoCfTBqRRZ8CN
         YGccEvmEfmjEAZzwLpyi2gCiA3cqEsWZbUr/bEhZm0762h2tK27gp6Bery7Pp3f2PsP4
         nI5OE3exOijOTTUiows/yqICADZnUrSFGYCeSJYzU62S9PHL2ZKrzmEpnv9Mfwr+Ijv6
         hO8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=1ZAgs0EUhexlFlK2MZMbzZ6IVMi8WJy1viUVzYD9emk=;
        b=7gds61LZ6qZ058pSgHvsDnQa559Ecn00dAS8DYt7RkEN4NB6vYx1lniXs1c7CJAAba
         Ugctk1+fdjx7v3HYyFMF+xXvr+OOyMJLF1dJKEWXRYJR+GRg8HyaOm0nMXZ526xzQ82I
         j0kDi6e4uqmVkZE+D30v8u/zmkjnLQOcEsg36A6Xq/dYw7eEQVqyXhDD9yaeh8NtrKiG
         sWurPr2SYHDOySOFdxBUV/sATQd07L7Q2FNSz4GLbtJL8X+oUJKybhdtRugjgCacSj0A
         Ij5aDl7Pie+hTqiOPIQeC/OtN1OvKQYRZdBNtVxvtmGHQGrEH2eOx8n1uhgOrxZ0Cp9d
         Ah4Q==
X-Gm-Message-State: ACrzQf3R2afBgjjorJIlmtNeE1X9wXhl/MWanz7mKTBkeXYi55EgV97x
        Mm7W7DBfzpdHdiw+ebs5oR88aVtkW2YGZQ==
X-Google-Smtp-Source: AMsMyM7gTldbBKgeoo+KYBFYwn+kQJCUC9DtOchu7WIkEY62Vl99e1lguy3POjnJvxtEufrAcXveRQ==
X-Received: by 2002:a17:902:be01:b0:176:8bc3:b379 with SMTP id r1-20020a170902be0100b001768bc3b379mr3024831pls.109.1663735094713;
        Tue, 20 Sep 2022 21:38:14 -0700 (PDT)
Received: from skynet-linux.local ([2406:7400:61:8a0f:392d:db19:673c:627a])
        by smtp.googlemail.com with ESMTPSA id t185-20020a6378c2000000b0042c0ffa0e62sm821182pgc.47.2022.09.20.21.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 21:38:14 -0700 (PDT)
From:   Sireesh Kodali <sireeshkodali1@gmail.com>
To:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, linux-kernel@vger.kernel.org
Cc:     andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        Sireesh Kodali <sireeshkodali1@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v4 4/4] dt-bindings: remoteproc: qcom: wcnss: Add compatible for pronto v3
Date:   Wed, 21 Sep 2022 10:06:48 +0530
Message-Id: <20220921043648.2152725-5-sireeshkodali1@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220921043648.2152725-1-sireeshkodali1@gmail.com>
References: <20220921043648.2152725-1-sireeshkodali1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pronto v3 remoteproc is similar to pronto v2. It is found on the
MSM8953 platform, which is used by SDM450, SDM625, SDM626, APQ8053 and
other SoCs. Since the configuration is same on all SoCs, a single
compatible is used.

Signed-off-by: Sireesh Kodali <sireeshkodali1@gmail.com>
---
 .../bindings/remoteproc/qcom,wcnss-pil.yaml      | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml
index 31232c59b22b..639c52284f4f 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml
@@ -22,6 +22,7 @@ properties:
           - enum:
               - qcom,pronto-v1-pil
               - qcom,pronto-v2-pil
+              - qcom,pronto-v3-pil
           - const: qcom,pronto
       - const: qcom,riva-pil
 
@@ -197,6 +198,21 @@ allOf:
         - power-domains
         - power-domain-names
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,pronto-v3-pil
+    then:
+      properties:
+        vddmx-supply: false
+        vddcx-supply: false
+
+      required:
+        - power-domains
+        - power-domain-names
+
 examples:
   - |
     #include <dt-bindings/interrupt-controller/arm-gic.h>
-- 
2.37.3

