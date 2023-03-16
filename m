Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAC196BCE9D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 12:43:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbjCPLn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 07:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjCPLnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 07:43:55 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 648392004B
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 04:43:52 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id x13so6477278edd.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 04:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1678967031;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=thUFjFBGjR3fhOfIi9hVXRjQGGNCMGLil0BHgmTo/ic=;
        b=KyeM9k0ZKw4NJASVXPNZ0vzzWep932EWoZHPycDlavk6txL1/DqQqg0mTQHmVoBHB8
         V9ld6c8BWWd4ejSmes2n1NVAVRiMfE9S7xTmzhYXHIdu/VCiPbCBxVc7kQqy2r3f1Ofj
         iL5ddMWOlA3dzOSwuoO9rJO+oAZ4dOzntwgYZRpbKJrHi82UH8VpTBxtxrq5YAfexj2s
         4XtUvrhiXsokBnZxxZG+aSub9HBETU1W5BzCwFszLte9Ot1aFRCT/6MwFMcW1rtBHfiv
         bsrIUxjk65K7fryaETQblboHu1M+n0igZBu8/imWB/nTu12GUKLLsoU+ZewJ9v4dTkXK
         ptDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678967031;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=thUFjFBGjR3fhOfIi9hVXRjQGGNCMGLil0BHgmTo/ic=;
        b=fpZiELwIsJW7FD3W9WIIV/9fTgZwX/WRlNsFjQw21YiBCtXM3/OEx4R68uzc3olec1
         3wLLWOjfULbqHaepXdx6hqP7jGKTs5vqNN4ObOD1czz45PtGPvvt6Z4zkf1WbakpuWr4
         YQH8RcNQ3ldF+9fzKQ/6ExCNHwI5f8Lq/QE7i4J7RvyR6/8nCWh57JCfnFx6hN7zDqgQ
         80lMxuwC84qQd5HAcpr4qKLf8WEmVMW7X5q8GVX/OYyW6SmHeuAfYahMwoyjTn8oUbpN
         5sqkbswwWa4OYlXF343BbVQgF681pWlALFl0J2qXqmASDQcjn1utu/05VlmJmhZ4nROk
         VXiQ==
X-Gm-Message-State: AO0yUKVnfoq0UfUTbvonlAMV0JayYyoxsGe+vaR2fxNqpEs+c/K5dFyq
        Qf7Ox9pmiYSpSZN9rQsTwkUCZQ==
X-Google-Smtp-Source: AK7set9DzddMMCMd0B+4V/kLF1eWBlJyzgxJJXNzHSTU0T9xuZkAhz9WVCq1iaeT3rYerBx/YztakQ==
X-Received: by 2002:aa7:d99a:0:b0:4fb:78a0:eabf with SMTP id u26-20020aa7d99a000000b004fb78a0eabfmr5903708eds.29.1678967030711;
        Thu, 16 Mar 2023 04:43:50 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:118:fc7d:1ce3:f580? ([2a02:578:8593:1200:118:fc7d:1ce3:f580])
        by smtp.gmail.com with ESMTPSA id s26-20020a508d1a000000b004bef1187754sm3685504eds.95.2023.03.16.04.43.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Mar 2023 04:43:50 -0700 (PDT)
Message-ID: <81f8be3e-4860-baf9-8e13-fec3a103245b@tessares.net>
Date:   Thu, 16 Mar 2023 12:43:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 0/2] docs & checkpatch: allow Closes tags with links
To:     Thorsten Leemhuis <linux@leemhuis.info>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        =?UTF-8?Q?Kai_Wasserb=c3=a4ch?= <kai@dev.carbon-project.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, mptcp@lists.linux.dev
References: <20230314-doc-checkpatch-closes-tag-v1-0-1b83072e9a9a@tessares.net>
 <c27709bd-90af-ec4f-de0b-3a4536bc17ca@leemhuis.info>
Content-Language: en-GB
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <c27709bd-90af-ec4f-de0b-3a4536bc17ca@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thorsten, Linus,

@Linus: in short, we would like to continue using the "Closes:" tag (or
similar, see below) with a URL in commit messages. They are useful to
have public bug trackers doing automated actions like closing a specific
ticket. Any objection from your side?

The full thread is visible there:

https://lore.kernel.org/linux-doc/20230314-doc-checkpatch-closes-tag-v1-0-1b83072e9a9a@tessares.net/T/


@Thorsten: thank you for your reply!

On 16/03/2023 10:22, Thorsten Leemhuis wrote:
> On 15.03.23 18:44, Matthieu Baerts wrote:
>> Since v6.3, checkpatch.pl now complains about the use of "Closes:" tags
>> followed by a link [1]. It also complains if a "Reported-by:" tag is
>> followed by a "Closes:" one [2].
>>
>> As detailed in the first patch, this "Closes:" tag is used for a bit of
>> time, mainly by DRM and MPTCP subsystems. It is used by some bug
>> trackers to automate the closure of issues when a patch is accepted.
>>
>> Because this tag is used for a bit of time by different subsystems and
>> it looks like it makes sense and it is useful for them, I didn't bother
>> Linus to get his permission to continue using it. If you think this is
>> necessary to do that up front, please tell me and I will be happy to ask
>> for his agreement.
> 
> Due to how he reacted to some "invented" tags recently, I'd think it
> would be appropriate to CC him on this patchset, as he then can speak up
> if he wants to (and I assume a few more mails don't bother him).

Sure, just did with a short summary.

>> The first patch updates the documentation to explain what is this
>> "Closes:" tag and how/when to use it. The second patch modifies
>> checkpatch.pl to stop complaining about it.
> 
> I liked Andrew's `have been using "Addresses:" on occasion. [...] more
> humble [...]` comment.  Sadly that tag is not supported by GitLab and
> GitHub. But well, "Resolves" is and also a bit more humble if you ask
> me. How about using that instead? Assuming that Konstantin can work with
> that tag, too, but I guess he can.

I don't mind changing the tag name but I still have a preference to use
'Closes:' simply because it was used ~500 times in the past.

If we want to change, it is probably the best time to do so but for me,
the fact we -- MPTCP subsystem -- use the same tag as the DRM subsystem
(and ClangBuiltLinux and Debian) without consulting each other -- if I'm
not mistaken -- is a sign it is a good tag :)

> I also wonder if the texts for the documentation could be shorter.
> Wouldn't something like this do?
> 
> `Instead of "Link:" feel free to use "Resolves:" with an URL instead, if
> the issue was filed in a public bug tracker that will consider the issue
> resolved when it noticed that tag.`
> 
> [s/Resolves/Closes/ if we stick to that]

Sure, I'm not used to write doc and I appreciate your suggestion to
improve that. I might change one or two words but I have no objection to
write this in the v2 once we agreed on the name of this tag.

Also, should I use the same text in both process/5.Posting.rst and
process/submitting-patches.rst?

> Side note: makes we wonder if we should go "all in" here to avoid
> confusion and allow "Resolves" everywhere, even for links to lore.

Personally, I would recommend that, it might even be useful for other
bots like regzbot: a patch can be linked to one discussion but not
fixing the issue and even fixing another one instead. It might be useful
for a bot to be able to distinguish the two without depending on a not
100% reliable AI ;-)

A concrete example: patch 1/2 of this series is linked to a bug report
[1]. The ticket can be closed only when patch 2/2 will be applied.

Cheers,
Matt

[1] https://github.com/multipath-tcp/mptcp_net-next/issues/373
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
