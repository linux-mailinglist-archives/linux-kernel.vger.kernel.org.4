Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FAF96A5DE7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 18:04:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbjB1REg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 12:04:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjB1REd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 12:04:33 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F6B9DBF8;
        Tue, 28 Feb 2023 09:04:30 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id m14-20020a7bce0e000000b003e00c739ce4so6291990wmc.5;
        Tue, 28 Feb 2023 09:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZMZhtDVi0ANB75TYAQmf04yd/0ANVqJs0z7VbMzHPoY=;
        b=dm1I6p9icI0p+ry6bVglTWJ1e4hvGm9f1mewR3MpKwfY2yupw5/+BQVK2fPjWnlhjk
         dWH8z4YnBmV4Wbrfz4SGoRDwZPoucE+AiBiCHyGePjQyTdedVLOZfFHBAz01Ty3xD1+q
         GFDFlm+W79JGquFZGYPsx+OCsCBk40RoSH8eJItEfhY9gYbVCivCWtkZml2Fs2OHKmNy
         OGsduHN8YFhysWR4WWTLN3TDYx14U/yNuFjywM5jV9+2qkXsSWN3RhqhzOOSY+hVS/ms
         aVY9oOP7sAUHtBPWiZehXrzKKVxB4xwV1eHeWNTVyy9LTg1/xtHsprvJmYelQ1woJ/ft
         crcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZMZhtDVi0ANB75TYAQmf04yd/0ANVqJs0z7VbMzHPoY=;
        b=dJw473gFkS2wR5UpKIDFSgne2Tn6zURwV0bwNqD+7BDitLYlOYj1nZz9PXmO2yPYVy
         C/qGiKuPLcF3nBUxf2G68spXT2v9I5RHMots9aEdI1NwGx7L5feMxzAzze+rm8c//sYf
         RQV3MvsGbbrTC6oWvPAQNDeSWCKHk7YY1YQK5V8h1iR4EM+AgIYc9XvWmy2RPXYvb7x3
         VnNgEc3X78qiMXbC7ZQ4sDcknI6T2EB2nT1fCVH9qj1jX6hqGU/7p5SAgsCjGwqsXrQa
         vDKtK32VLYT2/N0S06Hx0pntbUUUo9hZtPaDI5URlBr28xLBH7RYEZu/KOhAFwakEmhz
         z7Ww==
X-Gm-Message-State: AO0yUKXNYljLxyV5eXFXEdz2S9i4UTnFn/aIgNFzLLimw55vbX7P1bDO
        cwHoUfYyOGaecvHh8HYkVvU5NaaOu+k=
X-Google-Smtp-Source: AK7set+bKeqZ0JV3G6Aj9aUHdcY2/B86tHV7NUqJNy0PE3oyRIYRr2dTph/rscHmoxLZH01ulmDnZw==
X-Received: by 2002:a05:600c:2215:b0:3e2:1368:e3a0 with SMTP id z21-20020a05600c221500b003e21368e3a0mr2600398wml.18.1677603868566;
        Tue, 28 Feb 2023 09:04:28 -0800 (PST)
Received: from [10.83.37.24] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id i13-20020a1c540d000000b003db06224953sm13272080wmb.41.2023.02.28.09.04.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Feb 2023 09:04:28 -0800 (PST)
Message-ID: <c44af068-8f30-9fbc-1b06-da9fe317f213@gmail.com>
Date:   Tue, 28 Feb 2023 17:04:26 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v12 2/3] ptrace,syscall_user_dispatch: checkpoint/restore
 support for SUD
Content-Language: en-US
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Gregory Price <gourry.memverge@gmail.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        avagin@gmail.com, peterz@infradead.org, luto@kernel.org,
        krisman@collabora.com, tglx@linutronix.de, corbet@lwn.net,
        shuah@kernel.org, Gregory Price <gregory.price@memverge.com>
References: <20230224233126.1936-1-gregory.price@memverge.com>
 <20230224233126.1936-3-gregory.price@memverge.com>
 <CAJwJo6YnELNhU8RmR-z37vDZ=xb0CmUUBgrPGgHP2dqjVm=O2g@mail.gmail.com>
 <20230228165217.GA16798@redhat.com>
From:   Dmitry Safonov <0x7f454c46@gmail.com>
In-Reply-To: <20230228165217.GA16798@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/28/23 16:52, Oleg Nesterov wrote:
> On 02/27, Dmitry Safonov wrote:
>>
>>> +int syscall_user_dispatch_set_config(struct task_struct *task, unsigned long size,
>>> +                                    void __user *data)
>>> +{
>>> +       int rc;
>>> +       struct ptrace_sud_config cfg;
>>> +
>>> +       if (size != sizeof(struct ptrace_sud_config))
>>> +               return -EINVAL;
>>> +
>>> +       if (copy_from_user(&cfg, data, sizeof(struct ptrace_sud_config)))
>>> +               return -EFAULT;
>>
>> It seems that the tool you want here would be copy_struct_from_user(),
>> which is designed for extendable syscalls.
> 
> Hmm. Why?
> 
> In this case ksize == usize, so why do we need copy_struct_from_user ?

In case the structure extends in future, that will let newer userspace
run on an older kernel (as long as it doesn't use [set] any new fields).
With regular sizeof(struct ptrace_sud_config) instead of adding
size-related defines.

It was Christian's idea how-to add/design new syscalls in an
"extensible" manner. Here are his LPC slides:
https://lpc.events/event/7/contributions/657/attachments/639/1159/extensible_syscalls.pdf
[7/18 slide on checks]
And an LWN article:
https://lwn.net/Articles/830666/

Thanks,
          Dmitry
