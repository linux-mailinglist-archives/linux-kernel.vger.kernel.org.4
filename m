Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DEFF5FEC9A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 12:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbiJNKdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 06:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiJNKdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 06:33:04 -0400
Received: from domac.alu.hr (domac.alu.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F73D1C77D0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 03:33:02 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id E21C7604F1;
        Fri, 14 Oct 2022 12:32:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1665743579; bh=HeyEgrL8tPwV+soJuA8PP5qyivTn5FZTvpsM2LlSirA=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=eKz8jCyTrN2IxF/GI0YNbE0Be4btg942xYeBIejqPTEmupn1Rl5qiA5SLRUyBSDMW
         H9AFUNLTB2wggtP/1MHyQBzNqamHRp8VyqtvwQ1SJAOroP5Q03U7MTwFY7iB6rxG2P
         nlUulFdaT8rEgSkGTY7F1FfvrphVoFymbMYQabVfCHkocrge9VtRNisLR0srZ1Grym
         VQgnDT7NCkS6OqwXy1Qwi7JwdxrMJAvhIcsXEVNlMPyBFpsiWSIHht4u58Q1CRGVId
         MXxM1SM5E4mjmPOFzS6wABphNFXP9Y2oH0y6gLnDoFe+miU5pswIRARSKXp6VbYZm8
         mFhAVkAHI+Bog==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id tfhYaGS8RhY3; Fri, 14 Oct 2022 12:32:56 +0200 (CEST)
Received: from [193.198.186.200] (pc-mtodorov.slava.alu.hr [193.198.186.200])
        by domac.alu.hr (Postfix) with ESMTPSA id ED279604EC;
        Fri, 14 Oct 2022 12:32:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1665743576; bh=HeyEgrL8tPwV+soJuA8PP5qyivTn5FZTvpsM2LlSirA=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=J9mSNq5Ohl8Z2Y6uWe1FeLLLJy2CdciLhEvvY6/um+eiqtrWkUPtoc0n2jU6HYSBJ
         PWgu5/XT3YzL231jmBjUjL23HYzcnfBKj7miWREBIx1p0PwMABn1d/cziXvtQqyn6j
         lAQG7xLNwrZ4lWbNH4+2OhwPgLY/EqLdM4QuR1Z4CyhxyS1RUwt2k6hzYygiaUy2f8
         IfjxcF5k9Ue9aZ7ESDPJe5lcwn6ZO1ZP26Q4McQgL1tA+AzyoaqiC0E97OhpHuNe48
         n6R/84V08OSceBejpG2AXrTXlfsEzd4A7b3aRd3qXWoPBJO5kRTZd1LaF7FXxYY8BM
         3I5luVYNumfDA==
Message-ID: <6375f31f-316a-bebc-6aec-c6241049e401@alu.unizg.hr>
Date:   Fri, 14 Oct 2022 12:32:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: 6.0.0-RC kernels trigger Firefox snap bug with 6.0.0-rc3 through
 6.0.0-rc7
Content-Language: en-US
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Slade Watkins <srw@sladewatkins.net>,
        Marc Miltenberger <marcmiltenberger@gmail.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <b0c258c3-6dcf-aade-efc4-d62a8b3a1ce2@alu.unizg.hr>
 <Y0Zw2eHEb1aZ9f4y@debian.me>
 <29362d2e-eec6-5a23-4354-cf8868d50b2c@alu.unizg.hr>
In-Reply-To: <29362d2e-eec6-5a23-4354-cf8868d50b2c@alu.unizg.hr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everybody,

On 10/13/22 15:24, Mirsad Goran Todorovac wrote:

> Thank you for the instruction for how to shorten the bisection time. 
> My fastest build was almost 2 hours.
>
> This bug did appear with the mainline Ubuntu's and ElRepo's 6.0.0 
> kernels, however not with the
> /usr/bin/firefox build, but only that using snapd, squashfs and 
> /snap/bin/firefox ...
>
> The Firefox 91.x esr was unaffected, indeed, in a couple of days of 
> testing its work (on AL).
>
> However, please not that this bug is no deterministic, and that it can 
> take from a couple of hours
> to an overnight work to manifest.
>
> The "make localmodconfig" feature will probably help reducing the 
> build time, but I am also doing
> my day job stuff which by the Murphy's law surged right now ...
>
> You second request, to reproduce with Firefox from the dev site, is as 
> you will understand impossible
> to meet: the bug occurred only with Firefox 104.x and 105.0.1, 
> 105.0.2, 105.0.3 in Ubuntu snap
> release (and the snap release guest installed at AlmaLinux, the CentOS 
> fork).
>
> I was able to confirm that AppArmor doesn't affect behaviour once the 
> Firefox misbehaves.
> After starting to crash tabs and refusing to connect to the Internet 
> from inside Yahoo mail (Chrome
> simultaneously connected), then it complained about libmozsandbox.so 
> version and Verneed record.
>
> -Mirsad
>
> On 12.10.2022. 9:46, Bagas Sanjaya wrote:
>> Hi Mirsad,
>>
>> The bug doesn't appear on 6.0 mainline release. However, in my case,
>> Firefox is downloaded and installed from official Mozilla binary [1].
>>
>> Also, many developers here want to see bisection result. In order to
>> shorten kernel build time (and thus time needed for bisection),
>> you can strip out unneeded modules in your kernel configuration with
>> "make localmodconfig". Ensure that all devices on your computer is
>> plugged in before running that. And as other people pointed, base
>> your localmodconfig from last working kernel.
>>
>> In any case, please reproduce with Firefox from [1].
>>
>> Thanks.
>>
>> [1]: https://www.mozilla.org/en-US/firefox/
>>
I tried the "make localmodconfig" and provided the default answers 
([ENTER]) to all questions
the script asked as advised here: 
https://www.stolaf.edu/people/rab/os/linux-compile.html .

However, though it built much faster, the stripped version did not 
trigger the bug.

I am now trying to reproduce the bug with v6.0-rc[123] with 
config-{051913,060000}.
This brings a lot of combinations, and though I am a newbie, I noticed 
that build scripts
start with "make clean" for both deb-pkg and rpm-pkg.

Is there a way to rebuild only the stuff that changed between the versions?

Thank you.

-- 
Mirsad Goran Todorovac
Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu
-- 
System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb, Republic of Croatia

