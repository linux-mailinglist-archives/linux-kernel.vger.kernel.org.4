Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 820056C06FE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 01:53:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbjCTAx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 20:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbjCTAxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 20:53:13 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D60D11C590;
        Sun, 19 Mar 2023 17:53:11 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 883641042;
        Sun, 19 Mar 2023 17:53:55 -0700 (PDT)
Received: from slackpad.fritz.box (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0D1503F885;
        Sun, 19 Mar 2023 17:53:08 -0700 (PDT)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        =?UTF-8?q?Andr=C3=A1s=20Szemz=C3=B6?= <szemzo.andras@gmail.com>,
        Icenowy Zheng <uwu@icenowy.me>,
        Fabien Poussin <fabien.poussin@gmail.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Belisko Marek <marek.belisko@gmail.com>
Subject: [PATCH v2 3/4] dt-bindings: arm: sunxi: document MangoPi MQ-R board names
Date:   Mon, 20 Mar 2023 00:52:48 +0000
Message-Id: <20230320005249.13403-4-andre.przywara@arm.com>
X-Mailer: git-send-email 2.35.7
In-Reply-To: <20230320005249.13403-1-andre.przywara@arm.com>
References: <20230320005249.13403-1-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MangoPi MQ-R board is a small development board, using Allwinner
SoCs with co-packaged DRAM. There are versions with a RISC-V core and
ones with two Arm Cortex-A7 cores.

Add the board/SoC compatible string pair to the list of known boards.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 Documentation/devicetree/bindings/arm/sunxi.yaml   | 5 +++++
 Documentation/devicetree/bindings/riscv/sunxi.yaml | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml b/Documentation/devicetree/bindings/arm/sunxi.yaml
index 3ad1cd50e3fe0..1a2d728234b1e 100644
--- a/Documentation/devicetree/bindings/arm/sunxi.yaml
+++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
@@ -843,6 +843,11 @@ properties:
           - const: wexler,tab7200
           - const: allwinner,sun7i-a20
 
+      - description: MangoPi MQ-R board
+        items:
+          - const: widora,mangopi-mq-r-t113
+          - const: allwinner,sun8i-t113s
+
       - description: WITS A31 Colombus Evaluation Board
         items:
           - const: wits,colombus
diff --git a/Documentation/devicetree/bindings/riscv/sunxi.yaml b/Documentation/devicetree/bindings/riscv/sunxi.yaml
index 9edb5e5992b19..b36e313e13a67 100644
--- a/Documentation/devicetree/bindings/riscv/sunxi.yaml
+++ b/Documentation/devicetree/bindings/riscv/sunxi.yaml
@@ -64,6 +64,11 @@ properties:
           - const: widora,mangopi-mq-pro
           - const: allwinner,sun20i-d1
 
+      - description: MangoPi MQ-R board
+        items:
+          - const: widora,mangopi-mq-r-f133
+          - const: allwinner,sun20i-d1s
+
 additionalProperties: true
 
 ...
-- 
2.35.7

