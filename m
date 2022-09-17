Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 885885BB9F2
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 20:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbiIQSiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 14:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiIQSiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 14:38:10 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2F42CE06
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 11:38:09 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 181F43200A19;
        Sat, 17 Sep 2022 14:38:05 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sat, 17 Sep 2022 14:38:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1663439885; x=
        1663526285; bh=jHHLXpWPtd6zlE9ADGiuOsDT6ny/BGJfLNQ5Ar/S0Ug=; b=m
        F4888kZcFaMWN2coxV2NEX+LfS/DstXM457voerhN9UVqFGfuArfSkquG8oB45a0
        URCY88XoBHjiXv+tWp9eOTHAC/i3lLiYa2CAJo/GP8Abhqh9eDiUi09bDuixBF/9
        sPccxbOFoqNR3bXMc4HWQKR8AEXPP+xIc85KAADEh7xtVym9jN98GdwOlk2IFWr+
        ZbMUzc1Qeh6sqWaWkmrRAu+aJuAydm1WMD1/0gCkOmy3Qfc+kCSVX/w0doCu+1Jn
        ldEtY8gTSIW3Rw1MA1R0lC3sCEm0xIGVMoxa1AyOUIhM3fVlZlOSu6sWNy/A35te
        eI3BZGrn1INt8G6UV7QSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1663439885; x=
        1663526285; bh=jHHLXpWPtd6zlE9ADGiuOsDT6ny/BGJfLNQ5Ar/S0Ug=; b=k
        qMOQmebyncMIvKhK0Q78RlPwuId6hcXn6Hhu5ySsot2AZcYsTk+XD8TKpizA3H44
        GEHTm7CK2OhJSZA94M+LJC8KchiQAVQc3hYyGMBn+YbIKL+INQZCyJ2BdJy2xWdm
        4kNSNkhmEOxhaaSZmf4+lxeqX2lc82K8Z7l5hmLrtcA01A+8kG2G+tRECok5GjDR
        WReXl67mzLWiK9c9xwU+47Z90YoeNkQ0+AULmmjvXiHLhuDjdUlqyYHoo+HoDKPC
        To0zdTRIzTSHQundtQJNk7l3kvfgjva6hYMddftjUjow3hC/qEJnunZTRJAnY51k
        QizmC6hO+n80U83/A1Mww==
X-ME-Sender: <xms:DBQmY1P7jnLypib1ofmkRo4BIxz4tdD4Qvy4bgsMMqTrzXns19JWUQ>
    <xme:DBQmY3-wJy_noARqfUsFGwHxxEBfJCpZu5OT_Dr4HyQKxDGh-iC45EUn8JdBRPypg
    Q1OKxBOll9oui0xgw>
X-ME-Received: <xmr:DBQmY0SY7Iq1dZyivlcRzdNWwT-nH8NzJuBss2HN-oX9_N9ujRmnWp5JiP6KFPQDkf7qF5tdAbv9lF4Xi4sUPvzzYz0uTjbmVrbmSieWns615H6NQAWHKvNXjg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfedvvddgudeftdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefkffggfgfvvehfhffujggtgfesthekredttdefjeenucfhrhhomhepufgr
    mhhuvghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqne
    cuggftrfgrthhtvghrnhepgeeikeeufedvvdeuteeivdeiffdtgfdtfeejgfetfeefgeff
    gfdvffehjedvueeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:DBQmYxtZHVPA_SPjoe6Z5Ag5MwjZHjjaouBtc4eM3NY5oKqk-bO5Qw>
    <xmx:DBQmY9f2tIxbrXTTFFQ7M4KMJ6wkcJfrqqqH-nm3YM_Y-6CFJ40DdQ>
    <xmx:DBQmY93f7P_wn6xfFmm2nbrWZo6qnaKrLMyIlG3pTlo8FKaX8juWRQ>
    <xmx:DRQmY1TbTeFz6w3euZsHjRQ2liLAzelc2S0ZhQAaZA5XRbmQoPF5qg>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 17 Sep 2022 14:38:04 -0400 (EDT)
Message-ID: <aebab2f0-a962-68ed-b655-84a3e87f2c7d@sholland.org>
Date:   Sat, 17 Sep 2022 13:38:03 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux ppc64le; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Content-Language: en-US
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Russell Currey <ruscur@russell.cc>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
References: <20220916050515.48842-1-samuel@sholland.org>
 <89049105-64fc-8d5b-d090-2841064786d1@csgroup.eu>
From:   Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH] powerpc: Save AMR/IAMR when switching tasks
In-Reply-To: <89049105-64fc-8d5b-d090-2841064786d1@csgroup.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/17/22 03:16, Christophe Leroy wrote:
> Le 16/09/2022 à 07:05, Samuel Holland a écrit :
>> With CONFIG_PREEMPT=y (involuntary preemption enabled), it is possible
>> to switch away from a task inside copy_{from,to}_user. This left the CPU
>> with userspace access enabled until after the next IRQ or privilege
>> level switch, when AMR/IAMR got reset to AMR_KU[AE]P_BLOCKED. Then, when
>> switching back to the original task, the userspace access would fault:
> 
> This is not supposed to happen. You never switch away from a task 
> magically. Task switch will always happen in an interrupt, that means 
> copy_{from,to}_user() get interrupted.

That makes sense, the interrupt handler is responsible for saving the
KUAP status. It looks like neither DEFINE_INTERRUPT_HANDLER_RAW nor any
of its users (performance_monitor_exception(), do_slb_fault()) do that.
Yet they still call one of the interrupt_return variants, which restores
the status from the stack.

> Whenever an interrupt is taken, kuap_save_amr_and_lock() macro is used 
> to save KUAP status into the stack then lock KUAP access. At interrupt 
> exit, kuap_kernel_restore() macro or function is used to restore KUAP 
> access from the stack. At the time the task switch happens, KUAP access 
> is expected to be locked. During task switch, the stack is switched so 
> the KUAP status is taken back from the new task's stack.

What if another task calls schedule() from kernel process context, and
the scheduler switches to a task that had been preempted inside
copy_{from,to}_user()? Then there is no interrupt involved, and I don't
see where kuap_kernel_restore() would get called.

> Your fix suggests that there is some path where the KUAP status is not 
> properly saved and/or restored. Did you try running with 
> CONFIG_PPC_KUAP_DEBUG ? It should warn whenever a KUAP access is left 
> unlocked.
> 
>>
>>    Kernel attempted to write user page (3fff7ab68190) - exploit attempt? (uid: 65536)
>>    ------------[ cut here ]------------
>>    Bug: Write fault blocked by KUAP!
>>    WARNING: CPU: 56 PID: 4939 at arch/powerpc/mm/fault.c:228 ___do_page_fault+0x7b4/0xaa0
>>    CPU: 56 PID: 4939 Comm: git Tainted: G        W         5.19.8-00005-gba424747260d #1
>>    NIP:  c0000000000555e4 LR: c0000000000555e0 CTR: c00000000079d9d0
>>    REGS: c00000008f507370 TRAP: 0700   Tainted: G        W          (5.19.8-00005-gba424747260d)
>>    MSR:  9000000000021033 <SF,HV,ME,IR,DR,RI,LE>  CR: 28042222  XER: 20040000
>>    CFAR: c000000000123780 IRQMASK: 3
>>    NIP [c0000000000555e4] ___do_page_fault+0x7b4/0xaa0
>>    LR [c0000000000555e0] ___do_page_fault+0x7b0/0xaa0
>>    Call Trace:
>>    [c00000008f507610] [c0000000000555e0] ___do_page_fault+0x7b0/0xaa0 (unreliable)
>>    [c00000008f5076c0] [c000000000055938] do_page_fault+0x68/0x130
>>    [c00000008f5076f0] [c000000000008914] data_access_common_virt+0x194/0x1f0
>>    --- interrupt: 300 at __copy_tofrom_user_base+0x9c/0x5a4
> 
> ...
> 
>>
>> Fix this by saving and restoring the kernel-side AMR/IAMR values when
>> switching tasks.
> 
> As explained above, KUAP access should be locked at that time, so saving 
> and restoring it should not have any effect. If it does, it means 
> something goes wrong somewhere else.
> 
>>
>> Fixes: 890274c2dc4c ("powerpc/64s: Implement KUAP for Radix MMU")
>> Signed-off-by: Samuel Holland <samuel@sholland.org>
>> ---
>> I have no idea if this is the right change to make, and it could be
>> optimized, but my system has been stable with this patch for 5 days now.
>>
>> Without the patch, I hit the bug every few minutes when my load average
>> is <1, and I hit it immediately if I try to do a parallel kernel build.
> 
> Great, then can you make a try with CONFIG_PPC_KUAP_DEBUG ?

Yes, I will try this out in the next few days.

Regards,
Samuel

