Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 126A16BF0E1
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 19:41:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjCQSlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 14:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjCQSlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 14:41:08 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 797282412D
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 11:41:06 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id cy23so23857578edb.12
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 11:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1679078465;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qLt5F1/Ugauyf5shEntzjWUG+KhzEEAAsNAk/6CtFTE=;
        b=lcoDKNmu1EfwcWHjdgwtVGLMa25SD/WC8VLwf7alwUeGfLq6eshSCJ22WOuJDtfOzb
         6/69b0NxZlClU5YgYlWRL8KpAmwIWQOSw0civfngs2yfIhF6JLwFMe4Seg9TFyZh9GrZ
         ytK+xvIOsMaQMd0BDqriHu/ELLUBiM0R0xAE1a2wv1u2LtV43klnMANaaqS68vU0nD2f
         /oh9MQFTDdOXS+q+z69HiGaIdllndDY+7zS54Xou9egCnSJjupfgWj3u+aX8dQhHyUNi
         Odh6bYxbmS79lr3QcCbLkCRU0JcC9lu5c0Z0hbPYrIEVRyRPEuJ6YtlAIkalOl8gNkdz
         75gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679078465;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qLt5F1/Ugauyf5shEntzjWUG+KhzEEAAsNAk/6CtFTE=;
        b=b8pSw6usKCr46Wt6sTjclLLf2KVvExvkXwYOuL4NtokHepuJkSY6he0M5PI6Yz8e7K
         X5vu/3QJ44zSvWtVppZkYPFAfwx6VWh44e3M3uk//nXz1ulSHIZJbd3bcKHGDgqx/jWa
         hnZMmfUp21ovw6NJwz16gfWOoxdtQCLNaePawaejZklFYRP7iBXL2b5Xj6T0Qjsu6Cg5
         hqfGCW3ggmgwAF04Nmi8/IQy5cjI7ESNtEvR3tf2ObljrCyc1x8Aa96GL+1Nq1DAJBb9
         fQaMTnjZcF6HtHMsgXd0GsU6sdOg1BkGo7nAugQJgU2D8iwZW9aFdAtTeqducmkNi0x5
         dstw==
X-Gm-Message-State: AO0yUKVtgCxgB8DGbWJFyogjWCAKyEU1HOXima66BAt3xlKt9kbQ9TsV
        rem053C1LENwpN12S5NJiYuoWA==
X-Google-Smtp-Source: AK7set9zmfshHjflDBnfziFdWGSSG/cPG5ezsYRMkRCGB0k0XRTVRYAcMr0jg//ExGnmLG9ZrZDnQw==
X-Received: by 2002:a17:906:d8d6:b0:886:ec6e:4c1 with SMTP id re22-20020a170906d8d600b00886ec6e04c1mr400460ejb.59.1679078464904;
        Fri, 17 Mar 2023 11:41:04 -0700 (PDT)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id v2-20020a170906292200b009321cd80e15sm883836ejd.73.2023.03.17.11.41.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Mar 2023 11:41:04 -0700 (PDT)
Message-ID: <7974f3ec-3f17-c21c-139b-fd5651871a75@tessares.net>
Date:   Fri, 17 Mar 2023 19:41:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 0/2] docs & checkpatch: allow Closes tags with links
Content-Language: en-GB
To:     Daniel Vetter <daniel@ffwll.ch>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     Thorsten Leemhuis <linux@leemhuis.info>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        =?UTF-8?Q?Kai_Wasserb=c3=a4ch?= <kai@dev.carbon-project.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        mptcp@lists.linux.dev
References: <20230314-doc-checkpatch-closes-tag-v1-0-1b83072e9a9a@tessares.net>
 <c27709bd-90af-ec4f-de0b-3a4536bc17ca@leemhuis.info>
 <81f8be3e-4860-baf9-8e13-fec3a103245b@tessares.net>
 <CAHk-=wh0v1EeDV3v8TzK81nDC40=XuTdY2MCr0xy3m3FiBV3+Q@mail.gmail.com>
 <CAKMK7uESvC-zgGJEup1OAmf34Rk8s5cCrSBYUNP_REFUuer1-w@mail.gmail.com>
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <CAKMK7uESvC-zgGJEup1OAmf34Rk8s5cCrSBYUNP_REFUuer1-w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, Daniel, Konstantin,

@Linus, Daniel: Thank you both for your replies!

@Konstantin: I have one question for you at the end of this email if you
don't mind.

On 17/03/2023 17:58, Daniel Vetter wrote:
> On Thu, 16 Mar 2023 at 18:30, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> On Thu, Mar 16, 2023 at 4:43 AM Matthieu Baerts
>> <matthieu.baerts@tessares.net> wrote:
>>>
>>> @Linus: in short, we would like to continue using the "Closes:" tag (or
>>> similar, see below) with a URL in commit messages. They are useful to
>>> have public bug trackers doing automated actions like closing a specific
>>> ticket. Any objection from your side?
>>
>> As long as it's a public link, I guess that just documents what the
>> drm people have been doing.
>>
>> I'm not convinced "Closes" is actually any better than just "Link:",
>> though. I would very much hope and expect that the actual closing of
>> any bug report is actually done separately and verified, rather than
>> some kind of automated "well, the commit says it closes it, so.."
>>
>> So honestly, I feel like "Link:" is just a better thing, and I worry
>> that "Closes:" is then going to be used for random internal crap.
>> We've very much seen people wanting to do that - having their own
>> private bug trackers, and then using the commit message to refer to
>> them, which I am *violently* against. If it's only useful to some
>> closed community, it shouldn't be in the public commits.
> 
> Yeah I think that's fine. The bot can then autogenerate a request in
> the bug report to confirm that it's fixed, and ask the reporter to
> close in that case. And then maybe if there's no message a few weeks
> after the release, auto-close or something.

That would be a nice behaviour indeed. That's just a shame it means we
cannot use the default behaviour of these bug trackers and we need a
dedicated bot instead. I don't know what's the behaviour with GitLab and
other bug trackers but with GitHub, when a commit is seen in a public
repo with a "Link:" tag pointing to an issue, a "special" comment is
added to the bug report but no notifications are sent. So if we don't
implement the bot you described, we will still have to do the tracking
manually.

I understand we can see that as an issue with the existing service but
it also means we cannot use their build-in automations.

Maybe it means we have to switch to Bugzilla and wait for the new bot :)
(but no, I don't want to add pressure on Konstantin ;) )


> Bot needs to make sure it's only parsing tags for the instance it's
> botting for anyway, so overloading Link: with all the meanings
> (absolutely all themeanings!) is not really a problem since Closes:
> has the same issue if different subsystems use it for different bug
> tracking needs.

Here, "Closes:" would be used exclusively with a URL to a specific bug
report, not just "Closes: #1234". Would this not work if different
subsystems use it?

An extra check could be added to checkpatch.pl to display a warning if
this "Closes:" tag is not used with a URL.

In the case of GitHub -- and GitLab if I'm not mistaken -- there are
some safeguards: the closure is only done if a commit having the
"Closes:" tag to the bug report is applied into a specific branch. In
other words, if someone applies the same patch elsewhere, the bug report
will not be closed automatically. Also in case of closure, a
notification is also sent and the bug report can be re-opened if
something wrong happened.

>> And while the current GPU people seem to use "Closes:" the right way
>> (and maybe some other groups do too - but it does seem to be mostly a
>> freedesktop thing), I really think it is amenable to mis-use in ways
>> "Link:" is not.
> 
> Huh I didn't realize this picked up. Way back we used Bugzilla: for
> this sometimes, but I think just using Link: for everything and
> letting instance-specific bots figure out whether it's relevant for
> them should be perfectly fine. Humans should have no problem parsing
> meaning out of a tag soup anyway (I mean we have Cc: stable meaning
> backport after all, and I think that address is a blackhole).
> 
> I guess if you feel strongly we can percolate this a bit to
> submaintainers and contributors in drm.

I understand the risks of being misused by some and I guess the main
point here is that we want to avoid exceptions.

On our side with MPTCP, if we can definitively no longer use the
"Closes:" tag, we will find alternatives. Probably by rewriting patches
containing them before sending patches to netdev. This way we can
continue to use the feature internally and when sent upstream, the
commits will contain Fixes tag instead :)


So correct me if I'm wrong but the conclusion is then to stop using the
"Closes:" tag to avoid misuses. In this case, we can of course drop this
series.

@Konstantin: would it be OK for your future Bugzilla bot to deal with
the generic "Link:" tag instead of the specific "Closes:" one?

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
