Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11E1E731ABE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 16:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344854AbjFOOC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 10:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344834AbjFOOCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 10:02:20 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB2E1FCC;
        Thu, 15 Jun 2023 07:02:19 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 3A0905C00D8;
        Thu, 15 Jun 2023 10:02:17 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 15 Jun 2023 10:02:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1686837737; x=1686924137; bh=eY
        CsNbwSpZasMtX08Ox/O4cr7nckW5aMGHyiTHaMEvU=; b=vOzobmNPGCa6Mb+YMn
        asY4+o4H7LWFlBlorgzjotB25hUrMvqvukGFrvIOFTYkNkmBCFfkfYb7X6imkzfn
        sML3mf0MEl+OOFAzv6L0+9AuUaTQic/O3l7J/Um+a/XK/7TQ3dK9jE23HkDJV3Vs
        tDR4Cptq7Fgq6dS47eJsrpRHBCMYlX0sI0Td+Q7oFfoVuMaf0cMmk4mZGTrOZpYO
        0rMG2r1EEBy5j9jm1bkbitkBDqQTPnwcL4WNXUNHHbhTVXFMjTwseb2LBCgUEp/1
        +s+r4qww3/aMPqDMeUtP5In77D7fY0JN1JnDwlhLQ//7UetfJyigloRfTgfH3qFG
        V+Fg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1686837737; x=1686924137; bh=eYCsNbwSpZasM
        tX08Ox/O4cr7nckW5aMGHyiTHaMEvU=; b=RSjrdEsgeakMj9X0uhMrA2PN8j4Rw
        pWXc64Yh1QUJkZeWJkSnJ0wQsjdXWC/3XpGIHvmkTcOdt0VT+5p3Xd6K+WSijJZD
        P9QRahEgKUIIR6zj5ENb/as3xq4x6AqDJw4/GMYKH7b+N/YNAtxKum1MSPXLflPG
        m+HlPmtoy7O2mEY7LLNS57KYNliFt1xshKmL9IOluY5EiwB7aXhrahSgQhyPoY5q
        6VwOrvtNtqhDyTOc2qBbMDmGt9vkhZgEglyYMXiiMxdFV2KpT+lH4lAnZz1lUxWM
        W0mHLLlOQST/9FfJJb2bpnMmrnrSx7xM+VZOqpQpE1UAmfOmbdFqxZq5A==
X-ME-Sender: <xms:5xmLZKCYyHW13ObS6w0LD32bRjVKIvAyUoxIfkLUbwHtvZxyxzeB4A>
    <xme:5xmLZEjY_hphZXlP1bRPz0opQcFXjc-eW38HI_E3PzOCKDizjqRXwR1xD4qSwCSeq
    VcGMqtko0gNCR47e-Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedvvddgieejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:5xmLZNkekz6_0Xug5GdmBYkGf7aRRh9mTOIPN1FfLVJMFhxt3vwz8Q>
    <xmx:5xmLZIyESrV9s75tfwvOAsFrQB5NyxdP7_8qsaRcPkjS3Q4Pnc6FtA>
    <xmx:5xmLZPT7I_mIrWmX-DvFqlb4-GewBZkZk_6P1avaIqcMyNV5RSAH8w>
    <xmx:6RmLZALLJEV_J5Zlse85sRbLxpAvhdWEEI0sUeczWEi-Hx4Bd32Kig>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 6F440B60089; Thu, 15 Jun 2023 10:02:15 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-496-g8c46984af0-fm-20230615.001-g8c46984a
Mime-Version: 1.0
Message-Id: <502240f7-2cac-4fe6-9e27-f9861db3666d@app.fastmail.com>
In-Reply-To: <2023061555-enlighten-worshiper-c92d@gregkh>
References: <20230612025355.547871-1-ychuang570808@gmail.com>
 <20230612025355.547871-2-ychuang570808@gmail.com>
 <2023061338-lunchbox-snorkel-e6a9@gregkh>
 <f8eb6114-8248-8886-b301-c2886e50e016@gmail.com>
 <2023061356-matchbook-footwear-d142@gregkh>
 <35e768ad-7f15-48a4-9c38-09570026cf71@app.fastmail.com>
 <2023061555-enlighten-worshiper-c92d@gregkh>
Date:   Thu, 15 Jun 2023 16:01:55 +0200
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023, at 12:19, Greg Kroah-Hartman wrote:
> On Tue, Jun 13, 2023 at 05:44:23PM +0200, Arnd Bergmann wrote:
>> On Tue, Jun 13, 2023, at 16:49, Greg KH wrote:
>> I don't see how Jacky can come up with a patch to do this correctly
>> without more specific guidance to what exactly you are looking for,
>> after the last 123 people that added support for a new port got
>> that merged.
>
> I keep complaining about this, when I notice it.  Just use the "default"
> port type in the serial driver and don't add a new type here and it
> should just work, right?
>
>> I checked debian codesearch and found only three obscure packages that
>> accidentally include this header instead of including linux/serial.h,
>> a couple of lists of all kernel headers, and none that include it on
>> purpose. I agree that this header should really not exist in uapi,
>> but the question is what exactly to do about it.
>> 
>> Possible changes would be:
>> 
>> - add a special value PORT_* constant other than PORT_UNKNOWN that
>>   can be used by serial drivers instead of a unique value, and
>>   ensure that the serial core can handle drivers using it.
>
> Why do we need a special constant?

The "default" value is 0, which translates to PORT_UNKNOWN, and the
serial core code prevents this from working. I think Jacky tried
to use this the last one or two times you commented on it, and
it did not work.

Setting it to a plain '1' as Jacky suggested in his reply is the
same as PORT_8250, which may or may not be a good choice here.

Since the number is exported to userspace in serial_struct,
it might be better to pick a new constant such as

#define PORT_SERIAL_GENERIC (-1)

in order to be less ambiguous. It's a signed integer, so -1
would work here this would clearly be a special value, or
another option might be to use 255 as something that is
slightly less special but still recognizable as something
that may have a special meaning.

      Arnd
