Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5243E6985B1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 21:37:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjBOUhq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 15:37:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjBOUhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 15:37:36 -0500
Received: from stravinsky.debian.org (stravinsky.debian.org [IPv6:2001:41b8:202:deb::311:108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F433B3CE;
        Wed, 15 Feb 2023 12:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
        s=smtpauto.stravinsky; h=X-Debian-User:Content-Transfer-Encoding:MIME-Version
        :References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=r49yZYmJjuE0DOdqDD4meHmGEzLhjIGb5mML7c5O7pA=; b=nWZitlbNhn+wFiicL3hw+i9Kp1
        Qq8MR8kEy3UH/kxsk+U8NUazMQhqV2OaRN80F7T+XlgBDakte1VDsqn5Cmar5M9WDtRNOAjfzv3UL
        PtxHF+WNi2w3jkpZRwgSXOWn27lh7exgg5B7QCG0Mzn53tqquCX098gxoljrQnoP1At5nnKYs50NX
        2+FHOq45N504I4Xdx+QR4AIo+dHTlZN8A9Am7DIkzYDhaymRRBk8hYzw4LMTwmPAp9YhkP54jrnYA
        jXUNQp1380Mb9fv3e1ej2R4bwDhPk1faA9CqHEM46W1uLi6weOec2GbMHku6yMMh3OqjLUdp8gUrw
        AWSJQydw==;
Received: from authenticated user
        by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <bage@debian.org>)
        id 1pSOWj-002j5f-CM; Wed, 15 Feb 2023 20:37:17 +0000
From:   Bastian Germann <bage@debian.org>
To:     Wilken Gottwalt <wilken.gottwalt@posteo.net>
Cc:     Bastian Germann <bage@debian.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        devicetree@vger.kernel.org
Subject: [PATCH v2 3/5] dt-bindings: hwlock: sun6i: Add missing names
Date:   Wed, 15 Feb 2023 21:37:08 +0100
Message-Id: <20230215203711.6293-4-bage@debian.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230215203711.6293-1-bage@debian.org>
References: <20230215203711.6293-1-bage@debian.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Debian-User: bage
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The allwinner,sun6i-a31-hwspinlock.yaml binding needs clock-names
and reset-names set to "ahb" as required by the Linux driver.

Fixes: f9e784dcb63f ("dt-bindings: hwlock: add sun6i_hwspinlock")
Signed-off-by: Bastian Germann <bage@debian.org>
---
 .../hwlock/allwinner,sun6i-a31-hwspinlock.yaml       | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/hwlock/allwinner,sun6i-a31-hwspinlock.yaml b/Documentation/devicetree/bindings/hwlock/allwinner,sun6i-a31-hwspinlock.yaml
index 38478dad8b25..6cdfe22deb3c 100644
--- a/Documentation/devicetree/bindings/hwlock/allwinner,sun6i-a31-hwspinlock.yaml
+++ b/Documentation/devicetree/bindings/hwlock/allwinner,sun6i-a31-hwspinlock.yaml
@@ -23,9 +23,17 @@ properties:
   clocks:
     maxItems: 1
 
+  clock-names:
+    items:
+      - const: ahb
+
   resets:
     maxItems: 1
 
+  reset-names:
+    items:
+      - const: ahb
+
   '#hwlock-cells':
     const: 1
 
@@ -33,7 +41,9 @@ required:
   - compatible
   - reg
   - clocks
+  - clock-names
   - resets
+  - reset-names
   - "#hwlock-cells"
 
 additionalProperties: false
@@ -47,7 +57,9 @@ examples:
         compatible = "allwinner,sun6i-a31-hwspinlock";
         reg = <0x01c18000 0x1000>;
         clocks = <&ccu CLK_BUS_SPINLOCK>;
+        clock-names = "ahb";
         resets = <&ccu RST_BUS_SPINLOCK>;
+        reset-names = "ahb";
         #hwlock-cells = <1>;
     };
 ...
-- 
2.39.1

