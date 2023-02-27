Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7D186A4294
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 14:25:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbjB0NZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 08:25:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbjB0NZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 08:25:50 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 222DC17CFB
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 05:25:48 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id f13so25736639edz.6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 05:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+VpsQInKb6hDy8SzTPUjCGkifl/HrsvzM70ay22Ageo=;
        b=6uZKyabUZgqBbl4zmFed1Okb3kCurgy7JsZ8Gdt84RHxd5Mh3fVK4bXpOP5auIZbgk
         Fbxn2cmisBfCr75lV10k/LQP1KaNj054cGkGYXPraefRx28v1xFCateWkbkd659CLwdq
         x/j2luHutwksPWFZWqIbdapj4NuNl6Hyv6KWtD3mF47HLuK5kPuvwA4TAu70UUwmpbab
         UPIu/pqFr51jwnM11nQFtVjlJx8h31b9hD8J6a+elKoYcXRzvrV7qAGAS0H//KX04MFU
         yL/BNkk3X5es4r1/aqg9xwYiVhys0reiOCmd6pGha/1DWhooyBi+SdRL1AJ5FH86uD1G
         lqig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+VpsQInKb6hDy8SzTPUjCGkifl/HrsvzM70ay22Ageo=;
        b=ECYyj39PC54BK1W3iWcV6pSktGh89iXdj051C+x5UYqV/6g6wJ2FNcQn940QuaH86x
         qmvmBlFdn8XWfn3YExp+G5RE5YFfXcJKxM2M1UUx1bqksuJai6FxN/FMdV5A3izsLMqr
         Xdv5lU3pGFtsks1OJGy0oGt0ACBMFoCWelrSZ8lwryiOef+Ku7JnJ/TyzUTicl32OXwC
         ig5sDEyrssKerq2qqso+MlGjwl1IWDW0M0nK4DloJdbkg+5SW4lwe4u2ALWSRk7FSrDy
         jB+2iFLCBOk1TcUq1KlCfhkOPFf0t2DOgntgIQB/cQx78fJGcxTGY5WncsQlIALBXoDg
         HK6w==
X-Gm-Message-State: AO0yUKW8gM8fxix7NHrcaH96XpPT5FFi3ZvQYgc+GbEhwm7lXBAXu3Ke
        0+Mj/P/G6ySFQl+w/1XtjBMc9g==
X-Google-Smtp-Source: AK7set+xm52lJMz8j7l449ZaF99h1U+ZjRkBMig+SaxfxC6aGkpgdQIp6xfIydL8mjJmJ9BVCOOn1w==
X-Received: by 2002:a17:907:3e24:b0:8eb:27de:240e with SMTP id hp36-20020a1709073e2400b008eb27de240emr23350197ejc.13.1677504346455;
        Mon, 27 Feb 2023 05:25:46 -0800 (PST)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id e12-20020a1709061e8c00b008d1693c212csm3169260ejj.8.2023.02.27.05.25.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Feb 2023 05:25:46 -0800 (PST)
Message-ID: <a27480c5-c3d4-b302-285e-323df0349b8f@tessares.net>
Date:   Mon, 27 Feb 2023 14:25:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v4 1/3] checkpatch: warn when unknown tags are used for
 links
Content-Language: en-GB
To:     Thorsten Leemhuis <linux@leemhuis.info>,
        Joe Perches <joe@perches.com>,
        Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     =?UTF-8?Q?Kai_Wasserb=c3=a4ch?= <kai@dev.carbon-project.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
References: <cover.1674217480.git.linux@leemhuis.info>
 <3b036087d80b8c0e07a46a1dbaaf4ad0d018f8d5.1674217480.git.linux@leemhuis.info>
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <3b036087d80b8c0e07a46a1dbaaf4ad0d018f8d5.1674217480.git.linux@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 20/01/2023 13:35, Thorsten Leemhuis wrote:
> From: Kai Wasserbäch <kai@dev.carbon-project.org>
> 
> Issue a warning when encountering URLs behind unknown tags, as Linus
> recently stated ```please stop making up random tags that make no sense.
> Just use "Link:"```[1]. That statement was triggered by an use of
> 'BugLink', but that's not the only tag people invented:
> 
> $ git log -100000 --no-merges --format=email -P \
>    --grep='^\w+:[ \t]*http' | grep -Poh '^\w+:[ \t]*http' | \
>   sort | uniq -c | sort -rn | head -n 20
>  103958 Link: http
>     418 BugLink: http
>     372 Patchwork: http
>     280 Closes: http
>     224 Bug: http
>     123 References: http
>      84 Bugzilla: http
>      61 URL: http
>      42 v1: http
>      38 Datasheet: http
>      20 v2: http
>       9 Ref: http
>       9 Fixes: http
>       9 Buglink: http
>       8 v3: http
>       8 Reference: http
>       7 See: http
>       6 1: http
>       5 link: http
>       3 Link:http
> 
> Some of these non-standard tags make it harder for external tools that
> rely on use of proper tags. One of those tools is the regression
> tracking bot 'regzbot', which looks out for "Link:" tags pointing to
> reports of tracked regressions.

I'm sorry for the late feedback but would it be possible to add an
exception for the "Closes" tag followed by a URL?

This tag is useful -- at least for us when maintaining the MPTCP subtree
-- to have tickets being automatically closed when a patch is accepted.
I don't think this "Closes" tag is a "random one that makes no sense"
but I agree it is not an "official" one described in the documentation.

On our side, we are using GitHub to manage issues but this also works
with GitLab and probably others. Other keywords are also accepted [1][2]
but I guess it is best to stick with one, especially when it is already
used according to the list provided above.

Would it then be OK to allow this "Closes" tag in checkpatch.pl and
mention it in the documentation (Submitting patches)?

Or should we switch to the "Link" tag instead (and re-do the tracking
manually)?

Cheers,
Matt

[1]
https://docs.github.com/en/get-started/writing-on-github/working-with-advanced-formatting/using-keywords-in-issues-and-pull-requests
[2]
https://docs.gitlab.com/ee/user/project/issues/managing_issues.html#default-closing-pattern
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
