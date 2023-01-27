Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C91B067E292
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 12:04:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232845AbjA0LEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 06:04:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232782AbjA0LD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 06:03:58 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D8074FC33;
        Fri, 27 Jan 2023 03:03:50 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pLMVt-004hKi-RU; Fri, 27 Jan 2023 19:03:22 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 27 Jan 2023 19:03:21 +0800
Date:   Fri, 27 Jan 2023 19:03:21 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Jia Jie Ho <jiajie.ho@starfivetech.com>
Cc:     Olivia Mackall <olivia@selenic.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH] hwrng: starfive - Enable compile testing
Message-ID: <Y9OveVKTkX8cRhyP@gondor.apana.org.au>
References: <20230117015445.32500-1-jiajie.ho@starfivetech.com>
 <20230117015445.32500-3-jiajie.ho@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230117015445.32500-3-jiajie.ho@starfivetech.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable compile testing for jh7110.  Also remove the dependency on
HW_RANDOM.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/drivers/char/hw_random/Kconfig b/drivers/char/hw_random/Kconfig
index 9924e2f35b69..ae508e96cfc2 100644
--- a/drivers/char/hw_random/Kconfig
+++ b/drivers/char/hw_random/Kconfig
@@ -551,8 +551,7 @@ config HW_RANDOM_CN10K
 
 config HW_RANDOM_JH7110
 	tristate "StarFive JH7110 Random Number Generator support"
-	depends on SOC_STARFIVE
-	depends on HW_RANDOM
+	depends on SOC_STARFIVE || COMPILE_TEST
 	help
 	  This driver provides support for the True Random Number
 	  Generator in StarFive JH7110 SoCs.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
