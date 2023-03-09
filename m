Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7D366B1E53
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 09:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbjCIIhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 03:37:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbjCIIgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 03:36:37 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ECF8E484E;
        Thu,  9 Mar 2023 00:34:55 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 234FE3200958;
        Thu,  9 Mar 2023 03:33:59 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 09 Mar 2023 03:34:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :content-transfer-encoding:content-type:content-type:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1678350838; x=1678437238; bh=X/QeGclk9xl/dLs0KMrYxx6pvj8LTlIVWQk
        gwAejAF4=; b=Dki5aiMPR0FVZhDLWfggFVuCHV8/Kpg7EbAX1eybj48v1QTl2Lr
        8Y51Nm1U+KQXYvQZD9ABY3elqEhyRmrRbTMknv/pyXKW21aFYxmlGHVsA6dzJR+r
        HR+0kAcatICr0PRmo/3w0DGsFt5AJm6Okkus3KvJYunt/gBKZ1TVMWILcMyLKjpC
        xmQQLBzTXG9wqPQOKQTlQxifSjat2NJHG/HQYabYSYtxkfifXzKb85V9cGSEOrkW
        VOE4dVLWFZltPqKUWfEeXGh1c9pDCnQ88RZCPOOvlN0MwC5Tw9ufCemgJTZQckd2
        Jri9HatItkfhXk2w/5mhiTu6of+hgXLGP1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1678350838; x=
        1678437238; bh=X/QeGclk9xl/dLs0KMrYxx6pvj8LTlIVWQkgwAejAF4=; b=U
        /PoiZ5Kjtlw4f4lUXSj081wKNDaP9G9TVC5a1eac9bg2SgJFK/bqj3/9RDw+zPnM
        sNvtyKdVBd4BjeIxrKoZJybZY6vjsVtUEhnfyhJ+eiBhXvFZUqFEWUEvM1moW0Xg
        uJf00VzF9YMtvK7x4bOhP5k/7waVdneTXQiXDpe4mAv496U4aTIMevCuZIcURWX7
        /edp3XEtWJvlKc5KgAZT73MqkJA0Z+Q4L80i1jC2odzSpL1q+CdO8zB9jbqmh4Dl
        Rk+DlaFyvTAqRmdDA/YyqobkdZ8IPYpfKsdGSt4nAYegLrp2RCzusHeoxOH0s1FW
        wveEiAn+4hdVqj03vzFbw==
X-ME-Sender: <xms:9pkJZJiEdXaqXZw0KjFcCUi2f0QRot3r8tPDDGPzMfNk4wuOVTVIIA>
    <xme:9pkJZOAgQFkl7SXHOlkMdEDDDvv4k9mzOJtrZk4Tv-WxL36aEGLWOr5xnIxlcKkCl
    6NcGgS1-j9Xq71f2zg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdduhedgvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgfgsehtqhertderreejnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepjeeghfeutdejjeehudevgeehveduffejkefhveefgfettdehgeeiledufeeu
    vdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:9pkJZJGXtyNtOn_0qdE7d1kpH7HmL-hj1EAb_COIwMvh9kiE7Rg4Sw>
    <xmx:9pkJZOQ65-PJmjbE91ui6TzAmX1fu8zmeb2u9-ldGrnYDZSrTZRp8g>
    <xmx:9pkJZGyv0AYizT655KKYZEo5KLBtNP5PzD_b55HImenQDz2R9L_W2A>
    <xmx:9pkJZLr0senTvl08EYUAmSweZk_x1LrbIYWWJoInds18lEAFq9rRUg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 7F7C0B60086; Thu,  9 Mar 2023 03:33:58 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-206-g57c8fdedf8-fm-20230227.001-g57c8fded
Mime-Version: 1.0
Message-Id: <a41277c0-d495-4b7a-969e-20019dfb1bc8@app.fastmail.com>
In-Reply-To: <20230309082035.14880-9-ilpo.jarvinen@linux.intel.com>
References: <20230309082035.14880-1-ilpo.jarvinen@linux.intel.com>
 <20230309082035.14880-9-ilpo.jarvinen@linux.intel.com>
Date:   Thu, 09 Mar 2023 09:33:27 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-serial@vger.kernel.org,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Jiri Slaby" <jirislaby@kernel.org>,
        "Ulf Hansson" <ulf.hansson@linaro.org>,
        "Shawn Guo" <shawnguo@kernel.org>,
        "Sascha Hauer" <s.hauer@pengutronix.de>,
        "Pengutronix Kernel Team" <kernel@pengutronix.de>,
        "Fabio Estevam" <festevam@gmail.com>,
        "NXP Linux Team" <linux-imx@nxp.com>, linux-kernel@vger.kernel.org,
        "linux-mmc @ vger . kernel . org" <linux-mmc@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 8/8] tty: Convert hw_stopped in tty_struct to bool
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 9, 2023, at 09:20, Ilpo J=C3=A4rvinen wrote:
> hw_stopped in tty_struct is used like bool, convert the variable type
> to bool.
>
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/char/pcmcia/synclink_cs.c |  6 +++---
>  drivers/mmc/core/sdio_uart.c      | 10 +++++-----
>  drivers/tty/amiserial.c           |  6 +++---
>  drivers/tty/mxser.c               |  6 +++---
>  drivers/tty/synclink_gt.c         |  6 +++---
>  include/linux/tty.h               |  2 +-
>  6 files changed, 18 insertions(+), 18 deletions(-)

The patch looks good to me, but it will (trivially) conflict with the
synclink_cs removal.

    Arnd
