Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 828F7750CB8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 17:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233735AbjGLPiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 11:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233731AbjGLPin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 11:38:43 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 901BE1BE4;
        Wed, 12 Jul 2023 08:38:41 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-55be1ce1669so3697196a12.1;
        Wed, 12 Jul 2023 08:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689176320; x=1691768320;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gv1RN/Rmst6r+oFCiGVscIFlwXQptYlMhsp41fIGnGg=;
        b=GEfqvFu9G2UdxlDCuueTp9SolunOVRAcKtCOJ536nnqNNkARJEjp62LuXH06kUvXvD
         kvkUJTHR4ezssU0K+SvIFgWp2hLXC2jcM5Ucoonwm534OG4wUZFC14pKO/lO7npFpQCG
         qhXbo4a20yDknPNhsgnCqyqXUQU8SiOWm0IZxt1Ui/RO07vCWUPeewmmJMDqhZ6Rh4/r
         yMDG7km9n5tvbPUXZ8FBGJSehmHrizYxzrILcdFsOVV/GSI7k/KNXRSO0QUPmCYCvKSF
         sj/ttRR4+SvhEZ2HTRE7gPE3pHalKbSV3X1gvMz8rWTe5DEcJxqRVbaivRoYCBOOoyoK
         B9SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689176320; x=1691768320;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gv1RN/Rmst6r+oFCiGVscIFlwXQptYlMhsp41fIGnGg=;
        b=CHoD1OtY83OTQxDDk8TLQkYRKHdq3hkX5pOlBIFGXbvN7rRjkue8pd0mPOk5Q6wLKJ
         /P03JIky1caC4YEX5luiktb3jheR0h3V0c+ue/fSloSfoPXX6zcblo3Sl3OJhMI1LeTq
         K53fSdOy/5Tuy2iM5hCsQcwrAhkH1paghopWtpBXtVBiryIxLRkjB9d2J0ISvA8u/030
         247zGPX3qLBswT4xO6z9zEgNDe3BffERdEsdQoaSXYlXnm59bQT9qdtS31awfsy1Fm00
         KePTTlWRj+N/ar3bkX/V8qlQ/W8UL8o+c0+YsFfi9XRBjbuRjrowhhGmrbJlo/jO6Tf9
         fyNg==
X-Gm-Message-State: ABy/qLYNWbM81IfsiM8GEvYyczrtB2HAmEsW7vnzRz0+NBhPKf/Wjj0i
        3RKcmJbcDBkHL4l6X9eRTqA=
X-Google-Smtp-Source: APBJJlFJdcZ6C9rXwthema0/IQTOcFYNvkez2Vy8bSvnBL3fm4CwYNn2w7WFpsoTyu5m6mTahy+AQQ==
X-Received: by 2002:a17:90a:6fe1:b0:265:8184:5903 with SMTP id e88-20020a17090a6fe100b0026581845903mr11956765pjk.40.1689176320461;
        Wed, 12 Jul 2023 08:38:40 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id cp9-20020a17090afb8900b00256a4d59bfasm10169867pjb.23.2023.07.12.08.38.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 08:38:39 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <b02489c7-96de-b6ed-07b9-9ba423af34c6@roeck-us.net>
Date:   Wed, 12 Jul 2023 08:38:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        David Laight <David.Laight@ACULAB.COM>,
        'John Paul Adrian Glaubitz' <glaubitz@physik.fu-berlin.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <fbfea3ad-d327-4ad5-ac9c-648c7ca3fe1f@roeck-us.net>
 <CAMuHMdUfXdCf_CQuWXpP72MzKFYvXg3Ud1VN_3Bd0RHxfLhVeQ@mail.gmail.com>
 <7b2c0d812280afaefee0c70a9aea00a0fcf84e3a.camel@physik.fu-berlin.de>
 <cd1caa5d-fbd8-c3fe-29e9-b848ddd5634c@omp.ru>
 <1178f8d0-be70-c088-ee6a-8b421b290624@roeck-us.net>
 <a0a0d4d06eecc9c3194afe2cee0b61ebed5e0392.camel@physik.fu-berlin.de>
 <c5ad5c59fcfa4888bd03fb8a855c989c@AcuMS.aculab.com>
 <c9483d7f-7f5f-dd29-2bba-5659a1dae7e0@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] sh: Avoid using IRQ0 on SH3 and SH4
In-Reply-To: <c9483d7f-7f5f-dd29-2bba-5659a1dae7e0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/12/23 01:20, Sergei Shtylyov wrote:
> On 7/12/23 11:12 AM, David Laight wrote:
> 
>>> Sent: 09 July 2023 00:13
>> ....
>>> Looking at arch/sh/boards/mach-r2d/irq.c, there is some IRQ translation going
>>> on and maybe that's the part where we need to correct the offset by 16?
>>
>> Would it be less problematic to use (say) 16 for IRQ_0
>> leaving IRQ_1+ as 1+ ?
> 
>     I don't think so.
> 
>> At least that would only cause issues for code that needed
>> to use IRQ_0.
>>
>> (It has to be said that making IRQ 0 invalid seemed wrong
>> to me. x86 (IBM PC) gets away with it because IRQ 0 is
>> always assigned to platform specific hardware.)
> 
>     Not only x86, IIRC.
>     Have you seen the commit below?
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ce753ad1549cbe9ccaea4c06a1f5fa47432c8289
> 

Quoting:

using IRQ0 is considered invalid (according to Linus) outside the arch/ code
                                                       ^^^^^^^^^^^^^^^^^^^^^^

The changes here were made _in_ the arch code. While there may be valid
arguments for doing that, quoting the above commit as reason isn't really
sufficient.

Guenter

