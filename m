Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD40163BA02
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 07:55:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbiK2Gze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 01:55:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiK2Gzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 01:55:31 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D8A27CFC
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 22:55:30 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 6F8C93200392;
        Tue, 29 Nov 2022 01:55:26 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 29 Nov 2022 01:55:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1669704925; x=
        1669791325; bh=fn3AVBEvA2mYWNxyxWEfooyD0pfzwmNsEuuAT5x/W5Y=; b=K
        fbYdRmAe8bgttsueFJIxOy0h7u+kewm7R/N8vi5oAu4nKwYP+h3uo6L+LcHIt374
        mqNC0oFHfgZaSpe45fcYnLFp8Yu4fl00Q2XVxXq1pjPE3WPIpiNpQKLpK21NsQLY
        XVtl75tKnBs0mLjRsWWsAOc8ov5i59miWNfyK3DcJyeP6wIy7i9/5YJz+IwOzuq8
        c/YlCKx+jHf6jOAi3b8MG0pCVFOtLc/x3JJkGJVr7v+bokirc4qABv/zvq7vsmQL
        9F3xAA8dsREHK9iTIQHf80YPccKb3yf6q9HMPTHlJoircjMXpmZyPWx8ZjnQwiy5
        jYumPsQZ0nGPuufF1iL3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1669704925; x=
        1669791325; bh=fn3AVBEvA2mYWNxyxWEfooyD0pfzwmNsEuuAT5x/W5Y=; b=O
        p7f+J+F/9FjdznWIgDsy31xNmvek33rw+W0Bx1vQDyvyniN1EP5+jLJ1NpuYlchs
        dSyB3RwB55xO2Olv12dYkHCgAnny/f6YahVfjj71n+kzhFNFCWal7ZM6pUeUiDkb
        rWg0OwdZxoaPQeUN8f4URK9ytPCzsRDTvMaUCErYlYapDdTrBe8k1nJVA3ZgfFxk
        9YIbpw37x2OIZJ2mGB9+S9vo6+f5+nQUoLQ/QK2Yhti2Ey2W5M+hVu7fsdY7Xrtf
        xnBXf5/HeoAfCc8A3ENtpv1JIuBzb7dq4Kpx5kk8/mZ1aaNFFvpdvpudo5kjnnjQ
        NPshkCP+k3gHtSF3XZffg==
X-ME-Sender: <xms:3ayFY9S9060OQYlUnn6qoFeG_E2e0kpjsSHYY0TbceR_xhs3gQduCg>
    <xme:3ayFY2xnGl9lnr_LcQm_7egJsqqrasUIL7FxZ2rFlRGXWpUjVSmq56cNYu30oe-jS
    F2gVcXcwy3vZHD-fg>
X-ME-Received: <xmr:3ayFYy1pGS4Xehk8XiGWPGIGJufpki3XRrQ7pcvR7ksnaQ_JyLnFP4g-17sIyc8hPn0l9JcEXS2UBCsttpAr-9_bLibvHkyf9DbFbNItSEqmehed0B2U1-aeMw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrjeefgddutdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfvfevfhfhufgjtgfgsehtkeertddtfeejnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpefhtdehieejhffhkeelveeggfelueekudetfeehkedtjeekhedu
    udffheejjefffeenucffohhmrghinhephhgvrggurdhssgdpkhgvrhhnvghlrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhu
    vghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:3ayFY1Cir7U03-fZA3oAYlPaS2_Mq1P1o8cHrjCtywFhgiBRDWs3Mw>
    <xmx:3ayFY2jAn2VuforYQ_9y8tAz8IH6TEbeURh-IoQhaP8eq-SZFi2w6g>
    <xmx:3ayFY5r4qNxlcsUFNUgHAP-gDIIF_oMlex4fhaKS4JhKL2mwDkWCiQ>
    <xmx:3ayFY4aClnXt9ZiJtyzuAFvCyZRPKyA40xXBKRioLnTj3MwfJflptQ>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Nov 2022 01:55:25 -0500 (EST)
Message-ID: <d79d85c2-8457-9b0e-6460-089cf91dd425@sholland.org>
Date:   Tue, 29 Nov 2022 00:55:24 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux ppc64le; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Content-Language: en-US
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Atish Patra <atishp@rivosinc.com>, jszhang@kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <mhng-028a3e75-6cd0-4775-ac68-3e0eb70c91ae@palmer-ri-x1c9>
From:   Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH] riscv: head: use 0 as the default text_offset
In-Reply-To: <mhng-028a3e75-6cd0-4775-ac68-3e0eb70c91ae@palmer-ri-x1c9>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29/22 00:19, Palmer Dabbelt wrote:
> On Mon, 28 Nov 2022 21:04:48 PST (-0800), samuel@sholland.org wrote:
>> On 11/28/22 14:11, Atish Kumar Patra wrote:
>>> On Mon, Nov 28, 2022 at 7:34 AM Jisheng Zhang <jszhang@kernel.org>
>>> wrote:
>>>>
>>>> Commit 0f327f2aaad6 ("RISC-V: Add an Image header that boot loader can
>>>> parse.") adds an image header which "is based on ARM64 boot image
>>>> header and provides an opportunity to combine both ARM64 & RISC-V
>>>> image headers in future.". At that time, arm64's default text_offset
>>>> is 0x80000, this is to give "512 KB of guaranteed BSS space to put
>>>> the swapper page tables" as commit cfa7ede20f13 ("arm64: set
>>>> TEXT_OFFSET
>>>> to 0x0 in preparation for removing it entirely") pointed out, but
>>>> riscv doesn't need the space, so use 0 as the default text_offset.
>>>>
>>>> Before this patch, booting linux kernel on Sipeed bl808 M1s Dock
>>>> with u-boot booti cmd:
>>>> [    0.000000] OF: fdt: Ignoring memory range 0x50000000 - 0x50200000
>>>> ...
>>>> [    0.000000]   DMA32    [mem 0x0000000050200000-0x0000000053ffffff]
>>>> As can be seen, 2MB DDR(0x50000000 - 0x501fffff) can't be used by
>>>> linux.
>>>>
>>>> After this patch, the 64MB DDR is fully usable by linux
>>>> [    0.000000]   DMA32    [mem 0x0000000050000000-0x0000000053ffffff]
>>>>
>>>> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
>>>> ---
>>>>  arch/riscv/kernel/head.S | 12 +-----------
>>>>  1 file changed, 1 insertion(+), 11 deletions(-)
>>>>
>>>> diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
>>>> index b865046e4dbb..ef95943f7a70 100644
>>>> --- a/arch/riscv/kernel/head.S
>>>> +++ b/arch/riscv/kernel/head.S
>>>> @@ -38,18 +38,8 @@ ENTRY(_start)
>>>>         .word 0
>>>>  #endif
>>>>         .balign 8
>>>> -#ifdef CONFIG_RISCV_M_MODE
>>>> -       /* Image load offset (0MB) from start of RAM for M-mode */
>>>> +       /* Image load offset (0MB) from start of RAM */
>>>>         .dword 0
>>>> -#else
>>>> -#if __riscv_xlen == 64
>>>> -       /* Image load offset(2MB) from start of RAM */
>>>> -       .dword 0x200000
>>>> -#else
>>>> -       /* Image load offset(4MB) from start of RAM */
>>>> -       .dword 0x400000
>>>> -#endif
>>>> -#endif
>>>
>>> NACK.
>>> RV64 needs to boot at a 2MB aligned address and RV32 needs to boot at
>>> a 4MB aligned address.
>>> The firmware is assumed to live at the start of DRAM for Linux running
>>> in S-mode.
>>
>> What needs to happen so we can stop making this assumption? If the SBI
>> implementation wants to reserve memory, it should use the devicetree to
>> do so. OpenSBI already does this.
> 
> IMO we've really screwed up the boot flow on RISC-V.  Having Linux
> reserve space for the firmware is just all backwards, Linux can't know
> how much memory the firmware needs (which manifests under large hart
> counts in OpenSBI, for example).  Unfortunately there's no specification
> that defines these platform-level details, so we're stuck depending on 
> unspecified behavior like this.
> 
> I think we could fix this by either making Linux's early boot relocation
> code work sanely (fix whatever bugs are there, document what can't be
> fixed, and then add some sort of Image flag to tell firmware the kernel
> can be relocated) or relying on relocatable firmware, but both of those
> come with some costs ...

It sounds like Alexandre's patch[1] lets us use memory below this
offset, so we don't have to relocate the kernel to the beginning of RAM.
In fact, we could even increase the offset if we are concerned about the
kernel link address conflicting with the SBI implementation.

[1]:
https://patchwork.kernel.org/project/linux-riscv/patch/20221122084141.1849421-1-alexghiti@rivosinc.com/

>> Throwing away 2 MiB of RAM is quite wasteful considering we have
>> multiple SoCs (D1s, BL808) that are limited to 64 MiB of in-package RAM.
> 
> ... and I'd argue that users on systems don't want to pay those costs. 

What does fixing the early relocation code cost? Just longer boot time?
If the bootloader takes care of avoiding reserved-memory regions, and
Linux can run from wherever it gets loaded, that would be ideal to me.

> In fact, I'd argue that systems like that don't want resident firmware
> at all.

I would much rather pay 256 KiB for resident firmware than reimplement
all of the power management and PMU logic in Linux. It's not as bad as
losing 2 MiB when I know most of that is unused.

> So let's just add a CONFIG_SBI=n, and then just use direct drivers for
> everything.  If the firmware doesn't need to be resident then it's
> pretty straight-forward to support these 0 offsets, so we can just add
> that as another Kconfig.  Sure this will trip up firmware that depends
> on these fixed reservations, but saying "the resident firmware fits in 0
> superpages" is just as much of a platform-specific dependency as saying
> "the resident firmware fits in 1 superpage".  If firmware can't handle
> this field in the Image format then we're going to end up with breakages
> at some point, it might as well be now.
>
> If these systems don't have all the ISA bits necessary to avoid M-mode
> entirely then we can just implement a tiny M-mode stub in Linux that
> gets left around during early boot and then shims stuff to S-mode. 
> That'll be a bit of a headache and with some extensions it can be
> avoided, the standard stuff won't allow for that until the latest round
> of specs is done but if it's possible via whatever custom extensions are
> in these things then that's probably the way to go.

I don't think Linux has a choice here, when started in S-mode. And
neither does the bootloader parsing the Image, because it most likely
runs in S-mode as well.

And when started in M-mode, we already don't use SBI.

Regards,
Samuel

