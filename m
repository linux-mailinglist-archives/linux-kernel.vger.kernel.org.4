Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC7372A170
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 19:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbjFIRlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 13:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbjFIRlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 13:41:37 -0400
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C603588;
        Fri,  9 Jun 2023 10:41:35 -0700 (PDT)
Received: from 068-189-091-139.biz.spectrum.com ([68.189.91.139] helo=tharvey.pdc.gateworks.com)
        by finn.localdomain with esmtp (Exim 4.93)
        (envelope-from <tharvey@gateworks.com>)
        id 1q7g6n-006Chf-Lh; Fri, 09 Jun 2023 17:41:09 +0000
From:   Tim Harvey <tharvey@gateworks.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH v2 1/2] dt-bindings: arm: Add Gateworks i.MX8M Mini GW7905-0x board
Date:   Fri,  9 Jun 2023 10:41:06 -0700
Message-Id: <20230609174107.3373182-1-tharvey@gateworks.com>
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

Add DT compatible string for a Gateworks GW7905-0x board based on
the i.MX8M Mini from NXP.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
v2:
 - sort alphabetically
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 15d411084065..3a053e3e5929 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -902,6 +902,7 @@ properties:
               - fsl,imx8mm-ddr4-evk       # i.MX8MM DDR4 EVK Board
               - fsl,imx8mm-evk            # i.MX8MM EVK Board
               - gateworks,imx8mm-gw7904
+              - gateworks,imx8mm-gw7905-0x # i.MX8MM Gateworks Board
               - gw,imx8mm-gw71xx-0x       # i.MX8MM Gateworks Development Kit
               - gw,imx8mm-gw72xx-0x       # i.MX8MM Gateworks Development Kit
               - gw,imx8mm-gw73xx-0x       # i.MX8MM Gateworks Development Kit
-- 
2.25.1

