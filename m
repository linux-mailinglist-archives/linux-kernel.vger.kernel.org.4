Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2E6667F8CC
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 15:45:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232174AbjA1Opi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 09:45:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbjA1Opf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 09:45:35 -0500
X-Greylist: delayed 326 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 28 Jan 2023 06:45:27 PST
Received: from 7of9.schinagl.nl (7of9.connected.by.freedominter.net [185.238.129.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF90F561A9;
        Sat, 28 Jan 2023 06:45:27 -0800 (PST)
Received: from [10.2.12.71] (unknown [10.2.12.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by 7of9.schinagl.nl (Postfix) with ESMTPSA id F1DD918A3771;
        Sat, 28 Jan 2023 15:39:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=schinagl.nl; s=7of9;
        t=1674916800; bh=BDzOy+7xZC21egrV0bu8pSE2qu/8H6OBqAFnjEutPLA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=IIUf3OSUnv8P5T+k6YpAYOaqAAW84vuiTKEEOXioviO5uCMF+sq/CP/2bumTrFhHn
         AhKw8A462/d/MlxoUOx2wN5VMPL9TcaXpSQK07dI45iAikAGAT3Ro7+ocf1pV1DhUZ
         b2sDnV6uXiDX4aoSmI1Gx7eR2ch4cwjUi8P3uuFQ=
Message-ID: <46724036-fabf-7bae-41f8-1e95c5f1db5c@schinagl.nl>
Date:   Sat, 28 Jan 2023 15:39:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] mips: Realtek RTL: select NO_EXCEPT_FILL
Content-Language: nl
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Sander Vanheule <sander@svanheule.net>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230115121922.6359-1-sander@svanheule.net>
 <20230127162755.GB6090@alpha.franken.de>
From:   Olliver Schinagl <oliver@schinagl.nl>
In-Reply-To: <20230127162755.GB6090@alpha.franken.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Thomas,

On 27-01-2023 17:27, Thomas Bogendoerfer wrote:
> On Sun, Jan 15, 2023 at 01:19:22PM +0100, Sander Vanheule wrote:
>> Olliver has suggested to make this change, in order to reduce the delta
>> with a fully generic MIPS kernel.
>> <snip>
> applied to mips-next.
>
> Thomas.
>
Thanks Thomas, may I take this moment to poke you about a nother issue I 
don't quite understand how to resolve/figure out.


I made the realtek target work with the GENERIC_MIPS_KERNEL, but only if 
I disable SWAP_IO_SPACE[0].

While I could act all smart and ask what this is for, I better ask, why 
is this concidered 'generic'. The comment in mangle-port [1] mentions 
'sane hardware'. I don't know what is considered sane here, as the 
number of targets following generic mips seem to be around 5.

So any pointers (other then doing SWAP_IO_SPACE if !REALTEK_SOC, which I 
have now) would be appreciated


[0]: https://elixir.bootlin.com/linux/latest/source/arch/mips/Kconfig#L157

[1]: 
https://elixir.bootlin.com/linux/latest/source/arch/mips/include/asm/mach-generic/mangle-port.h#L17


