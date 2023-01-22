Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF85676C0F
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 11:20:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjAVKUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 05:20:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbjAVKUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 05:20:00 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 245CB1E1D7
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 02:20:00 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 3C7C23200645;
        Sun, 22 Jan 2023 05:19:59 -0500 (EST)
Received: from imap47 ([10.202.2.97])
  by compute5.internal (MEProxy); Sun, 22 Jan 2023 05:19:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1674382798; x=1674469198; bh=r5
        oKi9VweDyRvedU0o7SpTgiCr05j2yCKy3Tna3B5YU=; b=h2fdLCOC/PbONAgApO
        aZziaw7BmWZFC3JvYLGNQ/9Mlrty2bjNoWRjbc5YNPFg25obpj60Vqqpximr4NCG
        le92tYo6UJx5dpcv2CszaWgjd1j4lE6Uv0iOaUfta+os/wVjz2+FCjN0vnPHutOk
        jb2z6UNG0u8PeaCb9vNRDqylH8Dc1uJF06nMq+4zh2pSDvWKQrLMbh3/Ia6snqIC
        44ras2jfuGn9hvxgoCSNwXqe+JMcLSFG1nMI2NCRNjJEWowsT7IHbT6hzgSFDRWy
        nr01+Ayizg2xgYZmCvh8kusOQfS+6cT5Qf1Epe7Pwc/g35kTb8azo3juCTmygYMB
        sSDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1674382798; x=1674469198; bh=r5oKi9VweDyRvedU0o7SpTgiCr05
        j2yCKy3Tna3B5YU=; b=U02OMTgK2nM7kCd4hxQI5Dl/tyFyGRrM6GKYKS5Rfbt9
        ea6VO4UoEWjs5BVnQjUdHtPEnY4Od0ZDH21ITrslQjTUO/xdOjRFezMe/wII2D9a
        1MVUgB2xwjePc5KbBq3U9sJH3z2Iwh+zFTGCl8LcAnwvZmU7cgrnRExaWuHz9Xuj
        CEeUSmla/5ja4qc2oQMyO8vNWUDv8F9zDic3f6rJ6F6kkOtTFOXxnoQ7KTzIJ+80
        rgwPG4AGVniwTCII5bVdoN8JlQxRmiJ49Fo2dIYiVrBjJyzqdRIl4YHNw+UfQ2qd
        GTDA9Wg3qPThwHmK0f6qrTXWimlw2jNArNiCJ81UXg==
X-ME-Sender: <xms:zg3NY6WILBKUnTFh5rppTOVUVc-qAZ93XdaARTh3FaRFGHdioG562w>
    <xme:zg3NY2mIzBWszMDoV_5MeJNtqL0OvuLDjpz7-brarIpt0d6UPcdE2IfBiJ6HfFm1R
    c36aNUbIKgXUpXzeUI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudduiedgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfufhv
    vghnucfrvghtvghrfdcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrf
    grthhtvghrnhepleevgfegffehvedtieevhfekheeftedtjeetudevieehveevieelgffh
    ieevieeunecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomh
    epshhvvghnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:zg3NY-bC0NDrF8QLco4BBMHMcWOooYs04NUHL8kgGxIzf7o3_x_scQ>
    <xmx:zg3NYxUM6dz-reDPGUS-Pbz6AmHe6yFW6J1sYqh9KL6sipCUgDpaLw>
    <xmx:zg3NY0nHtAXhqoE8ldE5VAgMgJCghBnhX9k65fuqKegGnJWRWwaudA>
    <xmx:zg3NY-j3VyCLxA1D9PsAE02_AqHjlzuuh4s94Pa7BDACeV2V1HPQUA>
Feedback-ID: i51094778:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id B7963A6007C; Sun, 22 Jan 2023 05:19:58 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-85-gd6d859e0cf-fm-20230116.001-gd6d859e0
Mime-Version: 1.0
Message-Id: <938ee8b4-3745-43a7-b813-801df22f2888@app.fastmail.com>
In-Reply-To: <20230121073741.3807-1-lina@asahilina.net>
References: <20230121073741.3807-1-lina@asahilina.net>
Date:   Sun, 22 Jan 2023 11:19:38 +0100
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Asahi Lina" <lina@asahilina.net>,
        "Hector Martin" <marcan@marcan.st>
Cc:     "Alyssa Rosenzweig" <alyssa@rosenzweig.io>, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: apple: rtkit: Add register dump decoding to crashlog
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 21, 2023, at 08:37, Asahi Lina wrote:
> When the coprocessor crashes, it's useful to get a proper register dump
> so we can find out what the firmware was doing. Add a decoder for this.
>
> Originally this had ESR decoding by reusing the ARM64 arch header for
> this, but that introduces some module linking and cross-arch compilation
> issues, so let's leave that out for now.
>
> Signed-off-by: Asahi Lina <lina@asahilina.net>
> ---

Reviewed-by: Sven Peter <sven@svenpeter.dev>

thanks,

Sven

