Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81050627286
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 21:34:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235443AbiKMUeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 15:34:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235450AbiKMUeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 15:34:00 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B001262E;
        Sun, 13 Nov 2022 12:33:59 -0800 (PST)
Message-ID: <20221113202428.374088146@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668371638;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=GT/G9vK93mYpvzZdTpl6h6K4LTwENiZbMbRH6Qg8/+A=;
        b=i5ON7/T9CK+x6BaaPX0ib3fI7p5Xyl0PdQzaUz3wqpgNCMpJygjT8EOCpSIte1rmDZdT98
        Dxg9w2ACknjtLt5VOOg6V4UWlSGgfVW1m9t8hRkgT40X5Lzn0ZumV6XtvdYxH91U/aN4f7
        4bnsIosfAm3Jki1/JUbYXFE8w5/y0kR6zWoDp17xh7JMT8ObRvKRkW6rGYnt2tIEWYh4U8
        5aRYDDRfuuuzGkJ4g31NF2wsqzDqonuOkv1QLV0QUF1Et2rsPgJlVpkS62vm9uIFPYj+qV
        G1LCazcY8WhFUzMH6Bzy20Xnt61TRTOdtKUj1hyDHTDpdRvQ3UwSWsFyVA24CQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668371638;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=GT/G9vK93mYpvzZdTpl6h6K4LTwENiZbMbRH6Qg8/+A=;
        b=91QWuMdBPKzbVai5jiM9l05feXw5wsOIcvebbKgZMv/lAnIPg8ReG3wJCUBWz+0QFe6vAq
        tf2jsE9ExI6bKUDA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org
Subject: [patch 02/10] ata: ahci: Remove linux/msi.h include
References: <20221113201935.776707081@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 13 Nov 2022 21:33:57 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nothing in this file needs anything from linux/msi.h

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: linux-ide@vger.kernel.org
---
 drivers/ata/ahci.c |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -26,7 +26,6 @@
 #include <linux/device.h>
 #include <linux/dmi.h>
 #include <linux/gfp.h>
-#include <linux/msi.h>
 #include <scsi/scsi_host.h>
 #include <scsi/scsi_cmnd.h>
 #include <linux/libata.h>

