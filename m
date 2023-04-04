Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 318A66D5852
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 08:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233558AbjDDGAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 02:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233184AbjDDGA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 02:00:29 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 455711992
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 23:00:27 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id B8082320096F;
        Tue,  4 Apr 2023 02:00:25 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 04 Apr 2023 02:00:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        joshtriplett.org; h=cc:content-type:content-type:date:date:from
        :from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1680588025; x=1680674425; bh=Lr
        TlRnC1PMOEduoHyaDrJIwpQILB4R4Y2q12p1O1Lq4=; b=TVQd44oYV/EGE32s1j
        U2FtduT+QMuANL8y4onAgbmKKMM/FqVE0EImoq9XSjzYsMgl97KwCFjN1tNKNNig
        cWqI/KOygYxL3q5YAkffb9TL6FDpM58aLSeCiQAW8j2YeDeN/4pD8dZev1OvueCu
        6z6eQH9PdG19ABcWHXZNVhvqRl6NN3bRJsO6GCKXq61Hw0t0f+fqg0BWaOmCjhNf
        TWiNCElsY/dZsI91vE8Fe0rBnANoYdv2EQxoWMUWUtnoT+g2kDNTDtyoJN3TWuXg
        BlanORl+lotAHUArBd/stRjGPHRBLFpEme6U4xP9nqlb35GkYO+RBPj0LEof8Vnn
        7UTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1680588025; x=1680674425; bh=LrTlRnC1PMOEduoHyaDrJIwpQILB4R4Y2q1
        2p1O1Lq4=; b=trYbBXo4nZv9yYGIl660K02BlRjcUspug0z0uEJXchR0X3vVizm
        CWYp2aspxKTqM9H3SIhFZujUCmPiTQtnw16Ur6xG0fqdcWN9ts+KJViNLM2/c9Qj
        KHkZNxx0rH7DkboOcSTCxPB7zordka1C1toU/ffxhO0jGDOoq2AQQDRvCGy3mQHd
        o9GUutruWvP0B2SncJ5QjfMlvHMKlR2s/LQhCK+6ze9IlDFQQmF/a7eg6FguHT4c
        vaM2d9NaKnP2+OuZLOS9eCkmy18L7pwaXaMby59Mk4IZtnuLFQndsj6VnRkbdWsh
        FzrkGS0XNPKV/TbNOyiEkfzNRG3LyGN5XBw==
X-ME-Sender: <xms:-bwrZGy1tLfxDnxTQBIYYvCZ10GZmE9xohspJO8R0zeaXq7Jc80DJA>
    <xme:-bwrZCRjdsIq38OHOOEjOvTHiyTrSrGRfnwVnDANG8_fBEM4PpM3FTnj-uQMze8YB
    NuLT5vyKXCntxByxug>
X-ME-Received: <xmr:-bwrZIXmCr5UGlPwlWWhgPOQdCbWFdTV8YifHgJePIC4LRIp_9uyghkSFfsUYVqolqozNBFh9fjeBSUKzWdYifWxmaA3YsX-eUYjUUM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeikedgkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkgggtugesthdtredttd
    dtvdenucfhrhhomheplfhoshhhucfvrhhiphhlvghtthcuoehjohhshhesjhhoshhhthhr
    ihhplhgvthhtrdhorhhgqeenucggtffrrghtthgvrhhnpeelleeggedtjeejfeeuvddufe
    eggfektdefkeehveeuvedvvdfhgeffgfdvgfffkeenucevlhhushhtvghrufhiiigvpedt
    necurfgrrhgrmhepmhgrihhlfhhrohhmpehjohhshhesjhhoshhhthhrihhplhgvthhtrd
    horhhg
X-ME-Proxy: <xmx:-bwrZMgQP9OLTEQzpTUiTAqbcOh3m0McF8_CRNni9s6PXTJjwFxt9Q>
    <xmx:-bwrZICZkb-M6xpAxBQdBLOOjTYeV_JYcJy0evq_eORTwSvztBa6MQ>
    <xmx:-bwrZNL3zWO_H_lNytygtBlO2qPlrRPvTj2ks6JNqCmodX7OhsI5lg>
    <xmx:-bwrZDpvGlmDZHNW4b3mB_1v2Z4yFxlRibj62BjaTCHaZIuArkPH6g>
Feedback-ID: i83e94755:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Apr 2023 02:00:23 -0400 (EDT)
Date:   Tue, 4 Apr 2023 15:00:19 +0900
From:   Josh Triplett <josh@joshtriplett.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] prctl: Add PR_GET_AUXV to copy auxv to userspace
Message-ID: <b11a591e085f1cd06adb454b1f7cde676d317318.1680585798.git.josh@joshtriplett.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a library wants to get information from auxv (for instance,
AT_HWCAP/AT_HWCAP2), it has a few options, none of them perfectly
reliable or ideal:

- Be main or the pre-main startup code, and grub through the stack above
  main. Doesn't work for a library.
- Call libc getauxval. Not ideal for libraries that are trying to be
  libc-independent and/or don't otherwise require anything from other
  libraries.
- Open and read /proc/self/auxv. Doesn't work for libraries that may run
  in arbitrarily constrained environments that may not have /proc
  mounted (e.g. libraries that might be used by an init program or a
  container setup tool).
- Assume you're on the main thread and still on the original stack, and
  try to walk the stack upwards, hoping to find auxv. Extremely bad
  idea.
- Ask the caller to pass auxv in for you. Not ideal for a user-friendly
  library, and then your caller may have the same problem.

Add a prctl that copies current->mm->saved_auxv to a userspace buffer.

Signed-off-by: Josh Triplett <josh@joshtriplett.org>
---

I've built, booted, and tested this.

man-pages snippet:

.\" prctl PR_GET_AUXV
.TP
.BR PR_GET_AUXV " (since Linux 6.x)"
Get the auxilliary vector (auxv) into the buffer pointed to by
.IR "(void\~*) arg2" ,
whose length is given by \fIarg3\fP.
If the buffer is not long enough for the full auxilliary vector,
the copy will be truncated.
Return (as the function result)
the full length of the auxilliary vector.
\fIarg4\fP and \fIarg5\fP must be 0.

Will send a patch for man-pages once merged.

 include/uapi/linux/prctl.h |  2 ++
 kernel/sys.c               | 15 +++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index 1312a137f7fb..b2b24eaf2427 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -290,4 +290,6 @@ struct prctl_mm_map {
 #define PR_SET_VMA		0x53564d41
 # define PR_SET_VMA_ANON_NAME		0
 
+#define PR_GET_AUXV		0x41555856
+
 #endif /* _LINUX_PRCTL_H */
diff --git a/kernel/sys.c b/kernel/sys.c
index 495cd87d9bf4..fdd297507d7e 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2377,6 +2377,16 @@ static inline int prctl_get_mdwe(unsigned long arg2, unsigned long arg3,
 		PR_MDWE_REFUSE_EXEC_GAIN : 0;
 }
 
+static int prctl_get_auxv(void __user *addr, unsigned long len)
+{
+	struct mm_struct *mm = current->mm;
+	unsigned long size = min(sizeof(mm->saved_auxv), len);
+
+	if (size && copy_to_user(addr, mm->saved_auxv, size))
+		return -EFAULT;
+	return sizeof(mm->saved_auxv);
+}
+
 SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 		unsigned long, arg4, unsigned long, arg5)
 {
@@ -2661,6 +2671,11 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 	case PR_SET_VMA:
 		error = prctl_set_vma(arg2, arg3, arg4, arg5);
 		break;
+	case PR_GET_AUXV:
+		if (arg4 || arg5)
+			return -EINVAL;
+		error = prctl_get_auxv((void __user *)arg2, arg3);
+		break;
 	default:
 		error = -EINVAL;
 		break;
-- 
2.40.0
