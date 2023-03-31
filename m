Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 482196D1E45
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 12:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbjCaKpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 06:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjCaKpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 06:45:19 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38A9FEC50;
        Fri, 31 Mar 2023 03:45:18 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id A26FF5C00E3;
        Fri, 31 Mar 2023 06:45:17 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 31 Mar 2023 06:45:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1680259517; x=1680345917; bh=pzy3nJ30w0x4nrGzKOJJ8rRyt47zboRy5gx
        fhKC4NYI=; b=A7YeMzUJVhHQHNgRPcCCzPVnsvvJW/+RlJHcot4BrK9OnCx+4Nr
        ggbru+dt4n3iLcF60cSoLKHEAG6Bb4YbtAhmElrZcs9HCCdB5RFb/k8NoArODb92
        +EqoLY8OmnZYkwunpoQIJSY2u68OccDdU8z/JgFundu7Jbw3EJX1q74r6yFgJiVD
        HQDFQyB5IqiNntc52jkAhFEXPO0Al3gfjKHGhy1adumV75lyqrZivOh8zeacl97h
        XSSLQSJZp/5Qr9+gm99/rKqIxoYMZb6mMPaFnYGYupD/l0ym/i8RuxS7NPO/1BC0
        ytOMGQ1UG04vwBX2SaP/8zmk2DqZFnDEwQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1680259517; x=1680345917; bh=pzy3nJ30w0x4nrGzKOJJ8rRyt47zboRy5gx
        fhKC4NYI=; b=rRLpijf7nAfAb9LM1qqYp6dF8Z5Mj6xTdPJoDYABChmA8MUlAWs
        VcoEfUYpSeki5Io71aV0OfMdb34D+Xu5PBxU25zuYqgexM7rgqE5rkk+jHpHlzj+
        Qk/LG6+budISvSoeWaPuQIGh5DqNUnlOtYaIoYZmvjL97UIBk98ATs6KMZjU5Voz
        I9QLBf2uGkbsADdWT/UtEJaqqF6Gz4f1Jg5cLBUM0PIkheTq8onN8J2/RiZi2h8e
        RE3F2FNRq/dwlg1b8HFR8vAW+TfvigZkKCHtIvKWTTwyHPB0d4Fj9Q1k1FY89vfD
        FokczKERpeSl9Nnim0sIUDju1VqgrQnQLMw==
X-ME-Sender: <xms:vLkmZNrl6H1Tc7fB5jrm4lqdNJ0LtmefjT3I8b1YIC1q-J49hL-k8Q>
    <xme:vLkmZPrVmRMXZyoH7f__R98oiB3KzRM7vJO7aSdBENIqtz2lkPoEj2_3a10qgIBcZ
    j7xgCDSFxvN4DI0Nuc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeiuddgvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:vLkmZKMPl5Rso5qEETRCL4RnVxWW2c-ERzdNvmHt718-ajWblUVhLA>
    <xmx:vLkmZI6GhQXD2Sk3buXdUqrEFQBqo80UhkuO9cJ1c4Ws_IjyZGWmCg>
    <xmx:vLkmZM6i6bvzE5I-SHBRUMuxVIohfc2ZGDIbt73gwvR8yNzDOiHPCQ>
    <xmx:vbkmZHo_EqC7oO3WQFk1S3wK_PR5n3PcF5Ga-HLg1Ivau52NgmnVyA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 4266AB6008D; Fri, 31 Mar 2023 06:45:16 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-238-g746678b8b6-fm-20230329.001-g746678b8
Mime-Version: 1.0
Message-Id: <1c441d20-951d-407b-90ba-4cda3b0505b2@app.fastmail.com>
In-Reply-To: <CA+V-a8tkiDXG37YjFKPxrGoXVQMVBemMdBcfb+uUDzBofOWH_A@mail.gmail.com>
References: <20230330204217.47666-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20230330204217.47666-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <6ca5941a-8803-477d-8b40-17292decc5af@app.fastmail.com>
 <CA+V-a8tkiDXG37YjFKPxrGoXVQMVBemMdBcfb+uUDzBofOWH_A@mail.gmail.com>
Date:   Fri, 31 Mar 2023 12:44:54 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     Prabhakar <prabhakar.csengg@gmail.com>
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
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 31, 2023, at 12:37, Lad, Prabhakar wrote:
> On Thu, Mar 30, 2023 at 10:34=E2=80=AFPM Arnd Bergmann <arnd@arndb.de>=
 wrote:
>
>> It also seems wrong to have the fallback be to do nothing
>> when the pointer is NULL, since that cannot actually work
>> when a device is not cache coherent.
>>
> If the device is non cache coherent and if it doesn't support ZICBOM
> ISA extension the device won't work anyway. So non-cache coherent
> devices until they have their CMO config enabled won't work anyway. So
> I didn't see any benefit in enabling ZICBOM by default. Please let me
> know if I am misunderstanding.

Two things:

- Having a broken machine crash with in invalid instruction
  exception is better than having it run into silent data
  corruption.

- a correctly predicted branch is typically faster than an
  indirect function call, so the fallback to zicbom makes the
  expected (at least in the future) case the fast one.

> @@ -465,7 +466,6 @@ config RISCV_ISA_ZICBOM
>         depends on MMU
>         depends on RISCV_ALTERNATIVE
>         default y
> -       select RISCV_DMA_NONCOHERENT
>         help
>            Adds support to dynamically detect the presence of the ZICB=
OM
>            extension (Cache Block Management Operations) and enable its
>
> But what if the platform doesn't have the ZICBOM ISA extension?

Then it needs to register its cache operations before the first
DMA, which is something that it should do anyway. With your
current code, it may work by accident depending on the state of
the cache, but with the version I suggested, it will either work
correctly all the time or crash in an obvious way when misconfigured.

     Arnd
