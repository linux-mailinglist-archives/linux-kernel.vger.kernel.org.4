Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC132725F55
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 14:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235424AbjFGM17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 08:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240469AbjFGM1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 08:27:55 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA2F1BDA;
        Wed,  7 Jun 2023 05:27:54 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 9843E3200941;
        Wed,  7 Jun 2023 08:27:50 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 07 Jun 2023 08:27:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1686140870; x=1686227270; bh=/1
        169bcX/O7cbil0YCwg8r2k4LkhwgcSR32DXzp12J0=; b=RflaOYKFt1vhwhMW6S
        G1JQSFkuE21Oo/7xLPvc1ISuJvZabK5Bx2VwcH+8KIgVMjHnZs7HHSZC8qWsuxmI
        8U3dVaYsrY+84Zqe4EKHXZEMuWYa0EJ+FvG3DDKTWfhGW91/X9VRx/Do2M+LwGxG
        AaJxCPnVJeErZi2RXdzClKCywahJLSIf8B04zb66mqNh0ZzIHdOzVIs5iiqZHnDj
        /UNohFoxgebHRzdmzwSgj/UDf8SIR5md5crtY3Hp0N+BvNuhqclLJUKpaxitlG1k
        JK9er9LB0LmLRyBY+D3YeR+sBOrL7+VOYhO6TWsfrtfnHV1tS/d0CFa1jwIMbbk0
        hvVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1686140870; x=1686227270; bh=/1169bcX/O7cb
        il0YCwg8r2k4LkhwgcSR32DXzp12J0=; b=KrAwFCYhzFrSNFYDnDByFpjNonwQz
        ua6P+cEAuK3ExFCIqgMYz0K5vlj1GVTVS+V9L7Zq/TYLlq3b41otF8zF8KAd53QS
        t2qF8+zbsQAqFbFu64DFDCmPJAZGqxo/58zev+f9n+oMuSFIskiEypJ5YuhZ6ia5
        TFFjLA+9sNrqHbDNBeSlQEn1NribhNIvDyJHHaM33NZCbevGPZ3PZZBUGaFhhRzp
        fANpkwtvW+bfw82N2z7/6OIZbu5IxMkBw2zPbS+/Z/rjOoMva/P810eUodfH7V8G
        P/6lZlJv4y9pRVJXEIrK0raaoQMeeAVbRjANReGpEdMzz/0iSiLk8HDSQ==
X-ME-Sender: <xms:xXeAZIzUn8ZhQYNkr2Ctb7MhHPzhx-DneWnfsj9okIMyjcaTQhdO-Q>
    <xme:xXeAZMRjCcwIIgXpWXlH4UFoDyICBf5fiZGbjT7kKvZ_BfDDse61E0m98Rc4Ik2eF
    MjcfDPFNAJZdczUOd0>
X-ME-Received: <xmr:xXeAZKXqsTdm_xq_cuxl9YMf0FQxL7i1I-8pLYFcWJotIFJGcewXMAe1heuc3is4aqxcpgb_emlNqcddEhVeQg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedtgedgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtsfertddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeeuveduheeutdekvefgudevjeeufedvvdevhfejgfelgfdtkeevueegteek
    gfelfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:xXeAZGiSkDpoHuUiDAoWmJvMqaUOxkGT4ZNBjn1NSXXmtormPcSwrw>
    <xmx:xXeAZKCKOzcNVNRcE5yERrh0kisivUGPW5I9S9yoY-LgB6hhFD45eA>
    <xmx:xXeAZHJiTA_MXy6oRh3VeiIGcTQ--BBbGZi1qHrkQigDT87b00YIFw>
    <xmx:xneAZO4EGt56rA9S8sAJ6QlMU4nK7a--3HMp6CMvJy2YLuiw6_SZ0w>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Jun 2023 08:27:48 -0400 (EDT)
Date:   Wed, 7 Jun 2023 14:27:46 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Frank Oltmanns <frank@oltmanns.dev>
Cc:     Andre Przywara <andre.przywara@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Roman Beranek <me@crly.cz>,
        Samuel Holland <samuel@sholland.org>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 0/2] clk: sunxi-ng: Consider alternative parent rates
 when determining NKM clock rate
Message-ID: <vvmdk3fqtjt3jspxgvlbypdxajchymydshya5b5ivk3wfodwwr@yyi26m6toosh>
References: <20230605190745.366882-1-frank@oltmanns.dev>
 <87legv2093.fsf@oltmanns.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uuxo73wcgiod7tfb"
Content-Disposition: inline
In-Reply-To: <87legv2093.fsf@oltmanns.dev>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uuxo73wcgiod7tfb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 07, 2023 at 09:35:20AM +0200, Frank Oltmanns wrote:
> So, my question: Is spending the 30 ms fine or do I need to optimize for
> speed in order for this patchset to be accepted? Or is 2 ms also too
> much of an increase, in which case I'm out of ideas. :-)

You keep mentioning it, but it's really not clear to me why you think
that both are intertwined, or depend on one another?

What's wrong with just merging (some later version of) this series?

Maxime

--uuxo73wcgiod7tfb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZIB3wgAKCRDj7w1vZxhR
xQGDAP9ZWebC3BinDPK4gGWLRjD0HNZE0Gw5+meDWojq2+LmcwD8DB3cp2GP9ALZ
r3Q4b6tCW9B0o8N6153GQBAVONzS8AY=
=HfoE
-----END PGP SIGNATURE-----

--uuxo73wcgiod7tfb--
