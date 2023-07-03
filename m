Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5CF8745453
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 05:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjGCDx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 23:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbjGCDxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 23:53:54 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7367D12A;
        Sun,  2 Jul 2023 20:53:53 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 94D0D6016E;
        Mon,  3 Jul 2023 05:53:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1688356431; bh=uzx1ErNrMjImzVv3l2byDkeCdYnn0EgrD81DL/eF2m4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=qsYOgmyFhbTuZ8orbdWOKkBvRdjpyk0i/92fSoeoHlqS1TeYiuIpJXAtAtZio7xRl
         5svK14fJUqRLVPtvGMZuhLy3KhvBpibOy+Q529MYKJDueNN0TefgyL8fyl8e3ohVIE
         +mX8SsD8ES4NcOdaR5xQKugVwFJ8avOEACehtf6qQEIdCdBg35y6WS/KcxOIlKXTG0
         +roS2pgMzJnftA+HbxQaa5ZIrGpVJpnNSVGq0+XNFZ/jLDJRv31bOqcTvBIXFfqeGL
         D8KOJwLx2K70xwnJCVq0cV8NCeF5dDiXf3t7D61MJbk8KgJUzmgkZZ8e+PRfWT34ZE
         enyL+DtGjxruQ==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Aa4XC2t8HN-g; Mon,  3 Jul 2023 05:53:48 +0200 (CEST)
Received: from [192.168.1.6] (unknown [94.250.191.183])
        by domac.alu.hr (Postfix) with ESMTPSA id D071B60161;
        Mon,  3 Jul 2023 05:53:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1688356428; bh=uzx1ErNrMjImzVv3l2byDkeCdYnn0EgrD81DL/eF2m4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=R7iQj/claQ0foW9Tpy5MCBtv5b2NX9DbFCan5Vv4KmlTUa8JdpId08vS6A5eDOOkk
         NcQQPSU+ew/+A8Sumn8utudjczlX77SLqP7gGbyPSAOGKPxB84fDBZvkqbbj8Sl6zU
         7Vqo76N0jDKHBiA6xVfX9z8ow0Dj4IYjSNz4SvS6fORA1wbm8nJZS0Ba8U9d5c6LQm
         g5hD+vdrlMxfEUeG7ekc9iQLbdsN33UjiXN9bQ76mbjZcja5MAyKh27VyRRwA2f9eJ
         ZvhrziV+8dGZ854DPEOq6oq54P9++cYFGQPSucVu9YkD09jgPzT/WEYtlIwZMAflHB
         LpeSiPAulR3Iw==
Message-ID: <4ea9488c-0f98-89b4-7af3-174cfcdaa02c@alu.unizg.hr>
Date:   Mon, 3 Jul 2023 05:53:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [CRASH][BISECTED] 6.4.1 crash in boot
To:     Guenter Roeck <linux@roeck-us.net>,
        Kees Cook <keescook@chromium.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux LLVM <llvm@lists.linux.dev>,
        linux-kbuild@vger.kernel.org,
        Linux Regressions <regressions@lists.linux.dev>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
References: <9a8e34ad-8a8b-3830-4878-3c2c82e69dd9@alu.unizg.hr>
 <ZKIoBVzrjZ+Ybxy9@debian.me> <202307022018.B26F5795@keescook>
 <625e951e-9922-d15d-5520-e8cd5eba1995@roeck-us.net>
Content-Language: en-US
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <625e951e-9922-d15d-5520-e8cd5eba1995@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/3/23 05:26, Guenter Roeck wrote:
> On 7/2/23 20:20, Kees Cook wrote:
>> On Mon, Jul 03, 2023 at 08:44:37AM +0700, Bagas Sanjaya wrote:
>>> On Sun, Jul 02, 2023 at 06:36:12PM +0200, Mirsad Goran Todorovac wrote:
>>>> Hi,
>>>>
>>>> After new git pull the kernel in Torvalds tree with default debug config
>>>> failed to boot with error that occurs prior to mounting filesystems, so there
>>>> is no log safe for the screenshot(s) here:
>>>>
>>>> [1] https://domac.alu.unizg.hr/~mtodorov/linux/crashes/2023-07-02/
>>>>
>>>> Bisect shows the first bad commit is 2d47c6956ab3 (v6.4-rc2-1-g2d47c6956ab3):
>>>>
>>>> # good: [98be618ad03010b1173fc3c35f6cbb4447ee2b07] Merge tag 'Smack-for-6.5' of https://github.com/cschaufler/smack-next
>>>> git bisect good 98be618ad03010b1173fc3c35f6cbb4447ee2b07
>>>> # bad: [f4a0659f823e5a828ea2f45b4849ea8e2dd2984c] drm/i2c: tda998x: Replace all non-returning strlcpy with strscpy
>>>> git bisect bad f4a0659f823e5a828ea2f45b4849ea8e2dd2984c
>>>> .
>>>> .
>>>> .
>>>> # bad: [2d47c6956ab3c8b580a59d7704aab3e2a4882b6c] ubsan: Tighten UBSAN_BOUNDS on GCC
>>>> git bisect bad 2d47c6956ab3c8b580a59d7704aab3e2a4882b6c
>>>> # first bad commit: [2d47c6956ab3c8b580a59d7704aab3e2a4882b6c] ubsan: Tighten UBSAN_BOUNDS on GCC
>>>>
>>>> The architecture is Ubuntu 22.04 with lshw and config give in the attachment.
>>>
>>> Can you show early kernel log (something like dmesg)?
>>>
>>> Anyway, I'm adding it to regzbot:
>>>
>>> #regzbot ^introduced: 2d47c6956ab3c8
>>> #regzbot title: Linux kernel fails to boot due to UBSAN_BOUNDS tightening
>>
>> I'm confused. Commit 2d47c6956ab3c8b580a59d7704aab3e2a4882b6c isn't in the v6.4
>> tree... it's only in Linus's ToT.
>>
> 
> In ToT:
> 
> $ git describe 2d47c6956ab3
> v6.4-rc2-1-g2d47c6956ab3
> 
> $ git describe --contains 2d47c6956ab3
> next-20230616~2^2~51
> $ git describe --contains --match 'v*' 2d47c6956ab3
> fatal: cannot describe '2d47c6956ab3c8b580a59d7704aab3e2a4882b6c'
> 
> "git describe" always shows the parent tree, which I guess was based on
> v6.4-rc2.
> 
> Guenter
> 
> 
>> Also, the config you included does not show CONFIG_UBSAN_BOUNDS_STRICT
>> as even being available, much less present. Something seems very wrong
>> with this report...
>>
>> -Kees

Anyway, I have double checked and linux-image-6.4.0-rc2-crash boots while
linux-image-6.4.0-rc2-crash-00001-g2d47c6956ab3 freezes in early boot.

Of course, in the next boot dmesg appears overwritten ... I could provide
only the first screen screenshots.

The difference is only one commit.

It is a bit strange so I am available for any additional diagnostics.

Regards,
Mirsad

