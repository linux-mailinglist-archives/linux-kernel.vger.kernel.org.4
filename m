Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C155E703040
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 16:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241913AbjEOOnP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 15 May 2023 10:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241759AbjEOOnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 10:43:06 -0400
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41229270D
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 07:42:50 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:41028)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1pyZPT-000HU2-Ep; Mon, 15 May 2023 08:42:47 -0600
Received: from ip68-110-29-46.om.om.cox.net ([68.110.29.46]:48662 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1pyZPR-003Kxl-OI; Mon, 15 May 2023 08:42:47 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <CAAhV-H79bUF396+dWaafanzcMq41VtcOsfa_3SYSUftyNDOyvw@mail.gmail.com>
        (Huacai Chen's message of "Sat, 13 May 2023 11:18:37 +0800")
References: <20230509104127.1997562-1-chenhuacai@loongson.cn>
        <87ild0w5qs.fsf@email.froward.int.ebiederm.org>
        <CAAhV-H79bUF396+dWaafanzcMq41VtcOsfa_3SYSUftyNDOyvw@mail.gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Date:   Mon, 15 May 2023 09:41:50 -0500
Message-ID: <87ttwdu05t.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1pyZPR-003Kxl-OI;;;mid=<87ttwdu05t.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.110.29.46;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX18kmDAXAFN2evKbBlpraJSCti1ihQ0mM6I=
X-SA-Exim-Connect-IP: 68.110.29.46
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Virus: No
X-Spam-DCC: XMission; sa03 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Huacai Chen <chenhuacai@kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1032 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 3.9 (0.4%), b_tie_ro: 2.8 (0.3%), parse: 0.71
        (0.1%), extract_message_metadata: 12 (1.1%), get_uri_detail_list: 1.56
        (0.2%), tests_pri_-2000: 19 (1.8%), tests_pri_-1000: 1.88 (0.2%),
        tests_pri_-950: 1.10 (0.1%), tests_pri_-900: 0.80 (0.1%),
        tests_pri_-200: 0.67 (0.1%), tests_pri_-100: 3.0 (0.3%),
        tests_pri_-90: 240 (23.2%), check_bayes: 227 (22.0%), b_tokenize: 6
        (0.6%), b_tok_get_all: 7 (0.7%), b_comp_prob: 1.81 (0.2%),
        b_tok_touch_all: 208 (20.2%), b_finish: 0.89 (0.1%), tests_pri_0: 299
        (29.0%), check_dkim_signature: 0.55 (0.1%), check_dkim_adsp: 2.6
        (0.3%), poll_dns_idle: 436 (42.2%), tests_pri_10: 2.6 (0.2%),
        tests_pri_500: 445 (43.1%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH RFC] kthread: Unify kernel_thread() and user_mode_thread()
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Huacai Chen <chenhuacai@kernel.org> writes:

> Hi, Eric,
>
> On Wed, May 10, 2023 at 11:45 PM Eric W. Biederman
> <ebiederm@xmission.com> wrote:
>>
>> Huacai Chen <chenhuacai@loongson.cn> writes:
>>
>> > Commit 343f4c49f2438d8 ("kthread: Don't allocate kthread_struct for init
>> > and umh") introduces a new function user_mode_thread() for init and umh.
>> > But the name is a bit confusing because init and umh are indeed kernel
>> > threads at creation time, the real difference is "they will become user
>> > processes".
>>
>> No they are not "kernel threads" at creation time.  At creation time
>> init and umh are threads running in the kernel.
>>
>> It is a very important distinction and you are loosing it.
>>
>> Because they don't have a kthread_struct such tasks in the kernel
>> are not allowed to depend on anything that is ``kthread''.
> Hmm, traditionally, we call a "task" without userland address space
> (i.e., the task_struct has no mm, it shares kernel's address space) as
> a kernel thread, so init and umh are kernel threads until they call
> kernel_execve().

No.

The important distinction is not the userland address space.

The important distinction is how such tasks interact with the rest of
the system.

It is true the mm does not initially have userspace content but
that does not change the fact that it is a valid userspace mm.

For scheduling, for signal delivery, and for everything else
these tasks are userspace tasks.

The very important detail is that it is not at kernel_execve time that
the distinction is made, but that it is made earlier when the thread
is created.

This is a subtle change from the way things used to work once upon a
time.  But the way things used to work was buggy and racy.  Deciding at
thread creation time what the thread will be used for, what limitations
etc is much less error prone.

We had this concept of kthread_create that used to create a special
class of tasks.  What was special, and what extra could be done with
those tasks was defined by the presence "struct kthread" (my apologies
I mispoke when I said kthread_struct earlier).

Then because that specialness was needed on other tasks struct kthread
started to be added to tasks at run-time.  That runtime addition of
struct kthread introduced races that complicated the code, and had
bugs.

> Of course in your patch a kernel thread should have a
> "kthread" struct (I can't grep "kthread_struct" so I suppose you are
> saying "kthread"), but I think the traditional definition is more
> natural for most people?

Natural and traditional is a silly argument.  The fact is those are
tasks that ultimately run userspace code.  That ability needs to
be decided upon at creation time to make them race free.

Therefore the old code and definition are wrong.

Eric
