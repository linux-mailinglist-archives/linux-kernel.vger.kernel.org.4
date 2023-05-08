Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 955E66FA387
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 11:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233688AbjEHJlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 05:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233552AbjEHJlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 05:41:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C7B81E9B7;
        Mon,  8 May 2023 02:40:59 -0700 (PDT)
Date:   Mon, 08 May 2023 09:40:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683538857;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Cng7TLVSH71g87ujYCYuNZuOfQdfaBqovpjDFRGtTHs=;
        b=4mUgM1AjMiw/TOEj7gU8aXIqqkcdZTqiB5KkARQR1ObaqRoqLlEhbBC7rK8Y3+KOvJyya4
        f5TB8zczWuRayP9TLF8GYU+LrRu6IpyDdweLS10OlAqyN9xhRR+cieObon/eBuO1WXcy86
        CzHrS6aNibl+EDgoba/YYVtzlru3j9/NhjKHGSfLO0HNRRzoM1eiZP0pqwH++ZXY/jJNgr
        mJy5gXKLjBZ/S+F4BrRqqwryDtmiUxcimC6KBY/HzbETer2FYy0AdSgIIKd/wLY0j31yoe
        QHoC4n/M2YJeF0UApzo9UvLhewJy0qE/eNoWuZjg0smkxXh6BmxMoIntAdwGLA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683538857;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Cng7TLVSH71g87ujYCYuNZuOfQdfaBqovpjDFRGtTHs=;
        b=yHsF6siykYeZCixTWS4NwKGUACE+qEgzSjyJp4lHAl4/kh5kJedobImhanPvl+axFgueOw
        pZT2JhVfrFGmIfAw==
From:   "tip-bot2 for Mario Limonciello" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/amd_nb: Add PCI ID for family 19h model 78h
Cc:     Mario Limonciello <mario.limonciello@amd.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Guenter Roeck <linux@roeck-us.net>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230427053338.16653-2-mario.limonciello@amd.com>
References: <20230427053338.16653-2-mario.limonciello@amd.com>
MIME-Version: 1.0
Message-ID: <168353885677.404.42750208560084923.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     23a5b8bb022c1e071ca91b1a9c10f0ad6a0966e9
Gitweb:        https://git.kernel.org/tip/23a5b8bb022c1e071ca91b1a9c10f0ad6a0966e9
Author:        Mario Limonciello <mario.limonciello@amd.com>
AuthorDate:    Thu, 27 Apr 2023 00:33:36 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 08 May 2023 11:25:19 +02:00

x86/amd_nb: Add PCI ID for family 19h model 78h

Commit

  310e782a99c7 ("platform/x86/amd: pmc: Utilize SMN index 0 for driver probe")

switched to using amd_smn_read() which relies upon the misc PCI ID used
by DF function 3 being included in a table.  The ID for model 78h is
missing in that table, so amd_smn_read() doesn't work.

Add the missing ID into amd_nb, restoring s2idle on this system.

  [ bp: Simplify commit message. ]

Fixes: 310e782a99c7 ("platform/x86/amd: pmc: Utilize SMN index 0 for driver probe")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>  # pci_ids.h
Acked-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/r/20230427053338.16653-2-mario.limonciello@amd.com
---
 arch/x86/kernel/amd_nb.c | 2 ++
 include/linux/pci_ids.h  | 1 +
 2 files changed, 3 insertions(+)

diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index 4266b64..7e331e8 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -36,6 +36,7 @@
 #define PCI_DEVICE_ID_AMD_19H_M50H_DF_F4 0x166e
 #define PCI_DEVICE_ID_AMD_19H_M60H_DF_F4 0x14e4
 #define PCI_DEVICE_ID_AMD_19H_M70H_DF_F4 0x14f4
+#define PCI_DEVICE_ID_AMD_19H_M78H_DF_F4 0x12fc
 
 /* Protect the PCI config register pairs used for SMN. */
 static DEFINE_MUTEX(smn_mutex);
@@ -79,6 +80,7 @@ static const struct pci_device_id amd_nb_misc_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M50H_DF_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M60H_DF_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M70H_DF_F3) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M78H_DF_F3) },
 	{}
 };
 
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 45c3d62..95f33da 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -567,6 +567,7 @@
 #define PCI_DEVICE_ID_AMD_19H_M50H_DF_F3 0x166d
 #define PCI_DEVICE_ID_AMD_19H_M60H_DF_F3 0x14e3
 #define PCI_DEVICE_ID_AMD_19H_M70H_DF_F3 0x14f3
+#define PCI_DEVICE_ID_AMD_19H_M78H_DF_F3 0x12fb
 #define PCI_DEVICE_ID_AMD_CNB17H_F3	0x1703
 #define PCI_DEVICE_ID_AMD_LANCE		0x2000
 #define PCI_DEVICE_ID_AMD_LANCE_HOME	0x2001
