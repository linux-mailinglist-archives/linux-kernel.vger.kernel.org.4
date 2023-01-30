Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35AE6680DAB
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 13:30:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236839AbjA3Ma4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 07:30:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236836AbjA3May (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 07:30:54 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D99B2ED6B
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 04:30:52 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id bg13-20020a05600c3c8d00b003d9712b29d2so9905960wmb.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 04:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n1QRubOqqMcAF6INE/oHUYXKZooNA3LwFw2vbXP3BI8=;
        b=JBPq4WtHgD17brJJNB+HeJ+uoALbeC49/oqkEeC23GT0s/NZMwYna5WRm+1cGHhL4c
         /5ZivFTfG9W3l5ncLECn0ufEkv47harQ1NM5/H3rLTRNTeUU7CAGIj5RqSdsT9JkLlVq
         RnPnafjOpWgHphC38YL4qyckpbBjzcLZWBcNepj+5CEF1kF8xdmE3EuZaJCgW1Co8slB
         +oKCliNUjTroTnbcRh7p2fgXCPc8ZP9+fvlAmi9g50waMH2BJ7qEkzC8AZ6XCqYELz3a
         28sYnFg45Yc6sgDIcLPMcx8Ulu0OiZzIIGQ96Nk78O2bfrpsQZvf9dqnWplYkO+5wtpm
         oXMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n1QRubOqqMcAF6INE/oHUYXKZooNA3LwFw2vbXP3BI8=;
        b=mcJmzoUf9AWDU5Qdou3SPyxYQPFqXRGHybB+RBfWE/8IME7cU6LoCK6HeWoKwcCjZ4
         +Tsr58ThoeWs8SostNSuH+8fMGZ1FXlOGTwCcwmEwHpuaigJUT5yyzH4tyIPmQNa0NBR
         CXLJN2pGFkJwPOTWLr38g/Psj42p6UpUyr6pJFykNAzwUTutq2l/NcBdzeQYnS2U3Ghu
         yTUbMMrXrKasnEvMmJzo7hkTTpIifTrnUqevjcUpAq8jLHikttl16Uv8GujOyglSXpB+
         Ib01rbkubLVFo5hzTbFbLBGeI4ypGnEOTCYxvCNUWSRouYPJvJwAA1qDQTPtJbnz43Us
         ApKg==
X-Gm-Message-State: AFqh2kobYfJxGt7vJWuAbc/Q+rlKMa4+zCpmT8KUPLTkT7gEPcKWm+np
        9qUg/ho56YyokHTmBZTD6+fXEw==
X-Google-Smtp-Source: AMrXdXtmlsbX33v3FHmU8EnTwJ9AI+SyD8UGSf4c1yBXeykjS4ESON4fJZpK9sDEnnI92b5Em2hLKw==
X-Received: by 2002:a05:600c:3b1e:b0:3cf:497c:c4f5 with SMTP id m30-20020a05600c3b1e00b003cf497cc4f5mr52975076wms.13.1675081851015;
        Mon, 30 Jan 2023 04:30:51 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id i20-20020a1c5414000000b003dc3f3d77e3sm9823416wmb.7.2023.01.30.04.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 04:30:50 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        iresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v2] dt-bindings: cpufreq: cpufreq-qcom-hw: Add SM8550 compatible
Date:   Mon, 30 Jan 2023 14:30:46 +0200
Message-Id: <20230130123046.3229654-1-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible for EPSS CPUFREQ-HW on SM8550.
Also document the interrupts.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---

The v1 is here:
https://lore.kernel.org/all/20221116115046.2687244-1-abel.vesa@linaro.org/

Changes since v1:
 * dropped the interrupts related properties as they are already there.

 Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
index 2494e90a2fda..e4aa8c67d532 100644
--- a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
+++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
@@ -32,6 +32,7 @@ properties:
               - qcom,sm8250-cpufreq-epss
               - qcom,sm8350-cpufreq-epss
               - qcom,sm8450-cpufreq-epss
+              - qcom,sm8550-cpufreq-epss
           - const: qcom,cpufreq-epss
 
   reg:
-- 
2.34.1

