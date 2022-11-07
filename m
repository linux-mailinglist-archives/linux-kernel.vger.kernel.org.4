Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7693161F4CF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 15:00:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbiKGN74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 08:59:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232029AbiKGN7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 08:59:53 -0500
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8443DB1E;
        Mon,  7 Nov 2022 05:59:52 -0800 (PST)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id 83B6B4000A;
        Mon,  7 Nov 2022 13:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1667829591;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OtZQJBL/FYUOH9MyZ1O4/vM6k2nj9uAHCCwNNoTB1Ag=;
        b=dYl4ZSG0LJDPOMJ5EHeoZ+Khw1qoNXzZorJHW3LE++5rFQ2XWIMrIfG9Ue9o/u2zMt06W6
        bqt/b69ECQ5OX5c7e3YMHx7pp9yWbcYUXZuOpoJDQCgdMYQd3kY1GpbKVVNMNWVZ8k3Vc1
        MPnDR3sv8HCz8ie7pLuJfkjk0zw1kEonuvcQ33DuYw68V3rZWlb3qWm3FVC7GEyW/WQ8Jc
        1ElOfqedAaYiA1jjD24a21E9EYc43uJTeE7gf+cpAKs2puyatNixrXScLeAJkOH7xM2Uay
        yrM4H78serZxde+4erp+1S8pgJWNQJN81GVpma20WBqvVAw62+8FU0BB7oUPFQ==
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
Subject: [PATCH 2/7] dt-bindings: clock: renesas,r9a06g032-sysctrl: Add h2mode property
Date:   Mon,  7 Nov 2022 14:58:20 +0100
Message-Id: <20221107135825.583877-3-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221107135825.583877-1-herve.codina@bootlin.com>
References: <20221107135825.583877-1-herve.codina@bootlin.com>
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
2.37.3

