Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8866D8A9C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 00:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbjDEWbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 18:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjDEWbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 18:31:35 -0400
Received: from alln-iport-1.cisco.com (alln-iport-1.cisco.com [173.37.142.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0BA01721
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 15:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1370; q=dns/txt; s=iport;
  t=1680733894; x=1681943494;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nODPX+s+Q/kJw5P5tL3y79XtWx5aevSrDkBNT3QoGeM=;
  b=Wx22jJYy8Bo2D0CA/+jjEEHDdqtRfmrz2cT7P9lIHfiZAY+L0gvWlbwH
   zGv4fvAALV9GePKFPVkwg15PlEt/OJrJ3IIISZQ7NWR58S2h25C6sPJzG
   LA2Wh2P4D4YnLV0b8w1C8bggIeNaYaiDzmYu+ES3jdRAE2zRqCQT6fhHg
   Q=;
X-IronPort-AV: E=Sophos;i="5.98,322,1673913600"; 
   d="scan'208";a="96032875"
Received: from rcdn-core-11.cisco.com ([173.37.93.147])
  by alln-iport-1.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 05 Apr 2023 22:30:31 +0000
Received: from localhost.localdomain ([10.160.65.27])
        by rcdn-core-11.cisco.com (8.15.2/8.15.2) with ESMTP id 335MUSxJ031603;
        Wed, 5 Apr 2023 22:30:30 GMT
From:   Daniel Walker <danielwa@cisco.com>
To:     - <xe-linux-external@cisco.com>
Cc:     Marcin Wierzbicki <mawierzb@cisco.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Walker <dwalker@fifo99.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] dt-bindings: cisco: document the CrayAR compatibles
Date:   Wed,  5 Apr 2023 15:30:27 -0700
Message-Id: <20230405223028.1268141-2-danielwa@cisco.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 10.160.65.27, [10.160.65.27]
X-Outbound-Node: rcdn-core-11.cisco.com
X-Spam-Status: No, score=-10.0 required=5.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Describe the compatible properties for the Cisco CrayAR SoC.

Cc: xe-linux-external@cisco.com
Cc: Marcin Wierzbicki <mawierzb@cisco.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Daniel Walker <dwalker@fifo99.com>
---
 .../devicetree/bindings/arm/cisco/crayar.yaml | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/cisco/crayar.yaml

diff --git a/Documentation/devicetree/bindings/arm/cisco/crayar.yaml b/Documentation/devicetree/bindings/arm/cisco/crayar.yaml
new file mode 100644
index 000000000000..0ee4e6313ab0
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/cisco/crayar.yaml
@@ -0,0 +1,27 @@
+# SPDX-License-Identifier: GPL-2.0-only
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/cisco/crayar.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cisco CrayAR based Platforms
+
+maintainers:
+  - xe-linux-external@cisco.com
+
+description:
+  Cisco CrayAR boards with CrayAR SOC
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    oneOf:
+      - description: Cisco CrayAR Argos evaluation board
+        items:
+          - const: cisco,crayar-argos
+          - const: cisco,crayar
+
+additionalProperties: true
+
+...
-- 
2.25.1

