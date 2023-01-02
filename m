Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0FA65AE20
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 09:30:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231846AbjABIav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 03:30:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231949AbjABIad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 03:30:33 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 501C625F5
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 00:30:31 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id C7C1E3200913;
        Mon,  2 Jan 2023 03:30:28 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Mon, 02 Jan 2023 03:30:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1672648228; x=1672734628; bh=71n8oqUeqp
        +nXbKCPCaVDE0spfo0v3obD01TQKeJVbg=; b=GFc0WldkoNQyEL6S5jn/xBQFyh
        Pr/bbu+tXrSmMdkwIzvYM2uoRzZ9LTnNqtQvyf9ap5VniZn01f0xPHo2BPQqS4Aj
        qxM6pNpcGqZvBiSLw7oyc2bUcKJFcEdJx3ehKwwdHkg5Z40T6g5dk9uCYQqwFEKH
        mpxnPRBJrDXY0s+wkirDIuRv9XvBv41gPJrMbhRuPH9MdBbTFyp+KkSrVsTcBSUU
        3k/6zV/NwOpFaMv4NNQg+ACu9P8mY3r81UsIUmFPeRLfkHRRMH/JtJcL27hokcW6
        PvJva4fN2s8AUCdTQKRrjtLzOKMeCeDQGatWjhR4iVyI6p5XG5+1fA/MpTtA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1672648228; x=1672734628; bh=71n8oqUeqp+nXbKCPCaVDE0spfo0
        v3obD01TQKeJVbg=; b=KWIHl8QkHDxXsADfexp46vcydJHbvm5s4dCkLUsevXhd
        5M1FQEKJjXNCccycAbYjLWn/xYW7HRpYMGZFmOdyUkSdhx82DfrY+MLNHNM0fxpw
        +aWjYKHcnMZfkL8DBmrblgIAm4K6WVuMY+4E7irMZM9GAKkQceWeW1+WgKUMnPBC
        O/YHipMSRU9/JzqH3AsgjY8FqEriU/dv53mZiOvEg5v1WvrjDk9nMb7Epd6jfyJw
        mN6xL8GheKf0qXDZD8rsc2v2mCXF8agW2sWi42qheMfg0whxx9IaWdxoqWk5ExSz
        6X5eVBzI8FME23sm6u0Jlsqm5LeS4hyxEJc8e6C6nw==
X-ME-Sender: <xms:JJayY5O4_wzxw_x7hSwWeoJCYAF5nMsc0jlv83rsXwAdIcANHCoXow>
    <xme:JJayY7_ELzJXEFJ_U3605y0_1_xniG_-6SubdiE7PmlrUTFHX_4xzSnzRUn13jFyq
    vw7G-XmLl9EqVlv1WE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrjedugdduvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfgjfhffhffvufgtsehttd
    ertderredtnecuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegr
    rhhnuggsrdguvgeqnecuggftrfgrthhtvghrnheptdehjeeuieejkefhgefhfeejieduhe
    ekgeetjefgjeehleeuteejkefhgedtjedunecuffhomhgrihhnpehmohhnthhjohhivgdr
    ohhvhhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:JJayY4S3jkLQ5lqppx74PCLQElLu-gC_V2tB4O0LIKm4CllZUjW3AA>
    <xmx:JJayY1snOHpW-X5A1TgUROi1Hehwv252O8GerrsGBRPA9-0oz9Twlg>
    <xmx:JJayYxdIbOvtWawAVtA-3LtA2XOA5lIAc9RW175RHIyXjzE5sOKedg>
    <xmx:JJayYxnBweLDTn-EjHIzpPy40BazF4QE16S4EEUIZYCSNHmPW0SCJQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 230A2B60086; Mon,  2 Jan 2023 03:30:28 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1185-g841157300a-fm-20221208.002-g84115730
Mime-Version: 1.0
Message-Id: <52ec1b11-4756-4396-866b-6250c6018f93@app.fastmail.com>
In-Reply-To: <Y7HMfUTjuWC+Zudk@Red>
References: <Y7HMfUTjuWC+Zudk@Red>
Date:   Mon, 02 Jan 2023 09:30:07 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Corentin Labbe" <clabbe.montjoie@gmail.com>,
        "Dominik Brodowski" <linux@dominikbrodowski.net>,
        linux-kernel@vger.kernel.org
Subject: Re: pcmcia: ti: regression cannot get IRQ
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 1, 2023, at 19:10, Corentin Labbe wrote:
> Hello
>
> I was trying to boot again my old compaq armada 7400 laptop and the 
> network card is unusable.
>
> Last known working kernel is 4.16.18.
> First known bad kernel is 4.17.19
>
> The interesting log is:
> [    3.503348] yenta_cardbus 0000:00:0c.0: ISA IRQ mask 0x0698, PCI irq 
> 0
> [    3.503442] yenta_cardbus 0000:00:0c.0: Socket status: 30000006
> [    3.505250] yenta_cardbus 0000:00:0c.1: CardBus bridge found 
> [0e11:b048]
> [    3.505370] yenta_cardbus 0000:00:0c.1: adjusting diagnostic: 60 -> 
> 00
> [    3.505457] yenta_cardbus 0000:00:0c.1: Using INTVAL to route CSC 
> interrupts to PCI
> [    3.505554] yenta_cardbus 0000:00:0c.1: Routing CardBus interrupts 
> to ISA
> [    3.505556] yenta_cardbus 0000:00:0c.1: TI: mfunc 0x00000000, devctl 
> 0x64
> [    3.505556] yenta_cardbus 0000:00:0c.1: TI: no PCI interrupts. Fish. 
> Please report.
> [    3.505556] yenta_cardbus 0000:00:0c.1: no PCI IRQ, CardBus support 
> disabled for this socket.
> [    3.505556] yenta_cardbus 0000:00:0c.1: check your BIOS CardBus, 
> BIOS IRQ or ACPI settings.
> [    3.632323] yenta_cardbus 0000:00:0c.1: ISA IRQ mask 0x0698, PCI irq 
> 0
> [    3.632416] yenta_cardbus 0000:00:0c.1: Socket status: 30000020
>
> Full 4.16.18 log is availlable at: 
> http://kernel.montjoie.ovh/zoo/armada/dmesg-4.16.18.txt
> Since 4.17 (and 4.18) is stuck sarting init, I have log for 5.0.29
> Full 5.0.29 log is availlable at: 
> http://kernel.montjoie.ovh/zoo/armada/dmesg-5.0.21.txt

I see you hit this code path:

        if (!socket->cb_irq || request_irq(socket->cb_irq, yenta_interrupt, IRQF_SHARED, "yenta", socket)) {
                /* No IRQ or request_irq failed. Poll */
                socket->cb_irq = 0; /* But zero is a valid IRQ number. */
                timer_setup(&socket->poll_timer, yenta_interrupt_wrapper, 0);
                mod_timer(&socket->poll_timer, jiffies + HZ);
                dev_info(&dev->dev,
                         "no PCI IRQ, CardBus support disabled for this socket.\n");
                dev_info(&dev->dev,
                         "check your BIOS CardBus, BIOS IRQ or ACPI settings.\n");
        } else {


The "socket->cb_irq" is just the device IRQ, which is originally
set to "11", and this one appears to be shared with all the other
PCI devices:

[    2.402035] ACPI: PCI Interrupt Link [C168] (IRQs *11)
[    2.403507] ACPI: PCI Interrupt Link [C16C] (IRQs *11)
[    2.405461] ACPI: Blank _CRS EXT IRQ resource
[    2.405546] ACPI: PCI Interrupt Link [C16D] (IRQs 11) *0, disabled.
[    2.407578] ACPI: Blank _CRS EXT IRQ resource
[    2.407663] ACPI: PCI Interrupt Link [C16E] (IRQs 11) *0, disabled.
[    2.409610] ACPI: Blank _CRS EXT IRQ resource
[    2.409695] ACPI: PCI Interrupt Link [C16F] (IRQs 11) *0, disabled.
[    2.411647] ACPI: Blank _CRS EXT IRQ resource
[    2.411733] ACPI: PCI Interrupt Link [C170] (IRQs 11) *0, disabled.
[    2.413690] ACPI: Blank _CRS EXT IRQ resource
[    2.413775] ACPI: PCI Interrupt Link [C171] (IRQs 11) *0, disabled.
[    2.416055] ACPI: Blank _CRS EXT IRQ resource
[    2.416140] ACPI: PCI Interrupt Link [C172] (IRQs 11) *0, disabled.

If any of them try to get the IRQ as non-shared, then the cardbus
one would fail. Do you see anything suspicious in /proc/interrupts?

     Arnd
