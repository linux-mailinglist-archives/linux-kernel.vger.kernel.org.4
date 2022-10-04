Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6D45F4704
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 17:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbiJDP5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 11:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiJDP5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 11:57:04 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A33A0275F0;
        Tue,  4 Oct 2022 08:57:03 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 5E7AE5C0113;
        Tue,  4 Oct 2022 11:57:00 -0400 (EDT)
Received: from imap47 ([10.202.2.97])
  by compute2.internal (MEProxy); Tue, 04 Oct 2022 11:57:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1664899020; x=1664985420; bh=8f
        ukQVxVOSYCkUPUNcLdJutRz1dvTUy8PfzYQAo6isM=; b=l+yg/n97knmHPcEq2h
        o1LpzdLSxj7lp0whnawB8nCPyhe8hVfE7JXmxVxcWnxyakUkc048tSTwcsaAQbPQ
        V2aN/jRmizYCSu0O4kaLtHRHCL4lB5XgiR/HOiVFpox0DD5tGT5PbyaEXJLtcDWy
        NA8JxGg8PEVkCKndIwphOFOx7HDpnNtlxGQcCo/bCmvWm1CPSdtHyly1fUS/n3HS
        dna4E693G0X1I5sRxxKBU5cVPfMFED184eswbXfN9pYmuAz6ikGNnuq8YYsbqkGS
        5NtA+j4ig0CsDXqERjQ678c0XQXc1ZDgpmkTbVRCdqN2vckjS+Fus7dN6YME6gxh
        gP8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1664899020; x=1664985420; bh=8fukQVxVOSYCkUPUNcLdJutRz1dv
        TUy8PfzYQAo6isM=; b=EfBHBnWPUcpmB4dRe8mtfBhdCPqVZYLyOQaIo3/Sfn7+
        4l571zNwxZ43nLEMlJeXsqXWjo1lbVFPH625GoZSrnRkSi75+9LX8SCC9qb1v1S7
        hY3CqLWS0tqYJ8v5ItXbLOfl+LgF7/LykgRBRSoavERLs3B4fnMp3K++g1feJj4I
        eqlvhoc7FFol6yVRBEBVxyhtcZ9Lxb8o1TriuFNKb9YTQGu7CYD1nS9utZ/teV0m
        WXHVnrBfOsgPLy2n7Yk4uFXA/CthMZrXPjz+SDpbKk3G59lpcP4KenOMi4W59yrl
        busBS1ebQkybFt4IPsb6645MDwKysSBaxC4Ae1Dx/Q==
X-ME-Sender: <xms:ylc8Y_9lBwRbUzD9LrYY5Hpd6MA_o006vt0TaafBReOqAQHYgs9Umw>
    <xme:ylc8Y7uj081QXianIUy9lgXj11C-JMqmZneFwTMyhMb6qCzlGeqoF7oQtabI1VPMe
    DMELx5AUIL_5KQMfLc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeeiuddgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfufhv
    vghnucfrvghtvghrfdcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrf
    grthhtvghrnhepleevgfegffehvedtieevhfekheeftedtjeetudevieehveevieelgffh
    ieevieeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshhvvghnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:y1c8Y9AQ-9lCWMosRpNxUkI8JeO_T4OQN39DSEM34vEorUejlppCQg>
    <xmx:y1c8Y7d0pIX6xTL_6iPaDyfBu5NOwMS7P-LZRIv9rc5ciKGvujodmw>
    <xmx:y1c8Y0Pg2S7oeef4HfSthlyGiaGUORGXj_UNDHJOeX1HB7LcbjYsgg>
    <xmx:zFc8YzoxrNezxt0kdEyiFlO-gFPLpQPBJrmMpZI43PTXUTQPoF25ow>
Feedback-ID: i51094778:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id D834CA6007C; Tue,  4 Oct 2022 11:56:58 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1015-gaf7d526680-fm-20220929.001-gaf7d5266
Mime-Version: 1.0
Message-Id: <3398859f-e872-4f1d-8a03-4dcb1e46e010@app.fastmail.com>
In-Reply-To: <20221004112724.31621-2-konrad.dybcio@somainline.org>
References: <20221004112724.31621-1-konrad.dybcio@somainline.org>
 <20221004112724.31621-2-konrad.dybcio@somainline.org>
Date:   Tue, 04 Oct 2022 17:56:38 +0200
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Konrad Dybcio" <konrad.dybcio@somainline.org>,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Cc:     "Nick Chan" <towinchenmi@gmail.com>,
        "Hector Martin" <marcan@marcan.st>,
        "Alyssa Rosenzweig" <alyssa@rosenzweig.io>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Marc Zyngier" <maz@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/2] irqchip/apple-aic: Add support for A7-A11 SoCs
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


On Tue, Oct 4, 2022, at 13:27, Konrad Dybcio wrote:
> Add support for A7-A11 SoCs by if-ing out some features only present
> on:
>
> * A11 & newer (implementation-defined IPI & UNCORE registers)
> * A11[1] & newer (fast IPI support).
>
> UNCORE/UNCORE2 and IPI registers conveniently both first appeared on
> A11, so introduce just one check for that.
>
> Knowing whether the SoC supports the latter is necessary, as they are
> written to, even if fast IPI is disabled. 

AFAIK that's only an artifact in this driver: It was added to prevent an FIQ
storm in case there were pending fast ipis (i.e. the bootloader was broken ;))
when this driver didn't support fast ipis yet.

> This in turn causes a crash
> on older platforms, as the implemention-defined registers either do
> something else or are not supposed to be touched - definitely not a
> NOP though.
>
> [1] A11 is supposed to use this feature, but it currently doesn't work
> for reasons unknown and hence remains disabled. It can easily be enabled
> on A11 only, as there is a SoC-specific compatible in the DT with a
> fallback to apple,aic. That said, it is not yet necessary, especially
> with only one core up, and it has worked a-ok so far.

Just to make sure I understand this correctly - we have the following three situations:

- base: no fastipi, no uncore, will work on A11 and M1 though
- A11: fastipi and uncore but fastipi is broken (possibly due to HW errata or some bug in this driver that only happens on A11)
- M1 (or maybe even A12 already, doesn't matter though): fastipi and uncore support

If we figured out _why_ fastipi is broken on A11 we would only need a single
feature flag to enable both uncore and fastipi but for now we need two to
disable fastipi for A11.

I'm also curious: What are the symptoms when you enable fastipi on A11?


Sven
