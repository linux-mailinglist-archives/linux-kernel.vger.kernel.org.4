Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4E8731BF3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 16:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345140AbjFOO44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 10:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345162AbjFOO4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 10:56:32 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B6E2946;
        Thu, 15 Jun 2023 07:56:31 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 8E8CA5C00EA;
        Thu, 15 Jun 2023 10:56:30 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 15 Jun 2023 10:56:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1686840990; x=1686927390; bh=Hy
        mpvAbMAmDlsKdR8DjVa+pRbRNPZ2oT5iCjFzqTR3A=; b=uKrbjIOhZVp1jYUgRn
        f1vHjHGwkLukMQKH4LxRLHyfQwEq2ei9mCkT/yVl1JFjzETJDpfiQAtx2OLhZ+eI
        avk4VSDE445do/Gba0+z8DTiTY0YSrkLhEhsUIYdEpfHevou/F7JhCCsj6QlaGsK
        4t4Bsy0j6yYCi9Ep8WtjgkX7wWiIQirjWI6HpCK8acX6q0045NjznLorAshlbEyZ
        bFRKVoPr8fdHmHRJ6PYmnTpTZOdwrfnIco+Sp6qaIiMNb19GLN+NcMzIBqYyxeRQ
        JLR55/y6fnQWwZ8OQXEM8t2dsO4ff+XzgjtUa6n0Nv2n3AxoK8sb3sR/Mf9Ois0F
        n5yw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1686840990; x=1686927390; bh=HympvAbMAmDls
        KdR8DjVa+pRbRNPZ2oT5iCjFzqTR3A=; b=NJ0hJacgy1irx6Nn+CqatmljXReEY
        XldIlSONuBxjccmQZ8J9Sb6ApE+KyxjS9tMIYBpfXAqWTNXGv1NwQIPfJorG/etD
        NP8JlW+hvPJum+WHz13qL0RKoqMIjRxPmjZRfUhoRZedGgdNQTK0KrRaN5cJBoU/
        /M/ebHBaKlLbQ6jrLcJY/C0YMMxBscIa1bPQtqyONVlp/ho/DKXdh45qRnRBzhR5
        i86i49500S5j+mV9Mg/ItAK66pr3ANxACoClqXec7MVdm1XpF1PiPwnFOmrR1SVf
        oSVWmtwtrXR8zKScamct+oGo4xKMUyp4u7pg2FjKJe46Gy2xkIJxZnn6A==
X-ME-Sender: <xms:niaLZEWJiENINwtp_xjuWgrZ88818hZOJtgL2ASkUVcnlF3FkPf83Q>
    <xme:niaLZImMCBYLJgSudmm6AEuFiPI5g8Ibh50D65swL8A9lqOPpXpMe-4G7y4719egi
    n5Vy7IdRuqsBYOV-wc>
X-ME-Received: <xmr:niaLZIZEk2N3QGeEfxxqGul504WmeAW5sOdkoy31s5Qww6t8zAehcAsbIRoSXxYPf58LKc9XYbWBjJlC4pdmTA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedvvddgjeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtsfertddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeeuveduheeutdekvefgudevjeeufedvvdevhfejgfelgfdtkeevueegteek
    gfelfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:niaLZDX9r1lKvW5rTDkpeFHwjlWRN30137-DCKYIdjBY_b2kab7OMA>
    <xmx:niaLZOkxjOxbAAAPyjCqYQNt2ZtwDLwEFC-ByBXFbnP-5BYH1AVlKA>
    <xmx:niaLZIcyOz6gU9H2eXVinSlRUx6W5k9BEZg7t0NfcPdyWAySYALcHQ>
    <xmx:niaLZI5aVPPO-4zWlzu9ci8hZx1OhCza-P-e4alrdKMtTZaqXUdjcQ>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Jun 2023 10:56:29 -0400 (EDT)
Date:   Thu, 15 Jun 2023 16:56:28 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        m.grzeschik@pengutronix.de, windhl@126.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/11] clk: at91: sama7g5: s/ep_chg_chg_id/ep_chg_id
Message-ID: <gzkzaixuq564oouflxr22ykvt6zqxpzukeqe2rlmao6mjpb77d@iakcgpryefii>
References: <20230615093227.576102-1-claudiu.beznea@microchip.com>
 <20230615093227.576102-12-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vunwytje5gyuocfj"
Content-Disposition: inline
In-Reply-To: <20230615093227.576102-12-claudiu.beznea@microchip.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vunwytje5gyuocfj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 15, 2023 at 12:32:27PM +0300, Claudiu Beznea wrote:
> s/ep_chg_chg_id/ep_chg_id in documentation of master clock structure.
>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Maxime

--vunwytje5gyuocfj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZIsmnAAKCRDj7w1vZxhR
xY/nAQCKT8GJIFCw8Bskfsw+Xf00JI+DPpxH9hfuRtnzyRTUAgD/TdY/S5s8nC3B
dW81ywiH/ge4UKlqLFC2y6uiey4W8Qg=
=6cVe
-----END PGP SIGNATURE-----

--vunwytje5gyuocfj--
