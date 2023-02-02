Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 731D26872DC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 02:13:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbjBBBNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 20:13:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjBBBNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 20:13:17 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D6A53547;
        Wed,  1 Feb 2023 17:13:14 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 7E7BF320039A;
        Wed,  1 Feb 2023 20:13:13 -0500 (EST)
Received: from imap50 ([10.202.2.100])
  by compute6.internal (MEProxy); Wed, 01 Feb 2023 20:13:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1675300393; x=1675386793; bh=QfLsF1O5sT
        /gmSokHoHo9s2t1jshMacmGtTiB4l9UAQ=; b=a7w6MKlNWW4oPSerpo9oV2gf+W
        LB4sT68ejtdouSAjpoH+IuoBPATqnxcJzBFAhlHKgabyqD1mMS2ecI2sYl4KrB7h
        juQ0Hxg4Qw+VKmFUQ0Up5S9x9ZjITaekuQrMPnpjGGsUf52v3fbD3EQ802WGMjvJ
        OZtxniJFZEaEZbgTb4Z2g8ZKRV9s5cH195QGVMRNBuejCgxc4JeNcxV9Lw5MRvUF
        6S//RhIw1VwBfUE30ULW+HKb7PNCBWba8sR66+wDwLLxENfCtXGfpW8s761dTfN4
        wi4ilgCZRSQXI4jWKoJy4m2r6kgtmL9+cmpy+hs9j90hwbv4CmWp9axZACsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1675300393; x=1675386793; bh=QfLsF1O5sT/gmSokHoHo9s2t1jsh
        MacmGtTiB4l9UAQ=; b=Upo+msoxxyqhXo6uCWcfsWFmg+9iijrl3/bvmoA5+ZMT
        QagKho9s6GBUyO4d/sVvph+WcGMZpZ5U2B1eWJADclFcZ8eK12u5osyIsdiiO/+5
        E3TVc7iMoYHXglpfd22wd9sVGZUIYKcQh5SKa+USkTUuWVkQcSN9uIhyA+9NoKq4
        ORlRPTwBRx8qlDkhpgiIxYzN7QQaa2ZaTz8I2NP59g/rowACmwbGD0Uwgoq9JFfv
        jc6rS/U7YRQB4/9YoSqupj4Ii0RoSsV0MlvYVejOLZ0Zv0RonSHAN1k6jk/RFi3Q
        Fo+G7XfR46FN1ukwyxUlhm+1lPNQsQtIq87Yl1k5hg==
X-ME-Sender: <xms:KA7bY5rc5j29EyVBKrv11btTVxkm2m8k-9eo9_UrY6xXXJ7BzJnEPw>
    <xme:KA7bY7plbPdGQhBLETcfGfgR5s7BrRf_Qz2pacnp2JoOXm5xOs3cJAmeB28zm0JeT
    sFq0zxRjYNnP5MbQA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudefjedgfeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehn
    ughrvgifucflvghffhgvrhihfdcuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucggtf
    frrghtthgvrhhnpedvvedvieeuteehiefftdfhjeevvdetffevgffhhfeuudffhedvkeef
    veeiueejleenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghnughrvgifsegrjhdrihgurdgr
    uh
X-ME-Proxy: <xmx:KA7bY2PEZMfATTCg1IwmjS8mKs3xIia0yjiadtYenWMSOJpTK82dqw>
    <xmx:KA7bY078f5jo6n2dhWCV-5JEBDVFJ7pFRHpUeAvP522XxmFeHFy5Ug>
    <xmx:KA7bY45FWGP67bdrtONAIdkr4TSmUIO0CBAuHHqGWq6bVGSgov_Jag>
    <xmx:KQ7bY5HM5Gg5_pGdPyWHEcJ_zLYbBhAbkl20GNIuipY-3VqlweAxKQ>
Feedback-ID: idfb84289:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 92F721700089; Wed,  1 Feb 2023 20:13:12 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-107-g82c3c54364-fm-20230131.002-g82c3c543
Mime-Version: 1.0
Message-Id: <206f0e93-059d-4657-8359-0c5080797c76@app.fastmail.com>
In-Reply-To: <Y9ppGn0rLfnA3vz6@enigma.ccjz.io>
References: <20230110042533.12894-1-clayc@hpe.com>
 <7734c165-5918-4677-b8d4-f7d5a3ed37d5@app.fastmail.com>
 <Y9kbsRsRcOnGS0ps@enigma.ccjz.io> <Y9ppGn0rLfnA3vz6@enigma.ccjz.io>
Date:   Thu, 02 Feb 2023 11:42:49 +1030
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     clayc <clayc@hpe.com>
Cc:     linux-kernel@vger.kernel.org, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        verdun@hpe.com, nick.hawkins@hpe.com,
        "Arnd Bergmann" <arnd@arndb.de>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Russell King" <linux@armlinux.org.uk>,
        "Olof Johansson" <olof@lixom.net>
Subject: Re: [PATCH 0/5] ARM: Add GXP SROM Support
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 1 Feb 2023, at 23:58, Clay Chang wrote:
> Hi Andrew,
>
> On Tue, Jan 31, 2023 at 09:46:42PM +0800, Clay Chang wrote:
>> > I'm trying to understand whether we can find some common ground with
>> > controlling e.g. Aspeed's BMCs LPC peripherals based on Arnd's query[1],
>> > but the description is a bit too vague right now for me to be able to do
>> > that.
>> > 
>> > [1] https://lore.kernel.org/all/66ef9643-b47e-428d-892d-7c1cbd358a5d@app.fastmail.com/
>> > 
>> > Andrew
>
> I briefly studied driver/soc/aspeed/aspeed-lpc-ctrl.c, and IMO the
> similarity between HPE GXP driver and Aspeed's could be that we both
> expose the LPC memory addresses or registers for configuration purposes.
> However, the functions to be configured could vary. There are a few sets
> of registers that HPE wants to expose for configuration in the future.

The talk of "exposing registers" feels concerning - we're trying not to 
do that directly. Instead we want to lift out an API that constrains 
the behaviour a bit but works for both of us if there's overlap in 
functionality.

Can you point to any documentation of the behaviour of your hardware? 
It's still a little vague to me.

Andrew
