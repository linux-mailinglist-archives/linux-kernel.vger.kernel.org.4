Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF12E7375F3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 22:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjFTUS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 16:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbjFTUS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 16:18:29 -0400
X-Greylist: delayed 512 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 20 Jun 2023 13:18:04 PDT
Received: from unicorn.mansr.com (unicorn.mansr.com [81.2.72.234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EADB01BD2;
        Tue, 20 Jun 2023 13:18:04 -0700 (PDT)
Received: from raven.mansr.com (raven.mansr.com [81.2.72.235])
        by unicorn.mansr.com (Postfix) with ESMTPS id DC83115360;
        Tue, 20 Jun 2023 21:09:28 +0100 (BST)
Received: by raven.mansr.com (Postfix, from userid 51770)
        id B3DAF21A4DD; Tue, 20 Jun 2023 21:09:28 +0100 (BST)
From:   Mans Rullgard <mans@mansr.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Tony Lindgren <tony@atomide.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: bus: ti-sysc: fix typo
Date:   Tue, 20 Jun 2023 21:09:17 +0100
Message-ID: <20230620200917.24958-1-mans@mansr.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix typo (period vs comma) in list of valid clock names.

Signed-off-by: Mans Rullgard <mans@mansr.com>
---
 Documentation/devicetree/bindings/bus/ti-sysc.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/bus/ti-sysc.yaml b/Documentation/devicetree/bindings/bus/ti-sysc.yaml
index f089634f9466..6d7bca6c138e 100644
--- a/Documentation/devicetree/bindings/bus/ti-sysc.yaml
+++ b/Documentation/devicetree/bindings/bus/ti-sysc.yaml
@@ -97,7 +97,7 @@ properties:
       - enum: [ ick, fck, sys_clk ]
       - items:
           - const: fck
-          - enum: [ ick. dbclk, osc, sys_clk, dss_clk, ahclkx ]
+          - enum: [ ick, dbclk, osc, sys_clk, dss_clk, ahclkx ]
       - items:
           - const: fck
           - const: phy-clk
-- 
2.41.0

