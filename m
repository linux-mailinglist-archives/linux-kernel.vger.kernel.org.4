Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11D19718247
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 15:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236465AbjEaNl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 09:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236543AbjEaNlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 09:41:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E205BE58;
        Wed, 31 May 2023 06:40:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 05A0363B0A;
        Wed, 31 May 2023 13:40:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 681F2C43446;
        Wed, 31 May 2023 13:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685540442;
        bh=+Uc/69FxdQG6Cx4lTgPkXnqoeB2Ro0Egv3BZI2vb6mg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Uetn8Pqca5VUX6gKBltUIG25c8qPIBcl2sHjBlqXv2A1jB9gHx7g8UnJCL8jSFQvd
         Ntyau8wA+N42Omn9nfYzsdfYI4G1hPCUUvKQKt/Mmu7HOkIB0gJW3V2LdMZJoFdZOq
         YaKKSidCXhwv982eHTfkh0JsNvPgSqI2h4KOOZkbK/qtidqaCdaeYHykY+K/zDnjJw
         VdUAS8ZtM4vqzDVjRP2x+oewQZn61roXA9PX8rAAQ60jLRLbWRsjzXraLXNvglWdUo
         fmGAg296P/oojNIbh+ANlEP18uu588RTzGmlbMUL5NfkFuJ63cegiGb+j4MN8bGSBp
         LzQqyjyRKGfgw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Marc Zyngier <maz@kernel.org>, Sasha Levin <sashal@kernel.org>,
        tglx@linutronix.de, neil.armstrong@linaro.org,
        khilman@baylibre.com, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH AUTOSEL 6.3 13/37] irqchip/meson-gpio: Mark OF related data as maybe unused
Date:   Wed, 31 May 2023 09:39:55 -0400
Message-Id: <20230531134020.3383253-13-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230531134020.3383253-1-sashal@kernel.org>
References: <20230531134020.3383253-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[ Upstream commit 14130211be5366a91ec07c3284c183b75d8fba17 ]

The driver can be compile tested with !CONFIG_OF making certain data
unused:

  drivers/irqchip/irq-meson-gpio.c:153:34: error: ‘meson_irq_gpio_matches’ defined but not used [-Werror=unused-const-variable=]

Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20230512164506.212267-1-krzysztof.kozlowski@linaro.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/irqchip/irq-meson-gpio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-meson-gpio.c b/drivers/irqchip/irq-meson-gpio.c
index 2aaa9aad3e87a..7da18ef952119 100644
--- a/drivers/irqchip/irq-meson-gpio.c
+++ b/drivers/irqchip/irq-meson-gpio.c
@@ -150,7 +150,7 @@ static const struct meson_gpio_irq_params s4_params = {
 	INIT_MESON_S4_COMMON_DATA(82)
 };
 
-static const struct of_device_id meson_irq_gpio_matches[] = {
+static const struct of_device_id meson_irq_gpio_matches[] __maybe_unused = {
 	{ .compatible = "amlogic,meson8-gpio-intc", .data = &meson8_params },
 	{ .compatible = "amlogic,meson8b-gpio-intc", .data = &meson8b_params },
 	{ .compatible = "amlogic,meson-gxbb-gpio-intc", .data = &gxbb_params },
-- 
2.39.2

