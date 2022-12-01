Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 896C563F401
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 16:33:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbiLAPdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 10:33:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231945AbiLAPdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 10:33:06 -0500
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0487CB4B3
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 07:32:38 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id B0E705C00CA;
        Thu,  1 Dec 2022 10:32:31 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 01 Dec 2022 10:32:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1669908751; x=1669995151; bh=E1pjq6O5l0
        LrJHsoPp1Hm/5Wa9enGEBiTS8IWQ9GNz8=; b=NGKuVY6eVGwWjvXOXGStrxfp54
        fljeCKBGF0nx5HRr4YboNKLR8CUE7j22HggHj9URX01B1t+BFXR9I/8DSizvkdap
        3J1X60lisIpB/4zLwqnesr3O6TMi2mr3aak89tK3hcViRyl4hZ1TK/ZtZ2pTJz/m
        3U0QGGJr5NwCd9YfrqhBouw00Ew1CJvEnLnavGZ6859MQ37PDqyTi8qer9mdwmrH
        xtUNQ3vXBUb3wnsHcy0FGSGJ96Fx8lbvvc//j4PQcmasZQs/K5Ac6y/2o93NMNo8
        VbBQQmXCmyXYia08ukAMJrLdKa93rLAjzexE54NhOB/DooLQWMP6D/+9tfEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1669908751; x=1669995151; bh=E1pjq6O5l0LrJHsoPp1Hm/5Wa9en
        GEBiTS8IWQ9GNz8=; b=GaMtkm81HxoUj8OM+tezRhg6USQKf42ynHLj6lRHlFZU
        YTztYc8T638ny/cVIiSW1SGBMHYB+MPNAHd1UTp+rgTOsKa9V2q0fVWeLwDZ1Nd6
        +kMwIdfJGdiU3RnbQuepGHi5KDVy6MTH8mVuJSh7nybjlx7xFxZeQuaUACh+YN2s
        RAeX4eEo89TQsJkJFxHKnJePEe6kk/Bi29IkVuVJj8EmCEi0czT8cJVJWkIW4s7P
        OUBFjTtmRFFEqGLz7ewOe41z/1x9b0knp21Co0qmR/UIETtXdv+mHH3P2HhRkHpb
        o9ab3j14vzmDzmDe9Tw6z20ELj0o/xPb+/bSmYTHAw==
X-ME-Sender: <xms:D8mIY6OGl6HYqKyxbfZ2HR3BMMI3n_awcd5N1oxPSrKPK2OtiZuydQ>
    <xme:D8mIY4_htLC9eidpeVKNNtIjENbP4yMD0EOMGtfpJEe7zsCt_R-2P9YUiOGE-9EOP
    U3aoNylDJtRYMSk3CE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrtdehgdejkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:D8mIYxTc3qgtHWC5BsZRuRyDwjzHdF8MbXR95LXhQXnD3zKVP4sKRA>
    <xmx:D8mIY6sY8Z-AIMkmh9hycza_WuN5rvjcaHytnprvv7iBZp2T2U7sIg>
    <xmx:D8mIYyfnuPkS0DOvyelu4vy2FsETIs6X6qMYD0wangK4C0tBwW3cEQ>
    <xmx:D8mIY2FudD3uyw9oJk9WsEB14EMN0xAM2740_pWc8oTuWJpGsWPrFw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 08ED4B60086; Thu,  1 Dec 2022 10:32:30 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1115-g8b801eadce-fm-20221102.001-g8b801ead
Mime-Version: 1.0
Message-Id: <f5b0c1a5-58ea-4ac4-bea0-aa887d42d04a@app.fastmail.com>
In-Reply-To: <202211301556064978448@zte.com.cn>
References: <202211301556064978448@zte.com.cn>
Date:   Thu, 01 Dec 2022 16:31:55 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     zhang.songyi@zte.com.cn
Cc:     "Robert Jarzmik" <robert.jarzmik@free.fr>,
        "Lubomir Rintel" <lkundrak@v3.sk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-next] pxa: Remove dev_err() after platform_get_irq()
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2022, at 08:56, zhang.songyi@zte.com.cn wrote:
> From: zhang songyi <zhang.songyi@zte.com.cn>
>
> There is no need to call the dev_err() function directly to print a
> custom message when handling an error from either the platform_get_irq()
> or platform_get_irq_byname() functions as both are going to display an
> appropriate error message in case of a failure.
>
> /drivers/soc/pxa/ssp.c:150:2-9: line 150 is redundant because
> platform_get_irq() already prints an error
>
> Signed-off-by: zhang songyi <zhang.songyi@zte.com.cn>
> ---
>  drivers/soc/pxa/ssp.c | 1 -
>  1 file changed, 1 deletion(-)

I tried to apply the patch, but it appears to be whitespace damaged
and does not apply, probably something wrong with your email client.

Can you make sure you are following the steps in 
Documentation/translations/zh_CN/process/email-clients.rst and
resend the patch, with Lubomir's Reviewed-by added in?

Usually the process it for platform maintainers to pick up patches,
but this time please send it directly to soc@kernel.org (since
there is already maintainer ack) and I'll pick it up from there.

Thanks,

       Arnd
