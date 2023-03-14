Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D581A6B9DE0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 19:06:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbjCNSGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 14:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjCNSGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 14:06:41 -0400
Received: from uho.ysoft.cz (uho.ysoft.cz [81.19.3.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B15F9FE4C;
        Tue, 14 Mar 2023 11:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
        s=20160406-ysoft-com; t=1678817197;
        bh=CPyrwY41zCcCYtYW1XjUD/gtyd8Rz/bTbU8OHbiOVH8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SddtKUPlPm8JRGuXuF+fz0zlbz/yiGPtdbfETkrqz8eabylKre2WkACUmOmllvr0w
         lAb/dFhHomBsnmd8lt5JipI/kNADUw6yFH/I6JICdbwLOzI9a4iFLEPesURiHrgByl
         CQYmuYRb6A0jJavjk+2drAgtfZyAIIUr9tZ0wg4U=
Received: from vokac-Latitude-7410.ysoft.local (unknown [10.0.30.161])
        by uho.ysoft.cz (Postfix) with ESMTP id 564EEA0518;
        Tue, 14 Mar 2023 19:06:37 +0100 (CET)
From:   =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
Subject: [PATCH v2 2/5] =?UTF-8?q?ARM:=C2=A0dts:=20imx6dl-yapp4:=20Move=20?= =?UTF-8?q?status=20to=20the=20end=20of=20property=20list?=
Date:   Tue, 14 Mar 2023 19:06:05 +0100
Message-Id: <20230314180608.44482-3-michal.vokac@ysoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230314180608.44482-1-michal.vokac@ysoft.com>
References: <20230314180608.44482-1-michal.vokac@ysoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The status property should always be last in the list.

Fixes: b86d3d21cd4c ("ARM: dts: imx6dl-yapp4: Add reg property to the lp5562 channel node")
Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
---
Changes in v2:
- new patch

 arch/arm/boot/dts/imx6dl-yapp4-common.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi b/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
index cb1972f8e8d2..8a78a656bac0 100644
--- a/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
+++ b/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
@@ -269,9 +269,9 @@ leds: led-controller@30 {
 		compatible = "ti,lp5562";
 		reg = <0x30>;
 		clock-mode = /bits/ 8 <1>;
-		status = "disabled";
 		#address-cells = <1>;
 		#size-cells = <0>;
+		status = "disabled";
 
 		led@0 {
 			chan-name = "R";
-- 
2.25.1

