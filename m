Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3565F197B
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 05:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232362AbiJADXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 23:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233113AbiJADWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 23:22:43 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2AC885AB6;
        Fri, 30 Sep 2022 20:15:19 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id f23so5441276plr.6;
        Fri, 30 Sep 2022 20:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=5Bev8D6ZYJiqDjBpp+o/3o3sID8wHikuW24dd+pn+/w=;
        b=PGe1+HcPTAw6H/e/EvSr1dQxZUhqMjOFMEr7JegNTuuF3B6VllEtzC6cY1vS6ObK/6
         Mv5MSa+H3Zjk126gmSaI7WsLGWb8Msya+uraVcpAKYwvvJcjt6gOkNmx1tm4dSk7boSv
         pz50WfKjdDOZbUCloD7aiRKLueQBTTVdrKxIAzjfGAzyElXA8eiCSdsYv4WT63QZATY7
         fcKsr5ffvsuAn2L2Ga/GQ00wPzn4jM1eiZkFt1+WIxQAzHNvtT878nS6ZbToHr5Qqbxb
         49V5IizKhGY++oixBP7xfGY8JDbQEp3gNLehA8WD9QuFYSMUFCGDBzI/rddaXYYeshV9
         XQGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=5Bev8D6ZYJiqDjBpp+o/3o3sID8wHikuW24dd+pn+/w=;
        b=JlKaDQObG8lc7U2ym4o2d7lK6Mj6/dJO1RY5/YkVXzss4gwVIgh1TF9GPX6mQbJO4r
         4JZ1WTn6byInbhPI+OeTzLTNcEW0zj/V2ekDuPcYCo9g+AQOsHFcFaujjxC3kCWXWgQV
         ELqLGNkOrLMWXa3w4BfVCbjT/YB9BCXeBWSFWxoomn+OHybBMwXJ0M8pYD4Hd0EL20zB
         hOgTR1W9/8Bd6tR1Iuqiz4lmYv/dHrB2dZ1YfR1CYlTeQdf1o1YTlTHcnU7yrdgOeFsi
         PFSd+1YDE3VG8F6i4D4uZBfZizS6S+DQNGr/AXLa2axjCj2ZgeXkN2+sGjGpaz3xe+BS
         1M6g==
X-Gm-Message-State: ACrzQf3ZN91yfYodsOIBdvQs1qfaqiUlQjS7jysU7eeHPD1L25IFGkeD
        c9MPvTzkFXEQCmC4cYNS+PkirY1tvdSrOzdl
X-Google-Smtp-Source: AMsMyM44ANcunkldxLZFZ73zNKxVK1ToZcJq26NjvxGQy1aPM74t/R3klkbu5we1SvAQ6FGhKHCazA==
X-Received: by 2002:a17:902:f684:b0:178:84d:ddc5 with SMTP id l4-20020a170902f68400b00178084dddc5mr12184099plg.62.1664594061730;
        Fri, 30 Sep 2022 20:14:21 -0700 (PDT)
Received: from skynet-linux.local ([2406:7400:61:5d7c:3fe4:8f6d:b1b6:f2bf])
        by smtp.googlemail.com with ESMTPSA id cp1-20020a170902e78100b00172a567d910sm2627371plb.289.2022.09.30.20.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 20:14:21 -0700 (PDT)
From:   Sireesh Kodali <sireeshkodali1@gmail.com>
To:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, linux-kernel@vger.kernel.org
Cc:     andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        Sireesh Kodali <sireeshkodali1@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v6 5/5] dt-bindings: remoteproc: wcnss-pil: Make supplies optionally required
Date:   Sat,  1 Oct 2022 08:43:44 +0530
Message-Id: <20221001031345.31293-6-sireeshkodali1@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221001031345.31293-1-sireeshkodali1@gmail.com>
References: <20221001031345.31293-1-sireeshkodali1@gmail.com>
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
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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

