Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B272C628484
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 17:02:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237124AbiKNQCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 11:02:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235591AbiKNQC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 11:02:27 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B278DFCEA
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 08:02:25 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 20E475C0178;
        Mon, 14 Nov 2022 11:02:25 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 14 Nov 2022 11:02:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1668441745; x=1668528145; bh=Ef
        P3qqKn1NfZJz+8A+1j/0uKoh3sMGCvWBbmH1HbEgk=; b=M+izC1dmfZV925VPnD
        qiFKXMzWsptAvDrE1l9NNr5JVutaar2D5tXFh4VG8+QcS+wZrJzvDMuU+QVvLrUF
        StobNQmYmP17CSgHo+wr832jEwplWECiYskytottUvVZei3BCnd2t/JQtUQ4JiuL
        DQR/n2EbpQl2L5PBJWa/kRKROKaPx4jdWAEmzZ/C8UpGO5OP1Mh3zSO8VL81IfCH
        9FOdvOQgzOEwmBr9R40Wc7PyRXtldPVLNHzI8i/8v55le6B7g8yUuOFvcECxSmUH
        CQyKoRUES8j14He3OQX+Pih0NuV8JSFnouwQfUisiOrwhiD6SrlApdWHuHw7lB5H
        YIYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1668441745; x=1668528145; bh=EfP3qqKn1NfZJ
        z+8A+1j/0uKoh3sMGCvWBbmH1HbEgk=; b=Kwc0XwtPGNHQNahWCE767Qq2Y2hVu
        P5uhHGzttvHcFDGuOVFHBJVg9YwvMJbScM3WrG/q0Pld9t+UWlfuQJo1uRakMKSj
        6Qf86fVK7zktPGWyN64jn4iyTIt27Bn4kThRYCGDIef1MgYrLcc7srtqSnwtrfUn
        5qQ5+yAE8s80Yo0wOidsveM2e5oTNshvE9Ivqt855uWEa5LS8/ofOMxXD7sNFe15
        Fa6MRVxTmCnJcBEjyozSebdFS8LWR25+BC+PrmivmoPhbZwkrY7crB51485rqF2A
        q3+kWWjIEaNfnojPypsfmZkf1JLK7HJZBGq2MP2ikbNQp/MUFpXcGhiLQ==
X-ME-Sender: <xms:kGZyYwtcjUJ2xvzyt6SJ70OGu8IcKCPOv7WYvc5I9u_PobdEiNey8g>
    <xme:kGZyY9cu_AJFzYiGL5SBBtIwuMvvbz_7eOV2WKEzall-fT6N3l-kw2wst844AvLNG
    zZNpp2xady4kuOvADE>
X-ME-Received: <xmr:kGZyY7xzCW8JWnHdjRMPye_9LKTwc7HHoedIWxBgmHKc_AojT07FhnjOuI2biEsKu7KO8Huh>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrgedvgdehiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefvhigthhho
    ucetnhguvghrshgvnhcuoehthigthhhosehthigthhhordhpihiiiigrqeenucggtffrrg
    htthgvrhhnpefhvefhvddvffeufffgffejheelffeffeffueehgeevvdeggfeufeekudei
    kefgleenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepthihtghhohesthihtghhohdrphhiiiii
    rg
X-ME-Proxy: <xmx:kGZyYzObNMOzfGg_0dQKYAaa-6nWQCr8r2-lj_pha8bS2pHkAPT2DQ>
    <xmx:kGZyYw-rHeoI1fqJF2Y_PNlC1XLlg_RJvXAuYC11hcYRc1cCBduV-g>
    <xmx:kGZyY7XrC4tq3GnlfVXGqdWOjUeOVQpvw6L_gM2yWq33iATzehFoLg>
    <xmx:kWZyY0ZW-jcO8xxT7mZnmuL9aiX8RHWmC6Rsph996mweeGsJg6V2eQ>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Nov 2022 11:02:23 -0500 (EST)
From:   Tycho Andersen <tycho@tycho.pizza>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Eric Biederman <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, fuse-devel@lists.sourceforge.net,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Tycho Andersen <tycho@tycho.pizza>
Subject: [PATCH v3] fuse: In fuse_flush only wait if someone wants the return code
Date:   Mon, 14 Nov 2022 09:02:09 -0700
Message-Id: <20221114160209.1229849-1-tycho@tycho.pizza>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAJfpegvrd2nsydG26stcmeEkdO1JLyeu69KrZs4dvVxXtoz42Q@mail.gmail.com>
References: <CAJfpegvrd2nsydG26stcmeEkdO1JLyeu69KrZs4dvVxXtoz42Q@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a fuse filesystem is mounted inside a container, there is a problem
during pid namespace destruction. The scenario is:

1. task (a thread in the fuse server, with a fuse file open) starts
   exiting, does exit_signals(), goes into fuse_flush() -> wait
2. fuse daemon gets killed, tries to wake everyone up
3. task from 1 is stuck because complete_signal() doesn't wake it up, since
   it has PF_EXITING.

The result is that the thread will never be woken up, and pid namespace
destruction will block indefinitely.

To add insult to injury, nobody is waiting for these return codes, since
the pid namespace is being destroyed.

To fix this, let's not block on flush operations when the current task has
PF_EXITING.

This does change the semantics slightly: the wait here is for posix locks
to be unlocked, so the task will exit before things are unlocked. To quote
Miklos: https://lore.kernel.org/all/CAJfpegsTmiO-sKaBLgoVT4WxDXBkRES=HF1YmQN1ES7gfJEJ+w@mail.gmail.com/

> "remote" posix locks are almost never used due to problems like this,
> so I think it's safe to do this.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
Signed-off-by: Tycho Andersen <tycho@tycho.pizza>
Link: https://lore.kernel.org/all/YrShFXRLtRt6T%2Fj+@risky/
---
v2: drop the fuse_flush_async() function and just re-use the already
    prepared args; add a description of the problem+note about posix locks
v3: use schedule_work() to avoid other sleeps in inode_write_now() and
    fuse_sync_writes(). Fix a UAF of the stack-based inarg.
---
 fs/fuse/file.c | 106 +++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 84 insertions(+), 22 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 71bfb663aac5..10173b0e74b7 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -18,6 +18,7 @@
 #include <linux/falloc.h>
 #include <linux/uio.h>
 #include <linux/fs.h>
+#include <linux/file.h>
 
 static int fuse_send_open(struct fuse_mount *fm, u64 nodeid,
 			  unsigned int open_flags, int opcode,
@@ -477,20 +478,20 @@ static void fuse_sync_writes(struct inode *inode)
 	fuse_release_nowrite(inode);
 }
 
-static int fuse_flush(struct file *file, fl_owner_t id)
+static void fuse_invalidate_attrs(struct fuse_mount *fm, int err, struct inode *inode)
 {
-	struct inode *inode = file_inode(file);
-	struct fuse_mount *fm = get_fuse_mount(inode);
-	struct fuse_file *ff = file->private_data;
-	struct fuse_flush_in inarg;
-	FUSE_ARGS(args);
-	int err;
-
-	if (fuse_is_bad(inode))
-		return -EIO;
+	/*
+	 * In memory i_blocks is not maintained by fuse, if writeback cache is
+	 * enabled, i_blocks from cached attr may not be accurate.
+	 */
+	if (!err && fm->fc->writeback_cache)
+		fuse_invalidate_attr_mask(inode, STATX_BLOCKS);
+}
 
-	if (ff->open_flags & FOPEN_NOFLUSH && !fm->fc->writeback_cache)
-		return 0;
+static int do_fuse_flush(struct fuse_mount *fm, struct inode *inode,
+			 struct file *file, struct fuse_args *args)
+{
+	int err;
 
 	err = write_inode_now(inode, 1);
 	if (err)
@@ -504,6 +505,53 @@ static int fuse_flush(struct file *file, fl_owner_t id)
 	if (err)
 		return err;
 
+	err = fuse_simple_request(fm, args);
+	if (err == -ENOSYS) {
+		fm->fc->no_flush = 1;
+		err = 0;
+	}
+
+	return err;
+}
+
+struct fuse_flush_args {
+	struct fuse_args args;
+	struct fuse_flush_in inarg;
+	struct inode *inode;
+	struct fuse_file *ff;
+	struct work_struct work;
+	struct file *file;
+};
+
+static void fuse_flush_async(struct work_struct *work)
+{
+	struct fuse_flush_args *fa = container_of(work, typeof(*fa), work);
+	struct fuse_mount *fm = get_fuse_mount(fa->inode);
+	int err;
+
+	err = do_fuse_flush(fm, fa->inode, fa->file, &fa->args);
+	if (err < 0)
+		fuse_invalidate_attrs(fm, err, fa->inode);
+	fuse_file_put(fa->ff, false, false);
+	fput(fa->file);
+	kfree(fa);
+}
+
+static int fuse_flush(struct file *file, fl_owner_t id)
+{
+	struct inode *inode = file_inode(file);
+	struct fuse_mount *fm = get_fuse_mount(inode);
+	struct fuse_file *ff = file->private_data;
+	struct fuse_flush_in inarg;
+	FUSE_ARGS(args);
+	int err;
+
+	if (fuse_is_bad(inode))
+		return -EIO;
+
+	if (ff->open_flags & FOPEN_NOFLUSH && !fm->fc->writeback_cache)
+		return 0;
+
 	err = 0;
 	if (fm->fc->no_flush)
 		goto inval_attr_out;
@@ -518,19 +566,33 @@ static int fuse_flush(struct file *file, fl_owner_t id)
 	args.in_args[0].value = &inarg;
 	args.force = true;
 
-	err = fuse_simple_request(fm, &args);
-	if (err == -ENOSYS) {
-		fm->fc->no_flush = 1;
-		err = 0;
+	if (current->flags & PF_EXITING) {
+		struct fuse_flush_args *fa;
+
+		err = -ENOMEM;
+		fa = kzalloc(sizeof(*fa), GFP_KERNEL);
+		if (!fa)
+			goto inval_attr_out;
+
+		memcpy(&fa->args, &args, sizeof(args));
+		memcpy(&fa->inarg, &inarg, sizeof(inarg));
+		fa->args.in_args[0].value = &fa->inarg;
+		fa->args.nocreds = true;
+		fa->ff = fuse_file_get(ff);
+		fa->inode = inode;
+		fa->file = get_file(file);
+
+		INIT_WORK(&fa->work, fuse_flush_async);
+		schedule_work(&fa->work);
+		return 0;
 	}
 
+	err = do_fuse_flush(fm, inode, file, &args);
+	if (!err)
+		return 0;
+
 inval_attr_out:
-	/*
-	 * In memory i_blocks is not maintained by fuse, if writeback cache is
-	 * enabled, i_blocks from cached attr may not be accurate.
-	 */
-	if (!err && fm->fc->writeback_cache)
-		fuse_invalidate_attr_mask(inode, STATX_BLOCKS);
+	fuse_invalidate_attrs(fm, err, inode);
 	return err;
 }
 

base-commit: f0c4d9fc9cc9462659728d168387191387e903cc
-- 
2.34.1

