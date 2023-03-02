Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C555F6A79F7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 04:19:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbjCBDT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 22:19:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjCBDT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 22:19:27 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A8293A99
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 19:19:26 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id i12so9682999ila.5
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 19:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677727165;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R/+65KgUux6M/KjkKXP6fqk1tnD3vpVSO0nQnts9lo8=;
        b=NRJYXjOqYePrHzjJdowU9/9d0bK7PFixIsZVzBb9PfsNwHf9dWwMlTZqN+isaBe3id
         bn7u71F05aXFxEJdng20CzrlJpOeHrVBSqqyTbW7Yc1wUCqR2B8sJdada3fFlogtF1nI
         mSdcRLj6lQPmDM+HL9FA336fjwR3GD9XxRyrtfLOd3Z4RP1ZU6C1wb9MG6P9rFtF8c8M
         jOkrRHFAs5aiot48MvrCz2ATNPhr9i0v9foapzRA3lRdNdopKY0zw3uOmIsPNTvRZH66
         Yn7D+YBDqTNYGYpA2K04pqCIiSM/qdBLAatTnJUkYj2CIZtiN4SHt60nlzS566nJikWc
         QRXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677727165;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R/+65KgUux6M/KjkKXP6fqk1tnD3vpVSO0nQnts9lo8=;
        b=5MJoWsuI1VfI9pD/LpF0qlflW8iOUIxcgWcRHSQrttC/tVokSDm/HBUs+h/VhODSay
         IoDCZc1py+2HTf+ReVy/IIgXXvr+S08xdsKir9d/wRaIKKMnMKO2lo/btbl7J2CgP0v0
         7hLoppAGM8kJyY7gcXIL8GJZl4jlwlaeiXEbuDeOWSLzet0aQkW3y74nS0eY+LJpiF0M
         yBkVusFNt80O7WstjuTMbUU9gbzfWvq1JgJqfnPoexp7c/Yi3fYU9+z/H/AxG3qisFko
         G4/UXspMT4dmsWXg0Zny072kHg0Rrf17SzAgq7/2Nk/dH640lNdTM6182yV5CEcQIWPv
         xy1A==
X-Gm-Message-State: AO0yUKVIod5o9L7A1yxSmR/CKZRzny7CPnPSXwpkVrDOwvnfuVMYlPYe
        cpkVL42X3BwhRA+fz6nlaOo=
X-Google-Smtp-Source: AK7set8ECM22OhS8ypV8uochFDnUx/8A8kYjn376yv9yw0Tq/BF1BNWBURvgKTPQAcYNNlvmnJaNUQ==
X-Received: by 2002:a05:6e02:1529:b0:316:e6e4:56ff with SMTP id i9-20020a056e02152900b00316e6e456ffmr8889723ilu.1.1677727165322;
        Wed, 01 Mar 2023 19:19:25 -0800 (PST)
Received: from localhost ([2607:fea8:529d:4d00::eba0])
        by smtp.gmail.com with ESMTPSA id k20-20020a056e02135400b0031830e2c987sm286655ilr.20.2023.03.01.19.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 19:19:24 -0800 (PST)
Date:   Wed, 1 Mar 2023 22:19:22 -0500
From:   Richard Acayan <mailingradian@gmail.com>
To:     Hector Martin <marcan@marcan.st>, linux-kernel@vger.kernel.org
Cc:     Asahi Lina <lina@asahilina.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Michael Dolan <mdolan@linuxfoundation.org>
Subject: Re: Linux kernel DCO
Message-ID: <ZAAVuo81E3XA6/LS@radian>
References: <Y820a/niMYtHfe8k@radian>
 <58a5ad01-dbfc-04a7-2234-c57bb627ee84@marcan.st>
 <Y84K1N3fzz/J4Pxa@radian>
 <6d96fb3c-9027-c612-fca4-e22c7c19186f@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d96fb3c-9027-c612-fca4-e22c7c19186f@marcan.st>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jan 23, 2023 at 01:50:33PM +0900, Hector Martin wrote:
> On 23/01/2023 13.19, Richard Acayan wrote:
>> On Mon, Jan 23, 2023 at 10:42:21AM +0900, Hector Martin wrote:
>>> Hi,
>>>
>>> On 23/01/2023 07.13, Richard Acayan wrote:
>>>> 	Considering marcan knows you enough to let you use his stream
>>>> 	keys, his own sign-offs might properly certify the origin of
>>>> 	these patches. No matter how this was done, it should be
>>>> 	documented in case someone in a similar situation wants to
>>>> 	contribute pseudonymously and possibly anonymously.
>>>
>>> This is standard procedure for patches submitted to subsystem trees
>>> (i.e. us subsystem maintainers have to sign off before committing to our
>>> tree and sending the pull upstream). That means patch authorship
>>> concerns are something for us maintainers to worry about, not any
>>> downstream kernel users.
>> I hope Will Deacon knows what they're signing up/off for in [6], then.
>> 
>> Is this documented? How would anyone know?
>
> And therein lies the problem with the "rule". It is unenforceable, and
> completely unenforced. Nobody is checking IDs, nobody expects to check
> IDs, and nobody expects people to check IDs.
>
> When Arnd signed my PGP key and blessed me as a sub-maintainer, he
> *explicitly* made a point to me that what the kernel community cares
> about is continuity of authorship and trust, not whatever combination of
> characters happens to be attached to it, and declined to check my ID.
>
> See also the DRM maintainers' opinion:
>
> https://lore.kernel.org/dri-devel/CAPM=9twCiqyakgPLz0v=7-abUhzLb8ZZH7-U65PV8qtQOP7Xww@mail.gmail.com/
>
> Now Greg might disagree with this, but this is already the stance of a
> good fraction of the kernel community, as you can see. Just because Greg
> sent a change 17 years ago doesn't mean everyone today thinks it's a
> good idea or even meaningful in any practical way.
>
>>> Without commenting on Lina's situation in particular, you should know
>>> that there are already quite a few pseudonymous contributions to the
>>> Linux kernel (if you go digging through git logs, it won't take long to
>>> find some interesting names - try grepping for 'George Spelvin'). So
>>> again, if this were of significant concern downstream, that would've
>>> been brought up long ago.
>> I was not aware of this. Nor was "Newbyte", with 3 patches applied to
>> linux-next, or "Hakurei Reimu", someone who does work on old Samsung

In retrospect, I did not ask these people for permission before
mentioning them. Maybe they knew and chose to do away with aliases
anyway.

>> phones, with 22. The chat log [4] shows how this was discovered at all,
>> initially starting with a tweet/toot [7][8].
>> 
>> Documentation/process/submitting-patches.rst:
>> 
>> 	then you just add a line saying::
>> 	
>> 		Signed-off-by: Random J Developer <random@developer.example.org>
>> 	
>> 	using your real name (sorry, no pseudonyms or anonymous contributions.)
>> 
>> The kernel documentation tells you to use your real name when submitting
>> patches. That's what most people, distro maintainers and contributors
>> alike, expect as a rule. To reiterate my last quoted sentence, maybe
>> this should be changed so the rules aren't confusing?
>
> Distro maintainers don't and absolutely should not care because their
> job is not to audit kernel contributions for authorship. The vast
> majority of open source projects do not have any such rules, including
> Mesa (where Lina was just made an official maintainer and given commit
> access a few days ago, for whatever that's worth). No distro has a rule
> that all contributions to all packaged software must use real names,
> because such a rule would disqualify the vast majority of the open
> source ecosystem. It is only the kernel and a few (mostly
> corporate-managed, draconian-CLA-required style) projects that have this
> kind of rule. And so it is for those projects to deal with, not any
> consumers.
>
> I agree that this should be changed (for many reasons, I could write
> about this at length), and as I'm sure you can imagine, such change
> would probably have to be a coordinated push with buy-in from several
> kernel stakeholders. So I would appreciate it if you don't turn this
> into a public discussion at this time, and let us figure out how to deal
> with it when the time comes.

Sorry to bother you, but what happened?

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=d4563201f33a022fc0353033d9dfeb1606a88330

Two Acked-by's are a bit underwhelming for a coordinated push with
buy-in from several kernel stakeholders. According to the commit
message, there wasn't even much of a discussion since the first email in
this thread.

Did Linus have an afterthought this weekend, independant of this
discussion? Did that "fire" Mastodon toot have anything to do with this?

With my first contribution, I had the perception that anyone with a
computer and good email provider (there are some practical exceptions to
this) could contribute to the mainline Linux kernel. After managing
someone's 5-year-old patch, I percieved that you can even do it by
accident.

Of course, it's easy to call this naive and ignorant. I accepted this
explanation and respected this request to not turn this into a public
discussion until the time comes. Now, I wonder if this patch was written
and applied later than it should have been because we misunderstood the
kernel contribution process as an aristocracy for this specific case.

>
> - Hector
