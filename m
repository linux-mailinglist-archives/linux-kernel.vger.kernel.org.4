Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84E0B5C02FB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 17:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232070AbiIUP5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 11:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232058AbiIUP45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 11:56:57 -0400
Received: from wnew1-smtp.messagingengine.com (wnew1-smtp.messagingengine.com [64.147.123.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F3E7A00E5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 08:51:11 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id 486A12B05927;
        Wed, 21 Sep 2022 11:49:54 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Wed, 21 Sep 2022 11:49:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1663775393; x=1663778993; bh=ZUdMdpnOR+
        H/XlChteHcAuStJhMtVvaLi2st4KpsvfM=; b=ODvEgHZSllsMKOHRlFpNTlLENR
        nkaqWr/NYiTtBlAd86He3HECPLY2S77BOxI8+4XWYdPSm6ut2P7qYSFfzZb6ygaS
        469kj559eP6TuTHmrzvv7PJ9i3+BFBW/+xn/iXdALYPBhBToo0xCPJ0v0CBdJtsw
        dGqmZutL+3dgime5EFdv6Nu+EZh+IO02gIUqGG6VLmXCMSakqWwBtQPoDGssVmCX
        EevyAKVHC6Yn1LwYPGh9cxjqDJLP5/oor/EIljKOmAfpZc6AuAz4oZGiQePXT12y
        pOR+d4fISmNX9UeGsHmG0EgJaPOTAtuFPj8y+BOcfxAQTmN2U0D6TdSzsd5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1663775393; x=1663778993; bh=ZUdMdpnOR+H/XlChteHcAuStJhMt
        VvaLi2st4KpsvfM=; b=qab1EJdeFpWQVm8O39GURAACXhRmUR6elSO3awQaFh4s
        rgJc203sYybM9IXKqHA4qRSUWMM3QasISyf7KvzoINllwKZBKZT5j46xwM+CzAvm
        tu43x7qsf3G7jVXhCuM0LT9FkIiRFwm7qYEgNMq6PVKDFIU6y1wbXE3ojaGUh/kB
        kTPdX770hjUjz46T0yKDRhwk3xaGYGgitGDTyXmZtrinOs/4MGIQ/DyUXIscJMDo
        waDCr9JT5EcsirYH01ACAQmnVkFQqMdNhlOSi+x0F66F7aWbCH9anIPvGKK7507V
        y6gbTSBm3cDSxfFtD/XJMD9kqZH8OiJOUYo1QU4P4g==
X-ME-Sender: <xms:oTIrYx0_6P_zF8IVDN8QBCVfPWhkzX8yUGgzXflJRpSO5Ix2SIqa7A>
    <xme:oTIrY4EJSTuH0GX1jP91V2PNJNXVXLn6a1TE3WCokS2xvDxf4BSY4kNgs32_Z6rst
    XuhQWtiyxhtqtktXlE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeefuddgleegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepvefhffeltdegheeffffhtdegvdehjedtgfekueevgfduffettedtkeekueef
    hedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:oTIrYx5K73Q6BoU8LQRpJ-MQCKSVk4dlAhFSEufwb06xAu-MdtZaug>
    <xmx:oTIrY-3uBGNvlc4p5WDNpgIkZJ3gZorjbQA2xMVKjZbZPFWtoj1iug>
    <xmx:oTIrY0FtgpynCJGvUH0lmWaDuBHv3ORWNsu9LeMH8naJBfO3tiYYXQ>
    <xmx:oTIrY4AtUPPxtSbDQ_Rts9whdZBi_O7-KOfz4W9YC7wlVZMySxIW40gOGpY>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 096A7B60086; Wed, 21 Sep 2022 11:49:53 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-935-ge4ccd4c47b-fm-20220914.001-ge4ccd4c4
Mime-Version: 1.0
Message-Id: <ef9a2618-2dd0-4d1b-b9d2-37d59506f004@www.fastmail.com>
In-Reply-To: <20220921164720.6bbc56d5@xps-13>
References: <202209210641.MziHAbW7-lkp@intel.com>
 <20220921104002.226ff3f6@xps-13>
 <ffde44bc-d4ae-4052-c60c-35c8775a5101@sequans.com>
 <7074197c-aa8d-f763-cb0f-03ea5335b923@sequans.com>
 <20220921164720.6bbc56d5@xps-13>
Date:   Wed, 21 Sep 2022 17:49:11 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Miquel Raynal" <miquel.raynal@bootlin.com>,
        "Valentin Korenblit" <vkorenblit@sequans.com>
Cc:     "kernel test robot" <lkp@intel.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [mtd:nand/next 11/31]
 drivers/mtd/nand/raw/cadence-nand-controller.c:1893:4: error: implicit
 declaration of function 'ioread64_rep' is invalid in C99
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2022, at 4:47 PM, Miquel Raynal wrote:
>
> The (erased) context of this thread:
> https://lore.kernel.org/llvm/202209210641.MziHAbW7-lkp@intel.com/
>
> vkorenblit@sequans.com wrote on Wed, 21 Sep 2022 14:27:47 +0200:
>
>> Hi Miquel,
>> 
>> I see that x86_64 doesn't support readsq/writesq because of
>> CONFIG_GENERIC_IOMAP (I was building for arm64). However,
>> __raw_readq/writeq are available and there are a few drivers
>> using them.
>
> I would suggest to rather try using [read|write]sq() to get rid
> of the CONFIG_GENERIC_IOMAP dependency. But it looks like those
> functions are not defined on 32-bit architectures anyway. So if we want
> the driver to compile on both arm and aarch64, it will not be enough.
>
> In practice, I guess we should never have the 64-bit accessor executed
> when running on a 32-bit platform thanks to the following conditions:
>
>   1885			u8 data_dma_width = cdns_ctrl->caps2.data_dma_width;
>   1886	
>   1887			int len_in_words = (data_dma_width == 4) ? len >> 2 : len >> 3;
>   1888	
>   1889			/* read alingment data */
>   1890			if (data_dma_width == 4)
>   1891				ioread32_rep(cdns_ctrl->io.virt, buf, len_in_words);
>   1892			else
>> 1893				ioread64_rep(cdns_ctrl->io.virt, buf, len_in_words);
>
> So maybe we could have something awful yet simple, like the following
> within the Cadence driver:
>
> #if !CONFIG_64BIT
> readsq(...) { BUG()? }
> #endif
>
> Arnd, I've seen a couple of similar issues on the mailing lists in the
> past 5 years but I could not find any working solution, I don't know
> how all these threads have settled in the end. I thought maybe you
> would have a better idea than the above hack :)

There are a lot of different things going on here, so I need
to unwind a bit:

- every architecture should provide readsq()/readsl()/readsw()/readsb()
  these days, regardless of CONFIG_GENERIC_IOMAP. If x86 does
  not have that, we should fix asm-generic/io.h.

- CONFIG_GENERIC_IOMAP just means an architecture uses the generic
  ioread32_rep() style wrapper around readsl()/insl(). On most
  architectures (not x86), insl() is implemented as a wrapper around
  readsl() itself, so readsl() and ioread32_rep() should be identical.

- For a FIFO, you cannot use readq() but have to use __raw_readq()
  to get the correct endianness. You cannot use this for an
  MMIO register with side-effects though, as this needs the byteswap
  and the barrier in readsl().

- On 32-bit architectures, there is no generic way to access a 64-bit
  MMIO location as you say. However, depending on the device you are
  accessing, you can replace __raw_readq() with a pair of
  __raw_readl(), along the lines of
  include/linux/io-64-nonatomic-{lo-hi,hi-lo}.h
 
>> Do you want me to re-implement readsq and writesq in Cadence
>> driver privately or do you suggest a different (cleaner) approach?
>
> I would rather prefer to avoid this solution, as anyway I believe there
> is no "generic" implementation working in all cases, there were a
> couple of attempts IIRC to bring generic helpers like the above for all
> architectures, but none of them landed in Linus' tree, probably because
> it just cannot be made...

If anyone has a datasheet for the cadence driver, they should be
able to look up how one can access the FIFO in 8-byte mode using
32-bit accesses. I think it's something like

static inline void cadence_nand_readsq(const volatile void __iomem *addr,
               void *buffer, unsigned int count)
{
        if (count) {
                u64 *buf = buffer;

                do {
#ifdef __raw_readq
                        u64 x = __raw_readq(addr);
                        *buf++ = x;
#else
                        u32 *buf32 = (void *)buf;
                        buf32[0] = __raw_readl(addr + OFF0);
                        buf32[1] = __raw_readl(addr + OFF1);
                        buf++;
#endif
                } while (--count);
        }
}

Most likely, OFF0 is zero, while OFF1 is 4 here, but that
depends on how the FIFO register is implemented.

     Arnd
