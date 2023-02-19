Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACB6E69C032
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 13:39:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbjBSMj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 07:39:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjBSMjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 07:39:24 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC22510271;
        Sun, 19 Feb 2023 04:39:23 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id BC6DF32000EB;
        Sun, 19 Feb 2023 07:39:22 -0500 (EST)
Received: from imap47 ([10.202.2.97])
  by compute5.internal (MEProxy); Sun, 19 Feb 2023 07:39:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1676810362; x=1676896762; bh=k8
        3A+g7S3ByBVaUJPvDn2um16R3lzsxqFfSEQC5A0ls=; b=oDNhtv0DuSXXtQpIKc
        aQlBh+GfGOy8X3rS+YYGpM1PX0Hzt4LDfXmpGGxAYFj7BLQkDKv9KbOlZBjlxfaC
        myRo6/nSwB7dh2Y+vfb3o8PgSSMnslP0KA9ei6aEnKhDipeOq4BYsaVTF+b6ki6f
        TzZUrWVkvmWMxn9nhAivHiGv98z3WIlZcYFogFN68gWwu5KlsIqk5gTzftaU8V2r
        QdUC2Fk9f8v1RVmVA07v3SG0S2XKLdvwQI/nlAxGAY67ova5aNyzCaGbAees4fv1
        hD+jCwlykJXBpW4AOkz7JHCNpsjneSBMlbepZrFABlicKMoZRFgI7kaZ0H6kd0Ic
        nNcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1676810362; x=1676896762; bh=k83A+g7S3ByBVaUJPvDn2um16R3l
        zsxqFfSEQC5A0ls=; b=XnlDmCRzSEgzBbxfME0H9Ry2dnYZzJ5OQA1p1VIi0TAE
        sZp/Ynij3iqEWylE8StrhX6KCGgtjA2xISN9t2BET9KNcYM4yVlVAsBetqb/qJRB
        IYa6WyWVvI9AW1sd7syCMqXQKQRSRemZ7AfQImii4kMXaVV6fxLZRxrd0eiB4Lyj
        l6AjekA2jlr5mVBumSkBj5y+4tPg8llhTdSLsvoXwUUV6jY0QoJc2e5YqNaDmO3C
        ugKc1JmVc1vIZMWvzemavp4HWSf3vUoohuk4RK2KzaRjVSeoORMmfbMsaooCtvDj
        MxuIwr1qanzLPtts+IgX+iB3b0P5PCIoRBRc1J8oew==
X-ME-Sender: <xms:eRjyYxtRmrPRpXv2IOcrMkHTxIk7bum9qoPtiN6TyzYsi53oqt6qug>
    <xme:eRjyY6fmbJRJM9KuqYWBP4RzyHbRFMpjJA4-IIUZZ_0UTDnxCvOpgF0x9PhHxiq40
    cPQgWMxfsSbrCTRZhw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudejfedggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfufhv
    vghnucfrvghtvghrfdcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrf
    grthhtvghrnhepleevgfegffehvedtieevhfekheeftedtjeetudevieehveevieelgffh
    ieevieeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshhvvghnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:eRjyY0yX7HTYdp9fBhazdF28JzrOj0IkDoPMblzZaqicXdismFON9Q>
    <xmx:eRjyY4Mfnv-kasoqKCYIMHmJ6vRqsj1Y2S0_2CTrJA2K_WDiIJTdzQ>
    <xmx:eRjyYx_hqsmnGFnMW47HsasywQBOCMRVFF2V3Y0KmFfuFZ_9jjwj5A>
    <xmx:ehjyYxwzelqr5DfRfmZX9pthVMqRZEEYvBBAj8xaDTrqwOwnmRNzzg>
Feedback-ID: i51094778:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 38341A6007C; Sun, 19 Feb 2023 07:39:21 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-156-g081acc5ed5-fm-20230206.001-g081acc5e
Mime-Version: 1.0
Message-Id: <0f49c43d-c6e0-47a9-871b-6fbe4daaa37e@app.fastmail.com>
In-Reply-To: <20230217141059.392471-12-nick.alcock@oracle.com>
References: <20230217141059.392471-1-nick.alcock@oracle.com>
 <20230217141059.392471-12-nick.alcock@oracle.com>
Date:   Sun, 19 Feb 2023 13:38:54 +0100
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Nick Alcock" <nick.alcock@oracle.com>, mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Hitomi Hasegawa" <hasegawa-hitomi@fujitsu.com>,
        "Hector Martin" <marcan@marcan.st>,
        "Philipp Zabel" <p.zabel@pengutronix.de>, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 11/24] kbuild, soc: apple: apple-pmgr-pwrstate: remove
 MODULE_LICENSE in non-modules
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2023, at 15:10, Nick Alcock wrote:
> Since commit 8b41fc4454e ("kbuild: create modules.builtin without
> Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
> are used to identify modules. As a consequence, uses of the macro
> in non-modules will cause modprobe to misidentify their containing
> object file as a module when it is not (false positives), and modprobe
> might succeed rather than failing with a suitable error message.
>
> So remove it in the files in this commit, none of which can be built as
> modules.
>
> Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
> Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: linux-modules@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
> Cc: Hector Martin <marcan@marcan.st>
> Cc: Sven Peter <sven@svenpeter.dev>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: asahi@lists.linux.dev
> Cc: linux-arm-kernel@lists.infradead.org
> ---

Acked-by: Sven Peter <sven@svenpeter.dev>


Sven


>  drivers/soc/apple/apple-pmgr-pwrstate.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/soc/apple/apple-pmgr-pwrstate.c 
> b/drivers/soc/apple/apple-pmgr-pwrstate.c
> index e1122288409a..2c15474c7b53 100644
> --- a/drivers/soc/apple/apple-pmgr-pwrstate.c
> +++ b/drivers/soc/apple/apple-pmgr-pwrstate.c
> @@ -319,6 +319,5 @@ static struct platform_driver apple_pmgr_ps_driver 
> = {
> 
>  MODULE_AUTHOR("Hector Martin <marcan@marcan.st>");
>  MODULE_DESCRIPTION("PMGR power state driver for Apple SoCs");
> -MODULE_LICENSE("GPL v2");
> 
>  module_platform_driver(apple_pmgr_ps_driver);
> -- 
> 2.39.1.268.g9de2f9a303
