Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74ECA6D7163
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 02:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236484AbjDEAiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 20:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234892AbjDEAiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 20:38:20 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8666D1705
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 17:38:19 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id EDAD93200A78;
        Tue,  4 Apr 2023 20:38:18 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 04 Apr 2023 20:38:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        joshtriplett.org; h=cc:content-type:content-type:date:date:from
        :from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1680655098; x=1680741498; bh=ej
        zhtkUjzuEOBfr+jkw68scBu5KVz3rG4G/vQRTMeww=; b=VrHN7PaOMJ/lYHLRBV
        JLadOyWW2FWqqZR3LmQCOIw34A9FM2Omrk/7VOVGOx4uXtefv9yCPdaL2wHAsclP
        UGKyYs5j7Uakggiw5qPaMxrs6zBQDtWU/3l7bBXfxWqtp6FsUMr3wBqlMmMRxBJd
        5swd1rMVnwY4EkPk//l9BO+nvWGe9WnZ8L7eN0rdRgQiDP1aeKWKTEEFnzOJN/bq
        85o0VX7kbkUkOsWKYKQp05hB1GdyWMRNdTptdqtrUSCGr56RkYHVBWeeQMRSK7lf
        4JmfqfiXIAvXy12arIDoFSsFpcdl2ks5CCJh0JKHnl1z4iYaMWTsgCehZlUF+lFj
        4YvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1680655098; x=1680741498; bh=ejzhtkUjzuEOBfr+jkw68scBu5KVz3rG4G/
        vQRTMeww=; b=isrBH6eFfRH4sgMtk+URn+vOWJWB9zZ77RVq67miD5qIdyUG4tq
        iNurQ9hCw8RUaZQM8zvyvrIOitXCXa+7EqfAwUI7yNs4Xu7IXyFvFviglmCTx6bJ
        ccURZXKRrNkDGHFe90U4eF1l7DtC4Qe4xYQlr/YI0fHeL2h+SuNzMCzCyPs6kI0D
        03fgXKcN+EFwPIrM+tdipadSGnfK5SDtLxYtyANpdB/2aXA/umIPlIEviUNh9Q6N
        B8+EFJJ9giSXwginI9IWbY8UnEsmmNqYlBZz4X0eDOkLBGNxPomCF24KcAC/WT89
        yiyQ+86R9u/ZGjlxNAKQNln3Gtmm+WD/tKQ==
X-ME-Sender: <xms:-sIsZKiBzJ5oyOvqRTLRZmfa2MR8og29o3r3RXHWXTvha7SO4v_dcg>
    <xme:-sIsZLBAZtjnqWX0O_HvDdF1p1EGOFX1OqD_P_zcnCPskcqhJRHx4cdSarf7LTp1o
    IaIZlW0PNTPBdPT4fw>
X-ME-Received: <xmr:-sIsZCEDSDvNz1p0hoM3Rx2NiPCEEFeAweeeInqxLGhEPZqE9qSkcb3rWpNY3AgGyoAqUJkugBRUCDtRoNyOIpYC-9PskgHGZhxwaco>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdejtddgfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkgggtugesthdtredttd
    dtvdenucfhrhhomheplfhoshhhucfvrhhiphhlvghtthcuoehjohhshhesjhhoshhhthhr
    ihhplhgvthhtrdhorhhgqeenucggtffrrghtthgvrhhnpeelleeggedtjeejfeeuvddufe
    eggfektdefkeehveeuvedvvdfhgeffgfdvgfffkeenucevlhhushhtvghrufhiiigvpedt
    necurfgrrhgrmhepmhgrihhlfhhrohhmpehjohhshhesjhhoshhhthhrihhplhgvthhtrd
    horhhg
X-ME-Proxy: <xmx:-sIsZDRnyLWv7Zizdpml_SLHjGduEOaxCrLegjV9QyvOwnIWJpw-aA>
    <xmx:-sIsZHxtQOs5XlWcneMe994a_bhKg5Ikmq5wWM42143aQzwQLN-s3A>
    <xmx:-sIsZB6iAgRh776lQWq9ZwmqIGP0kQoPKv3wdIWFce-4IewwJx09Iw>
    <xmx:-sIsZFYDTHkcGF_cX4UGe93B4PAPx8tz91BMjE7bjIFld0zM4l-KDQ>
Feedback-ID: i83e94755:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Apr 2023 20:38:16 -0400 (EDT)
Date:   Wed, 5 Apr 2023 09:38:14 +0900
From:   Josh Triplett <josh@joshtriplett.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] prctl: Add PR_GET_AUXV to copy auxv to userspace
Message-ID: <e2236beddcef21cd4868849df990debd38c1ae3a.1680654963.git.josh@joshtriplett.org>
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

v2:
- Fix W=1 warning about min type mismatch
v3:
- Change argument type to size_t. (Left the return value as int to match
  all the other helpers in the file.)

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
index 495cd87d9bf4..f031edb8bc47 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2377,6 +2377,16 @@ static inline int prctl_get_mdwe(unsigned long arg2, unsigned long arg3,
 		PR_MDWE_REFUSE_EXEC_GAIN : 0;
 }
 
+static int prctl_get_auxv(void __user *addr, size_t len)
+{
+	struct mm_struct *mm = current->mm;
+	size_t size = min_t(size_t, sizeof(mm->saved_auxv), len);
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

