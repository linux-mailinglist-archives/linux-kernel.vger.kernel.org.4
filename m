Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1BA742F73
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 23:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232003AbjF2VX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 17:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbjF2VXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 17:23:48 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8202D52
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 14:23:47 -0700 (PDT)
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id BE6753F171
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 21:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1688073824;
        bh=lBu3qM/V63MFPKIE8Q51C0JVShDE9+Oj/gb/00UQ8Pk=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=MDAx3stWZHLXjRZI+48SZpPBMPBUcopSguX5YZrw6lGsp59YK9SPaVu1huo+oixwm
         EGl463mt3TqaxwQYSLnaY9Q27/5jJ2g6FoJeu6+IiUVVbanYg+GIcS1dF6NfDTFPag
         ot9/KZqAhmovTPnS5BUCWs5f3IZC3VpxLwYVU543CI9Fv8wHusnDYFB+fIqMqyK3J0
         wfwmXokA+l1PeUEHaemjSdscB5wYsX8Bo1ts+pwPHIP0H25isl4tgXIlYfyFCxGzxB
         OVMGqnBHHh0DvHCKcw7jH0jicdTipJxS3SJBc1EzLmz5TL7JJZcU/U0Zay2GgwJgVH
         d4XV40w95Sw6A==
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-6b2ac1fe3d6so1669787a34.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 14:23:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688073822; x=1690665822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lBu3qM/V63MFPKIE8Q51C0JVShDE9+Oj/gb/00UQ8Pk=;
        b=LlgTD6e2fScY8CZvA3arUjQm9TK3ASFrJCRbGgLaIdIJhKZy1WKAQiFpIoLIV/342L
         tlGvg573mQ/bR3N4fs1IApyCqrJWXtrZL3hQoImXJ8kWXHpRPZX0XKgiSmS/tDpo1WQR
         REawF3uMOw6HLzT05PL/qK9jxHU/PHHQudy2ZCsJ23dyeCAF9CCN6sMMQwI2pNaj1v/s
         ydaXyx7qrnNI1tvv/9leoWP30ynpNpf/+4fX01TDCtE+X92Ftm14HklW/SsPxG0t7B+1
         DoZSPMThGfTC1FT5R5wdrKQMB+qD5JeBbWIptziZjzkmmxYnMJpKJQnS0bBEftNNuycj
         iVPQ==
X-Gm-Message-State: AC+VfDwx8C52gpu6CgXTR5Cdn4xinTyouqp8+BzhdyKlbWdZaXbaf8HV
        szKZtXM75ZW20KgF8PomneXNcnFqUm6qnlK8fLhCvyA/PKKGG2C/yUNiFnBTxitaLCn2prH9BEg
        M8ca4CpakXW6optERJoaQVZNDBHrlcRBzB3V7o/PQUg==
X-Received: by 2002:a9d:7412:0:b0:6b3:70ee:3055 with SMTP id n18-20020a9d7412000000b006b370ee3055mr1118629otk.13.1688073822631;
        Thu, 29 Jun 2023 14:23:42 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5BSkQ14DJnLGsVYL3rkT1q6lTW+tOQ0ujOLMJuBmJHltoGd6bcezyTaH/cgHrQoi/rbwjVig==
X-Received: by 2002:a9d:7412:0:b0:6b3:70ee:3055 with SMTP id n18-20020a9d7412000000b006b370ee3055mr1118618otk.13.1688073822478;
        Thu, 29 Jun 2023 14:23:42 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:4e1:83a2:7720:9030:a195:e622])
        by smtp.gmail.com with ESMTPSA id q6-20020a9d6646000000b006b871010cb1sm2711764otm.46.2023.06.29.14.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 14:23:42 -0700 (PDT)
From:   Mauricio Faria de Oliveira <mfo@canonical.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     "Isaac J. Manjarres" <isaacmanjarres@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] loop: deprecate autoloading callback loop_probe()
Date:   Thu, 29 Jun 2023 18:22:55 -0300
Message-Id: <20230629212256.918239-2-mfo@canonical.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230629212256.918239-1-mfo@canonical.com>
References: <20230629212256.918239-1-mfo@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'probe' callback in __register_blkdev() is only used
under the CONFIG_BLOCK_LEGACY_AUTOLOAD deprecation guard.

The loop_probe() function is only used for that callback,
so guard it too, accordingly.

See commit fbdee71bb5d8 ("block: deprecate autoloading based on dev_t").

Signed-off-by: Mauricio Faria de Oliveira <mfo@canonical.com>
---
 drivers/block/loop.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index bc31bb7072a2..21bcd6ffe241 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -2095,6 +2095,7 @@ static void loop_remove(struct loop_device *lo)
 	put_disk(lo->lo_disk);
 }
 
+#ifdef CONFIG_BLOCK_LEGACY_AUTOLOAD
 static void loop_probe(dev_t dev)
 {
 	int idx = MINOR(dev) >> part_shift;
@@ -2103,6 +2104,7 @@ static void loop_probe(dev_t dev)
 		return;
 	loop_add(idx);
 }
+#endif
 
 static int loop_control_remove(int idx)
 {
@@ -2237,8 +2239,11 @@ static int __init loop_init(void)
 	if (err < 0)
 		goto err_out;
 
-
+#ifdef CONFIG_BLOCK_LEGACY_AUTOLOAD
 	if (__register_blkdev(LOOP_MAJOR, "loop", loop_probe)) {
+#else
+	if (register_blkdev(LOOP_MAJOR, "loop")) {
+#endif
 		err = -EIO;
 		goto misc_out;
 	}
-- 
2.39.2

