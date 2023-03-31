Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75CD36D1F36
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 13:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231542AbjCaLgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 07:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCaLge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 07:36:34 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C74E7;
        Fri, 31 Mar 2023 04:36:33 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id E6DF75C0101;
        Fri, 31 Mar 2023 07:36:32 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 31 Mar 2023 07:36:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1680262592; x=1680348992; bh=lA
        TVIt48Hpo+q3JJzTeR8jiPkek4/jt/yPq+C0ofGOc=; b=qwOPUeI5fevhA8XQSD
        cyLK+sTtkxX23M69wn8jJd1j5bycqOJ3N68bTC1+LUzAb9nPYwglJFWJs3CRp/B4
        wG3zDOMBp0yYsmnNz3z1aAXWTzMqvMteifmzgNpSaj8cbYgKoeLkOdIay6carwKM
        1hTE7Ai0L7938hAZGaGKHKimFUTQQ7M1Ci6bmSiF99A+SrUgkKO8zhyDI1BKBWDA
        j1plG8fdUB33NdxDeSRaYM8+ntmYOFzX0Aie+06a6MmQFTn7Xl0bNUGbs+IV+t6v
        kHbreO/5AmGeAPaqA/D/wSQIIEsgUBnJ/hPR7BLQBZxW1CA6/9lTXONsFlkXKkJu
        ZfjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1680262592; x=1680348992; bh=lATVIt48Hpo+q
        3JJzTeR8jiPkek4/jt/yPq+C0ofGOc=; b=lC0u06xIA9SXGzlgtSXgNq9N7A9R6
        ZLflqDYtON3uJPnuT/DmXFmjCniwajtkC+CIL0pscI1A0D2aaxh1UgJzQ+P5E0pg
        s+jEiDJyKp3lP1ea21OTCmkGboZr+JHsX6UF6JDayIDy4aeORr0ju+q7xeEbF0OH
        KIBho75TyesT3bEzI608oyD4ksM5DfuUH17++cMGq/OcdibNWyAMEpzGPZlItVtA
        7RAt5rdaUi21P5aCCN6aeWSQLXPef89hcZg5QxV5l7kSfybHDd1lz7EgrGeDKAAZ
        ponC0W30tfTnao/RlPzqBpwpB2mYO35Sl1+igfOrN/QPqqQE7+I5NsgzA==
X-ME-Sender: <xms:wMUmZBKUM4fKUDD_dmcV3zgf7O9E4E30Ev_X4ZeMeiBNdvxHzJnpQg>
    <xme:wMUmZNJTjEzXziGaE-gBPfXV4Fq9L-ZsNdcO4GCMw-fcoHJqT31xwCjMX4yqQpVBW
    VBZYOddg-OJsBAHlEI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeiuddgfeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:wMUmZJu0BgRw0CZ1EHzbcbVOnDqx-qnJseYrsmlJWDUliKtq-MrGdA>
    <xmx:wMUmZCaU5eoDjCvY8WCDnKczM1pSv7MhE-B6UkPIQ_pRqjhZhpZVzg>
    <xmx:wMUmZIb8JQrgHuQzT1pdfMJ8Kii1TCdUwg9s1XlSepSTyHS8wM-avQ>
    <xmx:wMUmZFKGL_2aPddCKBucqadFd2dWjWfCGVpw71HFrTW33TtxtZyThg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 4667FB6008D; Fri, 31 Mar 2023 07:36:32 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-238-g746678b8b6-fm-20230329.001-g746678b8
Mime-Version: 1.0
Message-Id: <08eace10-3eee-481a-b1b4-de58e94cd828@app.fastmail.com>
In-Reply-To: <50e932df-cb20-4679-b911-fd9d7f0f2c1d@spud>
References: <20230330204217.47666-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20230330204217.47666-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <6ca5941a-8803-477d-8b40-17292decc5af@app.fastmail.com>
 <CA+V-a8tkiDXG37YjFKPxrGoXVQMVBemMdBcfb+uUDzBofOWH_A@mail.gmail.com>
 <50e932df-cb20-4679-b911-fd9d7f0f2c1d@spud>
Date:   Fri, 31 Mar 2023 13:36:11 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Conor.Dooley" <conor.dooley@microchip.com>,
        Prabhakar <prabhakar.csengg@gmail.com>
Cc:     "Geert Uytterhoeven" <geert+renesas@glider.be>,
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
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 31, 2023, at 12:55, Conor Dooley wrote:
> On Fri, Mar 31, 2023 at 11:37:30AM +0100, Lad, Prabhakar wrote:
>>
>
> Does that actually work? I don't think it does.
> If you try to enable RISCV_ISA_ZICBOM then you won't get
> RISC_DMA_NONCOHERENT turned on. Run menuconfig and disable support for
> Renesas, SiFive and T-Head SoCs & you can replicate.

Right, the circular dependency has to be broken in some form.

> I think one of RISCV_ISA_ZICBOM and RISCV_DMA_NONCOHERENT should just be
> dropped, although I don't know which one to pick!
> Making RISCV_DMA_NONCOHERENT user selectable probably makes the most
> sense.

That sounds good to me.

    Arnd
