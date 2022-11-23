Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7209634E7A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 04:42:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235629AbiKWDmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 22:42:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235141AbiKWDmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 22:42:31 -0500
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C33ACE1;
        Tue, 22 Nov 2022 19:42:29 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id C93585C00C6;
        Tue, 22 Nov 2022 22:42:26 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 22 Nov 2022 22:42:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1669174946; x=
        1669261346; bh=WjpBSbkHlgZr/G9/b4e3LKpvH6PCl3lLDxsfAs74hmg=; b=Z
        eBgJmEvqpQW43y6yuK+731Q75LYU/YKMvMepiymAkpqmgBgMbkPco43zHg+zaiH0
        +xEjKL78jyKt3ea8CxpqDJ4bi27/1X03iqb+O3DHUbILYeZAATFgkTGtgfcjRU1v
        oAJfONUM/ftWpYLJt8v8AAmstl6xwGD6Qmdu0SKJ7wDRm+wsklrQFbbB5Jb0vwy/
        1H/ND+3DkAAorEnBKoPdj4JVV8qrCsQ+f+rUaEEiEBtlsKHJ8bf96SQyVX/0Q9Za
        6oBOmDTB7tSE/2UAu8wz3YO20fXWULyFyzxThKQLHrGvHs4StqbubPVHDOCstHgn
        3MYqd7RQGO4wmyy+QJTvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1669174946; x=
        1669261346; bh=WjpBSbkHlgZr/G9/b4e3LKpvH6PCl3lLDxsfAs74hmg=; b=A
        p+TSx97LLKyDd9xsxQ54ZcQDlcudCGB1pyvSl/8cwahIZWkF4N/lRnoWQDVZPXnw
        nSmnl62RqTLYg8k2LuTWs849lbxV2ioFkMXFjZiOLUdkWaU5VC4f+5Nn/0KeNCgJ
        LiC52WdK1efT+Y1V/r7fdyMr3ev4K0aqGdgp/CEuQvjXfROrMY6xch4uBgJmMV/q
        5ycVDFd9mZfRmFCli7KvwlwbMFb+NtWDh2cPUc1VByMhfM1wmLSi7i0gePU9Qo1X
        SMWrnW1v5c8ELv2078cFeMXQjRW9FnLm0cgtTACOk8uC9MAGn9g5ss7LNQb3EVDV
        rFpHDlZWYLitBYKejEOcQ==
X-ME-Sender: <xms:opZ9Yx5dngQZ-8CCWP80cBgQDBDqLfdWnbm-uGbCaWTxS_ORQ-AjlA>
    <xme:opZ9Y-61tGIwPckwHlwKAKlrpDkZ3Nvj5AmMr_ifWZdpn-s_ExxyGS_EmW0-Pl85G
    jgybbTu7CGgteRqnw>
X-ME-Received: <xmr:opZ9Y4eiLXWPXtOa4et-KZmBkSdGa06ZgbVr6Vj6aTmH3NH_knEmtfjIlHOzuxEYEYOjO_XFETZJNCWQsIpUbxLQZa2BL4TDG8cnT4Ly7BDth5dsh3-fyf9mgg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedriedtgdeivdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfvvehfhffujggtgfesthejredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepkeetudekfeehuedvhffgteeilefhhffghffgtdejieehjedvgfdv
    jefhvdethfdunecuffhomhgrihhnpehgihhthhhusgdrtghomhdpihhnfhhrrgguvggrug
    drohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:opZ9Y6Lpyg9HjOfw-o2m_b4pMKgIeJ2foRvdZz0p71NtOsgIsJGTuQ>
    <xmx:opZ9Y1LK6CAY2_c_3DTmSF5iXTz1hxTkgd-59sgZ33YgRjmw_z3X7g>
    <xmx:opZ9YzxtYklWJE1Rta7T-WKMUJBbg7f6IOMuvXhBv8JgiI4NfUOnUQ>
    <xmx:opZ9Y_xGnqRjb5K_nm0uSdGXli9FtaUrQA1d42P0JnWgm3vUFzvYTw>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Nov 2022 22:42:25 -0500 (EST)
Message-ID: <2309d3e5-0e37-c77b-1c0b-610abf0af62d@sholland.org>
Date:   Tue, 22 Nov 2022 21:42:24 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux ppc64le; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Content-Language: en-US
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        Conor Dooley <conor@kernel.org>, anup@brainfault.org,
        rafael@kernel.org, daniel.lezcano@linaro.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        linux-pm@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux@rivosinc.com
References: <20221121205647.23343-1-palmer@rivosinc.com>
 <bf6d3b1f-f703-4a25-833e-972a44a04114@sholland.org> <Y3ytSj6NEeU54z7m@wendy>
From:   Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH] cpuidle: riscv-sbi: Stop using non-retentive suspend
In-Reply-To: <Y3ytSj6NEeU54z7m@wendy>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor,

On 11/22/22 05:06, Conor Dooley wrote:
> Hey Samuel,
> 
> Thanks a lot for the extra context.
> 
> On Mon, Nov 21, 2022 at 06:45:25PM -0600, Samuel Holland wrote:
>> Hi Palmer,
>>
>> On 11/21/22 14:56, Palmer Dabbelt wrote:
>>> From: Palmer Dabbelt <palmer@rivosinc.com>
>>>
>>> As per [1], whether or not the core can wake up from non-retentive
>>> suspend is a platform-specific detail.  We don't have any way to encode
>>> that, so just stop using them until we've sorted that out.
>>
>> We do have *exactly* a way to encode that. Specifically, the existence
>> or non-existence of a non-retentive CPU suspend state in the DT.
>>
>> If a hart has no way of resuming from non-retentive suspend (i.e. a
>> complete lack of interrupt delivery in non-retentive suspend), then it
>> makes zero sense to advertise such a suspend state in the DT.
> 
> I would have to agree with that. I think the sprawling conversation has
> confused us all at this point, I (prior to reading this mail) thought
> that suspend was borked on the D1. I don't think anyone is advertising
> specific states in the DT at the moment though, I had a check in the D1
> patchset and didn't see anything there - unless you're adding it
> dynamically from the bootloader?

The availability and latency properties of idle states depend on the SBI
implementation, so yes, they need to be added dynamically.

>> Therefore,
>> if the state exists in the DT, you can assume there is *some* interrupt
>> that can wake up the hart. And I would extend that to assume at least
>> one of those wakeup-capable interrupts is a timer interrupt, although
>> not necessarily the architectural timer interrupt.
>>
>>> Link: https://github.com/riscv-non-isa/riscv-sbi-doc/issues/98#issuecomment-1288564687
>>
>> This comment refers specifically to the architectural timer interrupt,
>> not interrupts more generally.
>>
>>> Fixes: 6abf32f1d9c5 ("cpuidle: Add RISC-V SBI CPU idle driver")
>>> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
>>>
>>> ---
>>>
>>> This should allow us to revert 232ccac1bd9b ("clocksource/drivers/riscv:
>>> Events are stopped during CPU suspend"), which fixes suspend on the D1
>>> but breaks timers everywhere.
>>
>> I understand that reverting 232ccac1bd9b is the easiest way to fix the
>> issues you and others are seeing.
> 
> I am going to submit another respin of that revert, hopefully with the
> extra context from here and elsewhere mixed in.
> 
>> I do not have any functioning RISC-V
>> hardware with SMP, so it is hard for me to help debug the root issue in
>> the Linux timer code. I do not know why turning on the C3STOP flag
>> breaks RCU stall detection or clock_nanosleep(), but I agree that
>> breakage should not happen.
>>
>> So while I still think 232ccac1bd9b is the right change to make from a
>> "following the spec" standpoint
> 
> Right, so the spec says:
> Request the SBI implementation to put the calling hart in a platform
> specific suspend (or low power) state specified by the suspend_type
> parameter. The hart will automatically come out of suspended state and
> resume normal execution when it receives an interrupt or platform
> specific hardware event.
> 
> That, as we have discussed a bunch of times, does not say whether a
> given interrupt should actually arrive during suspend. The correct
> behaviour, to me, is to assume that no events arrive during suspend.

Are you suggesting that we need some property to declare the delivery of
each kind of interrupt (software, timer, external, PMU)? I assumed that
external interrupt delivery would be required to consider an idle state
"viable", but I suppose it would be _possible_ to have a state where
only timer interrupts are deliverable.

> We've got a regular old SiFive implementation so I assume (and will go
> investigate at some point this week) that the other SiFive {,based}
> implementations also have timer events during suspend.
> 
>> I am okay with reverting it for
>> pragmatic reasons. Since the D1 has another timer driver that is
>> currently used in preference to the RISC-V/SBI timer triver,
> 
> Once we have got something in place to actually make the determination
> we can revert the revert. I'll go give some feedback on Anup's stuff,
> I've been meaning to but unfortunately not had the chance to do so yet.

Thanks for following up on this.

Regards,
Samuel

>> reverting
>> 232ccac1bd9b does not break non-retentive suspend for the D1.
> 
> Ah, I did not know this. Probably should have gone looking before I
> acked this patch - sorry!
> Since that's the case this patch seems un-needed.
> 
>> But please do not make the change below. It is unnecessarily broad, and
>> will break something that works fine right now. If the DT advertises a
>> CPU suspend state that cannot be woken up from at all, then that is a
>> bug in the DT. Linux should not try to work around that.
> 
> Thanks again Samuel :)
> 
>>> ---
>>>  drivers/cpuidle/cpuidle-riscv-sbi.c | 11 +++++++++++
>>>  1 file changed, 11 insertions(+)
>>>
>>> diff --git a/drivers/cpuidle/cpuidle-riscv-sbi.c b/drivers/cpuidle/cpuidle-riscv-sbi.c
>>> index 05fe2902df9a..9d1063a54495 100644
>>> --- a/drivers/cpuidle/cpuidle-riscv-sbi.c
>>> +++ b/drivers/cpuidle/cpuidle-riscv-sbi.c
>>> @@ -214,6 +214,17 @@ static bool sbi_suspend_state_is_valid(u32 state)
>>>  	if (state > SBI_HSM_SUSPEND_NON_RET_DEFAULT &&
>>>  	    state < SBI_HSM_SUSPEND_NON_RET_PLATFORM)
>>>  		return false;
>>> +
>>> +	/*
>>> +	 * Whether or not RISC-V systems deliver interrupts to harts in a
>>> +	 * non-retentive suspend state is a platform-specific detail.  This can
>>> +	 * leave the hart unable to wake up, so just mark these states as
>>> +	 * unsupported until we have a mechanism to expose these
>>> +	 * platform-specific details to Linux.
>>> +	 */
>>> +	if (state & SBI_HSM_SUSP_NON_RET_BIT)
>>> +		return false;
>>> +
>>>  	return true;
>>>  }
>>>  
>>
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv

