Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0C445BC168
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 04:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbiISCe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 22:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbiISCeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 22:34:24 -0400
Received: from mail-m972.mail.163.com (mail-m972.mail.163.com [123.126.97.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EB542140BA
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 19:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=YoMJE
        y+9rOUOA5Azl9cO7NVgPzkqtCIeA2OfdQKcG9I=; b=mq8SJsPAx53BsHC20sJm2
        zFkYgmzAGC0SEKXK0UpTI+uurKDYdYlolRBPkA0quZcNArQNCXT11FW3Rmqu8A5O
        EKNziBKySYVNlBSVXdefPKARwVOY/xW0Z5s176JBe2M6Q4Z+KH0KlLwcJ5l7LRT9
        nYXbO840JHGdBmmON0BAkU=
Received: from localhost.localdomain (unknown [116.128.244.169])
        by smtp2 (Coremail) with SMTP id GtxpCgA3uuz_1CdjBWoWew--.14210S2;
        Mon, 19 Sep 2022 10:33:36 +0800 (CST)
From:   Jiangshan Yi <13667453960@163.com>
To:     akpm@linux-foundation.org, viro@zeniv.linux.org.uk
Cc:     willy@infradead.org, linux-kernel@vger.kernel.org,
        Jiangshan Yi <yijiangshan@kylinos.cn>
Subject: [PATCH] fs/efs/inode.c: use __func__ instead of function name
Date:   Mon, 19 Sep 2022 10:33:14 +0800
Message-Id: <20220919023314.3622391-1-13667453960@163.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GtxpCgA3uuz_1CdjBWoWew--.14210S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7JryDWF4kWry8tFW7XFWrXwb_yoWfXwc_W3
        WIywn5Ga12vw4rZrs7Ca1YqF1vka1DKay7JF43Ar13u3y5Xa1DXF4Dtr1Ikrs8ur40qFsx
        ur4vyas7tr9FgjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8jg43UUUUU==
X-Originating-IP: [116.128.244.169]
X-CM-SenderInfo: bprtllyxuvjmiwq6il2tof0z/1tbivgCB+1ZceuzkxAAAs4
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
 fs/efs/inode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/efs/inode.c b/fs/efs/inode.c
index 3ba94bb005a6..ba15c7d66adc 100644
--- a/fs/efs/inode.c
+++ b/fs/efs/inode.c
@@ -141,8 +141,8 @@ struct inode *efs_iget(struct super_block *super, unsigned long ino)
 	}
 
 	brelse(bh);
-	pr_debug("efs_iget(): inode %lu, extents %d, mode %o\n",
-		 inode->i_ino, in->numextents, inode->i_mode);
+	pr_debug("%s(): inode %lu, extents %d, mode %o\n",
+		 __func__, inode->i_ino, in->numextents, inode->i_mode);
 	switch (inode->i_mode & S_IFMT) {
 		case S_IFDIR: 
 			inode->i_op = &efs_dir_inode_operations; 
-- 
2.27.0


No virus found
		Checked by Hillstone Network AntiVirus

