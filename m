Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CDFD5B6DB8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 14:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231882AbiIMMx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 08:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbiIMMxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 08:53:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 521EB52DC4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 05:53:18 -0700 (PDT)
Date:   Tue, 13 Sep 2022 12:53:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1663073596;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jy7yKsA4zbBJAHnwTbtPZlibswqQuh312rB6ckiooQ4=;
        b=tFyS4Rset0eMFmFVXpuQu5N/iFybSWHu3UKCcQ/8L95jNmIzWEa/KYzP5ggdpmthyNoeOc
        uWyTCsNExjw10iawLneFDlZoK5WdbOxUMfzcuXRcwlHiSLPsExml4vlIrAlqL27b95SbJ/
        hRFdbVzQy+M3LS3Vg1CnUXHqh7RCH+H8KYuDhf1t4f1YDjGPGZC+W/kWbvJcnocQexjrZJ
        Co0pn+PB/16TFMR/iFF/c98tsx23mT/rC+EnP4E+0Md+yd9gkTFFxf4b8FOfaoZwgcMlVB
        /z8VLtyY+DN0zNfLSOu54ajsHkFiuf9k1O1P3Bz7QzvtOWFzyOuwkpSDd5irUQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1663073596;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jy7yKsA4zbBJAHnwTbtPZlibswqQuh312rB6ckiooQ4=;
        b=7Fk5+pSGVjxSMnvT+H6zawA9Mto6LbMnO+VslSRZUtPuVWlD6GB3OUvLcJ3n4W3sAcwr/A
        /84QOmZNmkRqmxDA==
From:   "irqchip-bot for Huacai Chen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-fixes] irqchip: Select downstream irqchip
 drivers for LoongArch CPU
Cc:     kernel test robot <lkp@intel.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20220808085319.3350111-1-chenhuacai@loongson.cn>
References: <20220808085319.3350111-1-chenhuacai@loongson.cn>
MIME-Version: 1.0
Message-ID: <166307359441.401.13393713212108483468.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-fixes branch of irqchip:

Commit-ID:     8d5356f9820dc48578fc50077f5a34905386e47f
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/8d5356f9820dc48578fc50077f5a34905386e47f
Author:        Huacai Chen <chenhuacai@loongson.cn>
AuthorDate:    Mon, 08 Aug 2022 16:53:19 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Mon, 12 Sep 2022 16:50:55 +01:00

irqchip: Select downstream irqchip drivers for LoongArch CPU

LoongArch irqchips have a fixed hierarchy which currently can't be
described by ACPI tables, so upstream irqchip drivers call downstream
irqchip drivers' initialization directly. As a result, the top level
(CPU-level) irqchip driver should explicitly select downstream drivers
to avoid build errors.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20220808085319.3350111-1-chenhuacai@loongson.cn
---
 drivers/irqchip/Kconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 66b9fa4..2549daa 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -561,6 +561,11 @@ config IRQ_LOONGARCH_CPU
 	select GENERIC_IRQ_CHIP
 	select IRQ_DOMAIN
 	select GENERIC_IRQ_EFFECTIVE_AFF_MASK
+	select LOONGSON_LIOINTC
+	select LOONGSON_EIOINTC
+	select LOONGSON_PCH_PIC
+	select LOONGSON_PCH_MSI
+	select LOONGSON_PCH_LPC
 	help
 	  Support for the LoongArch CPU Interrupt Controller. For details of
 	  irq chip hierarchy on LoongArch platforms please read the document
