Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF0D66E225C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 13:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbjDNLha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 07:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbjDNLhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 07:37:24 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A1A27D81
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 04:37:22 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id b40so2505562lfv.4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 04:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681472241; x=1684064241;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pjBdsofLs3+4G8st7nvJWY7fIQpctrGr3PE8MEm6BzQ=;
        b=hzBrlhIvvN0RTsEhtWNx+QObaZS+HtMR7hvASL5X7M4Cka95Zh5IcSJ9AHEeqWuTbe
         gahQC08KkM7RGtu2FyPu7TZ4/XJLl6+ts3mraEf2g9mqKvavi2z46+eRA7LG/N8T+ByF
         41uiuEFyGE4bNjJyHXfhDOBJOe1DZWbpYzNU/+0aoopz0KpwplaUi3dwqcGst/Js8/cy
         uVPM9GToWGAiElnqsuQtjY3o+Bgbc7qB4R/5fsODUttHg2WrduNW5+6XZGzEJG32a3WN
         bskJFl6oIsh9sh6MCnEJPmA1dbJToIIvmuQXv/JaCG7wZCKGI5ewvQLygaI9CKq8L6Lt
         XBpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681472241; x=1684064241;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pjBdsofLs3+4G8st7nvJWY7fIQpctrGr3PE8MEm6BzQ=;
        b=fafgQChxzYZDYd5u08eZ/lQNYA6QIsfqJ5ucFrrwROfRh94E+QrDIVbiqViSiBJt9Z
         CxqPKyCCKgiXl1dsQwY2s8YNfMwTQ3Ctzyphz6fOc+lmK0r9HLcu8tlg15eN7lXEaz70
         0cNxZw1Vldws8WcgJBjAWhGzr5yTJH6WpXoBp1Fx1h8vrim3dsQ3mr6nIPeojTdL3Nan
         aQAnHlJZnQumggDhCEhzQEMubg6BUt2BpGkTjqAFy+sRkGiV9Zs+q7fFuO1t1mcnPccZ
         3uExUlPgvrxt5D5p0Xwh6HljzhlOnbFtCPdRFVTgF8+yNFIu/+Uy1cLULZlDViMcP4LR
         jeVg==
X-Gm-Message-State: AAQBX9dyTSB5gYMYzqo/OtJUkE2bqVIWXUqvMXrFxlueL+/bLB8JxnUE
        OEd8cTCP9OwxHFhyUGTu6Zr3Lw==
X-Google-Smtp-Source: AKy350a8UFvi0ALlRJcb1lA0q+2SLkQixgXy3apO9rO+ZLS1exRSo+TH5mffAezgjNgDDuSuLyrTFg==
X-Received: by 2002:a05:6512:511:b0:4eb:4160:7ca9 with SMTP id o17-20020a056512051100b004eb41607ca9mr1500868lfb.16.1681472240817;
        Fri, 14 Apr 2023 04:37:20 -0700 (PDT)
Received: from [192.168.1.101] (abyl123.neoplus.adsl.tpnet.pl. [83.9.31.123])
        by smtp.gmail.com with ESMTPSA id y5-20020ac24e65000000b004ec83bc3e43sm756946lfs.192.2023.04.14.04.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 04:37:20 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 14 Apr 2023 13:37:17 +0200
Subject: [PATCH v3 1/2] dt-bindings: soc: qcom: Add RPM Master stats
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230405-topic-master_stats-v3-1-2cb2ba4f2092@linaro.org>
References: <20230405-topic-master_stats-v3-0-2cb2ba4f2092@linaro.org>
In-Reply-To: <20230405-topic-master_stats-v3-0-2cb2ba4f2092@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1681472238; l=2174;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=TH1zgnCa8zRbU3KMG+EVZMt/V85Or/9zrfIZNwaDzLA=;
 b=P45AxPiiNgpI9Zd/uzJUdSIwikCqiN0AsWEGmaeP0EgoKO/c4S8+MZiWRWa8DXYOruEbYAFvNtT5
 cM+ZFzqOBJNDIeUrg17h1Su9k8HVu9S1lnBNSncGlZSV9zxlPY/t
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RPM MSG RAM contains per-RPM-master (e.g. APPS, ADSP etc.) sleep
statistics. They let one assess which core is actively preventing the
system from entering a true low-power mode.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../bindings/soc/qcom/qcom,rpm-master-stats.yaml   | 53 ++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,rpm-master-stats.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,rpm-master-stats.yaml
new file mode 100644
index 000000000000..d7e58cbd3344
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,rpm-master-stats.yaml
@@ -0,0 +1,53 @@
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
+description:
+  Per-RPM-Master (e.g. APSS, ADSP, etc.) sleep statistics.
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
+    description: RPM Master name
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

