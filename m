Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29E1D6F035B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 11:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243326AbjD0J1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 05:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243068AbjD0J1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 05:27:20 -0400
Received: from wnew4-smtp.messagingengine.com (wnew4-smtp.messagingengine.com [64.147.123.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF94C3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 02:27:19 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.west.internal (Postfix) with ESMTP id 7BCBF2B06722;
        Thu, 27 Apr 2023 05:27:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 27 Apr 2023 05:27:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1682587635; x=1682594835; bh=Di
        IG0SqQqwKC+QxzuzST+OM7ic3p060jotUTDIfc4ws=; b=Dn+Is4x5yrdGG9I/J9
        ApHGPFahxTBhzqskzdGrli7Yz+fBKHAK2zed1hSfZCngH8KV/gVRkUUC6i4Z8u79
        WNXzO0aUR5kkBcpydvtpxIGV+yubw/8teSuQrrcthxDYz8S83es01YH/2hETAESR
        Kc+BMRDQxzQaW/RNAzCQ/QHFDZYUPFRSvZu2jxN92wk+IhUCghQQiLcKqDvO4TCv
        QtxL45lnpq9qYhxRvv+uoSjsXMbrCEhdK2paHJerNkBHhirbz4LSPLvIorBOaxtY
        n3bn3P83y+l6uylpp+Gj9pdsLHl2cxcR2/8KYMdvVjFnuRQbmgrhADdmFtwlbpam
        X/9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1682587635; x=1682594835; bh=DiIG0SqQqwKC+
        QxzuzST+OM7ic3p060jotUTDIfc4ws=; b=O+IzhBOLswPqo4Q7DC7VEdKHjH2ST
        YxgfUQCbaKqV0420VrHPgYbUQ07TJH8HVIXtqt04TO1rkSRwxeltCm+NiBsgucuX
        /j/pDCTbeC5LuoF+5Ho5ZjusWXUCh9Q9XTk7cojkW+2LIXIV0f086JhdkygNq+Kx
        BnCFxPumMZgCt9biR9zcc60cEU+o5HpZLA/9Hh4+Ofiuv17fpQXqdh9040gTHnzV
        joNyjI6Sv7pqW/AGdeFN8rCrMx9tlM5URZqgAQHb35T4B1hyfSlxIWvAyeUVDtE3
        7czqih1jOrh3MDCPMhfcH2EEO5eKoOqz40dDLyMeU3iAfh7QLYdDmJJnw==
X-ME-Sender: <xms:8j9KZFAnOYGV5MesUxkBMi4Ak9sJrNKjWh60NIQsCeEthkUmA7UREg>
    <xme:8j9KZDi5XUQJem8w3r0LagYAAU8-S9Ns7t8bxQ30RROA6VeIlQubt70nLesyltScN
    Ki728lvwrsRVwSodos>
X-ME-Received: <xmr:8j9KZAmFUJeIeXVIpysJ_0IpkLZVovKjiFreZT0T1APdyJ-Djfq4UVZy5QkUZSlOQJGCpxmJ4zndSyIXHKoMCFVSVCagm54>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeduiedgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtsfertddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeeuveduheeutdekvefgudevjeeufedvvdevhfejgfelgfdtkeevueegteek
    gfelfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:8j9KZPwm_ntFwRHPNLGMFMoJi6qaU9SzEOKJ7BMiDu2K1QuhB40Izw>
    <xmx:8j9KZKTF0NZi-fKYzZVEq6Lxw3tyy0LUe60V9nSYDuzKLs4fMSRPwg>
    <xmx:8j9KZCYbjPQi9P-2RtB3hlfoaEKTYE2nS44fFHJoXaX-hKS6PEIm9w>
    <xmx:8z9KZLCfMxW6IqCEN2G3j3m-PI1tGeNIz98Hj7TwYEXIp1we6DTKopM1KDQ>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Apr 2023 05:27:13 -0400 (EDT)
Date:   Thu, 27 Apr 2023 11:27:11 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Roman Beranek <me@crly.cz>
Cc:     Chen-Yu Tsai <wens@csie.org>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Frank Oltmanns <frank@oltmanns.dev>,
        Icenowy Zheng <icenowy@aosc.io>, Ondrej Jirman <megi@xff.cz>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/7] arm64: dts: allwinner: a64: assign PLL_MIPI to
 CLK_TCON0
Message-ID: <4o243jwhbdfw32s5gzsbn4nhinicliugo4gqhh55lwxbfxkvkh@2jofbkdavewn>
References: <20230427091611.99044-1-me@crly.cz>
 <20230427091611.99044-4-me@crly.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qgslua4gfdtt6xq5"
Content-Disposition: inline
In-Reply-To: <20230427091611.99044-4-me@crly.cz>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qgslua4gfdtt6xq5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 27, 2023 at 11:16:07AM +0200, Roman Beranek wrote:
> Assign pll-mipi parent to tcon0's source clock via 'assigned-clocks'.
>=20
> Signed-off-by: Roman Beranek <me@crly.cz>

Again, you should be doing it in the driver, not the device tree.

Maxime

--qgslua4gfdtt6xq5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZEo/7wAKCRDj7w1vZxhR
xeKXAP9u1WrfKJfosG1ywij448ZJihQE5w/g08nQ3OOHuy8mxwD/TadcRTkLXYFT
CabMDNnhkfOFqrbngXbnseRYpdEFKAw=
=UrYD
-----END PGP SIGNATURE-----

--qgslua4gfdtt6xq5--
