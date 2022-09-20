Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE37F5BE47D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 13:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbiITL3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 07:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbiITL3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 07:29:44 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8036EE00;
        Tue, 20 Sep 2022 04:29:41 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id z13so3303635edb.13;
        Tue, 20 Sep 2022 04:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=LvqwcG3mpG/9d3nLSI/pURts+ISMWzkQRnI/rGgmAcA=;
        b=NmxcksdXtHeR+kMKTUsnObq0DkMDvOGsEG5KyK/pelkwmH4/JtJkqI56v5hzRDFv/3
         9w4QNGCJCAhOdr56Xh61vkUlphdeoU4QyGGsBdKSj+8W8+2gYf7TpuUNNH/AEM0i+nIw
         OYWjqslWWogDeTxWBPVIi+p/umrUZIKREPpSoY6GRRCB7HtYZ6Ae9exdUkceir93rTJz
         3odpppDGcLQf7HovWvrbk//8iIWEdDiuxHiAavXldYtnFzwQLawaQZDaQxsEumZJHxJa
         gyepPnQcdzyTyMIQ5iYGn/ZQWICn+R3l8+Q7IIBymZ1ze/F/pva4rh8OkvystBPMGRiQ
         C9GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=LvqwcG3mpG/9d3nLSI/pURts+ISMWzkQRnI/rGgmAcA=;
        b=hDFGfEnYs+MLD2TT3L+gEzzDUFL3sYwMRnHJuvOPkTyrqqJZKJYXdRkk3XTt4THAbc
         SKGE+hEwDwA5GMjAiGcpV+HGHMlE2FXPsrmgrGQSceH+ysnxi69qWmN4NOPj2gCC4GPX
         WSGiYoAngT4hgF5RAUm/s+xhFmgsRZHC1clLXEadFf71M9n7RtxZPcZ8VFJcrbBlT4ra
         O1oNSUKkPVbtPwrd+gyAuKFAFL9RR9mQVyaxTOPuu3EXQhH/WjF7LSXQdP8LzR74aflp
         ooWLxaOsjrRgewNdm4C0CpbM/GVQ7T3POpnH2JInalSXpEkYjWozVi0BJzcPMtWLrtJN
         Dn8w==
X-Gm-Message-State: ACrzQf2hroypZ+BUFS8MYFmWSdc5qGvOsKyE44iCRzXA4JIyJo63TaKQ
        ocyOD4V4dqrArNg6wm91msI=
X-Google-Smtp-Source: AMsMyM6VSpQXwSkPjQUEK3zTaq58gx1lEe6sECsvUcB1JUDh2j5/FU1sjNhyTr4KNq17e7vCyDD75g==
X-Received: by 2002:aa7:dd0a:0:b0:44e:a27b:fec with SMTP id i10-20020aa7dd0a000000b0044ea27b0fecmr19000689edv.168.1663673380316;
        Tue, 20 Sep 2022 04:29:40 -0700 (PDT)
Received: from felia.fritz.box (200116b826a61100c127d83ad13ce8e7.dip.versatel-1u1.de. [2001:16b8:26a6:1100:c127:d83a:d13c:e8e7])
        by smtp.gmail.com with ESMTPSA id p1-20020a17090653c100b0077f20a722dfsm678791ejo.165.2022.09.20.04.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 04:29:39 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] scsi: wd33c93: remove dead code related to the long-gone config WD33C93_PIO
Date:   Tue, 20 Sep 2022 13:29:21 +0200
Message-Id: <20220920112921.25275-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The historical commit 5e018f7e60c9 ("Remove PC9800 support") from 2004 in
linux's history.git removed the config WD33C93_PIO to tweak the scsi
wd33c93 driver for the PC9800.

Some dead code in drivers/scsi/wd33c93.[ch] under an ifdef WD33C93_PIO
continued to remain in the repository until now.

Remove this dead code.

This issue was discovered with ./scripts/checkkconfigsymbols.py.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 drivers/scsi/wd33c93.c | 60 ------------------------------------------
 drivers/scsi/wd33c93.h |  5 ----
 2 files changed, 65 deletions(-)

diff --git a/drivers/scsi/wd33c93.c b/drivers/scsi/wd33c93.c
index 3fe562047d85..e4fafc77bd20 100644
--- a/drivers/scsi/wd33c93.c
+++ b/drivers/scsi/wd33c93.c
@@ -162,65 +162,6 @@ module_param(setup_strings, charp, 0);
 
 static void wd33c93_execute(struct Scsi_Host *instance);
 
-#ifdef CONFIG_WD33C93_PIO
-static inline uchar
-read_wd33c93(const wd33c93_regs regs, uchar reg_num)
-{
-	uchar data;
-
-	outb(reg_num, regs.SASR);
-	data = inb(regs.SCMD);
-	return data;
-}
-
-static inline unsigned long
-read_wd33c93_count(const wd33c93_regs regs)
-{
-	unsigned long value;
-
-	outb(WD_TRANSFER_COUNT_MSB, regs.SASR);
-	value = inb(regs.SCMD) << 16;
-	value |= inb(regs.SCMD) << 8;
-	value |= inb(regs.SCMD);
-	return value;
-}
-
-static inline uchar
-read_aux_stat(const wd33c93_regs regs)
-{
-	return inb(regs.SASR);
-}
-
-static inline void
-write_wd33c93(const wd33c93_regs regs, uchar reg_num, uchar value)
-{
-      outb(reg_num, regs.SASR);
-      outb(value, regs.SCMD);
-}
-
-static inline void
-write_wd33c93_count(const wd33c93_regs regs, unsigned long value)
-{
-	outb(WD_TRANSFER_COUNT_MSB, regs.SASR);
-	outb((value >> 16) & 0xff, regs.SCMD);
-	outb((value >> 8) & 0xff, regs.SCMD);
-	outb( value & 0xff, regs.SCMD);
-}
-
-#define write_wd33c93_cmd(regs, cmd) \
-	write_wd33c93((regs), WD_COMMAND, (cmd))
-
-static inline void
-write_wd33c93_cdb(const wd33c93_regs regs, uint len, uchar cmnd[])
-{
-	int i;
-
-	outb(WD_CDB_1, regs.SASR);
-	for (i=0; i<len; i++)
-		outb(cmnd[i], regs.SCMD);
-}
-
-#else /* CONFIG_WD33C93_PIO */
 static inline uchar
 read_wd33c93(const wd33c93_regs regs, uchar reg_num)
 {
@@ -287,7 +228,6 @@ write_wd33c93_cdb(const wd33c93_regs regs, uint len, uchar cmnd[])
 	for (i = 0; i < len; i++)
 		*regs.SCMD = cmnd[i];
 }
-#endif /* CONFIG_WD33C93_PIO */
 
 static inline uchar
 read_1_byte(const wd33c93_regs regs)
diff --git a/drivers/scsi/wd33c93.h b/drivers/scsi/wd33c93.h
index b3800baccd2c..e5e4254b1477 100644
--- a/drivers/scsi/wd33c93.h
+++ b/drivers/scsi/wd33c93.h
@@ -180,13 +180,8 @@
 
    /* This is what the 3393 chip looks like to us */
 typedef struct {
-#ifdef CONFIG_WD33C93_PIO
-   unsigned int   SASR;
-   unsigned int   SCMD;
-#else
    volatile unsigned char  *SASR;
    volatile unsigned char  *SCMD;
-#endif
 } wd33c93_regs;
 
 
-- 
2.17.1

