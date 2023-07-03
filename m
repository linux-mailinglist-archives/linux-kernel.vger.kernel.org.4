Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4F37745495
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 06:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbjGCEi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 00:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjGCEiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 00:38:55 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48BFD1AB;
        Sun,  2 Jul 2023 21:38:53 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so2891414a12.1;
        Sun, 02 Jul 2023 21:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688359132; x=1690951132;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=x0S1JkZS9qbPw++EtmvPDulhpZ8OPzh6zrJYaBNGJ5E=;
        b=BZqRMUXyXM2dShSRH3UCrjwxxJ7bJsHRv5B81oEym9Ji4yYm14H3Ym3G3SZbMKCAdT
         +D5WDqfvQEpmpXDyxdWn8gKVAbH88+9tkvYnGWQjpZCAx3FfbYrLjXQChLlqTFiTit+6
         E9u4Fc9SOZn1cEiLjlpJ3aGZL9GGjuuQ/0LH1bRRcmlLze1COQQ7IO5LvJks/EvTePaA
         0A6SXxmcGXJFtTbCDAMt6OwZO7DNfpP+KvCYKsXrb1xT6Asa+b+lQh0kIfl69BIDBlkh
         aBwAbWYZFtWAp0c1zwh39Ps/P72sDyv8pTDiWrNlosnb9SXbEiA9Cme+U0qhBH4GzAe4
         /lgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688359132; x=1690951132;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x0S1JkZS9qbPw++EtmvPDulhpZ8OPzh6zrJYaBNGJ5E=;
        b=cGHLYuHDFqffzoH07QY3qNO0uug0GTYwXdPVqjZKO2qtKwXIM4yTMg+9rDcAXgYsfZ
         hZePT3EDOlBsYlEkOqPjUI85ycEokg5jwqAZyqRVbnsJI/i/GsbL0B4r4HDHXg14Adj3
         1Sb+aqf2wx7T1ndsFG5ecCwIQSihZA227S93nTbC7GjHMLqqQ96KMVDTX7i7yh5eBe2M
         UHqrNT7eSa3qOdnITQ+fY3x8ZnRIP4tHfHrNAFZgd7WHQGngyuTfLHcHoRbNRZYU2qQO
         FKAsGcVYbjDKdOl8sl/a7cHgvTBtj4AnCV4Y+NkeBGP7INfCBtwM5GSmS40O+3ywJREq
         eqOA==
X-Gm-Message-State: AC+VfDwIl1RLZgIhs2Lu8BcNiHPzfo6qar1bhERXhSXJY9pvCFxsCtn4
        Xsr9Wo5T6oWjb7KXRSqBlGY=
X-Google-Smtp-Source: ACHHUZ4QxPJKcVnTdgGxLR/w7Nx8q7LX8tuuv+hDEgiF3V6OnSmd6JafVd/ilnFNFh2yvFgA2/C5sw==
X-Received: by 2002:a05:6a21:6d98:b0:10b:4539:fa0a with SMTP id wl24-20020a056a216d9800b0010b4539fa0amr14271676pzb.1.1688359132621;
        Sun, 02 Jul 2023 21:38:52 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e5-20020a62ee05000000b0064f76992905sm12974767pfi.202.2023.07.02.21.38.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Jul 2023 21:38:52 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <b27f513d-38a5-5422-ba32-f2ccfdfae909@roeck-us.net>
Date:   Sun, 2 Jul 2023 21:38:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [CRASH][BISECTED] 6.4.1 crash in boot
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux LLVM <llvm@lists.linux.dev>,
        linux-kbuild@vger.kernel.org,
        Linux Regressions <regressions@lists.linux.dev>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
References: <9a8e34ad-8a8b-3830-4878-3c2c82e69dd9@alu.unizg.hr>
 <ZKIoBVzrjZ+Ybxy9@debian.me> <202307022018.B26F5795@keescook>
 <625e951e-9922-d15d-5520-e8cd5eba1995@roeck-us.net>
 <4ea9488c-0f98-89b4-7af3-174cfcdaa02c@alu.unizg.hr>
 <202307022115.D96AB033F@keescook>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <202307022115.D96AB033F@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/2/23 21:30, Kees Cook wrote:
> On Mon, Jul 03, 2023 at 05:53:48AM +0200, Mirsad Goran Todorovac wrote:
>> On 7/3/23 05:26, Guenter Roeck wrote:
>>> On 7/2/23 20:20, Kees Cook wrote:
>>>> On Mon, Jul 03, 2023 at 08:44:37AM +0700, Bagas Sanjaya wrote:
>>>>> On Sun, Jul 02, 2023 at 06:36:12PM +0200, Mirsad Goran Todorovac wrote:
>>>>>> Hi,
>>>>>>
>>>>>> After new git pull the kernel in Torvalds tree with default debug config
>>>>>> failed to boot with error that occurs prior to mounting filesystems, so there
>>>>>> is no log safe for the screenshot(s) here:
>>>>>>
>>>>>> [1] https://domac.alu.unizg.hr/~mtodorov/linux/crashes/2023-07-02/
>>>>>>
>>>>>> Bisect shows the first bad commit is 2d47c6956ab3 (v6.4-rc2-1-g2d47c6956ab3):
>>>>>>
>>>>>> # good: [98be618ad03010b1173fc3c35f6cbb4447ee2b07] Merge tag 'Smack-for-6.5' of https://github.com/cschaufler/smack-next
>>>>>> git bisect good 98be618ad03010b1173fc3c35f6cbb4447ee2b07
>>>>>> # bad: [f4a0659f823e5a828ea2f45b4849ea8e2dd2984c] drm/i2c: tda998x: Replace all non-returning strlcpy with strscpy
>>>>>> git bisect bad f4a0659f823e5a828ea2f45b4849ea8e2dd2984c
>>>>>> .
>>>>>> .
>>>>>> .
>>>>>> # bad: [2d47c6956ab3c8b580a59d7704aab3e2a4882b6c] ubsan: Tighten UBSAN_BOUNDS on GCC
>>>>>> git bisect bad 2d47c6956ab3c8b580a59d7704aab3e2a4882b6c
>>>>>> # first bad commit: [2d47c6956ab3c8b580a59d7704aab3e2a4882b6c] ubsan: Tighten UBSAN_BOUNDS on GCC
>>>>>>
>>>>>> The architecture is Ubuntu 22.04 with lshw and config give in the attachment.
>>>>>
>>>>> Can you show early kernel log (something like dmesg)?
>>>>>
>>>>> Anyway, I'm adding it to regzbot:
>>>>>
>>>>> #regzbot ^introduced: 2d47c6956ab3c8
>>>>> #regzbot title: Linux kernel fails to boot due to UBSAN_BOUNDS tightening
>>>>
>>>> I'm confused. Commit 2d47c6956ab3c8b580a59d7704aab3e2a4882b6c isn't in the v6.4
>>>> tree... it's only in Linus's ToT.
>>>>
>>>
>>> In ToT:
>>>
>>> $ git describe 2d47c6956ab3
>>> v6.4-rc2-1-g2d47c6956ab3
>>>
>>> $ git describe --contains 2d47c6956ab3
>>> next-20230616~2^2~51
>>> $ git describe --contains --match 'v*' 2d47c6956ab3
>>> fatal: cannot describe '2d47c6956ab3c8b580a59d7704aab3e2a4882b6c'
>>>
>>> "git describe" always shows the parent tree, which I guess was based on
>>> v6.4-rc2.
>>>
>>> Guenter
>>>
>>>
>>>> Also, the config you included does not show CONFIG_UBSAN_BOUNDS_STRICT
>>>> as even being available, much less present. Something seems very wrong
>>>> with this report...
>>>>
>>>> -Kees
>>
>> Anyway, I have double checked and linux-image-6.4.0-rc2-crash boots while
>> linux-image-6.4.0-rc2-crash-00001-g2d47c6956ab3 freezes in early boot.
> 
> I don't understand what tree you're testing. 2d47c6956ab3 is only in
> Linus's latest tree, which is not 6.4-rc2.
> 

Maybe this ?

$ git checkout -b testing 2d47c6956ab3
Updating files: 100% (15501/15501), done.
Switched to a new branch 'testing'
groeck@server:~/src/linux-staging$ git describe
v6.4-rc2-1-g2d47c6956ab3

Guenter

> If you're testing Linus's tree, and you're bisecting to 2d47c6956ab3,
> I don't understand why the .config you sent doesn't include
> CONFIG_UBSAN_BOUNDS_STRICT (which was introduced by that commit) --
> it should be visible whether or not it is selected.
> 
>> Of course, in the next boot dmesg appears overwritten ... I could provide
>> only the first screen screenshots.
> 
> Without CONFIG_UBSAN_TRAP, I would not expect anything other than a
> warning (i.e. boot would continue).
> 
> The only other thing I can think of that seems related (the backtrace
> appears to show usb), might be this:
> https://lore.kernel.org/lkml/20230629190900.never.787-kees@kernel.org/
> which won't appears until after v6.5-rc1.
> 
>> The difference is only one commit.
>>
>> It is a bit strange so I am available for any additional diagnostics.
> 
> Thanks! Can you send "grep UBSAN .config" output for the crashing kernel?
> 
> Are you booting on an EFI-capable machine? If you could configure pstore
> to use the EFI-vars backend, you can capture the crash in EFI and
> pstorefs will show it after the next boot. (If you're using systemd,
> this all may already be happening -- check /var/lib/systemd/pstore/
> or see[1] for more details.)
> 
> -Kees
> 
> [1] https://www.freedesktop.org/software/systemd/man/systemd-pstore.service.html
> 

