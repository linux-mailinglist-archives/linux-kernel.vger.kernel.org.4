Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A91066A1B27
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 12:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbjBXLKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 06:10:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbjBXLJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 06:09:44 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB2EF129;
        Fri, 24 Feb 2023 03:08:49 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 54AB33200937;
        Fri, 24 Feb 2023 06:08:48 -0500 (EST)
Received: from imap47 ([10.202.2.97])
  by compute5.internal (MEProxy); Fri, 24 Feb 2023 06:08:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1677236927; x=1677323327; bh=KK
        c/e3/c+gUAR7YNhfs2iVKf3/8vMlHu6FvoTx1kM0Q=; b=h3dkd95IaDHrMsar4P
        5ZfIW5JSTdVRQy6z9xoYkUnzJYg7yPofrxkbnJZBMmFpc3ZbT9NQq3++zQJqy8w0
        +NmBryomuKiXCoJ/UPf6uYvAF1R4nDAsf6PflW27PkGFe56kLQ3wuyfDnH/5y4Y0
        sk/3fVHzgy2qmtmaH8HJ9u1zFehPVH94gxoIOU7hmB2y11ZbEI3sSjO2JbRmAIyK
        WH56iCUQVH1Ut2awz8eBSLwtC4/m6/x4hKjXIFGlA7oCbzcxL0cJnufMIV/p7Cvk
        K4njz/oFFBvHveT5bVuIryzCZr5YrBweGgzF1QhA98/AOCUud7lN+17TEe8buxwv
        xHrw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1677236927; x=1677323327; bh=KKc/e3/c+gUAR7YNhfs2iVKf3/8v
        MlHu6FvoTx1kM0Q=; b=IM3O6FDRpepQ373V6L66WQMSxqTavvHfvd85D74fenGy
        0LOIFKbStaLCwMTL0bJ3dbx1sgCObgugiOKdPrmduKqFRLrvawsnxXCp+c9npW4B
        +z8BzzYSEnnZwJrakTBSwRojiAqdgb1lLtcxiSRvAPkMlsKgR+SoMnZYFjt3y52W
        XsFQKkifcEMjMX/DHnlqEvujTTl9FH5Z9cp/0OUb8e4Sy7X95gzx2AxQHie7IYjd
        YFDwcz0+ZXdyCNbfmYRJf4qL10Bn0DpJeVGuYHyzYM2sGRgeABjj/O26Il/fxgGC
        q3LZJknveJzISIGJbDZ52M9FuPTMiUZWtrsqsLF/6g==
X-ME-Sender: <xms:v5r4Y7eOL4GPuMpw9qjBwM6NpdS0TmMdyG9C5SAKAMp_7WwOGDSPbg>
    <xme:v5r4YxNKIkZPx7ZbP9s8XBjCCOG0hFsJjnDPKwGLuKaZy5DqdGUbPK4Ztm7YOb4Xz
    aOGqZTvIve-xX6Og5U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudekfedgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfufhv
    vghnucfrvghtvghrfdcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrf
    grthhtvghrnhepleevgfegffehvedtieevhfekheeftedtjeetudevieehveevieelgffh
    ieevieeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshhvvghnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:v5r4Y0j0CmYGUuTkyLHHFix-zpqch2wnoIvDJY3iN0TuMJ7H-tqvYg>
    <xmx:v5r4Y88eZjEDu9eTUxAMlahRfwC2jPeipa9paQKo-MsfMudyJ1sQMA>
    <xmx:v5r4Y3vcQO1vOMoprK8i0g0Ec75dcueKuJtBX1vbxzBBBrvZBYoPrg>
    <xmx:v5r4Y4mDU1dxo7kQTVrYDK-EHuSoh_hfJegkhndP1P_vCFSGVcQE4A>
Feedback-ID: i51094778:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id AD0FCA6007C; Fri, 24 Feb 2023 06:08:47 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-172-g9a2dae1853-fm-20230213.001-g9a2dae18
Mime-Version: 1.0
Message-Id: <e6c7eb27-1b60-4894-a623-28ca3bccdea5@app.fastmail.com>
In-Reply-To: <CAMT+MTQOUd0aSDJ3DPBMfkVwaic=nbRPtfGgu2nduSdCdydcgg@mail.gmail.com>
References: <20230223-z2-for-ml-v1-0-028f2b85dc15@gmail.com>
 <20230223-z2-for-ml-v1-1-028f2b85dc15@gmail.com>
 <87r0ufs574.fsf@bloch.sibelius.xs4all.nl>
 <CAMT+MTQOUd0aSDJ3DPBMfkVwaic=nbRPtfGgu2nduSdCdydcgg@mail.gmail.com>
Date:   Fri, 24 Feb 2023 12:08:27 +0100
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Sasha Finkelstein" <fnkl.kernel@gmail.com>,
        "Mark Kettenis" <mark.kettenis@xs4all.nl>
Cc:     "Hector Martin" <marcan@marcan.st>,
        "Alyssa Rosenzweig" <alyssa@rosenzweig.io>,
        "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        asahi@lists.linux.dev, "Henrik Rydberg" <rydberg@bitmath.org>,
        linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 1/4] dt-bindings: input: touchscreen: Add Z2 controller
 bindings.
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On Fri, Feb 24, 2023, at 12:04, Sasha Finkelstein wrote:
> On Fri, 24 Feb 2023 at 11:55, Mark Kettenis <mark.kettenis@xs4all.nl> wrote:
>
>> What is the motivation for including the firmware name in the device
>> tree rather than constructing it in the driver like what is done for
>> the broadcom wireless?
> There is no way to identify the device subtype before the firmware is
> uploaded, and so i need some way of figuring out which firmware to use.

Some Broadcom bluetooth boards use the compatible of the root node (see
btbcm_get_board_name in drivers/bluetooth/btbcm.c) which would be "apple,jXXX"
for Apple Silicon. I believe the Broadcom WiFi driver has similar logic as well
which marcan had to extend to instead of "brcm,board-type" because different
WiFi boards can me matched to different Apple Silicon boards. I don't think
that's the case for this touchscreen though.



Sven
