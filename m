Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10CD27216F1
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 14:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbjFDM1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 08:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbjFDM1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 08:27:36 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F1411BF;
        Sun,  4 Jun 2023 05:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1685881633;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s1RJUCGj4nB1iNY8d5w8aIK40sAZLfxM8ksgaf5zRXc=;
        b=cPQrviulFS4Raq43BCRWx1X92wf5oie9PpfnuONQ1O9WBlIBs4bGm+zEjfv/TlHWHMrP0m
        w1g8C+Oe7vEwEoN/NXgKazr8ZnhNniDtFc55i7ELZtAkjQhvS1Y7ZHJaBI59wQWOr0Fj85
        HsfTgp0jXbE2xhp81GiE3SlEPOC0CaM=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Paul Burton <paulburton@kernel.org>,
        Siarhei Volkau <lis8215@gmail.com>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, list@opendingux.net,
        Paul Cercueil <paul@crapouillou.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH 4/4] MIPS: DTS: qi_lb60: Don't use unit address for regulators
Date:   Sun,  4 Jun 2023 14:26:55 +0200
Message-Id: <20230604122655.69698-4-paul@crapouillou.net>
In-Reply-To: <20230604122655.69698-1-paul@crapouillou.net>
References: <20230604122655.69698-1-paul@crapouillou.net>
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

The regulators don't have any "reg" property, and therefore shouldn't
use an unit address in their node names.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org
---
 arch/mips/boot/dts/ingenic/qi_lb60.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/boot/dts/ingenic/qi_lb60.dts b/arch/mips/boot/dts/ingenic/qi_lb60.dts
index ba0218971572..24f987244a12 100644
--- a/arch/mips/boot/dts/ingenic/qi_lb60.dts
+++ b/arch/mips/boot/dts/ingenic/qi_lb60.dts
@@ -27,7 +27,7 @@ chosen {
 		stdout-path = &uart0;
 	};
 
-	vcc: regulator@0 {
+	vcc: regulator-0 {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc";
 
@@ -36,7 +36,7 @@ vcc: regulator@0 {
 		regulator-always-on;
 	};
 
-	mmc_power: regulator@1 {
+	mmc_power: regulator-1 {
 		compatible = "regulator-fixed";
 		regulator-name = "mmc_vcc";
 		gpio = <&gpd 2 0>;
@@ -45,7 +45,7 @@ mmc_power: regulator@1 {
 		regulator-max-microvolt = <3300000>;
 	};
 
-	amp_supply: regulator@2 {
+	amp_supply: regulator-2 {
 		compatible = "regulator-fixed";
 		regulator-name = "amp_supply";
 		gpio = <&gpd 4 0>;
-- 
2.39.2

