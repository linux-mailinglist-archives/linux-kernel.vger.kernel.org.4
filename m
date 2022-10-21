Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBFFF607E29
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 20:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbiJUSOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 14:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbiJUSOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 14:14:42 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ABAA12AC6;
        Fri, 21 Oct 2022 11:14:26 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id v11so2798180wmd.1;
        Fri, 21 Oct 2022 11:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Bk4YjCSLu5/QbUBb+oa/0HDOrbXfgW9e8G+jzD0uIkI=;
        b=PUNnKf2QyDtw3cp6/6a0DqYNduOX6oQOMw0kTySqoz0k97maIX6wieSU4HoAxeqkUR
         s9IYTjR+KjOj3MRIQO8UP11ROyOT57b6ka9Jho5DhSqQezTiuyQqKQ3GNxL3OQWMSpWd
         y9gbba63TYG+GfS1Er8kp09QxY837iE8zgVWzYcwD2rQP6T80+JmrYVePkWZsdwrSNV4
         JzT9H7IZoSLdr9zzJkuXT/6P5ylX9o77PYgi7gpzX2WWiLB0jO5Bk6jaqY78o2GfJ4+E
         r3UTzo8/K/UvKp2JHYhOL8w7F/OE+uGYxlKQAMfkGbQnRDYidk1CvojN7kigVA3YvV5l
         tvvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bk4YjCSLu5/QbUBb+oa/0HDOrbXfgW9e8G+jzD0uIkI=;
        b=mYpEcu4tyH/MFThk5A+DyW9xzqWBpsiYuEl1ZcUF4oV7lR0nZVc4HA/vbah2qF+0X5
         Ce7h/HloW29zqObNlCr+e7R8CWhAGds6aguOC5ZXoakqd9Pgd1lG1spHmD0Ggx4D4p/d
         /4JiNLRts//t8ZOWK1OeD7I2W9ys83esoIXcZVb06UH6xoCxnN+7N+hcf6p3vOUs6Jg3
         kXM2C21KFacJtPiF+5wQC3ao2DrANVKNweN10iz4YAHFQ+dnInPpx2Y30TDuax2GkC2x
         lpfJly/Q6EBckzZEGrjH9aO3wq2L2pXRI6aqS2yhD6B18u1RnRYhE21T9GYqSiViy3PV
         mepw==
X-Gm-Message-State: ACrzQf3CkxjQtiesmyRoICO5tPvZZuG4QHxqIXpBaMS37J8ngSvZ1Q40
        tZFvQpsKqAmY5cFGkXTY9MU=
X-Google-Smtp-Source: AMsMyM45xoVdse05SFORL9vCUlpOMxtTcVqSzWcnsdFhZJsruvC+5KZwqNN10ESR0pIBuzglzfSyog==
X-Received: by 2002:a1c:4405:0:b0:3c5:8b6b:1efc with SMTP id r5-20020a1c4405000000b003c58b6b1efcmr34952115wma.192.1666376064869;
        Fri, 21 Oct 2022 11:14:24 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id r9-20020a05600c35c900b003c5571c27a1sm4405061wmq.32.2022.10.21.11.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 11:14:24 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] sysv: Remove variable res
Date:   Fri, 21 Oct 2022 19:14:23 +0100
Message-Id: <20221021181423.29433-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

The variable res being incremented but it is never referenced,
it is redundant and can be removed.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 fs/sysv/itree.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/sysv/itree.c b/fs/sysv/itree.c
index d4ec9bb97de9..505f4cb7be79 100644
--- a/fs/sysv/itree.c
+++ b/fs/sysv/itree.c
@@ -430,12 +430,10 @@ static unsigned sysv_nblocks(struct super_block *s, loff_t size)
 {
 	struct sysv_sb_info *sbi = SYSV_SB(s);
 	int ptrs_bits = sbi->s_ind_per_block_bits;
-	unsigned blocks, res, direct = DIRECT, i = DEPTH;
+	unsigned blocks, direct = DIRECT, i = DEPTH;
 	blocks = (size + s->s_blocksize - 1) >> s->s_blocksize_bits;
-	res = blocks;
 	while (--i && blocks > direct) {
 		blocks = ((blocks - direct - 1) >> ptrs_bits) + 1;
-		res += blocks;
 		direct = 1;
 	}
 	return blocks;
-- 
2.37.3

