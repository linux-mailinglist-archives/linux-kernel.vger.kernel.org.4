Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8B9F5F54CF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 14:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbiJEM7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 08:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiJEM7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 08:59:33 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 948A67823E;
        Wed,  5 Oct 2022 05:59:32 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:52138)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1og3zn-00BkiA-Kh; Wed, 05 Oct 2022 06:59:31 -0600
Received: from ip68-110-29-46.om.om.cox.net ([68.110.29.46]:48256 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1og3zm-008PSK-Oj; Wed, 05 Oct 2022 06:59:31 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Paul Moore <paul@paul-moore.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CAHC9VhShpEVTuogj4h74PxbEeTUNn4odo8SE6GBvb6sGUM0LHw@mail.gmail.com>
        <87sfk3mim9.fsf@email.froward.int.ebiederm.org>
        <CAHk-=wiCqicQrnQPeHbDF7ECKHk_ceYzZK5dYq7y5nZTZhpB8g@mail.gmail.com>
        <CAHk-=wjjKsSmNVLa1e22Q29-YUEXWtS39d7EDkcN8v_E7SoKGA@mail.gmail.com>
Date:   Wed, 05 Oct 2022 07:59:24 -0500
In-Reply-To: <CAHk-=wjjKsSmNVLa1e22Q29-YUEXWtS39d7EDkcN8v_E7SoKGA@mail.gmail.com>
        (Linus Torvalds's message of "Tue, 4 Oct 2022 14:30:35 -0700")
Message-ID: <87czb6h1eb.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1og3zm-008PSK-Oj;;;mid=<87czb6h1eb.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.110.29.46;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX194papHtAgjuUo54RQw7kyhgOiDF0VRh3g=
X-SA-Exim-Connect-IP: 68.110.29.46
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *****;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 343 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 15 (4.2%), b_tie_ro: 12 (3.6%), parse: 1.06
        (0.3%), extract_message_metadata: 14 (4.2%), get_uri_detail_list: 1.56
        (0.5%), tests_pri_-1000: 17 (5.0%), tests_pri_-950: 2.0 (0.6%),
        tests_pri_-900: 1.62 (0.5%), tests_pri_-90: 98 (28.6%), check_bayes:
        95 (27.8%), b_tokenize: 6 (1.9%), b_tok_get_all: 8 (2.4%),
        b_comp_prob: 3.0 (0.9%), b_tok_touch_all: 72 (20.9%), b_finish: 1.66
        (0.5%), tests_pri_0: 179 (52.1%), check_dkim_signature: 0.55 (0.2%),
        check_dkim_adsp: 3.3 (1.0%), poll_dns_idle: 1.40 (0.4%), tests_pri_10:
        2.4 (0.7%), tests_pri_500: 9 (2.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [GIT PULL] LSM patches for v6.1
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Tue, Oct 4, 2022 at 1:55 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> So this whole "don't do this" approach you have is not acceptable.
>
> Side note: if we have a security hook for "create random file", then
> the notion that creating a whole new namespace somehow must not have
> any security hooks because it's *so* special is just ridiculous.
>
> I also note that right now USER_NS is both "default n" and "if not
> sure, say 'n'" in the Kconfig files, even though obviously that ship
> has sailed long ago.

Definitely.  I did try and slow the up take as long as I could when
the code was maturing.

> So originally it might have been a reasonable expectation to say "only
> enable this if you're doing containers in servers", but that clearly
> isn't the case any more. So we basically take USER_NS for granted, but
> the fact that people might want chrome to use it for sandboxing does
> *not* mean that randomly we want any CLONE_NEWNS to just be ok,
> regardless of how trusted (or not) the case is.

Most importantly chrome shows how the mechanism this patch is using to
deny user space applications is one that ``breaks'' userspace.  AKA
causing to silently fall back on less tested code paths that existed
before user namespaces were common.  Any application that does this
uses less trusted code paths.

I am pretty certain that the code should be sending a fatal signal
instead of returning an error code on user namespace creation.  I
unfortunately hadn't realized the implications until this conversation.



That said Chrome and sandboxing I think is a reasonable case to look at
to demonstrate the trade-offs.  This is not all about increased kernel
attack surface, user namespaces also enable reduced attack surface in
sandboxes, which can make applications safer.

Eric
