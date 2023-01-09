Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5551A662373
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 11:48:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236420AbjAIKsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 05:48:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236818AbjAIKsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 05:48:07 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D0EEBE9
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 02:48:04 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id d17so7711699wrs.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 02:48:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s3YhczK4urURUC1Olx6x7ih5A9tdexOnktWzKva3cnQ=;
        b=lgyQ4xsUnsH/rYZCIu2ULrX6UVcXR5EJlAR2aUfStMs+y/zZNCYKqpNYYS937Yps9s
         Avtg2mbLsxD29yxHXu08LrIJxiCvEb39VkDRrca+jMngkX6PayyBWzldr8qABQcr2nFw
         uhmPT6kt4nkb7EsjtP479wQ4pUzu++oV5mZEXW11pj+lG5FhaJzeQxmRVPzyQCc+jGh7
         CZGVHgdAy9j6uwuaFr4re/BbVoFhEsYb/WMSJMK0tFOXGfbEehFQ+BYzXJvNxFjDvRzs
         yceV8jr1wgG2pRpzOFh+zwmT0idJDXVAAP4g3dHtRygpCrnwrC6mG0V1rFj3W/BHEBL8
         0lwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s3YhczK4urURUC1Olx6x7ih5A9tdexOnktWzKva3cnQ=;
        b=QciN/n0Iu+wO9XSBydm3sbmfR15bAUChAhGOVxDOgHPHT1/tY0ldRFp0zW1Dlu+kQ5
         QJXncclQIpUM7+zhpaJXzBj5MQyJOT/Y40N4pn/O405/22v8c83oU0qCAMexoCPaR1im
         iir61v4rwSc6RIKkn/PzN2cOVttOrpC2QDwnwNJLXNkQs5rqLYuaxiiNSERBMkI4JV74
         5vl99bRFl89sdFXlNZ12SB5C7UioGxTZc7kAhdfBuaBB5RTcrw0dQaoNJbCBpdbluxBQ
         +x6HFKjG6X3MLUVsK7eH2CaqoHDrd0q/st0OGnC+5Er0dFlkk8jdbCiz8gFTXWp/R8ft
         IQ4A==
X-Gm-Message-State: AFqh2kqYWORByU2sKDvSwzEhaNFt8sCjAW4R8CB1OLnKXANlOFCWPvAi
        1IaJ5lrMHwtC1BVM8hlZZA0z7A==
X-Google-Smtp-Source: AMrXdXv2Bv0wTWz616z6eiWLcOwogUH1tk9up7HtMdkvkY2lbZS4AY/HhxmPlBn0JbEXNkukgzrWHA==
X-Received: by 2002:a5d:6244:0:b0:2bb:9106:d10 with SMTP id m4-20020a5d6244000000b002bb91060d10mr4355079wrv.10.1673261282553;
        Mon, 09 Jan 2023 02:48:02 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id y15-20020adffa4f000000b002bbec19c8acsm2945605wrr.64.2023.01.09.02.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 02:48:02 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Mon, 09 Jan 2023 11:47:42 +0100
Subject: [PATCH v6] dt-bindings: regulators: convert non-smd RPM Regulators
 bindings to dt-schema
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221005-mdm9615-pinctrl-yaml-v6-1-6c913908bb85@linaro.org>
X-B4-Tracking: v=1; b=H4sIAM7wu2MC/43Nz2rDMAwG8FcpPs9D8r/WO+09Sg+2ozQGxxl2F
 ygl7z6x28hhOYlP4vvpJTq1TF18nF6i0Zp7XioH93YSaQr1TjIPnIUCpRDAynmYvUMrv3JNj1bk
 M8xFoh5twkswgw6CqzF0krGFmiYu1+9SeDnl/lja8/fVijyu/6grSpCQYgJwpIKGz5JraMv70u7
 ixuKqjiiKFaf9SO4cwETaKfqIolkhS2CsM8afcaeYI4phxThtlfboE/qdYo8olhXPd/RjvEQf/y
 jbtv0ArgMZzdYBAAA=
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh@kernel.org>
X-Mailer: b4 0.11.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the non-SMD Regulators bindings to dt-schema, the old text based
bindings will be deleted later since the RPM bindings are not yet converted.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
This is a second round of bindings & DT fixes for the MDM9615 platform.

This second round focuses on less trivial changes like pinctrl & regulators bindings,
the remaining work will mainly be fixing the qcom,kpss-timer/qcom,msm-timer situation and
add bindings for qcom,lcc-mdm9615, qcom,kpss-gcc & swir,mangoh-iotport-spi.

Dependencies: None
---
Changes in v6:
- Fixed ref error on patch 1
- Dropped applied patch 2
- Link to v5: https://lore.kernel.org/r/20221005-mdm9615-pinctrl-yaml-v5-0-910019fb8b9b@linaro.org

Changes in v5:
- Fixed bindings invalid id after rename
- Fixed invalid ref path to qcom,rpm-regulator.yaml from qcom,rpm.yaml bindings
- Link to v4: https://lore.kernel.org/r/20221005-mdm9615-pinctrl-yaml-v4-0-463523919c19@linaro.org

Changes in v4:
- Removed applied patches
- Removed "-ipc" from bindings file name and removed IPC from title & description
- Added the review tags from v3 after file renaming & title/description change, after Lee's acceptation
- Link to v3: https://lore.kernel.org/r/20221005-mdm9615-pinctrl-yaml-v3-0-e5e045644971@linaro.org

Changes in v3:
- Path 1: Removed from serie because applied
- Path 2: None
- Path 3: Added reviewed-by tag
- Path 4: Fixed dt-schema title and added unevaluatedProperties
- Path 5: Various schema fixes, uses same naming as other dt-schema for qcom regulators
- New patch added changing regulators names of msm8660 to conform to bindings
- Link to v2: https://lore.kernel.org/r/20221005-mdm9615-pinctrl-yaml-v2-0-639fe67a04be@linaro.org

Changes in v2:
- Rebased on v6.1-rc1
- Patch 1: Fixed bindings and aligned with Krysztof's series
- Patch 2: Rewrote patch title and added reviewed-by tag
- Patch 3: Added reviewed-by tag
- Patch 4: Moved to end, added support for (regulators|-regulators) sudnode
- Patch 5: Fixed schema description and added missing unevaluatedProperties in patternProperties
- Patch 6: Dropped & squashed with patch 4
- Link to v1: https://lore.kernel.org/r/20221005-mdm9615-pinctrl-yaml-v1-0-0cbc006e2a30@linaro.org
---
 .../bindings/regulator/qcom,rpm-regulator.yaml     | 128 +++++++++++++++++++++
 1 file changed, 128 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/qcom,rpm-regulator.yaml b/Documentation/devicetree/bindings/regulator/qcom,rpm-regulator.yaml
new file mode 100644
index 000000000000..8a08698e3484
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/qcom,rpm-regulator.yaml
@@ -0,0 +1,128 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/qcom,rpm-regulator.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm RPM regulator
+
+description:
+  The Qualcomm RPM regulator is modelled as a subdevice of the RPM.
+
+  Please refer to Documentation/devicetree/bindings/soc/qcom/qcom,rpm.yaml
+  for information regarding the RPM node.
+
+  The regulator node houses sub-nodes for each regulator within the device.
+  Each sub-node is identified using the node's name, with valid values listed
+  for each of the pmics below.
+
+  For pm8058 l0, l1, l2, l3, l4, l5, l6, l7, l8, l9, l10, l11, l12, l13, l14, l15,
+  l16, l17, l18, l19, l20, l21, l22, l23, l24, l25, s0, s1, s2, s3, s4,
+  lvs0, lvs1, ncp
+
+  For pm8901 l0, l1, l2, l3, l4, l5, l6, s0, s1, s2, s3, s4, lvs0, lvs1, lvs2, lvs3,
+  mvs
+
+  For pm8921 s1, s2, s3, s4, s7, s8, l1, l2, l3, l4, l5, l6, l7, l8, l9, l10, l11,
+  l12, l14, l15, l16, l17, l18, l21, l22, l23, l24, l25, l26, l27, l28,
+  l29, lvs1, lvs2, lvs3, lvs4, lvs5, lvs6, lvs7, usb-switch, hdmi-switch,
+  ncp
+
+  For pm8018 s1, s2, s3, s4, s5, l1, l2, l3, l4, l5, l6, l7, l8, l9, l10, l11,
+  l12, l14, lvs1
+
+  For smb208 s1a, s1b, s2a, s2b
+
+maintainers:
+  - Bjorn Andersson <andersson@kernel.org>
+
+properties:
+  compatible:
+    enum:
+      - qcom,rpm-pm8058-regulators
+      - qcom,rpm-pm8901-regulators
+      - qcom,rpm-pm8921-regulators
+      - qcom,rpm-pm8018-regulators
+      - qcom,rpm-smb208-regulators
+
+patternProperties:
+  ".*-supply$":
+    description: Input supply phandle(s) for this node
+
+  "^((s|l|lvs)[0-9]*)|(s[1-2][a-b])|(ncp)|(mvs)|(usb-switch)|(hdmi-switch)$":
+    description: List of regulators and its properties
+    $ref: regulator.yaml#
+    unevaluatedProperties: false
+    properties:
+      bias-pull-down:
+        description: enable pull down of the regulator when inactive
+        type: boolean
+
+      qcom,switch-mode-frequency:
+        description: Frequency (Hz) of the switch-mode power supply
+        $ref: /schemas/types.yaml#/definitions/uint32
+        enum:
+          - 19200000
+          - 9600000
+          - 6400000
+          - 4800000
+          - 3840000
+          - 3200000
+          - 2740000
+          - 2400000
+          - 2130000
+          - 1920000
+          - 1750000
+          - 1600000
+          - 1480000
+          - 1370000
+          - 1280000
+          - 1200000
+
+      qcom,force-mode:
+        description: Indicates that the regulator should be forced to a particular mode
+        $ref: /schemas/types.yaml#/definitions/uint32
+        enum:
+          - 0 # QCOM_RPM_FORCE_MODE_NONE do not force any mode
+          - 1 # QCOM_RPM_FORCE_MODE_LPM force into low power mode
+          - 2 # QCOM_RPM_FORCE_MODE_HPM force into high power mode
+          - 3 # QCOM_RPM_FORCE_MODE_AUTO allow regulator to automatically select its own mode
+              # based on realtime current draw, only for pm8921 smps and ftsmps
+
+      qcom,power-mode-hysteretic:
+        description: select that the power supply should operate in hysteretic mode,
+          instead of the default pwm mode
+        type: boolean
+
+additionalProperties: false
+
+required:
+  - compatible
+
+examples:
+  - |
+    #include <dt-bindings/mfd/qcom-rpm.h>
+    regulators {
+      compatible = "qcom,rpm-pm8921-regulators";
+      vdd_l1_l2_l12_l18-supply = <&pm8921_s4>;
+
+      s1 {
+        regulator-min-microvolt = <1225000>;
+        regulator-max-microvolt = <1225000>;
+
+        bias-pull-down;
+
+        qcom,switch-mode-frequency = <3200000>;
+      };
+
+      pm8921_s4: s4 {
+        regulator-min-microvolt = <1800000>;
+        regulator-max-microvolt = <1800000>;
+
+        qcom,switch-mode-frequency = <1600000>;
+        bias-pull-down;
+
+        qcom,force-mode = <QCOM_RPM_FORCE_MODE_AUTO>;
+      };
+    };
+...

---
base-commit: 1b929c02afd37871d5afb9d498426f83432e71c2
change-id: 20221005-mdm9615-pinctrl-yaml-13f5c18a4d3a

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>
