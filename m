Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2E26217A7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 16:07:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234363AbiKHPG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 10:06:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233326AbiKHPGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 10:06:50 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 720EA1834F;
        Tue,  8 Nov 2022 07:06:49 -0800 (PST)
Date:   Tue, 08 Nov 2022 15:06:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1667920007;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6nn2+6QPtNaSW1pyOCLfhVc5vN3vLiQaT1ZZLVJu6dY=;
        b=odL9q5P5vQozLA/599EkB1XV7eltdBGo12zdaK1ho1phd/luifBUzobFGVFWPFAsC05lP8
        c39WxfmJr2M9z6zHlXaJE0q/cQ4LAditpPvPuNHvZxorGwktfv+zSvUkh4Spry3DE8yuyI
        i2uSirhe5rC5rO59srWWy3HsGtrxsnlaHBKp8A7raC/8bgqGHZfLturZdAnmsb5OT4gChZ
        fFVQEABFUyMhK9zVVG9QlF/z3wDte6jaP5PDUrCb2wWT/HYM6hfd3Sz3+pIH4L3zNIS0kL
        VRRz/Dg6MSD9Xzfg/wwAx2KoFv2JRc6OZImyY5lOMYiwOxfc3QpPTju52T3lVg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1667920007;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6nn2+6QPtNaSW1pyOCLfhVc5vN3vLiQaT1ZZLVJu6dY=;
        b=ai4bjf55eLxTVMxxZnI+YGYzya/laqIeAeUZYfFZjPyTAqAoglMqH5OVr07bbkUWky65eI
        c0Kb6NHmkQfYZDBQ==
From:   "tip-bot2 for Cole Robinson" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] virt/sev-guest: Add a MODULE_ALIAS
Cc:     Cole Robinson <crobinso@redhat.com>, Borislav Petkov <bp@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <ff480c5e688eb0a72a4db0a29c7b1bb54c45bfd4.1667594253.git.crobinso@redhat.com>
References: <ff480c5e688eb0a72a4db0a29c7b1bb54c45bfd4.1667594253.git.crobinso@redhat.com>
MIME-Version: 1.0
Message-ID: <166792000609.4906.10929281276330288769.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     2874529b3513bdc90299c90f40713602da685e35
Gitweb:        https://git.kernel.org/tip/2874529b3513bdc90299c90f40713602da685e35
Author:        Cole Robinson <crobinso@redhat.com>
AuthorDate:    Fri, 04 Nov 2022 16:42:45 -04:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 08 Nov 2022 15:54:34 +01:00

virt/sev-guest: Add a MODULE_ALIAS

Autoload the driver when, for example, SNP init code creates the
corresponding platform device.

  [ bp: Rewrite commit message. ]

Fixes: fce96cf04430 ("virt: Add SEV-SNP guest driver")
Signed-off-by: Cole Robinson <crobinso@redhat.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Tom Lendacky <thomas.lendacky@amd.com>
Link: https://lore.kernel.org/r/ff480c5e688eb0a72a4db0a29c7b1bb54c45bfd4.1667594253.git.crobinso@redhat.com
---
 drivers/virt/coco/sev-guest/sev-guest.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index e9704ae..13911b9 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -742,3 +742,4 @@ MODULE_AUTHOR("Brijesh Singh <brijesh.singh@amd.com>");
 MODULE_LICENSE("GPL");
 MODULE_VERSION("1.0.0");
 MODULE_DESCRIPTION("AMD SEV Guest Driver");
+MODULE_ALIAS("platform:sev-guest");
