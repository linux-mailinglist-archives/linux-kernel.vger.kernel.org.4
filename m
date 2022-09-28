Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED6F5EDDD5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 15:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234122AbiI1Nhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 09:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233957AbiI1NhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 09:37:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 457A38F97B
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 06:37:20 -0700 (PDT)
Date:   Wed, 28 Sep 2022 13:37:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1664372238;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=56B7gMKSRSNYnNP0BCnRZSPKxz31JBKPy0BNp1NcrXA=;
        b=NzIpZOe+aoHjJMNkH03M/JjxVFvXllUI6/CJZ/USj9HlGUm9U7Tu8XgkrToAuEbRN7ac7f
        GYm5qPSXPz8HUYbNiToETQ9Nhjv/+rN9oBrv+JyhNjg9Y/oODo9TrGkbZQxI5CuVKRWw8j
        b94sVm4HMzlgDqj08aSDjr6SmfDiRKWVTVnz8O8CjxHWRcYyfiuKqzHCle481QKH2Wxlk0
        4GU5G3bhhPN26ESVCD5C1u85J5G5WNZEcJ5gdhe4l0qff12M5BKWVxDyfNMpHOznF+zcsY
        XFzR0mgR5UBqzA8Sdr8vJHEChVfogPRiukc8gtwmX+lMu430ldbB9+5jxRhWNQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1664372238;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=56B7gMKSRSNYnNP0BCnRZSPKxz31JBKPy0BNp1NcrXA=;
        b=Sn2L6lPwEnQAFY0YPM1uSU51DmF3jMOT1Q9edXWbnGzVWc0WLik8QMus0mkdvGJ08JURHi
        psuOzSpFyOyES0Bw==
From:   "irqchip-bot for Frank Li" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] platform-msi: Export symbol
 platform_msi_create_irq_domain()
Cc:     Frank Li <Frank.Li@nxp.com>, Marc Zyngier <maz@kernel.org>,
        tglx@linutronix.de
In-Reply-To: <20220922161246.20586-2-Frank.Li@nxp.com>
References: <20220922161246.20586-2-Frank.Li@nxp.com>
MIME-Version: 1.0
Message-ID: <166437223771.401.9808676891572289166.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     aecd1de3b1438cc4ead086a025fb49a3a896d615
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/aecd1de3b1438cc4ead086a025fb49a3a896d615
Author:        Frank Li <Frank.Li@nxp.com>
AuthorDate:    Thu, 22 Sep 2022 11:12:41 -05:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 28 Sep 2022 14:21:05 +01:00

platform-msi: Export symbol platform_msi_create_irq_domain()

Allow irqchip drivers using platform MSI to be built as modules.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
[maz: rewrote commit message]
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20220922161246.20586-2-Frank.Li@nxp.com
---
 drivers/base/platform-msi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/platform-msi.c b/drivers/base/platform-msi.c
index 296ea67..12b0441 100644
--- a/drivers/base/platform-msi.c
+++ b/drivers/base/platform-msi.c
@@ -138,6 +138,7 @@ struct irq_domain *platform_msi_create_irq_domain(struct fwnode_handle *fwnode,
 
 	return domain;
 }
+EXPORT_SYMBOL_GPL(platform_msi_create_irq_domain);
 
 static int platform_msi_alloc_priv_data(struct device *dev, unsigned int nvec,
 					irq_write_msi_msg_t write_msi_msg)
