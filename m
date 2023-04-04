Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45E7C6D6065
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 14:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234870AbjDDMb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 08:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231344AbjDDMb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 08:31:57 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37DE3170C
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 05:31:55 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 7FAEF3200934;
        Tue,  4 Apr 2023 08:31:54 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 04 Apr 2023 08:31:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        joshtriplett.org; h=cc:content-type:content-type:date:date:from
        :from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1680611514; x=1680697914; bh=nt
        6QuxRluVizW8uPZoCJ4NC8q9XQ4kfvc7TVTu/KcJw=; b=ekmuq8zkGHbLBYey+c
        1XMecsdG2y9co0x62WU2T2zlddxfC976rXhIjQynILiMPq1jxI9RFHmdcaaWf06A
        0NT61BrlAkFGCNzhM1pb8aW7vnk599VrAgTgXr8STZcdN8sZg5OuznQoCsxznUjN
        nVoRQo+Fx+JpLQ9v6UZpMuN8JbgpXQml4O8rr9ceuAc9D7sEo7MrCJ0TZfIEYq2U
        lquCMu2Y+8hni7kuv53j6vX/UxRHu/u+LCdWaC0CGK2nvxuvw+fJoDtXgrv5blhd
        NTG74N5qr8KfM4T2nTsSySWlRmQsLSRv+vb/L7YzYEwLTbkXBq4C2jA4lW71rqup
        BJYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1680611514; x=1680697914; bh=nt6QuxRluVizW8uPZoCJ4NC8q9XQ4kfvc7T
        VTu/KcJw=; b=TelJz/PPtY2EeYcftDqF5K1vPxYxI1iHYy4ovtr4RgWveLbfGuj
        s+a1/TgvBK2uBcvvqj6yh9+WEBjvuyFu5m4NrJCFqjWFM27KIMar6b8NL2QFV87b
        V1VByMRcLozA0bJZ/3F9ppcOTkjGtvceXGzY0IYKfYXSIBaO+rI3kBhKct+bUumV
        RMcHZqnlLq3doU7aGwIfbifsow7Gi/AEqNKtlMII1FEy9pQEvEn44I9UPV2/T0Bk
        A+gZNX584FuL57Xpt520bcyN5LYltUSmSRQOziwm9Iy9FZgIAuoCio7OG5x5J+iS
        vqhwIHAmYgCNZCkoTZ8Vv84QRFI+y4ZJNSg==
X-ME-Sender: <xms:uRgsZCCNuliajZGcABZ3kq8jQJ195CX8R155lmVpqZyx2UEp-1oRKA>
    <xme:uRgsZMjyroOxFhtGjnYkWLOyIq6VSbnEqu8AxbZXO-_BkRyTMhMiBjDtrpvxAfUaA
    aq5WBVOgwz3Ky-rOmk>
X-ME-Received: <xmr:uRgsZFlnXXccSYG6vgnodaOuz6_HYY887lKPMl_SCIP88SPlMkrJE6TBiN8zB12az-4ysdSkI0JlBV650OGITo0GPCxRVSOyqlJtzgs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeiledgheefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkgggtugesthdtredttd
    dtvdenucfhrhhomheplfhoshhhucfvrhhiphhlvghtthcuoehjohhshhesjhhoshhhthhr
    ihhplhgvthhtrdhorhhgqeenucggtffrrghtthgvrhhnpeelleeggedtjeejfeeuvddufe
    eggfektdefkeehveeuvedvvdfhgeffgfdvgfffkeenucevlhhushhtvghrufhiiigvpedt
    necurfgrrhgrmhepmhgrihhlfhhrohhmpehjohhshhesjhhoshhhthhrihhplhgvthhtrd
    horhhg
X-ME-Proxy: <xmx:uhgsZAxjjnYzcp42II1fPBtuP-3rCtE_KdFA4laR9MZ5_w9DWy79bg>
    <xmx:uhgsZHS48FpanaOc2rRtnDJiyL_4wqK_LSZR5rlDrkfu1Z7Qt8CJHw>
    <xmx:uhgsZLZdDSKZuAYD4PY-co9joRCnI5Kjm-g6d1IHoflbZUib1F4LTw>
    <xmx:uhgsZI62ZMXW3aJI65vfTh6GDBbpKDckd_Wf8qN6z-L3VgD83jV23w>
Feedback-ID: i83e94755:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Apr 2023 08:31:52 -0400 (EDT)
Date:   Tue, 4 Apr 2023 21:31:48 +0900
From:   Josh Triplett <josh@joshtriplett.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] prctl: Add PR_GET_AUXV to copy auxv to userspace
Message-ID: <d81864a7f7f43bca6afa2a09fc2e850e4050ab42.1680611394.git.josh@joshtriplett.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
index 495cd87d9bf4..43f922170706 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2377,6 +2377,16 @@ static inline int prctl_get_mdwe(unsigned long arg2, unsigned long arg3,
 		PR_MDWE_REFUSE_EXEC_GAIN : 0;
 }
 
+static int prctl_get_auxv(void __user *addr, unsigned long len)
+{
+	struct mm_struct *mm = current->mm;
+	unsigned long size = min_t(unsigned long, sizeof(mm->saved_auxv), len);
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

