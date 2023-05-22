Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8646A70CBEB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 23:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235273AbjEVVFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 17:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235216AbjEVVEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 17:04:50 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CDA69D
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 14:04:47 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-513fd8cc029so131985a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 14:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1684789486; x=1687381486;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=87E11T0PWo3pRQwioS2ru6DFv9NXjk9At+4H7tRtoQ4=;
        b=R7U0UybwJD1Kw4pZ1JGSV+kjfqlu89bLXaiEC8Z7ohZeXI9xs5Wo6slRygraV9FxdU
         6dUt7n+ejiY5WAjZJBkcPp4hme6z1VMNC4Y/+qRrfPLgFC/v+DD6PTicxvQyqtgYSdQ2
         g9xk5WrA4L+TU4++nLhsjYPJRaWlTsqUxH1MI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684789486; x=1687381486;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=87E11T0PWo3pRQwioS2ru6DFv9NXjk9At+4H7tRtoQ4=;
        b=l/VlupDyvlDO/xcUens0ehV3aPKRUbdqnL/5JxMTJZSB2I9tBKHEZ1yv6EDYT8w+am
         BWYZCBb4F//FasgGGEWvlXd4e0McMu879R9NJUZAh/qiz4/Sj686ikLYO1XrUhcSZksk
         N3KOs3AVm1XGV48WU1qc1JpGRGt/vEVBqztaxkgS3Rk2NFmtuMdIG6n9UujgHhnQ8O2T
         ckX+pCF6Q2I62zAAyYFUx+XVNMerca285SsEhfxqad40Q/8vrjuRhxkDEDqtWwH6pIJV
         O0BNnsz93aeWpwaLAzeLuEDd4yVTeAXDmbxfcE1LYmiKH9Oni39/T2ImOEjSkjPqTNut
         oz3w==
X-Gm-Message-State: AC+VfDxU37w/5sMSvTSx3tbGhEbXkfyyc6iwMdjU4ckdQRDPGhk2blQy
        Y+gLsd0giir//43zwZj0yZfyiA==
X-Google-Smtp-Source: ACHHUZ5PKzX/MIqIwmIIGgXgGBFz3QvBRGt6y9Z5XPqBQD3NsZJ0dPLDSLbaIy7Cyh40tpt3sxG+wQ==
X-Received: by 2002:a17:906:5044:b0:96a:63d4:24c5 with SMTP id e4-20020a170906504400b0096a63d424c5mr11397934ejk.77.1684789486049;
        Mon, 22 May 2023 14:04:46 -0700 (PDT)
Received: from [192.168.1.128] ([80.208.70.1])
        by smtp.gmail.com with ESMTPSA id de35-20020a1709069be300b0096637a19dc7sm3581071ejc.108.2023.05.22.14.04.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 May 2023 14:04:45 -0700 (PDT)
Message-ID: <1e424481-6428-068c-d58b-7a11e36c2cc6@rasmusvillemoes.dk>
Date:   Mon, 22 May 2023 23:04:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] vsprintf/doc: Document format flags including field width
 and precision
Content-Language: en-US, da
To:     Petr Mladek <pmladek@suse.com>,
        John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, phone-devel@vger.kernel.org,
        linux-doc@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>,
        linux-kernel@vger.kernel.org
References: <CSSLOC8WDIPE.1WO9BXZQA7A12@otso>
 <20230522150853.30417-1-pmladek@suse.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <20230522150853.30417-1-pmladek@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/05/2023 17.08, Petr Mladek wrote:
> The kernel implementation of vsprintf() tries to be as compatible with
> the user space variant as possible. Though it does not implement all
> features. On the other hand, it adds some special pointer printing
> modifiers.
> 
> Most differences are described in Documentation/core-api/printk-formats.rst
> Add the missing documentation of the supported flag characters
> '#', '0', '-', ' ', '+' together with field width and precision modifiers.
> 
> Suggested-by: Luca Weiss <luca.weiss@fairphone.com>
> Signed-off-by: Petr Mladek <pmladek@suse.com>
> ---
> What about something like this, please?
> 
>  Documentation/core-api/printk-formats.rst | 69 +++++++++++++++++++++++
>  1 file changed, 69 insertions(+)
> 
> diff --git a/Documentation/core-api/printk-formats.rst b/Documentation/core-api/printk-formats.rst
> index dfe7e75a71de..79655b319658 100644
> --- a/Documentation/core-api/printk-formats.rst
> +++ b/Documentation/core-api/printk-formats.rst
> @@ -8,6 +8,75 @@ How to get printk format specifiers right
>  :Author: Andrew Murray <amurray@mpc-data.co.uk>
>  
>  
> +Flag characters
> +===============
> +
> +The character '%' might be followed by the following flags that modify
> +the output:
> +
> +	- '#' - prepend '0', '0x', or 'OX for 'o', 'x', 'X' number conversions
> +	- '0' - zero pad number conversions on the field boundary
> +	- '-' - left adjust on the field boundary, blank pad on the right
> +	- ' ' - prepend space on positive numbers
> +	- '+' - prepend + for positive numbers when using signed formats

[I wonder if we have a single user of any of the latter two in the
entire tree.]

> +Examples::
> +
> +	|%x|	|1a|
> +	|%#x|	|0x1a|
> +	|%d|	|26|
> +	|% d|	| 26|
> +	|%+d|	|+26|
> +
> +
> +Field width
> +===========
> +
> +A field width may be defined when '%' is optionally followed by the above flag
> +characters and:
> +
> +	- 'number' - the decimal number defines the field width
> +	- '*' the field width is defined by an extra parameter
> +
> +Values are never truncated when the filed width is not big enough.

filed -> field (several places)

> +Spaces are used by default when a padding is needed.
> +
> +Examples::
> +
> +	|%6d|	|    26|
> +	|%-6d|	|26    |
> +	|%06d|	|000026|
> +
> +	printk("Dynamic table: |%*d|%*s|\n", id_width, id, max_name_len, name);
> +
> +The filed width value might have special meaning for some pointer formats.
> +For example, it limits the size of the bitmap handled by %*pb format.

It should also be noted that a negative field width passed as a *
argument is interpreted as if the - flag is used and then the absolute
value is used as field width.

> +
> +
> +Field precision:
> +================
> +
> +A field width may be defined when '%' is optionally followed by the above flag
> +characters:
> +
> +	- '.number' - the decimal number defines the field precision
> +	- '.*' the field precision is defined by an extra parameter
> +
> +The precision defines:
> +
> +	- number of digits after the decimal point in float number conversions

No, don't mention floats, the kernel doesn't do those.

> +	- minimal number of digits in integer conversions
> +	- maximum number of characters in string conversions
> +
> +Examples::
> +
> +	|%.3f|	|12.300|

Remove.

> +	|%.6d|	|    26|

Nope, that actually produces 000026.

---

So overall, I'm not sure this is a net win. I think it might be better
to emphasize that

- the kernel doesn't do floats, argument reordering via m$, wide
characters/strings, %m or %n (just so that's out of the equation)

- for string and integer conversions, the kernel's printf is very very
close to following POSIX/libc/whatever, in terms of flags, field width
etc. [There are a few exceptions, those I've found are documented in
test_printf.c, but nobody is ever likely to hit those.]

- for %p, the kernel has its own rules, starting with the fact that
modifying behaviour based on alphanumerics following the p is completely
non-standard.

and then spend the rest explaining those rules, and perhaps also some
background on why the %p extensions exist and why they are implemented
the way they are - for example "we want -Wformat to tell us if something
is wrong", but that, for example, means we can only use a field width
and not a precision to pass an extra argument to a %psomething. And
alphanumerics are chosen because nobody would usually follow a normal %p
by anything but whitespace or punctuation, and because the compiler
format checking is happy as long as there's some pointer argument
corresponding to the %p, and the remaining characters are, from the
compiler's POV, just literal characters.

Rasmus

