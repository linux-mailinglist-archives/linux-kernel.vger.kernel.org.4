Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1606B5B62
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 12:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbjCKL6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 06:58:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbjCKL6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 06:58:11 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AAEB1BF1
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 03:58:05 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id l7-20020a05600c1d0700b003eb5e6d906bso5020439wms.5
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 03:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678535883;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ptrqZeh9HIGFI7MOVZ5moQhtRx3GFjYgX8SReWprvoM=;
        b=o1Mj3GY4Cn8akOv3bHd+q5AVPYVXfb7R6wjvmJa6UvIiBcvNwFxxKoC1TkeBuxYBuB
         KNY4iurBv+NevaSDDRaelltwmR5EW4tDPJs+ZjE7V7z69YW7aln/QnVlQRMVJb/1njgM
         jYnOZhOQuyxKp8bRou0xOvqFxq0fXKmGFUQWT2BAtOn0itqzM+ZVCmEJt+7CTE4FLymu
         bXqEdsm2gxL8CTPEpgqk5JLwlEyJN30aAaZRV0E4frIuBh5fpc7GpKo5W6RYzG30kzVd
         WXpPrOVimqER6/DGyFdeww44lEnAKDhfGnPPEHzldKEYFN6o+ZfsApDKl1OxSRB6HK2H
         2Lmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678535883;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ptrqZeh9HIGFI7MOVZ5moQhtRx3GFjYgX8SReWprvoM=;
        b=DtL9/LbgL3+RaM8zLeMW86urxd2nc1zqEYdpgTlLmohz2ztqVvsA5tpM44VX4o8QKy
         nPkGIRvlJZeluDcdQOrEFRUix6/x3clQN+2Bo2o+V73hcdJKB6mgSQk7+CXVVWXQxLA0
         tRBF7YztWtV8A9KAkwIvBgTbBkmWxBrT6J0YD5lJLu/Oe5lSkYrH9d+CACJLVgFZ9SNZ
         pLlJyI1kEDENyhdO0H1DeAQxxGm9sIJ6KEscR+HuP5+XepwR5t1ZCaYbOfO9GmGdomvk
         1MdkA4rnQEwAuK7uq26ssc8A7GT3IjfHi2jpS3uoaMR2M7JsG34UR3zXun2I9WmBW0Pw
         +4Xg==
X-Gm-Message-State: AO0yUKVPRcxqDAulfZ85TjOVki01g6DT7AhqHzN9b+2o/jxvIaTkb6yJ
        5LSPYxs6btjmsTBfgoouiaUnMn3RAuBS26yy
X-Google-Smtp-Source: AK7set8DJMGgjuDt6KMKwOHFqDnTPy/G6R74HQnLW9Dhwnbc7BpnAH3dSjSK52muIZXjMP6gY95/hw==
X-Received: by 2002:a05:600c:1c0d:b0:3dc:4318:d00d with SMTP id j13-20020a05600c1c0d00b003dc4318d00dmr5525596wms.11.1678535883563;
        Sat, 11 Mar 2023 03:58:03 -0800 (PST)
Received: from khadija-virtual-machine ([39.41.45.115])
        by smtp.gmail.com with ESMTPSA id k17-20020a05600c0b5100b003e1f6e18c95sm2641027wmr.21.2023.03.11.03.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 03:58:03 -0800 (PST)
Date:   Sat, 11 Mar 2023 16:58:01 +0500
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v3] staging: axis-fifo: remove tabs to align arguments
Message-ID: <ZAxsyX8n7G92nlJh@khadija-virtual-machine>
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

In file drivers/staging/axis-fifo/axis-fifo.c, in line 386 and 529, the
last argument is indented as if it were an argument of the second
argument. Remove tabs to align the arguments.

Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
---
Changes in v3:
 - Do not align the line 530 since it is not part of the last argument.

 drivers/staging/axis-fifo/axis-fifo.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/axis-fifo/axis-fifo.c b/drivers/staging/axis-fifo/axis-fifo.c
index dfd2b357f484..b119cec25a60 100644
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
@@ -528,9 +528,9 @@ static ssize_t axis_fifo_write(struct file *f, const char __user *buf,
 		ret = wait_event_interruptible_timeout(fifo->write_queue,
 			ioread32(fifo->base_addr + XLLF_TDFV_OFFSET)
 				 >= words_to_write,
-				 (write_timeout >= 0) ?
-				  msecs_to_jiffies(write_timeout) :
-				  MAX_SCHEDULE_TIMEOUT);
+			(write_timeout >= 0) ?
+			msecs_to_jiffies(write_timeout) :
+			MAX_SCHEDULE_TIMEOUT);
 
 		if (ret <= 0) {
 			if (ret == 0) {
-- 
2.34.1

