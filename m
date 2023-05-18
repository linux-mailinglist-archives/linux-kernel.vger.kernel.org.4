Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C55F708812
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 20:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbjERS5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 14:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbjERS5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 14:57:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C015E52;
        Thu, 18 May 2023 11:57:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F3A8C614CA;
        Thu, 18 May 2023 18:57:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9743AC4339E;
        Thu, 18 May 2023 18:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684436221;
        bh=ayCUu7VWTParlzqlhysZ/3yMoFf8bKiG9G6ke1+jMJ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bk41F/OJXLE+OA+bkypJqEMkcA4OcdwSmKYtN4q6m6SVlGG9YWXwH7FfaQClnLhwB
         SFOmC8XoQ9wUmaOsHiPreGL8eUEYVNmUDPijwPOJDy9Lczx3zXZ+KohWgdUDBZ4zZk
         8FkVWqpsiaSsT9jHknJmsTvhZa3tg0RaZpNyohe4c+4Rnf1e6SSL0lec9vcPauXmmX
         YKEOmhM0edn3+YfkOFjNOoWeoov0Qa1ibfk0ks3ghjYgozf9W2xzpFuRYlHov6Jz0Y
         Bx9zzwPWh+SjoaMPSedIZNonW1Q1tT7ZxdszhpyWbxR5RjtUSYbTlGEeKoC/21I0Ku
         JvW03+ywiDL1A==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, Yangtao Li <frank.li@vivo.com>,
        Wei Fu <wefu@redhat.com>, Icenowy Zheng <uwu@icenowy.me>
Subject: [PATCH v2 3/9] dt-bindings: riscv: Add T-HEAD TH1520 board compatibles
Date:   Fri, 19 May 2023 02:45:35 +0800
Message-Id: <20230518184541.2627-4-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230518184541.2627-1-jszhang@kernel.org>
References: <20230518184541.2627-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several SoMs and boards are available that feature the T-HEAD TH1520
SoC. Document the compatible strings.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 .../devicetree/bindings/riscv/thead.yaml      | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/riscv/thead.yaml

diff --git a/Documentation/devicetree/bindings/riscv/thead.yaml b/Documentation/devicetree/bindings/riscv/thead.yaml
new file mode 100644
index 000000000000..e62f6821372e
--- /dev/null
+++ b/Documentation/devicetree/bindings/riscv/thead.yaml
@@ -0,0 +1,29 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/riscv/thead.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: T-HEAD SoC-based boards
+
+maintainers:
+  - Jisheng Zhang <jszhang@kernel.org>
+
+description:
+  T-HEAD SoC-based boards
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    oneOf:
+      - description: Sipeed Lichee Pi 4A board for the Sipeed Lichee Module 4A
+        items:
+          - enum:
+              - sipeed,lichee-pi-4a
+          - const: sipeed,lichee-module-4a
+          - const: thead,th1520
+
+additionalProperties: true
+
+...
-- 
2.40.0

