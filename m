Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C928B62DF2C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 16:10:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240563AbiKQPKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 10:10:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240252AbiKQPJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 10:09:23 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E097819F;
        Thu, 17 Nov 2022 07:08:18 -0800 (PST)
Date:   Thu, 17 Nov 2022 15:08:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668697696;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3wC+ca9xmoMw4v4EixRmIbpEv7TkVbKrWzaJWHLc1Ek=;
        b=gggEUJRjkD20M4bM5iyqp5r7HTmk+3N26rEPZBnEZm8NtlSBHGogfy7A/7SZ86BlWNF/p/
        MPV3Z2XB4W7ofElMMzj2mwv7k9UX4fg2nH8PnmVo78SnupZaYa3YwFQ7wLnOTpDylnP5k3
        q5i3b4byEY08Vu2els7wyxxApSFwHJzPB+aT0uVhhOQCUx4o4h1a0pYlaZAt2vNx5YCpir
        nXVYZP32PrNmDduP0SuBBznOp02j4839Y9sPZIsfXatxFkTdQ3BVdZ3QZAKvr45FzavuAG
        giccESG3Rn5Rz5edl8Yz31RSxKhawzQMakfgi7DsiIvms7kZH8N/DbGEcEZYlQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668697696;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3wC+ca9xmoMw4v4EixRmIbpEv7TkVbKrWzaJWHLc1Ek=;
        b=OQM6Pc2U0io17bNE55F/RpZK91J4NNTta9uOK5n1lxo5oZUzHBatvmFoj4ESCFAghsR/0G
        Mi8T50mHxzQPVeAA==
From:   "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] PCI/MSI: Get rid of externs in msi.h
Cc:     "Ahmed S. Darwish" <darwi@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Bjorn Helgaas <bhelgaas@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20221111122014.582175082@linutronix.de>
References: <20221111122014.582175082@linutronix.de>
MIME-Version: 1.0
Message-ID: <166869769537.4906.7495651253482641225.tip-bot2@tip-bot2>
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

Commit-ID:     db537dd3bf83169d78e5617b75158f64deabcb0b
Gitweb:        https://git.kernel.org/tip/db537dd3bf83169d78e5617b75158f64deabcb0b
Author:        Ahmed S. Darwish <darwi@linutronix.de>
AuthorDate:    Fri, 11 Nov 2022 14:54:42 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 17 Nov 2022 15:15:20 +01:00

PCI/MSI: Get rid of externs in msi.h

Follow the style of <linux/pci.h>

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Link: https://lore.kernel.org/r/20221111122014.582175082@linutronix.de

---
 drivers/pci/msi/msi.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/msi/msi.h b/drivers/pci/msi/msi.h
index dbeff06..fc92603 100644
--- a/drivers/pci/msi/msi.h
+++ b/drivers/pci/msi/msi.h
@@ -5,12 +5,12 @@
 
 #define msix_table_size(flags)	((flags & PCI_MSIX_FLAGS_QSIZE) + 1)
 
-extern int pci_msi_setup_msi_irqs(struct pci_dev *dev, int nvec, int type);
-extern void pci_msi_teardown_msi_irqs(struct pci_dev *dev);
+int pci_msi_setup_msi_irqs(struct pci_dev *dev, int nvec, int type);
+void pci_msi_teardown_msi_irqs(struct pci_dev *dev);
 
 #ifdef CONFIG_PCI_MSI_ARCH_FALLBACKS
-extern int pci_msi_legacy_setup_msi_irqs(struct pci_dev *dev, int nvec, int type);
-extern void pci_msi_legacy_teardown_msi_irqs(struct pci_dev *dev);
+int pci_msi_legacy_setup_msi_irqs(struct pci_dev *dev, int nvec, int type);
+void pci_msi_legacy_teardown_msi_irqs(struct pci_dev *dev);
 #else
 static inline int pci_msi_legacy_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
 {
