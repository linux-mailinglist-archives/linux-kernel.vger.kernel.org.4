Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2ED97149FD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 15:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbjE2NOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 09:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjE2NOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 09:14:30 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DD17DB
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 06:14:28 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4f4b2bc1565so3484189e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 06:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685366066; x=1687958066;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y+V7KYFuHBlcW45OH+41zrPJ2QlzAmwJ01YvxpqIdOY=;
        b=heEDyz0czFX7nvZcYkoL5KM3cb/debnJIH2icfy4MLPa9ya6cNZYEF5js/pUZ/CVf2
         CCjCPZrxJzV9vD2eqBKTKttlxrSDi4eQW6kPpINuDEEQeAGTvanDqQ4dEoJ6sWPhoxKK
         6g2/NJ6m193P2A0ai2qCnvDSxlGm2hkkW1mE40wjnKP2/ywrAQQvJudnVk1llm6DZc2d
         n+SRRvQxazTsCepMJzx55ci+/3RM30mLONX4oIHTFM+HVcXBrBJjWQvGc6gpCXNtsqdF
         VJorsUxrlQbkn/KzutuwDXcZXrwImunrz9tGvIGRd4a+ZmI7kvjHvsGsrWtwH7hO2j4b
         sjZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685366066; x=1687958066;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y+V7KYFuHBlcW45OH+41zrPJ2QlzAmwJ01YvxpqIdOY=;
        b=Bx2enMp5ylkVGTkqTEcJNx2SGSKjeo0NwF6PxaaGHRo6p4yALNgdeyR1qim+MNNCH1
         6Ru2fyK8+TFfuEozByZCvWv/DDSOVuLjvO3VgFWMZojZkwDPQlu6p1yZw7xfml3yJ/ki
         62KY6qhn9MDYGzp+IlmAQ9q5aYsME+EIHW8/ZzpktZfg+Pk4FqSKMeN0SvkkA2l5u8WD
         qmB8n2UQUgvMTHMnYHLjjPYJ+W+CXZyCLxS1VcmGU+eR67vX0Dxta1VUsLgligLn/Fmc
         NJSkTOi1/K+0stfPkkD/rRLAfveyAx/bI7Aa8ALgnCiGfomf862Xc6+zOvmUpRwXd1Ma
         zb4A==
X-Gm-Message-State: AC+VfDz/1Qxut9ucD8eQTJZLW37Of6VUlYINN8GwA2lkXcGLLC/uEA1j
        M1hceWUso1vsC+N4olkhwtiEER/W40lL8yv7Ufs=
X-Google-Smtp-Source: ACHHUZ7j20SK7rrraFhp/LOk0x4kKeh5uRiNhFtlZWnbqmYRAVyUyrPhnb7CnwVnvH44a4GNkLwC9Q==
X-Received: by 2002:ac2:5208:0:b0:4f3:a0f0:7c4a with SMTP id a8-20020ac25208000000b004f3a0f07c4amr3419633lfl.40.1685366066606;
        Mon, 29 May 2023 06:14:26 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id b30-20020ac25e9e000000b004eff4f67f1csm1966375lfq.304.2023.05.29.06.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 May 2023 06:14:26 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 29 May 2023 15:14:23 +0200
Subject: [PATCH 1/2] dt-bindings: clock: sm6375-gpucc: Add VDD_GX
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230529-topic-sm6375gpuccpd-v1-1-8d57c41a6066@linaro.org>
References: <20230529-topic-sm6375gpuccpd-v1-0-8d57c41a6066@linaro.org>
In-Reply-To: <20230529-topic-sm6375gpuccpd-v1-0-8d57c41a6066@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1685366063; l=1827;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=WQWF4JJc7yA9tWZ94p0YCyHtEC0Bk5E4nV1ZHYYfpQM=;
 b=zZUIuwkkxc6pabcOv6AenjuRpHNEF0ij5m1IkX94treKnyiYUsxZLrVX/P0U+/F7ckkRkoEHP
 42FKRKl7G0GDNfUEGh1PV/yZuQFxMZIgi+cRoo0IfTiRHfuJrzjHCLv
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GPUCC block on SM6375 is powered by VDD_CX and VDD_GX. If the latter
rail is not online, GX_GDSC will never turn on. Describe the missing
handles.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../devicetree/bindings/clock/qcom,sm6375-gpucc.yaml      | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,sm6375-gpucc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm6375-gpucc.yaml
index b480ead5bd69..cf4cad76f6c9 100644
--- a/Documentation/devicetree/bindings/clock/qcom,sm6375-gpucc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,sm6375-gpucc.yaml
@@ -27,9 +27,21 @@ properties:
       - description: GPLL0 div branch source
       - description: SNoC DVM GFX source
 
+  power-domains:
+    description:
+      A phandle and PM domain specifier for the VDD_GX power rail
+    maxItems: 1
+
+  required-opps:
+    description:
+      A phandle to an OPP node describing required VDD_GX performance point.
+    maxItems: 1
+
 required:
   - compatible
   - clocks
+  - power-domains
+  - required-opps
 
 allOf:
   - $ref: qcom,gcc.yaml#
@@ -40,6 +52,7 @@ examples:
   - |
     #include <dt-bindings/clock/qcom,sm6375-gcc.h>
     #include <dt-bindings/clock/qcom,rpmcc.h>
+    #include <dt-bindings/power/qcom-rpmpd.h>
 
     soc {
         #address-cells = <2>;
@@ -52,6 +65,8 @@ examples:
                      <&gcc GCC_GPU_GPLL0_CLK_SRC>,
                      <&gcc GCC_GPU_GPLL0_DIV_CLK_SRC>,
                      <&gcc GCC_GPU_SNOC_DVM_GFX_CLK>;
+            power-domains = <&rpmpd SM6375_VDDGX>;
+            required-opps = <&rpmpd_opp_low_svs>;
             #clock-cells = <1>;
             #reset-cells = <1>;
             #power-domain-cells = <1>;

-- 
2.40.1

