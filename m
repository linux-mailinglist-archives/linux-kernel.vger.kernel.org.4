Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4E2627C18
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 12:19:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235905AbiKNLTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 06:19:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236986AbiKNLRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 06:17:30 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A70E21264;
        Mon, 14 Nov 2022 03:15:31 -0800 (PST)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id 65E936000D;
        Mon, 14 Nov 2022 11:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1668424530;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rIVbSyIZp3imXtExKvo6Q6tMSTGJpwHSvojy2YkLNKY=;
        b=oK5TgccplQbeUnRe5w0VER8tpOM+JeVb7gYR9spS/2E+xBFr96Bvr4+5xjqDTDe6LnN7l0
        mkozKP6IFSmHc5JZV/8up090HkHIEZJedIryDPj+m/MX9/sXNkh3mlUuZjZKXbMkuUa7vv
        P0XoE/j7O8i24EdplurCC9RlRsI22/z55z7Easx8g6+nB7YKNsfZRbFEys7Z5OA2jgvfvR
        DdpVOoR+YZOtd9ZsdHYXPLHtelIiCeNVtqDQfpYR5qiOvOq/WsZVcu8dQz8mtN/s3DOTNJ
        b4ciRmoCNBOwmp8YlVAhjGaW/MqEpaaR8bjVoYw5kKKk/7rQJwQ4lmnYONPxEw==
From:   Herve Codina <herve.codina@bootlin.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Herve Codina <herve.codina@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>
Cc:     linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v2 2/7] dt-bindings: clock: renesas,r9a06g032-sysctrl: Add h2mode property
Date:   Mon, 14 Nov 2022 12:15:08 +0100
Message-Id: <20221114111513.1436165-3-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221114111513.1436165-1-herve.codina@bootlin.com>
References: <20221114111513.1436165-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the h2mode property to force the USBs mode ie:
 - 2 hosts
or
 - 1 host and 1 device

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 .../bindings/clock/renesas,r9a06g032-sysctrl.yaml      | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/renesas,r9a06g032-sysctrl.yaml b/Documentation/devicetree/bindings/clock/renesas,r9a06g032-sysctrl.yaml
index 95bf485c6cec..f9e0a58aa4fb 100644
--- a/Documentation/devicetree/bindings/clock/renesas,r9a06g032-sysctrl.yaml
+++ b/Documentation/devicetree/bindings/clock/renesas,r9a06g032-sysctrl.yaml
@@ -39,6 +39,16 @@ properties:
   '#power-domain-cells':
     const: 0
 
+  renesas,h2mode:
+    description: |
+      Configure the USBs mode.
+        - <0> : the USBs are in 1 host and 1 device mode.
+        - <1> : the USBs are in 2 host mode.
+      If the property is not present, the value used is the one already present
+      in the CFG_USB register (from reset or set by the bootloader).
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1]
+
   '#address-cells':
     const: 1
 
-- 
2.38.1

