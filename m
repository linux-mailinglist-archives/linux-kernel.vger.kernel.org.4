Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD3EF601AED
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 23:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbiJQVGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 17:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbiJQVFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 17:05:53 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D872C6BCDB;
        Mon, 17 Oct 2022 14:05:51 -0700 (PDT)
Received: from localhost (unknown [188.24.131.113])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id EDC66660232A;
        Mon, 17 Oct 2022 22:05:49 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666040750;
        bh=AaMf44NQLs0FWOmJ2NB4kVWHiWutQgTR2F4DGQiSUCA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wt9cEePWTnKmky3w2jqKP2BTP15iidh99hKmwyyPFVK4MBWhROmtRUonUkShnnSvS
         I7LDAOyqHVRh/Alp29RBzgyBz36h8PyxAq3z59t9OYcl3nrStywKmxPyICSjr/Xj7R
         hvchqd64Jsg6KnKaEE6hUxgSxCN9kUVCZILg/GhgaEsLQ0dUGFMoSmtdPKw41/uzT/
         V24qWkgoQvT+NA+9g0p25EqFxZFf4ezyyWIWqsTcyKb/kcx4Ni0lkXb9QW3vjuGRWg
         JGeINxoZXhO+vhMhUrnanb+y8iVIcFaIfszjElo7A3uchpO83jnen/Uc4BAIcWGNLA
         NFnT/3tz4vHNw==
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Michael Zhu <michael.zhu@starfivetech.com>,
        Drew Fustini <drew@beagleboard.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Conor Dooley <conor.dooley@microchip.com>
Cc:     devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 1/3] dt-bindings: riscv: starfive: Add StarFive VisionFive V1 board
Date:   Tue, 18 Oct 2022 00:05:40 +0300
Message-Id: <20221017210542.979051-2-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221017210542.979051-1-cristian.ciocaltea@collabora.com>
References: <20221017210542.979051-1-cristian.ciocaltea@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the compatibles for StarFive VisionFive V1 SBC [1].
The board is based on the StarFive JH7100 SoC.

[1] https://github.com/starfive-tech/VisionFive

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/riscv/starfive.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/riscv/starfive.yaml b/Documentation/devicetree/bindings/riscv/starfive.yaml
index 5b36243fd674..5d3fcee52d59 100644
--- a/Documentation/devicetree/bindings/riscv/starfive.yaml
+++ b/Documentation/devicetree/bindings/riscv/starfive.yaml
@@ -19,7 +19,9 @@ properties:
   compatible:
     oneOf:
       - items:
-          - const: beagle,beaglev-starlight-jh7100-r0
+          - enum:
+              - beagle,beaglev-starlight-jh7100-r0
+              - starfive,visionfive-v1
           - const: starfive,jh7100
 
 additionalProperties: true
-- 
2.38.0

