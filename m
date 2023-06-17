Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5AE6733EC1
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 08:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345914AbjFQGkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 02:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234473AbjFQGj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 02:39:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E9602D70
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 23:39:52 -0700 (PDT)
Date:   Sat, 17 Jun 2023 06:39:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686983990;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EI0GW2Nm+QhCSuxVK61/nVtDUZUrRXj1BN5Rihu3s7s=;
        b=XOyC6bUrg9EMLef/030g++G4WYQsA587rXMlmLDs9FSwpLE4sbAuzbcJZtigPKXy9hPa6k
        LcCSJGarGu53qzm2AbIwECq8xZM03R6Me2STmXq79LTKlHJHQ78m6FRJ5k3iak16Uod4DD
        9YLJMGMMwcncB1IbQpJWYeB7m+RHwdS+BKb5ccuurhvzueHDS90TT0QVrbmSY2A7P8I1Wc
        YRaxYc0KOKD1CBR3jDSIDPGWFtIa5dMntH9INSDpaikKpoJUnF8ssVHhSjsZy3ie9jDOx8
        3AiRvmnja3VH8ZxlIY83f7QiEeCKSnhZU/E0pzl46pqWPm5YxvU7sPXIyApRbw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686983990;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EI0GW2Nm+QhCSuxVK61/nVtDUZUrRXj1BN5Rihu3s7s=;
        b=KBTC33wbkShyi45l8AC294VevDk7242Un5/K9RnTBVzaHORPp2DoDurouiUYcFnXhWFJ2f
        5froTHCBQV9OWVBw==
From:   "irqchip-bot for Arnd Bergmann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/mxs: Include linux/irqchip/mxs.h
Cc:     Arnd Bergmann <arnd@arndb.de>, Shawn Guo <shawnguo@kernel.org>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20230516200516.554663-4-arnd@kernel.org>
References: <20230516200516.554663-4-arnd@kernel.org>
MIME-Version: 1.0
Message-ID: <168698399031.404.4946111862133700285.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     5b7e5676209120814dbb9fec8bc3769f0f7a7958
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/5b7e5676209120814dbb9fec8bc3769f0f7a7958
Author:        Arnd Bergmann <arnd@arndb.de>
AuthorDate:    Tue, 16 May 2023 22:05:07 +02:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sat, 17 Jun 2023 07:21:15 +01:00

irqchip/mxs: Include linux/irqchip/mxs.h

This header contains the definition for icoll_handle_irq(), which
is used in arch/arm/mach-mxs/mach-mxs.c, without this we get a warning
about a missing prototype when building with W=1.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20230516200516.554663-4-arnd@kernel.org
---
 drivers/irqchip/irq-mxs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/irqchip/irq-mxs.c b/drivers/irqchip/irq-mxs.c
index 55cb6b5..b3b1fba 100644
--- a/drivers/irqchip/irq-mxs.c
+++ b/drivers/irqchip/irq-mxs.c
@@ -9,6 +9,7 @@
 #include <linux/init.h>
 #include <linux/irq.h>
 #include <linux/irqchip.h>
+#include <linux/irqchip/mxs.h>
 #include <linux/irqdomain.h>
 #include <linux/io.h>
 #include <linux/of.h>
