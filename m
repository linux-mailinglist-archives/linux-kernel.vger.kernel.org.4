Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA5068D9E4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 14:56:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232322AbjBGN44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 08:56:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231733AbjBGN4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 08:56:41 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB733802E
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 05:56:11 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id k13so6225946wrh.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 05:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QX4rZ/apusxA+kOocMUgPZzFJ0GB7RlYqxdsd8KGKjw=;
        b=ZePF7sbU5Y7OjGS2yW0g9dLDgyFY7/XNsDvb4KSI8zVo4duMujEAIRIDEAYzgW/aJA
         FXn4Dgir0houDF4USc1XH2s73/6rqJurfSkOeT1oH1oxUfxBf6PCNk3HVe/YGNwhKxjZ
         qPZVgPpkhtfd0Ru0984YUutdfo1dTodUWIjs4lNTELSKRLfCXPDs0+9zz1wsd8bIIZFl
         iyjbxsWzCmYzqO7DjEQkem0WgEleR8XNZPpIIvOCgElV+Tx2q5aeKr9ebSPBCsaKUIbz
         Z1pxs8ovrpq5wYQf/FbdwaBu0nh/mBbWqiGn3+0OHZ52xsseHlNpqcNp+POJSV7GzykX
         629A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QX4rZ/apusxA+kOocMUgPZzFJ0GB7RlYqxdsd8KGKjw=;
        b=EWfZq5/FrKxlZHCizvpuqPYGMb6aHdl+t8xsKGbMzfQL7/rtI7BgWQuUfSGNJKd0US
         d/qggqvwrRqHeZ9OE9TY4rjCE07Brj9IlwJ7O6iwD1kgMRuX8khFvR0v9rWYMg94zBVL
         cNujCyy3OiLdGxQ3zs9dAhe0axzMEAQKeTCFbsmZl9xtrQQmod8NVA5N7q9+/cuPg4M2
         vq1rGC4iBSmCDsNBSep+Ig9pd77Aw/lwPlZjSyYyjsiV74Uu6p+rctTDO+aKtcarJ84J
         1gioTCFp9gn/Rog0kNIgYfZqvV+GQ1AefapZy97IKWHAje0zS/Jz8IpCrNLY9fI6ZC6p
         5C7Q==
X-Gm-Message-State: AO0yUKWQVRY7I5cC5CGPaEDFA93UPoxN5R+YkNNVgwDpckHnxDmBXZIS
        Q7Z8AVliycXvtfU+2NtxCGKTOw==
X-Google-Smtp-Source: AK7set/3HsxRPjRdhDnMoTIKD5/HI3EB5DMI/wZsOGOaUNEUdIzsU4vzJeppub9ye2E67JzGIA9cbA==
X-Received: by 2002:adf:dc04:0:b0:2c3:ea92:3494 with SMTP id t4-20020adfdc04000000b002c3ea923494mr2499644wri.55.1675778156573;
        Tue, 07 Feb 2023 05:55:56 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id p10-20020a5d59aa000000b002be5401ef5fsm11611312wrr.39.2023.02.07.05.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 05:55:56 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 1/7] dt-bindings: phy: Add qcom,snps-eusb2-repeater schema file
Date:   Tue,  7 Feb 2023 15:55:45 +0200
Message-Id: <20230207135551.1418637-2-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230207135551.1418637-1-abel.vesa@linaro.org>
References: <20230207135551.1418637-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SM8550 SoC uses Synopsis eUSB2 repeater found in PM8550b.
Add a dt-binding schema for the new driver.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---

The v3 (rfc) is here:
https://lore.kernel.org/all/20230202133816.4026990-3-abel.vesa@linaro.org/

Changes since v3:
 * made this patch the first one in the series to fix the binding check
   for the 2nd patch.
 * dropped the compatible for pmic in the example. This is due to the
   dependency between this patch and the next one.

 .../phy/qcom,snps-eusb2-repeater.yaml         | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,snps-eusb2-repeater.yaml

diff --git a/Documentation/devicetree/bindings/phy/qcom,snps-eusb2-repeater.yaml b/Documentation/devicetree/bindings/phy/qcom,snps-eusb2-repeater.yaml
new file mode 100644
index 000000000000..54afab7e21fb
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/qcom,snps-eusb2-repeater.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/qcom,snps-eusb2-repeater.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Synopsis eUSB2 to USB 2.0 repeater
+
+maintainers:
+  - Abel Vesa <abel.vesa@linaro.org>
+
+properties:
+  compatible:
+    const: qcom,pm8550b-eusb2-repeater
+
+  reg:
+    maxItems: 1
+
+  "#phy-cells":
+    const: 0
+
+  vdd18-supply: true
+
+  vdd3-supply: true
+
+required:
+  - compatible
+  - reg
+  - "#phy-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/spmi/spmi.h>
+
+    pmic@7 {
+      reg = <0x7 SPMI_USID>;
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      pm8550b_eusb2_repeater: phy@fd00 {
+        compatible = "qcom,pm8550b-eusb2-repeater";
+        reg = <0xfd00>;
+        #phy-cells = <0>;
+      };
+    };
+...
-- 
2.34.1

