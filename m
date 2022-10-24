Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB9360AE48
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 16:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbiJXO4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 10:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233100AbiJXOzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 10:55:41 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5025C114DDE;
        Mon, 24 Oct 2022 06:32:48 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id t4so6569506wmj.5;
        Mon, 24 Oct 2022 06:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sLYkpvVCOOtRmeROPQWGaXprs16SuKoBjgdo1TzDYBw=;
        b=OidfekMQ+wgqg2Jyz1BrARw3IJY3Ql0Yv9rP1UqPRTfXq3UAP9XIu5iE9dDpR6Hgni
         0S4Z9lf9mU81W0QdXfo56RvHtmwbC+fEtiRDAXwLor+FrTk41upfkcfBDCWzgsJav+wb
         GYStwBKnPk16tOtkMSuPx4QYNVyaED7NIxjI9D+j8zYnxs4NhEsa0GDzYiRC0MeglRrr
         KAW4uxcSA7kPjpZGL6SdC9/YaZ4BB2zl5sGRhPvM7Sm6ZzntNiwyYGXX0zdWWeyR8RIX
         Pva6eh9Cdx0iykZAiubnD6erR450whWtNg8b7fuxHAbBuqDjNxDJ1+SiKOah4c+QgwXH
         yvbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sLYkpvVCOOtRmeROPQWGaXprs16SuKoBjgdo1TzDYBw=;
        b=sb2UNscYibAC5yLssJ9lKRJHU32T7D0SpjvchS1MBoGpmrZ95EOgO+OSumPnSUCTRV
         rpvX+G92fbPQziX9SVYpSphVG8fTYU6BQHYodX3lGGjYIEMHJSv/6d7ylz0d6YBGbInu
         6Nf6oUzSkWZbe+EdHJmz2AeALF5Uun/1bRINbsyccbWucHJpF+CjB6qCX+/+bWpJsJVT
         D4okkMRp0sW8FuYsnS38NkuGkFPJy8sy97r5huQTh8pMUFSwjQXVogPkLkB+cwH63eRF
         F/wwoY69i1r2M/RwH79gAoaFih5k7r0hF1lFuZuQU52sO1Gbn5Z5x/YD6Ty3YWulQjOR
         Rblg==
X-Gm-Message-State: ACrzQf0yxHyyk9J991D5Eoo7XyAQqc0eHSmDTXvt/pxmX7eGjysVX7s0
        Ppoz61yxra7GKv1/TyiE+w0=
X-Google-Smtp-Source: AMsMyM7EVVv6tLq9HYHCC0JhHbl4xrIrrfI7Mqkf7iAbNX3F9V1/zF38tt5rpXYdtcWuRgcdX3tgCA==
X-Received: by 2002:a05:600c:5011:b0:3c6:cd93:cf24 with SMTP id n17-20020a05600c501100b003c6cd93cf24mr21905457wmr.16.1666618180452;
        Mon, 24 Oct 2022 06:29:40 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id o10-20020a1c750a000000b003b4868eb6bbsm13581511wmc.23.2022.10.24.06.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 06:29:40 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Mike Marshall <hubcap@omnibond.com>,
        Martin Brandenburg <martin@omnibond.com>,
        devel@lists.orangefs.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] orangefs: remove variable i
Date:   Mon, 24 Oct 2022 14:29:39 +0100
Message-Id: <20221024132939.2157707-1-colin.i.king@gmail.com>
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

Variable i is just being incremented and it's never used
anywhere else. The variable and the increment are redundant so
remove it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 fs/orangefs/inode.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index 7a8c0c6e698d..eaa35a966115 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -530,7 +530,6 @@ static ssize_t orangefs_direct_IO(struct kiocb *iocb,
 	size_t count = iov_iter_count(iter);
 	ssize_t total_count = 0;
 	ssize_t ret = -EINVAL;
-	int i = 0;
 
 	gossip_debug(GOSSIP_FILE_DEBUG,
 		"%s-BEGIN(%pU): count(%d) after estimate_max_iovecs.\n",
@@ -556,7 +555,6 @@ static ssize_t orangefs_direct_IO(struct kiocb *iocb,
 	while (iov_iter_count(iter)) {
 		size_t each_count = iov_iter_count(iter);
 		size_t amt_complete;
-		i++;
 
 		/* how much to transfer in this loop iteration */
 		if (each_count > orangefs_bufmap_size_query())
-- 
2.37.3

