Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65E5169D222
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 18:32:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232420AbjBTRck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 12:32:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbjBTRci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 12:32:38 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2CF51DB8C;
        Mon, 20 Feb 2023 09:32:36 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id ff4so1842256qvb.2;
        Mon, 20 Feb 2023 09:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kFO6HDk/LvdEJJ6EhYdimdWV1qH1YYBfNXIb/8yU3F4=;
        b=Jl5BmAsIdDWmrv6hn/mFTdJRbeJ2tZLdzz8EbwQbCT64DlkkT0RcBpSvz49StTahqB
         yGSyKlilGuI0MtpEy9BNN8fjP7zWZ3abvlrEj+ZgSstbHkGTSkWWGK/U7AQzjMJZ2+gz
         1bvJ6l4JM2bUWnEkLidUxJrIm8CPh095nNbZvcJxXss/Odx0TysmF9S9uVLMiFK2tsze
         hVlIOz8WWYlnh7Nf9+c1/NOEsr/em8NlM2hGJ9hjv5AKOhJs+Iu2VqhyUM62xZQIGEHh
         wxZCcsgd4Tt5TUZiN73Kd+Sz3pFqPzE1Cv/d4b7E7wtQQfHFm/6n381GKr+mI36iaP13
         4G4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kFO6HDk/LvdEJJ6EhYdimdWV1qH1YYBfNXIb/8yU3F4=;
        b=zKiU/t6btXTrbvHOxBouuLk9FkNeqg+KKQnDnYbebM5if6jOM+NULlQlKj4FKVltcD
         gTlfxxc60xTxet1QvYIC5fUXWet8KIvqzjcTV10zZVHNGQZl3nhw6oMf91TQRlFHfB6u
         fIB7M03RZkai2I5DHBoBHkwrcL0DptD+T+Rfs7FR3Pelg3lM+a2uvKDWdkow10Ujr0B7
         XNjVb/gxhpYRffEZfYr5Dx147b7krDnx21DNZr2tLViG+DRLRkBvhn0JgQqUt4+W9H41
         un18R2pXJTnBl+5ltv4qDfBZdBYMOpCNQxd6tj9kT1dyrYGLysx2Fzjpr5aHDuXxVO8k
         6v9g==
X-Gm-Message-State: AO0yUKXU0+uk5nQobJ/x4/J+Ez/uatn3R9DhjF84Eguh5+TlT7lufNYS
        e+2sgwIL7s4sAdBb2kJeU+Y=
X-Google-Smtp-Source: AK7set8M0iE89d7j9ilKkczU26VE6m5GGHd7SWiu2nZ/OFkvjvXQUqvwg6s8bTY6NpPWDkErQa1RVg==
X-Received: by 2002:a05:6214:dc6:b0:56f:979:b1e8 with SMTP id 6-20020a0562140dc600b0056f0979b1e8mr4433976qvt.48.1676914355859;
        Mon, 20 Feb 2023 09:32:35 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id f66-20020a37d245000000b007201df7ff47sm825313qkj.45.2023.02.20.09.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 09:32:35 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailauth.nyi.internal (Postfix) with ESMTP id B61C327C0054;
        Mon, 20 Feb 2023 12:32:34 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 20 Feb 2023 12:32:34 -0500
X-ME-Sender: <xms:sK7zY6jtQ43bHXRZb_AC50BZ9f-S60B38V2DpiuIeBWYpR18T3KdPg>
    <xme:sK7zY7A8Rzx6SPJgEeQcP_NzNi1XUOBmIYUJhbpiOwrd_P2mcR4_3dzXzydcvIwk5
    3cGu-EAm_rQrNfnqg>
X-ME-Received: <xmr:sK7zYyFPezTLPEGn3e2AzdZarW6UKwPZQVRM-_jcqV7vMyfT0bOFLB8BSNE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudejhedgleeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:sK7zYzTD5_bWkRxxuFO8tH_WqTpiOZ8WHYRPbwqcGppEWXcqVI42-g>
    <xmx:sK7zY3yZQqL1YHqtwz1bU1mxBhPU9EFULi7Asc467nNmRoTZDQIiEw>
    <xmx:sK7zYx5ed3OIXZSAUHtpzCKpDGiXkV3pEFhUw8_0ISECU9nR3SU1_Q>
    <xmx:sq7zY8JIThlFG2T_JcxXhwXCZxvAcxuZ5KywqOLwyQXze-vwrCEJ-g>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Feb 2023 12:32:32 -0500 (EST)
Date:   Mon, 20 Feb 2023 09:32:19 -0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Coly Li <colyli@suse.de>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        syzkaller <syzkaller@googlegroups.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        Hillf Danton <hdanton@sina.com>
Subject: Re: [PATCH RFC] drivers/core: Replace lockdep_set_novalidate_class()
 with unique class keys
Message-ID: <Y/Ouo4Jog4bInO63@boqun-archlinux>
References: <Y+hW74TAVzCpSv7c@rowland.harvard.edu>
 <Y+hYn6uzIUBaxDdV@moria.home.lan>
 <Y+kEgDLSRwdODRdD@rowland.harvard.edu>
 <Y+oBveWO2z6xdTW/@hirez.programming.kicks-ass.net>
 <Y+pWhyFJeE93nlWd@rowland.harvard.edu>
 <Y+plfZnEqw6mG+XH@hirez.programming.kicks-ass.net>
 <Y+rpD7QPheQQ8Lxj@boqun-archlinux>
 <Y+tm59SmBEY1Ywq7@hirez.programming.kicks-ass.net>
 <Y+u1RBMMcCkvKISZ@boqun-archlinux>
 <Y+y3r8Q5GT+oJsvd@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+y3r8Q5GT+oJsvd@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2023 at 11:45:03AM +0100, Peter Zijlstra wrote:
> On Tue, Feb 14, 2023 at 08:22:28AM -0800, Boqun Feng wrote:
> 
> > Ah, right, I was missing the fact that it works with 2 classes...
> > 
> > But I think with only one class, the nest_lock() still works, right?
> > In other words, if P and Cn are the same lock class in your example.

After playing with some self test cases, I found I was wrong again ;-(

> 
> I don't think so, but I don't think I've carefully considered that case.
> 

You are right, the same class case will trigger a DEBUG_LOCKS_WARN_ON()
in the match_held_lock() when releasing the locks.

> > Also seems I gave a wrong answer to Alan, just to clarify, the following
> > is not a deadlock to lockdep:
> > 
> > T1:
> > 	mutex_lock(P)
> > 	mutex_lock_next_lock(C1, P)
> > 	mutex_lock_next_lock(C2, P)
> > 	mutex_lock(B)
> > 
> > T2:
> > 	mutex_lock(P)
> > 	mutex_lock(B)
> > 	mutex_lock_next_lock(C1, P)
> > 	mutex_lock_next_lock(C2, P)
> > 
> 
> This should in fact complain about a CB-BC deadlock, (but I've not
> tested it, just going on memories of how I implemented it).
> 

Yes, confirmed by a selftest.

> > Because of any pair of
> > 
> > 	mutex_lock(L);
> > 	... // other locks maybe
> > 	mutex_lock_nest_lock(M, L);
> > 
> > lockdep will not add M into the dependency graph, since it's nested and
> > should be serialized by L.
> 
> We do enter M into the dependency graph, but instead ignore M-M
> recursion. Specifically so that we might catch the above deadlock vs B.

Right, I mis-read the code, which suggests I should improve it to help
the future me ;-)

FWIW, the selftests I used are as follow:

Regards,
Boqun

------------------------------->8
diff --git a/lib/locking-selftest.c b/lib/locking-selftest.c
index 8d24279fad05..6aadebad68c1 100644
--- a/lib/locking-selftest.c
+++ b/lib/locking-selftest.c
@@ -60,6 +60,7 @@ __setup("debug_locks_verbose=", setup_debug_locks_verbose);
 #define LOCKTYPE_RTMUTEX 0x20
 #define LOCKTYPE_LL	0x40
 #define LOCKTYPE_SPECIAL 0x80
+#define LOCKTYPE_NEST	0x100
 
 static struct ww_acquire_ctx t, t2;
 static struct ww_mutex o, o2, o3;
@@ -2091,14 +2092,14 @@ static void ww_test_edeadlk_acquire_wrong_slow(void)
 	ww_mutex_lock_slow(&o3, &t);
 }
 
-static void ww_test_spin_nest_unlocked(void)
+static void nest_test_spin_nest_unlocked(void)
 {
 	spin_lock_nest_lock(&lock_A, &o.base);
 	U(A);
 }
 
 /* This is not a deadlock, because we have X1 to serialize Y1 and Y2 */
-static void ww_test_spin_nest_lock(void)
+static void nest_test_spin_nest_lock(void)
 {
 	spin_lock(&lock_X1);
 	spin_lock_nest_lock(&lock_Y1, &lock_X1);
@@ -2110,6 +2111,33 @@ static void ww_test_spin_nest_lock(void)
 	spin_unlock(&lock_X1);
 }
 
+static void nest_test_spin_nest_lock_deadlock(void)
+{
+	nest_test_spin_nest_lock();
+
+	/*
+	 * Although above is not a deadlokc, but with the following code, Y1 and
+	 * A create a ABBA deadlock.
+	 */
+	spin_lock(&lock_X1);
+	spin_lock(&lock_A);
+	spin_lock_nest_lock(&lock_Y1, &lock_X1);
+	spin_lock_nest_lock(&lock_Y2, &lock_X1);
+	spin_unlock(&lock_A);
+	spin_unlock(&lock_Y2);
+	spin_unlock(&lock_Y1);
+	spin_unlock(&lock_X1);
+}
+
+/* Not the supported usage */
+static void nest_test_spin_nest_lock_same_class(void)
+{
+	spin_lock(&lock_X1);
+	spin_lock_nest_lock(&lock_X2, &lock_X1);
+	spin_unlock(&lock_X2);
+	spin_unlock(&lock_X1);
+}
+
 static void ww_test_unneeded_slow(void)
 {
 	WWAI(&t);
@@ -2323,14 +2351,6 @@ static void ww_tests(void)
 	dotest(ww_test_edeadlk_acquire_wrong_slow, FAILURE, LOCKTYPE_WW);
 	pr_cont("\n");
 
-	print_testname("spinlock nest unlocked");
-	dotest(ww_test_spin_nest_unlocked, FAILURE, LOCKTYPE_WW);
-	pr_cont("\n");
-
-	print_testname("spinlock nest test");
-	dotest(ww_test_spin_nest_lock, SUCCESS, LOCKTYPE_WW);
-	pr_cont("\n");
-
 	printk("  -----------------------------------------------------\n");
 	printk("                                 |block | try  |context|\n");
 	printk("  -----------------------------------------------------\n");
@@ -2360,6 +2380,27 @@ static void ww_tests(void)
 	pr_cont("\n");
 }
 
+static void nest_tests(void)
+{
+	printk("  --------------------------------------------------------------------------\n");
+	printk("  | nest lock tests |\n");
+	printk("  -------------------\n");
+	print_testname("spinlock nest unlocked");
+	dotest(nest_test_spin_nest_unlocked, FAILURE, LOCKTYPE_NEST);
+	pr_cont("\n");
+
+	print_testname("spinlock nest test");
+	dotest(nest_test_spin_nest_lock, SUCCESS, LOCKTYPE_NEST);
+	pr_cont("\n");
+	print_testname("spinlock nest test dead lock");
+	dotest(nest_test_spin_nest_lock_deadlock, FAILURE, LOCKTYPE_NEST);
+	pr_cont("\n");
+	print_testname("spinlock nest test dead lock");
+	dotest(nest_test_spin_nest_lock_same_class, FAILURE, LOCKTYPE_NEST);
+	pr_cont("\n");
+
+}
+
 
 /*
  * <in hardirq handler>
@@ -2966,6 +3007,8 @@ void locking_selftest(void)
 
 	ww_tests();
 
+	nest_tests();
+
 	force_read_lock_recursive = 0;
 	/*
 	 * queued_read_lock() specific test cases can be put here
