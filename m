Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEE7B6EBB57
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 22:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjDVUum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 16:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbjDVUua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 16:50:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09CFE26B0;
        Sat, 22 Apr 2023 13:50:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 85C6F61455;
        Sat, 22 Apr 2023 20:50:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6A9CC4339C;
        Sat, 22 Apr 2023 20:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682196627;
        bh=5pTEe5QNmuiGBfjEiv1SzkhBlJWy5vnpGmBzGZ3koYY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Dh80RwQo8vfVEPI+IA2p9L5NZm4T/GXu9XE2tY7tOJdaGChTl6PHPzut+66Ax7YKH
         oQccGTdqxBJV5rDK7tLK3eiXgJkTT28pIPuapmLbd+1Zmmf0DGlbfzBT+SDi039Cw5
         tRzB3B/XMnWshCLDCp+IkTi8qlRDGj1Rv7JYkYQ6BEA2XTckACLBGX8oJsvySu3ceH
         TLA3s/chdLMilu/IVaEfdw5/T+mf7IUxrWoB8zMhEzq6p5X3J64tqalki6nxJvXNte
         1yZ5ErUg7Rt9qxOTunmFg1z1s0fw8mLR4E8GbRfz5DJJuJiRnSKPOInmOfms/g14cL
         y/9jm/nimUFBw==
Received: by mercury (Postfix, from userid 1000)
        id 0B5A11066CB7; Sat, 22 Apr 2023 22:50:25 +0200 (CEST)
From:   Sebastian Reichel <sre@kernel.org>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Gerald Loacker <gerald.loacker@wolfvision.net>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 02/13] dt-bindings: display: st7789v: add Inanbo T28CP45TN89
Date:   Sat, 22 Apr 2023 22:50:01 +0200
Message-Id: <20230422205012.2464933-3-sre@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230422205012.2464933-1-sre@kernel.org>
References: <20230422205012.2464933-1-sre@kernel.org>
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

Add compatible value for Inanbo t28cp45tn89 and make reset GPIO non
mandatory, since it might not be connected to the CPU.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 .../devicetree/bindings/display/panel/sitronix,st7789v.yaml  | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/panel/sitronix,st7789v.yaml b/Documentation/devicetree/bindings/display/panel/sitronix,st7789v.yaml
index d984b59daa4a..7c5e4313db1d 100644
--- a/Documentation/devicetree/bindings/display/panel/sitronix,st7789v.yaml
+++ b/Documentation/devicetree/bindings/display/panel/sitronix,st7789v.yaml
@@ -15,7 +15,9 @@ allOf:
 
 properties:
   compatible:
-    const: sitronix,st7789v
+    enum:
+      - inanbo,t28cp45tn89-v17
+      - sitronix,st7789v
 
   reg: true
   reset-gpios: true
@@ -29,7 +31,6 @@ properties:
 required:
   - compatible
   - reg
-  - reset-gpios
   - power-supply
 
 unevaluatedProperties: false
-- 
2.39.2

