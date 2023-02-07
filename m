Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0FE568DC23
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 15:53:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbjBGOxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 09:53:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjBGOxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 09:53:04 -0500
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9DCCB761;
        Tue,  7 Feb 2023 06:52:59 -0800 (PST)
Received: (Authenticated sender: clement.leger@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id C0FF21BF20C;
        Tue,  7 Feb 2023 14:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1675781578;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j2/3cXaxny95Q4D8yYhsZgl+n2ENCIE4bfiAT9/mBFA=;
        b=Z1c0Tl6cORygKGjZkgi4UDKNTIl+8DeGOWtT26TE7QKyMVHljktMJML7oS5L1YOpoUEoUc
        dwOLbxis3akUVQ0fPqbi609ovsTsR9VcAA2wvHev4QbKgfpl9rvt7REBtXU1Onzjej9eo5
        EGlCxJ5WfQ4K4zp7i7UwwhBhnseN+ZeJ3luprWCxyt2wERNG3jKxhv7UBx7T9DV9vQ7x47
        PhainMzdNLgnPQa/5rfQeVKvmeiuzdQqzi09Sd3L/H+cp1QQl5XazWWjrOnka1zlTu71oh
        6wog2qWLbrerQIS28Pbo0sbeGSUx9BGvRUz035qu5mZgkuWh/SA5W1L+qQ4cvg==
From:   =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>,
        =?UTF-8?q?Miqu=C3=A8l=20Raynal?= <miquel.raynal@bootlin.com>,
        Milan Stevanovic <milan.stevanovic@se.com>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Pascal Eberhard <pascal.eberhard@se.com>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: soc: renesas: renesas.yaml: add renesas,rzn1d400-eb compatible
Date:   Tue,  7 Feb 2023 15:54:43 +0100
Message-Id: <20230207145444.166950-2-clement.leger@bootlin.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230207145444.166950-1-clement.leger@bootlin.com>
References: <20230207145444.166950-1-clement.leger@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add "renesas,rzn1d400-eb" which target the RZ/N1 EB board when a RZ/N1D-DB
daughter board is plugged on it.

Signed-off-by: Clément Léger <clement.leger@bootlin.com>
---
 Documentation/devicetree/bindings/soc/renesas/renesas.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/renesas/renesas.yaml b/Documentation/devicetree/bindings/soc/renesas/renesas.yaml
index 2789022b52eb..c31b10e5f44e 100644
--- a/Documentation/devicetree/bindings/soc/renesas/renesas.yaml
+++ b/Documentation/devicetree/bindings/soc/renesas/renesas.yaml
@@ -431,6 +431,12 @@ properties:
               - renesas,rzn1d400-db # RZN1D-DB (RZ/N1D Demo Board for the RZ/N1D 400 pins package)
           - const: renesas,r9a06g032
 
+      - description: RZ/N1{D,S} EB
+        items:
+          - enum:
+              - renesas,rzn1d400-eb # RZN1D-EB (Expansion Board when using a RZN1D-DB)
+          - const: renesas,r9a06g032
+
       - description: RZ/Five and RZ/G2UL (R9A07G043)
         items:
           - enum:
-- 
2.39.0

