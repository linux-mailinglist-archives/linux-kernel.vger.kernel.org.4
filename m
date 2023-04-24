Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 702AD6EC960
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 11:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbjDXJsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 05:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231503AbjDXJsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 05:48:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6406A40C6;
        Mon, 24 Apr 2023 02:47:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2EDA861F8F;
        Mon, 24 Apr 2023 09:47:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 213D9C433D2;
        Mon, 24 Apr 2023 09:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682329658;
        bh=FoOMzZ9W2LOp0CpmrKDEkp3PtIM99Y8iatERnmHe6IY=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=jJcFG2URKWfqioGUKJbzEevLZtmaIJr7DjJQ1d6nlyv9LCxU7XrBNs7c0tEyt28hq
         33LW3Ia69ZD6+NycB98lyZKLwwhj/1GBJlsIP211oSiCdgoZW/Zk7HxwDVQ6svaRqK
         xudpHB3vz0DMwJGiiftfAb5G1sYawukLKUOhfsz5MKWhUpH3zGbCP0exrHMJg9OtbF
         wlzkNyfZGhgkGEXOYOoE2ro+PgjZsY0jawZNwwQPz604+pzaBZNvbzGr6XnCpaDYMC
         zJDJVBMwrMjLZ4F0ykq4OmQRw3ozLS4oaHXWeO+WyVzJ3KeGj5nx5EApoGQrM9J8s9
         6TCY1h+JfdPNQ==
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailauth.nyi.internal (Postfix) with ESMTP id 09C9327C0054;
        Mon, 24 Apr 2023 05:47:36 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Mon, 24 Apr 2023 05:47:37 -0400
X-ME-Sender: <xms:OFBGZP76DiyQa041ys-qc5AqO7C56p-gSnK9FdMokgFN8L38y5wdLA>
    <xme:OFBGZE4u_yWPuNdTUp92kK_nENXi1OHPeuDsSgUCUxCbXhSrAFPOQrnTl7ISxFCOY
    _ZOik0sI3z7Tk6THCI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedutddgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusehkvghrnhgvlhdrohhrgheqnecuggftrf
    grthhtvghrnhepvdeviefgtedugeevieelvdfgveeuvdfgteegfeeiieejjeffgeeghedu
    gedtveehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprghrnhguodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduvdekhedujedt
    vdegqddvkeejtddtvdeigedqrghrnhgupeepkhgvrhhnvghlrdhorhhgsegrrhhnuggsrd
    guvg
X-ME-Proxy: <xmx:OFBGZGcjibz-9UjxPrzkgudlniE31wWHVsRCTXZZNbP-Q3mZsWrAhA>
    <xmx:OFBGZAIJCraGL6lE-7k9Ddbf8mG_6ll_guDAm9Pki0s3gljLZCeWqg>
    <xmx:OFBGZDJmecykIE2JCvhk-hENB5wQvfZy-Wps_00NiZhUPiLy2e6n7g>
    <xmx:OFBGZAHmjaG_lsUijBQIfJ0WzL6lTfgC2EC0U7zliyo53oZW37D7Iw>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 8BFD5B60086; Mon, 24 Apr 2023 05:47:36 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-372-g43825cb665-fm-20230411.003-g43825cb6
Mime-Version: 1.0
Message-Id: <60b87f6c-29ee-4ed8-a78d-3ef632aa0655@app.fastmail.com>
In-Reply-To: <20230424123522.18302-30-nikita.shubin@maquefel.me>
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
 <20230424123522.18302-30-nikita.shubin@maquefel.me>
Date:   Mon, 24 Apr 2023 11:47:15 +0200
From:   "Arnd Bergmann" <arnd@kernel.org>
To:     "Nikita Shubin" <nikita.shubin@maquefel.me>
Cc:     "Linus Walleij" <linusw@kernel.org>,
        "Alexander Sverdlin" <alexander.sverdlin@gmail.com>,
        "Alessandro Zummo" <a.zummo@towertech.it>,
        "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 29/43] rtc: m48t86: add DT support for m48t86
Content-Type: text/plain
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 24, 2023, at 14:34, Nikita Shubin wrote:
> - get regs from device tree
>
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>

Acked-by: Arnd Bergmann <arnd@arndb.de>

> 
> +#ifdef CONFIG_OF
> +static const struct of_device_id m48t86_rtc_of_ids[] = {
> +	{ .compatible = "dallas,rtc-m48t86" },
> +	{ /* end of table */ },
> +};
> +MODULE_DEVICE_TABLE(of, m48t86_rtc_of_ids);
> +#endif
> +
>  static struct platform_driver m48t86_rtc_platform_driver = {
>  	.driver		= {
>  		.name	= "rtc-m48t86",
> +		.of_match_table = of_match_ptr(m48t86_rtc_of_ids),
>  	},
>  	.probe		= m48t86_rtc_probe,

If you end up doing another revision, I'd suggest you drop the
of_match_ptr() and the #ifdef: there is no point in saving a
few bytes of space for non-DT kernel builds if both the machines
that use this device always rquire CONFIG_OF to be enabled.

     Arnd
