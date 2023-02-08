Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5414868ECAC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 11:19:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbjBHKTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 05:19:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbjBHKSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 05:18:49 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 103AA42DDE
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 02:18:17 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id v18-20020a17090ae99200b00230f079dcd9so3156875pjy.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 02:18:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eGdDoS4Ih3Tm5U0bLO+WZaZect02AOAohgwE+xzoAvA=;
        b=Ngk24v3RNJEahx30zOXr7umBMNpg//DjSZ/beFNtkh/DKk+gKdJ6boLUFVFRAPRVvt
         Pal3vXCSrjF2fwh9HTV6wTr1au9tiUzGIGOWrAy4TXmnPOnOFbiW+qQkfirLAHi/+UCu
         r99MxqOZMe9PIzpw9tjmH5Yi3Cgh7SWmQeqW+8PvmqR/spkGeTlBbDdsV2Jfh6wntVP7
         2iR1EMDwfXZPApUyEpkFl259XlrJSx6cuTIil70oKxBgKNxPhkvAzoKFsUysgCRHB32v
         ajLTXhS90uNmZSJ32cDYhSae6aJhGIKOLbNxv/uHOMPHWFJ/530L2NKi8ZmESoHj+Qa6
         g8qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eGdDoS4Ih3Tm5U0bLO+WZaZect02AOAohgwE+xzoAvA=;
        b=LfLGNOl81+V/oQUGtHvgeKhgLBtmAXO6nq3gyAC1S1iDxDoySf0Baz7OwpK2x6Ztst
         WI0RYyHosh2GB5bpbctCEPsh4LUTIp2mGM1VVEwp+f7vXzMqCxaKTe+BfCJsZMoiitjv
         4L4+ZTuxCmUmGEU14gOkAUQKQWMKKDmvOn033N2dejI+bIFehQEC/53o3OXgny90mwzW
         64lA+ITrasHN8Crz10eQ8LwQL3hs0lcfzpLTe/h9UtQzPvO1yTo9FFUbz4QA+AOXzEba
         iSgaZFasdZcclqgkxrVLVyuB+UXScbB3U2ckqzvTLDQs8dR+Ix1PnNlkTbwMS81zJM64
         jK0Q==
X-Gm-Message-State: AO0yUKV+8Uja0xo1Dn2a/Mrr7X3MRZV8ZLqETC5mpCa+bzfhBvrF8qlo
        +6rrjQTTDBzHgeqTggO1Lpw=
X-Google-Smtp-Source: AK7set8V1QYaE1EGsxPbUb15bdPNIpk58Ue4idMWqEVdiQYiu7RIS9PstAklRxujvuG9ODvWYrXb3Q==
X-Received: by 2002:a17:902:ec92:b0:199:527d:42c3 with SMTP id x18-20020a170902ec9200b00199527d42c3mr87899plg.24.1675851495012;
        Wed, 08 Feb 2023 02:18:15 -0800 (PST)
Received: from localhost.localdomain ([112.20.108.204])
        by smtp.gmail.com with ESMTPSA id v23-20020a1709028d9700b0019926c7757asm3991058plo.289.2023.02.08.02.18.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 08 Feb 2023 02:18:14 -0800 (PST)
From:   chris.chenfeiyang@gmail.com
X-Google-Original-From: chenfeiyang@loongson.cn
To:     w@1wt.eu, paulmck@kernel.org
Cc:     Feiyang Chen <chenfeiyang@loongson.cn>, arnd@arndb.de,
        chenhuacai@kernel.org, jiaxun.yang@flygoat.com,
        chris.chenfeiyang@gmail.com, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] tools/nolibc: Add statx() and make stat() rely on statx() when available
Date:   Wed,  8 Feb 2023 18:17:51 +0800
Message-Id: <b9bbf73286238bb4657d855c9d50983aa17953e2.1675851111.git.chenfeiyang@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1675851111.git.chenfeiyang@loongson.cn>
References: <cover.1675851111.git.chenfeiyang@loongson.cn>
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

From: Feiyang Chen <chenfeiyang@loongson.cn>

loongarch and riscv32 only have statx(). arc, hexagon, nios2 and
openrisc have statx() and stat64() but not stat() or newstat().
Add statx() and make stat() rely on statx() to make them happy.

Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
---
 tools/include/nolibc/sys.h | 51 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index c4818a9c8823..46b6b3bb3b4e 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -20,6 +20,7 @@
 #include <linux/time.h>
 #include <linux/auxvec.h>
 #include <linux/fcntl.h> // for O_* and AT_*
+#include <linux/stat.h>  // for statx()
 
 #include "arch.h"
 #include "errno.h"
@@ -1048,12 +1049,61 @@ pid_t setsid(void)
 	return ret;
 }
 
+/*
+ * int statx(int fd, const char *path, int flags, unsigned int mask, struct statx *buf);
+ */
+
+static __attribute__((unused))
+int sys_statx(int fd, const char *path, int flags, unsigned int mask, struct statx *buf)
+{
+	return my_syscall5(__NR_statx, fd, path, flags, mask, buf);
+}
+
+static __attribute__((unused))
+int statx(int fd, const char *path, int flags, unsigned int mask, struct statx *buf)
+{
+	int ret = sys_statx(fd, path, flags, mask, buf);
+
+	if (ret < 0) {
+		SET_ERRNO(-ret);
+		ret = -1;
+	}
+	return ret;
+}
 
 /*
  * int stat(const char *path, struct stat *buf);
  * Warning: the struct stat's layout is arch-dependent.
  */
 
+#ifdef __NR_statx
+static __attribute__((unused))
+int sys_stat(const char *path, struct stat *buf)
+{
+	struct statx stat;
+	long ret;
+
+	ret = sys_statx(AT_FDCWD, path, AT_NO_AUTOMOUNT, STATX_BASIC_STATS, &stat);
+	buf->st_dev     = ((stat.stx_dev_minor & 0xff)
+			  | (stat.stx_dev_major << 8)
+			  | ((stat.stx_dev_minor & ~0xff) << 12));
+	buf->st_ino     = stat.stx_ino;
+	buf->st_mode    = stat.stx_mode;
+	buf->st_nlink   = stat.stx_nlink;
+	buf->st_uid     = stat.stx_uid;
+	buf->st_gid     = stat.stx_gid;
+	buf->st_rdev    = ((stat.stx_rdev_minor & 0xff)
+			  | (stat.stx_rdev_major << 8)
+			  | ((stat.stx_rdev_minor & ~0xff) << 12));
+	buf->st_size    = stat.stx_size;
+	buf->st_blksize = stat.stx_blksize;
+	buf->st_blocks  = stat.stx_blocks;
+	buf->st_atime   = stat.stx_atime.tv_sec;
+	buf->st_mtime   = stat.stx_mtime.tv_sec;
+	buf->st_ctime   = stat.stx_ctime.tv_sec;
+	return ret;
+}
+#else
 static __attribute__((unused))
 int sys_stat(const char *path, struct stat *buf)
 {
@@ -1083,6 +1133,7 @@ int sys_stat(const char *path, struct stat *buf)
 	buf->st_ctime   = stat.st_ctime;
 	return ret;
 }
+#endif /* __NR_statx */
 
 static __attribute__((unused))
 int stat(const char *path, struct stat *buf)
-- 
2.39.0

