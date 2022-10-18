Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82686602194
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 05:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbiJRDBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 23:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiJRDBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 23:01:50 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 083627C1DF;
        Mon, 17 Oct 2022 20:01:49 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id h185so12137279pgc.10;
        Mon, 17 Oct 2022 20:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WWMdFJGs5DgUEWW8awow44gePXhtUjv8QjZhtsWcoqI=;
        b=HG9s31zBmBlGU/c8g3l2rRlwoH6mf+t4iR1KVR21X7KFGu9a4/AGUL9xdVpA9m8MRP
         Rii+QEy66+EomLoHH+4CS/IH9wYfp/eheBpQ4I4+sU8QAyr5W14qouJb9+j/HxuOMY3U
         fuse64nJv7TymuKZCw/5D3YmYr+FUjw31JlKpPFN0DQJJnMxtcr4555O+mApp2tSTQvi
         +etbHgqtERj/f4YLq9cfeHOQIPjRMODmTPiZUCKHZAqGxamVGi1zubGFQPSg48j+ryDt
         BkTeK8F03g3ZLHCDNI8oAkfGGAZt/wDjYgX86iIhmVMNifXPINGHfGrS6zmYRhCxQhAU
         Berg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WWMdFJGs5DgUEWW8awow44gePXhtUjv8QjZhtsWcoqI=;
        b=g/QdpqZmecqXXMc6U7GVIZaMuYtnQxXU8rabfLdTYcK2YRkUzJxtQs7XUSAzEBwmD9
         WMLWa0yUtguQ4Gfweoj1s/4RvfllG1B18xOZAS+dPnL75M9N6N0/KivDSDOHf+hGkJZ6
         0mtUj/HJAHMdZTaVBgb/OXs+pDZPgl4KUJSU+g7OoTvnUJVTFk0r6wIqtCiI9vzeJ39M
         KQM9eqHU3CYWrBnepeMP8JdkmhojXyrJswZ+xvava3oy6eBeW4/00CVEv/sIm/R+MYco
         XKXjpSzdf4caPUzXuTRMkWWgneBGxusP/8BPtI2Q+rS8dfLrOw+gyoAbts4EACrUzxit
         o+YQ==
X-Gm-Message-State: ACrzQf1SuU7cROF1mbb35um2TAMwFvuQVXwbgW07Et+GiizrDcgXP6sw
        2ntJw/hna3zGaJ1o8Wz6Lfw=
X-Google-Smtp-Source: AMsMyM7qtN/U45oKAQelUobuQzV70zQqr0ujKel/xvCovIjaPori1kDFKCBa2gDbzxxoZ7KLwYKFew==
X-Received: by 2002:a05:6a00:1f10:b0:562:b9e1:55e9 with SMTP id be16-20020a056a001f1000b00562b9e155e9mr722034pfb.60.1666062108488;
        Mon, 17 Oct 2022 20:01:48 -0700 (PDT)
Received: from Zbook.localdomain ([129.227.152.6])
        by smtp.gmail.com with ESMTPSA id u5-20020a170903124500b00174c0dd29f0sm7375257plh.144.2022.10.17.20.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 20:01:47 -0700 (PDT)
From:   Yuwei Guan <ssawgyw@gmail.com>
X-Google-Original-From: Yuwei Guan <Yuwei.Guan@zeekrlife.com>
To:     paolo.valente@linaro.org, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yuwei.Guan@zeekrlife.com
Subject: [RESEND PATCH] block, bfq: remove unused variable for bfq_queue
Date:   Tue, 18 Oct 2022 11:01:39 +0800
Message-Id: <20221018030139.159-1-Yuwei.Guan@zeekrlife.com>
X-Mailer: git-send-email 2.34.1
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

it defined in d0edc2473be9d, but there's nowhere to use it,
so remove it.

Signed-off-by: Yuwei Guan <Yuwei.Guan@zeekrlife.com>
Acked-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index 64ee618064ba..71f721670ab6 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -369,12 +369,8 @@ struct bfq_queue {
 	unsigned long split_time; /* time of last split */
 
 	unsigned long first_IO_time; /* time of first I/O for this queue */
-
 	unsigned long creation_time; /* when this queue is created */
 
-	/* max service rate measured so far */
-	u32 max_service_rate;
-
 	/*
 	 * Pointer to the waker queue for this queue, i.e., to the
 	 * queue Q such that this queue happens to get new I/O right
-- 
2.34.1

