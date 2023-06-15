Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 411F5731E2D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 18:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235420AbjFOQtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 12:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236185AbjFOQtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 12:49:15 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCDAF2D5E;
        Thu, 15 Jun 2023 09:49:14 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 480685C0106;
        Thu, 15 Jun 2023 12:49:14 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 15 Jun 2023 12:49:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1686847754; x=1686934154; bh=0e
        k1jBDgMnsSC6f4mR2SRSNajWTw3nx/qz35iGSppxs=; b=hcQSL7qB8rsiUyRHpF
        LPBKewYfYGtrT13spd4Pq6rDzr00/gUS8w+hqpRrVhKMMqMbbx0WxmOl7ysf6Mbh
        +v7HpyGz7DQkjRO0X9qwlK6tZ8Tn8zQq3KXBOaB403uDAtejfAwIw4IFJpixMH/y
        s2Mcc6eVEKDdtm3Gi7LGcDH9lmqYT8Th88fLrxYwXhrnrbAqudDHiqyEGZpwXc7I
        PCSCmINk/+Du875lmI9kY5ngUc9hd6HRqO5ObN1SLrw+2/1cL3MHZ2DT90qoAQIA
        FhaMZ3OXXd3CDcT4QJsYWTQEUIpVCI+Ya3Tm941Zkc7CCmsO2OESiAwLROVW4xql
        7QpQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1686847754; x=1686934154; bh=0ek1jBDgMnsSC
        6f4mR2SRSNajWTw3nx/qz35iGSppxs=; b=TSozwJQV8tC1xbaLlgE95ub+wXrpF
        Fm84OvzPDs9t9cFrVJjY9bBK3EAFFCCB0frXAXxTFnAlvIL+hhxvCQD1ek1+JV22
        B1WBqO+VPPhPk4mQDmli3EicARvd1ABB73FujpTElO3dJpXphz4gveWbWGmyyiTj
        2N0ZYzlVGAyRGzFVUNx4Zld6+vrqKfflvEv7bACFpoSOkoL74DMxp6diGJSMq2zO
        DhYQ8MvZYKgPax3O12OREXYy7L3JRmga0yPy3as72JfQRQghz5a+90HmR0BoZ6VN
        3LHmxISC91IEPrkUsDhZkFW2jyxBA1krurZEkjH47LyT8obQ6PiSfZ+kA==
X-ME-Sender: <xms:CkGLZDo4Y78ywoqGiuM_St9aq07Bj7gus77s6x0lGY6yuMoiP9Shiw>
    <xme:CkGLZNooMQuhSEkiFiudWHmUR__S6KqZ59zCEPDYJ2_3ujEZXo4ozJpoAS4XErk5m
    RBPHZMQli0FzkHPtPw>
X-ME-Received: <xmr:CkGLZAOZ-po252SIuPdzk3wm2ijtiV25PBBt81i-RmwszeZR-LMi-S7vokmToaVB1Wqg9GrJy-yk4PhqEesEvA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedvvddguddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtdfsredttddvnecuhfhrohhmpeforgig
    ihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrf
    grthhtvghrnhepueevudehuedtkeevgfduveejueefvddvvefhjefglefgtdekveeugeet
    kefgleefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:CkGLZG5E0w8ipaQPXw1oZefEQ4VpV0oOkZEZO8MWc1Lgng1gwKk_PQ>
    <xmx:CkGLZC67GkKpZ_fO2xy7OnOGSNdMjnHWcrjpCbuT9r7RUABtEUecEg>
    <xmx:CkGLZOii2xxnp-BpsTtlmSnhSNn7d-avfoOGvJS1_b6wkx1j6aLr8A>
    <xmx:CkGLZEvI3fsP1cyh2VuohvnR6es29u5E0LPOcpcp9jzvfkkc7aWTwQ>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Jun 2023 12:49:13 -0400 (EDT)
Date:   Thu, 15 Jun 2023 18:49:12 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        m.grzeschik@pengutronix.de, windhl@126.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/11] clk: at91: clk-master: add support for parent_hw
Message-ID: <cpgz2cpsbref6khjvf2qtuu7qvg7r2kbkcaxjb3umzxjeka3z2@i243me4l57v3>
References: <20230615093227.576102-1-claudiu.beznea@microchip.com>
 <20230615093227.576102-4-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wkkxdt37famqf3bn"
Content-Disposition: inline
In-Reply-To: <20230615093227.576102-4-claudiu.beznea@microchip.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wkkxdt37famqf3bn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 15, 2023 at 12:32:19PM +0300, Claudiu Beznea wrote:
> Add support for parent_hw in master clock drivers.
> With this parent-child relation is described with pointers rather
> than strings making registration a bit faster.
>=20
> All the SoC based drivers that rely on clk-master were adapted
> to the new API change. The switch itself for SoCs will be done
> in subsequent patches.
>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Maxime

--wkkxdt37famqf3bn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZItBCAAKCRDj7w1vZxhR
xY0eAP0S1ZhFlNWRlQdoFeSt8+MWInAbeWCtsZyDch+tq9+REgD+K8D88nx9m1Sg
0T9zr9SzA13XmTasliSnhnBUOezhIgk=
=GoED
-----END PGP SIGNATURE-----

--wkkxdt37famqf3bn--
