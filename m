Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E10669445E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 12:25:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbjBMLZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 06:25:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbjBMLZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 06:25:00 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A21D814E82;
        Mon, 13 Feb 2023 03:24:59 -0800 (PST)
Date:   Mon, 13 Feb 2023 11:24:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676287498;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KRfwpv/HgZDdd4k+GFcTibHg4hbUMy4dGlmO3TPOkNc=;
        b=hlYV+QdyR5oiMXms6YtHG9QeBgXLm2ypHhtpejJ57WKb0mzKCS1x5e6SjDneTTCPsukm5u
        OW37suUvntxWvDMk7rwrS+BfjiHefdBfjgrkbr30grLaJx1COSFcFhqBeydpCBXKMUfWnY
        71gx+O2faabfpFGmBY0bTq4vpAR3HNv7fRt2HSGj5A0q8ufkj5YEGyTMTfM8VYzzgUThqb
        9wvEVSeDgKKa3HZa+GFhS/21VCOj1BXGtOohIaOPCTgQlMkNw3fVwZj4hSwFeDbBNlwJXS
        i6USvznKK4ZapSrtU14COt5gDFa5FRjo/CmSYU5iCWEfpuEFAT4fpEC380HUaw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676287498;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KRfwpv/HgZDdd4k+GFcTibHg4hbUMy4dGlmO3TPOkNc=;
        b=D7Xo5nvRfihZliq/Pe50933/ND4c2MZzssos0eM02Yh5TM6HB+IqLtUxxarWeokaxLorrG
        dHA4lUECqilbgSBw==
From:   "tip-bot2 for Reinette Chatre" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] PCI/MSI: Provide missing stubs for CONFIG_PCI_MSI=n
Cc:     kernel test robot <lkp@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: =?utf-8?q?=3C158e40e1cfcfc58ae30ecb2bbfaf86e5bba7a1ef=2E16759?=
 =?utf-8?q?78686=2Egit=2Ereinette=2Echatre=40intel=2Ecom=3E?=
References: =?utf-8?q?=3C158e40e1cfcfc58ae30ecb2bbfaf86e5bba7a1ef=2E167597?=
 =?utf-8?q?8686=2Egit=2Ereinette=2Echatre=40intel=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <167628749774.4906.17069524905880641563.tip-bot2@tip-bot2>
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

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     2b129f0b24ab578b02901b4a1744b7f97399faa0
Gitweb:        https://git.kernel.org/tip/2b129f0b24ab578b02901b4a1744b7f97399faa0
Author:        Reinette Chatre <reinette.chatre@intel.com>
AuthorDate:    Thu, 09 Feb 2023 13:49:00 -08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 13 Feb 2023 12:17:20 +01:00

PCI/MSI: Provide missing stubs for CONFIG_PCI_MSI=n

pci_msix_alloc_irq_at() and pci_msix_free_irq() are not declared when
CONFIG_PCI_MSI is disabled.

Users of these two calls do not yet exist but when users do appear (shown
below is an attempt to use the new API in vfio-pci) the following errors
will be encountered when compiling with CONFIG_PCI_MSI disabled:

drivers/vfio/pci/vfio_pci_intrs.c:461:4: error: implicit declaration of\
        function 'pci_msix_free_irq' is invalid in C99\
        [-Werror,-Wimplicit-function-declaration]
                           pci_msix_free_irq(pdev, msix_map);
                           ^
drivers/vfio/pci/vfio_pci_intrs.c:511:15: error: implicit declaration of\
        function 'pci_msix_alloc_irq_at' is invalid in C99\
        [-Werror,-Wimplicit-function-declaration]
                   msix_map = pci_msix_alloc_irq_at(pdev, vector, NULL);

Provide definitions for pci_msix_alloc_irq_at() and pci_msix_free_irq() in
preparation for users that need to compile when CONFIG_PCI_MSI is
disabled.

Reported-by: kernel test robot <lkp@intel.com>
Fixes: 34026364df8e ("PCI/MSI: Provide post-enable dynamic allocation interfaces for MSI-X")
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/158e40e1cfcfc58ae30ecb2bbfaf86e5bba7a1ef.1675978686.git.reinette.chatre@intel.com
---
 include/linux/pci.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index adffd65..254c8a4 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1621,6 +1621,18 @@ pci_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
 					      flags, NULL);
 }
 
+static inline struct msi_map pci_msix_alloc_irq_at(struct pci_dev *dev, unsigned int index,
+						   const struct irq_affinity_desc *affdesc)
+{
+	struct msi_map map = { .index = -ENOSYS, };
+
+	return map;
+}
+
+static inline void pci_msix_free_irq(struct pci_dev *pdev, struct msi_map map)
+{
+}
+
 static inline void pci_free_irq_vectors(struct pci_dev *dev)
 {
 }
