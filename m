Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F40AF6FC66D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 14:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235376AbjEIMcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 08:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233731AbjEIMcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 08:32:39 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0AE340D9;
        Tue,  9 May 2023 05:32:37 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id B8F8432005B5;
        Tue,  9 May 2023 08:32:35 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 09 May 2023 08:32:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1683635555; x=1683721955; bh=j4Tty1TtH2xu1KFfX5U4nu0r+YPVUX+H4xd
        KGXYuqL0=; b=PY6m7GibKw4PfF6fRztVM9LkBonnvWm5DeTxdFnAW2PoE9PKecY
        Y8T65aT+fuKPhFLh58f+BN4Vdi1g54CC//3QKlRahsuANgb+rF0vHDOnRZo9jQ5y
        t7sjZez37bCeiRGmGEy0AqWffdjCyQSCUEV09xbZVUdUCN010K+DaYCBqrk/JJEM
        iB+vrxcD6FEGJ6I+cY5miTEr90yhzO03XBdXt+s8+aY+tswsab0A6o34NWe3jpUm
        PX3eSAeE6j+G6BVtklJv0LXtCTYoczeuvqILQYliVzLMaMmSKQjEE74cm9ism2dG
        ySSHm/m1iVu/S2YcMvFGncu1w2Jhd+/LVLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1683635555; x=1683721955; bh=j4Tty1TtH2xu1KFfX5U4nu0r+YPVUX+H4xd
        KGXYuqL0=; b=ZeOUA0S57AXSFRxJ6nTctd/UvAhAW+Lbtc87ncxN9+7iUP2ooJH
        0dD6l6S2voRJfKViUYPLscVkDCm++jDaFY0/qc9iCxwZQEQsjxlOoZWbLCU0clWQ
        9+FMI0/9C4aqAWqi+6Q3PzJjfN7yVKwAhtoSWKxn1LfvFDj2UqFfrYwdqcwW1M/h
        QcrTg43pbhxJQaLzdJe71ps+yg63gY/xgB8fw4pVYJLzHnHpJJHmgAFFTEiR6P3U
        9dCyUBGaNu/SAgOkWJZOQUw4Wj2kvQFzsBESt2Ym4ieqkHcZeVV3vCkJEdXEAS81
        3airv3DjwjENAplSYkYJQqFZyVnbH36f66w==
X-ME-Sender: <xms:Yj1aZGD4HifU45vgEY5a4iFzzoDC70M-m6Eh1lIq8z-ibfQCTYX7-A>
    <xme:Yj1aZAgdzPuOzsCJY5v7SF926n4yoBpYF0E99MxykGdlF7VAwOy3zXN5e6xkh0iuW
    qzVoUWbztASJwbV13M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeegtddghedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:Yj1aZJnkvUJ-vv65tFXl6WLr8jb-zxnU8f-j8iQXp9f7FzTPmPegUQ>
    <xmx:Yj1aZEw3K7bSgTtrTePH79QPyjabh4kyRiCVn9f-DM2_pUUhHbK3pw>
    <xmx:Yj1aZLSXaIIEHgviwQte5bbV4GC7ACSUk8IYjuFa_0g2PuqusvzKag>
    <xmx:Yz1aZMKONUfqCCXWRGpLEYXOMnB56HqEsXskVJKCkMhLn5OIJwUpeg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 95BB3B60086; Tue,  9 May 2023 08:32:34 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-415-gf2b17fe6c3-fm-20230503.001-gf2b17fe6
Mime-Version: 1.0
Message-Id: <72983689-0e98-4482-b549-ba2530274943@app.fastmail.com>
In-Reply-To: <b9573562-d4d7-3535-fb4d-f2bc694f2a4@linux.intel.com>
References: <20230508025936.36776-1-ychuang570808@gmail.com>
 <20230508025936.36776-11-ychuang570808@gmail.com>
 <2ba483e9-267f-2159-1ea8-75a2618fcdf9@linux.intel.com>
 <eeeaf258-8f2b-436a-aba0-b32dc90b359f@app.fastmail.com>
 <b9573562-d4d7-3535-fb4d-f2bc694f2a4@linux.intel.com>
Date:   Tue, 09 May 2023 14:32:12 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     "Jacky Huang" <ychuang570808@gmail.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org, "Lee Jones" <lee@kernel.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        "Stephen Boyd" <sboyd@kernel.org>,
        "Philipp Zabel" <p.zabel@pengutronix.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Jiri Slaby" <jirislaby@kernel.org>,
        "Tomer Maimon" <tmaimon77@gmail.com>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-serial <linux-serial@vger.kernel.org>, schung@nuvoton.com,
        mjchen@nuvoton.com, "Jacky Huang" <ychuang3@nuvoton.com>
Subject: Re: [PATCH v10 10/10] tty: serial: Add Nuvoton ma35d1 serial driver support
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 9, 2023, at 14:25, Ilpo J=C3=A4rvinen wrote:
> On Tue, 9 May 2023, Arnd Bergmann wrote:
>> On Tue, May 9, 2023, at 12:17, Ilpo J=C3=A4rvinen wrote:
>> > On Mon, 8 May 2023, Jacky Huang wrote:
>> >> +
>> >> +#define UART_NR			17
>> >> +
>> >> +#define UART_REG_RBR		0x00
>> >> +#define UART_REG_THR		0x00
>> >> +#define UART_REG_IER		0x04
>> >> +#define UART_REG_FCR		0x08
>> >> +#define UART_REG_LCR		0x0C
>> >> +#define UART_REG_MCR		0x10
>> >
>> > These duplicate include/uapi/linux/serial_reg.h ones, use the std o=
nes=20
>> > directly.
>> >
>> > Setup regshift too and use it in serial_in.
>>=20
>> I think this came up in previous reviews, but it turned out that
>> only the first six registers are compatible, while the later
>> ones are all different, and it's not 8250 compatible.
>
> So use the normal name for compatible ones and HW specific names for t=
he=20
> others?
>
> It might not be compatible in everything but surely 8250 influence is=20
> visible here and there.

I'd rename all of them and share nothing. I had the same thought as you
when I first looked at the driver, and thought of how we merged the omap
uart into 8250 for this reason, but after I found a datasheet for this
one, my impression was that it's a much more distant cousin of 8250
than the others,

There is clearly some family lineage, but there are differences
everywhere, and I don't think it was designed by extending a 8250
compatible hardware block with extra features, but rather built
from scratch (sigh) based only loosely on a register description
but then extending it with no intent of retaining compatibility.

       Arnd
