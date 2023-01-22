Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B34C1676C0E
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 11:18:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbjAVKSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 05:18:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbjAVKSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 05:18:40 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D2D1E1D7
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 02:18:38 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 16EAF3200645;
        Sun, 22 Jan 2023 05:18:38 -0500 (EST)
Received: from imap47 ([10.202.2.97])
  by compute5.internal (MEProxy); Sun, 22 Jan 2023 05:18:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1674382717; x=1674469117; bh=A9
        pY3uzjg1fXUFXIN7wLr8bDc71+17U62MPlsvEQgco=; b=knX1ftn/oj76w7+O4R
        g0GrboIAL5wL8acbi2Pbr0n72rtn8TLt8Zo2O5HZgU+wWA9DQ471AX+7CsH7BxFB
        RQpddYcyvm/oKBIyXGBeXf+JIBdoa6wnvYQmKqq2P/tILF43Sv+pYg//wH7pgQ/r
        hkWWf7cxPJ+N8HBqkTKTJn7hnWOSTeW0Cm43ts1Z/yGxu6eQ/aaj5sbGIVReMi9R
        AkK5cIuYG6x52NykwuMmREbJzJNWEcfbrM0U3jAy57/yYFjE6zIWvGrWrizA802u
        N9rrmS9DYCmLTv9AJb1utCbcCfgr1AOnLrgN14CNgduKZP9rHm2H5nmfaIQlw+Ja
        +Sdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1674382717; x=1674469117; bh=A9pY3uzjg1fXUFXIN7wLr8bDc71+
        17U62MPlsvEQgco=; b=FTdxFIEr6hp+vZmMdRBmpfY/jseB14Ljjd60SvdfH6I1
        FNZWJ59IAQBj8biUQfFaY7MDDYpjNbmMfJQ9js9pHpMctWNcXPhjx8C4RfFDukG0
        5O3h9fVnOHYqHJ+Q+KJ/blGovPDQVcCDBLwMQTbDxWxirUv6aFVb+SCRpx+kUXVg
        fTJKhgVTTKpV886/nLmrPaUzpJYemgICyCn5MuFny+BxcW4KMpAUA1qwv8bveuIf
        xWqHOBOT12qjzDM/igzNoONIFuURbvow+zxYAEN4iKVpYkt0G10ty5Y0X2Tbochh
        qwMmF/Y+Df1ELVjBrMgWq/MUtEHYmifDOEZFrtoOxg==
X-ME-Sender: <xms:fQ3NYy_redOFHxOfSa4dkxXNis8A7GmlC1_OFL0NrKml2kYsdb7Spg>
    <xme:fQ3NYyt5f23Tq04k0TFYP80-hdsYueQZ4XBsWgrckw8K_Ze-lpuXIILxLHpPnFTxU
    YDEmghakv3I-taMALI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudduiedgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfufhv
    vghnucfrvghtvghrfdcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrf
    grthhtvghrnhepleevgfegffehvedtieevhfekheeftedtjeetudevieehveevieelgffh
    ieevieeunecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomh
    epshhvvghnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:fQ3NY4CRJxs-nuo_opeu-GtZ8Q0z8N162IcvDTkrnbui9qigCZcC0w>
    <xmx:fQ3NY6dfdYNqs2BUniDo5CQieF9H9GJOY3bLfj5pn8yL8EgE4Zr1QA>
    <xmx:fQ3NY3OIIal8hwgXsF-9FdNoFVlwPu-3SY0zji9rPpAvurkgQyi_Ew>
    <xmx:fQ3NYwqtpWcGRYbW_4wJFB2K6QELq_BZcJqC-r5nRTfpFq05CaZQSw>
Feedback-ID: i51094778:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 80AD9A6007C; Sun, 22 Jan 2023 05:18:37 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-85-gd6d859e0cf-fm-20230116.001-gd6d859e0
Mime-Version: 1.0
Message-Id: <5fa96f07-4abc-478c-bb9c-bb4961faf6d3@app.fastmail.com>
In-Reply-To: <20230121074135.8629-1-lina@asahilina.net>
References: <20230121074135.8629-1-lina@asahilina.net>
Date:   Sun, 22 Jan 2023 11:18:17 +0100
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Asahi Lina" <lina@asahilina.net>,
        "Hector Martin" <marcan@marcan.st>
Cc:     "Alyssa Rosenzweig" <alyssa@rosenzweig.io>, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: apple: rtkit: Export non-devm init/free functions
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 21, 2023, at 08:41, Asahi Lina wrote:
> While we normally encourage devm usage by drivers, some consumers (and
> in particular the upcoming Rust abstractions) might want to manually
> manage memory. Export the raw functions to make this possible.
>
> Signed-off-by: Asahi Lina <lina@asahilina.net>

Reviewed-by: Sven Peter <sven@svenpeter.dev>

thanks,

Sven
