Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFE6E6FC611
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 14:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235674AbjEIMQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 08:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjEIMQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 08:16:08 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 160CA3C25;
        Tue,  9 May 2023 05:16:04 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 846B63200437;
        Tue,  9 May 2023 08:15:59 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 09 May 2023 08:16:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1683634559; x=1683720959; bh=jMFJATipArZQBRY6U4nByREOOWvUXM2jwlx
        Y3nY6hu0=; b=ZfsaS5LDJ0o2jzmbku6hsKKp4oObCLeMCqZEuxd7nuCw81w3krt
        pdTWFMEX9b9NcYaoE/uuu3vGgpdVsc0I0nGzz+Uay2NA7FhED7+e05ZXqfIMk/Iq
        rRUOymcyzGBMyo3ksf/3lgDJaC63Rx6Z6PhM0P5ZpXPdtU+1Vef4AEsFNAKGdjgg
        dZw2C//hotodyFWSm0gHFvmcYvhon9wVV5WTGatxB2Pxi5PqN9BABn1MDJV3H/lN
        KS1YH+4O9/bOqLhy84QRVeo2cnXI0lHp+XiIr9BsL7f3UIotn67VTbPb+fossMxB
        WuhptkpiWKvn/rtm8Hmdpjb7h8TYrF97bWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1683634559; x=1683720959; bh=jMFJATipArZQBRY6U4nByREOOWvUXM2jwlx
        Y3nY6hu0=; b=LC89PMaH+NrcQx7ntd8N9c3gGTHk77YGeaxocqDBUZVoNX0vYyy
        21gcoBEEur2Z3DyJN+3uWL1oRfWL8EAasgFYOdQd/eNjdmqPmI46x8QcC0PjPOtY
        Y+LEnUCBV6jci5GBm9+zGwL34nXM0OOZbJJ9puBraCNP6/TI3EEEy7ysKv4MZn1X
        ZEyFb8kmi48FyJ7DV+rdwwABX4tr/MhG5bOXniO3Q5w6h9Jzue030dhaDd2e+8Br
        InKeJCDAFNq4mzX+WoKT/gaZt/j7n5l1QJ4Zzj9q3UrUC60g4RLBxmXFXbUvmoOU
        MnwFoU1scv97ZmqrJxT9ne0HWqResTECjDA==
X-ME-Sender: <xms:fjlaZFpnnWGKp_l1wYq3iNuQN7Gni46QlwMzAqXckS9ufTk7JxjO_w>
    <xme:fjlaZHr5zZUHXPswqpZWTP0A1G9OqmM--lh3voqG91_qHbZRx1tvIR2pGltEsWAXz
    BCzQWPPGTasqg4oJJE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeegtddggeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:fjlaZCMtr5bwynHlhW4Lm9PXk7yAgi4-S0X3LzOd6BAzENQxRiM8dQ>
    <xmx:fjlaZA4WS8a8pR5ljQ1U3Vkdw67Ko-30g3NdKzeSocpZ_eKZvDX2dA>
    <xmx:fjlaZE689Ji7FiV5fy4mmoE47E22b3pwIcqN0eCGmtNGHn9o5JycAQ>
    <xmx:fzlaZBwXX1FNQxwMzmeJm51odJp-ZEtamFOJuGxX1kWbn4B9CxIZ1w>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 6606FB60086; Tue,  9 May 2023 08:15:58 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-415-gf2b17fe6c3-fm-20230503.001-gf2b17fe6
Mime-Version: 1.0
Message-Id: <eeeaf258-8f2b-436a-aba0-b32dc90b359f@app.fastmail.com>
In-Reply-To: <2ba483e9-267f-2159-1ea8-75a2618fcdf9@linux.intel.com>
References: <20230508025936.36776-1-ychuang570808@gmail.com>
 <20230508025936.36776-11-ychuang570808@gmail.com>
 <2ba483e9-267f-2159-1ea8-75a2618fcdf9@linux.intel.com>
Date:   Tue, 09 May 2023 14:14:00 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        "Jacky Huang" <ychuang570808@gmail.com>
Cc:     "Rob Herring" <robh+dt@kernel.org>,
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

On Tue, May 9, 2023, at 12:17, Ilpo J=C3=A4rvinen wrote:
> On Mon, 8 May 2023, Jacky Huang wrote:
>> +
>> +#define UART_NR			17
>> +
>> +#define UART_REG_RBR		0x00
>> +#define UART_REG_THR		0x00
>> +#define UART_REG_IER		0x04
>> +#define UART_REG_FCR		0x08
>> +#define UART_REG_LCR		0x0C
>> +#define UART_REG_MCR		0x10
>
> These duplicate include/uapi/linux/serial_reg.h ones, use the std ones=20
> directly.
>
> Setup regshift too and use it in serial_in.

I think this came up in previous reviews, but it turned out that
only the first six registers are compatible, while the later
ones are all different, and it's not 8250 compatible.

It might be helpful to rename the registers to something
with a prefix other than UART_REG_*, to avoid the confusion
and possible namespace clash.

>
>> +/* UART_REG_IER - Interrupt Enable Register */
>> +#define IER_RDA_IEN		BIT(0)  /* RBR Available Interrupt Enable */
>> +#define IER_THRE_IEN		BIT(1)  /* THR Empty Interrupt Enable */
>> +#define IER_RLS_IEN		BIT(2)  /* RX Line Status Interrupt Enable */
>
> These look same as UART_IER bits, use the std ones.
...
> Are these same as UART_FCR_CLEAR_* functionality wise? If they're use =
std=20
> ones.

Again, I'd think we're better off having a distinct naming for
them than trying to share the definitions with 8250.

>> +static struct uart_driver ma35d1serial_reg =3D {
>> +	.owner        =3D THIS_MODULE,
>> +	.driver_name  =3D "serial",
>> +	.dev_name     =3D "ttyS",
>> +	.major        =3D TTY_MAJOR,
>> +	.minor        =3D 64,
>> +	.cons         =3D MA35D1SERIAL_CONSOLE,
>> +	.nr           =3D UART_NR,
>> +};
>
> This doesn't seem necessary, 8250 core will have the uart_driver for y=
ou
> and most of the console stuff too. You just need to setup a few things=20
> correctly (see the setup functions in 8250_early for ideas/examples).
>...
>> +
>> +	ret =3D uart_add_one_port(&ma35d1serial_reg, &up->port);
>
> For 8250, you should be using serial8250_register_8250_port(). See the=20
> other drivers how to setup the console functions.

Consequently, this should also be kept separate from the serial8250
driver, I don't see a way to fit the nuvoton code into the existing
driver without making the resulting driver worse for everyone.

There is one thing that absolutely needs to be changed though:
the driver_name/dev_name/major/minor fields all clash with the
8250 driver, so you cannot have a kernel that has both drivers
built-in. All of these should change to get out of the way of the
existing drivers.

        Arnd
