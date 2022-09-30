Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 442985F0DE3
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 16:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbiI3Orz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 10:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiI3Orx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 10:47:53 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E35B8128A31;
        Fri, 30 Sep 2022 07:47:52 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id a29so4433047pfk.5;
        Fri, 30 Sep 2022 07:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date;
        bh=i8xavYOx2/zSc0otKBWPIT9xxqzPwCN5Fxa8ZVs4kwQ=;
        b=e9n3chMP27Mlf1qZ3wrrMzdkijJyGINRYyjEh517FOJMb7ZKJNqcz/5xQBsE0mmlzC
         TEkhU5betxkTDUOBQDnjsoiMDfDQJ9lBzFICOGzYz/86PnAGOW7ditvwmQU0XplZsoue
         zrO2UiKngwHE72HrEIdVKGMueKB8MpDcTWduHPJpfOXSoev48Tl3sPpU3v9KzOpIiN4+
         Snac4hi9zBS7ixUtIJdyiHHWGm8U9XoYwl0v79jG8Vcvx+62IwpLoiNnSp9lDKEK7Jgj
         ePu8J02kTyK8hPUP9lbenU5dUY8TiZkIWibNoso2FNYy+3KYLHZZWCLA8BuGQDm2QlMP
         PoYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=i8xavYOx2/zSc0otKBWPIT9xxqzPwCN5Fxa8ZVs4kwQ=;
        b=WYG0fbg3RZyPYVuOtKyR1YB5ufaHDZ5SRvs3IzxSx8+ajwQaTnQs2WGYwwpcBOd1Hl
         oizpZNFhHSVp4/9ULNX76CJxbcNwB9bQ1v3u1WEas+trAIT5HBl/LDeDBM1eDc0ng5KN
         wqManP/6Y0GBJoaNAMH9zvhCUvMRZEDEA87lkIZVkCDJyt4kuDkfv3pfyHPD+McGscqG
         c64QXbEuK8SgVUTv8STV5OSyiZbRecgeFaqDMbnG4mcea1s3srP/6xNQuTW95GXzNhnf
         2365NgKsOXOQsazhI+m+VQvx2B72yhUTwsH/kcgdm9HZo0JVb9GLMk1iTfz+/kgnL/kH
         bwvA==
X-Gm-Message-State: ACrzQf0t2jKhMNv6OOpGN3MGEgUOD5FoUGAfi8+HlYJPAmD0rj2FwzPp
        sLwboNxKXQYjB94EskF0AQc=
X-Google-Smtp-Source: AMsMyM4uIiiclGGSmqSTJXg+3N9TZdumzP5VslsQ6Jd9/srm9omVe9RBV+Ykp7wd3LiDkPga8/ODgA==
X-Received: by 2002:aa7:8497:0:b0:558:ac3b:3bf6 with SMTP id u23-20020aa78497000000b00558ac3b3bf6mr9449147pfn.29.1664549272382;
        Fri, 30 Sep 2022 07:47:52 -0700 (PDT)
Received: from [192.168.11.9] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id k17-20020a170902c41100b0016c0b0fe1c6sm2025099plk.73.2022.09.30.07.47.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Sep 2022 07:47:52 -0700 (PDT)
Message-ID: <21f8d79a-0ad4-b28b-15d8-f4be0cfd9730@gmail.com>
Date:   Fri, 30 Sep 2022 23:47:48 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
From:   Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH v3] Documentation/process: Add text to indicate supporters
 should be mailed
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     corbet@lwn.net, konstantin@linuxfoundation.org,
        krzysztof.kozlowski@linaro.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@leemhuis.info, tytso@mit.edu,
        Akira Yokosawa <akiyks@gmail.com>
References: <20220930064629.329514-2-bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <20220930064629.329514-2-bryan.odonoghue@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 30 Sep 2022 07:46:29 +0100, Bryan O'Donoghue wrote:
> Recently when submitting a yaml change I found that I had omitted the
> maintainer whose tree the change needed to go through.
> 
> The reason for that is the path in MAINTAINERS is marked as Supported not
> Maintained. Reading MAINTAINERS we see quote:
> 
>            Supported:   Someone is actually paid to look after this.
>            Maintained:  Someone actually looks after it.
> 
> The current submitting-patches.rst only says to mail maintainers though not
> supporters. When we run scripts/get_maintainer.pl anybody who is denoted a
> paid maintainer will appear as a supporter.

So the root cause of your confusion was you couldn't figure out
the fact that "supporter" in the output of get_maintainver.pl means
"maintainer of a supported subsystem", wasn't it?

I guess all you need would be just a short notice along the lines of:

    "supporter" in the output from get_maintainer.pl means "maintainer
    of a supported subsystem".

No?

> 
> Add text to state that every mail address returned by get_maintainer.pl
> --nogit-fallback should be included when submitting a patch, giving an
> example of the same.> 
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>  Documentation/process/submitting-patches.rst | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
> index be49d8f2601b4..18a1f52e0563a 100644
> --- a/Documentation/process/submitting-patches.rst
> +++ b/Documentation/process/submitting-patches.rst
> @@ -227,9 +227,15 @@ You should always copy the appropriate subsystem maintainer(s) on any patch
>  to code that they maintain; look through the MAINTAINERS file and the
>  source code revision history to see who those maintainers are.  The
>  script scripts/get_maintainer.pl can be very useful at this step (pass paths to
> -your patches as arguments to scripts/get_maintainer.pl).  If you cannot find a
> -maintainer for the subsystem you are working on, Andrew Morton
> -(akpm@linux-foundation.org) serves as a maintainer of last resort.
> +your patches as arguments to scripts/get_maintainer.pl).  You should mail every
> +email address returned by `scripts/get_maintainer.pl --nogit-fallback` when
> +submitting a patch.
> +For example::
> +
> +    $ scripts/get_maintainer.pl --nogit-fallback -f submitting-patches.rst
> +    Jonathan Corbet <corbet@lwn.net> (maintainer:DOCUMENTATION)
> +    linux-doc@vger.kernel.org (open list:DOCUMENTATION)
> +    linux-kernel@vger.kernel.org (open list)

This example has a number of issues...

 1) The command line doesn't work when run under the top of kernel tree.
 2) The -f flag contradicts the instruction above:
    (pass paths to your *patches* as arguments to scripts/get_maintainer.pl).
 3) There can be cases where --git-fallback (default) is useful.
 4) The output can change any time.
 5) There is no point in using Jon's actual name and email address.

Why not just add a short notice I mentioned above as a first step?

Please take your time before sending out v4 to make sure your change
will improve things.

Regards,
Akira

>  
>  You should also normally choose at least one mailing list to receive a copy
>  of your patch set.  linux-kernel@vger.kernel.org should be used by default
