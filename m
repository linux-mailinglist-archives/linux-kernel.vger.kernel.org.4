Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 340B7679B25
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 15:09:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233953AbjAXOJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 09:09:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233508AbjAXOJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 09:09:07 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A9ED42BDC;
        Tue, 24 Jan 2023 06:09:06 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id v6-20020a17090ad58600b00229eec90a7fso1740904pju.0;
        Tue, 24 Jan 2023 06:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E4ZXFPQbjBHo1EROCk4SYmBdv33HRf/eYQ7E1Z4yJ6c=;
        b=B4ewlu/nHDWD1ZdBVb0iqOhNibN1rV5/EZF8TdXGV5XSTQFohtmjemfGZQZcqHPVlp
         ws1hVP8LuFp22/BrNoxzdwRRgXeuH9nbt4axQmhsCiDnWSb1ARSOGQ37fDVkz5TIEyaJ
         KsXDCpMoYYBPPjUG30CW1GB5kuNRts9XYS2MKmgARJHkr+T/0WwddSLiXKMoZeqxBh79
         NO8xioKpXXc0W6yHbGZbsQRUDL1SfjmZmSeR6ML1yON8lXO5dZKj6GaT8n9vi+8mSWEp
         s5DcWPzDQozMOIUj8cG6IOPBPnoqVXqEo/aooy+q/j/1ExXJ5jErwIaWL59FuFGBzqJa
         d65g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E4ZXFPQbjBHo1EROCk4SYmBdv33HRf/eYQ7E1Z4yJ6c=;
        b=TMXygni9+FvcXa5kT3Sg/0hRS993SS6GQ/Rf0NDZa6cKSo4fuNnScqHZJoRAHUf2Wf
         rlPN5qQX56vU0nVDilPsP/pQvRvkzhFgmiW5tHA1a/fU6P4U4QW74jlnRzWX7ySQ6QSu
         nBTxCxuPYkbvSnm/V3y8K1Rachv4eov/A8OUhVt/7J5L+XT07oyY2ut2f37TTkj9uwDU
         WlA8Qn24Tqh7ttAdP0AWUDN5P2TcqQWrlwy0YG/Jy5CrAwb0EtbxBeY18U0rpC0QrN0q
         CJYDIC5CHQZROY7BedJjjcFtkU2Fe03d7t7fKeRMgnuumaxUm2BVQethP8zdausbcHBC
         nK0g==
X-Gm-Message-State: AFqh2krwaYzcA52DKAvoyFOd6fVs7cn0I6AB2ye7qTqM7gp1f2aXzvjg
        Ycp0FmMxtCc4CqsOWAGkwYNizCm7VXl7aw==
X-Google-Smtp-Source: AMrXdXvPHzbgF3TWr0WobWk8KmSIuNyKVP8DTLJbWsoK8FphoZRA+kRYiaQxRbLjp7Lh4W3QGMo58g==
X-Received: by 2002:a05:6a20:8f0f:b0:b8:a0e1:2748 with SMTP id b15-20020a056a208f0f00b000b8a0e12748mr39818074pzk.6.1674569345602;
        Tue, 24 Jan 2023 06:09:05 -0800 (PST)
Received: from [192.168.43.80] (subs02-180-214-232-28.three.co.id. [180.214.232.28])
        by smtp.gmail.com with ESMTPSA id a3-20020aa78643000000b0056bbeaa82b9sm1631072pfo.113.2023.01.24.06.09.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 06:09:04 -0800 (PST)
Message-ID: <526ffdf0-3aaa-2ccc-c5b6-ea5582e251a5@gmail.com>
Date:   Tue, 24 Jan 2023 21:09:01 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] module.h: Fix full name of the GPL
Content-Language: en-US
To:     Diederik de Haas <didi.debian@cknow.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "open list:MODULE SUPPORT" <linux-modules@vger.kernel.org>,
        "open list:MODULE SUPPORT" <linux-kernel@vger.kernel.org>
References: <20230122193443.60267-1-didi.debian@cknow.org>
 <Y89HHtQQ4/pvsOut@debian.me> <3145585.5fSG56mABF@bagend>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <3145585.5fSG56mABF@bagend>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/24/23 20:32, Diederik de Haas wrote:
> *) I made a clusterfsck of similar patch submissions where I replaced "GNU 
> Public License" with "GNU General Public License", and got the exact same 
> comment from Bagas to several of them.

That was what I mean: not being word-for-word same, but semantically same
text. I guess everyone here (and myself) should be immersed more into
English-speaking idioms...

If you'd like to see what my reviews are, please see (in lore.kernel.org
search bar) `f:bagasdotme@gmail.com AND s:"Re:"`. Read the whole message.

> I've (now) retracted all of those patches, except this one. In those other 
> ones, I later realized I would actually be changing the license, not merely 
> fixing a spelling error.
> See https://lore.kernel.org/lkml/2281101.Yu7Ql3qPJb@prancing-pony/
> 
> AFAICT, for this patch I'm not changing the actual license, only references to 
> that license, so that can still be considered spelling fixes.
> That's why I haven't requested to ignore this patch (too).
> 

OK.

>> Why did you do that? Maybe as justification for your other GPL name
>> expansion fix patches?
> 
> Debian's lintian tool complained about it and after looking at
> https://www.gnu.org/licenses/ I concluded that lintian was right.
> 

Nice.

> As the full/proper name of the GPL is GNU General Public License, I submitted 
> a patch to fix that.
> 

OK, I know the reason.

>> Anyway, let's see what Linus thinks.
> 
> Sorry you all had to see my rant, but after seeing (and ignoring) Bagas' 
> rather useless and exactly the same comment numerous times yesterday and 
> getting accused of being a bot (!) and someone else feeling the need to point 
> out Bagas' less then constructive behavior AND me feeling shitty about my 
> clusterfsck and spending considerable time fixing that (which is fair) 
> yesterday, it seemed Bagas went out of their way to find the one patch I hadn't 
> asked to ignore and add the same useless and bot-like comment to, I had 
> enough. I'm not a delicate flower which needs to be handled with extreme care, 
> but everyone does have a breaking point.
> 

Let's assume that I'm on the subsystem maintainer side. I receive patches from
many people (and you), including first-time contributors who has just started to
learn how to submit kernel patches. I may take more care on patch description
(which would later become commit message in the changelog) and description.
I may follow Documentation/process/submitting-patches.rst literally and check
for code correctness/look more (disclaimer: since I'm autistic and had like to
see all patches having my own quality level, i.e. raise the bar). Good developers
are expected to addresses any reviews not only from me but also others. Sometimes
I massage the patch description when I have time and motivation to do so when
applying, but I may simply want to see the reroll if I'm lazy. Other maintainers
may or may not have "harsh" requirement as mine did, but that's the life in the
kernel development: there are idiosyncrasies which can only be understood by
immersing yourself into them. 

> If this patch is just wrong, please ignore it. If it needs improvement, let me 
> know and I'll do my best to do so.
> 

OK, thanks!

-- 
An old man doll... just what I always wanted! - Clara

