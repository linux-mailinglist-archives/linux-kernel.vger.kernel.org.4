Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94BBB6BD247
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 15:23:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbjCPOX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 10:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbjCPOXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 10:23:24 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C9226CD4;
        Thu, 16 Mar 2023 07:23:22 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 4D11A5C0114;
        Thu, 16 Mar 2023 10:23:22 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 16 Mar 2023 10:23:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1678976602; x=1679063002; bh=wo
        uBF1QhdapPSQlIt+AypAOmdCLJ4gnTYz03amI7Xwk=; b=RZG4EvLiMEPQbVe5kv
        u499NhsuLf8rem76YmTUMbE391TdkcHR6+75r9/BLV90lH3uSK2EhGV7eOOeaVat
        6G6oq728X+yJCEDJnpoiPOYBNmclSiSpcjOZP5r+veUBe84+Ux/HrSHk1C6J54ZM
        U9aGICB1kvX3TvrDaeQC566hPpbH1QrYEEnpJYUTWlJJ3J33ATGEPE8jmzOaLDrf
        Amv7Ck3ngexltDrbedgNdbTrCn6aJ/3TV9gUuX1B+3aM2s9M29jqn1TDMJDbik5Z
        oBWfu45a4xBoJhpGR9oop5ONiGK6P4nxsFU2pIqYAaUz+t+5FVMpQrQrC2UeH2r5
        kH/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1678976602; x=1679063002; bh=wouBF1QhdapPS
        QlIt+AypAOmdCLJ4gnTYz03amI7Xwk=; b=g8TzCD5szksR/FswTGM2JDvN/MWYF
        8L9Xp4X9+mIPOjkJXi5qxbEBpMkWddFMmsgI228+2w3t/QCzebnxbN/ZuJ1txhjL
        bVrF+qOKxEcSwsKYwTo8UKflxFn7sntBb0rIGeiL5kCW009kcHckI0bPbJGh2Npv
        xB7A39ESRiwsOr4gWYfrZqqWXkUudIEgIH8Egzl/gGzdjGWl9WE8i76PQPecgPBJ
        /WQsdZ0UlocaaO21YKyIcK+XB2gsvMQYcA8UvaST2cSa3VQxuKabss6M3KOLcuCX
        cgLckkKwrMY8czI67hX+pR6yLqLQNIC7cDo50zXf8puYkX3c55MCNnDUA==
X-ME-Sender: <xms:WSYTZBJsOk0xkFer_nc2gS2reOjWRO1TMje_eLGE-WyhwoCSfyHPXA>
    <xme:WSYTZNJLhuO2oAVQUsT4te_s5Er8NSxUg91ypTg4xwoi59YSZxqsq7mwQsg5pJqLt
    3oQhCSoJgh8RVEF8tg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeftddgieegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:WSYTZJtMRYEOeVFmeMuZZyPXG1xGmQWaRpumpRPzAIsOMgS3b2YwaA>
    <xmx:WSYTZCZMHJuB37K3VVHfYh6X1gM6nhim406-sMmb7GUrGjqSaAc7Fw>
    <xmx:WSYTZIZUwtoxP2c5f10Y9a7yl9sxqy1DsuuYq9mhRbQw8iL1Yb6ISA>
    <xmx:WiYTZERZ0WIoc4VgS7hSAp6yp-m3TXBuPJJvD7nAgWM-0UQnMLyMzw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id BFD08B60089; Thu, 16 Mar 2023 10:23:21 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-221-gec32977366-fm-20230306.001-gec329773
Mime-Version: 1.0
Message-Id: <44c5fe37-be74-4fb1-802a-8cf8c813ec96@app.fastmail.com>
In-Reply-To: <20230315072902.9298-3-ychuang570808@gmail.com>
References: <20230315072902.9298-1-ychuang570808@gmail.com>
 <20230315072902.9298-3-ychuang570808@gmail.com>
Date:   Thu, 16 Mar 2023 15:23:01 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Jacky Huang" <ychuang570808@gmail.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org, "Lee Jones" <lee@kernel.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        "Stephen Boyd" <sboyd@kernel.org>,
        "Philipp Zabel" <p.zabel@pengutronix.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Jiri Slaby" <jirislaby@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        schung@nuvoton.com, "Jacky Huang" <ychuang3@nuvoton.com>
Subject: Re: [PATCH 02/15] arm64: defconfig: Add Nuvoton MA35 family support
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2023, at 08:28, Jacky Huang wrote:
> From: Jacky Huang <ychuang3@nuvoton.com>
>
> Enable basic drivers for ma35d1 booting up support: architecture,
> device tree, clock, reset, and uart.
>
> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>

The description does not seem to match the actual contents,
which only enable the platform but none of the drivers.

It's ok generally to enable options in the defconfig file
before you add the drivers, but if it's all part of a patch
series, I would probable more this bit to the end.

     Arnd
