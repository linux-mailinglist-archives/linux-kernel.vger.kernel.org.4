Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B357F66DAB0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 11:15:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235641AbjAQKPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 05:15:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235848AbjAQKPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 05:15:47 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E182717;
        Tue, 17 Jan 2023 02:15:45 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 041533200976;
        Tue, 17 Jan 2023 05:15:41 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 17 Jan 2023 05:15:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1673950541; x=1674036941; bh=XKPMNAyWjO
        5bizn8aYIilfV14edG3KsI/pCa+0iqYeY=; b=RsTUlsCP5+0mD/5GnmSUTdJf99
        zah1MhwXxfftnOQLzqebONzyrYjfGAhOjYGBhj7L4maM6yMoZQ5GZQeP5TVJwWc9
        1Z2tRYVGWu79PaLu9tU9ucqTR432+bf/M7qFYvAd0dEHES7qIXA0DTW+hDpophXg
        OlMmUBufJw3RDDMPLzq4CAygIG7WL9Kej2il/YTZSL0Hn2LLQtEqDHAwqmhIChls
        gK0jm1FU0llZ1PnuCcqD+3TFM2xoaa8W+Bp8tKDm+7bTmlDrHes4jZSmzvJ4XldW
        YDqKVBU5oWlcsC26V2qL7KiaU/O81yK55YNWYVgdimTo1dTgE7GdTx/Yckuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1673950541; x=1674036941; bh=XKPMNAyWjO5bizn8aYIilfV14edG
        3KsI/pCa+0iqYeY=; b=h6BZnIehpQI/LEW8ZCQUUvp2rv01TCxOPSAfZ4Om+lcL
        UczDG5NsVuF9/wbBKrexYrnZsPTX4KbgPcaHWk2C9xK5gUGmdVUjfeu80xp1bESr
        riHSnGfxAuWzpaHmq8pww07Y+hduSK9yguVWnzXYj+l+KbBwfgjPimb/zeVyhB0l
        whdm0WErVDlpDQSvI35C1XO827z0HaXw4IKKF+HJr7zQIWpIYfRWztxfr+03yeIv
        UBLS0wjdq9B5kDwVseLF79X6QoUamkH+29Nn6+lbrIsJzrsEc41PPZMRiEEIw8gX
        BzM8zKo9eI52ZvLzBGpMm2dp7Ww+wIcWrOcW1N2Kyw==
X-ME-Sender: <xms:TXXGY_Me-piRPSzPJ9BaVYFh10Uy_7dhRxnLzDO1ekJxowXLOmy9mQ>
    <xme:TXXGY5-bR2R5A1IpwR0iqjazySsXbt36ycWl3z1LwnyMP_MRrlnDhdLouWxKNKVjp
    OOh9d5_2QRJ_wwtBN8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddtiedguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:TXXGY-R0QliJEiJlxn5gse2ZKWXqhtVfhxt3fXy87m0TC5G_aTYY_g>
    <xmx:TXXGYzsJZAicISpxSXhM-pyXeVAAQKJJNqAJjE9CgsHbii4rBN8G2w>
    <xmx:TXXGY3e0ilskgs2rLoXaBX9oMtjvU51s3vd32RqAnKMtrIOK8rCTaw>
    <xmx:TXXGY5tL2xvXOED1GU-796BGvLeOvLHR6t4rvjuq3i9kvtJsjbm9WQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 01C10B60086; Tue, 17 Jan 2023 05:15:40 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1187-g678636ba0d-fm-20230113.001-g678636ba
Mime-Version: 1.0
Message-Id: <a699e52a-db19-4374-a4bc-a3948ecc43ef@app.fastmail.com>
In-Reply-To: <20230117100845.16708-1-nikita.shubin@maquefel.me>
References: <20230117100845.16708-1-nikita.shubin@maquefel.me>
Date:   Tue, 17 Jan 2023 11:15:20 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Nikita Shubin" <nikita.shubin@maquefel.me>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Cc:     "Linus Walleij" <linus.walleij@linaro.org>,
        "Hartley Sweeten" <hsweeten@visionengravers.com>,
        "Alexander Sverdlin" <alexander.sverdlin@gmail.com>,
        "Russell King" <linux@armlinux.org.uk>,
        "Lukasz Majewski" <lukma@denx.de>,
        "Bartosz Golaszewski" <brgl@bgdev.pl>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] gpio: ep93xx: convert driver to DT
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023, at 11:08, Nikita Shubin wrote:

> 
> +#ifdef CONFIG_OF
> +static const struct of_device_id ep93xx_gpio_match[] = {
> +	{ .compatible = "cirrus,ep93xx-gpio" },
> +	{ /* end of table */ },
> +};
> +MODULE_DEVICE_TABLE(of, ep93xx_gpio_match);
> +#endif
> +
>  static struct platform_driver ep93xx_gpio_driver = {
>  	.driver		= {
>  		.name	= "gpio-ep93xx",
> +		.of_match_table = ep93xx_gpio_match,
>  	},
>  	.probe		= ep93xx_gpio_probe,

The #ifdef here is wrong and will cause a build failure because
of the unconditional reference to the variable.

Just remove the #ifdef/#endif.

    Arnd
