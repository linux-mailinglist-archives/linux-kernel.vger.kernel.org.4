Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3845B62C0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 23:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbiILV31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 17:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiILV3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 17:29:25 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B2727FD2;
        Mon, 12 Sep 2022 14:29:24 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id i203-20020a1c3bd4000000b003b3df9a5ecbso7229113wma.1;
        Mon, 12 Sep 2022 14:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date;
        bh=Zx7jjBB5IBx0W7EnQ+S3p3BxnBrqMDtfQs/QT9RTn9w=;
        b=R8y3gaH+ySTgnCTx0+q7LRdt6jIO4EYnwFI/Kvn/Zc+TQJhDpJfsAW4AGjb8zBcvjI
         Nvb1Fa0ohte+AAQ4bmGmSaftcwu/dr5qoQOx4kIw5eLqhWqbw9paz/K+kU1H+Hdme/V7
         Bwwnvjkw1Qg1LNHOxA1WShCscPHLezN71l99o7LC3ZKMnzMg6TYqy/DqyITiWARyGLTp
         Hhh4G1QgCZp6TSMl6CYjyX8aYE1+fLcNEugXaO4Gnud8Qualg1yVSX+wAJKshA/rsIAH
         ZsXIVDSCwkrHcvbAXUW9liovgeHzLq+uqEAmLEezdcpkNGBF3jxqWQUCNNLMUMs+LhXd
         lz+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Zx7jjBB5IBx0W7EnQ+S3p3BxnBrqMDtfQs/QT9RTn9w=;
        b=cJ6KH/VfLtyRy+6dzB8nzwqCZxFAmmAePPNZ1FfArBPCgAoAy9K6qC+sQQ52D8ATDS
         nUobyQLmo41uixh4EhiE/Ys8QQfcJVgm1MQjs/kXBNSNNL6AdFHoRggPqW2IfvIJRjl9
         yMgLEUmszYPyEkdcl/xlHUcSTaP3BLiWe1JDqxAlxHfP5VOH5zE6v09jSdPILJgxl+ia
         0L8iczDHzO7MN74VpR78EcRqJjmOO3Wj0MD5UOgcFO6SxQ197rNr1IVsTxkBRiHI58J/
         Bi5a14sSAheW/3qoO6bnux3TQpNycVyx+/oz/V91jX+ITosYRwAoa9/oGDAwJzLw2oo4
         MA4w==
X-Gm-Message-State: ACgBeo0t5+3K88NiFyG/QcI4yTgIk+ZM+qWP1u4GTnCRhl9i6NM4QucX
        YKjTCQPKjbEGT1pq5SXHJQ==
X-Google-Smtp-Source: AA6agR4TVfH17t5eyskeR7ch6bJRAqAnCPQO11rKYxsO+lxm6BfieTQ2mgnZHMctB3Z0qMmW9vgioA==
X-Received: by 2002:a05:600c:4591:b0:3a6:755b:8e6 with SMTP id r17-20020a05600c459100b003a6755b08e6mr182534wmo.147.1663018163093;
        Mon, 12 Sep 2022 14:29:23 -0700 (PDT)
Received: from playground (host-92-29-143-165.as13285.net. [92.29.143.165])
        by smtp.gmail.com with ESMTPSA id b11-20020a05600c4e0b00b003b492753826sm2329064wmq.43.2022.09.12.14.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 14:29:22 -0700 (PDT)
Date:   Mon, 12 Sep 2022 22:29:11 +0100
From:   Jules Irenge <jbi.octave@gmail.com>
To:     jejb@linux.ibm.com
Cc:     martin.petersen@oracle.com, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, mpi3mr-linuxdrv.pdl@broadcom.com
Subject: [PATCH] scsi: mpi3mr: Remove useless casting value returned by
 kcalloc to structure
Message-ID: <Yx+kp8NxHvDHs7dv@playground>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

coccinelle reports a warning

WARNING: casting value returned by memory allocation function
to (struct mpi3mr_throttle_group_info *) is useless

To fix this the useless cast is removed.

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 drivers/scsi/mpi3mr/mpi3mr_fw.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/scsi/mpi3mr/mpi3mr_fw.c b/drivers/scsi/mpi3mr/mpi3mr_fw.c
index 0866dfd43318..ee3c695ece9a 100644
--- a/drivers/scsi/mpi3mr/mpi3mr_fw.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_fw.c
@@ -3795,8 +3795,7 @@ int mpi3mr_init_ioc(struct mpi3mr_ioc *mrioc)
 	if (!mrioc->throttle_groups && mrioc->num_io_throttle_group) {
 		dprint_init(mrioc, "allocating memory for throttle groups\n");
 		sz = sizeof(struct mpi3mr_throttle_group_info);
-		mrioc->throttle_groups = (struct mpi3mr_throttle_group_info *)
-		    kcalloc(mrioc->num_io_throttle_group, sz, GFP_KERNEL);
+		mrioc->throttle_groups = kcalloc(mrioc->num_io_throttle_group, sz, GFP_KERNEL);
 		if (!mrioc->throttle_groups)
 			goto out_failed_noretry;
 	}
-- 
2.35.1

