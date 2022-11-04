Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFB79619AF8
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 16:07:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232274AbiKDPHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 11:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232419AbiKDPHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 11:07:04 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 417ED959B
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 08:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=k1; bh=R70gBy0m0MbozJ2K4Le71tLAXCw
        UziIMAwHzbCELvIE=; b=f98Y7fsPCImPg8hIOHGA1jaFMLlSRPo9iSnblogVzjg
        kwQeSq3ZrgMK9dbUUC0EWWhRpE8rQ0FIUMyAXAkDBvw8d0DlcJAqyaNGzg4Km2nX
        xQQR0IcRLd5LWuVzkVfqaSPUCOf6u87G8oY4P8n5MWbWUrz519tolAcVDNx4ROUQ
        =
Received: (qmail 3146712 invoked from network); 4 Nov 2022 16:06:58 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 4 Nov 2022 16:06:58 +0100
X-UD-Smtp-Session: l3s3148p1@ISWibKbsk11ZD+8G
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH] dt-bindings: timer: renesas,cmt: Add r8a779g0 CMT support
Date:   Fri,  4 Nov 2022 16:06:42 +0100
Message-Id: <20221104150642.4587-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 Documentation/devicetree/bindings/timer/renesas,cmt.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/timer/renesas,cmt.yaml b/Documentation/devicetree/bindings/timer/renesas,cmt.yaml
index bde6c9b66bf4..a0be1755ea28 100644
--- a/Documentation/devicetree/bindings/timer/renesas,cmt.yaml
+++ b/Documentation/devicetree/bindings/timer/renesas,cmt.yaml
@@ -102,12 +102,14 @@ properties:
           - enum:
               - renesas,r8a779a0-cmt0     # 32-bit CMT0 on R-Car V3U
               - renesas,r8a779f0-cmt0     # 32-bit CMT0 on R-Car S4-8
+              - renesas,r8a779g0-cmt0     # 32-bit CMT0 on R-Car V4H
           - const: renesas,rcar-gen4-cmt0 # 32-bit CMT0 on R-Car Gen4
 
       - items:
           - enum:
               - renesas,r8a779a0-cmt1     # 48-bit CMT on R-Car V3U
               - renesas,r8a779f0-cmt1     # 48-bit CMT on R-Car S4-8
+              - renesas,r8a779g0-cmt1     # 48-bit CMT on R-Car V4H
           - const: renesas,rcar-gen4-cmt1 # 48-bit CMT on R-Car Gen4
 
   reg:
-- 
2.35.1

