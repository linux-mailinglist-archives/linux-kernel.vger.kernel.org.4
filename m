Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EAC65F5BAF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 23:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbiJEV20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 17:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiJEV2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 17:28:19 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC78D6C740;
        Wed,  5 Oct 2022 14:28:18 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:41014)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1ogBw8-00D173-0e; Wed, 05 Oct 2022 15:28:16 -0600
Received: from ip68-110-29-46.om.om.cox.net ([68.110.29.46]:53660 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1ogBw6-00AJ8c-Ti; Wed, 05 Oct 2022 15:28:15 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CAHC9VhShpEVTuogj4h74PxbEeTUNn4odo8SE6GBvb6sGUM0LHw@mail.gmail.com>
        <87sfk3mim9.fsf@email.froward.int.ebiederm.org>
        <CAHk-=wiCqicQrnQPeHbDF7ECKHk_ceYzZK5dYq7y5nZTZhpB8g@mail.gmail.com>
        <87r0zmigx6.fsf@email.froward.int.ebiederm.org>
        <CAHC9VhSK=oYxV=MzT7BLD3TuzQYiX0aY7h1aPb25wuRN=vPyKg@mail.gmail.com>
        <87a66ae15h.fsf@email.froward.int.ebiederm.org>
        <CAHC9VhTmfRhYCJibpZ20ibH-JhVMrwbpFdCtKUz5tqFHsjLRiw@mail.gmail.com>
Date:   Wed, 05 Oct 2022 16:27:09 -0500
In-Reply-To: <CAHC9VhTmfRhYCJibpZ20ibH-JhVMrwbpFdCtKUz5tqFHsjLRiw@mail.gmail.com>
        (Paul Moore's message of "Wed, 5 Oct 2022 12:04:27 -0400")
Message-ID: <874jwic66q.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1ogBw6-00AJ8c-Ti;;;mid=<874jwic66q.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.110.29.46;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1+pzk/xFxwA038CMk9+07SgSJFZrrAJ06o=
X-SA-Exim-Connect-IP: 68.110.29.46
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ****;Paul Moore <paul@paul-moore.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 478 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 11 (2.3%), b_tie_ro: 10 (2.0%), parse: 0.88
        (0.2%), extract_message_metadata: 18 (3.7%), get_uri_detail_list: 1.85
        (0.4%), tests_pri_-1000: 29 (6.0%), tests_pri_-950: 1.27 (0.3%),
        tests_pri_-900: 0.94 (0.2%), tests_pri_-90: 78 (16.4%), check_bayes:
        76 (15.9%), b_tokenize: 7 (1.4%), b_tok_get_all: 8 (1.7%),
        b_comp_prob: 2.5 (0.5%), b_tok_touch_all: 55 (11.5%), b_finish: 1.31
        (0.3%), tests_pri_0: 308 (64.4%), check_dkim_signature: 0.94 (0.2%),
        check_dkim_adsp: 4.1 (0.9%), poll_dns_idle: 0.04 (0.0%), tests_pri_10:
        3.8 (0.8%), tests_pri_500: 24 (5.1%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [GIT PULL] LSM patches for v6.1
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Moore <paul@paul-moore.com> writes:

> On Wed, Oct 5, 2022 at 11:33 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>> Paul Moore <paul@paul-moore.com> writes:
>> > On Wed, Oct 5, 2022 at 8:39 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>> >> Linus Torvalds <torvalds@linux-foundation.org> writes:
>
> ...
>
>> >> Effectively he said that where two or more out of tree LSM policies want
>> >> something it makes no sense to discussion the actual reasons people want
>> >> to use the hook.
>> >
>> > Runtime kernel configuration is inherently "out of tree", this
>> > includes not only loadable LSM security policies (e.g. a SELinux
>> > policy), the system's firewall configuration, things like sysctl.conf,
>> > and countless others.  Please understand that "out of tree" in this
>> > context is not the same as when it is used in the context of kernel
>> > code; the former is actually a positive thing ("look we can configure
>> > the kernel behavior the way we want!") while the latter is a
>> > maintenance and support nightmare.
>>
>> Paul are you saying my experience with /proc/net pointing incorrectly at
>> /proc/self/net instead of /proc/thread-self/net is invalid?
>
> My comment was that runtime kernel configuration is always going to be
> out of tree due to its very nature, and conflating runtime
> configuration with kernel code is a mistake.

When the runtime configuration has it's own llvm backend I have
trouble seeing the difference.  It is code that controls kernel behavior
that does not live in the kernel.

Apparmor and selinux polices are not quite that generic but as I have
discovered much to my pain routine clean-ups that userspace does not
care about are blocked because apparmor and selinux policies have bugs.

When I can not fix kernel bugs because of policy bugs, it has the
same kind of effect as keeping an interface the same for out of
tree code.  A little worse actually.

Most kernel runtime configuration is a on/off of a numeric setting
with logic that is enabled by that in the kernel.  Those I can agree
are not the same.  

Given that the logic and it's bugs are going to be out of tree I do not
agree that we should only consider what goes into the kernel when
looking into that kind of code.  Instead we should treat it will all of
the due diligence that we attempt to use when creating a system call.
That very much has not happened here.

Eric
