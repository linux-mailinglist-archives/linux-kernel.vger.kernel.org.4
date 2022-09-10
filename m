Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43CCA5B47E3
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 20:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbiIJSNL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 14:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiIJSNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 14:13:09 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 287654AD58
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 11:13:08 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id 145so4672237pfw.4
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 11:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date;
        bh=B3vLcoYSGqr9VyKcT5vBvlQKyO5qij4poejcGa69FYg=;
        b=QEN64mPp/T8yf5c9I/0dBX4k1TKMKhGiRAXHzsIgPTMEiMhrGmWlQUr2sPX7uFA51R
         eA4Hsdwx74aX3XFh8MPmdHnKoPK4osP6F0Q0uHWP1SiUolzbNQFz8izi+SmZ5LaHPbKo
         obmdH4BxGHHJ4G1P8efY+co4+fsKKLSimkuKd9f35BVeXIZOQM4kCtnRiTN7/lVTC+gO
         i7jM8KU02G1HCQMouEl+jAr7w9dKag11vxOzP8+M2c/pPy8ADcWnusAgCoVAE9PqYt7+
         u7lHCPHJvtl2kRoF87ix2K2PkgEAkV7XDbs1jyHGTn3ly33CJtW3gMtMkHkSuiTwdbXv
         GGxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date;
        bh=B3vLcoYSGqr9VyKcT5vBvlQKyO5qij4poejcGa69FYg=;
        b=rjhx1eS+TGnG8d3BEFg8fvjcFCjO+ydsfHgWZNEUoGLZA1fVHxIpzo/J3iBmWNzkhX
         v5Z0FTHVQmDpOvXGR2JtRoteqIWn5F8mKeUMPCTV63E3cgzgMvXp/F1jmt8jF2gvVT8R
         R3oy5Mo9+aeqExw1ZuAHk0e68CD9j0j6474WbkTlN8s0AQhbrIdz5sscvzFgMFRS3khZ
         pcHHQv1KC/hT11Wnwp6GpmKEfbelRsQYI2vCScZ0sA2fe4F6WHEhr4HMoVzAADWmNmn8
         rBkfGpSxT8HWZ0zGNinnwauWDMc42TeR5YKv8I63xJ4OrlXns/aaTjYBh1Sq8ka+Fayz
         Nf8Q==
X-Gm-Message-State: ACgBeo33FMWOs4TaiN4Dm2x2k9PVPFFYfjrDtiCQhffy1+lKkMYeWKxc
        MYkTRnL6VQgxR0DribUrKSVSTu7GuZrn/g==
X-Google-Smtp-Source: AA6agR5n01tLWhONK3KZX8qGJbJU8+q4jI1Pzw66d+Lgh+qo0bjOA7mRW9e4GIeX90xqluEOuDbCSg==
X-Received: by 2002:a63:f747:0:b0:429:f993:da06 with SMTP id f7-20020a63f747000000b00429f993da06mr17176920pgk.291.1662833587548;
        Sat, 10 Sep 2022 11:13:07 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h6-20020aa796c6000000b0053e22fc5b4fsm2046434pfq.0.2022.09.10.11.13.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Sep 2022 11:13:05 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <752fba06-8ccc-d1e7-68d8-f141eece1230@roeck-us.net>
Date:   Sat, 10 Sep 2022 11:13:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAHk-=wiqix9N5P0BXrSSOXjPZxMh=wDDRJ3sgf=hutoTUx0nZQ@mail.gmail.com>
 <20220905125637.GA2630968@roeck-us.net>
 <CAHk-=whh=0FG6r_YJ4_1pq07b=bqN8gTExU5T_ys-SVn0CRDtQ@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: Linux 6.0-rc4
In-Reply-To: <CAHk-=whh=0FG6r_YJ4_1pq07b=bqN8gTExU5T_ys-SVn0CRDtQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/10/22 10:44, Linus Torvalds wrote:
> On Mon, Sep 5, 2022 at 8:56 AM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> Revert "scsi: core: Make sure that targets outlive devices"
>> Revert "scsi: core: Make sure that hosts outlive targets"
>> Revert "scsi: core: Simplify LLD module reference counting"
>> Revert "scsi: core: Call blk_mq_free_tag_set() earlier"
>>      revert f323896fe6fa
>>      revert 1a9283782df2
>>      revert fe442604199e
>>      revert 16728aaba62e
>>      Rationale:
>>          The series may result in hung tasks on reboot when booting from USB drive.
> 
> This should be in my tree as of yesterday evening thanks to the SCSI
> fixes merge.
> 
>> Revert "fec: Restart PPS after link state change"
>>      revert f79959220fa5
>>      Rationale:
>>          The patch results in various tracebacks and crashes.
> 
> Hmm. No revert, but does commit b353b241f1eb ("net: fec: Use a
> spinlock to guard `fep->ptp_clk_on`") fix it?
> 

No. The m68k crash is still there as of v6.0-rc4-284-gce888220d5c7. The above patch
changes fec_enet_clk_enable(), but the crash is elsewhere - or at least now it is
elsewhere.

*** ILLEGAL INSTRUCTION ***   FORMAT=4
Current process id is 1
BAD KERNEL TRAP: 00000000
PC: [<00000000>] 0x0
SR: 2704  SP: (ptrval)  a2: 40829628
d0: 00002700    d1: 00000000    d2: 40829420    d3: 00000000
d4: 00000000    d5: 402e81aa    a0: 00000000    a1: 00000012
Process swapper (pid: 1, task=(ptrval))
Frame format=4 eff addr=400681c2 pc=00000000
Stack from 40831cf0:
         40829420 00000000 40832000 402e81aa 40bae000 00000008 40829420 40829000
         401b0e44 40829628 40829420 00000000 40831e0c 00000200 401dce0a 40884a50
         401b14d6 40829598 4082970e 40347ee0 401ad2d6 40829420 40347eea 00000000
         40831e0c 402e81aa 40bae000 00000008 40347ee0 40829000 fffffff8 4082944e
         40829000 408294bb 00000002 00000000 00000000 00000000 00000000 00000000
         00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
Call Trace: [<401b0e44>] fec_ptp_gettime+0x28/0x68
  [<401dce0a>] __alloc_skb+0xb0/0x24c
  [<401b14d6>] fec_ptp_save_state+0x12/0x3e
  [<401ad2d6>] fec_restart+0x5a/0x770
  [<401ae4c0>] fec_probe+0x732/0xcee
...

On top of that, I now also see

[   22.043994] BUG: sleeping function called from invalid context at drivers/clk/imx/clk-pllv3.c:68
[   22.044249] in_atomic(): 1, irqs_disabled(): 128, non_block: 0, pid: 272, name: ip
[   22.044395] preempt_count: 1, expected: 0
[   22.044485] 3 locks held by ip/272:
[   22.044571]  #0: c1af1ce0 (rtnl_mutex){+.+.}-{3:3}, at: devinet_ioctl+0xbc/0x8f0
[   22.044792]  #1: c40dc8e8 (&fep->tmreg_lock){....}-{2:2}, at: fec_enet_clk_enable+0x58/0x250
[   22.045011]  #2: c1a71af8 (prepare_lock){+.+.}-{3:3}, at: clk_prepare_lock+0xc/0xd4
[   22.045217] irq event stamp: 1460
[   22.045295] hardirqs last  enabled at (1459): [<c1084cd8>] _raw_spin_unlock_irqrestore+0x50/0x64
[   22.045454] hardirqs last disabled at (1460): [<c1084a98>] _raw_spin_lock_irqsave+0x64/0x68
[   22.045623] softirqs last  enabled at (1444): [<c0e77268>] __dev_change_flags+0xa8/0x254
[   22.045784] softirqs last disabled at (1442): [<c0e77238>] __dev_change_flags+0x78/0x254
[   22.045944] CPU: 0 PID: 272 Comm: ip Tainted: G        W        N 6.0.0-rc4-00286-gb260ebd186c0 #1
[   22.046113] Hardware name: Freescale i.MX7 Dual (Device Tree)
[   22.046235]  unwind_backtrace from show_stack+0x10/0x14
[   22.046360]  show_stack from dump_stack_lvl+0x68/0x90
[   22.046477]  dump_stack_lvl from __might_resched+0x17c/0x284
[   22.046604]  __might_resched from clk_pllv3_wait_lock+0x4c/0xcc
[   22.046735]  clk_pllv3_wait_lock from clk_core_prepare+0xc4/0x328
[   22.046866]  clk_core_prepare from clk_core_prepare+0x50/0x328
[   22.046992]  clk_core_prepare from clk_core_prepare+0x50/0x328
[   22.047118]  clk_core_prepare from clk_core_prepare+0x50/0x328
[   22.047243]  clk_core_prepare from clk_core_prepare+0x50/0x328
[   22.047368]  clk_core_prepare from clk_core_prepare+0x50/0x328
[   22.047493]  clk_core_prepare from clk_core_prepare+0x50/0x328
[   22.047618]  clk_core_prepare from clk_core_prepare+0x50/0x328
[   22.047744]  clk_core_prepare from clk_core_prepare+0x50/0x328
[   22.047868]  clk_core_prepare from clk_core_prepare+0x50/0x328
[   22.047992]  clk_core_prepare from clk_prepare+0x20/0x30
[   22.048110]  clk_prepare from fec_enet_clk_enable+0x68/0x250
[   22.048235]  fec_enet_clk_enable from fec_enet_open+0x3c/0x3b8
[   22.048360]  fec_enet_open from __dev_open+0xec/0x1ac
[   22.048476]  __dev_open from __dev_change_flags+0x1bc/0x254
[   22.048603]  __dev_change_flags from dev_change_flags+0x14/0x44
[   22.048730]  dev_change_flags from devinet_ioctl+0x88c/0x8f0
[   22.048854]  devinet_ioctl from inet_ioctl+0x194/0x258
[   22.048971]  inet_ioctl from sock_ioctl+0x4b0/0x5cc
[   22.049083]  sock_ioctl from sys_ioctl+0x548/0xf18
[   22.049198]  sys_ioctl from ret_fast_syscall+0x0/0x1c

in various arm boot tests. This is new since -rc4.

Guenter
