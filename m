Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4803C5BD46B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 20:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbiISSGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 14:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbiISSGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 14:06:39 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37DE845980;
        Mon, 19 Sep 2022 11:06:38 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id b5so387994wrr.5;
        Mon, 19 Sep 2022 11:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=QfWW3Bgk8p54Ws6mo7HUHIpRuHazfcXLyPjujKD+Bao=;
        b=Lr550RupUK0YccgUrYx5Sfx29b8xaU5VmqyKT8Lh0Uh0nnGUtgtzv3mulSxLthCH3I
         aF4hb4wITBc6rd03wYiz4+Mwo2sjBmjbrM4yJg1DcQbECHCzCzwQSJSuhWxDU7YEllCf
         OsLvOse6aF2Cvv0wDaxPGooQnig5mOVxr5msEyfz6Q+2y8GivItHFo2FyDnJI+xmksne
         CIvLHaq1hkF6eW8jgoTI1IObi2osqHgEECfecWrsY8Vfo1BJd7twnXUVqSKwMk4ruHYo
         aUZZmU5JH6y2nnzUMfmfszlVJPLUwL5hrEAhRl/DJxHrUsx71YajRNoj4kppZiFMZTby
         4vUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=QfWW3Bgk8p54Ws6mo7HUHIpRuHazfcXLyPjujKD+Bao=;
        b=xZG89ybW7naGonLCcLu/IPHiIGp6lR77uNSMVcHD2Wi4Gv6j1N1M9IWbFbsRpZpx5Q
         89+JCjIONjoxnza8FsIxrifRnl6uAW+Ry0zxN8Whublxgl5uxkAQtTLh5aoeNGeCGlUY
         xZwescE1rRKtfTeijy4ztwj6zR/12G4UPl1VPjgVyrZqpqrVzXa30n1GozN56i2Wz/j3
         N5dCl34N/rBFKKSi6WtL7YkhwU+75mJjuWTDWu2+Rz6zxmj1FiTGVJyqSe0VD891io+D
         h+cCLWKYQo0uIOy4/pvY/gAQa8XCQH+gxca1XjPHzySwkR844G4tRu+iAzmjXa5RNauI
         0OUw==
X-Gm-Message-State: ACrzQf0nNIgjsWYOQ0XKW8PrMRGJ0/DKE+wYgdVRlKti/U4SPiQonkwD
        h8DP9+ZHgWVAlCbyO+rJbEw=
X-Google-Smtp-Source: AMsMyM62KrjeHWnEOgnvk6O0kZn16SPBrxKiWIb47tnj0HtXUNHOA1P1cViRE2UsK14mhJC9zYTQLQ==
X-Received: by 2002:a5d:588e:0:b0:22a:feea:6c09 with SMTP id n14-20020a5d588e000000b0022afeea6c09mr3878663wrf.112.1663610796663;
        Mon, 19 Sep 2022 11:06:36 -0700 (PDT)
Received: from localhost ([77.78.20.135])
        by smtp.gmail.com with ESMTPSA id e5-20020adff345000000b0022ac672654dsm14895071wrp.58.2022.09.19.11.06.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Sep 2022 11:06:36 -0700 (PDT)
From:   Iskren Chernev <iskren.chernev@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Caleb Connolly <caleb@connolly.tech>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/8] dt-bindings: arm: qcom: Add compatible for oneplus,billie2 phone
Date:   Mon, 19 Sep 2022 21:06:13 +0300
Message-Id: <20220919180618.1840194-4-iskren.chernev@gmail.com>
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

oneplus,billie2 (OnePlus Nord N100) is based on QualComm Snapdragon
SM4250 SoC.

Add support for the same in dt-bindings.

Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Caleb Connolly <caleb@connolly.tech>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 1b5ac6b02bc5..35cfc1ef7522 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -54,6 +54,8 @@ description: |
         sdm845
         sdx55
         sdx65
+        sm4250
+        sm6115
         sm6125
         sm6350
         sm7225
@@ -690,6 +692,11 @@ properties:
               - xiaomi,polaris
           - const: qcom,sdm845
 
+      - items:
+          - enum:
+              - oneplus,billie2
+          - const: qcom,sm4250
+
       - items:
           - enum:
               - sony,pdx201
-- 
2.37.3

