Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA3A724EA2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 23:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239505AbjFFVQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 17:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238517AbjFFVQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 17:16:08 -0400
Received: from smtp.dudau.co.uk (dliviu.plus.com [80.229.23.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B473E1725;
        Tue,  6 Jun 2023 14:16:05 -0700 (PDT)
Received: from mail.dudau.co.uk (bart.dudau.co.uk [192.168.14.2])
        by smtp.dudau.co.uk (Postfix) with SMTP id 034C941D13A7;
        Tue,  6 Jun 2023 22:16:04 +0100 (BST)
Received: by mail.dudau.co.uk (sSMTP sendmail emulation); Tue, 06 Jun 2023 22:16:04 +0100
From:   Liviu Dudau <liviu@dudau.co.uk>
To:     =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Liviu Dudau <liviu@dudau.co.uk>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v4 1/2] dt-bindings: mips: Add bindings for TP-Link HC220 G5 v1 board
Date:   Tue,  6 Jun 2023 22:15:59 +0100
Message-Id: <20230606211600.1601694-2-liviu@dudau.co.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230606211600.1601694-1-liviu@dudau.co.uk>
References: <20230606211600.1601694-1-liviu@dudau.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for the compatible string used for the TP-Link's
HC220 G5 V1 board, a wireless AP based on MT7621.

Signed-off-by: Liviu Dudau <liviu@dudau.co.uk>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Acked-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 Documentation/devicetree/bindings/mips/ralink.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mips/ralink.yaml b/Documentation/devicetree/bindings/mips/ralink.yaml
index 704b5b5951271..53c1f66353770 100644
--- a/Documentation/devicetree/bindings/mips/ralink.yaml
+++ b/Documentation/devicetree/bindings/mips/ralink.yaml
@@ -80,6 +80,7 @@ properties:
           - enum:
               - gnubee,gb-pc1
               - gnubee,gb-pc2
+              - tplink,hc220-g5-v1
           - const: mediatek,mt7621-soc
 
 additionalProperties: true
-- 
2.40.1

