Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 214BC690A59
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 14:35:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbjBINe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 08:34:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbjBINes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 08:34:48 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE415FB66;
        Thu,  9 Feb 2023 05:34:29 -0800 (PST)
Received: (Authenticated sender: clement.leger@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 8907DFF80A;
        Thu,  9 Feb 2023 13:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1675949576;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R2zOQUAjt2I8dbN52IsUL+dPKaSTEc8e2Tf2jdFu8og=;
        b=UusUK6G8Z8h1vLarh4nWkHedlhQOw6mafUI/LsraDFvIBga0NjrDmZBg1XbpGCoO8nw7Up
        jI8ZsNTJmanA/KCdWzuc+Eubo3uM/oQkITcfFZQF6L68RZI54ysIat78mkS5GsVEL2MIjT
        pNYWoAtI4Zutte0XIZYiMnvBg23al6y8U33NEUksYibVa/JhVHEJo5b5u4AHmyh/mqDbsW
        u87+f1dwPaylstgPr/FSJt+5q0O9ZeVM37BPQwmwme4m/qLtzcYoYB9it66xxsLNjKnmv1
        89sDcBXmVQVWE8coMoQArrb/9bfXeWX1CEoFP/zPl1t0572Rc1SqVAsFYycpCA==
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
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: [PATCH v2 1/2] dt-bindings: soc: renesas: renesas.yaml: add renesas,rzn1d400-eb compatible
Date:   Thu,  9 Feb 2023 14:35:06 +0100
Message-Id: <20230209133507.150571-2-clement.leger@bootlin.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230209133507.150571-1-clement.leger@bootlin.com>
References: <20230209133507.150571-1-clement.leger@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add "renesas,rzn1d400-eb" which target the RZ/N1 EB board when a RZ/N1D-DB
daughter board is plugged on it.

Signed-off-by: Clément Léger <clement.leger@bootlin.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/soc/renesas/renesas.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/renesas/renesas.yaml b/Documentation/devicetree/bindings/soc/renesas/renesas.yaml
index 2789022b52eb..76f6da46ff5c 100644
--- a/Documentation/devicetree/bindings/soc/renesas/renesas.yaml
+++ b/Documentation/devicetree/bindings/soc/renesas/renesas.yaml
@@ -431,6 +431,13 @@ properties:
               - renesas,rzn1d400-db # RZN1D-DB (RZ/N1D Demo Board for the RZ/N1D 400 pins package)
           - const: renesas,r9a06g032
 
+      - description: RZ/N1{D,S} EB
+        items:
+          - enum:
+              - renesas,rzn1d400-eb # RZN1D-EB (Expansion Board when using a RZN1D-DB)
+          - const: renesas,rzn1d400-db
+          - const: renesas,r9a06g032
+
       - description: RZ/Five and RZ/G2UL (R9A07G043)
         items:
           - enum:
-- 
2.39.0

