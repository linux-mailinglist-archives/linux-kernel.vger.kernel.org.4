Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 237C569A9D4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 12:09:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjBQLJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 06:09:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbjBQLJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 06:09:00 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B8066656
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 03:08:30 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id o3so1207689lfo.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 03:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JoW4ktb7yfQrVNdteP+d/T//uPLuGe0EFh4utClSrWM=;
        b=XxbXWZ9faszV4z77drGKZ9RfYtLI6Jv463K74P/SIrZG9W5ySH4389O5cGssLv5OAh
         MIAdilPPHymeNn8PWuUJAv156JinemijPiD9zlhnNIjehLVP686O093WFAD1vtgaeTwD
         1rApIEc3xnYyFzQ69HUryVfmGEssFFDjiIEdX3gMF8OipBGCV3DOactcOvttUlJ6i7Dv
         z6biLLFoaHBY/Kn/Dt5aAv0LGbc8EeK1csDDwMLD1m/7QK3xntqaErbcaxt8b/dG/BVE
         ROM7EFwarFMXH2iULJJQ4ht+R1O9RfM386qvcbfFXX7DvdWCrK/B+/zOytbVsBfPA68r
         MPtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JoW4ktb7yfQrVNdteP+d/T//uPLuGe0EFh4utClSrWM=;
        b=ZxKNgmmMQnSRI3EVShg5Q+2iOLHNGuzaOuDbrMt4jRgoLwXTPTFGZQBwVq6WLRtUVt
         g38gSSBmlSbesQZ9FyIGDGvbKhzdITWNs2FJRmV75XaMe8ghPDN/NoQFP1H/gpB6r+dM
         LN7fDUMDVEwiOwgT3AgZMbFk6DDCyH451mxg1DIxdjYy8nu0gHQHeTef1cMlQ8OkUefk
         4q9+9AzK0tFz/GA4VLQvStcZqRqut9e6d0yqUJ+ntqdVVcUlPnXb1eH1Y7S3xsTaLxTP
         iSZ4/ToCi/Ynx+VH4wT4aJzMTvgAPliCuum8KK4sinJ/wMcB/c8kA7Zt5PKT+9UhxmQ1
         4gOg==
X-Gm-Message-State: AO0yUKVpeZ1Rv3HX6lHYfOFJDf7g6861lf15h6C7RVL/uorFsew0/YlR
        Fz2+a5byYvozb7MQ0lwUBvaDZA==
X-Google-Smtp-Source: AK7set+Vq49sN0ycDq0ivColuUJ0U7G+yZLL0scXsiolH+vWRP4vJiVVUYe6Ip0KroOIKEEa4xmhjw==
X-Received: by 2002:ac2:5453:0:b0:4b4:e4a1:2fc6 with SMTP id d19-20020ac25453000000b004b4e4a12fc6mr191778lfn.68.1676632108762;
        Fri, 17 Feb 2023 03:08:28 -0800 (PST)
Received: from [192.168.1.101] (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id a12-20020a056512020c00b004b57162edfasm640162lfo.117.2023.02.17.03.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 03:08:28 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 17 Feb 2023 12:08:25 +0100
Subject: [PATCH v10 2/6] dt-bindings: opp: v2-qcom-level: Document CPR3
 open/closed loop volt adjustment
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230217-topic-cpr3h-v10-2-67aed8fdfa61@linaro.org>
References: <20230217-topic-cpr3h-v10-0-67aed8fdfa61@linaro.org>
In-Reply-To: <20230217-topic-cpr3h-v10-0-67aed8fdfa61@linaro.org>
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
        Mark Brown <broonie@kernel.org>
Cc:     Robert Marko <robimarko@gmail.com>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1676632104; l=1379;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=cFLhE91kk6nAFRpw11bXMz02kwYFI7RIwXU7++yrFKw=;
 b=RJQ0C3ZbWrh50VeKzPj1kBZUKeSDywTiIYAFKtz+vPHz6ZkLEISUpm/siTIu+Ms9G8Y31zQ/TFMm
 pytESZ62CC2hUlsdVHptVYx61ZSUWcOuPME38gmY+fLx9Q5Wq99G
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
index a30ef93213c0..93cc88434dfe 100644
--- a/Documentation/devicetree/bindings/opp/opp-v2-qcom-level.yaml
+++ b/Documentation/devicetree/bindings/opp/opp-v2-qcom-level.yaml
@@ -34,6 +34,20 @@ patternProperties:
         minItems: 1
         maxItems: 2
 
+      qcom,opp-cloop-vadj:
+        description: |
+          A value representing the closed-loop voltage adjustment value
+          associated with this OPP node.
+        $ref: /schemas/types.yaml#/definitions/int32-array
+        maxItems: 2
+
+      qcom,opp-oloop-vadj:
+        description: |
+          A value representing the open-loop voltage adjustment value
+          associated with this OPP node.
+        $ref: /schemas/types.yaml#/definitions/int32-array
+        maxItems: 2
+
     required:
       - opp-level
       - qcom,opp-fuse-level

-- 
2.39.1

