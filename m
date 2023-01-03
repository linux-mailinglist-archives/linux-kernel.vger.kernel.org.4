Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6358265C517
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 18:32:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238564AbjACRcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 12:32:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238534AbjACRbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 12:31:52 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C4611A3C;
        Tue,  3 Jan 2023 09:31:38 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id c65-20020a1c3544000000b003cfffd00fc0so27083942wma.1;
        Tue, 03 Jan 2023 09:31:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lrEcmCtSJ+/1qtNXKPr4kZOp+CyB0SIyAk2dSH3BY8Y=;
        b=Dcvp/yGc7IZz98UBNMbxXxHa148D48TYRMog0iJHDNUQmPvwPC2FOnIN0Ck/tZ9FPT
         op2ftTnJpnyxXiodELsMofBXY/ax7s6BGe3Hr3mdVKd3qzz05IOhxzAmqk1/hqPnr7Jw
         8QcizFVp7GcKkj2CyV3vGY7IAeYZ1xuGvNZbvP0TQHylE83HAeDv0pPLHcOp5ael8P/5
         sxFlFSHoH9sD3LQsDwnBdQJ4CpexObo1dMliVrG51Xjztrm7YwjF6PRbu2sOxi4XRqkO
         irezC/W06LvUMR1l5gVsWbnfrXzmYLk/2NBMaRm5s6yhX9bAvk7AcvnoMHRgGpr1L5V4
         uzMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lrEcmCtSJ+/1qtNXKPr4kZOp+CyB0SIyAk2dSH3BY8Y=;
        b=I9x8+CIru/ga5WwJ72Ogv3QahkFFYC4x00sgy6st9GD8l/JRHt9szx9Q66hrF1eIcR
         z5l4c4kRw1TpK7HRT+M9PdXFK3ayj6ZDtxjNIpXkQfI4qQUyL/pcdjh8wzRV+8eXOKEe
         kT8I7dKvKhc8A1x6jls/m/4gXJmte0vWDZl4X25pSOXlSzm8bDTQA6Jk/bG/JZZgoBPm
         pvZBSGPbN18CDkTWfnH+W2PmT7bD0ibAoyz27qyFNxHY/FzFgEogBWPiG7trW8F2O0Dp
         wjItl8c4jT2QwzPk7tYsqfw/qAyEH80s683Ny6WobG+kV9bNPvjYVGdP8DgJD2vxTVlu
         EDuQ==
X-Gm-Message-State: AFqh2ko3WqYCuNrGPo+gpyokBmq96BXvEMcosSRq9wwNyC7VPvSqgj1h
        aCZU+ugn0JqcQp0MS/1NLMs=
X-Google-Smtp-Source: AMrXdXubGrhheCbq1z91kZPcX6R8teyUh5cDYObCAfHpsfotQgDocgu+e8ewflcr0Q2UbIBQfVm8YQ==
X-Received: by 2002:a05:600c:6016:b0:3d3:3c93:af5e with SMTP id az22-20020a05600c601600b003d33c93af5emr31825649wmb.35.1672767097053;
        Tue, 03 Jan 2023 09:31:37 -0800 (PST)
Received: from localhost.localdomain (host-79-56-217-20.retail.telecomitalia.it. [79.56.217.20])
        by smtp.gmail.com with ESMTPSA id s16-20020a1cf210000000b003c6bd12ac27sm42315707wmc.37.2023.01.03.09.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 09:31:36 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH] scsi: ips: Replace kmap_atomic() with kmap_local_page()
Date:   Tue,  3 Jan 2023 18:31:31 +0100
Message-Id: <20230103173131.21259-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmap_atomic() is deprecated in favor of kmap_local_page(). Therefore,
replace kmap_atomic() with kmap_local_page() in ips_is_passthru(). In
the meantime remove an unnecessary comment soon before local mapping,
align code and remove spaces (the function is short, therefore the
reviewers job won't be over-complicated by these logically unrelated
clean-ups).

kmap_atomic() is implemented like a kmap_local_page() which also disables
page-faults and preemption (the latter only for !PREEMPT_RT kernels).
The code within the mapping/unmapping in ips_is_passthru() is already
in atomic context because of a call to local_irq_save() and
kmap_local_page() can be called in atomic context too (including
interrupts).

Therefore, a mere replacement of the old API with the new one is all it
is required (i.e., there is no need to explicitly add any calls to
pagefault_disable() and/or preempt_disable()).

Suggested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/scsi/ips.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/ips.c b/drivers/scsi/ips.c
index 16419aeec02d..bb206509265e 100644
--- a/drivers/scsi/ips.c
+++ b/drivers/scsi/ips.c
@@ -1499,17 +1499,16 @@ static int ips_is_passthru(struct scsi_cmnd *SC)
                 struct scatterlist *sg = scsi_sglist(SC);
                 char  *buffer;
 
-                /* kmap_atomic() ensures addressability of the user buffer.*/
                 /* local_irq_save() protects the KM_IRQ0 address slot.     */
                 local_irq_save(flags);
-                buffer = kmap_atomic(sg_page(sg)) + sg->offset;
-                if (buffer && buffer[0] == 'C' && buffer[1] == 'O' &&
-                    buffer[2] == 'P' && buffer[3] == 'P') {
-                        kunmap_atomic(buffer - sg->offset);
+		buffer = kmap_local_page(sg_page(sg)) + sg->offset;
+		if (buffer && buffer[0] == 'C' && buffer[1] == 'O' &&
+		    buffer[2] == 'P' && buffer[3] == 'P') {
+			kunmap_local(buffer);
                         local_irq_restore(flags);
                         return 1;
                 }
-                kunmap_atomic(buffer - sg->offset);
+		kunmap_local(buffer);
                 local_irq_restore(flags);
 	}
 	return 0;
-- 
2.39.0

