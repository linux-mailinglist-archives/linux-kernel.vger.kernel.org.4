Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF9E67F79B
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 12:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233721AbjA1LiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 06:38:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233670AbjA1LiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 06:38:23 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 860FF29E34
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 03:38:22 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 91CBE32005C1;
        Sat, 28 Jan 2023 06:38:21 -0500 (EST)
Received: from imap47 ([10.202.2.97])
  by compute5.internal (MEProxy); Sat, 28 Jan 2023 06:38:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1674905901; x=1674992301; bh=tb
        Usm6pfIt/kPBot6dt1/vQv/ShnjRggzhxmWsZoqLM=; b=fckz/PQFvjLW+JNNFh
        FnQ/pRJIb/iv9fd9FaxntxmDyHu5SD7GAn2aNMFHYdc/S2fmnPI4mVlGWoGfRYd3
        HANSsL99UeqB3oJ9Gi4UzCMFRf/EWE/hqu+M1z71Z8AqA8vv51oe2wqeo74UkbNm
        Hmm/E4SQagy38rRX2bMDYY2VbRusdvG0NKUDd9X+xUfOXeGlzxh7U7yD1AJWwqKY
        VyCn0Az+h0huFTKKADV255zAFXogpezmX9CQKrSHTArciwECXgwDs4FrPK58ynlB
        R6zViigBJT1bs2xx/H7wfaxce7WqJpXCLuUhhXAFvmG+R+zmNyz3WL/QbI72knpG
        IZHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1674905901; x=1674992301; bh=tbUsm6pfIt/kPBot6dt1/vQv/Shn
        jRggzhxmWsZoqLM=; b=MX/AAKfWQPI8yVHD8sYXhmEy/4Nrts6V3GsGD4HMlXu8
        Uu+S+Usy+CiiA9nckzP+A5UV0RFE9oFCz5Gv1T5+vyxdBVI9nGhchyMZvfaKJwpg
        dBISpCPZLGjhxSdTRJkNdrjcio0G6boXJ2Bm4X77iFDPpigeLqm8ixN1SgK0pPBG
        YYQELfQw3q7inLvdbU2JUAI69sq7seFCafbnDjFuUfdZbX37P1rZvIy13GyZETsT
        BmV74yfJygMDDFVlRyKAsc5/pN1Gt/0ahhl9/7Q4AHIgUO5atLARFbOt2cuU3z8n
        vAmplDKHy/V0+T8YuvizktNNOYbgQ1AS1HqtO9iEig==
X-ME-Sender: <xms:LAnVY42KTh75hpmSMYuBDhokPEPYnhZszpCJsu2C9Wg-u3AUvEceIQ>
    <xme:LAnVYzHI3b_6YuOgLXKt7qRamGnRbk23Y-A7JEdBikEHJB9VI1SEHFokzG4yBLuB7
    3OWSIt7lM22pMO5cZg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddvkedgvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfufhv
    vghnucfrvghtvghrfdcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrf
    grthhtvghrnhepleevgfegffehvedtieevhfekheeftedtjeetudevieehveevieelgffh
    ieevieeunecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomh
    epshhvvghnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:LQnVYw6b1vWCqzJ9ntWqMtNLtAp9eLGhrsSUQJNellJ47thyeMSuvA>
    <xmx:LQnVYx0FetV2J92QkxKqsihz6-GwV9xNSAAi2kcaL_eYpYJBkg6ZmQ>
    <xmx:LQnVY7H_i569Q0oo_Uj_6ZNw5I-stNVaLvoPHGaml7n_29BM_PlDsg>
    <xmx:LQnVYzCtN2V3mjxhSfBroufbHDQLcTlG2PIv5h04pBaG50wEXwsSkw>
Feedback-ID: i51094778:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id E9F27A6007C; Sat, 28 Jan 2023 06:38:20 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-85-gd6d859e0cf-fm-20230116.001-gd6d859e0
Mime-Version: 1.0
Message-Id: <ef1a2650-806d-425f-af90-7004f99d11fe@app.fastmail.com>
In-Reply-To: <20230123065125.26350-1-marcan@marcan.st>
References: <20230123065125.26350-1-marcan@marcan.st>
Date:   Sat, 28 Jan 2023 12:38:00 +0100
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Hector Martin" <marcan@marcan.st>
Cc:     "Alyssa Rosenzweig" <alyssa@rosenzweig.io>,
        "Janne Grunau" <j@jannau.net>, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: apple: apple-pmgr-pwrstate: Switch to IRQ-safe mode
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2023, at 07:51, Hector Martin wrote:
> This requires changing the reset path locking primitives to the spinlock
> path in genpd, instead of the mutex path.
>
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---

Reviewed-by: Sven Peter <sven@svenpeter.dev>


Sven

