Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 221556BD10E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 14:40:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbjCPNko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 09:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjCPNkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 09:40:42 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A7FBB953C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 06:40:41 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id h7so998179ila.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 06:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678974040;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8pprCC3ZZzm5MzHYtPX0qmOhtOUyJsAx0tj0irD+54E=;
        b=MhVC5UNWv17Z2ZwuFBlWuEX6RisTFsTS15hSepCbPWOAcWMo1RDxMh8LyjDj7PdyqK
         opbwaz2lfdM+n48i2v4ISSpBqDJo4YFHLVX0M0a9tEngSgzQl9PYGDfKLd1Y+hf0DQDO
         +tG5x48rYIpVxF7Csg480kxix649uLMhzGtgLHe5IL1dbS5vR88vp1HtwA08Qsx9uNwN
         nTZlnI9fx6Ar7Gi8ehCrMMDMwuaMe7H+eEifGgvtWYAAOmhqMqoYMx+v5wWvS3Kmulia
         wNK9EJUNd+7W1ZovndTSDrw6OyFpJVaehrqDWKd76MCtoeNqPLGeDVZkBc7sAFpTAFhQ
         JeGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678974040;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8pprCC3ZZzm5MzHYtPX0qmOhtOUyJsAx0tj0irD+54E=;
        b=njKlsoU2UyAEoAzWTWVUKwOjW2yysR/d2Y5r//fOVRffuzYHpWOgkrtH5wXmNaMTRQ
         JPxJ7MoPjUp7Y8AIp1t+CYs1f09S3UPhhlIHKIRjoey+iO7nRoEYF2dbdwnBQYcb+TZ9
         1jA62OY/u0sQFW2qIglVyhTbjhZCYbFlPYC1FFzWOs4gg265gi88oSPfFcVx5sVctqv6
         RcVRPXRs8gIB1GScZNlc0LBzRFwIP7yi5DPqx97cainKaHDK+InMYPhH3x5QT6vWJVyb
         6fDyrgoE26wYUFI/yDIvKdZE+S1xZMoEzi3/9QIbHq2BM/ywfWAQeP640bkuWyCSdhos
         LTlA==
X-Gm-Message-State: AO0yUKUM8oL7/R0rX4XXP8cAMI5qn3ZE7pf2yLP3XN3fN6OcSBkHh2vv
        1suruwwgTuKpZXCIpPNQagM=
X-Google-Smtp-Source: AK7set8r8rDTKIQWdf4JaMmfYBm+nGWiDdREX9NKkftIRt0HSOxb4gXFrOMuvH0Wjr2e9x0aeB4XaQ==
X-Received: by 2002:a92:d10c:0:b0:322:fa92:7d60 with SMTP id a12-20020a92d10c000000b00322fa927d60mr6098722ilb.0.1678974040267;
        Thu, 16 Mar 2023 06:40:40 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p2-20020a92c102000000b003155a2a1e5asm2424520ile.74.2023.03.16.06.40.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Mar 2023 06:40:39 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <83c9306a-dbfe-819a-16d8-6242437b2810@roeck-us.net>
Date:   Thu, 16 Mar 2023 06:40:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Content-Language: en-US
To:     Guillermo Rodriguez Garcia <guille.rodriguez@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Petr Mladek <pmladek@suse.com>,
        Alejandro Vazquez <avazquez.dev@gmail.com>,
        Shreyas Joshi <shreyas.joshi@biamp.com>,
        sergey.senozhatsky@gmail.com, rostedt@goodmis.org,
        shreyasjoshi15@gmail.com
References: <CABDcavZWz=YOvZnW8pkQmuTVjTDxPPoa0zOiC7A_0HAEg_Vi3w@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: Change of behaviour when console=null and ttynull driver is used
In-Reply-To: <CABDcavZWz=YOvZnW8pkQmuTVjTDxPPoa0zOiC7A_0HAEg_Vi3w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/16/23 03:29, Guillermo Rodriguez Garcia wrote:
> Hi all,
> 
> We have several embedded systems where pass console= or console=null
> in production to disable the console.
> 
> Later we check for this in user space: in our inittab we check if fd0
> is "associated with a terminal" (test -t 0); if so, we are in
> development mode and we open a debug shell; otherwise (console
> disabled) we just start the application.
> 
> Recently [1] this behaviour has changed and now if we pass console= or
> console=null, the new ttynull driver is used. This breaks the check we
> were doing (test -t 0 always true now).
> 
> Is there a way to get the previous behaviour? If not, is there an easy
> way for userspace to detect whether the console device is a "real" tty
> or ttynull (other than trying to parse the kernel boot args, which
> would be a bit fragile).
> 
> Thank you,
> 
> (If possible, please CC me in any replies)
> 
>   [1]: https://lore.kernel.org/lkml/X%2FcDG%2FxCCzSWW2cd@alley/t/
> 

Let me know if/when you find a solution. In ChromeOS we have to carry
reverts of commit 48021f981308 ("printk: handle blank console arguments
passed in.") and commit 3cffa06aeef7 ("printk/console: Allow to disable
console output by using console="" or console=null") to handle the
same problem (the above mentioned commit didn't work and had odd side
effects).

Guenter

