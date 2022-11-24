Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 838A6637DFE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 18:04:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbiKXREG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 12:04:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbiKXRDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 12:03:45 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9767B748EE;
        Thu, 24 Nov 2022 09:03:17 -0800 (PST)
Date:   Thu, 24 Nov 2022 17:03:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669309395;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sJS/0jLM3YE0i7Xwtq5NfdvghuD8LZ+i4jPRuc60kzo=;
        b=MlaJvk+XM59aJB6CzJV5BEJVTKidiyufjmFkAo3d7aI1B/tuQtbcM08DBiQ71XhumhF6Ba
        vgHj+5iBxa2zqsKbQmFY2WaHLdUBu/jM3luIGmvGHqBIFpvsuMFT4plyO8EPf5A0C81ReX
        lzriUzUgH6/AVdBNKSZkc+eDNEINnpaJ6jGTHLxi1niuLcyRYoM4d0oJ8Us+lg4NA0ScpJ
        XmppvnjvmTnWQz/2AF79wxMhC+jfCtdU60/C2pSuk6gptWXNje+RpO046SZICUTvg4QFF4
        2h/+WxciI2W0V+eDBT2PUagw497lzQe1lFA4Er5UovtH1gqTsrbfz7a5gdTnYQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669309395;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sJS/0jLM3YE0i7Xwtq5NfdvghuD8LZ+i4jPRuc60kzo=;
        b=ULI1vk2PymjBfxgB92ImPFLQDeUak/alS1mHe1XMP7PqUWIIS4EmyiyZ4XiYKD+aa69Prp
        g/Fonh0n+Smt5QAw==
From:   "tip-bot2 for Randy Dunlap" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/irqreturn: Fix kernel-doc warnings
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20221124063013.28479-1-rdunlap@infradead.org>
References: <20221124063013.28479-1-rdunlap@infradead.org>
MIME-Version: 1.0
Message-ID: <166930939361.4906.365802629789314240.tip-bot2@tip-bot2>
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

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     f2756526450d19bca28714565062a8f286c05049
Gitweb:        https://git.kernel.org/tip/f2756526450d19bca28714565062a8f286c05049
Author:        Randy Dunlap <rdunlap@infradead.org>
AuthorDate:    Wed, 23 Nov 2022 22:30:13 -08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 24 Nov 2022 17:55:05 +01:00

genirq/irqreturn: Fix kernel-doc warnings

irqreturn.h:6: warning: missing initial short description on line:
 * enum irqreturn
irqreturn.h:15: warning: Enum value 'IRQ_NONE' not described in enum 'irqreturn'
irqreturn.h:15: warning: Enum value 'IRQ_HANDLED' not described in enum 'irqreturn'
irqreturn.h:15: warning: Enum value 'IRQ_WAKE_THREAD' not described in enum 'irqreturn'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20221124063013.28479-1-rdunlap@infradead.org

---
 include/linux/irqreturn.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/irqreturn.h b/include/linux/irqreturn.h
index bd4c066..d426c7a 100644
--- a/include/linux/irqreturn.h
+++ b/include/linux/irqreturn.h
@@ -3,10 +3,10 @@
 #define _LINUX_IRQRETURN_H
 
 /**
- * enum irqreturn
- * @IRQ_NONE		interrupt was not from this device or was not handled
- * @IRQ_HANDLED		interrupt was handled by this device
- * @IRQ_WAKE_THREAD	handler requests to wake the handler thread
+ * enum irqreturn - irqreturn type values
+ * @IRQ_NONE:		interrupt was not from this device or was not handled
+ * @IRQ_HANDLED:	interrupt was handled by this device
+ * @IRQ_WAKE_THREAD:	handler requests to wake the handler thread
  */
 enum irqreturn {
 	IRQ_NONE		= (0 << 0),
