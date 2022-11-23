Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16D8B636CE3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 23:13:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbiKWWMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 17:12:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiKWWLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 17:11:45 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98584102E5F;
        Wed, 23 Nov 2022 14:11:28 -0800 (PST)
Date:   Wed, 23 Nov 2022 22:11:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669241487;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zFOSI/7DgTMY8dVq4AuLC/DiUVYwsTk7m0d+SULh6Eg=;
        b=20uBdBgtCpXr3EkF+BobdX9LZR6oC7moi0SUIFHXDYWPvtpMTTZFPMhgBIgXumunOxGJyc
        fXrmisb15Bs5qHYalQbGag27Uj6MF9BfdULlC2Gh8+89+ebJtxG/f0V3fEhtOjLtScTNMq
        PRlDvakw+nJgmhLaz3m+4KZM4mGUj8RzXDfr9Aj/a5Wmo3wO6SUcxrhTVwbsX/7CsAsbsO
        jYPCQKS0NTkxrRAMUmbFfdAmte7mrhXn7lHkIpsv8bq3P1QeUWWZltWnDBmsEUqnRE6/Zi
        WoLlNrgdxOPU0sM/YJTFWqiLfQmx8t89Lol7i2bDzTaRdd9PPwnA0ewfGqccZg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669241487;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zFOSI/7DgTMY8dVq4AuLC/DiUVYwsTk7m0d+SULh6Eg=;
        b=tNxHGcg4yWarbPzq0KMiB1PXUmF0idMNTgvxjL41s2q4158UMTc+kpNBkJx1IXHShONuDJ
        ePaW2/1XUqxLOlAg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] bus: fsl-mc: Remove linux/msi.h includes
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20221113202428.511591041@linutronix.de>
References: <20221113202428.511591041@linutronix.de>
MIME-Version: 1.0
Message-ID: <166924148582.4906.5593507841514608618.tip-bot2@tip-bot2>
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

Commit-ID:     9d4c8175b8298a361d0ea91f435b1b4ed2ea06e3
Gitweb:        https://git.kernel.org/tip/9d4c8175b8298a361d0ea91f435b1b4ed2ea06e3
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sun, 13 Nov 2022 21:34:00 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 23 Nov 2022 23:07:37 +01:00

bus: fsl-mc: Remove linux/msi.h includes

Neither dprc-driver.c nor fsl-mc-bus.c need anything from linux/msi.h.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20221113202428.511591041@linutronix.de

---
 drivers/bus/fsl-mc/dprc-driver.c | 1 -
 drivers/bus/fsl-mc/fsl-mc-bus.c  | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/bus/fsl-mc/dprc-driver.c b/drivers/bus/fsl-mc/dprc-driver.c
index 5e70f97..4c84be3 100644
--- a/drivers/bus/fsl-mc/dprc-driver.c
+++ b/drivers/bus/fsl-mc/dprc-driver.c
@@ -11,7 +11,6 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/interrupt.h>
-#include <linux/msi.h>
 #include <linux/fsl/mc.h>
 
 #include "fsl-mc-private.h"
diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index 6143dbf..774f307 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -17,7 +17,6 @@
 #include <linux/slab.h>
 #include <linux/limits.h>
 #include <linux/bitops.h>
-#include <linux/msi.h>
 #include <linux/dma-mapping.h>
 #include <linux/acpi.h>
 #include <linux/iommu.h>
