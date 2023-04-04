Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B12CB6D58E9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 08:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233586AbjDDGul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 02:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233352AbjDDGuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 02:50:39 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D4881FC7;
        Mon,  3 Apr 2023 23:50:38 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 77F6B5C00C8;
        Tue,  4 Apr 2023 02:50:37 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 04 Apr 2023 02:50:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1680591037; x=1680677437; bh=el
        ixwEDiNgZqccMmgXM1U3TCkBH6pUKMQR7xL76PiyU=; b=SBTTwL3F10HK8gYxD+
        13CEenffSlTgD8tzUSP/qjBzQX4zH70uQiiGWGmmd5RcPLXp5yvS5jVm7KzBzSss
        gXRxBHejIO64oTiQhfZsSnf/sA1GVHtja+BuccNhulmtZfHBEXsiG7UjmUhx3NQS
        dW+15zaUxaoE9fGQ5M6M1mx9FVUgYObFMn4wOqtjYFdCS50f4B4k1L3Jfdnj3on6
        u8z5AjW5PcrVbCWA8/B9orGYDiG+dFn12HcARAB4wieL/QykBjyJ0WYKkNZii1l4
        cVOA5eXWuJtJdy+J4AWSuwCBdOdtxUgpMqxWd3nmJfrVEOHNrqwxzjgTU5sZf+Uk
        o3vQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1680591037; x=1680677437; bh=elixwEDiNgZqc
        cMmgXM1U3TCkBH6pUKMQR7xL76PiyU=; b=tRnpfs5nUR56U1Nh8AUU+/kGXjzbg
        N2/VpAOpyt1cgY9hMLFecqRriE8heTf5+UOdmyYnPxjZDKTkvbVOPsbR3OIn18qS
        EzfMM2G/Equ4kWfUvOBeh2Gj65eVj9dYlhQavuhGoteb/wbITcUHHKSI2SThfJJa
        xptQXW5QlO6tKk1kYGv6bzEM/zRKtupxfpIXNbFEQ/8nIWDafEr/otECt0MfCwBO
        wep6RlEF7QzSl/xyE2/PaFOk2HhvZf3djXNE754T7Mwuh2jh4+dohPDmrNnaped2
        di7JcP9gPA5kanjkrlspI9KCSEnBbpJyH4BcKPzP2if13i8wBj7XJQt4g==
X-ME-Sender: <xms:vMgrZPu7kf5XDc_8yTYtv24g-JbEuVp1mxnx8rNniRf99MTbkiMi5w>
    <xme:vMgrZAeoSpBNX_ZYZGWVLLWBajBGcs4n4LGxMVF_pdcm7znzFZvTl5-B8SMS9loBK
    lixlSN9l8hKfLhgbjQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeikedgleeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:vMgrZCwtlHLgPb-U5fpOH6uZkBSH4RT-VubLcDfY9uG9anIqzCHI7Q>
    <xmx:vMgrZOMvIPvBkf7EfY8gHHzhZ3cs-aMN9CnrM1iC1F4EmmWF8N7kUg>
    <xmx:vMgrZP8ZQhMsLRaCnCAynlFW2K5N34yjrGbJsB1pl5YjvyYFtiGYWA>
    <xmx:vcgrZHMFEh0UnzcvaFtW0xWqizs-Xi_FhfgxwxfNnzopeB6f4cSTqw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 488C2B60092; Tue,  4 Apr 2023 02:50:36 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-238-g746678b8b6-fm-20230329.001-g746678b8
Mime-Version: 1.0
Message-Id: <377d2841-18b5-4f61-b675-3a7c2e0db3b2@app.fastmail.com>
In-Reply-To: <ZCu1tFrQCVe2sgNz@infradead.org>
References: <20230330204217.47666-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20230330204217.47666-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <ZCu1tFrQCVe2sgNz@infradead.org>
Date:   Tue, 04 Apr 2023 08:50:16 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Christoph Hellwig" <hch@infradead.org>,
        Prabhakar <prabhakar.csengg@gmail.com>
Cc:     "Conor.Dooley" <conor.dooley@microchip.com>,
        "Geert Uytterhoeven" <geert+renesas@glider.be>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        guoren <guoren@kernel.org>,
        "Andrew Jones" <ajones@ventanamicro.com>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        "Albert Ou" <aou@eecs.berkeley.edu>,
        "Samuel Holland" <samuel@sholland.org>,
        linux-riscv@lists.infradead.org,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "Biju Das" <biju.das.jz@bp.renesas.com>,
        "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v7 1/6] riscv: mm: dma-noncoherent: Switch using function pointers
 for cache management
Content-Type: text/plain
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 4, 2023, at 07:29, Christoph Hellwig wrote:
> On Thu, Mar 30, 2023 at 09:42:12PM +0100, Prabhakar wrote:
>> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>> 
>> Currently, selecting which CMOs to use on a given platform is done using
>> and ALTERNATIVE_X() macro. This was manageable when there were just two
>> CMO implementations, but now that there are more and more platforms coming
>> needing custom CMOs, the use of the ALTERNATIVE_X() macro is unmanageable.
>> 
>> To avoid such issues this patch switches to use of function pointers
>> instead of ALTERNATIVE_X() macro for cache management (the only drawback
>> being performance over the previous approach).
>> 
>> void (*clean_range)(unsigned long addr, unsigned long size);
>> void (*inv_range)(unsigned long addr, unsigned long size);
>> void (*flush_range)(unsigned long addr, unsigned long size);
>> 
>
> NAK.  Function pointers for somthing high performance as cache
> maintainance is a complete no-go.

As we already discussed, this is now planned to use a direct
branch to the zicbom version when the function pointer is NULL,
which should be a fast predicted branch on all standard implementations
and only be slow on the nonstandard ones, which I think is a reasonable
compromise.

I'm also not sure I'd actually consider this a fast path, since
there is already a significant cost in accessing the invalidated
cache lines afterwards, which is likely going to be much higher than
the cost of an indirect branch.

I suppose an alternative would be to use the linux/static_call.h
infrastructure to avoid the overhead of indirect branches altogether.
Right now, this has no riscv specific implementation though, so
using it just turns into a regular indirect branch until someone
implements static_call.

       Arnd
