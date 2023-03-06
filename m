Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 178E16ACF92
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 21:52:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbjCFUws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 15:52:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjCFUwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 15:52:46 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B08724118
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 12:52:45 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id k37so6531635wms.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 12:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678135963;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5aJCxiJZWerGesLMxoiHiSQbzXq2ZZwY7rYAIRdf2Ow=;
        b=gcUrahBEEiK3lB9tcDO/XZO8WeBNXUpgDFlATbPAT5MXeiSwMCN6aklVbGYYHiF1WN
         ryuaitWiehrmvmA2eJZGm6zXEam7Hf0uvUCxNaVqczc8WGNtq9lVqU9nRcD0cV78vV2V
         arQurw56NnxeKsJsh053moE14OtP2kuiYSKEDJmDkI7dsB9aS3JhzOnHKkIyfmidxid4
         QEzZVAFZr00OO/wfycjW/n0scmZH1bU2sHbuhBYu0+dkPOlKANPwk3Ryjl1+bR7dNtof
         L9j5IZMvkskqjq8ogJhEvTKYgZqx6QDnCvjCrs+iBtCdZYqF6Ft4RpfberVlGg7r41wu
         CEtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678135963;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5aJCxiJZWerGesLMxoiHiSQbzXq2ZZwY7rYAIRdf2Ow=;
        b=MIIEc9QpEgS9JG5yV4ZLBXIOtS1Jl0SIwI2cmDKHGoSXaKtGUGIO5glvwJ7cy2Fww5
         TX0r50uu2jMa5k6tKLx5ikECgi1SvBKmWrvoFCeDR2sZp5ADauYswcj1abJuDmazCy8L
         Qvn3fNGlW480uVM3vnD9kKDQPUJeLq32korVu4GZ7oTJeKclhMBB3Fn45j9+YSyv1MqY
         2nYjFOxYvyNAIuBTyqO9Czi/VNtdoNy9v+VdRsOfXxGq+PpkVr0x8LybxaXUfwOc7t7a
         qZo9m/lB1kCR3w5SxrUbEwvgYX42QKgAnAVmu9Y0hksKgiaWVNzMs6Rhw2aJteBkrlPZ
         ufCg==
X-Gm-Message-State: AO0yUKWjC1q+XKr0IBA0LOwWIHyqBYYELcAcC6A6ID9X7BxKsUeBN1cw
        XTvsyYd62ellfmXyS6S8kM5uDkIndzX9VneA
X-Google-Smtp-Source: AK7set9ckL59axzNSlfpGNFK4YFTFflF6EN7ZhEsDsE98Hg8WI/WSPJBBXK0tTDbPjsN73pI6QUY5g==
X-Received: by 2002:a05:600c:3c90:b0:3eb:2b69:c3c6 with SMTP id bg16-20020a05600c3c9000b003eb2b69c3c6mr10510232wmb.1.1678135963365;
        Mon, 06 Mar 2023 12:52:43 -0800 (PST)
Received: from khadija-virtual-machine ([39.41.45.115])
        by smtp.gmail.com with ESMTPSA id m18-20020a05600c3b1200b003db0ad636d1sm16213303wms.28.2023.03.06.12.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 12:52:43 -0800 (PST)
Date:   Tue, 7 Mar 2023 01:52:40 +0500
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     outreachy@lists.linux.dev, linux-staging@lists.linux.dev
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: axis-fifo: alignment should match opening
 parenthesis in axis-fifo.c
Message-ID: <ZAZSmPpB6fcozGa4@khadija-virtual-machine>
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

In file drivers/staging/axis-fifo/axis-fifo.c the alignment did not match the opening parenthesis. So, a few tabs were added to match the alignment to exactly where the parenthesis started.

Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
---
 drivers/staging/axis-fifo/axis-fifo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/axis-fifo/axis-fifo.c b/drivers/staging/axis-fifo/axis-fifo.c
index dfd2b357f484..6e959224add0 100644
--- a/drivers/staging/axis-fifo/axis-fifo.c
+++ b/drivers/staging/axis-fifo/axis-fifo.c
@@ -383,7 +383,7 @@ static ssize_t axis_fifo_read(struct file *f, char __user *buf,
 		 */
 		mutex_lock(&fifo->read_lock);
 		ret = wait_event_interruptible_timeout(fifo->read_queue,
-			ioread32(fifo->base_addr + XLLF_RDFO_OFFSET),
+						       ioread32(fifo->base_addr + XLLF_RDFO_OFFSET),
 				 (read_timeout >= 0) ?
 				  msecs_to_jiffies(read_timeout) :
 				  MAX_SCHEDULE_TIMEOUT);
-- 
2.34.1

