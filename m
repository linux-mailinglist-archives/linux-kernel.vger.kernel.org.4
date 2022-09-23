Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1C25E84C7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 23:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232808AbiIWVV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 17:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231205AbiIWVVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 17:21:12 -0400
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4048C120BDF;
        Fri, 23 Sep 2022 14:21:11 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:46132)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1obq6g-000o8g-4w; Fri, 23 Sep 2022 15:21:10 -0600
Received: from ip68-110-29-46.om.om.cox.net ([68.110.29.46]:49406 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1obq6f-002Jll-1i; Fri, 23 Sep 2022 15:21:09 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     cambda@linux.alibaba.com
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Dust Li <dust.li@linux.alibaba.com>,
        Tony Lu <tonylu@linux.alibaba.com>
References: <69E17223-F0CA-4A4C-AAD7-065D6E6266D9@linux.alibaba.com>
        <87k05v5sqn.fsf@email.froward.int.ebiederm.org>
        <59403595-9F9B-49C4-AB62-259DD2C40196@linux.alibaba.com>
Date:   Fri, 23 Sep 2022 16:21:02 -0500
In-Reply-To: <59403595-9F9B-49C4-AB62-259DD2C40196@linux.alibaba.com>
        (cambda@linux.alibaba.com's message of "Fri, 23 Sep 2022 11:56:55
        +0800")
Message-ID: <874jwx4wjl.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1obq6f-002Jll-1i;;;mid=<874jwx4wjl.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.110.29.46;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX18HrC7RwvP/0Caif2Ktot5rOINy7T4j660=
X-SA-Exim-Connect-IP: 68.110.29.46
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Virus: No
X-Spam-DCC: ; sa02 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;cambda@linux.alibaba.com
X-Spam-Relay-Country: 
X-Spam-Timing: total 416 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 3.9 (0.9%), b_tie_ro: 2.7 (0.6%), parse: 0.68
        (0.2%), extract_message_metadata: 9 (2.1%), get_uri_detail_list: 2.1
        (0.5%), tests_pri_-1000: 10 (2.5%), tests_pri_-950: 1.07 (0.3%),
        tests_pri_-900: 0.79 (0.2%), tests_pri_-90: 72 (17.2%), check_bayes:
        70 (16.9%), b_tokenize: 7 (1.6%), b_tok_get_all: 9 (2.1%),
        b_comp_prob: 1.86 (0.4%), b_tok_touch_all: 50 (12.0%), b_finish: 0.71
        (0.2%), tests_pri_0: 309 (74.2%), check_dkim_signature: 0.40 (0.1%),
        check_dkim_adsp: 1.71 (0.4%), poll_dns_idle: 0.38 (0.1%),
        tests_pri_10: 1.77 (0.4%), tests_pri_500: 6 (1.5%), rewrite_mail: 0.00
        (0.0%)
Subject: Re: Syscall kill() can send signal to thread ID
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"cambda@linux.alibaba.com" <cambda@linux.alibaba.com> writes:

>> On Sep 22, 2022, at 23:33, Eric W. Biederman <ebiederm@xmission.com> wrote:
>> 
>> cambda@linux.alibaba.com writes:
>> 
>>> I found syscall kill() can send signal to a thread id, which is
>>> not the TGID. But the Linux manual page kill(2) said:
>>> 
>>> "The kill() system call can be used to send any signal to any
>>> process group or process."
>>> 
>>> And the Linux manual page tkill(2) said:
>>> 
>>> "tgkill() sends the signal sig to the thread with the thread ID
>>> tid in the thread group tgid.  (By contrast, kill(2) can be used
>>> to send a signal only to a process (i.e., thread group) as a
>>> whole, and the signal will be delivered to an arbitrary thread
>>> within that process.)"
>>> 
>>> I don't know whether the meaning of this 'process' should be
>>> the TGID? Because I found kill(tid, 0) will return ESRCH on FreeBSD,
>>> while Linux sends signal to the thread group that the thread belongs
>>> to.
>>> 
>>> If this is as expected, should we add a notice to the Linux manual
>>> page? Because it's a syscall and the pids not equal to tgid are not
>>> listed under /proc. This may be a little confusing, I guess.
>> 
>> How did you come across this?  Were you just experimenting?
>> 
>> I am wondering if you were tracking a bug, or a portability problem
>> or something else.  If the current behavior is causing problems in
>> some way instead of just being a detail that no one really cares about
>> either way it would be worth considering if we want to maintain the
>> current behavior.
>> 
>> Eric
>
> I have found I can cd into /proc/tid, and the proc_pid_readdir()
> uses next_tgid() to filter tid. Also the 'ps' command reads the
> /proc dir to show processes. That's why I was confused with kill().
>
> And yes, I'm tracking a bug. A service monitor, like systemd or
> some watchdog, uses kill() to check if a pid is valid or not:
>   1. Store service pid into cache.
>   2. Check if pid in cache is valid by kill(pid, 0).
>   3. Check if pid in cache is the service to watch.
>
> So if kill(pid, 0) returns success but no process info shows on 'ps'
> command, the service monitor could be confused. The monitor could
> check if pid is tid, but this means the odd behavior would be used
> intentionally. And this workaround may be unsafe on other OS?
>
> I'm agreed with you that this behavior shouldn't be removed, in case
> some userspace applications use it now.

As has already been mentioned using pids and api's like kill is
fundamentally racy.  We try and to keep from reusing pids too quickly.
Unfortunately what we have is that on average there will be some time
between pid reuse not an kind of worst case guarantee.

We have slowly been introducing techniques into linux allow combatting
that.  A directory processes directory in proc that you have open will
never point to another process even after the pid is reused.  Similarly
we have pidfd that will associate with a specific process and will not
associate with any other process even if the processes pid is reused.

That is we have userspace pid value reuse, but we don't reuse struct pid
in the kernel.

Unfortunately I don't think there is anything that allows these races to
be addressed in a portable manner.

Eric

