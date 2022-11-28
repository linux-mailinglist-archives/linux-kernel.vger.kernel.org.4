Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E35B363A76C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 12:54:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbiK1LyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 06:54:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbiK1Lx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 06:53:58 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CB4CB1CC
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 03:53:57 -0800 (PST)
Date:   Mon, 28 Nov 2022 11:53:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669636435;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ytrbYY9Bi5wFxKoqsejNQD9YZToZ4Kc9rbTdTcNgoK0=;
        b=gjQIXkKbeKAYu/10hwabYJdkI5yaNILG6jrcaMwwI712wPNUY6d6OtkrdFhSB4Rzyj2+4x
        D2LFTvzzVTT6ZCuWhF9fam0O9jYbSEvZMSJFGKOXELk42DhYELfyiyE7cJQ3YSbSEKCUh8
        yeWqE5OVR6+pOPYH9925g5MliEBRCIFw1kldH5muoFgF7zRYV/+hZQC3agRMWuob17K6Nf
        JU8BFbLbf80JJricw8615/AT4ezNX0xixH8CUX+Tg504uxFKhSRPIx3e/KHFH1C09NUhKb
        VXl78ISBXWiDbdAABSPzDBAH9zdSZdWjTQtRLBLU1pyV2TY3qul+JC1VYKsXlQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669636435;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ytrbYY9Bi5wFxKoqsejNQD9YZToZ4Kc9rbTdTcNgoK0=;
        b=/YX0mhsszyxHOew4p0Kt2Si4LDxZ+Q3uCikhxZz3qidNifNbZf/bYjcRsS+FBEXV3dAfb0
        qBdOttXSIhW3BHAg==
From:   "irqchip-bot for AngeloGioacchino Del Regno" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/irq-mtk-cirq: Add support for
 System CIRQ on MT8192
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20221128092217.36552-5-angelogioacchino.delregno@collabora.com>
References: <20221128092217.36552-5-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Message-ID: <166963643407.4906.7778593583371085086.tip-bot2@tip-bot2>
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

Commit-ID:     5c4e0aac0b2a27168844da49cee2c5dff2925d22
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/5c4e0aac0b2a27168844da49cee2c5dff2925d22
Author:        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
AuthorDate:    Mon, 28 Nov 2022 10:22:17 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Mon, 28 Nov 2022 11:44:02 

irqchip/irq-mtk-cirq: Add support for System CIRQ on MT8192

On some SoCs the System CIRQ register layout is slightly different,
as there are more registers per function and in some cases other
differences later in the layout: this is seen on at least MT8192,
but it's also valid for some other "contemporary" SoCs both for
Chromebooks and for smartphones.

Add the new "v2" register layout and use it if the compatible
"mediatek,mt8192-cirq" is found.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20221128092217.36552-5-angelogioacchino.delregno@collabora.com
---
 drivers/irqchip/irq-mtk-cirq.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/irqchip/irq-mtk-cirq.c b/drivers/irqchip/irq-mtk-cirq.c
index 4776ed6..76bc028 100644
--- a/drivers/irqchip/irq-mtk-cirq.c
+++ b/drivers/irqchip/irq-mtk-cirq.c
@@ -39,6 +39,18 @@ static const u32 mtk_cirq_regoffs_v1[] = {
 	[CIRQ_CONTROL]	= 0x300,
 };
 
+static const u32 mtk_cirq_regoffs_v2[] = {
+	[CIRQ_STA]	= 0x0,
+	[CIRQ_ACK]	= 0x80,
+	[CIRQ_MASK_SET]	= 0x180,
+	[CIRQ_MASK_CLR]	= 0x200,
+	[CIRQ_SENS_SET]	= 0x300,
+	[CIRQ_SENS_CLR]	= 0x380,
+	[CIRQ_POL_SET]	= 0x480,
+	[CIRQ_POL_CLR]	= 0x500,
+	[CIRQ_CONTROL]	= 0x600,
+};
+
 #define CIRQ_EN	0x1
 #define CIRQ_EDGE	0x2
 #define CIRQ_FLUSH	0x4
@@ -277,6 +289,7 @@ static const struct of_device_id mtk_cirq_of_match[] = {
 	{ .compatible = "mediatek,mt2701-cirq", .data = &mtk_cirq_regoffs_v1 },
 	{ .compatible = "mediatek,mt8135-cirq", .data = &mtk_cirq_regoffs_v1 },
 	{ .compatible = "mediatek,mt8173-cirq", .data = &mtk_cirq_regoffs_v1 },
+	{ .compatible = "mediatek,mt8192-cirq", .data = &mtk_cirq_regoffs_v2 },
 	{ /* sentinel */ }
 };
 
