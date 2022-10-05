Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28F365F54AB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 14:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbiJEMj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 08:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiJEMj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 08:39:26 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A018440E3F;
        Wed,  5 Oct 2022 05:39:25 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:53254)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1og3gJ-00BjAv-M8; Wed, 05 Oct 2022 06:39:23 -0600
Received: from ip68-110-29-46.om.om.cox.net ([68.110.29.46]:50842 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1og3gI-00CVVW-HM; Wed, 05 Oct 2022 06:39:23 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Paul Moore <paul@paul-moore.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CAHC9VhShpEVTuogj4h74PxbEeTUNn4odo8SE6GBvb6sGUM0LHw@mail.gmail.com>
        <87sfk3mim9.fsf@email.froward.int.ebiederm.org>
        <CAHk-=wiCqicQrnQPeHbDF7ECKHk_ceYzZK5dYq7y5nZTZhpB8g@mail.gmail.com>
Date:   Wed, 05 Oct 2022 07:38:45 -0500
In-Reply-To: <CAHk-=wiCqicQrnQPeHbDF7ECKHk_ceYzZK5dYq7y5nZTZhpB8g@mail.gmail.com>
        (Linus Torvalds's message of "Tue, 4 Oct 2022 13:55:17 -0700")
Message-ID: <87r0zmigx6.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1og3gI-00CVVW-HM;;;mid=<87r0zmigx6.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.110.29.46;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX18MKibCyEaL4f/gAWn5QHd12mbofl/2n5I=
X-SA-Exim-Connect-IP: 68.110.29.46
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Virus: No
X-Spam-DCC: XMission; sa03 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 614 ms - load_scoreonly_sql: 0.02 (0.0%),
        signal_user_changed: 4.5 (0.7%), b_tie_ro: 3.0 (0.5%), parse: 1.16
        (0.2%), extract_message_metadata: 15 (2.4%), get_uri_detail_list: 3.3
        (0.5%), tests_pri_-1000: 11 (1.9%), tests_pri_-950: 0.99 (0.2%),
        tests_pri_-900: 0.78 (0.1%), tests_pri_-90: 243 (39.6%), check_bayes:
        231 (37.6%), b_tokenize: 6 (1.0%), b_tok_get_all: 8 (1.3%),
        b_comp_prob: 2.6 (0.4%), b_tok_touch_all: 211 (34.4%), b_finish: 0.76
        (0.1%), tests_pri_0: 325 (52.9%), check_dkim_signature: 0.40 (0.1%),
        check_dkim_adsp: 2.5 (0.4%), poll_dns_idle: 0.82 (0.1%), tests_pri_10:
        2.6 (0.4%), tests_pri_500: 7 (1.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [GIT PULL] LSM patches for v6.1
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Tue, Oct 4, 2022 at 1:37 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>>
>> Please don't pull the user namespace bits of this code.
>
> Eric, already done.
>
> And I think you are in denial about how many problems the
> user-namespace stuff has caused.
>
> Distros are literally turning it off entirely because the whole "let
> users create their own namespace" has *NOT* been a great success.
>
> I personally think it was a mistake. We're stuck with it, but we most
> definitely need knobs to manage it that isn't just "enable/disable
> USER_NS" in the kernel config.
>
> So this whole "don't do this" approach you have is not acceptable.
>
> 99% of all code does NOT WANT the user namespace thing, and it's been
> a big new attack surface for the kernel getting things subtly wrong.

Yes. I know, and I keep saying geez guys isn't this the problem?
And I get told nope.  That isn't it.


> I do not understand your "people need to be able to do this with no
> controls", when the alternative is to literally turn it off ENTIRELY.

We already have /proc/sys/user/max_user_namespaces.  It is a per userns
control so you can run it in as fine grain as you like.  A little
cumbersome perhaps but real.

> I'm not saying that an LSM is the only place to do it, but I don't
> think there have been any better suggestions either.

I don't know.  I tried to have the conversation and Paul shut it down.
Effectively he said that where two or more out of tree LSM policies want
something it makes no sense to discussion the actual reasons people want
to use the hook.

> Put another way: your "no limits are acceptable" is simply not
> realistic, and you haven't given any sane alternatives that I am aware
> of. No way to say "sure, let trusted system apps create their
> namespaces, but not random things".

That isn't my position at all, that isn't even the case in the current
code.

In there current code there are two mechanisms that can be used to limit
things to secure system apps.  There is
/proc/sys/user/max_user_namespaces, and the security_capable hook in the
LSM.

I can imagine that /proc/sys/user/max_user_namespaces could be a bit
awkward to use as things need to be shuffled around a bit to get
a user namespace in place that you can use to set your number additional
user namespaces to 0, for the untrusted apps.

I can imagine that security_capable being a little unintuitive to find
but it has a parameter telling you it wants a capability from a
non-default user namespace.

It would be the easiest thing in the world in security_capable to
ask is this a trusted app, if not the answer is no.



My big objections are: Paul Moore shutdown the entire discussion into
why this is needed and alternatives, and that the mechanism the hook
is using silently breaks userspace applications.

In particular chrome's sandbox is silently disabled.  So in practice I
see this change advocating for silently stripping security from
userspace applications.

There is a security trade-off between attack surface and securing
applications here that I could never get the conversation around too.

My sense is that Paul figures with the policy in userspace (AKA the code
that actually uses these hooks), that it is completely out of scope to
consider what functionality the hooks make available.

In short I completely failed to have any reasonable conversations about
this code or it's implications, and it breaks userspace.

Eric

