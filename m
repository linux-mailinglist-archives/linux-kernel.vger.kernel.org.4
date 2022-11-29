Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC3163B94A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 06:05:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbiK2FFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 00:05:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiK2FE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 00:04:58 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A284733B
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 21:04:54 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 203F25C00CD;
        Tue, 29 Nov 2022 00:04:52 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 29 Nov 2022 00:04:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1669698292; x=
        1669784692; bh=7JBhdj+AHR3dAIOe2gseZvC2qPeV3j2qkNBk4trRfdg=; b=C
        u/lwyGeGHbV7DLYWZDlYiiimjmuOdbSgS641XgIEUQ7MBev0WjcgeIHQMAbEcHk4
        65BpayAEHpDHbDiCB/m2Z9zLcMOlw6C7J0G2rvLjSP2w1J9BSuvkwNshtpD1No3y
        f5tMtz1cpzIhLpqvcXakaR8RGQfEXIvtyx3J04I0E+Kc6ffcyLjmHyWPiCSB9laH
        NsQM0GlYNgeNJsnBcWbv3qQ0ti84bUCpYQzWH+NigWFX9XcWoZ9USH2tzvB0p2sD
        P3pFXz480A7pGRk57PXUpfpEchkaYKiWU6ffw0xgkl/wSwyGSDcB0TwNccYSk4oJ
        fweD6Ta6BDy4FtNz7e6Rg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1669698292; x=
        1669784692; bh=7JBhdj+AHR3dAIOe2gseZvC2qPeV3j2qkNBk4trRfdg=; b=M
        Vu04DsZaIrNTK11Enq8h9uAbbPbvIaamnkXUTZBLEv7sjT+11TU41YBQELfhjLGm
        a3P25LiOtrxYn6bvV4m3J2eiKL5LA83xq9zjUDp12XrsU5klWwAD/VpRKgBXCK5u
        hkTuZhwWBImjHi+E/l3Y2Y4WqKFlqUkjwjx1DMSBsrr8vl2psZNzH8400dxG2tAm
        bwGedGIkQtGxb5/4hBqyH/KezVaZ1Szyo6dB03NRh+POlhHqPAmcAhfG2z72CU7L
        UGJ1n/Ig3AyVAlEXfAAZkJ+Obzd+lIR/P6EZBpKlTprXweLbH6L/6s2eYv5ykHpN
        l1sW+5yCa3bfRKW5l2fOA==
X-ME-Sender: <xms:85KFY6KfoQMhrb7HMjbHOMzpYT3fP9Ke5tqf-ezBHQQGQ__OrvLNVA>
    <xme:85KFYyKgiq58ka_VtYmf3KYgbKJGjpNUzT7I6d_xQTVE98ZYrlQBnxy1HxlyxVu2Q
    8gsdUAT0bZjDdZ9Bg>
X-ME-Received: <xmr:85KFY6sSne-_znocklpvykGzxlTcfzkm9NsTm8ztCzYyQzYR7flNiKHm0TNA3EuQzESY4y9YV3A5C8T9BGLB8C4NgPGJXOxzgRY3HvouWM5Vy_irREQTk69wWg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrjeefgdektdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthejredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnheptedvueevffevvdelgfffledugeeuleehjeegveekjeeuheefvdeh
    kefhuefhteevnecuffhomhgrihhnpehhvggrugdrshgsnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghnugdr
    ohhrgh
X-ME-Proxy: <xmx:85KFY_YALunrmAOPH5LYQ33_dhtr6OUgWW8LHG8LgloEIO6JCOZA8w>
    <xmx:85KFYxYxfxDpTGth7XDSVHIgd3-XwsLIfhNzUESACXFmX7bh-7RsPA>
    <xmx:85KFY7BGcCFZ14w1ytw8NukUPSYTBY8V3v6GbSrmpysEx_isFrXITw>
    <xmx:9JKFY0yA_QE09KOH-z5mv2C9Ns6IPnRu8_DiFLIIGMMl43PHQrR2eg>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Nov 2022 00:04:49 -0500 (EST)
Message-ID: <e39851df-251d-662d-3319-af9d948a9430@sholland.org>
Date:   Mon, 28 Nov 2022 23:04:48 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux ppc64le; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH] riscv: head: use 0 as the default text_offset
Content-Language: en-US
To:     Atish Kumar Patra <atishp@rivosinc.com>,
        Jisheng Zhang <jszhang@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221128152442.3403-1-jszhang@kernel.org>
 <CAHBxVyHg0fU9msnV4vgp4oK6aZZv+nc9mFTbTRjHNsgJAG0eyg@mail.gmail.com>
From:   Samuel Holland <samuel@sholland.org>
In-Reply-To: <CAHBxVyHg0fU9msnV4vgp4oK6aZZv+nc9mFTbTRjHNsgJAG0eyg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/28/22 14:11, Atish Kumar Patra wrote:
> On Mon, Nov 28, 2022 at 7:34 AM Jisheng Zhang <jszhang@kernel.org> wrote:
>>
>> Commit 0f327f2aaad6 ("RISC-V: Add an Image header that boot loader can
>> parse.") adds an image header which "is based on ARM64 boot image
>> header and provides an opportunity to combine both ARM64 & RISC-V
>> image headers in future.". At that time, arm64's default text_offset
>> is 0x80000, this is to give "512 KB of guaranteed BSS space to put
>> the swapper page tables" as commit cfa7ede20f13 ("arm64: set TEXT_OFFSET
>> to 0x0 in preparation for removing it entirely") pointed out, but
>> riscv doesn't need the space, so use 0 as the default text_offset.
>>
>> Before this patch, booting linux kernel on Sipeed bl808 M1s Dock
>> with u-boot booti cmd:
>> [    0.000000] OF: fdt: Ignoring memory range 0x50000000 - 0x50200000
>> ...
>> [    0.000000]   DMA32    [mem 0x0000000050200000-0x0000000053ffffff]
>> As can be seen, 2MB DDR(0x50000000 - 0x501fffff) can't be used by
>> linux.
>>
>> After this patch, the 64MB DDR is fully usable by linux
>> [    0.000000]   DMA32    [mem 0x0000000050000000-0x0000000053ffffff]
>>
>> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
>> ---
>>  arch/riscv/kernel/head.S | 12 +-----------
>>  1 file changed, 1 insertion(+), 11 deletions(-)
>>
>> diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
>> index b865046e4dbb..ef95943f7a70 100644
>> --- a/arch/riscv/kernel/head.S
>> +++ b/arch/riscv/kernel/head.S
>> @@ -38,18 +38,8 @@ ENTRY(_start)
>>         .word 0
>>  #endif
>>         .balign 8
>> -#ifdef CONFIG_RISCV_M_MODE
>> -       /* Image load offset (0MB) from start of RAM for M-mode */
>> +       /* Image load offset (0MB) from start of RAM */
>>         .dword 0
>> -#else
>> -#if __riscv_xlen == 64
>> -       /* Image load offset(2MB) from start of RAM */
>> -       .dword 0x200000
>> -#else
>> -       /* Image load offset(4MB) from start of RAM */
>> -       .dword 0x400000
>> -#endif
>> -#endif
> 
> NACK.
> RV64 needs to boot at a 2MB aligned address and RV32 needs to boot at
> a 4MB aligned address.
> The firmware is assumed to live at the start of DRAM for Linux running
> in S-mode.

What needs to happen so we can stop making this assumption? If the SBI
implementation wants to reserve memory, it should use the devicetree to
do so. OpenSBI already does this.

Throwing away 2 MiB of RAM is quite wasteful considering we have
multiple SoCs (D1s, BL808) that are limited to 64 MiB of in-package RAM.

Regards,
Samuel

