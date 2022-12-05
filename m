Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F411D64305F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 19:29:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233569AbiLES3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 13:29:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232664AbiLESZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 13:25:24 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C689205E8;
        Mon,  5 Dec 2022 10:25:23 -0800 (PST)
Date:   Mon, 05 Dec 2022 18:25:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670264722;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yMr6lJj85dFwF+XsRzVTAMXhdatSuqiMSV0LfAlYqO8=;
        b=J0u/WusEN7Y5abj6+x/RiYBGgDo9kWaYCGH8ccca4718LOsQ489/HcMBHugY/msoNysBI/
        QrpQODbf3Zngn4ENH4yJW7oJFBUR+YXdMVdNa8UqJMesmmMDdooVTYkIyz6tCQT0CDpZU4
        L+7G2p3DuLTOnlCYbMAzmBEW91J0XNnNSMUXTl+EEYMIRBqCqQjSftB61oRzTz5Q/spZt+
        OgTKUGq5knidsufL7BWnQdHO3syLcg3EvUb6uRNpZ0FHdN0/P7HArYtK7MkG0/O19Dfg4f
        MCZO6iDXGRC9tG3x8/OoIi+dIOiCGkoAIxxEtQN7CQ7Z3sMiSpcmcvqW7ZsniQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670264722;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yMr6lJj85dFwF+XsRzVTAMXhdatSuqiMSV0LfAlYqO8=;
        b=Zn5h/DY+f3FTn2PGt80upuuTsfW7ebFv3YB2kL46pMCLBQj+ce/ojRk4wxm/HKFccBX52i
        MXXDn02E7r02ZOAA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/msi: Create msi_api.h
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Marc Zyngier <maz@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221124230313.632679220@linutronix.de>
References: <20221124230313.632679220@linutronix.de>
MIME-Version: 1.0
Message-ID: <167026472167.4906.6600096750077977681.tip-bot2@tip-bot2>
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

Commit-ID:     6b6941f6653ec8017e3822b55bb9eae245f0ed99
Gitweb:        https://git.kernel.org/tip/6b6941f6653ec8017e3822b55bb9eae245f0ed99
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 25 Nov 2022 00:24:14 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 05 Dec 2022 19:20:58 +01:00

genirq/msi: Create msi_api.h

Create a API header for MSI specific functions which are relevant to device
drivers.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Acked-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20221124230313.632679220@linutronix.de

---
 include/linux/msi.h     |  6 ++++--
 include/linux/msi_api.h | 15 +++++++++++++++
 2 files changed, 19 insertions(+), 2 deletions(-)
 create mode 100644 include/linux/msi_api.h

diff --git a/include/linux/msi.h b/include/linux/msi.h
index 2d87e00..9f72494 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -13,11 +13,14 @@
  *
  * Regular device drivers have no business with any of these functions and
  * especially storing MSI descriptor pointers in random code is considered
- * abuse. The only function which is relevant for drivers is msi_get_virq().
+ * abuse.
+ *
+ * Device driver relevant functions are available in <linux/msi_api.h>
  */
 
 #include <linux/irqdomain_defs.h>
 #include <linux/cpumask.h>
+#include <linux/msi_api.h>
 #include <linux/xarray.h>
 #include <linux/mutex.h>
 #include <linux/list.h>
@@ -188,7 +191,6 @@ struct msi_device_data {
 
 int msi_setup_device_data(struct device *dev);
 
-unsigned int msi_get_virq(struct device *dev, unsigned int index);
 void msi_lock_descs(struct device *dev);
 void msi_unlock_descs(struct device *dev);
 
diff --git a/include/linux/msi_api.h b/include/linux/msi_api.h
new file mode 100644
index 0000000..57d27cf
--- /dev/null
+++ b/include/linux/msi_api.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef LINUX_MSI_API_H
+#define LINUX_MSI_API_H
+
+/*
+ * APIs which are relevant for device driver code for allocating and
+ * freeing MSI interrupts and querying the associations between
+ * hardware/software MSI indices and the Linux interrupt number.
+ */
+
+struct device;
+
+unsigned int msi_get_virq(struct device *dev, unsigned int index);
+
+#endif
