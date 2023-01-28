Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 443E967F799
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 12:37:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233641AbjA1Lhq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 06:37:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231391AbjA1Lho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 06:37:44 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81330A271
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 03:37:43 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 83DCF3200925;
        Sat, 28 Jan 2023 06:37:42 -0500 (EST)
Received: from imap47 ([10.202.2.97])
  by compute5.internal (MEProxy); Sat, 28 Jan 2023 06:37:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1674905862; x=1674992262; bh=1W
        YzsEiF6F7eedlo4MoLV4jDmB7HCgdWFk6hhb57/gc=; b=IKtbirf16WygvJM5ie
        cpiSJIFNWL+HZOfpAQNo3cpN8KIbjQYkR8GSFMcVoWNGd11vs0w5OPfSzdCZ1gN5
        2n9mxP8QRofdLI5LBQficLVXfLzxp0A0BETRaKbm4uw0ZcjDx0WboOBt4DHHXDUr
        cc71lzx8VSvaZyEIBML/sNuicWJu2YzBozuVYIxL4Htx2SNHXOCoS/bNebi39/aH
        gwFhNkRyN9VZKPKS+gy9YFLTj48NUZjoHOBok0esXyTfLfm7f7KPoJuOPEAxIL8u
        za+b1LzsIu4XqOPfDB/39qkxlCs1NqqJ9QFB89tv2b8oaCjasFROvohMysFrKuX+
        ieGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1674905862; x=1674992262; bh=1WYzsEiF6F7eedlo4MoLV4jDmB7H
        CgdWFk6hhb57/gc=; b=DhfATTtWhrucCQW8gF5pA7JQ3LmkjmsNlc/W3dSCvIuh
        9I/gx90ev8jrj1EmKz1Fl4WXD+USIm+glcrbXKN8gQGDzmDw2mmo4n5egFMqek2E
        5eti8JW6wMfakQmYD7+WfIn0CGqoZ9dPQX0r8BKZpuBhDCSJZn11wjB6d9a2dAag
        pDs/IrT9xakpL6dAv1OU9zzdkmXQZeePpG5bLztU0ucYqFV453pzD/jkj0Q9ndHh
        oKubpz8OYlKAIEsb6ag8tvoHm3lr0JunZKogJ/7xCXg1+eGWdWvCSIoZ9OOgw0JA
        /bylGrbC1nnP2Yna8Q5P8TI0rzVZhd4rJLBdR0MEBw==
X-ME-Sender: <xms:BQnVY8UKLdpXjA7tBSwaetUuZbZ0Jx-Rin3Kd2UVXNZdeS_Qx37KIw>
    <xme:BQnVYwmwbGiCmGeNdgm4OwDq5M_kyOVBI1q11L9Rwu3Mu7w1gcLpDQL5LP7bNGf-N
    0o36-ZYRcHtfRDy8qY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddvkedgvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfufhv
    vghnucfrvghtvghrfdcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrf
    grthhtvghrnhepleevgfegffehvedtieevhfekheeftedtjeetudevieehveevieelgffh
    ieevieeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshhvvghnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:BQnVYwZiGypPgpoXhZN0jTdYAFCeDocQKzLQJ1zRIiWkXzOy1H2ICA>
    <xmx:BQnVY7WMJV7GYZWce4O04oeuo2hJTwPUEYJcdc6d4Pbc5g6WS1m2DA>
    <xmx:BQnVY2lLh7uslex5jtKtn4q1fSPh-Rw8ll5N9LZx60V0UZsm02Q1Gw>
    <xmx:BgnVY4iNMbznObNnonZvI2Bect-Pi6Xvv7CJ9FtKNphQQBkJYKJ41A>
Feedback-ID: i51094778:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id B8ED6A6007C; Sat, 28 Jan 2023 06:37:41 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-85-gd6d859e0cf-fm-20230116.001-gd6d859e0
Mime-Version: 1.0
Message-Id: <6551d88b-4aec-4ef9-9de6-9ed8255a50d5@app.fastmail.com>
In-Reply-To: <20230123065354.28179-1-marcan@marcan.st>
References: <20230123065354.28179-1-marcan@marcan.st>
Date:   Sat, 28 Jan 2023 12:37:20 +0100
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Hector Martin" <marcan@marcan.st>
Cc:     "Alyssa Rosenzweig" <alyssa@rosenzweig.io>,
        "Janne Grunau" <j@jannau.net>, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: apple: rtkit: Add apple_rtkit_idle() function
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2023, at 07:53, Hector Martin wrote:
> This is yet another low power mode, used by DCP.
>
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---

Reviewed-by: Sven Peter <sven@svenpeter.dev>


Sven
