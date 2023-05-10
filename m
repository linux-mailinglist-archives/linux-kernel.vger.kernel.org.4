Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 094CF6FDC0F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 12:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236261AbjEJK6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 06:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235609AbjEJK56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 06:57:58 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C5344A7;
        Wed, 10 May 2023 03:57:50 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 4912B5C0113;
        Wed, 10 May 2023 06:57:47 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 10 May 2023 06:57:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1683716267; x=1683802667; bh=U322gBAbCdps6RWJ4IJe3DP7Q6UeQ5VwPYn
        Ra4Qb9OY=; b=rMEQzxhepIevzd53zmr36ANsYcs/OOEySbJaannH74IKSpDs3Ju
        gQMYhehpV1GQ4LPVKnzIPDnQf1lvB33N9pE8YF9J32ReLyXJvx+S1B2QdpPlqls7
        g7Imz420Hwf4wT9v+BT6fEXENLl6JfjhZ3j2i04OgLETYfOKqBC+m5JwP4wMq7Dc
        XOQVNCGKulmK3B7CMtfLUbmThrqcKJ/HGDjyllm09BbWX/8ZCtyjnvJPcytEuB6i
        HBYXczt2TA64uMydKCs26VNGSy3RljKUssaBGAj8MDahQYkRJ9AIqZSoj1ZZgzMO
        WFgs1ScRCk5ltE3iCiho20uMqpo0uyR9llg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1683716267; x=1683802667; bh=U322gBAbCdps6RWJ4IJe3DP7Q6UeQ5VwPYn
        Ra4Qb9OY=; b=FBOsVLG+2ibtxfa6a9Z4GIo550sXjdgJMAao+8N8dx0Xuoap1xM
        MjKBy9SK65QSPtvtZe0ZWbDS6DaH4z9nil80gzUvaLsV46e4kzOs8mKCrcLUfbOx
        /Hybut2I8CDYP7OID27ZALVJ45UVLxCHFeFct4xjRYMC1nknVZAr24VdmRewiWHY
        hXPbbXfP7LxHG00ssM+Q8rmN8xvO8KTHriPehyClwF5ZrRZoY/n0a4/9cIa3mB+c
        h6nipdq6Ii+nfWynKdUsbZN96onkevdcHpPvZmd4PtEVYj2+9r+Z2U4xCp3hb3/G
        A4dA4wSa3hNX1x/7kHx2Mfw+pufqvbLei0A==
X-ME-Sender: <xms:qnhbZL9YYegaO6qGWff4Xn0A2xb34U0vKuswd_tkxADCDXL79Ty10w>
    <xme:qnhbZHt_OCEW04lS_K3jlhuNP6jN120R2OW4IT0UJGykIjjavBr1sl1wCPUjt2mpd
    iKDdFR0vu0P4fkOby0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeegiedgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:qnhbZJAhWw5JgD6ceJIE_eQRqx_7BE6awqkGnDFr38jzJXLeAszlQQ>
    <xmx:qnhbZHcWmBIERVA2crB5dc07ZxtSNsybRDEGtgW6AQQGm2Ruypr7xg>
    <xmx:qnhbZAM_6LIIoyF4TdW5Smun8jkrOAE-m2X-ezgJUD0EG7j2YP0L0g>
    <xmx:q3hbZLEa-PLZrqETUKsJK92oLjtZTu16qb_iW3QQsNFSpLf52HFDzg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 3BAD4B60086; Wed, 10 May 2023 06:57:46 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-415-gf2b17fe6c3-fm-20230503.001-gf2b17fe6
Mime-Version: 1.0
Message-Id: <6b35ee35-0567-473c-9f76-d8bdda0e90a3@app.fastmail.com>
In-Reply-To: <6bee2314-043d-e1af-016b-779df88f1868@gmail.com>
References: <20230508025936.36776-1-ychuang570808@gmail.com>
 <20230508025936.36776-11-ychuang570808@gmail.com>
 <2ba483e9-267f-2159-1ea8-75a2618fcdf9@linux.intel.com>
 <eeeaf258-8f2b-436a-aba0-b32dc90b359f@app.fastmail.com>
 <b9573562-d4d7-3535-fb4d-f2bc694f2a4@linux.intel.com>
 <72983689-0e98-4482-b549-ba2530274943@app.fastmail.com>
 <6bee2314-043d-e1af-016b-779df88f1868@gmail.com>
Date:   Wed, 10 May 2023 12:57:26 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Jacky Huang" <ychuang570808@gmail.com>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
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
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_TEMPERROR,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2023, at 03:26, Jacky Huang wrote:
> On 2023/5/9 =E4=B8=8B=E5=8D=88 08:32, Arnd Bergmann wrote:
>> On Tue, May 9, 2023, at 14:25, Ilpo J=C3=A4rvinen wrote:
>>> On Tue, 9 May 2023, Arnd Bergmann wrote:
>>>> On Tue, May 9, 2023, at 12:17, Ilpo J=C3=A4rvinen wrote:
>>>>> On Mon, 8 May 2023, Jacky Huang wrote:
>>>>>> +
>>>>>> +#define UART_NR			17
>>>>>> +
>>>>>> +#define UART_REG_RBR		0x00
>>>>>> +#define UART_REG_THR		0x00
>>>>>> +#define UART_REG_IER		0x04
>>>>>> +#define UART_REG_FCR		0x08
>>>>>> +#define UART_REG_LCR		0x0C
>>>>>> +#define UART_REG_MCR		0x10
>>>>> These duplicate include/uapi/linux/serial_reg.h ones, use the std =
ones
>>>>> directly.
...
>>
>> There is clearly some family lineage, but there are differences
>> everywhere, and I don't think it was designed by extending a 8250
>> compatible hardware block with extra features, but rather built
>> from scratch (sigh) based only loosely on a register description
>> but then extending it with no intent of retaining compatibility.
>>
>
> Yes, the design of this UART IP is indeed incompatible with the 8250, =
but it
> does imitate the 8250 in some register and register bit field naming, =
and
> even in usage definitions, which can easily lead to misunderstandings.
>
> In order to distinguish it from the 8250 and make it clear that it has=20
> nothing
> to do with the 8250, I hope you can agree with me not to use the exist=
ing
> register and bit field definitions of the 8250 in this driver.
>
> In fact, this UART design has been used for more than 15 years and is =
used
> in our M0/M23/M4, ARM7/ARM9 MCUs and MPUs. The MA35 series will also
> continue to use this design. I will add the MA35_ prefix to all=20
> registers and bit
> fields, and make the modifications suggested by Ilpo that are unrelate=
d to
> this 8250 issue.

Sounds good to me, thanks! It would be good if Jiri or GregKH can also
weigh in to make sure they agree on this approach.

On the topic of tty namespace, please also add the change that I suggest=
ed
to pick an unused major/minor number range. I'm not entirely sure about
whether using name=3D"ttyS" is actually preferred here or if you should
pick something else here as well. I see that "ttyN" has no other users
are the moment, though "ttyn" is what drivers/tty/serial/jsm/ has.

Maybe Jiri can also recommend what to pick here.

       Arnd
