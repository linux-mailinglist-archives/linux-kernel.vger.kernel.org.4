Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1891574543D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 05:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbjGCDlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 23:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjGCDk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 23:40:57 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0CA012A;
        Sun,  2 Jul 2023 20:40:55 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 1AD0E6016E;
        Mon,  3 Jul 2023 05:40:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1688355646; bh=g9yXXDDfiKFGXYs35wZ62G1hHziQXBpu/IYLkrKqkDg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=O/UZeWoPbsLCMBDupTwBsAC2XHgCkemKAUlekJTTzTDsGIkiReU8l/c9twIbtzn6J
         9rkNxLQKk1eTNy8en+9mIFfOcmm24z4BCk0iAukECYGYgBhPlAlgc5hOgvVqb4d6qz
         jeQFG5CqM9guu/AxbfLHFW/qpF6YVt9+GKsBe7Cs73ph7o11e23kI/CTVHKga0Sc29
         HnV/M2/8isBE3AuGD3EE7+9N9Ss5tVR7BTw11y7/sOhlLzizSsRBwdASH1+Gw97GZS
         V8BrEygkutvgSk0xCPRX/Qe5FrJZ2tL48atFxpad4SL5zz6h0N/F3VycT4gIS5TF7E
         VZPWT1xaa8urw==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id sSarGCCyqUfX; Mon,  3 Jul 2023 05:40:43 +0200 (CEST)
Received: from [192.168.1.6] (unknown [94.250.191.183])
        by domac.alu.hr (Postfix) with ESMTPSA id C3FC960161;
        Mon,  3 Jul 2023 05:40:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1688355643; bh=g9yXXDDfiKFGXYs35wZ62G1hHziQXBpu/IYLkrKqkDg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=pGyWXq8MBiAkxy88cpu9HnHmlxrDWx9q9bPyFEbzm/8m6xDVbsq/XfhJVF5DA73BH
         nxih1zM0HFu4D/uCLVzcPjwohOdjmAt5vuLAQxt1Ks1qJjveWeFHi+9+HBIgqzHK3W
         lHpfezaRI+Fajwp0SzEsu8ruBL1/bDUV5G8WOL1LREe5FT6u3/lBir2sDcpLym6tQF
         Qep99UPR/BJNQqn2Y1ofO8TLkFGRh/XS+8uCJelcyD4aUlgPKvKwOA8V8HVNoeNThY
         Yom4DAzrnlvmtaBK3fE3XWIaFZdafHz3HHNFBGuICWXh/qBrYjYpWSMeRgwzq+LwVR
         3AwFlPs303oEg==
Message-ID: <d2144011-9825-7cc8-ae61-cfed27f78fa8@alu.unizg.hr>
Date:   Mon, 3 Jul 2023 05:40:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [CRASH][BISECTED] 6.4.1 crash in boot
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux LLVM <llvm@lists.linux.dev>
Cc:     linux-kbuild@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Guenter Roeck <linux@roeck-us.net>
References: <9a8e34ad-8a8b-3830-4878-3c2c82e69dd9@alu.unizg.hr>
 <ZKIoBVzrjZ+Ybxy9@debian.me>
Content-Language: en-US
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <ZKIoBVzrjZ+Ybxy9@debian.me>
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

On 7/3/23 03:44, Bagas Sanjaya wrote:
> On Sun, Jul 02, 2023 at 06:36:12PM +0200, Mirsad Goran Todorovac wrote:
>> Hi,
>>
>> After new git pull the kernel in Torvalds tree with default debug config
>> failed to boot with error that occurs prior to mounting filesystems, so there
>> is no log safe for the screenshot(s) here:
>>
>> [1] https://domac.alu.unizg.hr/~mtodorov/linux/crashes/2023-07-02/
>>
>> Bisect shows the first bad commit is 2d47c6956ab3 (v6.4-rc2-1-g2d47c6956ab3):
>>
>> # good: [98be618ad03010b1173fc3c35f6cbb4447ee2b07] Merge tag 'Smack-for-6.5' of https://github.com/cschaufler/smack-next
>> git bisect good 98be618ad03010b1173fc3c35f6cbb4447ee2b07
>> # bad: [f4a0659f823e5a828ea2f45b4849ea8e2dd2984c] drm/i2c: tda998x: Replace all non-returning strlcpy with strscpy
>> git bisect bad f4a0659f823e5a828ea2f45b4849ea8e2dd2984c
>> .
>> .
>> .
>> # bad: [2d47c6956ab3c8b580a59d7704aab3e2a4882b6c] ubsan: Tighten UBSAN_BOUNDS on GCC
>> git bisect bad 2d47c6956ab3c8b580a59d7704aab3e2a4882b6c
>> # first bad commit: [2d47c6956ab3c8b580a59d7704aab3e2a4882b6c] ubsan: Tighten UBSAN_BOUNDS on GCC
>>
>> The architecture is Ubuntu 22.04 with lshw and config give in the attachment.
> 
> Can you show early kernel log (something like dmesg)?

No, machine freezes after those screenfulls and I could only take a
screenshot.
  
> Anyway, I'm adding it to regzbot:
> 
> #regzbot ^introduced: 2d47c6956ab3c8
> #regzbot title: Linux kernel fails to boot due to UBSAN_BOUNDS tightening
> 
> Thanks.
> 
