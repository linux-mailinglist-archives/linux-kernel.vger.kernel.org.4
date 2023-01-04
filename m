Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39B5665D675
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 15:46:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239479AbjADOqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 09:46:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239561AbjADOpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 09:45:55 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C797538AF5
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 06:45:45 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id u8so11967152ilg.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 06:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DqTOlQRjnAaEt30xylNxo3kPbBW18INY28tREbirW3Y=;
        b=UEIjiFTz2NypXUFB+hTUr5Qj/pk2LOIC0yqJGyflv/Kr8lml0PcGyz4yYN5Wg9k/U2
         yrFAUxks57/tep+4ZGZiRdoc4PuqGcK86A/j92LNTBTTPssIyZWD9BX1wpbpWeTZzbcu
         tWiayaFmTiFeTvlI6Dn7jWmgpqtE/AUND064YnANcEuYWiRuo7iGNh+V00eSyJI8KcQt
         CKOPFVJztg0F/p8TGc7MGzmK1yz7Ns6kMAY8dSBz2dRdTzNyU27aILRjiOjVlDuj7Atm
         m3fQv2dgV8CMf9zSXDPFbNSSOFkpaHwEshwzDQSGKsFjWsu7RA9LMF1Ze0HumZcs1JNF
         97Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DqTOlQRjnAaEt30xylNxo3kPbBW18INY28tREbirW3Y=;
        b=TYk1Pc2CBWRM6ssN+aUyIyIpqgc9ojufJjzzPNGqpq2ff/oJNcnf8XkpnnXgY8tUy1
         Ox0cp6gMK2h6LfrrqVDj/yUCZQmLJ08czfU9xg9x1jotSEVjo2LutzdmrlaZqpFqpyjJ
         JlRA2mtBiWi1jRuHq1UOMENtqrJvMaixLAZg1G4cEmbKes70Kn9O9e0U4ELiTnezVDVZ
         s/qP2vWgBT+X4FIrjrgwef9VlDEJKiiKhOwWN1SILkLg/Phz5RVAVYJOhkwANMjHI8hI
         4ZUiHzxv81L4hMma/MSoF2nPSmLRN65qcAZ79j+nb7jOX57DmMLWfFHNqPW8Sr4FJocH
         tcgg==
X-Gm-Message-State: AFqh2kqCpjZ4R9/QjYMGBHTRWJu+2eU6fJ76fz7oCfdUmcCqtRXfw3o5
        NWCAtzk797Siuoq+4ve/ZwkeZ0HKH9fvFwjc
X-Google-Smtp-Source: AMrXdXtOamW2PnhiyvjtiFZN0yKQOEJAiPtLatySQ+r4iE1hzJysRjxPl9HM4W457uB4Mtj2DLJttQ==
X-Received: by 2002:a05:6e02:d0d:b0:303:d8:f309 with SMTP id g13-20020a056e020d0d00b0030300d8f309mr5973813ilj.2.1672843544919;
        Wed, 04 Jan 2023 06:45:44 -0800 (PST)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id o8-20020a056e0214c800b0030c048e60bbsm7932582ilk.34.2023.01.04.06.45.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Jan 2023 06:45:44 -0800 (PST)
Message-ID: <3e08caed-d3b4-4992-2e1d-1f87186aa6b8@kernel.dk>
Date:   Wed, 4 Jan 2023 07:45:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [bug-report] possible performance problem in ret_to_user_from_irq
Content-Language: en-US
To:     Hui Tang <tanghui20@huawei.com>,
        "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <7ecb8f3c-2aeb-a905-0d4a-aa768b9649b5@huawei.com>
 <Y7P+MjPNA6Tg8JBr@shell.armlinux.org.uk>
 <50a5ebdb-4107-26cc-a2f6-da551d99ff38@kernel.dk>
 <Y7Q88aBpxfWRqzTe@shell.armlinux.org.uk>
 <1ecb9b0c-1103-650a-e32a-93110466b2ae@kernel.dk>
 <36320fa5-83e7-daf8-0c8b-9ae8e9561258@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <36320fa5-83e7-daf8-0c8b-9ae8e9561258@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        T_SPF_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/4/23 12:04?AM, Hui Tang wrote:
> 
> 
> On 2023/1/3 22:59, Jens Axboe wrote:
>> On 1/3/23 7:34?AM, Russell King (Oracle) wrote:
>>> On Tue, Jan 03, 2023 at 07:25:26AM -0700, Jens Axboe wrote:
>>>> On 1/3/23 3:06?AM, Russell King (Oracle) wrote:
>>>>> On Mon, Dec 26, 2022 at 04:45:20PM +0800, Hui Tang wrote:
>>>>>> hi folks.
>>>>>>
>>>>>> I found a performance problem which is introduced by commit
>>>>>> 32d59773da38 ("arm: add support for TIF_NOTIFY_SIGNAL").
>>>>>> After the commit,  any bit in the range of 0..15 will cause
>>>>>> do_work_pending() to be invoked. More frequent do_work_pending()
>>>>>> invoked possible result in worse performance.
>>>>>>
>>>>>> Some of the tests I've done? as follows:
>>>>>> lmbench test            base        with patch
>>>>>> ./lat_ctx -P 1 -s 0  2        7.3167        11.04
>>>>>> ./lat_ctx -P 1 -s 16 2          8.0467        14.5367
>>>>>> ./lat_ctx -P 1 -s 64 2        7.8667        11.43
>>>>>> ./lat_ctx -P 1 -s 16 16        16.47        18.3667
>>>>>> ./lat_pipe -P 1            28.1671        44.7904
>>>>>>
>>>>>> libMicro-0.4.1 test        base        with patch
>>>>>> ./cascade_cond -E -C 200\
>>>>>>  -L -S -W -N "c_cond_1" -I 100    286.3333    358
>>>>>>
>>>>>> When I adjust test bit, the performance problem gone.
>>>>>> -    movs    r1, r1, lsl #16
>>>>>> +    ldr    r2, =#_TIF_WORK_MASK
>>>>>> +    tst    r1, r2
>>>>>>
>>>>>> Does anyone have a good suggestion for this problem?
>>>>>> should just test _TIF_WORK_MASK, as before?
>>>>>
>>>>> I think it should be fine - but I would suggest re-organising the
>>>>> TIF definitions so that those TIF bits that shouldn't trigger
>>>>> do_work_pending are not in the first 16 bits.
>>>>>
>>>>> Note that all four bits in _TIF_SYSCALL_WORK need to stay within
>>>>> an 8-bit even-bit-aligned range, so the value is suitable for an
>>>>> immediate assembly constant.
>>>>>
>>>>> I'd suggest moving the TIF definitions for 20 to 19, and 4..7 to
>>>>> 20..23, and then 8 to 4.
>>>>
>>>> Like this?
>>>>
>>>> diff --git a/arch/arm/include/asm/thread_info.h b/arch/arm/include/asm/thread_info.h
>>>> index aecc403b2880..7f092cb55a41 100644
>>>> --- a/arch/arm/include/asm/thread_info.h
>>>> +++ b/arch/arm/include/asm/thread_info.h
>>>> @@ -128,15 +128,16 @@ extern int vfp_restore_user_hwstate(struct user_vfp *,
>>>>  #define TIF_NEED_RESCHED    1    /* rescheduling necessary */
>>>>  #define TIF_NOTIFY_RESUME    2    /* callback before returning to user */
>>>>  #define TIF_UPROBE        3    /* breakpointed or singlestepping */
>>>> -#define TIF_SYSCALL_TRACE    4    /* syscall trace active */
>>>> -#define TIF_SYSCALL_AUDIT    5    /* syscall auditing active */
>>>> -#define TIF_SYSCALL_TRACEPOINT    6    /* syscall tracepoint instrumentation */
>>>> -#define TIF_SECCOMP        7    /* seccomp syscall filtering active */
>>>> -#define TIF_NOTIFY_SIGNAL    8    /* signal notifications exist */
>>>> +#define TIF_NOTIFY_SIGNAL    4    /* signal notifications exist */
>>>>
>>>>  #define TIF_USING_IWMMXT    17
>>>>  #define TIF_MEMDIE        18    /* is terminating due to OOM killer */
>>>> -#define TIF_RESTORE_SIGMASK    20
>>>> +#define TIF_RESTORE_SIGMASK    19
>>>> +#define TIF_SYSCALL_TRACE    20    /* syscall trace active */
>>>> +#define TIF_SYSCALL_AUDIT    21    /* syscall auditing active */
>>>> +#define TIF_SYSCALL_TRACEPOINT    22    /* syscall tracepoint instrumentation */
>>>> +#define TIF_SECCOMP        23    /* seccomp syscall filtering active */
>>>> +
>>>>
>>>>  #define _TIF_SIGPENDING        (1 << TIF_SIGPENDING)
>>>>  #define _TIF_NEED_RESCHED    (1 << TIF_NEED_RESCHED)
>>>
>>> Yep, LGTM, thanks.
>>
>> Hui Tang, can you give it a whirl? Just checked and it applies to
>> 5.10-stable as well, just with a slight offset.
> 
> With the latest patch, the testcase rusults shown in the 'new patch' column.
> I also retested previous commit of 32d59773da38, the results shown in the 'base' column.
> 
> lmbench test                base        32d59773da38      new patch
> ./lat_ctx -P 1 -s 0  2      8.04          11.04        8.25
> ./lat_ctx -P 1 -s 16 2      9.08          14.5367         9.26
> ./lat_ctx -P 1 -s 64 2      8.78          11.43        8.71
> ./lat_ctx -P 1 -s 16 16     17.22         18.3667         17.32
> ./lat_pipe -P 1             43.5021       44.7904         41.3729
> 
> libMicro-0.4.1 test              base  32d59773da38    new patch
> ./cascade_cond -E -C 200\
>  -L -S -W -N "c_cond_1" -I 100    281    358          281
> 
> The performance problem also seem to gone with the latest patch, thanks.

Thanks for testing! I'm going to send it out and add your tested-by (and
reported-by).

-- 
Jens Axboe

