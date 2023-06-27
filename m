Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12F0E740348
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 20:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbjF0SbD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 14:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbjF0Sa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 14:30:57 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F8C2E71
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 11:30:52 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4fb7589b187so3907931e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 11:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687890650; x=1690482650;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dAlp+yDxSxsRQptzR5NDOwv6iD3bpQxnIcoaRH90yZA=;
        b=ILqCNtGqQXZISlUOCXmTfwPZWX3osMK5JSpd/zmUpEkbvmV5Y3ac1JYkrRG9xLV1mq
         ptpJ5wkBAqcqgmfVIdfl6spXQnJz3uuyda5rohv9Pv+QWISU5RLSPeKJg1Cb2x1krpc+
         UvivWz4rVznvYnm7GfLJfjvOmZE8LfYIsYf9j5TeqZ+MCjgIiMyiBm8HMJzpzj2u1RgL
         4F8Cy0y6V7TF0bBjt6Ue3oCyu5D2EgHKcgG9BlDnEPtOZ3uWiZu1a4gH/4ZtEa6SwLdT
         JU2vsuHlazt+v5L6QwmVKPRDB3rSYHanNwi+QlXmsiX+7pq90Um45dalKecA40E6F94q
         PDaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687890650; x=1690482650;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dAlp+yDxSxsRQptzR5NDOwv6iD3bpQxnIcoaRH90yZA=;
        b=GaWFt8ABjj7e5y8Q6uydJEDCQ1orzbPnmQPyfat/+BO4bZglehPoQpOiAD+ALdFtjp
         lCn8bK1syCbQSM1arCqYz3PeXGGIbQWDACuz/DEulo8T+PjClXoo2iJKuLR9EKzq4tI7
         esosPx/GE8N64xqDYbVaozrGXdgbxKYKrHgNUpg0pMd0d/sPBtUTtW7dMuLlc7fxY0l7
         rzn79ee0Yn887rVzpii269uvPEPA5HncxJWz7nCbm0vOS7/zwerzwBmNrC90vlVwtdNR
         Bt0oTyOp8KiJiCRq5rUN/RKPk/x8Xn2JlVUU8SzZmnMfeQNoK7xVwc7X/2CvgmGj+eRT
         gZuw==
X-Gm-Message-State: AC+VfDxek+AJg//GYukmwD8trp+wsAkOq0CEx5cOiRRMaokmeiBHgEnl
        ByZZAE34BIn3oDJ2Jbhs5XW1Cw==
X-Google-Smtp-Source: ACHHUZ51IbO1DU4xTXVMOv7H43ylTD06BP0GttZE6+0R2eji9UBzZT59jyKTT7AHqQn8JAs9Xh3AmQ==
X-Received: by 2002:a05:6512:3f24:b0:4fb:7be5:7404 with SMTP id y36-20020a0565123f2400b004fb7be57404mr3813308lfa.63.1687890650498;
        Tue, 27 Jun 2023 11:30:50 -0700 (PDT)
Received: from [192.168.1.101] (abxj103.neoplus.adsl.tpnet.pl. [83.9.3.103])
        by smtp.gmail.com with ESMTPSA id q16-20020ac25290000000b004f640b0fb04sm1605205lfm.212.2023.06.27.11.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 11:30:50 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 27 Jun 2023 20:30:38 +0200
Subject: [PATCH v11 2/9] dt-bindings: opp: v2-qcom-level: Document CPR3
 open/closed loop volt adjustment
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230217-topic-cpr3h-v11-2-ba22b4daa5d6@linaro.org>
References: <20230217-topic-cpr3h-v11-0-ba22b4daa5d6@linaro.org>
In-Reply-To: <20230217-topic-cpr3h-v11-0-ba22b4daa5d6@linaro.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Niklas Cassel <nks@flawful.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Robert Marko <robimarko@gmail.com>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687890646; l=1423;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=WRqHzfry/bVzZ1IkMj1Q1p4NGE07AGHXQmZVGRY1FDM=;
 b=8PnKSlSpFTAIQOFe6Wpt3Z1SBO7+E5nltoD5pfvymK2X6cRPhM+rEPderSS3ylCMfic97+IAy
 VWhMFkHN9bvBkapwbKZi4AkyqVM9Omoq9NozF0FxTFAJSryR9622bCG
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CPR3 and newer can be fed per-OPP voltage adjustment values for both
open- and closed-loop paths to make better decisions about settling
on the final voltage offset target. Document these properties.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../devicetree/bindings/opp/opp-v2-qcom-level.yaml         | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/opp/opp-v2-qcom-level.yaml b/Documentation/devicetree/bindings/opp/opp-v2-qcom-level.yaml
index a30ef93213c0..b203ea01b17a 100644
--- a/Documentation/devicetree/bindings/opp/opp-v2-qcom-level.yaml
+++ b/Documentation/devicetree/bindings/opp/opp-v2-qcom-level.yaml
@@ -34,6 +34,20 @@ patternProperties:
         minItems: 1
         maxItems: 2
 
+      qcom,opp-cloop-vadj:
+        description: |
+          An array of per-thread values representing the closed-loop
+          voltage adjustment value associated with this OPP node.
+        $ref: /schemas/types.yaml#/definitions/int32-array
+        maxItems: 2
+
+      qcom,opp-oloop-vadj:
+        description: |
+          An array of per-thread values representing the open-loop
+          voltage adjustment value associated with this OPP node.
+        $ref: /schemas/types.yaml#/definitions/int32-array
+        maxItems: 2
+
     required:
       - opp-level
       - qcom,opp-fuse-level

-- 
2.41.0

