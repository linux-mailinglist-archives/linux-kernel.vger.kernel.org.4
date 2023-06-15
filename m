Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8617B7321BD
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 23:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237511AbjFOVcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 17:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbjFOVc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 17:32:29 -0400
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FBFE2965;
        Thu, 15 Jun 2023 14:32:27 -0700 (PDT)
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-77b210292c5so311239f.1;
        Thu, 15 Jun 2023 14:32:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686864746; x=1689456746;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y0norJIwZvkkbQmhn8u0GhiUiYZjgn02uiIEXP7h5pk=;
        b=C2I0vPKwy7nfzg5o29AUqB6YXpTyhaG7PlR3WM/ss+u26xSnAyHdnL4NStZmxJU9pB
         ZqA6pbn+SayyEJcj/h/M5Q/OgGgHyexDkZbXKQXGH3/PJ3CaWrZN1CUQb5LpfOHUZJ4J
         sIfbKmqRyb9WENGKVFBPZZVLu+0ox3daJ9WK/If8P2GZqlBCVZkwwxPJgOq+jmBX7m2B
         MK/cvDQ0WczJ2r2rWAm0t/wclHrq5W4KpiwOtW1fzHuAWwzFdu8FcktKzgLKeVv9A7h5
         kwTpdSLxCLAPMpTbVbEDSUUPEkPnXkcDWkKk3U/25BYUl1qaD8RbMLC5O8K93l4ly+pZ
         aODw==
X-Gm-Message-State: AC+VfDyJB/IJHHIrKevm7kUT2lBK/42pcp3j7OXSA+Kg62VNf3ttlgRC
        fig+QCWiKiH/K/ZkUgYMAA==
X-Google-Smtp-Source: ACHHUZ60+gxkV4IZw00KRTgD2jBQ7xC/7Ngd/HzJayT/XQ1uokpKyUemkrB0PIm0uI6TBw6uHGnL+w==
X-Received: by 2002:a92:d309:0:b0:340:79ff:c1b8 with SMTP id x9-20020a92d309000000b0034079ffc1b8mr700906ila.7.1686864746393;
        Thu, 15 Jun 2023 14:32:26 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id z8-20020a92cd08000000b003375c8474absm6346149iln.56.2023.06.15.14.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 14:32:25 -0700 (PDT)
Received: (nullmailer pid 1753913 invoked by uid 1000);
        Thu, 15 Jun 2023 21:32:23 -0000
From:   Rob Herring <robh@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sebastian Reichel <sre@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        =?UTF-8?q?Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>,
        Marek Vasut <marex@denx.de>, Suman Anna <s-anna@ti.com>,
        - <devicetree-spec@vger.kernel.org>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-remoteproc@vger.kernel.org
Subject: [PATCH] dt-bindings: Remove last usage of "binding" or "schema" in titles
Date:   Thu, 15 Jun 2023 15:31:54 -0600
Message-Id: <20230615213154.1753313-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Devicetree bindings document does not have to say in the title that
it is a "Devicetree binding", but instead just describe the hardware.

Most of these have been fixed already, so fix the handful that snuck in.
With this, a meta-schema check can be enabled to catch these
automatically.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/clock/brcm,bcm63268-timer-clocks.yaml   | 2 +-
 Documentation/devicetree/bindings/clock/imx8mp-audiomix.yaml    | 2 +-
 .../devicetree/bindings/power/reset/restart-handler.yaml        | 2 +-
 .../devicetree/bindings/remoteproc/ti,pru-consumer.yaml         | 2 +-
 .../devicetree/bindings/reserved-memory/framebuffer.yaml        | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/brcm,bcm63268-timer-clocks.yaml b/Documentation/devicetree/bindings/clock/brcm,bcm63268-timer-clocks.yaml
index 199818b2fb6d..cd0d763ce2f3 100644
--- a/Documentation/devicetree/bindings/clock/brcm,bcm63268-timer-clocks.yaml
+++ b/Documentation/devicetree/bindings/clock/brcm,bcm63268-timer-clocks.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/clock/brcm,bcm63268-timer-clocks.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Broadcom BCM63268 Timer Clock and Reset Device Tree Bindings
+title: Broadcom BCM63268 Timer Clock and Reset
 
 maintainers:
   - Álvaro Fernández Rojas <noltari@gmail.com>
diff --git a/Documentation/devicetree/bindings/clock/imx8mp-audiomix.yaml b/Documentation/devicetree/bindings/clock/imx8mp-audiomix.yaml
index ff9600474df2..0a6dc1a6e122 100644
--- a/Documentation/devicetree/bindings/clock/imx8mp-audiomix.yaml
+++ b/Documentation/devicetree/bindings/clock/imx8mp-audiomix.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/clock/imx8mp-audiomix.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: NXP i.MX8MP AudioMIX Block Control Binding
+title: NXP i.MX8MP AudioMIX Block Control
 
 maintainers:
   - Marek Vasut <marex@denx.de>
diff --git a/Documentation/devicetree/bindings/power/reset/restart-handler.yaml b/Documentation/devicetree/bindings/power/reset/restart-handler.yaml
index 1f9a2aac53c0..f2ffdd29d52a 100644
--- a/Documentation/devicetree/bindings/power/reset/restart-handler.yaml
+++ b/Documentation/devicetree/bindings/power/reset/restart-handler.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/power/reset/restart-handler.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Restart and shutdown handler generic binding
+title: Restart and shutdown handler Common Properties
 
 maintainers:
   - Sebastian Reichel <sre@kernel.org>
diff --git a/Documentation/devicetree/bindings/remoteproc/ti,pru-consumer.yaml b/Documentation/devicetree/bindings/remoteproc/ti,pru-consumer.yaml
index c6d86964b72a..35f0bb38f7b2 100644
--- a/Documentation/devicetree/bindings/remoteproc/ti,pru-consumer.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/ti,pru-consumer.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/remoteproc/ti,pru-consumer.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Common TI PRU Consumer Binding
+title: TI PRU Consumer Common Properties
 
 maintainers:
   - Suman Anna <s-anna@ti.com>
diff --git a/Documentation/devicetree/bindings/reserved-memory/framebuffer.yaml b/Documentation/devicetree/bindings/reserved-memory/framebuffer.yaml
index 05b6648b3458..851ec24d6142 100644
--- a/Documentation/devicetree/bindings/reserved-memory/framebuffer.yaml
+++ b/Documentation/devicetree/bindings/reserved-memory/framebuffer.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/reserved-memory/framebuffer.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: /reserved-memory framebuffer node bindings
+title: /reserved-memory framebuffer node
 
 maintainers:
   - devicetree-spec@vger.kernel.org
-- 
2.39.2

