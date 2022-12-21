Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67CD6653549
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 18:33:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235112AbiLURdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 12:33:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235037AbiLURc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 12:32:27 -0500
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 620CC178BB;
        Wed, 21 Dec 2022 09:32:16 -0800 (PST)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BLDfaWw026002;
        Wed, 21 Dec 2022 18:31:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=9lEWHCTpXo5muG8dgTfW1ehUGbdevBxdGvchXuIYBYI=;
 b=AGQs4DiAgxB8JelVbDgPrLpwudM/Junr/wptUxbHkhtaDjvRKPpoO89mGhW/QAzOPOt5
 tdpL41ZCWU9H21qTn/Bllnvo5OJAzSgLcEPfINB8ic+oqw33X0+Y39e0TBErsut9NH6w
 WaPsb6m9HyLt+4bpIaiZYLHNCS3Lb0A5GoksKJioE15TPFoBYx+0eljd3nxACsBbl8iF
 DXMnHW+3pgH/7vScCVzQdVKlPi2CcxhaI0wdH5yPfR4G8BwNeBxXAPF33u16uzhxI8k4
 b9/DQEj2qrFimpV1MxSYCWBJXt9qHNmo3Hb6yafohKmtu3Bi4k+4PLDsYVwNPX0Qy7Sn jA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3mh605r5us-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Dec 2022 18:31:48 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3D2BD100039;
        Wed, 21 Dec 2022 18:31:42 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3749D23300E;
        Wed, 21 Dec 2022 18:31:18 +0100 (CET)
Received: from localhost (10.201.21.217) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.13; Wed, 21 Dec
 2022 18:31:17 +0100
From:   Gatien Chevallier <gatien.chevallier@foss.st.com>
To:     <alexandre.torgue@foss.st.com>, <robh+dt@kernel.org>,
        <Oleksii_Moisieiev@epam.com>, <linus.walleij@linaro.org>,
        <gregkh@linuxfoundation.org>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <loic.pallardy@st.com>,
        <devicetree@vger.kernel.org>, <mark.rutland@arm.com>,
        <arnd@arndb.de>, <gatien.chevallier@foss.st.com>,
        Oleksii Moisieiev <oleksii_moisieiev@epam.com>
Subject: [RFC PATCH 1/7] dt-bindings: Document common device controller bindings
Date:   Wed, 21 Dec 2022 18:30:49 +0100
Message-ID: <20221221173055.11719-2-gatien.chevallier@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221221173055.11719-1-gatien.chevallier@foss.st.com>
References: <20221221173055.11719-1-gatien.chevallier@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.21.217]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-21_10,2022-12-21_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>

Introducing of the common device controller bindings for the controller
provider and consumer devices. Those bindings are intended to allow
divided system on chip into muliple domains, that can be used to
configure hardware permissions.

Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
---
 .../feature-domain-controller.yaml            | 84 +++++++++++++++++++
 1 file changed, 84 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/feature-controllers/feature-domain-controller.yaml

diff --git a/Documentation/devicetree/bindings/feature-controllers/feature-domain-controller.yaml b/Documentation/devicetree/bindings/feature-controllers/feature-domain-controller.yaml
new file mode 100644
index 000000000000..90a7c38c833c
--- /dev/null
+++ b/Documentation/devicetree/bindings/feature-controllers/feature-domain-controller.yaml
@@ -0,0 +1,84 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/feature-controllers/feature-domain-controller.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Generic Domain Controller bindings
+
+maintainers:
+  - Oleksii Moisieiev <oleksii_moisieiev@epam.com>
+
+description: |+
+  Common Feature Domains Controller bindings properties
+
+  Domain controllers allow to divided system on chip into multiple feature
+  domains that can be used to select by who hardware blocks could be accessed.
+  A feature domain could be a cluster of CPUs (or coprocessors), a range of
+  addresses or a group of hardware blocks.
+
+  This device tree bindings can be used to bind feature domain consumer devices
+  with their feature domains provided by feature-domains controllers.
+  Feature omain controller provider can be represened by any node in the
+  device tree and can provide one or more configuration parameters, needed to
+  control parameters of the consumer device. A consumer node can refer to the
+  provider by phandle and a set of phandle arguments, specified by
+  '#feature-domain-cells' property in the device controller provider node.
+
+  Device controllers are typically used to set the permissions of the hardware
+  block. The contents of the feature-domains configuration properties are
+  defined by the binding for the individual feature-domains controller device.
+
+  Each node can be a consumer for the several providers. The first
+  configuration of 'feature-domains' or the one named 'default' is applied
+  before probing the device itself.
+
+# always select the core schema
+select: true
+
+properties:
+  '#feature-domain-cells':
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Number of cells in a feature-domains controller specifier;
+      Can be any value as specified by device tree binding documentation
+      of a particular provider.
+
+  feature-domain-controller:
+    description:
+      Indicates that the node is feature-domain-controller provider.
+
+  feature-domain-names:
+    $ref: '/schemas/types.yaml#/definitions/string-array'
+    description:
+      A list of feature-domains names, sorted in the same order as
+      feature-domains entries. Consumer drivers will use feature-domain-names
+      to match with existing feature-domains entries.
+
+  feature-domains:
+    $ref: "/schemas/types.yaml#/definitions/phandle-array"
+    description:
+      A list of feature-domains controller specifiers, as defined by the
+      bindings of the feature-domain-controller provider.
+
+additionalProperties: true
+
+examples:
+  - |
+    ctrl0: ctrl@100 {
+        feature-domain-controller;
+        reg = <0x100 0x10>;
+        #feature-domain-cells = <2>;
+    };
+
+    ctrl1: ctrl@110 {
+        feature-domain-controller;
+        reg = <0x110 0x10>;
+        #feature-domain-cells = <3>;
+    };
+
+    foo@0 {
+        reg = <0x0 0x1>;
+        feature-domains = <&ctrl0 1 2>, <&ctrl1 3 4 5>;
+        feature-domain-names = "default", "unbind";
+    };
-- 
2.25.1

