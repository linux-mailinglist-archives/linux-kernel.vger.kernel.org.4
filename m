Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2716D8043
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 17:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238361AbjDEPBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 11:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238433AbjDEPBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 11:01:46 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC595259
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 08:01:43 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id g19so33917427lfr.9
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 08:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680706901;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W6Ju8CIEzaK87pEwl0n+uObDKxQlL1nqcBRnevkvACM=;
        b=uHp/SrAjB5GGfZSeT+l/3+ThUPUu3B/tMP0PlBveDZHPHNEJWpcnOnvUTsfokgXHvZ
         X1Vb98woe/BIBj8nlp7rpSGeomPfpdgHBoqeiBBcLmex6ZgXi08MvUBJl/9nsChJ6cs9
         7iv9F85ItKQx7AP8qJkPa5hAEWANaY/IIs46wvZcg2SdBdoBTOcTzEntuDNhDtxNmZ/9
         3tpDZakhfUfXC9vKE2QmeJFu0tyMU6/UsQx8E8gUYqDJfBtB1YcjRZrLm7h/YhB09nZi
         6fROQkxje+KbNI9ytKTHvSBLKakIY+SrkzfQqbiPAHMcY2sOxZKc+BMq32N7SBrcEpLI
         CItg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680706901;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W6Ju8CIEzaK87pEwl0n+uObDKxQlL1nqcBRnevkvACM=;
        b=SIdIT/rI9UXFxONWkowwNkjTsAyjtJkSzJiNq8jH14f2X3Bn3KR2lReLef5NHSwrwK
         +OgEndW7J9p7gAqANtjPdj/eb30QPcpo68o8RSqLywABgHA44Kd3WmofCv0Lof3w11el
         Yn5CC/kzY8KCKt1OQyo2VQ9NY0ht83ujyX78fCuhtKodLNffxZnkjKqcOXZi6HoQUoXM
         B8CaM+NEQa7MQFkAIDMqiA8qO1nmlUAW57lwLU2KHpEefjBiIeijWz1dksrhfaQlukPn
         ZDTtePCotwsYmNqnV62iUsK2F2mJnAfdqwZWRtcWzXLtLU7M1gEStYJ6CB8vhs6CYCk6
         GPsQ==
X-Gm-Message-State: AAQBX9exYJgmLNvkHnAuhJDC+XCCLbFe5QbU7F0Lt8jEkg+0XWskBX4j
        v0vIU1g/FH1fSDyE/DBW2/nXAQ==
X-Google-Smtp-Source: AKy350bcrLsgvnZEp83uglMTecfngvgNLBjJJ0rdOZ+HUySu3Xduj0QVb2DSDf6+BKt89TbZ3lKSjQ==
X-Received: by 2002:ac2:43db:0:b0:4cb:4374:cc78 with SMTP id u27-20020ac243db000000b004cb4374cc78mr1825915lfl.26.1680706901595;
        Wed, 05 Apr 2023 08:01:41 -0700 (PDT)
Received: from [192.168.1.101] (abxh37.neoplus.adsl.tpnet.pl. [83.9.1.37])
        by smtp.gmail.com with ESMTPSA id 16-20020ac25690000000b004e84896253asm2833994lfr.251.2023.04.05.08.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 08:01:41 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 05 Apr 2023 17:01:35 +0200
Subject: [PATCH 1/2] dt-bindings: soc: qcom: Add RPM Master stats
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230405-topic-master_stats-v1-1-1b1fa2739953@linaro.org>
References: <20230405-topic-master_stats-v1-0-1b1fa2739953@linaro.org>
In-Reply-To: <20230405-topic-master_stats-v1-0-1b1fa2739953@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1680706899; l=2156;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=pOnWKQ9D5V1MjOyO4kKJpCciYdrkhMQtlWjnxKSUZfQ=;
 b=kgxETiISULWaSx50jp87qTXp6E9fgC29ravRA/S3GQbrjwlyxn37Hl8hhyYJffco835ubl/035zo
 o6vZrtGmAjlrRXgy2U4TnUyqjvt//XxEvqlDAN1x793Uyp1UgsSp
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
 .../bindings/soc/qcom/rpm-master-stats.yaml        | 53 ++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/qcom/rpm-master-stats.yaml b/Documentation/devicetree/bindings/soc/qcom/rpm-master-stats.yaml
new file mode 100644
index 000000000000..e8e71e75d161
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/qcom/rpm-master-stats.yaml
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/qcom/rpm-master-stats.yaml#
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
+    - const: qcom,rpm-master-stats
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

