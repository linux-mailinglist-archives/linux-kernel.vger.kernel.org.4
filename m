Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C2545EECFA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 07:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234914AbiI2FD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 01:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234847AbiI2FDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 01:03:02 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7406D1284A6;
        Wed, 28 Sep 2022 22:03:00 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id bh13so469876pgb.4;
        Wed, 28 Sep 2022 22:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=MAxX3HwZPoIUthNG89lC4GJ6X33ElvjGpgppMP4s59I=;
        b=ninWtnFr+PZBgoMjKfPm2KhI7Eek3iq7i0ShTtqXXCTWq/ViTXoEomk1Ns+cN/67U9
         cguqetWzOJB4M+fcUqekaxXbCr8WuQPPm82o47td59ScllerSWC2nTFDJ608sJKHTNEr
         CTItMegI7UhtkYpnDBzIZ17KHOlA+I9UNBdtsED2waoN0dk22givZAygMYMBDPYIacKl
         Hi5Yww4qWtVKKAqAq6yaLBbVK2HhtZkUrLH80nES2BDVJR80aEczepZ3iC8/GFteWnzo
         GUtikUpn1CKjOvAgc4AIrpII0GeZe83drnnXM1/07mkhY7J4uuxo5PLUx47PhSz2Dxaa
         I0cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=MAxX3HwZPoIUthNG89lC4GJ6X33ElvjGpgppMP4s59I=;
        b=C+JNNMbNgcm7KomLrZa5NmygkaZJCRg+b5TOiceSv2rE6xD+7bPjsg11nXLCy7vRQ3
         kbs8RI/dgUdSN9KDbMpxynPWtflCBnXzbEmzEgea+cBldGZ+qdsKQHTfG0Y/OM6qFEsS
         foV/1H1G0A3qIDlLa7svdfZFQj94TK/tRpN6v6AodwyfH+X3nnGzfzyg1ocv0Z1CoT/P
         qcHMtrXiVk65WA5G+Qy1qzH439zU66bWkPOz/iF/TPqK+DBfKcn9rlkBsbHDTlpQHCSp
         cx8iz/E5Ib2+BMrdroikjTNwUe94g+69AZCp3qrkHlu6kVUTfbVUBypeVTeKcq4D7rHW
         pFkA==
X-Gm-Message-State: ACrzQf2APssLR3PlDaKBSFUAqHp9dT5KM5jRkN97eB0oqIW/ZYWYERUK
        QOu4XKpcZ/9/V002lfm/wAfBRwl6Fy8SOm0I
X-Google-Smtp-Source: AMsMyM4bry2WOb170Y/tBalWnaBobFDexndbojNbGL6Z3HYWbWbeCb131hsk8dxYRwIrCrPjOVi/Gg==
X-Received: by 2002:a05:6a00:14d5:b0:542:9c32:ab27 with SMTP id w21-20020a056a0014d500b005429c32ab27mr1682903pfu.64.1664427779439;
        Wed, 28 Sep 2022 22:02:59 -0700 (PDT)
Received: from skynet-linux.local ([2a09:bac0:579::681d:4237])
        by smtp.googlemail.com with ESMTPSA id rm13-20020a17090b3ecd00b0020263b7177csm1895962pjb.3.2022.09.28.22.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 22:02:58 -0700 (PDT)
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
Subject: [PATCH v5 5/5] dt-bindings: remoteproc: wcnss-pil: Make supplies optionally required
Date:   Thu, 29 Sep 2022 10:32:09 +0530
Message-Id: <20220929050209.1464526-6-sireeshkodali1@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220929050209.1464526-1-sireeshkodali1@gmail.com>
References: <20220929050209.1464526-1-sireeshkodali1@gmail.com>
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

On MSM8974, power domains are not yet supported. The platform uses
regulators. This patch marks either the power-domains or *-supply as
required (instead of always requiring the power domains).

Signed-off-by: Sireesh Kodali <sireeshkodali1@gmail.com>
---
 .../devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml
index 2ba2b6cf11fb..45eb42bd3c2c 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml
@@ -196,9 +196,13 @@ allOf:
           deprecated: true
           description: Deprecated for qcom,pronto-v1/2-pil
 
-      required:
-        - power-domains
-        - power-domain-names
+      oneOf:
+        - required:
+            - power-domains
+            - power-domain-names
+        - required:
+            - vddmx-supply
+            - vddcx-supply
 
   - if:
       properties:
-- 
2.37.3

