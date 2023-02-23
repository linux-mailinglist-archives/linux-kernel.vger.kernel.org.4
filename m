Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB2C16A1071
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 20:17:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232516AbjBWTRd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 14:17:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232443AbjBWTRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 14:17:17 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B7C567BB
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 11:16:05 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id az36so191348wmb.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 11:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KEmHCylAiV87a2obQuRQeEqB1qmnfNX6w7leux+IHfg=;
        b=Ep8PCy81Or3QNNN8QIMCSx1GzRxoNmxGlGaCdwTioplAC5JNT2kid61J3I5vp/f2Kb
         yrUSryMWndPSZ2hBxzAprdxro9AnIZIEbfnEX6WBxQTxIxyKEwZv9B9Lftb/2HOrulfJ
         758iZipkfqqU67IZg7z2ZWKwQriHYqaCOfJ8EbyIFaOAi6GMXyYvTFVds8y+2tjEnQxz
         M1JtJGa2pKy8G8i//fKzXKhegCPj+jKUcF5/mjlSyTEfNYKD4iAQKLk5U4p5ZDpQkmid
         kor6VX1dc2z7+Li4yAzQSBQ06/SE9SFqka9eTNNT9aPhn+HshqCz1ko6xNqc15HacwSi
         CRzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KEmHCylAiV87a2obQuRQeEqB1qmnfNX6w7leux+IHfg=;
        b=2egLGIfJnbyicQev6r4ZWo1Q91LEF7HF69/a3/N2YQZBqih6gPPJ3b0DUAq6EqUWxj
         TYTEEOdR+WqtgwU2Pl/E/4d6xXGNglvw2vXpE8NL2CpnQ53Ak9HWIVGEkIQmuotnLEYW
         wxPbKkqgCEhLWPuurwkatcxnRYMM7qufX12GGp+QDvkgGjTuGJbVGPm5R3xai3bsrXPC
         +CscpBtd6nYbSLNpa5pgdcCKieb0FQdNuvrm/tR4FrDZ/X2Xv/BbzfmPAStyp4l0pn4W
         wsGjV2IxcF7zyWMUZHz3tYHnPi9S0ypxf1MNusoTSv9iR+lVKHqGr3qPMBfZnpZ8ULMN
         CmAg==
X-Gm-Message-State: AO0yUKUnjoZg+Q6sFKY+EdEMX1hEE2BosQuvVBGvbzNc4hSmXXdxE70X
        Skrsjv5K/CiwbU7uKYa1TvMAyA==
X-Google-Smtp-Source: AK7set9GsSu+0Jw/J8uOgEtWHOkGAMUy06HWYed6+TNi7UGBBxV2URTNQbZPzx1CzvfOnh+zZ3a80Q==
X-Received: by 2002:a05:600c:4da4:b0:3ea:c100:f18d with SMTP id v36-20020a05600c4da400b003eac100f18dmr1525961wmp.9.1677179692142;
        Thu, 23 Feb 2023 11:14:52 -0800 (PST)
Received: from ?IPV6:2a02:6b6a:b566:0:5ee0:5af0:64bd:6198? ([2a02:6b6a:b566:0:5ee0:5af0:64bd:6198])
        by smtp.gmail.com with ESMTPSA id w6-20020adff9c6000000b002c5493a17efsm7761456wrr.25.2023.02.23.11.14.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Feb 2023 11:14:51 -0800 (PST)
Message-ID: <304d9fc1-3fe2-a941-7b56-532f8acea049@bytedance.com>
Date:   Thu, 23 Feb 2023 19:14:51 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [External] Re: [PATCH 0/6] x86-64: Remove global variables from
 boot
Content-Language: en-US
To:     Brian Gerst <brgerst@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>
References: <20230222221301.245890-1-brgerst@gmail.com>
 <5bc62f30a439345eaf58231bafe621b28c62d85e.camel@infradead.org>
 <CAMzpN2j7-GV4ONG7P-R6fZ3P+ZYu9CRzZYFbO+OswX+XZwV4nA@mail.gmail.com>
From:   Usama Arif <usama.arif@bytedance.com>
In-Reply-To: <CAMzpN2j7-GV4ONG7P-R6fZ3P+ZYu9CRzZYFbO+OswX+XZwV4nA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/02/2023 14:24, Brian Gerst wrote:
> On Thu, Feb 23, 2023 at 8:44 AM David Woodhouse <dwmw2@infradead.org> wrote:
>>
>> On Wed, 2023-02-22 at 17:12 -0500, Brian Gerst wrote:
>>> This is on top of the parallel boot v10 series.
>>>
>>> Remove the global variables initial_gs, initial_stack, and
>>> early_gdt_descr from the 64-bit boot code.  The stack, GDT, and GSBASE
>>> can be determined from the CPU number.
>>>
>>> Brian Gerst (6):
>>>    x86/smpboot: Use CPU number instead of APIC ID for single CPU startup
>>>    x86/smpboot: Use current_task to get idle thread
>>
>>
>> I think those first two should be folded into the 'x86/smpboot: Support
>> parallel startup of secondary CPUs' patch rather than follow-on
>> patches?
> 
> Yes, that makes sense.
> 
>>>    x86/smpboot: Remove initial_stack on 64-bit
>>>    x86/smpbppt: Remove early_gdt_descr on 64-bit
>>>    x86/smpboot: Remove initial_gs
>>>    x86/smpboot: Simplify boot CPU setup
>>
>> Those four probably make sense to come separately. For each of them,
>>
>> Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
>>
>> I've pulled in the v10 series from Usama, squashed the first two as I
>> suggested, added the last four on top to do some testing:
>> https://git.infradead.org/users/dwmw2/linux.git/shortlog/refs/heads/parallel-6.2-rc8-part1
> 
> Looks good.  I noticed a typo in the commit log of the last patch
> (dynammically -> dynamically).  Can you fix that or should I resend?
> 
> Thanks
> 
> --
> Brian Gerst

I have tested the branch on top of v6.2 release and sent it as v11. Have 
also fixed the typo.

Thanks,
Usama
