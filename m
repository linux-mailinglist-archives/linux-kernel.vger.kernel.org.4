Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F149A6E79A5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 14:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233111AbjDSMXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 08:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233214AbjDSMX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 08:23:28 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E7DA83D8
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 05:23:25 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2a8b3ecf59fso27093561fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 05:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681907003; x=1684499003;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rpIrKGGSuGWfWoM6hvqicgJY+QR4yE0dRd/xAmGj4Vk=;
        b=azVSMzjNenkmgem6Oe0hWPFKOwsCHgbHWMLXJ28e6ZxNmp7PCJvtCCaDdygiIrjwyr
         tScYR7rXvC+Lg10tvwGReL1RV9nKYyuEz9e3BJuajHu2g5PyWpFdIzP8Lg3WvlwnB2ph
         JVEq+U032vYj21ScvJXWgrdlbdxU43eOov5ZAYs0/d7Qg8LvHZnXWkQdxK+Fkzp34EWM
         Z5HhLOrpNrsP9rwyqCQA9LepbxFv5+X5vfschdJrltUEgMracRVa1qrZOJfmoXJ4aUVr
         uVT/p+BI7NdJDnwkJw8NlfE/GIPsbRWY6qFjQkzytpnRfIKsGOV/10UENqmy6uvpBnJ2
         wm4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681907003; x=1684499003;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rpIrKGGSuGWfWoM6hvqicgJY+QR4yE0dRd/xAmGj4Vk=;
        b=OnO+TiAJl/10Mly9ZXouPvCFG0xaYe4tC6CG/YLZnYyZS4rjmLNM0MHP8NvJbj9khw
         Zgp/Geh0jHlj8E7z+j+85sGim3Y75cPYApl8oB5INvFxlrUgaJpgE41eGpx/4e1wWc9n
         e7QCTVFnBtA9miXqvo1+5t9ROBoHjnWR599FGnu0FagrkTG5j6X/Ea7fIgMs7cgO5KMf
         KN8FQk/gACMUlzIDqnDtQtK7ZMxvUbZ13H/TorroTtxkXKUkvPHTZsu7/q7KmkTu/Lpt
         Bu/Np4V05jb+cZK2EZCTVsGzehooZqsPPH+Xr+M4ptlBbpMHp/Ciy7Thurxf1LeR4dYI
         NhRQ==
X-Gm-Message-State: AAQBX9fKGKTgJVOxZk2xO6u8FqfCQvKzu22ByjCap7hpenFs7oxWirck
        K5MYIvvaFHVidaoTHV9M1JeajQ==
X-Google-Smtp-Source: AKy350YUWVlbiha/VXyCsQIxcwwqUaHjLH3eUPzyALQnO3vkbpfApgWBZx5XkVFDC48tTqGMUUuSFA==
X-Received: by 2002:a19:f71a:0:b0:4ed:d4ac:1e17 with SMTP id z26-20020a19f71a000000b004edd4ac1e17mr1539663lfe.49.1681907003424;
        Wed, 19 Apr 2023 05:23:23 -0700 (PDT)
Received: from [192.168.1.101] (abyj144.neoplus.adsl.tpnet.pl. [83.9.29.144])
        by smtp.gmail.com with ESMTPSA id a23-20020a2e8317000000b002a79d7ceb93sm2925550ljh.9.2023.04.19.05.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 05:23:23 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 19 Apr 2023 14:23:20 +0200
Subject: [PATCH v5 1/2] dt-bindings: soc: qcom: Add RPM Master stats
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230405-topic-master_stats-v5-1-2e1c98a8b63e@linaro.org>
References: <20230405-topic-master_stats-v5-0-2e1c98a8b63e@linaro.org>
In-Reply-To: <20230405-topic-master_stats-v5-0-2e1c98a8b63e@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1681907001; l=3242;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=p+kMF2wI4gUD7vWxW6rNWesT2Ay4RZ53dQRi1h/ATdY=;
 b=q1DsNMEJ7vggCx+E2l6mlDctPkj30e8vrqGILNMEjQZu/dcOjiT04Xcutcj2BpdCzw+0QJ6FMmYB
 tA/Q3z4hDRcHlc8C0Y+YQ9jtMgZgAmn+vBk35D67i/yTOKGMZN10
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
index 000000000000..8a654979ce92
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
+  spanning a single subsystem (e.g. APSS, ADSP, CDSP). All of the RPM decisons
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

