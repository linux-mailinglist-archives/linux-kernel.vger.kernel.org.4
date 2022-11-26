Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68E73639629
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 14:34:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbiKZNes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 08:34:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiKZNeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 08:34:37 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D751DA7F
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 05:34:36 -0800 (PST)
Date:   Sat, 26 Nov 2022 13:34:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669469674;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dKDND3GDJnvY9ZyMTLSV2UQZaSbHYFSI2ha5oMa/Fek=;
        b=s0Y0Ewg5niRD+tzkAYXULp+oW0iAhvIapRmKZWVkaus6EZS48OBZZtOiGA5lAxjce09QND
        BzuHMuN1o2+tM9/rhmUcYgcVfrQ93VxLFx3gJRKdBYfakuTj0/h8YcpisQUWZDSF6KvRgb
        dEAMx+Qh0hmOV3jHC8ZTuYy/Wuo2JcLGgI20090ohGPuKtyM6c1gcUnNwdfYjYURVtuaMr
        vFZIjy/7hZ9nASdpSGi0NS/4/qI7X7Crs+fPx13TRCzNvgqEE9bTHjp7XmmlRFOWeZWarM
        HHJ4hsjF0ReOU7uSC/d3pMEpt+GXrcSb9Ao/QGvyrgfbLdAHl8pGxoBo7D/GGw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669469674;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dKDND3GDJnvY9ZyMTLSV2UQZaSbHYFSI2ha5oMa/Fek=;
        b=3teGatumQ5gAeI2o2+RC/8xOz4cji4lDaC/3De9krk2s6Y8AgLBKwd38l6bSJuT0H1iUpd
        nAYwt9gCvFUfn4Cw==
From:   "irqchip-bot for wangjianli" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/mips-gic: Drop repeated word in comment
Cc:     wangjianli <wangjianli@cdjrlc.com>, philmd@linaro.org,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20221022054655.36496-1-wangjianli@cdjrlc.com>
References: <20221022054655.36496-1-wangjianli@cdjrlc.com>
MIME-Version: 1.0
Message-ID: <166946967368.4906.2141314585126518512.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqc=
hip:

Commit-ID:     915649da01de13961f9d6a891b6db5a6255ac0b2
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platfo=
rms/915649da01de13961f9d6a891b6db5a6255ac0b2
Author:        wangjianli <wangjianli@cdjrlc.com>
AuthorDate:    Sat, 22 Oct 2022 13:46:55 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sat, 26 Nov 2022 13:29:42=20

irqchip/mips-gic: Drop repeated word in comment

Delete the redundant word 'the'.

Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20221022054655.36496-1-wangjianli@cdjrlc.com
---
 drivers/irqchip/irq-mips-gic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index 1ba0f15..1a6a7a6 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -494,7 +494,7 @@ static int gic_irq_domain_map(struct irq_domain *d, unsig=
ned int virq,
 	map =3D GIC_MAP_PIN_MAP_TO_PIN | gic_cpu_pin;
=20
 	/*
-	 * If adding support for more per-cpu interrupts, keep the the
+	 * If adding support for more per-cpu interrupts, keep the
 	 * array in gic_all_vpes_irq_cpu_online() in sync.
 	 */
 	switch (intr) {
