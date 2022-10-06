Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84DAA5F66F8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 14:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231807AbiJFMzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 08:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230461AbiJFMzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 08:55:13 -0400
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4689A59A7;
        Thu,  6 Oct 2022 05:54:32 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:52790)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1ogQMl-001wrk-SK; Thu, 06 Oct 2022 06:52:43 -0600
Received: from ip68-110-29-46.om.om.cox.net ([68.110.29.46]:37142 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1ogQMk-00FeG7-Lp; Thu, 06 Oct 2022 06:52:43 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Paul Moore <paul@paul-moore.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CAHC9VhShpEVTuogj4h74PxbEeTUNn4odo8SE6GBvb6sGUM0LHw@mail.gmail.com>
        <87sfk3mim9.fsf@email.froward.int.ebiederm.org>
        <CAHk-=wiCqicQrnQPeHbDF7ECKHk_ceYzZK5dYq7y5nZTZhpB8g@mail.gmail.com>
        <87r0zmigx6.fsf@email.froward.int.ebiederm.org>
        <CAHk-=wihQGNanXu3aeN12rsq+2K9BDkZEij-9HWtbVxFbXg1rw@mail.gmail.com>
Date:   Thu, 06 Oct 2022 07:52:13 -0500
In-Reply-To: <CAHk-=wihQGNanXu3aeN12rsq+2K9BDkZEij-9HWtbVxFbXg1rw@mail.gmail.com>
        (Linus Torvalds's message of "Wed, 5 Oct 2022 11:54:32 -0700")
Message-ID: <87h70h5d36.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1ogQMk-00FeG7-Lp;;;mid=<87h70h5d36.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.110.29.46;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX18bJ2eMLHkzxYk/0SFWDcGQLZA8+RhXvg0=
X-SA-Exim-Connect-IP: 68.110.29.46
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ****;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 668 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 12 (1.7%), b_tie_ro: 10 (1.5%), parse: 1.20
        (0.2%), extract_message_metadata: 20 (2.9%), get_uri_detail_list: 3.5
        (0.5%), tests_pri_-1000: 16 (2.4%), tests_pri_-950: 1.49 (0.2%),
        tests_pri_-900: 1.24 (0.2%), tests_pri_-90: 127 (19.0%), check_bayes:
        125 (18.7%), b_tokenize: 12 (1.7%), b_tok_get_all: 13 (1.9%),
        b_comp_prob: 4.4 (0.7%), b_tok_touch_all: 91 (13.6%), b_finish: 1.06
        (0.2%), tests_pri_0: 470 (70.3%), check_dkim_signature: 0.78 (0.1%),
        check_dkim_adsp: 11 (1.7%), poll_dns_idle: 0.41 (0.1%), tests_pri_10:
        2.3 (0.3%), tests_pri_500: 13 (2.0%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [GIT PULL] LSM patches for v6.1
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Wed, Oct 5, 2022 at 5:39 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>>
>> We already have /proc/sys/user/max_user_namespaces.  It is a per userns
>> control so you can run it in as fine grain as you like.  A little
>> cumbersome perhaps but real.
>
> It's not that it's cumbersome.
>
> It's that it is *USELESS*.

Not quite.  Because you can have lower settings inside created user
namespaces, it is easy to create a user namespace so inside of
a sandbox you can't create more user namespaces.

> Sure, it limits the memory footprint of somebody who does the
> fork-bomb equivalent of user namespaces, but that's the least of the
> problems.
>
> Just think of normal users. They'd want a limited number of user
> namespaces for things like sandboxing (whether google chrome or
> whatever).
>
> So distros do want to allow people a few of them.
>
> But they want to be able to do so in a *controlled* manner. Not a "ok,
> this user can create five user namespaces and do whatever they want in
> them". Because we've had the issues where some kernel part has gotten
> things wrong, and thought "local NS root means root" or similar.
>
> So it's not about the number of namespaces. AT ALL. It's about *who*
> and *what* does them.

I see your concern that I am not acknowledging the current state of play
of user namespaces, and what problems they may be causing people.  Let
me describe what I understand the current state to be and you can
correct me where I am wrong.

At this point every old-school distro I am aware of enables user
namespaces by default. (I don't know what android and chrome-os do).  As
best I have been able to determine the bugs that are turning up are the
same kinds of bugs and at roughly the same rates as bugs turn up
anywhere else in the user/kernel interface.

There is a common trend that shows up when people examine posted
exploits (especially exploits connected to CVEs), a lot of the exploits
create user namespaces.  As best as I have been able to determine this
has two causes.  Arranging the conditions so that the bugs can be
triggered without using user namespaces is more difficult.  There is
more attack surface when user namespaces are enabled.

Even so it is my sense that for a typical linux desktop the additional
risk of running with user namespaces enabled is negligible.  My sense is
that there is a modest probability that there is a exploitable kernel
bug with user namespaces disabled, and that enabling them only slightly
increases the probability that there is an exploitable kernel bug.

The conclusion I draw from that is that it is ok to leave the use of
namespaces enabled by default for most people most of the time.

As best as I can determine it takes running on separate machines, or
possibly running inside of virtual machines to provide reasonable safety
from an attacker who manages to run arbitrary unprivileged userspace
code.  I don't believe disabling user namespaces appreciably moves the
needle.

In the linux desktop space there is chrome, and things like flatpak
that use sandboxes to run applications.  Making the gain of being able
to construct your own sandboxes something that has practical utility.
I believe that sandboxes make it more difficult for attackers to
achieve the ability to run arbitrary unprivileged userspace code.


So I think user namespaces are better default on.  Having user
namespaces default on means that people find them available and use
them.  Asking people to code for enviroments where user namespaces
may be on, may be off to the best I believe will encourage people
not to use the best tools that are available for securing their
applications, and so will be a net detriment to the community.

That is why max_user_namespaces looks like all it is good for is
preventing the user namespace equivalent of fork bombs, but is in fact
trivially capable of disabling user namespaces in sandboxes.

I do think there are cases where things get locked down and sandboxed
and tight that people should disable anything and everything they don't
need.  That in those case you want to implement the principle of least
privilege.  I see no problem with supporting those kinds of systems.

>> I don't know.  I tried to have the conversation and Paul shut it down.
>
> I really get the feeling that the problem here is that you're not even
> acknowledging the whole issue to begin with, since you mention that
> "max_user_namespaces" not once, but twice in the email.

Mentioning max_user_namespaces was my point that I very much see the
need for some controls.  That there are some already existing and
that is the one I built in the kernel already.  Not a contention
that these are good enough.

Saying Paul was the one who shut things down was probably going a bit
too far.  But I am very frustrated that the my attempts to figure out
what was going on.


>> It would be the easiest thing in the world in security_capable to
>> ask is this a trusted app, if not the answer is no.
>
> Isn't this *literally* what security_create_user_ns() would basically
> be doing?

The actual implementation of security_create_user_ns() current creates
regressions in userspace.

So I think the current implementation needs to be reverted, and the
current failure paths in create_user_ns with the same behavior need to
be fixed and we can talk about what are appropriate mechanisms to add
to the kernel.

I trust you can handle the revert of the regression.  At the moment I
have spent way more time on this then I have time for.  My family needs
me.

Eric
