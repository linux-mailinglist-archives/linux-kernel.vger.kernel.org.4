Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABB9A6D3E21
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 09:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbjDCHd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 03:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbjDCHdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 03:33:25 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F5E902A;
        Mon,  3 Apr 2023 00:33:23 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 70A1A604F2;
        Mon,  3 Apr 2023 09:33:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1680507201; bh=OomdGXBJG+0KCTW3JqIeMmiq2WhKhkrYe6oOfcXQtqE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=1FI7hIoMd6/7BkrWfr0Suz4+rj5qy/kEtzQGHx31PUvAVI0G+qFPlbT/029IFDyhQ
         GrawhgTrna5iPdox/ZBvxSVkg7Zz2ZAMZlMPIy/CVavYZsPZcpvQiRSueMDsJR1B2U
         x9YBz9iMyXgdlyGByM03gW6x9tEZdU1pPPqe54VQtRAyoRuXUMJmQmsXk0BGPQDl0l
         rFO4sognQ8u1D05KP6pXUXLRDaji3rUzd7LEhLNcJahhn2szAjo5o4HsLnk1sVrjy6
         dY/VxHIxEYee+UuMsLOxSNr7PilIQ8F4YR9PJEcR4lA179Xal/Xru4EQarOqx7SER6
         nDFordyEs485w==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id SnKZMUtd8w0M; Mon,  3 Apr 2023 09:33:18 +0200 (CEST)
Received: from [10.0.1.57] (grf-nat.grf.hr [161.53.83.23])
        by domac.alu.hr (Postfix) with ESMTPSA id 5A0B2604F0;
        Mon,  3 Apr 2023 09:33:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1680507198; bh=OomdGXBJG+0KCTW3JqIeMmiq2WhKhkrYe6oOfcXQtqE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=RnZ//ZGw7muFEbjr29RB9tqlR8+EKXXva1OvIl6W2fFjfpHw22dq6xAX9HvP6qjgF
         CtBwqCe5NXmFhur9fMD32xrHIqHM3sCjyUjxK6l7HnS1yHNddGi6iCk4gn1Q7nptrX
         YJGhQm7fxp5Oo/rQaPbA19mCxcQGGY7RyhvRubAdfUo/emSt3SQQ/GgKl6n/MgdNGd
         hxBVmiiqg1n5nLSVg3sBC6eJGwtyxX8n1QIpFv5TNs2CJGCkuZJOOLu9BwJ/4CWWrV
         QEx/H3cieA34rouBspmxFRM4qZgyJWbLi3sGiN69Oiffsp1dtCoP9ufIf4tbm3kpnV
         jTeCttIid3ZFw==
Message-ID: <2bd88480-24b4-b848-5092-47b6e31cf902@alu.unizg.hr>
Date:   Mon, 3 Apr 2023 09:33:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [BUG] [RFC] Problem with automatic kernel numbering
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Armin Wolf <W_Armin@gmx.de>,
        Masahiro Yamada <masahiroy@kernel.org>
References: <c4c14e20-941d-444e-7390-8624024d3027@alu.unizg.hr>
 <e33e3a14-fede-6a63-7cfe-776e02e2eecc@gmail.com>
Content-Language: en-US, hr
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <e33e3a14-fede-6a63-7cfe-776e02e2eecc@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2.4.2023. 15:23, Bagas Sanjaya wrote:
> On 4/1/23 18:54, Mirsad Goran Todorovac wrote:
>> I am talking about a problem with the CONFIG_LOCALVERSION_AUTO=y feature.
>>
>> I thought of a way to make an exact account of which patches were applied in a build
>> i.e. adding patch checksum to 6.3.0-rc4-00034-gfcd476ea6a88-dirty, for currently the
>> command
>>
>> # rpm -ivh --oldpackage <kernelname>-<build-no>.rpm
>>
>> install the kernels
>>
>> kernel-6.3.0_rc4mt+20230330_00051_g8bb95a1662f8_dirty-24.x86_64.rpm
>> kernel-6.3.0_rc4mt+20230330_00051_g8bb95a1662f8_dirty-25.x86_64.rpm
>> kernel-6.3.0_rc4mt+20230330_00051_g8bb95a1662f8_dirty-26.x86_64.rpm
>>
> First, Cc'ing Masahiro.

Thank you, Sir.

> I think applying patches with `git am` should change the `git describe`
> part of kernel version name. However, in this case, you have uncommitted
> changes in your tree when building.

Yes, this does create a unique commit hash. This apparently solves the problem.
Thanks for the hint.

>> all overlapping (apparently everything after '-' [minus] sign is discarded,
>> so one has to reboot to another kernel, i.e. 6.1.15, remove the offending kernel,
>> and then install the new one in the sequence of testing.
>> The CONFIG_LOCALVERSION_AUTO=y rpm build script might add something that rpm
>> command sees in the install process so the files do not overlap (as kernel names
>> are being truncated at '-' sign).

> Patch number truncated?

Indeed.

All of the

 >> kernel-6.3.0_rc4mt+20230330_00051_g8bb95a1662f8_dirty-24.x86_64.rpm
 >> kernel-6.3.0_rc4mt+20230330_00051_g8bb95a1662f8_dirty-25.x86_64.rpm
 >> kernel-6.3.0_rc4mt+20230330_00051_g8bb95a1662f8_dirty-26.x86_64.rpm

were treated like "kernel-6.3.0_rc4mt+20230330_00051_g8bb95a1662f8_dirty" by
the `rpm -ivh --oldpackage <package>.rpm` command.

This cause install collisions in filenames (thankfully, it did not break the
system, only prevented install until reboot in the third kernel, uninstall old
and install new - however, this is error prone and clumsy).

>> A smaller hash of the applied patches would suffice, considering the limit
>> of 64 chars. Or using an underscore '_' instead of minus '-', so the rpm
>> installer doesn't treat them as the same version of kernel.
> 
> 12 chars is minimum abbreviated hash length for Linux kernel, so it is
> already sufficient. Personally, I bump to 14 chars to give more headroom in
> case 12 chars give 50% collision in the (hopefully distant) future.

This is not a problem with the 12-chars truncated SHA-1 hash, I suppose, but
truncating "-24", "-25" and "-26" from the build id.

> Thanks.

Not at all, Sir.

It would be very useful if the kernel gave i.e. in /proc/applied-patches/*
the list of patches applied and against which build tree. If that is possible.
Do I make any sense?

Possibly, git may not be that smart to distinguish patches i.e. from the torvalds
from those manually applied with `git am`?

This might look like this:

# cat /proc/applied-patches/list
10de4cefccf7 (HEAD -> master) memstick: fix memory leak if card device is never registered
feeedf59897c platform/x86: think-lmi: Clean up display of current_value on Thinkstation
86cebdbfb8d2 platform/x86: think-lmi: Fix memory leaks when parsing ThinkStation WMI strings
ff9de97baa02 The command allocated to set exit latency LPM values need to be freed in case the command is never queued. This would 
be the case if there is no change in exit latency values, or device is missing.
2ac6d07f1a81 platform/x86: think-lmi: Fix memory leak when showing current settings
# cat /proc/applied-patches/2ac6d07f1a81
commit 2ac6d07f1a813facd03a0c011a48b317ed9f4654
Author: Armin Wolf <W_Armin@gmx.de>
Date:   Fri Mar 31 23:33:19 2023 +0200

     platform/x86: think-lmi: Fix memory leak when showing current settings

     When retriving a item string with tlmi_setting(), the result has to be
     freed using kfree(). In current_value_show() however, malformed
     item strings are not freed, causing a memory leak.
     Fix this by eliminating the early return responsible for this.

     Reported-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
     Link: https://lore.kernel.org/platform-driver-x86/01e920bc-5882-ba0c-dd15-868bf0eca0b8@alu.unizg.hr/T/#t
     Tested-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
     Fixes: 0fdf10e5fc96 ("platform/x86: think-lmi: Split current_value to reflect only the value")
     Signed-off-by: Armin Wolf <W_Armin@gmx.de>

However, I can't seem to find a git diff command to give me difference from the main branch?

Actually, I can, with some Googling:

mtodorov@domac:~/linux/kernel/linux_torvalds$ git log --oneline origin/master..master
10de4cefccf7 (HEAD -> master) memstick: fix memory leak if card device is never registered
feeedf59897c platform/x86: think-lmi: Clean up display of current_value on Thinkstation
86cebdbfb8d2 platform/x86: think-lmi: Fix memory leaks when parsing ThinkStation WMI strings
ff9de97baa02 The command allocated to set exit latency LPM values need to be freed in case the command is never queued. This would 
be the case if there is no change in exit latency values, or device is missing.
2ac6d07f1a81 platform/x86: think-lmi: Fix memory leak when showing current settings
mtodorov@domac:~/linux/kernel/linux_torvalds$

So, git knows the list of applied patches against the vanilla tree.

What would be handy for forensics would be to that that listed in /proc/applied-patches/list
or something, just like /boot/config-$(uname -r) is helpful.

However, this might not be so useful. Using "git am" solves the majority of the problem.

There is a warning in the kernel docs that the newbie developers have ideas that are
sometimes rejected.

I should do a lot of homework before making such suggestions :-/

Best regards,
Mirsad

-- 
Mirsad Todorovac
System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb
Republic of Croatia, the European Union

Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu

