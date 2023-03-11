Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7B16B5A38
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 10:46:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbjCKJqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 04:46:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbjCKJpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 04:45:36 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3930E14089C
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 01:44:08 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id bw19so7161000wrb.13
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 01:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678527846;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FV3s4pRBe/SsPDvS5hXhpiciVp3uptiHsH3lqLkU2zk=;
        b=Uio34FAeq2YHxBhU4bvnf9HFokRxjfOB1qJ4O+FDUqpT7UFH5A3z3c2eZjy9eTp5OU
         I6Ce+mpoMMRnfdlz4yiTDYqiolPpw0sVKhvfXxPo8YP0eMMwQreZtDnJg2p4Ap8lfImU
         wRrrss4iuZvEFxps7e1GMS4IfgFCrWRJC5l8jvHx9T6xMP2PBS3zC52pbdfMu9YtjP4P
         /x7sHF/bgCRjTWt+TlRFTrQ2HRF7IdrPYj17jr0LutGMiri38LjuzyOEq+85hxbwCdMb
         ipEoKBTMWp2ha/cCVcSOzPfhE4KkGl7JvtjqBKTOEr+mq+RCZaIGt9iXxHo2ZOkYBdx1
         e7wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678527846;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FV3s4pRBe/SsPDvS5hXhpiciVp3uptiHsH3lqLkU2zk=;
        b=olHMVwuzLHvL2ANzGxj3EZ2/BGA3JL2O2WrhvBjwBBvXJR9O6ZO7D3N686OyIUR+GD
         +ONfpjvpbzawVmHFYuiZd72fqjyuTrDqZzJgVLKo33kehcuPO0Di8herHMW6TILDaFq/
         imDKiU7xRDmsLZETRJBQet3ZWZs3bT7eKd62V4XJiezKVLvmMcIQWY2NvViqd46YhWNx
         FDQfLAD2ov+2rMpwTNU8Z1Q3jTVjcnge6wlu01o6yRs0GLkl33+NYSL6Und9e02ffwvg
         VcKqs1bCSZczTQuHtZZ9WgmsURTPFx+qdSYhyH691B1tIv5EbaTxN2LVldLpDXqE8SoO
         J5cg==
X-Gm-Message-State: AO0yUKUAFzJnTkIIMp6+NCDPK4DTpkItFu5PDE+o9b5Jy8txZoc/xwpU
        auGSASMcbENCooXXBD7c4V7sYDLK2bm0793I
X-Google-Smtp-Source: AK7set8pmYj4u4FDqLSBl8UQeoIicOm93KMCFaxkMKEuR8FNwIXgVOxfFt+1AVDWvaX/17Aqb2v/Nw==
X-Received: by 2002:a5d:6641:0:b0:2ce:a825:e0a1 with SMTP id f1-20020a5d6641000000b002cea825e0a1mr253556wrw.14.1678527846108;
        Sat, 11 Mar 2023 01:44:06 -0800 (PST)
Received: from khadija-virtual-machine ([39.41.45.115])
        by smtp.gmail.com with ESMTPSA id x4-20020a5d60c4000000b002c6d0462163sm1967663wrt.100.2023.03.11.01.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 01:44:05 -0800 (PST)
Date:   Sat, 11 Mar 2023 14:44:03 +0500
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: axis-fifo: remove tabs to align arguments
Message-ID: <ZAxNYw2rFQkrdtKl@khadija-virtual-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In file drivers/staging/axis-fifo/axis-fifo.c, in line 386 and 529, last
argument is indented as it were an argument of the second argument.
Remove tabs to align the arguments.

Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
---
Changes in v2:
 - Do not change the alignment of second argument
 - Align arguments so last argument do not look like an argument of the
   second argument.
 - Fixed two instances of the same problem

 drivers/staging/axis-fifo/axis-fifo.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/axis-fifo/axis-fifo.c b/drivers/staging/axis-fifo/axis-fifo.c
index dfd2b357f484..fbb3ff59dc7c 100644
--- a/drivers/staging/axis-fifo/axis-fifo.c
+++ b/drivers/staging/axis-fifo/axis-fifo.c
@@ -384,9 +384,9 @@ static ssize_t axis_fifo_read(struct file *f, char __user *buf,
 		mutex_lock(&fifo->read_lock);
 		ret = wait_event_interruptible_timeout(fifo->read_queue,
 			ioread32(fifo->base_addr + XLLF_RDFO_OFFSET),
-				 (read_timeout >= 0) ?
-				  msecs_to_jiffies(read_timeout) :
-				  MAX_SCHEDULE_TIMEOUT);
+			(read_timeout >= 0) ?
+			msecs_to_jiffies(read_timeout) :
+			MAX_SCHEDULE_TIMEOUT);
 
 		if (ret <= 0) {
 			if (ret == 0) {
@@ -527,10 +527,10 @@ static ssize_t axis_fifo_write(struct file *f, const char __user *buf,
 		mutex_lock(&fifo->write_lock);
 		ret = wait_event_interruptible_timeout(fifo->write_queue,
 			ioread32(fifo->base_addr + XLLF_TDFV_OFFSET)
-				 >= words_to_write,
-				 (write_timeout >= 0) ?
-				  msecs_to_jiffies(write_timeout) :
-				  MAX_SCHEDULE_TIMEOUT);
+			>= words_to_write,
+			(write_timeout >= 0) ?
+			msecs_to_jiffies(write_timeout) :
+			MAX_SCHEDULE_TIMEOUT);
 
 		if (ret <= 0) {
 			if (ret == 0) {
-- 
2.34.1

