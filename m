Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D83FB693FE5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 09:45:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbjBMIpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 03:45:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbjBMIpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 03:45:31 -0500
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6026E10C6;
        Mon, 13 Feb 2023 00:45:30 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 84ACE3200903;
        Mon, 13 Feb 2023 03:45:28 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 13 Feb 2023 03:45:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1676277928; x=
        1676364328; bh=CHr6ZXr+PKDm6XjaoSQUGvnP/21g+79OjDTwDq5gaPY=; b=W
        t3ThRa6m8G//ZEGPBt9bSSWQHtwhnV+V66r8PioCLDbu2gujONsSUIE6N7CaMz8n
        ky2KFbzjefwT+/SKdn5N7Hs5kcanFKFDxmSDuNwwUF+1JMt6i/XtTjrGoyiU6WHE
        ZPg80dNS3oXlCNbStquw7YzXLUjfuWiVAoXw17rwPPDa9Cw0/bQwWXNgz4PymR3B
        HDYjzC19w2gxR6IRQl3+u5X9lzRGR742qBYNwugmKqE0UmSvA7uyi/F66odrIbHY
        1m8Y7Y9taEsgdqPPvpR0qDQTfcLrWboPvxK9BoqDzdFDQZDCW/k6XO/eyrkNFpcS
        zTpUGZzmPB0KfFlm+GfUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1676277928; x=
        1676364328; bh=CHr6ZXr+PKDm6XjaoSQUGvnP/21g+79OjDTwDq5gaPY=; b=U
        3B8svi7ofTzNzNfCrAkG5k+OjjSV6n2kG450pJCl56tjYBA/tn63V0XsL6DCIZNf
        RWG7zesab0Z+Nxa4xd9OQuLFKTOmdmlF4tLUheQxeGtwZCh80zmaRTXKjeGtNb6y
        Nc4U16cHZaseGwb4xi+mXt74vqE4mTUfsIdd8NqFa4eX1hS5UDXoOQgVmUd6+X36
        W5KwL5iVYYbdIVBwpB3NLThPZHtf/IUW0o4lYCPMLPD64b6WGxnkG7w4Qa5LsrGb
        oTWrqf3qOwKzwDBd6BHZLmOELaIA/T5xOQeIvFZCidmSUeVyv/v1Sv9R5SsMN0pD
        SLp6d1fwrM40ctXRApsZw==
X-ME-Sender: <xms:p_jpY0Kmk_nnZfqC7dkLu06A6-ZB0R4EvAxbU-cR7-YIYhmYcwfgEA>
    <xme:p_jpY0IyC7SgFeAu1hYO5A0vnxHENzQ4PDfyFKNXNG3iiGOOqsjPbQ9Hv6gUnT5Md
    EN83NUt_yQuF59rHOU>
X-ME-Received: <xmr:p_jpY0sKJEAZ25PyphufYsur7gkQrbXalkNswmtuZwDHFsdPwW7Bu5vOJTKz5nQPRcIIxg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeitddguddvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtugfgjgesthhqredttddtvdenucfhrhhomhepofgr
    gihimhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtf
    frrghtthgvrhhnpeetgfelgefggeekkefggfeludeiudffjeffgeevveekjedukedtudeu
    teefteefgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:p_jpYxYwn3ytOO-2l-lqxezN2qmW_yIOcHhdbFAUi1_Flkpi3oQCAg>
    <xmx:p_jpY7YBh7lz6U76wlAhWJXkGHIIg07pBuH55d-7fcxarpyFrTtdrQ>
    <xmx:p_jpY9DaszLO6-KEtbb-GbVPbzJTza2fDaXjtbd4D4JgL-k_Vf4ekw>
    <xmx:qPjpY4QLNbGa4x2nK2jJAPx-hBvBn7kR_0Za636p63BVIzYe-vgb-g>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Feb 2023 03:45:27 -0500 (EST)
Date:   Mon, 13 Feb 2023 09:45:25 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Andreas Feldner <pelzi@flying-snail.de>
Cc:     Andre Przywara <andre.przywara@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] pinctrl: sunxi: set minimal debounce on
 input-debounce 0
Message-ID: <20230213084525.gr4urlvygsmonati@houat>
References: <Y+kuD+/v3+N1vwxR@debian-qemu.internal.flying-snail.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <Y+kuD+/v3+N1vwxR@debian-qemu.internal.flying-snail.de>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Feb 12, 2023 at 07:21:03PM +0100, Andreas Feldner wrote:
> sunxi-h3-h5 based boards have no support for switching
> off IRQ debouncing filter. This would be the expected
> behaviour of value 0 for the general pinctl parameter
> input-debounce.
> The current driver implementation ignores value 0
> for input-debounce, leaving the chip's default. This
> default, however, is not minimal, but equivalent to
> value 31 (microseconds).
>=20
> This patch does not ignore value 0 but instead makes
> sure the corresponding IRQ debounce filter is set
> to the shortest time selectable, i. e. the fast
> oscillator with a divider of 1 =3D=3D (2 ^ 0).
>=20
> Fixes: 7c926492d38a ("pinctrl: sunxi: Add support for interrupt debouncin=
g")
>=20
> Signed-off-by: Andreas Feldner <pelzi@flying-snail.de>

Like I said in the other thread, I don't think that deviating from the
generic property semantics is a good thing.

Maxime
