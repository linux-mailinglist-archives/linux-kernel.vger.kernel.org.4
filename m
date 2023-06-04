Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00024721805
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 16:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232403AbjFDO5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 10:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232103AbjFDO5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 10:57:46 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 962FACD;
        Sun,  4 Jun 2023 07:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1685890614;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R034GfN4U7HHrFGjYKI1LuV6Myfk+MiHIp4yvLQp6ls=;
        b=EJiormvbwoebR/mX4UcvHhjtLJwqS77vQhF7PmPNrqIrX/nyHVfm3pUrkK47P24iAf2IV7
        eb6/Z3f4XdMOcCMzAGUCCtjEhPcMN/u+J4eHUDzBorECQLhEweUG7f7GN/yg/FOlYkGxDv
        QEwqMim+Y+fECntkiYfJ1+ajeOdV/pY=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     "H . Nikolaus Schaller" <hns@goldelico.com>,
        linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, list@opendingux.net,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 4/9] MIPS: DTS: CI20: Do not force-enable CIM and WiFi regulators
Date:   Sun,  4 Jun 2023 16:56:37 +0200
Message-Id: <20230604145642.200577-5-paul@crapouillou.net>
In-Reply-To: <20230604145642.200577-1-paul@crapouillou.net>
References: <20230604145642.200577-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These regulators should be enabled by their respective drivers.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 arch/mips/boot/dts/ingenic/ci20.dts | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/mips/boot/dts/ingenic/ci20.dts b/arch/mips/boot/dts/ingenic/ci20.dts
index 662796acda41..7f6e7a4e3915 100644
--- a/arch/mips/boot/dts/ingenic/ci20.dts
+++ b/arch/mips/boot/dts/ingenic/ci20.dts
@@ -272,19 +272,16 @@ wifi_io: LDO6 {
 				regulator-min-microvolt = <2500000>;
 				regulator-max-microvolt = <2500000>;
 				inl-supply = <&vcc_33v>;
-				regulator-always-on;
 			};
 			cim_io_28: LDO7 {
 				regulator-min-microvolt = <2800000>;
 				regulator-max-microvolt = <2800000>;
 				inl-supply = <&vcc_33v>;
-				regulator-always-on;
 			};
 			cim_io_15: LDO8 {
 				regulator-min-microvolt = <1500000>;
 				regulator-max-microvolt = <1500000>;
 				inl-supply = <&vcc_33v>;
-				regulator-always-on;
 			};
 			vrtc_18: LDO_REG9 {
 				/* Despite the datasheet stating 3.3V
-- 
2.39.2

