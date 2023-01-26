Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6864467D04F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 16:34:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbjAZPe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 10:34:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbjAZPeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 10:34:25 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 954836813A
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 07:34:09 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id DC9263200A3D;
        Thu, 26 Jan 2023 10:34:08 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 26 Jan 2023 10:34:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1674747248; x=
        1674833648; bh=Cd7F3OFY9x8v3nIqGqdzEAHen309dXIbhVea8fHwSGQ=; b=D
        SSBTS0jgEBA83WJxUAEfm7R2lyTZvXkSzmkCQXaMspT2oD8nDwdeYYvXqIj9vPgJ
        P+yMa6xoxpnCg0zSABip9tIaPmWlYHi0v1PySDcOqSGYPtARIDkzeJP4OY+7qRcY
        d22Ul4UH0Z3QPzPCkrLAovwCYX0GHbGzQYCO28PSZ4d4oCYCvG8pClTzDejyX0FK
        Ll9qtwHzIwg26WzoPskzeMrMi/d9BQqL/csO4u0mZjjCFsjP1/hHhNqc5xkotsx2
        fRsXv+wReHStWBE8N6RAVHn/ijwYSrBUYpqEJWmskGK2SoFRY/jtwkSEUwUeqJqI
        6QnO6xNs6p1f1HRmqvZ4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1674747248; x=
        1674833648; bh=Cd7F3OFY9x8v3nIqGqdzEAHen309dXIbhVea8fHwSGQ=; b=r
        lmla8kdpLQ4d87C8yuCg1z5dNF+Xpctc+IVb/XjKI2fEWAKjKPQBjnPqArL8odDf
        CDPbWsiKcu7jBIEXUETPV4/gGgJfrSlj4n+KUQK3w1seFT+Gwr1UkxLKvKvzAJfy
        MYXYpYOCekTQXZ12MRPch0FMa8klZafbM0a0JEZpakpQLNnaYvFsYGG8eXPj0pib
        9N8PCm3LocqtgrDzr2YAalPvm+5KCV9cqlX339liYbDO2BcZpT8xoRsgZ9QRLjhU
        xUDUyLg9/Y4aYfsaBdjSG7pkB4gkP6r7aXLxhGHG8dOY1IPdMlo++QREETF7tBwK
        bGCwnOKh40+5Y7GTggiKg==
X-ME-Sender: <xms:cJ3SY_lq7Fei4AYFUslqSJrY5YtpWhCezmwSlEY3m2bz2x-dBAIzsA>
    <xme:cJ3SYy1eR6uKWoOhy7n0HzjdH-NoRi1AVQvuZjxuq52vVfnRUPevNdifI-MYXR5A6
    2zt702tccqx0Q_eJEU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddvgedgjeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:cJ3SY1rf29qGvXzHpuSoiX3DjstkJXW_M3ap8y2nu4Xsf66NcvEa9Q>
    <xmx:cJ3SY3lhJPK5rQXTtv_IOp0i_ZdLgolU5gVO1rcyDdW6_pv41WWRog>
    <xmx:cJ3SY9363858UPRbMujXc_2OBMi1dcw7LjJfDwmACGAlOze4qaqYnQ>
    <xmx:cJ3SY-_CDigfMt0qDnU3YhucjaJf_IUIeYAkT5Ck_Nc_OM3evbavUw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 2B355B60086; Thu, 26 Jan 2023 10:34:08 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-85-gd6d859e0cf-fm-20230116.001-gd6d859e0
Mime-Version: 1.0
Message-Id: <6c6862bc-067a-4f09-9952-9fc7fd75281d@app.fastmail.com>
In-Reply-To: <20230126152429.580539-1-u.kleine-koenig@pengutronix.de>
References: <20230126152429.580539-1-u.kleine-koenig@pengutronix.de>
Date:   Thu, 26 Jan 2023 16:31:41 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        "Lee Jones" <lee@kernel.org>
Cc:     "Pengutronix Kernel Team" <kernel@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: Remove .enable() and .disable() callbacks
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

On Thu, Jan 26, 2023, at 16:24, Uwe Kleine-K=C3=B6nig wrote:
> With commit dd77f5fa97d3 ("mfd: Remove toshiba tmio drivers") the last
> mfd driver that makes use of these callbacks is gone. The corresponding
> functions mfd_cell_enable() and mfd_cell_disable() are also unused
> (apart from the leds-asic3 driver that cannot be enabled any more after
> the above mentioned remove and will/should be deleted, too).
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/mfd/mfd-core.c   | 26 --------------------------
>  include/linux/mfd/core.h | 12 ------------
>  2 files changed, 38 deletions(-)

Acked-by: Arnd Bergmann <arnd@arndb.de>

