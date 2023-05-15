Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38864702C17
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 13:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241483AbjEOL5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 07:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238242AbjEOL53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 07:57:29 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 762B526B6;
        Mon, 15 May 2023 04:54:44 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id D091B5C010F;
        Mon, 15 May 2023 07:54:43 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 15 May 2023 07:54:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1684151683; x=1684238083; bh=YN
        2hehfhebmIswf1/JIgo//Dtk1KbSx4NssivhFQ048=; b=dkUb9tOVLQsK1ucevf
        PxqBQ9/HL1CaFY8DERKLlLvBKWesFX3to23gFbHHn/PU2hCbKbUsGWGnovWK+sdO
        mZTMnndEiGxt+KDOqwPtF4gu51pGo8iFmjsHragoMjW9Sw52DKTj6yXPVeR+uQY6
        BuXIFC777I/xSBANw72S9AUmatINBBrPtw4BPhsksGBnezW7BDkxUuQ3iJzZuMs1
        ew/ltpk44IYQDTEQxuAQppC1K+ejD+PfaPsWAswv49cx0mLvST7LeDyMc/lGSJKL
        oi5j/NYbZgX2/4tWeEQtdVEkIhaanQIZkmRJFIbyRAUA34HZWhH0+2anhZfEvVRT
        nPZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1684151683; x=1684238083; bh=YN2hehfhebmIs
        wf1/JIgo//Dtk1KbSx4NssivhFQ048=; b=DTiL8tEDchy/0FstCPucVIhziirSW
        yO+pzo+dbqz7u35lHvfvktCJDhPnKbn/YOgJ5/tG+zHUye7C3t3Pt2TxcpQpn+VL
        HNo+mcpzemSMyVU6f8bf6Iyq3JrVirlKDnlHDtilOoaIIAci3GZS4D2VhEgl94eX
        Htn4XjGmXRa9sUxPS3r5Gzg/XH83AV9/BHI/SYkV6T0KxAmHuGWjOl/RC4ljEEGK
        V8fXpxAH0rxHl69b99hly5vW1qjH/VpHqMdYZ3jSF7AfJCPDI9YnTcDpQDMjPIrg
        Y0I9Wc8WdeFo+9ALMuxMlrzC+6hhHOGNtkGNOqe/7HfAAEIaspoGZdRtQ==
X-ME-Sender: <xms:gx1iZF9En5sG5LkrrOiCKPNbCB9Hz7bpGredNE7j3ZP5y8vQdP0drA>
    <xme:gx1iZJuSxwvB1bqp0yi3dsxfPvigvS4VJsahzndOe5W6qEj65kteXw2wcKfU5pyDo
    fu3bJbGnZgfXn7cr1s>
X-ME-Received: <xmr:gx1iZDAG9dkMp2Sl2_qOD6x-OG_XDWwdwD76nwYNeGquJs8jvxuj23SIDwEGslxctBead6w0m696ZVKyQR-Z6g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeehjedggeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtsfertddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeeuveduheeutdekvefgudevjeeufedvvdevhfejgfelgfdtkeevueegteek
    gfelfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:gx1iZJcuBoqTUTRg551tq_CoQwBJNHWl99GKruhtBlLuB4seTxaO8g>
    <xmx:gx1iZKNE9XMXZTU1acdRHkBpH2HnRBQy94WfighePUtG77Wvav3KCw>
    <xmx:gx1iZLlHQ9wB4S6h4qZhBskAiJt5F6zZLc-wAglyBVYcl1x3smwM3g>
    <xmx:gx1iZHsBDIWUXjk5uflsw_7BiqdU9XlqMy7dUXeqYejdcb-1yPZGKg>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 May 2023 07:54:42 -0400 (EDT)
Date:   Mon, 15 May 2023 13:54:41 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Vasily Khoruzhick <anarsoul@gmail.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Ondrej Jirman <megous@megous.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v2] thermal/drivers/sun8i: Fix some error handling paths
 in sun8i_ths_probe()
Message-ID: <ucnnixemxbpkjlbyenboydicslozt5jpyjjfbd4gjk4oye52et@fgyd3zqdqsh2>
References: <a8ae84bd2dc4b55fe428f8e20f31438bf8bb6762.1684089931.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="va3mhj5nkg6jbttn"
Content-Disposition: inline
In-Reply-To: <a8ae84bd2dc4b55fe428f8e20f31438bf8bb6762.1684089931.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--va3mhj5nkg6jbttn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, May 14, 2023 at 08:46:05PM +0200, Christophe JAILLET wrote:
> Should an error occur after calling sun8i_ths_resource_init() in the probe
> function, some resources need to be released, as already done in the
> .remove() function.
>=20
> Switch to the devm_clk_get_enabled() helper and add a new devm_action to
> turn sun8i_ths_resource_init() into a fully managed function.
>=20
> Move the place where reset_control_deassert() is called so that the
> recommended order of reset release/clock enable steps is kept.
> A64 manual states that:
>=20
> 	3.3.6.4. Gating and reset
>=20
> 	Make sure that the reset signal has been released before the release of
> 	module clock gating;
>=20
> This fixes the issue and removes some LoC at the same time.

It should really be three different patches:
 - One to fix the resource release, that can be backported to stable
   releases
 - One to switch to devm_clk_get_enabled
 - and one to change the order of clock enable vs reset deassertion

Maxime

--va3mhj5nkg6jbttn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZGIdgQAKCRDj7w1vZxhR
xdmkAP9r4P7s+lWbUxXVJ+/Zx6Wfdpi7/HSi+H/K9rivRGupwAD/VW72Kfz4XlEp
oAzjFCvvawU+fc7nkk/gA4tjCfH5MQ0=
=KQEQ
-----END PGP SIGNATURE-----

--va3mhj5nkg6jbttn--
