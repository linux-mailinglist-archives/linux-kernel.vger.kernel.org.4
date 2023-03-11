Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 309516B600F
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 20:11:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbjCKTLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 14:11:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjCKTLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 14:11:03 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF2927D71
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 11:11:02 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id l9so1811422iln.1
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 11:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1678561861;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZioCoGuL3YwXw+MF3EM2JL8+qTfBwtfLWGaTl6x5jLQ=;
        b=RSUbKjognkBRT7p3e1tVQPIGZl9arZtcDYGbJaoXy6BqceesIPes4j93Uv080aXPBu
         7FQlilSshBPQgh9IjPIHnv7FVhBS9UCO4DpR+0XrBwcAAmh+wKaY0pFNfmUcBeLQYtIx
         ahWPJlHDFdXuO8DpKxxi918MyEIGsAB6zGRDw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678561861;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZioCoGuL3YwXw+MF3EM2JL8+qTfBwtfLWGaTl6x5jLQ=;
        b=2ofSAxvL2jh6B0JH7Zd+HFP127Vyy298zppkGbNv5nnZswVB2HZnJB5gCP36fF4ST6
         TPMGwwbfKH00rt0jDml97+277x5ihhT/1gqK8T/FIssfNy0XWmI7OFyOVcXI0YZ6LF3w
         artuFvSAEow7+J8uXUE6nztskvmEfSeHHd0B+ANLeceXYO52H4wdORvR41L7wCQcu6Fu
         gg8gUfbm0+Bq9lP3ZIwVzZGSp7CYYcd7DfFSX/zJDXQY8IFudhBBiOmNjDd8VBKlTHJb
         5EZb/7TPtN/P0vrBoPnYFPCFRz1eok7GdnL3+CKbno8VSlf4nbk6YYdWOUNa7llgviDV
         VD9g==
X-Gm-Message-State: AO0yUKVC6XmRobdObiMN+764uWfwPd/B6tcTm9xsZVe5SsDppOYWleiu
        xSVDc0K0DXdpAaNnIWVD4eBCyDQ5cg2W9QtkTBs=
X-Google-Smtp-Source: AK7set+hLSi+8GKGLrS7dhry3Tso3uhQ0yeYV59tBjqFsQ6XrMFobp350RtzrBzd6EJJQErg+COZ1A==
X-Received: by 2002:a92:d305:0:b0:322:fb69:e47f with SMTP id x5-20020a92d305000000b00322fb69e47fmr1071573ila.15.1678561861525;
        Sat, 11 Mar 2023 11:11:01 -0800 (PST)
Received: from [172.22.22.4] ([98.61.227.136])
        by smtp.googlemail.com with ESMTPSA id g13-20020a056e020d0d00b0031796c6d735sm1044391ilj.41.2023.03.11.11.11.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Mar 2023 11:11:01 -0800 (PST)
Message-ID: <e34f96c7-eee0-6dd6-7662-ffbf04034e27@ieee.org>
Date:   Sat, 11 Mar 2023 13:10:59 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] staging: greybus: eclose macro in a do - while loop
To:     Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>,
        outreachy@lists.linux.dev
Cc:     pure.logic@nexus-software.ie, johan@kernel.org, elder@kernel.org,
        gregkh@linuxfoundation.org, greybus-dev@lists.linaro.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20230311135919.9129-1-eng.mennamahmoud.mm@gmail.com>
Content-Language: en-US
From:   Alex Elder <elder@ieee.org>
In-Reply-To: <20230311135919.9129-1-eng.mennamahmoud.mm@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/11/23 7:59 AM, Menna Mahmoud wrote:
> " ERROR: Macros with multiple statements should be enclosed in a do -
> while loop"
> 
> Reported by checkpath.

This is also not an issue that should be "fixed."

If you look at where that macro is expanded, you see
that its purpose is simply to reduce the possibility
of some errors by enclosing some much-duplicated code
in this macro.  The expansion is at the top level of
the source file, so a "do...while" loop ends up being
an error.

When looking at the output of checkpatch, assume it's
giving you clues about problems that one *might* like to
fix.  Its suggestions are most often reasonable, but in
some cases (like this one) it's just not smart enough
to recognize the problem that comes from following its
advice.

Make sure you understand exactly what happens when
you make a change.  That means understanding the
code, and then it means ensuring that the fix passes
at least a compile test, and if possible an actual
execution test.

					-Alex

> 
> do loop with the conditional expression set to a constant
> value of zero (0).This creates a loop that
> will execute exactly one time.This is a coding idiom that
> allows a multi-line macro to be used anywhere
> that a single statement can be used.
> 
> So, enclose `gb_loopback_stats_attrs` macro in do - while (0) to
> fix checkpath error
> 
> Signed-off-by: Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
> ---
>   drivers/staging/greybus/loopback.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/greybus/loopback.c b/drivers/staging/greybus/loopback.c
> index 1a61fce98056..e86d50638cb5 100644
> --- a/drivers/staging/greybus/loopback.c
> +++ b/drivers/staging/greybus/loopback.c
> @@ -162,10 +162,12 @@ static ssize_t name##_avg_show(struct device *dev,		\
>   }									\
>   static DEVICE_ATTR_RO(name##_avg)
>   
> -#define gb_loopback_stats_attrs(field)				\
> -	gb_loopback_ro_stats_attr(field, min, u);		\
> -	gb_loopback_ro_stats_attr(field, max, u);		\
> -	gb_loopback_ro_avg_attr(field)
> +#define gb_loopback_stats_attrs(field)					\
> +	do { \
> +		gb_loopback_ro_stats_attr(field, min, u);		\
> +		gb_loopback_ro_stats_attr(field, max, u);		\
> +		gb_loopback_ro_avg_attr(field);				\
> +	} while (0)
>   
>   #define gb_loopback_attr(field, type)					\
>   static ssize_t field##_show(struct device *dev,				\

