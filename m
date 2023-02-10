Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B89F6922D0
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 16:59:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232890AbjBJP7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 10:59:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232835AbjBJP7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 10:59:03 -0500
Received: from uho.ysoft.cz (uho.ysoft.cz [81.19.3.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FBA238EAB;
        Fri, 10 Feb 2023 07:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
        s=20160406-ysoft-com; t=1676044184;
        bh=eQ/1mUnsjQ6zYc1umeBMKBHU5GQF28XDVjcZeP9EVhc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R1VlslCRLAXYjnh56OKRyLSiGAF7/2b3rMegjkFVgYDLY6sjieSJuVK3+lU6iVNXS
         ZY5Xl5EZVslNrH050G9SZiozwAL4HMxmarj0IwQY3eekNMs6r1Omhoovcm4QSNcnKd
         8NCoDaniO1Hfg6lbK6JtReBnPaQmR62NQSPGJKt8=
Received: from vokac-Latitude-7410.ysoft.local (unknown [10.1.8.111])
        by uho.ysoft.cz (Postfix) with ESMTP id 8E159A06F4;
        Fri, 10 Feb 2023 16:49:44 +0100 (CET)
From:   =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
Subject: [PATCH 4/6] =?UTF-8?q?dt-bindings:=20arm:=20fsl:=20Add=20Y=20Soft?= =?UTF-8?q?=20IOTA=C2=A0Phoenix,=20Lynx,=20Pegasus=20and=20Pegasus+?=
Date:   Fri, 10 Feb 2023 16:48:53 +0100
Message-Id: <20230210154855.3086900-5-michal.vokac@ysoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230210154855.3086900-1-michal.vokac@ysoft.com>
References: <20230210154855.3086900-1-michal.vokac@ysoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These i.MX6 boards are based on a facelifted PCB from the previous designs.
Routing for some unused parts was completely removed (uSD card, PCIe, audio
codec) and some new parts were added (supercap backed RTC, secure element,
PWM audio, GPIO button).

Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 791c63b2d483..b6be20602ca0 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -242,6 +242,7 @@ properties:
               - variscite,dt6customboard
               - wand,imx6q-wandboard      # Wandboard i.MX6 Quad Board
               - ysoft,imx6q-yapp4-crux    # i.MX6 Quad Y Soft IOTA Crux board
+              - ysoft,imx6q-yapp4-pegasus # i.MX6 Quad Y Soft IOTA Pegasus board
               - zealz,imx6q-gk802         # Zealz GK802
               - zii,imx6q-zii-rdu2        # ZII RDU2 Board
           - const: fsl,imx6q
@@ -352,6 +353,7 @@ properties:
               - prt,prtwd3                # Protonic WD3 board
               - wand,imx6qp-wandboard     # Wandboard i.MX6 QuadPlus Board
               - ysoft,imx6qp-yapp4-crux-plus  # i.MX6 Quad Plus Y Soft IOTA Crux+ board
+              - ysoft,imx6qp-yapp4-pegasus-plus # i.MX6 Quad Plus Y Soft IOTA Pegasus+ board
               - zii,imx6qp-zii-rdu2       # ZII RDU2+ Board
           - const: fsl,imx6qp
 
@@ -418,7 +420,9 @@ properties:
               - wand,imx6dl-wandboard     # Wandboard i.MX6 Dual Lite Board
               - ysoft,imx6dl-yapp4-draco  # i.MX6 Solo Y Soft IOTA Draco board
               - ysoft,imx6dl-yapp4-hydra  # i.MX6 DualLite Y Soft IOTA Hydra board
+              - ysoft,imx6dl-yapp4-lynx   # i.MX6 DualLite Y Soft IOTA Lynx board
               - ysoft,imx6dl-yapp4-orion  # i.MX6 DualLite Y Soft IOTA Orion board
+              - ysoft,imx6dl-yapp4-phoenix  # i.MX6 DualLite Y Soft IOTA Phoenix board
               - ysoft,imx6dl-yapp4-ursa   # i.MX6 Solo Y Soft IOTA Ursa board
           - const: fsl,imx6dl
 
-- 
2.25.1

