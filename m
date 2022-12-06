Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AEEC644DBB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 22:05:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbiLFVFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 16:05:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbiLFVE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 16:04:56 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F1354730C
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 13:04:54 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id B38B332009BA;
        Tue,  6 Dec 2022 16:04:52 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 06 Dec 2022 16:04:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1670360692; x=1670447092; bh=OROVgmSnnK
        Tr4mOTzjp5s7Ogptrk2ZCtbYjacFpd5eg=; b=EjnNZuFO+JS9M1FE6ktpmbJ9pO
        /g+yISYKRji9jiVNZFZZmytwZccH4PSjY0h2j+dT1t/mawiUeXrGk579z2eq0f0D
        zABmM8LNk5cNrXO/+flE3yU5NxcNiWAHQOJxKvdjXhkYkqtyEkTEu+ANJuzcALlP
        LwwFKJQNmQrczRmM0Ea0FXc5bMdDWiZxTWPOtnZrCGPbic7FD0BSh2b2k/87nOQi
        U9P4SuR34yeH5WoAX2XAJqdcNTBvvgWcww/uXNkpqYCTJ5ylQzHTkfqKsoKfpQZW
        lX/XxdEdY5vM/j3j8WgiFJ3lnZdaa6qq1zSNnmHdgI/0NTnovI2GytukIa5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1670360692; x=1670447092; bh=OROVgmSnnKTr4mOTzjp5s7Ogptrk
        2ZCtbYjacFpd5eg=; b=Rec0ZMU4EH7r//Y+V0YTaUW5HJ9JsSGw8nRYlT3j5Yoa
        MBdCQTGbASugiiXUFqg7cmA6nwayaOj6bgrOxRJJIxV7PVIdUqP31J+JzgTNNdyb
        LeEEAoGzSLmp2lIWV7AltI97Kjqn68HIwM1yZOAAzki9xgmDTTTt9Mr841Fib98v
        AVJnOIMCOHfYU+aOHv89Ya4khO9Cw99xG1iX9t1o9OK9sbPRbFCe1tDzsajFOJLU
        jCukj2oJjdAGkUqY/5/7ovKBlYIe/JTxlxfkRkUuvn58A0zEx4EsOY3FuLO4oE4R
        e8p0qefv+suNlBSCrgTmMdFHoFL6BmoKnaPE5W21hw==
X-ME-Sender: <xms:c66PY3oAO87wv8QqJIKpjKqfyIMRVCKSoTPOwQDT1A2VSkRyuSLurw>
    <xme:c66PYxrs-lVtfs0AhpyIqeSg3nyKrPjmsf-TDdZ8Mbhn3wR9gcRVvlezKuysza-Aw
    DSf_mJfNeYiF3ClZzY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeigddugeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:c66PY0M7Tjd2mz4FG54Zyq6GgSmGXJZB3abS5Y_T0SPIXfK0QXZcEQ>
    <xmx:c66PY67ZNNbtJa23GkcskNdqunSMv8-4okYr-8U8IKzM_J_hNHTZDg>
    <xmx:c66PY27Hvnzs69kjI9judcLEcdKZ8-U04xjgHe4nz9K7-3jcsjyb7A>
    <xmx:dK6PY4t6XtkS1ytKKGZpWmjeRhC_JHLhoTxAzzCfRPzaP6__gJD6AA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id AE85FB60086; Tue,  6 Dec 2022 16:04:51 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1115-g8b801eadce-fm-20221102.001-g8b801ead
Mime-Version: 1.0
Message-Id: <3e40bfd9-2345-45ea-af1c-b8000b50ac01@app.fastmail.com>
In-Reply-To: <20221206171049.3316611-1-dario.binacchi@amarulasolutions.com>
References: <20221206171049.3316611-1-dario.binacchi@amarulasolutions.com>
Date:   Tue, 06 Dec 2022 22:04:31 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Dario Binacchi" <dario.binacchi@amarulasolutions.com>,
        linux-kernel@vger.kernel.org
Cc:     "Amarula patchwork" <linux-amarula@amarulasolutions.com>,
        "Fabio Estevam" <festevam@gmail.com>,
        "Martin Kaiser" <martin@kaiser.cx>,
        "NXP Linux Team" <linux-imx@nxp.com>,
        "Pengutronix Kernel Team" <kernel@pengutronix.de>,
        "Russell King" <linux@armlinux.org.uk>,
        "Sascha Hauer" <s.hauer@pengutronix.de>,
        "Shawn Guo" <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/5] ARM: imx: add missing of_node_put()
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 6, 2022, at 18:10, Dario Binacchi wrote:
> The 5 patches in the series fix the same problem on different platforms.
> In doing so it is possible to add to each of them the tag "Fixes" which
> identifies the commit they fix.

I think these should be combined into a single patch after all.
It's not a problem to have multiple 'Fixes' tags pointing to
different commits here, as the patches would not get backported
to a different set of kernels.

     Arnd
