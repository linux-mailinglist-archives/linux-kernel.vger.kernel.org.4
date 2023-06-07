Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0A2725DD9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 13:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240485AbjFGL6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 07:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240517AbjFGL6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 07:58:21 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F17CE1FDB
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 04:58:11 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lgo@pengutronix.de>)
        id 1q6rne-0000Tp-JL; Wed, 07 Jun 2023 13:58:02 +0200
Received: from [2a0a:edc0:0:1101:1d::39] (helo=dude03.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <lgo@pengutronix.de>)
        id 1q6rnd-005jGM-Ty; Wed, 07 Jun 2023 13:58:01 +0200
Received: from lgo by dude03.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <lgo@pengutronix.de>)
        id 1q6rnd-00CTiq-55; Wed, 07 Jun 2023 13:58:01 +0200
From:   =?UTF-8?q?Leonard=20G=C3=B6hrs?= <l.goehrs@pengutronix.de>
To:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     kernel@pengutronix.de,
        =?UTF-8?q?Leonard=20G=C3=B6hrs?= <l.goehrs@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 7/8] dt-bindings: arm: stm32: Add compatible string for Linux Automation LXA TAC
Date:   Wed,  7 Jun 2023 13:55:06 +0200
Message-Id: <20230607115508.2964574-7-l.goehrs@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230607115508.2964574-1-l.goehrs@pengutronix.de>
References: <20230607115508.2964574-1-l.goehrs@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: lgo@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT compatible string for Linux Automation GmbH Test Automation
Controllers (LXA TAC).
LXA TACs are a development tool for embedded devices with a focus on
embedded Linux devices.

As of now there are two STM32MP157 based hardware generations (Gen 1 and
Gen 2) that have most of their hardware config in common.
In the future there will also be a STM32MP153 based hardware generation.

Signed-off-by: Leonard Göhrs <l.goehrs@pengutronix.de>
---
 Documentation/devicetree/bindings/arm/stm32/stm32.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/stm32/stm32.yaml b/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
index 13e34241145b4..11f8706101eca 100644
--- a/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
+++ b/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
@@ -143,7 +143,9 @@ properties:
       - description: Octavo OSD32MP15x System-in-Package based boards
         items:
           - enum:
-              - lxa,stm32mp157c-mc1 # Linux Automation MC-1
+              - lxa,stm32mp157c-mc1      # Linux Automation MC-1
+              - lxa,stm32mp157c-tac-gen1 # Linux Automation TAC (Generation 1)
+              - lxa,stm32mp157c-tac-gen2 # Linux Automation TAC (Generation 2)
           - const: oct,stm32mp15xx-osd32
           - enum:
               - st,stm32mp157
-- 
2.39.2

