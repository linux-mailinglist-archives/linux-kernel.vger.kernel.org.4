Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9126E9ADE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 19:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbjDTRg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 13:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbjDTRgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 13:36:25 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9529544AF
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 10:36:23 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4ec817735a7so686489e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 10:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682012182; x=1684604182;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=luGj539pp3UeKX7ZE1UY5I+Ghz8yELYDvW80PLWj8ZM=;
        b=TpN1j+9cbp1/xk4eHnPogF47p/38uEqFoUu2zRmxb+U/FGKBuXBIgWxVJD7W8oQ3Dz
         jvWN6Byzi42MOfyA83MTSrFptYQKQliBX7WhP4MmQH4DCqcirpSTq9R+Mmc6Y6OTWxU0
         EYxWK6au7jNKNRd6JyPxrk89XPxx5BXjMEIoxyq1G3XVrMXprsPZT1QGelPJ+asBejco
         pz4crJW36GhnFRAb2HS9FwSD0u4FQvASypBsBB7OG+OaiZDMSgFsKakCSh9c59oqoyiz
         QnKJa57dscq+rtK609zxxCwMna/SZ9JX9EMth9TMF/lu2y/QroRBwBpkevZGRYy9VnEr
         oBEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682012182; x=1684604182;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=luGj539pp3UeKX7ZE1UY5I+Ghz8yELYDvW80PLWj8ZM=;
        b=Vjf023v2M57IuczMwnW8q0VxJled6Q0aYcauQ9fwuipAEulYOZMWMyTfhNEcJMt1pW
         cGWALnYeIlitBqn2cZT8aghpAw/ddtRofwoGkI6+CguGJskobVkOHjmr5MvqH7t+JjRw
         zub9s/JRq3BoM7l87H5lt/GezXv2C+bqFWuppaa7wg6xr4yfvfpEOMj99hKlb148npCC
         L+L2vnaklyWvFPyUo8SH+/1jQwybR/ahwIOHflJ4opavxRbwl6cKq9N6gjIGfx7oSjfA
         BAVc7EJYgV/VMq13Cxe355xWJeeEDzLv+1ITP16NP3+TH7D9CDl+Gm6bjcivq62+dIrr
         tk6A==
X-Gm-Message-State: AAQBX9cM6H+CX83lA/6HOVvfYrx9KiAgZCfoWg8lLCXzMzwHBCRKsYiw
        GaLgE8tULqF6eGyT0rp7FohoSQ==
X-Google-Smtp-Source: AKy350bIDK3WWRMTdeXUUQD5xH+cWDeF5IYJI4toNKGxmY6Cg+0mwkVVznwwfFFAz1KrW4mDE0s01Q==
X-Received: by 2002:a05:6512:4c9:b0:4da:fb89:fcc6 with SMTP id w9-20020a05651204c900b004dafb89fcc6mr582923lfq.57.1682012181767;
        Thu, 20 Apr 2023 10:36:21 -0700 (PDT)
Received: from [192.168.1.101] (abyj144.neoplus.adsl.tpnet.pl. [83.9.29.144])
        by smtp.gmail.com with ESMTPSA id l16-20020ac25550000000b004edc16dbdfasm281336lfk.119.2023.04.20.10.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 10:36:21 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Thu, 20 Apr 2023 19:36:17 +0200
Subject: [PATCH v6 1/2] dt-bindings: soc: qcom: Add RPM Master stats
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230405-topic-master_stats-v6-1-2277b4433748@linaro.org>
References: <20230405-topic-master_stats-v6-0-2277b4433748@linaro.org>
In-Reply-To: <20230405-topic-master_stats-v6-0-2277b4433748@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1682012179; l=3243;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=q81J4A/2z95qbACyYEJZy5TUp/FHfxF8n9PZuxO8IRM=;
 b=uGmg9eoUXmGK9YUe5u0buP48X6jodud90A1QBh1pC2u5UDcHRP6soBLxgVllESU0HAVHWFm+KBN9
 ODlk2Vy0CLz0FBQyF2NRRpoCk94iQHXpGNjpqN31Nv+XYnXUCr5U
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

The RPM MSG RAM contains per-RPM-master (e.g. APPS, ADSP etc.) sleep
statistics. They let one assess which core is actively preventing the
system from entering a true low-power mode.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../bindings/soc/qcom/qcom,rpm-master-stats.yaml   | 69 ++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,rpm-master-stats.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,rpm-master-stats.yaml
new file mode 100644
index 000000000000..031800985b5e
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,rpm-master-stats.yaml
@@ -0,0 +1,69 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/qcom/qcom,rpm-master-stats.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Technologies, Inc. (QTI) RPM Master Stats
+
+maintainers:
+  - Konrad Dybcio <konrad.dybcio@linaro.org>
+
+description: |
+  The Qualcomm RPM (Resource Power Manager) architecture includes a concept
+  of "RPM Masters". They can be thought of as "the local gang leaders", usually
+  spanning a single subsystem (e.g. APSS, ADSP, CDSP). All of the RPM decisions
+  (particularly around entering hardware-driven low power modes: XO shutdown
+  and total system-wide power collapse) are first made at Master-level, and
+  only then aggregated for the entire system.
+
+  The Master Stats provide a few useful bits that can be used to assess whether
+  our device has entered the desired low-power mode, how long it took to do so,
+  the duration of that residence, how long it took to come back online,
+  how many times a given sleep state was entered and which cores are actively
+  voting for staying awake.
+
+  This scheme has been used on various SoCs in the 2013-2023 era, with some
+  newer or higher-end designs providing this information through an SMEM query.
+
+properties:
+  compatible:
+    const: qcom,rpm-master-stats
+
+  qcom,rpm-msg-ram:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description: Phandle to an RPM MSG RAM slice containing the master stats
+    minItems: 1
+    maxItems: 5
+
+  qcom,master-names:
+    $ref: /schemas/types.yaml#/definitions/string-array
+    description:
+      The name of the RPM Master which owns the MSG RAM slice where this
+      instance of Master Stats resides
+    minItems: 1
+    maxItems: 5
+
+required:
+  - compatible
+  - qcom,rpm-msg-ram
+  - qcom,master-names
+
+additionalProperties: false
+
+examples:
+  - |
+    stats {
+      compatible = "qcom,rpm-master-stats";
+      qcom,rpm-msg-ram = <&apss_master_stats>,
+                         <&mpss_master_stats>,
+                         <&adsp_master_stats>,
+                         <&cdsp_master_stats>,
+                         <&tz_master_stats>;
+      qcom,master-names = "APSS",
+                          "MPSS",
+                          "ADSP",
+                          "CDSP",
+                          "TZ";
+    };
+...

-- 
2.40.0

