Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 989026B58F8
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 07:34:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjCKGee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 01:34:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjCKGeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 01:34:31 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F94E1FF3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 22:34:30 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id x3so29145534edb.10
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 22:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678516469;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=30swHnKIN+jIFvRvtkwwf91dt5wPLQTt2b8IT3CLZQU=;
        b=kG1dWIaq6ffBsaLcL7TH6rxOfBoF4IsAAAkbKbFc6NQD38+2A1zQymOLWKZ72bZHJY
         6yM9Kgc7MHHPWAoZlFcc/Yrt4DPgsXwukJ/Jep8hyKCwObeCPYHm6CsSDheUfV+q8C27
         NhhE65P7iSmmwSJnrieiiPTDyCTrVbqFVB+ooLen3VZ9QpRki2hNZSYskZeLo8Ak6ZtT
         vNQVUafhd7eDTAd9F3I+pklVKMClH/atScGnzITyr3aFyWtsKEIDH0Iv4jLjtUWY5GT3
         t2rwlZ9Mrw8xOQDmJ54xQmPnrUkh7GTNw5o39O0PlvdQPl0OiBxQy8tsFOqW7cfFuBoH
         N8yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678516469;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=30swHnKIN+jIFvRvtkwwf91dt5wPLQTt2b8IT3CLZQU=;
        b=W3Ex6ZnzNosGEH1XiLtYaIREHYa+WagqjRzoi5ov/a/lWu1HnO+t4HULt83pYgxiQw
         q9Ok8wOchvcUoADK0cEu2O+HCMy0mfcb72+Wln+15GhobI85oLESqGR1kAiP7zmaUkvL
         iTRz/QRqGemAGceByztY/SzjmTB/18w3jWsKAb7TqMFh2q9phT5oV+4H6ma6eD9QBg6e
         xwrOkDoVJMndR46nM8VC+uVPG7jkH10gSECogmbSB24PIuh5yeqSMCNw/PiPl0V4ENkS
         GvugsWYqOZ5ACMUO7ukEy9YwvmmMSY+zsqu5lE/I15JxnLTxb9WoiX1HssNQvd+5v3bR
         xXQQ==
X-Gm-Message-State: AO0yUKVQyCIY5Uq3yuM+WFTBFT43ZwKXyJg9j0KjD0iQpEMrjzi7xAbG
        of7tH0nijVWxTb9CX1c46aU=
X-Google-Smtp-Source: AK7set9Cdn36F612qHzIDj2VO6b1Y3SmxJhRAR1oSJh26tUfrkCWCdgjoNjerHoLPAoP6FloxC/rUQ==
X-Received: by 2002:a17:906:1097:b0:8b1:4141:8a30 with SMTP id u23-20020a170906109700b008b141418a30mr4923013eju.6.1678516468713;
        Fri, 10 Mar 2023 22:34:28 -0800 (PST)
Received: from ivan-HLYL-WXX9.. ([37.252.81.68])
        by smtp.gmail.com with ESMTPSA id sg42-20020a170907a42a00b009202ce3c8adsm493368ejc.27.2023.03.10.22.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 22:34:28 -0800 (PST)
From:   Ivan Orlov <ivan.orlov0322@gmail.com>
To:     ericvh@gmail.com, lucho@ionkov.net, asmadeus@codewreck.org,
        linux_oss@crudebyte.com
Cc:     Ivan Orlov <ivan.orlov0322@gmail.com>,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, himadrispandya@gmail.com,
        syzbot+cb1d16facb3cc90de5fb@syzkaller.appspotmail.com
Subject: [PATCH v2] 9P FS: Fix wild-memory-access write in v9fs_get_acl
Date:   Sat, 11 Mar 2023 10:34:11 +0400
Message-Id: <20230311063411.7884-1-ivan.orlov0322@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KASAN reported the following issue:
[   36.825817][ T5923] BUG: KASAN: wild-memory-access in v9fs_get_acl+0x1a4/0x390
[   36.827479][ T5923] Write of size 4 at addr 9fffeb37f97f1c00 by task syz-executor798/5923
[   36.829303][ T5923]
[   36.829846][ T5923] CPU: 0 PID: 5923 Comm: syz-executor798 Not tainted 6.2.0-syzkaller-18302-g596b6b709632 #0
[   36.832110][ T5923] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/21/2023
[   36.834464][ T5923] Call trace:
[   36.835196][ T5923]  dump_backtrace+0x1c8/0x1f4
[   36.836229][ T5923]  show_stack+0x2c/0x3c
[   36.837100][ T5923]  dump_stack_lvl+0xd0/0x124
[   36.838103][ T5923]  print_report+0xe4/0x4c0
[   36.839068][ T5923]  kasan_report+0xd4/0x130
[   36.840052][ T5923]  kasan_check_range+0x264/0x2a4
[   36.841199][ T5923]  __kasan_check_write+0x2c/0x3c
[   36.842216][ T5923]  v9fs_get_acl+0x1a4/0x390
[   36.843232][ T5923]  v9fs_mount+0x77c/0xa5c
[   36.844163][ T5923]  legacy_get_tree+0xd4/0x16c
[   36.845173][ T5923]  vfs_get_tree+0x90/0x274
[   36.846137][ T5923]  do_new_mount+0x25c/0x8c8
[   36.847066][ T5923]  path_mount+0x590/0xe58
[   36.848147][ T5923]  __arm64_sys_mount+0x45c/0x594
[   36.849273][ T5923]  invoke_syscall+0x98/0x2c0
[   36.850421][ T5923]  el0_svc_common+0x138/0x258
[   36.851397][ T5923]  do_el0_svc+0x64/0x198
[   36.852398][ T5923]  el0_svc+0x58/0x168
[   36.853224][ T5923]  el0t_64_sync_handler+0x84/0xf0
[   36.854293][ T5923]  el0t_64_sync+0x190/0x194

Calling '__v9fs_get_acl' method in 'v9fs_get_acl' creates the
following chain of function calls:

__v9fs_get_acl
	v9fs_fid_get_acl
		v9fs_fid_xattr_get
			p9_client_xattrwalk

Function p9_client_xattrwalk accepts a pointer to u64-typed
variable attr_size and puts some u64 value into it. However,
after the executing the p9_client_xattrwalk, in some circumstances
we assign the value of u64-typed variable 'attr_size' to the
variable 'retval', which we will return. However, the type of
'retval' is ssize_t, and if the value of attr_size is larger
than SSIZE_MAX, we will face the signed type overflow. If the
overflow occurs, the result of v9fs_fid_xattr_get may be
negative, but not classified as an error. When we try to allocate
an acl with 'broken' size we receive an error, but don't process
it. When we try to free this acl, we face the 'wild-memory-access'
error (because it wasn't allocated).

This patch will add new condition to the 'v9fs_fid_xattr_get'
function, so it will return an EOVERFLOW error if the 'attr_size'
is larger than SSIZE_MAX.

In this version of the patch I removed explicit type conversion and
added separate condition to check the possible overflow and return
an error (in v1 version I've just modified the existing condition).

Reported-by: syzbot+cb1d16facb3cc90de5fb@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?id=fbbef66d9e4d096242f3617de5d14d12705b4659
Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
---
 fs/9p/xattr.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/9p/xattr.c b/fs/9p/xattr.c
index 50f7f3f6b55e..6affd6b3f5e6 100644
--- a/fs/9p/xattr.c
+++ b/fs/9p/xattr.c
@@ -35,10 +35,14 @@ ssize_t v9fs_fid_xattr_get(struct p9_fid *fid, const char *name,
 		return retval;
 	}
 	if (attr_size > buffer_size) {
-		if (!buffer_size) /* request to get the attr_size */
-			retval = attr_size;
-		else
+		if (!buffer_size) {/* request to get the attr_size */
+			if (attr_size > SSIZE_MAX)
+				retval = -EOVERFLOW;
+			else
+				retval = attr_size;
+		} else {
 			retval = -ERANGE;
+		}
 	} else {
 		iov_iter_truncate(&to, attr_size);
 		retval = p9_client_read(attr_fid, 0, &to, &err);
-- 
2.34.1

