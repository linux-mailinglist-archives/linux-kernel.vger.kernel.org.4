Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38C6C6F90F0
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 11:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232018AbjEFJgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 05:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231961AbjEFJgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 05:36:15 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDCB79ECB;
        Sat,  6 May 2023 02:36:13 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 362C85C00A2;
        Sat,  6 May 2023 05:36:13 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sat, 06 May 2023 05:36:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1683365773; x=1683452173; bh=NNMPU2Iwo3E/oDPyGzoZDXLN88FMheBU22I
        UKmk/Qxw=; b=IwkeCaiTtdug92xe8O6UVmVESA16y/NUTar2UgYIYSw8d7I17mK
        Ll447AJ96QQAfTRFIzIGt0iVLq/J7NhOsdCo+/nT1Vadpn+WKB+MjjwecvIJRly8
        SFK5noC+jf8YmwFa+7wr6FJqZOr4VVED0ZN1TOBW8nq3XTjprDEOfUymysp4Z7Ij
        rLG1cfJpM+Sp8rgW773vE3rcjza9xZk9nuOJ/ez/s6KgvXlEIrq1WPXPnT2OJwzt
        w7Nj364f7Y4XLYS8xK1gz0mutcLrUtuKR/JZWCJe/Dz26i1xti0/swKMYh+TygSk
        2FThcDnUvBenNsAZtIHaeyQyImw/KLbGa3w==
X-ME-Sender: <xms:jB9WZLbZJsa6sS1uHrNxUOZ9QJ_hgo9mIs1VMN07ojTjlJ2GL6kJig>
    <xme:jB9WZKZS4hW_q6ZArx4VwjsFopzH3L6Ebq71rPCaMuBooIX7UI9AaJvGZKw3-y3St
    MBK8zMBhO4mmyd-nJo>
X-ME-Received: <xmr:jB9WZN-sBsSbq0sDrVivZ8qv9-UbU5wacs1_DCnXmdJXR_wqVpHTg72DTJjw92A9TwZRiQmHsQ6Y8e4bNs7vyXRbDsEmUjfa4eo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeffedgudegjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefvvefkjghfhffuffestddtredttddttdenucfhrhhomhephfhinhhnucfv
    hhgrihhnuceofhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgheqnecuggftrfgrth
    htvghrnhepheekudffheejvdeiveekleelgeffieduvdegleeuhfeuudegkeekheffkefg
    gfehnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehfthhhrghinheslhhinhhugidqmheikehk
    rdhorhhg
X-ME-Proxy: <xmx:jB9WZBphn3o7OoGavHDnBHhaVKL_2xcMxpTNuajjEnXk1J5ntsdFUQ>
    <xmx:jB9WZGp4VbOmAyDWijN87rP7h2T5aWi48Hc3L_Adc6sn4VDIKi7EgA>
    <xmx:jB9WZHQdMpQntbA1t8O2eHU6HGcpyjvRzpG4ndU9b9GVJGwuOZvHlQ>
    <xmx:jR9WZJU9LW5s2bTbAc_E5VZ-gQeVS6MXNf1KogBdF_6e4TGbuQ5W2g>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 6 May 2023 05:36:11 -0400 (EDT)
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     "Michael Schmitz" <schmitzmic@gmail.com>,
        "Andreas Schwab" <schwab@linux-m68k.org>, stable@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Message-Id: <9e66262a754fcba50208aa424188896cc52a1dd1.1683365892.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1683365892.git.fthain@linux-m68k.org>
References: <cover.1683365892.git.fthain@linux-m68k.org>
From:   Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH v1 1/1] m68k: Move signal frame following exception on
 68020/030
Date:   Sat, 06 May 2023 19:38:12 +1000
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 68030/020, an instruction such as, moveml %a2-%a3/%a5,%sp@- may cause
a stack page fault during instruction execution (i.e. not at an
instruction boundary) and produce a format 0xB exception frame.

In this situation, the value of USP will be unreliable. If a signal is to
be delivered following the exception, this USP value is used to calculate
the location for a signal frame. This can result in a corrupted user
stack.

The corruption was detected in dash (actually in glibc) where it showed
up as an intermittent "stack smashing detected" message and crash
following signal delivery for SIGCHLD.

It was hard to reproduce that failure because delivery of the signal
raced with the page fault and because the kernel places an unpredictable
gap of up to 7 bytes between the USP and the signal frame.

A format 0xB exception frame can be produced by a bus error or an address
error. The 68030 Users Manual says that address errors occur immediately
upon detection during instruction prefetch. The instruction pipeline
allows prefetch to overlap with other instructions, which means an
address error can arise during the execution of a different instruction.
So it seems likely that this patch may help in the address error case also.

Reported-and-tested-by: Stan Johnson <userm57@yahoo.com>
Link: https://lore.kernel.org/all/CAMuHMdW3yD22_ApemzW_6me3adq6A458u1_F0v-1EYwK_62jPA@mail.gmail.com/
Cc: Michael Schmitz <schmitzmic@gmail.com>
Cc: Andreas Schwab <schwab@linux-m68k.org>
Cc: stable@vger.kernel.org
Co-developed-by: Michael Schmitz <schmitzmic@gmail.com>
Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
This is the same patch that was posted previously. The commit log has
been revised and tags added.
---
 arch/m68k/kernel/signal.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/m68k/kernel/signal.c b/arch/m68k/kernel/signal.c
index b9f6908a31bc..8aeafbb083f7 100644
--- a/arch/m68k/kernel/signal.c
+++ b/arch/m68k/kernel/signal.c
@@ -858,11 +858,16 @@ static inline int rt_setup_ucontext(struct ucontext __user *uc, struct pt_regs *
 }
 
 static inline void __user *
-get_sigframe(struct ksignal *ksig, size_t frame_size)
+get_sigframe(struct ksignal *ksig, struct pt_regs *tregs, size_t frame_size)
 {
 	unsigned long usp = sigsp(rdusp(), ksig);
+	unsigned long gap = 0;
 
-	return (void __user *)((usp - frame_size) & -8UL);
+	if (CPU_IS_020_OR_030 && tregs->format == 0xb)
+		/* USP is unreliable so use worst-case value */
+		gap = 256;
+
+	return (void __user *)((usp - gap - frame_size) & -8UL);
 }
 
 static int setup_frame(struct ksignal *ksig, sigset_t *set,
@@ -880,7 +885,7 @@ static int setup_frame(struct ksignal *ksig, sigset_t *set,
 		return -EFAULT;
 	}
 
-	frame = get_sigframe(ksig, sizeof(*frame) + fsize);
+	frame = get_sigframe(ksig, tregs, sizeof(*frame) + fsize);
 
 	if (fsize)
 		err |= copy_to_user (frame + 1, regs + 1, fsize);
@@ -952,7 +957,7 @@ static int setup_rt_frame(struct ksignal *ksig, sigset_t *set,
 		return -EFAULT;
 	}
 
-	frame = get_sigframe(ksig, sizeof(*frame));
+	frame = get_sigframe(ksig, tregs, sizeof(*frame));
 
 	if (fsize)
 		err |= copy_to_user (&frame->uc.uc_extra, regs + 1, fsize);
-- 
2.37.5

