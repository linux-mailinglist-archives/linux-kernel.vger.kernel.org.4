Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA08A731D81
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 18:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbjFOQMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 12:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjFOQMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 12:12:03 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A27219B5;
        Thu, 15 Jun 2023 09:12:02 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 454455C00E0;
        Thu, 15 Jun 2023 12:11:59 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 15 Jun 2023 12:11:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1686845519; x=1686931919; bh=lH
        VIyGJZwQS/ccpsXhg4DiZBGnwWrcAVNBqEwRIBymY=; b=qx9b2YnF22o7BTBU6c
        wPvv52FoKIQi6NZwVUQiXnBjYmPIdS6sUykEGDFA3Z2gZ7YZKqo44XZAmTBqfwQL
        Op3nd3Nm9Hw45SMphvKjSLFXSD4gMFJbkRH6U3djb0/9YNByRtoMlxFzxDQoEoV5
        PTMNoCgcpdJpCbmAlA6nTfRBUB0prkTGG1T1TPy37dlARa9bILaO2mgwTMk94/o7
        m8areMmDxQRhUQH9WIXqnKfLqbEUR7OcQvcLd11I2Rdj5h0afp80iC6eQZnmAu9z
        F69XMrnr9NiGpMWaaqumUr321hIq1yaQQcOu3R10kzTV34sAwRe0AUkbl3qlApER
        X8EA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1686845519; x=1686931919; bh=lHVIyGJZwQS/c
        cpsXhg4DiZBGnwWrcAVNBqEwRIBymY=; b=KwNQpUWnShH4M58lpUU6/3m+GZkTH
        nlIe1cv/fTjc2oAdYcp8ODnc0Abrq07vQ/3Yu7CFE88TlGFY7+gak50SAM/5Zs6f
        13aicZmcf/fah/KbUd8uLgaYz1iy8vZAY6Ko8EflGnHxu7bbIt5mf213D8OfWs54
        CClTnHm5YLJjrUEmHXK/kbyfR7XuxkWrEcG2ugwnUDPXmNdPG7e6zns6Vbv0ogeM
        QVzHc8pWMCY7FoCxDagWn/jPj9HxRH/InGH6m+ly6yvnLQWNlqpnEyOVOM50Q3Hj
        DQGDblBFEkLh4OOFA6XE84QZuV75jZc+zvr9YmihYpgz76KUENuAMpWTA==
X-ME-Sender: <xms:TTiLZJibKNQYeR_IndCVQSaXNK4rEwjSpLSiyGTR-SRtW9G_PmaEeA>
    <xme:TTiLZODrKlnHdCNH_Qj7ervH9FZEIWa57w-jQISwUrfbYSCcEV9mvsgtNNmZrTE4Y
    0GpquwDfGXEpfQfTH0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedvvddgleegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:TTiLZJEGEjHlTBV_JloqUdTfC34Uo9uvwZ-QvDMULff8IugVXdnBIw>
    <xmx:TTiLZOR9Iiclb7POQIIYA0OWA7C1rMGKxYKVCCG7YAATMJFjN2VQzA>
    <xmx:TTiLZGw2PqlP9s94FpC254UO9Vb-YMMm6knqeVTXswTDtZsDdnRjBQ>
    <xmx:TziLZHoqNn-s_2B_cpw36QAVcMDGTJU73T1qjGgkgc42xHqwL1xaIw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 6F379B60089; Thu, 15 Jun 2023 12:11:57 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-496-g8c46984af0-fm-20230615.001-g8c46984a
Mime-Version: 1.0
Message-Id: <9fecce53-fc7d-4783-9e05-509b1b418589@app.fastmail.com>
In-Reply-To: <2023061500-tipper-tightwad-8843@gregkh>
References: <20230612025355.547871-1-ychuang570808@gmail.com>
 <20230612025355.547871-2-ychuang570808@gmail.com>
 <2023061338-lunchbox-snorkel-e6a9@gregkh>
 <f8eb6114-8248-8886-b301-c2886e50e016@gmail.com>
 <2023061356-matchbook-footwear-d142@gregkh>
 <35e768ad-7f15-48a4-9c38-09570026cf71@app.fastmail.com>
 <2023061555-enlighten-worshiper-c92d@gregkh>
 <502240f7-2cac-4fe6-9e27-f9861db3666d@app.fastmail.com>
 <2023061500-tipper-tightwad-8843@gregkh>
Date:   Thu, 15 Jun 2023 18:11:36 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     "Jacky Huang" <ychuang570808@gmail.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org, "Lee Jones" <lee@kernel.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        "Stephen Boyd" <sboyd@kernel.org>,
        "Philipp Zabel" <p.zabel@pengutronix.de>,
        "Jiri Slaby" <jirislaby@kernel.org>,
        "Tomer Maimon" <tmaimon77@gmail.com>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        soc@kernel.org, schung@nuvoton.com, mjchen@nuvoton.com,
        "Jacky Huang" <ychuang3@nuvoton.com>
Subject: Re: [PATCH v14 1/1] tty: serial: Add Nuvoton ma35d1 serial driver support
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023, at 17:00, Greg Kroah-Hartman wrote:
> On Thu, Jun 15, 2023 at 04:01:55PM +0200, Arnd Bergmann wrote:
>> Since the number is exported to userspace in serial_struct,
>> it might be better to pick a new constant such as
>> 
>> #define PORT_SERIAL_GENERIC (-1)
>> 
>> in order to be less ambiguous. It's a signed integer, so -1
>> would work here this would clearly be a special value, or
>> another option might be to use 255 as something that is
>> slightly less special but still recognizable as something
>> that may have a special meaning.
>
> A new constant would be good, 255 is nice, and then we can move everyone
> to use it unless they can specifically show a reason why it will not
> work for them.
>
> I think originally this was used to do device-specific ioctls, right?
> That shouldn't be happening anymore, hopefully...

The only thing I could find is that you can use TIOCSSERIAL to set
the type between the supported types within a driver, which changes
the behavior in some cases, e.g. the exact size and layout of the
register file or its capabilities.

We may need a proper audit of TIOCSSERIAL anyway, I suspect there
are worse things you can do with other settings.

       Arnd
