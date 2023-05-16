Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2E88704A67
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 12:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232291AbjEPKWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 06:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231976AbjEPKWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 06:22:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 744753AB5
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 03:22:39 -0700 (PDT)
Date:   Tue, 16 May 2023 10:22:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684232557;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bxz4I3L1NMCAt+Ar8JZmZGLHMEwvK+Y+3kMvN8g85C8=;
        b=obd6qIS3A+aWYhy66mG9L1xPwq45RvN/epHd3klfmmSMdi0e6+0sHZE7ms7egPPD+8Fi0i
        6uJrwnCMGebcvj0lN0qFYVN03OmBBktBx5o3teyh829HdNBbMCshMFFNw/1WWWx6QW764i
        990/GEQLP/LwI1y19UXzHhh6wfkb8ipRXfHW9OIUEH8hzLKLifJPCRsynoTRmL/R+xhyD8
        OC1ZjlI72A8NdtxphfDTaDxmVG1axTteL2j2TMIFnR1Ef4cOSGyAvOT9gtHL8xevgZCMku
        8vdnEP8I2n7KEPy7WiuvNguQoNhog+UNIRM5s+k4bPfGZdh956wJOYdws5CvBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684232557;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bxz4I3L1NMCAt+Ar8JZmZGLHMEwvK+Y+3kMvN8g85C8=;
        b=u+D3KqW6DHApKcHF2jgAC++vfXR9tAAUS8O76U1SgElvh1vTgqJQFeY+QJKk0JJplX8qMY
        ec2e7lLin5kcMaDg==
From:   "irqchip-bot for Krzysztof Kozlowski" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-fixes] irqchip/meson-gpio: Mark OF related data
 as maybe unused
Cc:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20230512164506.212267-1-krzysztof.kozlowski@linaro.org>
References: <20230512164506.212267-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Message-ID: <168423255682.404.11441650260460262104.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-fixes branch of irq=
chip:

Commit-ID:     14130211be5366a91ec07c3284c183b75d8fba17
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platfo=
rms/14130211be5366a91ec07c3284c183b75d8fba17
Author:        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
AuthorDate:    Fri, 12 May 2023 18:45:06 +02:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Tue, 16 May 2023 11:01:18 +01:00

irqchip/meson-gpio: Mark OF related data as maybe unused

The driver can be compile tested with !CONFIG_OF making certain data
unused:

  drivers/irqchip/irq-meson-gpio.c:153:34: error: =E2=80=98meson_irq_gpio_mat=
ches=E2=80=99 defined but not used [-Werror=3Dunused-const-variable=3D]

Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20230512164506.212267-1-krzysztof.kozlowski@l=
inaro.org
---
 drivers/irqchip/irq-meson-gpio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-meson-gpio.c b/drivers/irqchip/irq-meson-gpi=
o.c
index 2aaa9aa..7da18ef 100644
--- a/drivers/irqchip/irq-meson-gpio.c
+++ b/drivers/irqchip/irq-meson-gpio.c
@@ -150,7 +150,7 @@ static const struct meson_gpio_irq_params s4_params =3D {
 	INIT_MESON_S4_COMMON_DATA(82)
 };
=20
-static const struct of_device_id meson_irq_gpio_matches[] =3D {
+static const struct of_device_id meson_irq_gpio_matches[] __maybe_unused =3D=
 {
 	{ .compatible =3D "amlogic,meson8-gpio-intc", .data =3D &meson8_params },
 	{ .compatible =3D "amlogic,meson8b-gpio-intc", .data =3D &meson8b_params },
 	{ .compatible =3D "amlogic,meson-gxbb-gpio-intc", .data =3D &gxbb_params },
