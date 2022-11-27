Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F62E639B12
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 14:35:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbiK0NfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 08:35:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiK0NfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 08:35:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEFB110B5B;
        Sun, 27 Nov 2022 05:34:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 73CB660DD4;
        Sun, 27 Nov 2022 13:34:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D3B1C433D6;
        Sun, 27 Nov 2022 13:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669556095;
        bh=vsfhkLiCJ/68w3F/Z2fdmD7dgsK7LenaTlTpgKiTus0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WlFi7+4qvrBNTSUWn/wtTQuEOiQ8s4JGT8QOEF04LktK9zhANGrRXgt4UtKDmOrIP
         hEQXHqEzDw4t3GoWplQ5g9usmGltjS8L9QicxYm5JbTPp8vwshdpVLd/BQmzp070/T
         WSwgblpm5xMW+SNyEXi4LI1ZEGzUqyYZUp4iXAxaKAb2p2de951qDERF8H91qkTVIW
         w7NTlFZxB1YxcMlySXBcmVnAYISDz3EdeVuYW7eZxOUN+Zvcp+iIUQZ12eh4pp6J0g
         YzTXJy7W/hU8uK6/gG1GI0OiKAiGjsRCm0Oug4d6NTm3rt+DFQkNWy4n0AkVXBkojJ
         hglbN1EQcqnig==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Conor Dooley <conor@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [PATCH v2 5/9] dt-bindings: riscv: Add bouffalolab bl808 board compatibles
Date:   Sun, 27 Nov 2022 21:24:44 +0800
Message-Id: <20221127132448.4034-6-jszhang@kernel.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221127132448.4034-1-jszhang@kernel.org>
References: <20221127132448.4034-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several SoMs and boards are available that feature the Bouffalolab
bl808 SoC. Document the compatible strings.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 .../bindings/riscv/bouffalolab.yaml           | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/riscv/bouffalolab.yaml

diff --git a/Documentation/devicetree/bindings/riscv/bouffalolab.yaml b/Documentation/devicetree/bindings/riscv/bouffalolab.yaml
new file mode 100644
index 000000000000..91ca9dbdc798
--- /dev/null
+++ b/Documentation/devicetree/bindings/riscv/bouffalolab.yaml
@@ -0,0 +1,34 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/riscv/bouffalolab.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Bouffalo Lab Technology SoC-based boards
+
+maintainers:
+  - Jisheng Zhang <jszhang@kernel.org>
+
+description:
+  Bouffalo Lab Technology SoC-based boards
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    oneOf:
+      - description: Sipeed M1s SoM:
+        items:
+          - const: sipeed,m1s
+          - const: bouffalolab,bl808
+
+      - description: Carrier boards for the Sipeed M1s SoM:
+        items:
+          - enum:
+              - sipeed,m1s-dock
+          - const: sipeed,m1s
+          - const: bouffalolab,bl808
+
+additionalProperties: true
+
+...
-- 
2.38.1

