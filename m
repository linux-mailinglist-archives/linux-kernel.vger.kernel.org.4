Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1309C6D009A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 12:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbjC3KEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 06:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbjC3KEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 06:04:21 -0400
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com [66.111.4.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 361AF8A51;
        Thu, 30 Mar 2023 03:03:57 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailnew.nyi.internal (Postfix) with ESMTP id A6E105821FE;
        Thu, 30 Mar 2023 06:03:53 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 30 Mar 2023 06:03:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1680170633; x=1680177833; bh=gF
        qXqcYMWSKuJaGFIiy50Zf8Mul16NUlD8xgems2xkg=; b=JxPZOVxjXCuuUFnz8g
        uR2No3WKokB1kYnBVGLyuNTT1GHbSx7HcllmOlx7WL73MRjvBNY1Jz63nwSIuXZm
        fARBRkt2EgiPXJLAvasiK+94JN9Rp7qIpeg/c8F9us28ZAmzX4a12l/FSLzGWeAf
        GP7Lhb+lkhGzU3GXPlwLR10V758pcgH1ojqXsjwkdVyUvwtO9WMqdgRyfQ7u3ctM
        W7sU+9bMDjJx0q1aRSpQBmyxejDAdo7VNGKwjccZfKKub+cgQ2ZTm/zkP2y/rRlx
        wYI35VSqJc9OdGsxpiyx9Lz/h6dHQyx/rbychak5+lhcx20ykt8JwaYwQzyk90NH
        m/JA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1680170633; x=1680177833; bh=gFqXqcYMWSKuJ
        aGFIiy50Zf8Mul16NUlD8xgems2xkg=; b=o3ayTuAjbuBu4DPifrxB/HOOZRdO1
        xb065wIqst9K32LE2zIFvIgvo3yv5lHodsQ9WEQeJOnQ4UcFBj18pN027eK8euOR
        PtcZaxUi42xyTMd+sbBNtRmY12wtqYj80lCZcTZsq6sg8WYonLY5xmdrshZ5C44/
        jXjWmEhQ68ThFXZ/SV/69f9njMopwi7kUxCVm+NBkbrrBCIP7mBID23rgx/hkVub
        HQT4TO9CRtSmC/0UwEYJhKoIxPA5B3sXRdQjC9d5SuBSM3xeOdM9GqWhROqUG5n+
        6gfH5c9KmTWNqq/meniN7YOfy58761x7eNGJpjVNO+ni0u9AywZLJQEUQ==
X-ME-Sender: <xms:h14lZP2P6-1WML0tnHU0HdMdtZK3G6AdboBJze6kLEnEZTHVfufW-A>
    <xme:h14lZOG421saOUxl3VTrr1QErXRPxmod2xdJenKYhBULtUD7d6J8ovO92D02wTAv1
    7ZDE3mwId6_yOeP8ic>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdehkedgvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:h14lZP41dAmtiVu4ty1E8BBZ-9reNxwryxuQCN8Se8vdMAwQTZcBkg>
    <xmx:h14lZE2dCL5QmCe3baeT7FUMFxbuJwcm88C-9hfhLub0UJvmYVxYPg>
    <xmx:h14lZCHsPaycpm9MVz5soXkltYLZMmnIjjAwPs6W0AlziFmXAZIfJA>
    <xmx:iV4lZI76poFBm_RbGrZvSm-s7BW_iB7cNPqH9WgtDueAW0AKJy54Lg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 423AFB60086; Thu, 30 Mar 2023 06:03:51 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-238-g746678b8b6-fm-20230329.001-g746678b8
Mime-Version: 1.0
Message-Id: <6a5bd3a3-87e0-4a24-89ca-d265b0817a95@app.fastmail.com>
In-Reply-To: <d7f36a28-0cae-a035-791b-363754aefeee@linaro.org>
References: <20230327121317.4081816-1-arnd@kernel.org>
 <20230327121317.4081816-19-arnd@kernel.org>
 <d7f36a28-0cae-a035-791b-363754aefeee@linaro.org>
Date:   Thu, 30 Mar 2023 12:03:16 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Neil Armstrong" <neil.armstrong@linaro.org>,
        "Arnd Bergmann" <arnd@kernel.org>, linux-kernel@vger.kernel.org
Cc:     "Vineet Gupta" <vgupta@kernel.org>,
        "Russell King" <linux@armlinux.org.uk>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>, guoren <guoren@kernel.org>,
        "Brian Cain" <bcain@quicinc.com>,
        "Geert Uytterhoeven" <geert@linux-m68k.org>,
        "Michal Simek" <monstr@monstr.eu>,
        "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
        "Dinh Nguyen" <dinguyen@kernel.org>,
        "Stafford Horne" <shorne@gmail.com>,
        "Helge Deller" <deller@gmx.de>,
        "Michael Ellerman" <mpe@ellerman.id.au>,
        "Christophe Leroy" <christophe.leroy@csgroup.eu>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        "Rich Felker" <dalias@libc.org>,
        "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>,
        "David S . Miller" <davem@davemloft.net>,
        "Max Filippov" <jcmvbkbc@gmail.com>,
        "Christoph Hellwig" <hch@lst.de>,
        "Robin Murphy" <robin.murphy@arm.com>,
        "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "Conor.Dooley" <conor.dooley@microchip.com>,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        "linux-oxnas@groups.io" <linux-oxnas@groups.io>,
        "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
        linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org,
        "linux-openrisc@vger.kernel.org" <linux-openrisc@vger.kernel.org>,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        "Daniel Golle" <daniel@makrotopia.org>
Subject: Re: [PATCH 18/21] ARM: drop SMP support for ARM11MPCore
Content-Type: text/plain
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023, at 09:48, Neil Armstrong wrote:
> On 27/03/2023 14:13, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>> 
>> The cache management operations for noncoherent DMA on ARMv6 work
>> in two different ways:
>> 
>>   * When CONFIG_DMA_CACHE_RWFO is set, speculative prefetches on in-flight
>>     DMA buffers lead to data corruption when the prefetched data is written
>>     back on top of data from the device.
>> 
>>   * When CONFIG_DMA_CACHE_RWFO is disabled, a cache flush on one CPU
>>     is not seen by the other core(s), leading to inconsistent contents
>>     accross the system.
>> 
>> As a consequence, neither configuration is actually safe to use in a
>> general-purpose kernel that is used on both MPCore systems and ARM1176
>> with prefetching enabled.
>> 
>> We could add further workarounds to make the behavior more dynamic based
>> on the system, but realistically, there are close to zero remaining
>> users on any ARM11MPCore anyway, and nobody seems too interested in it,
>> compared to the more popular ARM1176 used in BMC2835 and AST2500.
>> 
>> The Oxnas platform has some minimal support in OpenWRT, but most of the
>> drivers and dts files never made it into the mainline kernel, while the
>> Arm Versatile/Realview platform mainly serves as a reference system but
>> is not necessary to be kept working once all other ARM11MPCore are gone.
>
> Acked-by: Neil Armstrong <neil.armstrong@linaro.org>
>
> It's sad but it's the reality, there's no chance full OXNAS support will
> ever come upstream and no real work has been done for years.
>
> I think OXNAS support can be programmed for removal for next release,
> it would need significant work to rework current support to make it acceptable
> before trying to upstream missing bits anyway.

Ok, thanks for your reply!

To clarify, do you think we should plan for removal after the next
stable release (6.3, removed in 6.4), or after the next LTS
release (probably 6.6, removed in 6.7)? As far as I understand,
the next OpenWRT release (23.x) will be based on linux-5.15,
and the one after that (24.x) would likely still use 6.1, unless
they skip an LTS kernel.

     Arnd
