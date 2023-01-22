Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D423676C0B
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 11:18:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbjAVKSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 05:18:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjAVKR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 05:17:58 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD271A4B0
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 02:17:55 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 50CF7320085B;
        Sun, 22 Jan 2023 05:17:53 -0500 (EST)
Received: from imap47 ([10.202.2.97])
  by compute5.internal (MEProxy); Sun, 22 Jan 2023 05:17:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1674382672; x=1674469072; bh=zs
        A1eerhXxQaUGjq/k7I/yW9gRygQxaBHV3y1RifdYU=; b=Zj/SbSHHsctHGvB61p
        L3by4m/rRaR+i2pyNvQ2LO1U4NAvs/we9ZTt4KPoXII3OOC1fSlMiDyQXPuJFX9l
        2cyAnj6kHOxleXN9pRiBGZkNA5HUqYoESNRd39OCTxAQET0Cbo1yN+thtdK6cyyf
        pKr71RzOqFBDl2/v37F7pNclwhAXM3C4id/Sb5cFmRsqOO8X+NM61jZaofyaelAU
        Rc8n0OJr1X5FSdhBj9MLyzq+eRrPyT0UIetebGI+qYq+rJ1qpcCZX5A6EWxn8qBF
        dLilTFx9AYZB4NDKc/39VksWX9WsEcFonx9aya+g253kFMs7Wg5GE1D9pOLHJr3J
        b3nQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1674382672; x=1674469072; bh=zsA1eerhXxQaUGjq/k7I/yW9gRyg
        QxaBHV3y1RifdYU=; b=mlt4VnjdrpwsYctrSwG+edr74RuhSm7AXMvWCExH0LcX
        oCHj+5TLszDlvna85PqkjfSuRdwftMK8Qa9psxqsa/p+Uhs1MlshbLh/sWht68Ej
        XOUSrN8BY5K4bOzb8L307KYmjUYujuf9CTjiwz7Z4YrHMphS3UAI94j1AMk/CoQx
        /jwjEUujKSkDewWGvQzG11kWNtcKWXgtQehZPQgtz1O3uLmtJOcKKYmDGuW5aa/W
        gFksdj5Vak2MEgtG+cp2kavokpxSrDby7XgGIBnfY9BxXgqofpo9ZXpwRnkP3OdP
        VPQSjoC6VIgv/IBzCUjSZvBrTFA6clP3VfXVb2BZ6Q==
X-ME-Sender: <xms:Tw3NY-_BlR2I5uI7_7JIXpOvhA5YPVfeQS15KrrGgdQ8PsK4gtFHMw>
    <xme:Tw3NY-toSnf3YiNbtjzikiqjH9MHE38ifea81S8m5U18CWjOakNvS57Y3qFV_Q2te
    q3ZbAnD1XXSm-x7xiA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudduiedgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfufhv
    vghnucfrvghtvghrfdcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrf
    grthhtvghrnhepleevgfegffehvedtieevhfekheeftedtjeetudevieehveevieelgffh
    ieevieeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshhvvghnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:Tw3NY0Am9h5hoJWR88mdjwNHS_h6rMbuXm8Nzt4NWDesEKi2e-FGnA>
    <xmx:Tw3NY2c1D111hikBsTLBeKDvIaYoSViwBR-tSg_fcXjHThUROMJPQw>
    <xmx:Tw3NYzMLrBJOYZMXgAITwuvStRFUhj18wY63BYwq2rGOrkBc3tQwZw>
    <xmx:UA3NY8qQSZxrBE050sU6ELiYHHvn7YPDQ0bImNqgvJcwfGDFhe7hzg>
Feedback-ID: i51094778:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id C83C2A6007C; Sun, 22 Jan 2023 05:17:51 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-85-gd6d859e0cf-fm-20230116.001-gd6d859e0
Mime-Version: 1.0
Message-Id: <9c0df0cc-f592-468d-9d56-1559a6ab9513@app.fastmail.com>
In-Reply-To: <20230121074253.9774-1-lina@asahilina.net>
References: <20230121074253.9774-1-lina@asahilina.net>
Date:   Sun, 22 Jan 2023 11:17:31 +0100
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Asahi Lina" <lina@asahilina.net>,
        "Hector Martin" <marcan@marcan.st>
Cc:     "Alyssa Rosenzweig" <alyssa@rosenzweig.io>, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: apple: rtkit: Add a private pointer to apple_rtkit_shmem
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 21, 2023, at 08:42, Asahi Lina wrote:
> This allows downstream consumers to keep track of private data for shmem
> mappings. In particular, the Rust abstraction will use this to safely
> drop data associated with a mapping when it is unmapped.
>
> Signed-off-by: Asahi Lina <lina@asahilina.net>
> ---

Reviewed-by: Sven Peter <sven@svenpeter.dev>

thanks,

Sven
