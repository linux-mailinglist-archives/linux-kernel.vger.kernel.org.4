Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50D6E64305D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 19:29:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233613AbiLES31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 13:29:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232700AbiLESZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 13:25:25 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0550820BE9;
        Mon,  5 Dec 2022 10:25:24 -0800 (PST)
Date:   Mon, 05 Dec 2022 18:25:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670264722;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o2YGqGB0X++gFIlyftW837YV3I04HXl6/I0v3Q1flzU=;
        b=m8gYEHc+SEEZe3PUV/9s/vh/1ZSVzLRtFFe/vTnp02CO7nFS1cQ8oqsWONPL9MktUx8tuM
        owlcQ9U7jVCiSkNkds11UU4epdGbnkBacKP84GvREcyUmuZe7aF4X2y5aJr3KGqrks4sE6
        pYCSvH96j2TYQrBY7WbrQp7UCphs8QlRomn5m5VtpMLpDwWa4y7P6ldvqCBxHbk0t8dmiW
        9gWJGvQ4hxSdQJ314VFMfVGjR9z8SiiJXpLANeZCcMOcvlTYMpe/Rz6ZQ4MYTE3kFINbrB
        zn8CvfFaVKMYu37jSWufDTucobbo8XuzdGzAJRjaZOqNSnr0zlKlMf313ADOCA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670264722;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o2YGqGB0X++gFIlyftW837YV3I04HXl6/I0v3Q1flzU=;
        b=Tb09lcFxyhB+tzbrZ+AYErnnsKgcVQOhHNlQuCyrf+vgcJTkbat3LFe8Iiax2X79fv8OQb
        6Hh3+5mmx5NAuVAw==
From:   "tip-bot2 for Bagas Sanjaya" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] PCI/MSI: Use bullet lists in kernel-doc comments of api.c
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20221203100511.222136-1-bagasdotme@gmail.com>
References: <20221203100511.222136-1-bagasdotme@gmail.com>
MIME-Version: 1.0
Message-ID: <167026472230.4906.11758765575480144436.tip-bot2@tip-bot2>
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

Commit-ID:     6842694c5088925d216529d4a2358ab5ee8bb862
Gitweb:        https://git.kernel.org/tip/6842694c5088925d216529d4a2358ab5ee8bb862
Author:        Bagas Sanjaya <bagasdotme@gmail.com>
AuthorDate:    Sat, 03 Dec 2022 17:05:11 +07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 05 Dec 2022 18:57:46 +01:00

PCI/MSI: Use bullet lists in kernel-doc comments of api.c

Use bullet-list RST syntax for kernel-doc parameters' flags and interrupt
mode descriptions. Otherwise Sphinx produces "Unexpected identation" errors
and warnings.

Fixes: 5c0997dc33ac24 ("PCI/MSI: Move pci_alloc_irq_vectors() to api.c")
Fixes: 017239c8db2093 ("PCI/MSI: Move pci_irq_vector() to api.c")
Fixes: be37b8428b7b77 ("PCI/MSI: Move pci_irq_get_affinity() to api.c")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Suggested-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Ahmed S. Darwish <darwi@linutronix.de>
Link: https://lore.kernel.org/r/20221203100511.222136-1-bagasdotme@gmail.com
---
 drivers/pci/msi/api.c | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/msi/api.c b/drivers/pci/msi/api.c
index 6c3ad48..2d46a0c 100644
--- a/drivers/pci/msi/api.c
+++ b/drivers/pci/msi/api.c
@@ -142,12 +142,15 @@ EXPORT_SYMBOL(pci_disable_msix);
  * @min_vecs: minimum required number of vectors (must be >= 1)
  * @max_vecs: maximum desired number of vectors
  * @flags:    One or more of:
- *            %PCI_IRQ_MSIX      Allow trying MSI-X vector allocations
- *            %PCI_IRQ_MSI       Allow trying MSI vector allocations
- *            %PCI_IRQ_LEGACY    Allow trying legacy INTx interrupts, if
- *                               and only if @min_vecs == 1
- *            %PCI_IRQ_AFFINITY  Auto-manage IRQs affinity by spreading
- *                               the vectors around available CPUs
+ *
+ *            * %PCI_IRQ_MSIX      Allow trying MSI-X vector allocations
+ *            * %PCI_IRQ_MSI       Allow trying MSI vector allocations
+ *
+ *            * %PCI_IRQ_LEGACY    Allow trying legacy INTx interrupts, if
+ *              and only if @min_vecs == 1
+ *
+ *            * %PCI_IRQ_AFFINITY  Auto-manage IRQs affinity by spreading
+ *              the vectors around available CPUs
  *
  * Allocate up to @max_vecs interrupt vectors on device. MSI-X irq
  * vector allocation has a higher precedence over plain MSI, which has a
@@ -232,10 +235,11 @@ EXPORT_SYMBOL(pci_alloc_irq_vectors_affinity);
  * pci_irq_vector() - Get Linux IRQ number of a device interrupt vector
  * @dev: the PCI device to operate on
  * @nr:  device-relative interrupt vector index (0-based); has different
- *       meanings, depending on interrupt mode
- *         MSI-X        the index in the MSI-X vector table
- *         MSI          the index of the enabled MSI vectors
- *         INTx         must be 0
+ *       meanings, depending on interrupt mode:
+ *
+ *         * MSI-X     the index in the MSI-X vector table
+ *         * MSI       the index of the enabled MSI vectors
+ *         * INTx      must be 0
  *
  * Return: the Linux IRQ number, or -EINVAL if @nr is out of range
  */
@@ -255,10 +259,11 @@ EXPORT_SYMBOL(pci_irq_vector);
  * pci_irq_get_affinity() - Get a device interrupt vector affinity
  * @dev: the PCI device to operate on
  * @nr:  device-relative interrupt vector index (0-based); has different
- *       meanings, depending on interrupt mode
- *         MSI-X        the index in the MSI-X vector table
- *         MSI          the index of the enabled MSI vectors
- *         INTx         must be 0
+ *       meanings, depending on interrupt mode:
+ *
+ *         * MSI-X     the index in the MSI-X vector table
+ *         * MSI       the index of the enabled MSI vectors
+ *         * INTx      must be 0
  *
  * Return: MSI/MSI-X vector affinity, NULL if @nr is out of range or if
  * the MSI(-X) vector was allocated without explicit affinity
