Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C675636CE4
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 23:13:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbiKWWMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 17:12:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiKWWLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 17:11:45 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9AECCEFFB;
        Wed, 23 Nov 2022 14:11:26 -0800 (PST)
Date:   Wed, 23 Nov 2022 22:11:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669241484;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S9J/qL9NKxCY0GP1pXJl/kQUGavuBKONJhbiUUiHKkg=;
        b=UZNsVRTUMiamfitdcH8iNR8PqujKzwpfGqIjREcPiE8J0mQyXpOhryudLaE1z80Xq+TVGK
        a5WRgHWdg9lFnL7VsodZ34dlVLN7Cyadcfg1Ju6o71S0mv/hAhodt9vjmbgNFpH3cZ8LcG
        M0pZwL89xmjH8g7NbndOW30ER/wUYGNCmwVTvks//VMTQzZC2WxmYYQ0aArJ4+lK099XVB
        B8j8/+2bWaOECpHzUBkSyt9HEy5PB1UDwyQxWCiF2TtRWYyiia2h4lhM9qVS3Spzg55OEV
        BR1D3qXvexjI3dfKZ+OmQ2m8x7sA6QQ5QvSBoMvrIvD1zVf9jiFM084MqloP1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669241484;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S9J/qL9NKxCY0GP1pXJl/kQUGavuBKONJhbiUUiHKkg=;
        b=RcQNBZbUCxrpGUf8iIdnWSOelg05Cj+zCS6KPoEMZdeEf24jwy5jTSW/mQmVq9QkYsrNhL
        yKLqdxXHu7w43wCw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] vfio/fsl-mc: Remove linux/msi.h include
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Alex Williamson <alex.williamson@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20221113202428.826924043@linutronix.de>
References: <20221113202428.826924043@linutronix.de>
MIME-Version: 1.0
Message-ID: <166924148328.4906.7442911510751408773.tip-bot2@tip-bot2>
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

Commit-ID:     616eb7bf325fbf25df2b5046536b50fe896d4ab6
Gitweb:        https://git.kernel.org/tip/616eb7bf325fbf25df2b5046536b50fe896d4ab6
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sun, 13 Nov 2022 21:34:08 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 23 Nov 2022 23:07:38 +01:00

vfio/fsl-mc: Remove linux/msi.h include

Nothing in this file needs anything from linux/msi.h

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Acked-by: Alex Williamson <alex.williamson@redhat.com>
Link: https://lore.kernel.org/r/20221113202428.826924043@linutronix.de

---
 drivers/vfio/fsl-mc/vfio_fsl_mc_intr.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/vfio/fsl-mc/vfio_fsl_mc_intr.c b/drivers/vfio/fsl-mc/vfio_fsl_mc_intr.c
index 7b428ea..64d01f3 100644
--- a/drivers/vfio/fsl-mc/vfio_fsl_mc_intr.c
+++ b/drivers/vfio/fsl-mc/vfio_fsl_mc_intr.c
@@ -8,7 +8,6 @@
 #include <linux/slab.h>
 #include <linux/types.h>
 #include <linux/eventfd.h>
-#include <linux/msi.h>
 
 #include "linux/fsl/mc.h"
 #include "vfio_fsl_mc_private.h"
