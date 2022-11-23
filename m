Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3759863505F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 07:19:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236024AbiKWGTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 01:19:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235831AbiKWGTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 01:19:11 -0500
Received: from twspam01.aspeedtech.com (twspam01.aspeedtech.com [211.20.114.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00F0573BBE;
        Tue, 22 Nov 2022 22:19:07 -0800 (PST)
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 2AN5pU4K081940;
        Wed, 23 Nov 2022 13:51:31 +0800 (GMT-8)
        (envelope-from billy_tsai@aspeedtech.com)
Received: from BillyTsai-pc.aspeed.com (192.168.2.149) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 23 Nov
 2022 14:15:55 +0800
From:   Billy Tsai <billy_tsai@aspeedtech.com>
To:     <jdelvare@suse.com>, <linux@roeck-us.net>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <joel@jms.id.au>,
        <andrew@aj.id.au>, <lee@kernel.org>, <thierry.reding@gmail.com>,
        <u.kleine-koenig@pengutronix.de>, <corbet@lwn.net>,
        <p.zabel@pengutronix.de>, <billy_tsai@aspeedtech.com>,
        <linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: [v4 3/5] dt-bindings: hwmon: Add bindings for aspeed tach controller
Date:   Wed, 23 Nov 2022 14:16:33 +0800
Message-ID: <20221123061635.32025-4-billy_tsai@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221123061635.32025-1-billy_tsai@aspeedtech.com>
References: <20221123061635.32025-1-billy_tsai@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.2.149]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 2AN5pU4K081940
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the aspeed tach device bindings which should be the child-node of
pwm-tach mfd.

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
 .../bindings/hwmon/aspeed,ast2600-tach.yaml   | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/aspeed,ast2600-tach.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/aspeed,ast2600-tach.yaml b/Documentation/devicetree/bindings/hwmon/aspeed,ast2600-tach.yaml
new file mode 100644
index 000000000000..f42114f8e3c2
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/aspeed,ast2600-tach.yaml
@@ -0,0 +1,36 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2021 Aspeed, Inc.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hwmon/aspeed,ast2600-tach.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Aspeed Ast2600 Tach controller
+
+maintainers:
+  - Billy Tsai <billy_tsai@aspeedtech.com>
+
+description: |
+  The Aspeed Tach controller can support upto 16 fan input.
+  This module is part of the ast2600-pwm-tach multi-function device. For more
+  details see ../mfd/aspeed,ast2600-pwm-tach.yaml.
+
+properties:
+  compatible:
+    enum:
+      - aspeed,ast2600-tach
+patternProperties:
+  "^fan@[a-z0-9]+$":
+    type: object
+    properties:
+      reg:
+        description:
+          The tach channel used for this node.
+        maxItems: 1
+    required:
+      - reg
+
+required:
+  - compatible
+
+additionalProperties: false
-- 
2.25.1

