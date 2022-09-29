Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5320F5EFB15
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 18:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235782AbiI2QkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 12:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235866AbiI2QkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 12:40:14 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 695412AE0F
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 09:40:11 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 05EF63200926;
        Thu, 29 Sep 2022 12:40:09 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 29 Sep 2022 12:40:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1664469609; x=1664556009; bh=Ee
        I5ZyqSWevp3ALbdw0H7PBzG6BJRTt+WN9M56QhsbY=; b=VAfprg9OniIkrEbZkD
        OIIOg8dtbhBFwd5Mb38ArJimU0q+562wIykbE7oqmG4xbhoZA7qRNsrtOfDCXHVQ
        46ZINhZnbS7QZ3Fsq3nh9ALkCeEq/4ow7TFpsxV9NI1rTpxMNEKZhxqWLrbVOm+n
        pQDpMgJ9da85n7nKMNzyFGodZXN+8Mm0L1rKxW5314DnlH5jIKz3r2/XJY5FCj0V
        HF6WooEI2Umy2hLjdsBBLekumZlvbOeXxrKGf3OwEEEAtO09tMaS1y6mRmNmtbwW
        UKVsRKrILs6WNq34nmwWeevkmjMUXYyMoeazvhDF0yJdMJQ71HgqyN7hMwILYcY5
        z86g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1664469609; x=1664556009; bh=EeI5ZyqSWevp3
        ALbdw0H7PBzG6BJRTt+WN9M56QhsbY=; b=BMSADXNsQkqfQGff2vFd6w8v2iIQK
        q/RAy+ESRe6KuTyPN9sURbIOV/f6l6ztGbisRu7EISacujpVXxGNRZkpE+HiLaIn
        ImomfIKv5rQJOywa6cBi12ODKp+yklKjz4g2YHyRhjDRA1Ujj37Q/htjElkwKBOE
        +oYwCzEy5nEUuF/tNisuHSxWyngEbtrc0Yc7LE5ChjTPV/l0RyuvQVes++sBeMaY
        skl9DXm+gzuUVBWwT/SdksdG8YoeF0qvCkYlfEYyv6Fjhtaxkw8QpuoTOeO9DDtB
        2x3Iq8W2q2XVDMhmK7yZzBlYqFQa9LniPxnHYN8itz9KeAu5qCXLoJe6A==
X-ME-Sender: <xms:aMo1Y-w-acwpn67_zpJWqW7x1Nhk6TC7s0F4WulPE2wQMfaChjdWYg>
    <xme:aMo1Y6Tu3YhcvEbaDNO1HXmxFrecYPSq66PEvhEnSZooJU4WjSOnrU6gZ63Fo-9ht
    O63HSnw-2K2wA0K1yk>
X-ME-Received: <xmr:aMo1YwVMdtnUoPAjrcjNqjmDtVk5X35COOl_sy8gtF0V05l67KoCg-cI_Wxzz9Ksw2HmwS7z>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeehtddguddthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefvhigt
    hhhoucetnhguvghrshgvnhcuoehthigthhhosehthigthhhordhpihiiiigrqeenucggtf
    frrghtthgvrhhnpefhvefhvddvffeufffgffejheelffeffeffueehgeevvdeggfeufeek
    udeikefgleenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepthihtghhohesthihtghhohdrphhi
    iiiirg
X-ME-Proxy: <xmx:aMo1Y0hIKo-RvAHkeofWbcf1qnfKQ9UlO1qeMe2PU7a99eK-JaPe6w>
    <xmx:aMo1YwA7lUANrPeLtTzsQdyIkQLUMHPnfBzI6rtToB7OQTAQuH8AIg>
    <xmx:aMo1Y1K7cncWJfd74VLDOwFDzaDgaven_BvC1VQOM7kbd4yp3br8aw>
    <xmx:aco1Yz8Mg06d4AExTEaV4XxChgkCl_iNPTf4NqQHNPKZpQ30G7gbzg>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Sep 2022 12:40:07 -0400 (EDT)
From:   Tycho Andersen <tycho@tycho.pizza>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Eric Biederman <ebiederm@xmission.com>,
        "Serge E. Hallyn" <serge@hallyn.com>, linux-kernel@vger.kernel.org,
        fuse-devel@lists.sourceforge.net,
        Tycho Andersen <tycho@tycho.pizza>
Subject: [PATCH v2] fuse: In fuse_flush only wait if someone wants the return code
Date:   Thu, 29 Sep 2022 10:39:44 -0600
Message-Id: <20220929163944.195913-1-tycho@tycho.pizza>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAJfpegswSAeUdxHR1Z8jC_nQtUm7_mD=ZZC_LyQczaoJWTPe3g@mail.gmail.com>
References: <CAJfpegswSAeUdxHR1Z8jC_nQtUm7_mD=ZZC_LyQczaoJWTPe3g@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
---
 fs/fuse/file.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 05caa2b9272e..20bbe3e1afc7 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -464,6 +464,34 @@ static void fuse_sync_writes(struct inode *inode)
 	fuse_release_nowrite(inode);
 }
 
+struct fuse_flush_args {
+	struct fuse_args args;
+	struct fuse_flush_in inarg;
+	struct inode *inode;
+	struct fuse_file *ff;
+};
+
+static void fuse_flush_end(struct fuse_mount *fm, struct fuse_args *args, int err)
+{
+	struct fuse_flush_args *fa = container_of(args, typeof(*fa), args);
+
+	if (err == -ENOSYS) {
+		fm->fc->no_flush = 1;
+		err = 0;
+	}
+
+	/*
+	 * In memory i_blocks is not maintained by fuse, if writeback cache is
+	 * enabled, i_blocks from cached attr may not be accurate.
+	 */
+	if (!err && fm->fc->writeback_cache)
+		fuse_invalidate_attr_mask(fa->inode, STATX_BLOCKS);
+
+
+	fuse_file_put(fa->ff, false, false);
+	kfree(fa);
+}
+
 static int fuse_flush(struct file *file, fl_owner_t id)
 {
 	struct inode *inode = file_inode(file);
@@ -505,6 +533,28 @@ static int fuse_flush(struct file *file, fl_owner_t id)
 	args.in_args[0].value = &inarg;
 	args.force = true;
 
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
+		fa->args.nocreds = true;
+		fa->args.end = fuse_flush_end;
+		fa->ff = fuse_file_get(ff);
+		fa->inode = inode;
+
+		err = fuse_simple_background(fm, &fa->args, GFP_KERNEL);
+		if (err)
+			fuse_flush_end(fm, &fa->args, err);
+
+		return err;
+	}
+
 	err = fuse_simple_request(fm, &args);
 	if (err == -ENOSYS) {
 		fm->fc->no_flush = 1;

base-commit: 3d7cb6b04c3f3115719235cc6866b10326de34cd
-- 
2.34.1

