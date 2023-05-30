Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3551715408
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 04:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbjE3CtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 22:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbjE3CtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 22:49:02 -0400
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522C6CD
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 19:48:43 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:42588)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1q3pPe-007jSW-3z; Mon, 29 May 2023 20:48:42 -0600
Received: from ip68-110-29-46.om.om.cox.net ([68.110.29.46]:56626 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1q3pPd-009vMy-1g; Mon, 29 May 2023 20:48:41 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     michael.christie@oracle.com
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux@leemhuis.info, nicolas.dichtel@6wind.com, axboe@kernel.dk,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, mst@redhat.com,
        sgarzare@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        brauner@kernel.org
References: <20230524141022.GA19091@redhat.com>
        <87ttw1zt4i.fsf@email.froward.int.ebiederm.org>
        <20230525115512.GA9229@redhat.com>
        <87y1lcxwcj.fsf@email.froward.int.ebiederm.org>
        <CAHk-=wj4DS=2F5mW+K2P7cVqrsuGd3rKE_2k2BqnnPeeYhUCvg@mail.gmail.com>
        <87cz2mrtnk.fsf@email.froward.int.ebiederm.org>
        <CAHk-=whsi9JFP-okH3jXHrA8rh8bMuuSt6ZgkmPwiDMAn437qA@mail.gmail.com>
        <87mt1pmezu.fsf@email.froward.int.ebiederm.org>
        <20230529111859.GA15193@redhat.com>
        <022f4de6-9eae-0a94-0f55-b84be4982fc3@oracle.com>
        <20230529174646.GB15193@redhat.com>
        <ff1bce1a-62d8-1b2e-4560-1ce1ffc209bc@oracle.com>
        <723ac1ba-31d2-92fe-4010-42d8cd70d5df@oracle.com>
Date:   Mon, 29 May 2023 21:48:34 -0500
In-Reply-To: <723ac1ba-31d2-92fe-4010-42d8cd70d5df@oracle.com> (michael
        christie's message of "Mon, 29 May 2023 14:46:57 -0500")
Message-ID: <87bki2h6v1.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1q3pPd-009vMy-1g;;;mid=<87bki2h6v1.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.110.29.46;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX19wSqLMTVFEWgLETMysNGRtJ36mwutxbSI=
X-SA-Exim-Connect-IP: 68.110.29.46
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;michael.christie@oracle.com
X-Spam-Relay-Country: 
X-Spam-Timing: total 402 ms - load_scoreonly_sql: 0.07 (0.0%),
        signal_user_changed: 11 (2.7%), b_tie_ro: 10 (2.4%), parse: 0.92
        (0.2%), extract_message_metadata: 3.5 (0.9%), get_uri_detail_list:
        1.44 (0.4%), tests_pri_-2000: 3.2 (0.8%), tests_pri_-1000: 2.5 (0.6%),
        tests_pri_-950: 1.25 (0.3%), tests_pri_-900: 1.03 (0.3%),
        tests_pri_-200: 0.86 (0.2%), tests_pri_-100: 3.2 (0.8%),
        tests_pri_-90: 59 (14.8%), check_bayes: 58 (14.4%), b_tokenize: 7
        (1.8%), b_tok_get_all: 8 (2.0%), b_comp_prob: 2.4 (0.6%),
        b_tok_touch_all: 37 (9.2%), b_finish: 0.74 (0.2%), tests_pri_0: 289
        (71.9%), check_dkim_signature: 0.52 (0.1%), check_dkim_adsp: 8 (2.0%),
        poll_dns_idle: 6 (1.6%), tests_pri_10: 3.6 (0.9%), tests_pri_500: 14
        (3.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 3/3] fork, vhost: Use CLONE_THREAD to fix freezer/ps
 regression
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

michael.christie@oracle.com writes:

> On 5/29/23 2:35 PM, Mike Christie wrote:
>>> Hmm... If we you CLONE_THREAD the exiting vhost_worker() will auto-reap itself,
>> Oh wait, are you saying that when we get auto-reaped then we would do the last
>> fput and call the file_operations->release function right? We actually set
>> task_struct->files = NULL for the vhost_task task_struct, so I think we call
>> release a little sooner than you think.
>> 
>> vhost_task_create() sets kernel_clone_args->no_files, so the vhost_task task_struc
>> that gets created works like kthreads where it doesn't do a CLONE_FILES and it
>> doesn't do a dup_fd.
>> 
>> So when we do de_thread() -> zap_other_threads(), that will kill all the threads
>> in the group right? So when they exit, it will call our release function since
>> we don't have refcount on ourself.
>> 
>
> Just to make sure I'm on the same page now.
>
> In the past thread when were discussing the patch below and you guys were saying
> that it doesn't really ignore SIGKILL because we will hit the
> SIGNAL_GROUP_EXIT/group_exec_task checks and the parent is going to exit, it was
> on purpose.
>
> Instead of a signal to tell me when do exit, I was using the parent exiting and doing
> the last fput on the vhost device's file which calls our release function. That then
> allowed the vhost code to use the vhost_task to handle the outstanding IOs and then
> do vhost_task_should_stop to tell the vhost_task to exit when the oustanding IO
> had completed.
>
> On the vhost side of things it's really nice, because all the shutdown paths work
> the same and we don't need rcu/locking in the main IO path to handle the vhost_task
> exiting while we are using it.

The code below does nothing for exec.

You really need to call get_signal to handle SIGSTOP/freeze/process exit.

A variant on my coredump proposal looks like it can handle exec as well.
It isn't pretty but it looks good enough for right now.

If you could test the patch I posted up thread I think that is something
imperfect that is good enough for now.

Eric
