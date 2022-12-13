Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5C0164B09E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 08:53:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234712AbiLMHxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 02:53:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234596AbiLMHxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 02:53:37 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A26115713
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 23:53:35 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id s5so16514521edc.12
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 23:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Sn8m4YtnAt6/U2bhfzyln2Rk/G3bxMy5f1n4DF/7vg=;
        b=v4zBqFN9r5OYDkmkEoiICu8TLEA5D4dzV1PSG3PioTUWC+gmbEEubJN4a29FfEkk54
         AnVlzuA3wf61xRs+HTLQ4Q7u0UEMoyu7vAChW30JTDkdOcU8JNeTtwpS/5jKFuC09TL0
         OK6We6k/tDyYRsY7xryk7LwLg7j8rKYMY7t40Lb+M4yw29Kr9pNhzpx+Ybe9MIM7fmIZ
         77TqOXhUlbCmXpug4+eYYaCH36bf7Od6D2HWl0DwYF7bTIftJv72oNP+9jsw0IFO/biv
         eOqfiDHUJwXGs9iTIeRoNwnr6dkM8Oft07PPHKLC1yjnD0c/Dm1VVzze1Y4EBfONiUAk
         Pz7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Sn8m4YtnAt6/U2bhfzyln2Rk/G3bxMy5f1n4DF/7vg=;
        b=48pMySGuY79hY8ubwyhM4LS43d4qgwnbwF/m3AYB6zNtWIZFwMCKECEk+Zr5f1n3dl
         t95RPgtT5CCNhT12QX3FEBs0j6Emq1DVX6mKrfKhsk3vQXtTnNprUKJzOgOzLJmUur7L
         gxYs2muKPnL/oES9XZPRWa36ubraP7u+nVB7oVRdtnUsOQ7/rN3gg1zsQRufkDdZg4+G
         iaPSMNldG0l/P8+VzgDd/GB2Zr035qe5kBG6zfWUHLAQjZbVfW3FY07AGD8omI0tFdX7
         +PSJrsfrgeHVf0nsUWnnCGAaaA3oAlLEKQjWKSCxYreKNNLnvJPhH83G5z0g1+07rPWW
         pUaA==
X-Gm-Message-State: ANoB5plPC+Kb0pmjZab+JuVvftwSYLsG1SnmoUYz/Vig4fa9kMvZ2kWH
        kvdQLFNqklGMOsHCZSHMuGebLAqKlJ9JYoJ9
X-Google-Smtp-Source: AA0mqf4JSTvtaNlruqOEJsvVoxQ0P2ufkIdh/bXEIt4ja82eLgspSDzURXBf3qitaDbtAq7QMlJizA==
X-Received: by 2002:a05:6402:1004:b0:46b:c156:9965 with SMTP id c4-20020a056402100400b0046bc1569965mr16090841edu.38.1670918013871;
        Mon, 12 Dec 2022 23:53:33 -0800 (PST)
Received: from [192.168.0.105] (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id s19-20020a056402037300b0046c91fa5a4asm4682250edw.70.2022.12.12.23.53.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Dec 2022 23:53:33 -0800 (PST)
Message-ID: <91c26e68-7559-c43a-de54-c3cf90b6d675@monstr.eu>
Date:   Tue, 13 Dec 2022 08:53:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <b7ece19c-e50e-0709-7be1-2945883d155b@monstr.eu>
 <CAHk-=wiuqbgRZcotVf93Db4+gcPz8yAhW0mMfNZbEkM66rNB3Q@mail.gmail.com>
Content-Language: en-US
From:   Michal Simek <monstr@monstr.eu>
Subject: Re: [GIT PULL] arch/microblaze patches for 6.2-rc1
In-Reply-To: <CAHk-=wiuqbgRZcotVf93Db4+gcPz8yAhW0mMfNZbEkM66rNB3Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/12/22 18:49, Linus Torvalds wrote:
> On Thu, Dec 8, 2022 at 2:07 AM Michal Simek <monstr@monstr.eu> wrote:
>>
>> Microblaze patches for 6.2-rc1
>>
>> - Cleanup PCI support
> 
> That tag looks normal in the email, but it's actually nastily encoded.
> When I fetched it, I did this:
> 
>       git cat-file tag FETCH_HEAD | hexdump -c
> 
> and it shows
> 
> ...
> 0000080   9   3   5   4   6       +   0   1   0   0  \n  \n   M   i   c
> 0000090   r   o   b   l   a   z   e 302 240   p   a   t   c   h   e   s
> 00000a0 302 240   f   o   r 302 240   6   .   2   -   r   c   1  \n  \n
> 00000b0   -       C   l   e   a   n   u   p       P   C   I       s   u
> 00000c0   p   p   o   r   t  \n   -   -   -   -   -   B   E   G   I   N
> ...
> 
> Note how the "spaces" between "Microblaze", "patches", "for" and "6.2"
> are not actually regular space characters, but \xc2\a0, which is utf-8
> encoding for unicode character A0 ("no-break space").
> 
> Please don't do that.  I have my editor show odd characters as hex
> codes (I don't want any hidden information), which is why I noticed,
> and I'm not sure why/how you did it.

It is not done intentionally. I am looking at previous commit messages and I do 
c&p the first line from firefox via gitweb interface. This is style I use for 
years but I see when I do it now that there are added additional chars as you 
mentioned above.

I tracked it down that it started to behave like this between Oct 11/Nov 22 
(from my U-Boot tags) and it is actually firefox (which was upgraded) who is 
adding additional chars there. When I do the same style via chrome I can't see 
any issue.

I will start to write the whole message by hand without c&p to make sure that it 
won't happen again.

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP/Versal ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal/Versal NET SoCs

