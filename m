Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B80025F2C34
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 10:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbiJCInH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 04:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbiJCImg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 04:42:36 -0400
Received: from domac.alu.hr (domac.alu.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3382A13D67
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 01:19:01 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 3D5FB604F3;
        Mon,  3 Oct 2022 10:18:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1664785136; bh=UGHum/LFzRTkwvEfKnX3DJ9u4cum+7QJWU0b5trnnu8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=AR58iwke6RmKM04Z9WcpwGuUZhPnkBo+bHEgwxaf3lvsQnCR5Kd68823j/vRG8tIw
         S4TLl/dpQCV+mZVfVTpSKxfU1PmSuaQJMFiWhklqgDJDR/U4tbyOMfpi/iE/5SBuXN
         v1VyaQS6N/1Dbooa/fqUnBu+D13Gi9UaVaFfgjl+Ar7PzXDF0rWGfWsHVoWuuK9VyY
         1LoYdQKlNQQPhWebq8AG+P7GznS5XdyloEPxtYkIi+c19U+NOMN9hKGAozKdOYykJk
         kGW8s48AgU+oZ/q7pxB1chkXeMVJdTSM/b44EzExFX6XVKCT/oE6+G2judd0h68GRr
         Ki/F5zjFhFu2g==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 1MOYg4x5tYUA; Mon,  3 Oct 2022 10:18:53 +0200 (CEST)
Received: from [10.0.2.24] (grf-nat.grf.hr [161.53.83.23])
        by domac.alu.hr (Postfix) with ESMTPSA id 6C66E604F0;
        Mon,  3 Oct 2022 10:18:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1664785133; bh=UGHum/LFzRTkwvEfKnX3DJ9u4cum+7QJWU0b5trnnu8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=DzI7nGel9DXkr5dgcZH+KAEMh35Vh+I3CP+r/IoOiqWDuuJooIfEgoNjUlta0VD4/
         /ArU2WwzqOMadE+TAXFDa37i41xqMXOmDvELQQ/aieienGHnvzw9IanAZZNGCn3bXk
         jyq0OHCI72Gz6rvspIS8XtaawjrJqzPT9FHxwvczVNaiXfUzjeOiwLINy429ES2Egg
         69BenQ8D54DZlI2FdfR2WJU+1Ru+zKIb7G4cYvchCK1XS5JV612XbyHDyqGhOQxfgN
         EzYwlX+GoKr/C4LHpjMdMH2Zwq6l9+MkCwXN2+08f6C8qkc7sn6nPQ1mjVBtGIAvUV
         c/pCHe0CsUrWA==
Message-ID: <254f0b04-428e-cad8-02e3-0224b798b060@alu.unizg.hr>
Date:   Mon, 3 Oct 2022 10:18:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: BUG: 6.0.0-RC kernels trigger Firefox snap bug with 6.0.0-rc3
 through 6.0.0-rc7
Content-Language: en-US
To:     Slade Watkins <srw@sladewatkins.net>
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <b0c258c3-6dcf-aade-efc4-d62a8b3a1ce2@alu.unizg.hr>
 <1266113f-75a1-b276-bb8c-3cdfcbabf043@alu.unizg.hr>
 <47CFBECB-AE3D-4252-972D-933D2DF4A8EB@sladewatkins.net>
 <77bc5046-7b69-6100-f991-60b4d53994ee@alu.hr>
 <0BD28445-7393-4153-B15C-59E5DA868E80@sladewatkins.net>
 <2F9EDCCA-AB85-44CE-AD9F-44394C8663B8@sladewatkins.net>
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <2F9EDCCA-AB85-44CE-AD9F-44394C8663B8@sladewatkins.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.9.2022. 20:27, Slade Watkins wrote:

> Hey there:
>> On Sep 30, 2022, at 8:03 AM, Slade Watkins <srw@sladewatkins.net> wrote:
>>
>> Huh, okay, I’ll see if I can try to reproduce it again.
>>
>> I wasn’t having issues with kernel 6.0-rc7 but I’ll try a fresh install and see what that changes.
> I tried again twice (for “good measure,” so to speak.)
> Once with my x86_64 test machine (fresh install of my distribution and 6.0-rc7 kernel, Firefox snap 104.x/105.0.1), and with your setup (AlmaLinux, 6.0-rc7, same versions of Firefox snaps previously mentioned) as described in a previous email [1] and couldn’t reproduce.
>
> Not sure what’s happening here, or what’s to blame (the kernel, snapd, etc.), to be completely honest with you. But obviously, there’s an issue on your system with the snaps. So in that case, I do think somebody else with more insight into what could possibly affect this — or even Mozilla (specifically, the maintainers of their snap package) — may be more helpful.
>
> But please feel free to keep me in the loop! Even though I’m not able to reproduce, I’d still like to help wherever possible.
>
> [1] https://lore.kernel.org/lkml/1266113f-75a1-b276-bb8c-3cdfcbabf043@alu.unizg.hr/
> [2] https://lore.kernel.org/lkml/77bc5046-7b69-6100-f991-60b4d53994ee@alu.hr/
>
> Best,
> -srw

Hi, Slate,

I'm sorry you couldn't reproduce the bug. I will try to provide the list of the installed pkgs the
next time, for both configs.

I will try the linux-6.0.y build on Ubuntu 22.04 "focal" and Almalinux 8.6.

Hopefully there will be a result later today.

I couldn't find an option to build both deb-pkg and rpm-pkg, so the Makefile is needlessly compiling
the source twice :-(

Kind regards,
mt

-- 
Mirsad Todorovac
System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb
Republic of Croatia, the European Union
--
Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu

