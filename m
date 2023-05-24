Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBAC770F1A1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 11:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240502AbjEXJA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 05:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236330AbjEXJA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 05:00:26 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F7E8E;
        Wed, 24 May 2023 02:00:25 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id CE7B25C02B7;
        Wed, 24 May 2023 05:00:24 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 24 May 2023 05:00:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1684918824; x=1685005224; bh=S7sa8C/IogYZURJrOm0ZDAiU3OBbB8qNXQm
        tRKL6Fb0=; b=HZKgHz3rqNYJ2Pw2wrGOpbUOIDA/IOAgTV784ojJJtvpSFQIj10
        8qTDsUtYq8lLue6pSLuU0AKRdGj8vejKNrdfdMfAmpWhh8pG+RzEkpPpBUdEVivD
        Wig/sXjJbIH4DfPUMxXs4OaxlQNtuj0OfBonnlO0laVhGgx6NqSrRwgP9uQ9O6MU
        VDKrC24b2sAwDNuQe7GgUT9lsggeJGDTlgVY9rlS7KMTR0GIvSukUYLSWdWOeuaI
        hlBF0YtAnNGm1EfHiJlwP/75vOdgyNyKMlT8emi99bcEnAF4c8yKL0wKBIkXz7R6
        ZkJp7/2gMenWnwgulnYpEhTpvRGRV/3JQ9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1684918824; x=1685005224; bh=S7sa8C/IogYZURJrOm0ZDAiU3OBbB8qNXQm
        tRKL6Fb0=; b=p9n89m5rSqqp+mY4RDK1NFs2zf98lBIc8CeA3dU/0VKMZ7Qw86P
        ksW9Xf+jjGAxJxWXKlY4l/lJ3YNFzPTrtaSSosKEen3k11nXsqzx3NLAlijir1uZ
        7UvAcnSJKDcr11zux9/uGh52TnjzqgQI9l9Vg6X7Hw5oLzQGATQoSTU3F3jyMP2I
        NSdyBTtut4qnrnwk4tHRVCl8w02n0qeuXS9coLBsrjRCg5jBVl0T9AuVRSVVWiF6
        1O0M/6z3+BBNjn/8wDBtyIgD3oeENXAzvR2R0XJa6rVYY+wVIjF6mE3f9kXEXh2H
        yNC+29I76uPDb66Fob6VAwWbYkDDrgp7Q5A==
X-ME-Sender: <xms:KNJtZMPPd-OUVctrSMtu6gC_Wj2ea8HS-Scn1-0rMeC0-leHJYPFiA>
    <xme:KNJtZC_EZmiDOhgUVt0HFihP2Mr2muE4qaHOLCV1md5NfFpNwzPOFtvJJsXEN4ZRQ
    Dk5XxOyoEdoT1ePjL8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeejhedgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpefgkeeuleegieeghfduudeltdekfeffjeeuleehleefudettddtgfevueef
    feeigeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:KNJtZDQauFxY19YxAr7s2-7N5d1NzWWUW0NdVA4pLmUpJ4vUbjkOVQ>
    <xmx:KNJtZEtMwWa0CTxIzqV9LHZyznmkP0crMbnONb6f240qugw1cG4sdQ>
    <xmx:KNJtZEeiQAbGIAB1oGeRFC0MSADUaMjEEt8gCtYTdKVOX3a9cmvHYA>
    <xmx:KNJtZHWbuShUGGLuk0n7ehdbI6bgUuC5auJISleEu21SrAe-0_dUcA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 0B98CB60086; Wed, 24 May 2023 05:00:24 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-441-ga3ab13cd6d-fm-20230517.001-ga3ab13cd
Mime-Version: 1.0
Message-Id: <e312b861-a5cc-43b0-b2b0-7d66f47a3d0b@app.fastmail.com>
In-Reply-To: <aaef529f-69dc-8bec-0ae1-959a1ede87e0@gmail.com>
References: <20230516075217.205401-1-ychuang570808@gmail.com>
 <20230516075217.205401-11-ychuang570808@gmail.com>
 <3d4acb20-c80e-fd39-c0d0-e9b1e0309d81@kernel.org>
 <aaef529f-69dc-8bec-0ae1-959a1ede87e0@gmail.com>
Date:   Wed, 24 May 2023 11:00:02 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Jacky Huang" <ychuang570808@gmail.com>,
        "Jiri Slaby" <jirislaby@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org, "Lee Jones" <lee@kernel.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        "Stephen Boyd" <sboyd@kernel.org>,
        "Philipp Zabel" <p.zabel@pengutronix.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Tomer Maimon" <tmaimon77@gmail.com>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-serial@vger.kernel.org, soc@kernel.org, schung@nuvoton.com,
        mjchen@nuvoton.com, "Jacky Huang" <ychuang3@nuvoton.com>
Subject: Re: [PATCH v11 10/10] tty: serial: Add Nuvoton ma35d1 serial driver support
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2023, at 10:34, Jacky Huang wrote:
> On 2023/5/24 =E4=B8=8B=E5=8D=88 03:42, Jiri Slaby wrote:
>> On 16. 05. 23, 9:52, Jacky Huang wrote:
>>> +static void ma35d1serial_config_port(struct uart_port *port, int fl=
ags)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 /*
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * Driver core for serial ports forces a no=
n-zero value for port=20
>>> type.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * Write an arbitrary value here to accommo=
date the serial core=20
>>> driver,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * as ID part of UAPI is redundant.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> +=C2=A0=C2=A0=C2=A0 port->type =3D 1;
>>
>> So this 1 translates to PORT_8250. Why not to use it directly? Or=20
>> something more saner like PORT_16550A?
>>
> It's not actually 8250 or 16550A.
> Can we add the following definition to=20
> 'include/uapi/linux/serial_core.h' and use PORT_MA35 instead?
>
> #define PORT_MA35=C2=A0=C2=A0=C2=A0 124

This was already in a previous version, until Greg commented
that it was probably not needed:

https://lore.kernel.org/lkml/20fc81c9-5517-ce1e-639a-3b425cf27759@gmail.=
com/

Since leaving port->type at PORT_UNKNOWN doesn't work, and almost
all other drivers have something in serial_core.h, it's probably
best to do the same here. Checking the other drivers showed that
drivers/tty/serial/lantiq.c is currently the only exception, it
defines PORT_LTQ_ASC locally, which causes a conflict with
PORT_SPRD.

    Arnd
