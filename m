Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14CA5674701
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 00:14:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbjASXOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 18:14:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbjASXN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 18:13:29 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AA4C8A707
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 15:09:47 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id t12-20020a17090aae0c00b00229f4cff534so94504pjq.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 15:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EZ+aefaBRb6Q46DF1JPfX563rL64aYsp6riA6+GUZ18=;
        b=DxJRbKewKWbHMLYof4DKgM2lJNkwIfDTWbfLBqT12tHpZ531R2WUhhGdxyX/JeOD1/
         o6QJTA1ruywqFgCzrpdDFRlbhdswPtvx3G44btRRmWNfUycQCO2FLhPNN1MXY2bvMcez
         uYDcX1kG4gYyxqx0vcLKofVyv1uuiivvXmTzfjsSJvhh/iH31WTTJckq0lDwyhxATJpZ
         iHr3Je/JaNBuNzop9mSOD2Zv/5ZNLVVzxxM1pENXAhQDZNdyQqRwYe1RcJybQsjrsrBH
         cUYAGz84SskHIvMPLPVPx3iw7mGJb6PPtBl6K3MOBEUi7ngeQ/zr2V0dWaH277amnZyt
         3g4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EZ+aefaBRb6Q46DF1JPfX563rL64aYsp6riA6+GUZ18=;
        b=jQZM7FmOCYqMYIvxgTsDcbHdo5+cER+jHBxAvkJDhm0NnUt201BRE8xz6ISqlhQrsR
         1+lIkYg2LRz5cTLbHldpBXPNqJKRCM3srxPR9yWWz6ws/n197o8YsulF/ABQvk/YlJvB
         Elk/Fyzy5npGP4dknUW/Jz9KyfhoVORJtPWvXSbEDsJCXLueuHCg/wk2pnawPd023PiX
         GlwHZhtNLe+JLfKusIcoK2eq0EJEPC7gxvB41twSMb0KQ9IJ8sG+5QvpUXbPQc8t2khF
         zzLhbm9+ksOkz1gjPo4hqF2eoZkdJfhA80xeYRV3uCkgz8eRDJ0AoC/ZkHL4afJ0FTRy
         OOKA==
X-Gm-Message-State: AFqh2krkwZI4AK+KTKluYm0cvPzgM8t+bqBjhsfqAP2jp3ultY59cp3b
        xCakU+ddW2ZrFG4nvVy5kvE9dw==
X-Google-Smtp-Source: AMrXdXsx2nwQhGawNQ2nONo1ETqHOUZjRLTu/2aLPtp0u8Y6H9tpiJve2Py4qWJENOxwBW+UzqSMLw==
X-Received: by 2002:a17:902:ead2:b0:194:4785:5e9 with SMTP id p18-20020a170902ead200b00194478505e9mr3015839pld.4.1674169786672;
        Thu, 19 Jan 2023 15:09:46 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id h6-20020a170902f54600b00176b84eb29asm1072571plf.301.2023.01.19.15.09.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jan 2023 15:09:46 -0800 (PST)
Message-ID: <a4f62523-b01e-3986-7914-767f999b4153@kernel.dk>
Date:   Thu, 19 Jan 2023 16:09:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [ANNOUNCE] 5.10.162-rt78
Content-Language: en-US
To:     Salvatore Bonaccorso <carnil@debian.org>,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Cc:     Pavel Machek <pavel@denx.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        stable-rt <stable-rt@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@suse.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Jeff Brady <jeffreyjbrady@gmail.com>
References: <Y8VSslRJZpFbo1/u@uudg.org>
 <40de655e-26f3-aa7b-f1ec-6877396a9f1e@ti.com> <Y8krsVFguwWLy+zT@duo.ucw.cz>
 <Y8lCspFtQ0wg6uCy@uudg.org> <Y8mwF0m+M1+e/fz/@eldamar.lan>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Y8mwF0m+M1+e/fz/@eldamar.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/19/23 2:03?PM, Salvatore Bonaccorso wrote:
> Hi Luis, all,
> 
> On Thu, Jan 19, 2023 at 10:16:34AM -0300, Luis Claudio R. Goncalves wrote:
>> On Thu, Jan 19, 2023 at 12:38:25PM +0100, Pavel Machek wrote:
>>> Hi!
>>>
>>>>> I'm pleased to announce the 5.10.162-rt78 stable release.
>>>>>
>>>>> You can get this release via the git tree at:
>>>>>
>>>>>   git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git
>>>>>
>>>>>   branch: v5.10-rt
>>>>>   Head SHA1: 143ef105f40a65f3ddd57121d4b4bc36eb10cc06
>>>>>
>>>>> Or to build 5.10.162-rt78 directly, the following patches should be applied:
>>>
>>>> I see that vanilla 5.10.162-rt78 fails to build with arm64 defconfig. [0] Full log [1]
>>>> Any pointers on what maybe wrong?
>>>
>>> We see the same failure. 
>>>
>>>>   AS      arch/arm64/kernel/entry.o
>>>> arch/arm64/kernel/entry.S: Assembler messages:
>>>> arch/arm64/kernel/entry.S:763: Error: immediate out of range at operand 3 -- `and x2,x19,#((1<<1)|(1<<0)|(1<<2)|(1<<3)|(1<<4)|(1<<5)|(1<<6)|(1<<13)|(1<<7))'
>>>> make[2]: *** [scripts/Makefile.build:367: arch/arm64/kernel/entry.o] Error 1
>>>> make[1]: *** [scripts/Makefile.build:503: arch/arm64/kernel] Error 2
>>>> make: *** [Makefile:1837: arch/arm64] Error 2
>>>
>>> The line is:
>>>
>>>>        and     x2, x19, #_TIF_WORK_MASK
>>
>> I believe this is related to the arch/arm64/include/asm/thread_info.h
>> changes in 5.10.162-rt78, specifically:
>>
>>     79a9991e87fe arm64: add support for TIF_NOTIFY_SIGNAL
>>     1ba44dcf789d Merge tag 'v5.10.162' into v5.10-rt
>>
>> The first one is the original change, coming from stable v5.10.162 and the
>> second one has the merge conflict I fixed in that file due to the existence
>> of TIF_NEED_RESCHED_LAZY in PREEMPT_RT.
>>
>> It escaped me that having TIF_NEED_RESCHED_LAZY set to 13 breaks the AND
>> statement reported above. Looking at
>>
>>     b5a5a01d8e9a arm64: uaccess: remove addr_limit_user_check()
>>
>> specially this note
>>
>>     To ensure that _TIF_WORK_MASK can be used as an immediate value in an
>>     AND instruction (as it is in `ret_to_user`), TIF_MTE_ASYNC_FAULT is
>>     renumbered to keep the constituent bits of _TIF_WORK_MASK contiguous.
>>
>> I understand that I need to either have to renumber TIF_NEED_RESCHED_LAZY
>> to 8, with the risk of breaking something else, or backport commit
>> b5a5a01d8e9a in order to remove TIF_FSCHECK and then safely renumber
>> TIF_NEED_RESCHED_LAZY.
>>
>> Guidance is welcome here :)
> 
> Should we loop in here Jens, as having some overview of the needed
> changes for io_uring rebase in the 5.10.y version? (doing so in the
> mail).

Huh that's funky, I built and (runtime) tested this on arm64
specifically. But I do remember some details about the first 8 bits on
arm, but not arm64.

I guess we need to twiddle that asm to deal with eg 16 bits, rather than
attempt to backport any TIF removal patches.

-- 
Jens Axboe

