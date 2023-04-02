Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 387A96D36F1
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 12:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbjDBKIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 06:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbjDBKIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 06:08:01 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0072C2B0C2
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 03:07:42 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id o2so25399679plg.4
        for <linux-kernel@vger.kernel.org>; Sun, 02 Apr 2023 03:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680430062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ns2jPDGRWz/czfPYAkU0ANfXA6YC0owDF4gxQpajwV0=;
        b=xfXgK3qPqZv33ZCRsFAI/dxIgHUBk9UciMyK4AAaL6NGWvIdyrYKpTCVICXpcDv9o3
         baL8j22lLNyKQiPAy+yANoGY8BSSTtOY8827aoXHZyDiIzA08bSoa3+xWVPMzbnuGNkr
         M14F19AzW3sgpDsoaORTkJIFRAHZmI/QXKC91ohoH4UHGY0sqW6Pdk3FjHsBBloLTuls
         eKya/6fDGno2nm+k6HyZJuZ7A8YMiIXRbQcah0U6oZPrRPVbqRq+ZKXhvkP9T4veU1Ji
         Rthu7TQnhnmXEsfeNEVcKaNQBoRcm5F/S5iTOJ6MgjxmjUb8D6PWVJqLrHUo/BM9NEdz
         RbIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680430062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ns2jPDGRWz/czfPYAkU0ANfXA6YC0owDF4gxQpajwV0=;
        b=HR+yAd5Z3EPlDJ01Fl3Ok2kwXfcfbSbpRst6AmuvjZvK3Dnet780sdOPKxHuu0AdS8
         +oYgoT5Kl7aa51pfF2uks22hh7HKBV6GncEDG547QTZrslqnBJwq9QpJeBHttS2scMQg
         IKxaHYHu/9NXT5RFc2Pd4Q+v4TXGzi/oP38twbQu6D0EY4zQQlNzCojK8KllDJXb+GaI
         uwWFYBwnb8f515+ARZIZyy5V8JZeBYZ8wQfJb31eouplfLKC5dpITaNnEb2nBmQEzYUf
         WS5kcgLkpTeHb60FFlH9uax9EE4fuMqweR8WZ8t8SiAoZ5yI/Ix/q5Ycz0TiU/uCL/QY
         eF1g==
X-Gm-Message-State: AO0yUKWxzhAji+lAPsBnkhqJ7hA2v5FBu9S9amupRtihOg9uhkStRpnG
        vGM8F902WZkh69G9QMfJVNTB3Q==
X-Google-Smtp-Source: AK7set8/k+S1+Gow66T1mn6KMnnFC34t1zsT+r597uKySIZ9JC0a1EiCunte3PoH8IdvJ/jWFfAs9A==
X-Received: by 2002:a05:6a20:4ca8:b0:db:7382:cdd4 with SMTP id fq40-20020a056a204ca800b000db7382cdd4mr27445442pzb.6.1680430062097;
        Sun, 02 Apr 2023 03:07:42 -0700 (PDT)
Received: from localhost.localdomain ([223.233.66.184])
        by smtp.gmail.com with ESMTPSA id a26-20020a62bd1a000000b0062dba4e4706sm4788739pff.191.2023.04.02.03.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Apr 2023 03:07:41 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, andersson@kernel.org,
        bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        krzysztof.kozlowski@linaro.org, robh+dt@kernel.org,
        konrad.dybcio@linaro.org, vladimir.zapolskiy@linaro.org,
        rfoss@kernel.org, neil.armstrong@linaro.org
Subject: [PATCH v5 05/11] dt-bindings: qcom-qce: Fix compatible combinations for SM8150 and IPQ4019 SoCs
Date:   Sun,  2 Apr 2023 15:35:03 +0530
Message-Id: <20230402100509.1154220-6-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230402100509.1154220-1-bhupesh.sharma@linaro.org>
References: <20230402100509.1154220-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the compatible list available in 'qce' dt-bindings does not
support SM8150 and IPQ4019 SoCs directly which may lead to potential
'dtbs_check' error(s).

Fix the same.

Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 Documentation/devicetree/bindings/crypto/qcom-qce.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/crypto/qcom-qce.yaml b/Documentation/devicetree/bindings/crypto/qcom-qce.yaml
index e375bd981300..90ddf98a6df9 100644
--- a/Documentation/devicetree/bindings/crypto/qcom-qce.yaml
+++ b/Documentation/devicetree/bindings/crypto/qcom-qce.yaml
@@ -24,6 +24,12 @@ properties:
         deprecated: true
         description: Kept only for ABI backward compatibility
 
+      - items:
+          - enum:
+              - qcom,ipq4019-qce
+              - qcom,sm8150-qce
+          - const: qcom,qce
+
       - items:
           - enum:
               - qcom,ipq6018-qce
-- 
2.38.1

