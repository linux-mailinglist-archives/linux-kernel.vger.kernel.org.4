Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E45370567D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 21:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbjEPTBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 15:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjEPTBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 15:01:01 -0400
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 758C7CC;
        Tue, 16 May 2023 12:01:00 -0700 (PDT)
Received: from 068-189-091-139.biz.spectrum.com ([68.189.91.139] helo=tharvey.pdc.gateworks.com)
        by finn.localdomain with esmtp (Exim 4.93)
        (envelope-from <tharvey@gateworks.com>)
        id 1pyzud-005SW3-Se; Tue, 16 May 2023 19:00:44 +0000
From:   Tim Harvey <tharvey@gateworks.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tim Harvey <tharvey@gateworks.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH V2 1/2] dt-bindings: arm: Add Gateworks i.MX8M GW7905-2x board
Date:   Tue, 16 May 2023 12:00:40 -0700
Message-Id: <20230516190041.476045-1-tharvey@gateworks.com>
X-Mailer: git-send-email 2.25.1
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

Add DT compatible string for a Gateworks GW7905-2x board based on
the i.MX8MPlus from NXP.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
v2:
 - add Krzysztof's tag

 Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 15d411084065..d041d54d62c7 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -1019,6 +1019,7 @@ properties:
               - dmo,imx8mp-data-modul-edm-sbc # i.MX8MP eDM SBC
               - fsl,imx8mp-evk            # i.MX8MP EVK Board
               - gateworks,imx8mp-gw74xx   # i.MX8MP Gateworks Board
+              - gateworks,imx8mp-gw7905-2x # i.MX8MP Gateworks Board
               - polyhex,imx8mp-debix      # Polyhex Debix boards
               - polyhex,imx8mp-debix-model-a # Polyhex Debix Model A Board
               - toradex,verdin-imx8mp     # Verdin iMX8M Plus Modules
-- 
2.25.1

