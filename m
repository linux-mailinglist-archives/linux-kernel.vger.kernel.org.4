Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 363426398F5
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 00:41:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbiKZXln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 18:41:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiKZXlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 18:41:40 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9862BF73
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 15:41:38 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 77DCB5C0086;
        Sat, 26 Nov 2022 18:41:37 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sat, 26 Nov 2022 18:41:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1669506097; x=1669592497; bh=hd
        Uvaq3eie+r9PF0OlqmeKbt0IxTHeoQ0MpLNYqZ+Rw=; b=v3pJv01hvFZgVgBf5i
        f0EYSp/uRP5bRKPb98jG6wyoGjDKJ86s44lYOshly4tSHC15PscpRd+EEOGs4leV
        Kylk+B8QrUMURrXM72wEpRBocB5F4O1d+Y3WJ+RlOFo0o2yXvXwIh7IdbCIV8LcP
        MvJBVEjRe1PXCzCI5x4X6i4DBWfPimFgbAkZY9Wb0GMKgut45UI7IMK0zgxuPp61
        iX0Fo2/ibcF+34L7MkzqjRUfQ83Y5k9/YpQ3KpUQAx5Lk5xBuQiOSB5pZIzZaprU
        KfA/iD9EnafJsPX2qXv8koGWTxj+rcdkhm/aOgq7vnBMWc/da3Q6l586EBjo4eCc
        Dw1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1669506097; x=1669592497; bh=hdUvaq3eie+r9
        PF0OlqmeKbt0IxTHeoQ0MpLNYqZ+Rw=; b=gsAnqY0Nb/awF1P2O2Lu59+V0m/rj
        vJ015EBWac5kpbqbWosQPU22cCGZYUQ6bl64nYCS4EyXRj6zTXwSxuzBoexycv6Q
        mMKZTYhNFgoATjx0gVEZc4qR3SIeGcuxHFvE7/6ilfL4p5iPYJWxSplua99Xs2J5
        R/RUeiJwYO27i8ShLujxXBwjH/qDqNeHh52/re4iRY00jL9JLOLWsnZRbunS6xrw
        OVpXik5R1Hv24F25g34GPXu7PRku0qI2to9HefDSP4UI09XWbEteuE1KWVmqr39k
        XVXPYW23FwRNkDE4JUP4F0RJz6ANQSYKkD8akM65xgCnzIwCvV0G2I32Q==
X-ME-Sender: <xms:MaSCY4sf3l963pYo5lT7QckfoxVaq0Cx-MRt0laeF3Dqe4BUJCdpeA>
    <xme:MaSCY1dsBEgK6GeVePj697u2VDlw8XvfFi9xcvPtA7zcdXMFib8x2nFh97hU5ztzt
    vNblKkCn2VG5S3DTg>
X-ME-Received: <xmr:MaSCYzyjzOxh5WEoBe1xuDi-xajHdJxt3g9p3bkxqklGugYw32QXN3tLMIB1c8FaKctINHBYTWuZRjkJifmI9sm97ev5-h3ELXbGh9WzD2ukHTDOiP4Hxq69gtDUi4TbpgHfOg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrieekgdduudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpedukeetueduhedtleetvefguddvvdejhfefudelgfduveeggeehgfdu
    feeitdevteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:MaSCY7PU_HUhJ7nalq7PYIYoBekOPTqMQjh4IW34T71yTnS-PRKY6A>
    <xmx:MaSCY48mB--425paSDSrUVYdJyhsODkcTZEKDxSUNwJJtMQQ7Mg-DQ>
    <xmx:MaSCYzWBakHwFaRfdE4cSDsJpbf1r4MtkOPvcOAdjlssBDKDhpzcLA>
    <xmx:MaSCY3mX9aq-Dk3jgUL_yAGCb3uxcImGx7fsaw5twbk4eI_S3UfQXw>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 26 Nov 2022 18:41:36 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Palmer Dabbelt <palmer@dabbelt.com>
Cc:     linux-riscv@lists.infradead.org,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] genirq: Simplify cond_unmask_eoi_irq()
Date:   Sat, 26 Nov 2022 17:41:32 -0600
Message-Id: <20221126234134.32660-2-samuel@sholland.org>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20221126234134.32660-1-samuel@sholland.org>
References: <20221126234134.32660-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function calls .irq_eoi in three places, making the logic hard to
follow. Rearrange the function so that .irq_eoi is called only once.

The only time .irq_eoi is not called is when all three if checks fail,
so return early in that case. threads_oneshot can only be nonzero if
IRQS_ONESHOT is set, so the IRQS_ONESHOT check can be omitted there.

The IRQS_ONESHOT condition from the first if statement must then be
copied to the unmask_irq() condition.

Furthermore, if IRQS_ONESHOT is set, mask_irq() must have been called
in the parent function, so the irqd_irq_masked() check is redundant.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 kernel/irq/chip.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 8ac37e8e738a..672bad021a1f 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -658,10 +658,15 @@ EXPORT_SYMBOL_GPL(handle_level_irq);
 
 static void cond_unmask_eoi_irq(struct irq_desc *desc, struct irq_chip *chip)
 {
-	if (!(desc->istate & IRQS_ONESHOT)) {
-		chip->irq_eoi(&desc->irq_data);
+	/*
+	 * Do not send an EOI if the thread will do it later in
+	 * unmask_threaded_irq().
+	 */
+	if ((chip->flags & IRQCHIP_EOI_THREADED) && desc->threads_oneshot)
 		return;
-	}
+
+	chip->irq_eoi(&desc->irq_data);
+
 	/*
 	 * We need to unmask in the following cases:
 	 * - Oneshot irq which did not wake the thread (caused by a
@@ -669,12 +674,8 @@ static void cond_unmask_eoi_irq(struct irq_desc *desc, struct irq_chip *chip)
 	 *   completely).
 	 */
 	if (!irqd_irq_disabled(&desc->irq_data) &&
-	    irqd_irq_masked(&desc->irq_data) && !desc->threads_oneshot) {
-		chip->irq_eoi(&desc->irq_data);
+	    (desc->istate & IRQS_ONESHOT) && !desc->threads_oneshot)
 		unmask_irq(desc);
-	} else if (!(chip->flags & IRQCHIP_EOI_THREADED)) {
-		chip->irq_eoi(&desc->irq_data);
-	}
 }
 
 /**
-- 
2.37.4

