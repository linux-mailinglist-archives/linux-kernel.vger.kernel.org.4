Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1D9674A60
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 04:49:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjATDtg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 22:49:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjATDte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 22:49:34 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C09AA9370A
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 19:49:32 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id z9-20020a17090a468900b00226b6e7aeeaso3737975pjf.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 19:49:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ldi2U40YmyGQGFrPZn7nwdcUJyVB/9RWMPw4Sy7z5Hk=;
        b=5uE/wiMatiNrcNV5imHEPZdqm+/bX+AN3ribA6xHRH0MZmCBdiRjwaz9e9Sv3t3NkQ
         Kale6zY1V/O/2uf7oBtmd2KzKMV/mAbBvMJo+DR3nFvyKprs8P/Dv7F6uFkRDaSdqO5P
         soqbaYda95hsNOY3nGa6f/ye+1Px269JEONyIuxvrP8p+Bt+ADUuUOhyAEi8G2Quqnjp
         7JfeqU2CSdAZ28D12ZOWWKFwbrPjZaXHKaJqE3th39l1sFNVcXKxFXYR/115iuFkVKi4
         wXGF07HcGcrbIATD1oKy4pGAGYYqDkIYR7uldVa5z2111H7Vy1njfFfliMXDGlheB9eb
         y5VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ldi2U40YmyGQGFrPZn7nwdcUJyVB/9RWMPw4Sy7z5Hk=;
        b=aO5CJpkw1T9M37uYVE3YCNiWgB7quBLQ6qU0EZigrMpQq0s12nqwyBL6QRUFraOUnv
         CItt28iHm4WJ2BJR/CkwyeKK6O4sJNC1lMkp7/JiYxVFE//asfZOctmDmLSiyqGtUkzD
         3ri3Zhj9TGb2OK5/RfP+ONavL3rFEC+D1jFXc0/kwtVrlcn+uyeferHwPJgg+M59q87k
         RevjWCGIU3yfUbSNusB97Qj++D3tgPfpi98dWolN59gRk85R29OeGKa8oKF03u2HQpg6
         MsrJ/SpsAIHVDdLrmdngGPGUTPhWgGChPB7+Zm2qjzoKFGGb02IlNHaPUr0HKOYKSHl+
         03/A==
X-Gm-Message-State: AFqh2koIi9f+PqR9Zi/J2lPc+jfKhBjF80PSBqZt1w2VCK2DAtzy+nGM
        xFRFSm2Df7Rh1JDs26Vx836LMnDgCuOirAqI
X-Google-Smtp-Source: AMrXdXuu9dbAuuk02S9yjlKn8cUqCFqf3A4dYLim38trFwCeTDTFdTiGyFT0jPoq6pCjJY3ozGNrfg==
X-Received: by 2002:a17:903:32c2:b0:195:e437:ba2 with SMTP id i2-20020a17090332c200b00195e4370ba2mr201452plr.6.1674186572137;
        Thu, 19 Jan 2023 19:49:32 -0800 (PST)
Received: from ?IPV6:2620:10d:c085:21c8::1739? ([2620:10d:c090:400::5:ccda])
        by smtp.gmail.com with ESMTPSA id s32-20020a635260000000b004b1fef0bf16sm19139516pgl.73.2023.01.19.19.49.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jan 2023 19:49:31 -0800 (PST)
Message-ID: <c427d686-c850-4195-011b-93f51faa176d@kernel.dk>
Date:   Thu, 19 Jan 2023 20:49:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [ANNOUNCE] 5.10.162-rt78
Content-Language: en-US
To:     "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Cc:     Salvatore Bonaccorso <carnil@debian.org>,
        Pavel Machek <pavel@denx.de>,
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
 <a4f62523-b01e-3986-7914-767f999b4153@kernel.dk> <Y8oNTkUVDr7iQWzp@uudg.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Y8oNTkUVDr7iQWzp@uudg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/19/23 8:44?PM, Luis Claudio R. Goncalves wrote:
> On Thu, Jan 19, 2023 at 04:09:44PM -0700, Jens Axboe wrote:
>> On 1/19/23 2:03?PM, Salvatore Bonaccorso wrote:
>>> Hi Luis, all,
>>>
>>> On Thu, Jan 19, 2023 at 10:16:34AM -0300, Luis Claudio R. Goncalves wrote:
>>>> On Thu, Jan 19, 2023 at 12:38:25PM +0100, Pavel Machek wrote:
>>>>> Hi!
>>>>>
>>>>>>> I'm pleased to announce the 5.10.162-rt78 stable release.
>>>>>>>
>>>>>>> You can get this release via the git tree at:
>>>>>>>
>>>>>>>   git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git
>>>>>>>
>>>>>>>   branch: v5.10-rt
>>>>>>>   Head SHA1: 143ef105f40a65f3ddd57121d4b4bc36eb10cc06
>>>>>>>
>>>>>>> Or to build 5.10.162-rt78 directly, the following patches should be applied:
>>>>>
>>>>>> I see that vanilla 5.10.162-rt78 fails to build with arm64 defconfig. [0] Full log [1]
>>>>>> Any pointers on what maybe wrong?
>>>>>
>>>>> We see the same failure. 
>>>>>
>>>>>>   AS      arch/arm64/kernel/entry.o
>>>>>> arch/arm64/kernel/entry.S: Assembler messages:
>>>>>> arch/arm64/kernel/entry.S:763: Error: immediate out of range at operand 3 -- `and x2,x19,#((1<<1)|(1<<0)|(1<<2)|(1<<3)|(1<<4)|(1<<5)|(1<<6)|(1<<13)|(1<<7))'
>>>>>> make[2]: *** [scripts/Makefile.build:367: arch/arm64/kernel/entry.o] Error 1
>>>>>> make[1]: *** [scripts/Makefile.build:503: arch/arm64/kernel] Error 2
>>>>>> make: *** [Makefile:1837: arch/arm64] Error 2
>>>>>
>>>>> The line is:
>>>>>
>>>>>>        and     x2, x19, #_TIF_WORK_MASK
>>>>
>>>> I believe this is related to the arch/arm64/include/asm/thread_info.h
>>>> changes in 5.10.162-rt78, specifically:
>>>>
>>>>     79a9991e87fe arm64: add support for TIF_NOTIFY_SIGNAL
>>>>     1ba44dcf789d Merge tag 'v5.10.162' into v5.10-rt
>>>>
>>>> The first one is the original change, coming from stable v5.10.162 and the
>>>> second one has the merge conflict I fixed in that file due to the existence
>>>> of TIF_NEED_RESCHED_LAZY in PREEMPT_RT.
>>>>
>>>> It escaped me that having TIF_NEED_RESCHED_LAZY set to 13 breaks the AND
>>>> statement reported above. Looking at
>>>>
>>>>     b5a5a01d8e9a arm64: uaccess: remove addr_limit_user_check()
>>>>
>>>> specially this note
>>>>
>>>>     To ensure that _TIF_WORK_MASK can be used as an immediate value in an
>>>>     AND instruction (as it is in `ret_to_user`), TIF_MTE_ASYNC_FAULT is
>>>>     renumbered to keep the constituent bits of _TIF_WORK_MASK contiguous.
>>>>
>>>> I understand that I need to either have to renumber TIF_NEED_RESCHED_LAZY
>>>> to 8, with the risk of breaking something else, or backport commit
>>>> b5a5a01d8e9a in order to remove TIF_FSCHECK and then safely renumber
>>>> TIF_NEED_RESCHED_LAZY.
>>>>
>>>> Guidance is welcome here :)
>>>
>>> Should we loop in here Jens, as having some overview of the needed
>>> changes for io_uring rebase in the 5.10.y version? (doing so in the
>>> mail).
>>
>> Huh that's funky, I built and (runtime) tested this on arm64
>> specifically. But I do remember some details about the first 8 bits on
>> arm, but not arm64.
>>
>> I guess we need to twiddle that asm to deal with eg 16 bits, rather than
>> attempt to backport any TIF removal patches.
> 
> One simple solution, tested with defconfig plus FTRACE options (including
> FTRACE_SYSCALLS) enabled, is:
> 
> diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
> index 6eb36a2126e8..37f19bb49d38 100644
> --- a/arch/arm64/include/asm/thread_info.h
> +++ b/arch/arm64/include/asm/thread_info.h
> @@ -70,12 +70,12 @@ void arch_release_task_struct(struct task_struct *tsk);
>  #define TIF_FSCHECK		5	/* Check FS is USER_DS on return */
>  #define TIF_MTE_ASYNC_FAULT	6	/* MTE Asynchronous Tag Check Fault */
>  #define TIF_NOTIFY_SIGNAL	7	/* signal notifications exist */
> -#define TIF_SYSCALL_TRACE	8	/* syscall trace active */
> +#define TIF_NEED_RESCHED_LAZY	8
>  #define TIF_SYSCALL_AUDIT	9	/* syscall auditing */
>  #define TIF_SYSCALL_TRACEPOINT	10	/* syscall tracepoint for ftrace */
>  #define TIF_SECCOMP		11	/* syscall secure computing */
>  #define TIF_SYSCALL_EMU		12	/* syscall emulation active */
> -#define TIF_NEED_RESCHED_LAZY	13
> +#define TIF_SYSCALL_TRACE	13	/* syscall trace active */
>  #define TIF_MEMDIE		18	/* is terminating due to OOM killer */
>  #define TIF_FREEZE		19
>  #define TIF_RESTORE_SIGMASK	20
> 
> Would that be acceptable? With that we ensure the bits in
> _TIF_WORK_MASK are contiguous and within the 8 bits limit you
> mentioned. And TIF_SYSCALL_TRACE did not seem to have any (build)
> problem with the new value.

That should work too, the _TIF_WORK_MASK bits being in the lower 8 bits
is really all we should care about.

I do wonder why I didn't see this in testing - the kernel build bot was
also happy with it... But anyway, should be an easy fix.

-- 
Jens Axboe

