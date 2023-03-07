Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 783D96ADCA6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 11:58:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbjCGK6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 05:58:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbjCGK5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 05:57:23 -0500
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 185D05BCA2
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 02:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=k1; bh=Lkm0PfRMGNfNPc
        4inj3fdY2lQ/g94jqXF7RXgyG+CJU=; b=ehZIxuEuxTbiQHKg0EOJk2RbSe+mKR
        SKzfwGKMzUGLLrlPEF1fOUURsBNAPgAX2sHZMFzDrF1PvawX3jrcyS/zDyG+cJan
        hcqozGndJPXQCDdD1jS61BuSAYNVc0ElejiLYRfcIsC/bLVD8ef8+WY4WGb1lwqa
        LujQ3Ag3fRBLY=
Received: (qmail 650960 invoked from network); 7 Mar 2023 11:57:07 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 7 Mar 2023 11:57:07 +0100
X-UD-Smtp-Session: l3s3148p1@unrKRU32NoggAQnoAFQ+AGEn9EY5VOxJ
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] dt-bindings: soc: renesas: remove R-Car H3 ES1.*
Date:   Tue,  7 Mar 2023 11:56:39 +0100
Message-Id: <20230307105645.5285-4-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230307105645.5285-1-wsa+renesas@sang-engineering.com>
References: <20230307105645.5285-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FORGED_SPF_HELO,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

R-Car H3 ES1.* was only available to an internal development group and
needed a lot of quirks and workarounds. These become a maintenance
burden now, so our development group decided to remove upstream support
and disable booting for this SoC. Public users only have ES2 onwards.

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 .../devicetree/bindings/soc/renesas/renesas.yaml          | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/renesas/renesas.yaml b/Documentation/devicetree/bindings/soc/renesas/renesas.yaml
index 2789022b52eb..c3389de20c72 100644
--- a/Documentation/devicetree/bindings/soc/renesas/renesas.yaml
+++ b/Documentation/devicetree/bindings/soc/renesas/renesas.yaml
@@ -212,12 +212,12 @@ properties:
               - renesas,silk # SILK (RTP0RC7794LCB00011S)
           - const: renesas,r8a7794
 
-      - description: R-Car H3 (R8A77950)
+      # Note: R-Car H3 ES1.* (R8A77950) is not supported upstream anymore!
+
+      - description: R-Car H3 ES2.0 and later (R8A77951)
         items:
           - enum:
-                # H3ULCB (R-Car Starter Kit Premier, RTP0RC7795SKBX0010SA00 (H3 ES1.1))
-                # H3ULCB (R-Car Starter Kit Premier, RTP0RC77951SKBX010SA00 (H3 ES2.0))
-              - renesas,h3ulcb
+              - renesas,h3ulcb # H3ULCB (R-Car Starter Kit Premier, RTP0RC77951SKBX010SA00 (H3 ES2.0))
               - renesas,salvator-x # Salvator-X (RTP0RC7795SIPB0010S)
               - renesas,salvator-xs # Salvator-XS (Salvator-X 2nd version, RTP0RC7795SIPB0012S)
           - const: renesas,r8a7795
-- 
2.35.1

