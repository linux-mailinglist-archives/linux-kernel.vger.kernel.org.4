Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70B8263A41F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 10:06:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbiK1JGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 04:06:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbiK1JGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 04:06:15 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 627C61838B
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 01:06:12 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id q71so9359601pgq.8
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 01:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z+Rewj5p/ZFGKxaPkUSZu5AiKFXUjbdI5QMEOTU0onA=;
        b=N1GqHq6LcBeYT2l7XL/E6WrtMRb3SC9TfF0Ms+o9jvLzFuUqGl9Vm8bAou8v2kAWsi
         poKhl+7fXJFqqqWVJbPZdfSyo1DHC2n0YX1uvnCcs41pVleSqF9bFUuwRjg+iMcF2dZP
         GtZIUs9iE3sUpienUE20MiT6D8PgcUjnHJe9x+0kxXkPI10ugjCHonoNiNup1GwPZAmL
         Og7VTNP7yhM6ueK9OzJ6Lo/zKsvmfuL4be0w9cqBnuUsBj/JAzOpTJptu0HvQDjulGbD
         i0AebW/Aj1gLuAFrI35sA04jfCmRGBEWZGegZDlTbvEmG6VUu/9aLBfQIOEXz37gJNxU
         Rzfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z+Rewj5p/ZFGKxaPkUSZu5AiKFXUjbdI5QMEOTU0onA=;
        b=6zLTyOekxVF91SI8edEaUfd+dMaK6jD2y4TgJ6mLi/gpsJZppRDcKZrUC7Bp6+ar+S
         +K0OFWJIQr6GZObS7Y85uD65KasBrxHcGV7LkWqOERBhLsWXqmhYseZTg4sCq0i9BVRi
         pSHxoC/QB3uWx+yvWyuCguJ8bkWF0u5WbJelcBLRHn6ZIpRwTFyQohtpUZ2+ls9mE2Hq
         f7HNZhzkgaVqvxkmmMwrdw9sd/XS1YKwBjOxtM+C9+JfRrZBcbNLOUG1FxXpZIKXbHIu
         4keVUAY9rZUM8qsUcdNPQVHE0T5TpVXMTkYkFdunE5qhQ5drp+7kaXrACm3Hb2+wPgIX
         pluQ==
X-Gm-Message-State: ANoB5pkJmemUPwxwWYmST4f33CccZIzA+mOkJHJJh/cRmmVAYPeZdeF+
        /JVcIB8L3+YRiRwjkKCBgss=
X-Google-Smtp-Source: AA0mqf62LtEI9k6+6wMNDHKrBLNRhc6uHK7Lm6kOO+RYwr5f9qZ4w4JI2m2o2VZeO6mtsy7bcya9Qw==
X-Received: by 2002:a05:6a00:1d0c:b0:573:7b50:acb8 with SMTP id a12-20020a056a001d0c00b005737b50acb8mr34307462pfx.59.1669626371832;
        Mon, 28 Nov 2022 01:06:11 -0800 (PST)
Received: from mi-HP-ProDesk-680-G4-MT.mioffice.cn ([43.224.245.252])
        by smtp.gmail.com with ESMTPSA id s17-20020a170902ea1100b001811a197797sm8269268plg.194.2022.11.28.01.06.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Nov 2022 01:06:11 -0800 (PST)
From:   qixiaoyu1 <qxy65535@gmail.com>
X-Google-Original-From: qixiaoyu1 <qixiaoyu1@xiaomi.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        qixiaoyu1 <qixiaoyu1@xiaomi.com>,
        xiongping1 <xiongping1@xiaomi.com>
Subject: [PATCH 0/5] Support enhanced hot/cold data separation for f2fs
Date:   Mon, 28 Nov 2022 16:58:54 +0800
Message-Id: <20221128085859.5295-1-qixiaoyu1@xiaomi.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series introduce a runtime hot/cold data separation
method for f2fs, in order to improve the accuracy for data
temperature classification, reduce the garbage collection overhead
after long-term data updates.

Enhanced hot/cold data separation can record data block update
frequency as "age" of the extent per inode, and take use of the age
info to indicate better temperature type for data block allocation:
 - It record total data blocks allocated since mount;
 - When file extent has been updated, it calculate the count of data
blocks allocated since last update as the age of the extent;
 - Before the data block allocated, it search for the age info and
choose the suitable segment for allocation.

Patch 1 records total data blocks allocated since mount.

Patch 2 implements cache to manager block update frequency per inode.

Patch 3 adds age_extent_cache mount option to enable this feature only
when age_extent_cache mount option is on.

Patch 4 updates block age info during out of place update.

Patch 5 implements data block seperation with block update frequency.

Test and result:
 - Prepare: create about 30000 files
  * 3% for cold files (with cold file extension like .apk, from 3M to 10M)
  * 50% for warm files (with random file extension like .FcDxq, from 1K
to 4M)
  * 47% for hot files (with hot file extension like .db, from 1K to 256K)
 - create(5%)/random update(90%)/delete(5%) the files
  * total write amount is about 70G
  * fsync will be called for .db files, and buffered write will be used
for other files

The storage of test device is large enough(128G) so that it will not
switch to SSR mode during the test.

Benefit: dirty segment count increment reduce about 14%
 - before: Dirty +21110
 - after:  Dirty +18286

qixiaoyu1 (2):
  f2fs: update block age info during out of place update
  f2fs: implement data block seperation with block update frequency

xiongping1 (3):
  f2fs: record total data blocks allocated since mount
  f2fs: implement cache to manager block update frequency per inode
  f2fs: add age_extent_cache mount option

 Documentation/ABI/testing/sysfs-fs-f2fs |  14 +
 Documentation/filesystems/f2fs.rst      |   4 +
 fs/f2fs/Kconfig                         |   7 +
 fs/f2fs/Makefile                        |   1 +
 fs/f2fs/block_age.c                     | 733 ++++++++++++++++++++++++
 fs/f2fs/debug.c                         |  20 +
 fs/f2fs/f2fs.h                          |  83 +++
 fs/f2fs/file.c                          |  10 +
 fs/f2fs/inode.c                         |   8 +
 fs/f2fs/namei.c                         |   4 +
 fs/f2fs/node.c                          |   7 +-
 fs/f2fs/node.h                          |   3 +
 fs/f2fs/segment.c                       |  23 +
 fs/f2fs/shrinker.c                      |   3 +
 fs/f2fs/super.c                         |  51 ++
 fs/f2fs/sysfs.c                         |  28 +
 include/trace/events/f2fs.h             | 239 ++++++++
 17 files changed, 1237 insertions(+), 1 deletion(-)
 create mode 100644 fs/f2fs/block_age.c

-- 
2.36.1

