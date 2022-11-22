Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF5FF63318B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 01:47:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbiKVArG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 19:47:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231899AbiKVApa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 19:45:30 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1766A13F2F;
        Mon, 21 Nov 2022 16:45:29 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id C2AE032009D7;
        Mon, 21 Nov 2022 19:45:27 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 21 Nov 2022 19:45:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1669077927; x=
        1669164327; bh=fDo4wIRpT/cr00JSFZyRJXJl6OzORncK/vIgc7ZRQkk=; b=J
        6CnMjqONXI2E8ioFDyVdFNnyvY9ueuRBNt/1e26aLfKYAlgFhVS2hel8L1xo8We4
        NTYSTpdzySKpFbIhsX4pkj8++3yIFa1rLeE5J3mz0FM4zKmk7yQNSbGolsbMFq5r
        M8mXmPB9g4HGNKO1FdbHFuHpvPJbEkd++eT++A2EQxdsIR/uc+7Qzvd20inmEnJs
        2mPE3SKyf4UX8km4FaZG+ZcQZtF2Tlfc3/EK721qDYW+mIgWsTnoe9sJQrrEjLm4
        af7LtAi+BSe9MStIZi77K8M41RGKWjO8FKWj4AR0jhOm0n55EwepzYPq1lHHEDrE
        8hShbPP0pCwmsedUWfJvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1669077927; x=
        1669164327; bh=fDo4wIRpT/cr00JSFZyRJXJl6OzORncK/vIgc7ZRQkk=; b=V
        nJZxtfGEVMrF6eg8Ky2o+OwLEwr0qWH4WDtXfKZW4ubG0wPZhoUTcUtV/aF7stxL
        5R531aiFniq99980T+GAVs9G7ZaEHCJYi6IGjvjG0sMDCvJJu52oDmirdPXZNTss
        2yxe0hUdqK1pvbH78w/FwN3N8gB7ev+5uZGXQo0QNAcFZWeZC8bvcUCsfIzZIdOY
        f7TERsbeOhzNMG+BysOGxzQ029YLfXWGWf5TP2DvwPsHIw4BuWdlzHT2q0FAW4Gj
        gJhOmIBCd+zQHH/GVUhCF369+g60Ohdd9AC7TzYquTDwaXfmPDKLnkGcwugLlc7Q
        k3z8lJ7qxKAh6LoCc3aOA==
X-ME-Sender: <xms:pht8YyN3rNC6uJQ2Z3tbMqBvJReCw8urSh3znvc6odcyNAuEhCZzVg>
    <xme:pht8Yw9IskL-BeP9Cllr-RUzsAzpj5cMnVTiSE1rnIu05wRQtkBwbBW5vw3qzWMvd
    2N2Uvn3Zyo1xfKy6Q>
X-ME-Received: <xmr:pht8Y5SA2vkiZu8yuAFfA_h9yIiBZ18polg7Aya-z4cFMzkJwOn1mnYPmp-QBRqXUdE6YhIGUX9Xv1VcvyBUTHVHkpgMn3HT4VkgPacarLTIKUnZNcj1-nW1tQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrheejgddviecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfvvehfhffujggtgfesthejredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepudeuuefgleeludegueegvdeggffhveejgfeileejveegiefhffev
    ieffiedvkeehnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgr
    nhgurdhorhhg
X-ME-Proxy: <xmx:pht8Yysj4datzUUG5edxXJy2MuVRIzBoK2sHeXWKZttbNul8Qj4niw>
    <xmx:pht8Y6dfXLUOLPyz43Ob75QLXwnUyqWdhTq1F9D8JvtGxnO83rtwow>
    <xmx:pht8Y21gH7eBzGzthxlJ7A7Ps2F61GJc1hmGOMMa3qxvSUASe4NmVQ>
    <xmx:pxt8Y7UpRk1RyeyLvm3OglNzb_1tlIWhO1LTvdikdXxmkhbY5AVQqQ>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Nov 2022 19:45:26 -0500 (EST)
Message-ID: <bf6d3b1f-f703-4a25-833e-972a44a04114@sholland.org>
Date:   Mon, 21 Nov 2022 18:45:25 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux ppc64le; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Content-Language: en-US
To:     Palmer Dabbelt <palmer@rivosinc.com>,
        Conor Dooley <conor@kernel.org>
Cc:     anup@brainfault.org, rafael@kernel.org, daniel.lezcano@linaro.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        linux-pm@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux@rivosinc.com
References: <20221121205647.23343-1-palmer@rivosinc.com>
From:   Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH] cpuidle: riscv-sbi: Stop using non-retentive suspend
In-Reply-To: <20221121205647.23343-1-palmer@rivosinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Palmer,

On 11/21/22 14:56, Palmer Dabbelt wrote:
> From: Palmer Dabbelt <palmer@rivosinc.com>
> 
> As per [1], whether or not the core can wake up from non-retentive
> suspend is a platform-specific detail.  We don't have any way to encode
> that, so just stop using them until we've sorted that out.

We do have *exactly* a way to encode that. Specifically, the existence
or non-existence of a non-retentive CPU suspend state in the DT.

If a hart has no way of resuming from non-retentive suspend (i.e. a
complete lack of interrupt delivery in non-retentive suspend), then it
makes zero sense to advertise such a suspend state in the DT. Therefore,
if the state exists in the DT, you can assume there is *some* interrupt
that can wake up the hart. And I would extend that to assume at least
one of those wakeup-capable interrupts is a timer interrupt, although
not necessarily the architectural timer interrupt.

> Link: https://github.com/riscv-non-isa/riscv-sbi-doc/issues/98#issuecomment-1288564687

This comment refers specifically to the architectural timer interrupt,
not interrupts more generally.

> Fixes: 6abf32f1d9c5 ("cpuidle: Add RISC-V SBI CPU idle driver")
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> 
> ---
> 
> This should allow us to revert 232ccac1bd9b ("clocksource/drivers/riscv:
> Events are stopped during CPU suspend"), which fixes suspend on the D1
> but breaks timers everywhere.

I understand that reverting 232ccac1bd9b is the easiest way to fix the
issues you and others are seeing. I do not have any functioning RISC-V
hardware with SMP, so it is hard for me to help debug the root issue in
the Linux timer code. I do not know why turning on the C3STOP flag
breaks RCU stall detection or clock_nanosleep(), but I agree that
breakage should not happen.

So while I still think 232ccac1bd9b is the right change to make from a
"following the spec" standpoint, I am okay with reverting it for
pragmatic reasons. Since the D1 has another timer driver that is
currently used in preference to the RISC-V/SBI timer triver, reverting
232ccac1bd9b does not break non-retentive suspend for the D1.

But please do not make the change below. It is unnecessarily broad, and
will break something that works fine right now. If the DT advertises a
CPU suspend state that cannot be woken up from at all, then that is a
bug in the DT. Linux should not try to work around that.

So revert 232ccac1bd9b for now, and we can figure out what to do about
the DT property, but please do not merge this.

Regards,
Samuel

> ---
>  drivers/cpuidle/cpuidle-riscv-sbi.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/cpuidle/cpuidle-riscv-sbi.c b/drivers/cpuidle/cpuidle-riscv-sbi.c
> index 05fe2902df9a..9d1063a54495 100644
> --- a/drivers/cpuidle/cpuidle-riscv-sbi.c
> +++ b/drivers/cpuidle/cpuidle-riscv-sbi.c
> @@ -214,6 +214,17 @@ static bool sbi_suspend_state_is_valid(u32 state)
>  	if (state > SBI_HSM_SUSPEND_NON_RET_DEFAULT &&
>  	    state < SBI_HSM_SUSPEND_NON_RET_PLATFORM)
>  		return false;
> +
> +	/*
> +	 * Whether or not RISC-V systems deliver interrupts to harts in a
> +	 * non-retentive suspend state is a platform-specific detail.  This can
> +	 * leave the hart unable to wake up, so just mark these states as
> +	 * unsupported until we have a mechanism to expose these
> +	 * platform-specific details to Linux.
> +	 */
> +	if (state & SBI_HSM_SUSP_NON_RET_BIT)
> +		return false;
> +
>  	return true;
>  }
>  

