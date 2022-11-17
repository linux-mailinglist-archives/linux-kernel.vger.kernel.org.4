Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C977062DF13
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 16:08:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240228AbiKQPIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 10:08:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234795AbiKQPIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 10:08:02 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50043769D3;
        Thu, 17 Nov 2022 07:08:02 -0800 (PST)
Date:   Thu, 17 Nov 2022 15:07:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668697681;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UaWecbbSjg3Tm0wvLI1YflnP0pLAt0Tas3tsFTOhOOc=;
        b=kWqSDsXH5Kfu0wMY0zghrvt5aV2hU+WTVN/WrvDZcJF27Scenmv6ywA6Xe3niIUu1K6VXf
        X1u64rrgLENYYL1WnJgPk+QoMRc0DvX+JOyRrtsOmKzhSM7gRG2TGM9CyizS/YqwqJb6dQ
        6Y9+y1+06WvUczkz5v8WLq7TVRJrH5EK9tqXxbZqnaH45iFD1LliBdkyJIW2JTp00TuV5u
        BZug7qnDzgnn58AoW37gvip1F3osCMGRARs8ApEbdGaMI8pJ8ABRF8lm5AoQ7qS/A9Z8lh
        bC974/xuTaKJH9FQH+nxCT9/+V9ZrO8FwZ045RD1AIlKbne/+J0mMgpNNPbseg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668697681;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UaWecbbSjg3Tm0wvLI1YflnP0pLAt0Tas3tsFTOhOOc=;
        b=5IshFqBHNQG7UslwOOZOi6BWujQ3o7yZ8JtBSFyxbzKmBF0xfDNLTrIKnVmgs0dDFjnIgw
        BoYNaK2Deg0T1nCw==
From:   "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] Documentation: PCI: Add reference to PCI/MSI device
 driver APIs
Cc:     "Ahmed S. Darwish" <darwi@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Bjorn Helgaas <bhelgaas@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20221111122015.397739421@linutronix.de>
References: <20221111122015.397739421@linutronix.de>
MIME-Version: 1.0
Message-ID: <166869767973.4906.15641891890847821145.tip-bot2@tip-bot2>
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

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     88614075a952b1af50f5fb10c958e311f6b4f68a
Gitweb:        https://git.kernel.org/tip/88614075a952b1af50f5fb10c958e311f6b=
4f68a
Author:        Ahmed S. Darwish <darwi@linutronix.de>
AuthorDate:    Fri, 11 Nov 2022 14:55:04 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 17 Nov 2022 15:15:21 +01:00

Documentation: PCI: Add reference to PCI/MSI device driver APIs

All exported device-driver MSI APIs are now grouped in one place at
drivers/pci/msi/api.c with comprehensive kernel-docs added.

Reference these kernel-docs in the official PCI/MSI howto.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Link: https://lore.kernel.org/r/20221111122015.397739421@linutronix.de


---
 Documentation/PCI/msi-howto.rst | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/PCI/msi-howto.rst b/Documentation/PCI/msi-howto.rst
index aa2046a..8ae461e 100644
--- a/Documentation/PCI/msi-howto.rst
+++ b/Documentation/PCI/msi-howto.rst
@@ -285,3 +285,13 @@ to bridges between the PCI root and the device, MSIs are=
 disabled.
 It is also worth checking the device driver to see whether it supports MSIs.
 For example, it may contain calls to pci_alloc_irq_vectors() with the
 PCI_IRQ_MSI or PCI_IRQ_MSIX flags.
+
+
+List of device drivers MSI(-X) APIs
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+The PCI/MSI subystem has a dedicated C file for its exported device driver
+APIs =E2=80=94 `drivers/pci/msi/api.c`. The following functions are exported:
+
+.. kernel-doc:: drivers/pci/msi/api.c
+   :export:
