Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8136A5BC140
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 04:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbiISCI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 22:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiISCIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 22:08:55 -0400
Received: from mail-m975.mail.163.com (mail-m975.mail.163.com [123.126.97.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6CFAB13D11
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 19:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=nCEDr
        7B9T2lOsIVVEfziWenUjr7H/YIz7zCC+oZks+s=; b=e1/I+UNqLir8VjITwY8zg
        brmFGkm27Ndt8AM2itTc0atgSXrLBjx0EZXtnwvBegLXUU1nzxeKZWbslsR6eU3V
        k4nkMwNmxwMSeRu3lT5IVeHpzZYub2sgRsdc7rz+9tazGhzQWFthPAdMDLKfx8cC
        NgBeKU1YRBr3YxHGkm0s6k=
Received: from localhost.localdomain (unknown [116.128.244.169])
        by smtp5 (Coremail) with SMTP id HdxpCgDH8yEszydjGgoMdw--.41022S2;
        Mon, 19 Sep 2022 10:08:45 +0800 (CST)
From:   Jiangshan Yi <13667453960@163.com>
To:     dushistov@mail.ru
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        Jiangshan Yi <yijiangshan@kylinos.cn>
Subject: [PATCH] fs/ufs/super.c: use __func__ instead of function name
Date:   Mon, 19 Sep 2022 10:07:59 +0800
Message-Id: <20220919020759.3613414-1-13667453960@163.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: HdxpCgDH8yEszydjGgoMdw--.41022S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Jryktr4xGw45ArykKry3Arb_yoW8JF45pa
        1kC3W7KrZ8G3WkZa4rAFWvqw12q3ykt34xKryxZry3Xws5XwnxXFW8t34Fkry8XrWrXw1U
        Zr4DKrWSvr1xKw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Uuv3nUUUUU=
X-Originating-IP: [116.128.244.169]
X-CM-SenderInfo: bprtllyxuvjmiwq6il2tof0z/xtbBthyB+11uQiemOgAAsa
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FROM_LOCAL_DIGITS,FROM_LOCAL_HEX,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiangshan Yi <yijiangshan@kylinos.cn>

It is better to use __func__ instead of function name.

Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
---
 fs/ufs/super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ufs/super.c b/fs/ufs/super.c
index 23377c1baed9..87752e5dfd2a 100644
--- a/fs/ufs/super.c
+++ b/fs/ufs/super.c
@@ -153,7 +153,7 @@ static void ufs_print_super_stuff(struct super_block *sb,
 {
 	u32 magic = fs32_to_cpu(sb, usb3->fs_magic);
 
-	pr_debug("ufs_print_super_stuff\n");
+	pr_debug("%s\n", __func__);
 	pr_debug("  magic:     0x%x\n", magic);
 	if (fs32_to_cpu(sb, usb3->fs_magic) == UFS2_MAGIC) {
 		pr_debug("  fs_size:   %llu\n", (unsigned long long)
@@ -228,7 +228,7 @@ static void ufs_print_super_stuff(struct super_block *sb,
 static void ufs_print_cylinder_stuff(struct super_block *sb,
 				     struct ufs_cylinder_group *cg)
 {
-	pr_debug("\nufs_print_cylinder_stuff\n");
+	pr_debug("\n%s\n", __func__);
 	pr_debug("size of ucg: %zu\n", sizeof(struct ufs_cylinder_group));
 	pr_debug("  magic:        %x\n", fs32_to_cpu(sb, cg->cg_magic));
 	pr_debug("  time:         %u\n", fs32_to_cpu(sb, cg->cg_time));
-- 
2.27.0


No virus found
		Checked by Hillstone Network AntiVirus

