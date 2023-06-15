Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBB12731E8C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 18:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjFOQzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 12:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238896AbjFOQys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 12:54:48 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5455430D5;
        Thu, 15 Jun 2023 09:53:27 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id B59585C00C7;
        Thu, 15 Jun 2023 12:52:12 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 15 Jun 2023 12:52:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1686847932; x=1686934332; bh=mJ
        6xkMen+YO+/tCBYQ44GBlPDIDZ0CuOIbvbOv/3WAg=; b=43o1U/eM6WElwxWSA6
        +3BHxnr5Cq0zwTARkQPygKLU/+Qv9ihgqZMvXF1JL84j7O+vaccr9mIBYtwqyPZR
        d3aVIPaXYMU2PLBnzyaZrV5MK1jUCkxfQ2mcSuU0Z6iVtChe8w7J06iS2zkqufqT
        VS8uz2/QBCbn+XUhPHUeCt6DAB5tt63McdTDGK5p2Uee3Gg0fg+ijUJlpWtbYgjh
        sfpLlls7RcG7K5OUcog4eLr+D4UNpqms3XRAsZC4iQa1zCBlM7zqeMX/E9/YSw1c
        CwNYyIE1my8jWp//IpiAf4z5QAyt20tFBxtYv5bFfGSCsYhxV2JAOxh2j2uxhPpx
        8y6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1686847932; x=1686934332; bh=mJ6xkMen+YO+/
        tCBYQ44GBlPDIDZ0CuOIbvbOv/3WAg=; b=XNq+8msSpGau4HjnCa8Z/2RWwTn1d
        06+/bKo4q6Xu5cGv0F//dv6voGvdhnLLqGqVSf1k7lNaJFkkj6FhbPSxyd8HBcKh
        JakWCM1Sec/r1731/Xr2JOMZbuhxDWr1fgebN+72j98sUU/FzlFSUAPZZb+JDFad
        JPGi6lwGnYNCPTGQy/Amh9oGFVeMM3SBVl80BYvD4JSQ9IkRmyfE6PiDTq83TmRF
        HsDjAjrfOci1K1LLcjKlCb86GeusvMsa6onkcbnWobzmn0dirF5w+lzhCTPCdORp
        XX2BLEDRK4ZCtY2DWZCfHPxtQdYVWRBmiV8a2Qg2dICRzXD7qJEeMbY9w==
X-ME-Sender: <xms:vEGLZO2HIZEARDhIhbt8PGyyRfu1cchzjF6ZNVOLyg8A2n-OU81XZA>
    <xme:vEGLZBHq1wcYUJVF9nsNhdcicJ293FcLVDYtUEFwADMOxOxYolsiHcljOjRVOA0EX
    XAH2O56o5CZnh85n7Q>
X-ME-Received: <xmr:vEGLZG5HRtAzx8TY48RfUjoyFzOJSq_EJZb7e0EcAE5JNcxyfozSV4GUtr600Njj3HS-1iTAImF5RUIMuUnuJw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedvvddguddtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtdfsredttddvnecuhfhrohhmpeforgig
    ihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrf
    grthhtvghrnhepueevudehuedtkeevgfduveejueefvddvvefhjefglefgtdekveeugeet
    kefgleefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:vEGLZP2pZFRw1xyoeOdxQxRXTx4VVxxeyxljeesS1tEUX4AnGtw7mg>
    <xmx:vEGLZBFzFbdycdV0baTfsCGf_KQ9dPRPJ2Zvzqn9y-VeGwF_ZBpgKg>
    <xmx:vEGLZI_gFYz_2Tmna2z7wE40NuklNhWM8z8KsUcGWboN04lEb5e-rg>
    <xmx:vEGLZHbn7UPDvOBFMZKtE1stkYGP-LltPNQX9xGXJWSr0ASJ_kuVPg>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Jun 2023 12:52:11 -0400 (EDT)
Date:   Thu, 15 Jun 2023 18:52:10 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        m.grzeschik@pengutronix.de, windhl@126.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/11] clk: at91: sama7g5: switch to parent_hw and
 parent_data
Message-ID: <eykl6xmkojjjqju2fxyoadrgj22aadcognmirt2kyhssfyeh5c@glu2eacwkaq4>
References: <20230615093227.576102-1-claudiu.beznea@microchip.com>
 <20230615093227.576102-11-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="b6ft4lb6p72zt34b"
Content-Disposition: inline
In-Reply-To: <20230615093227.576102-11-claudiu.beznea@microchip.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--b6ft4lb6p72zt34b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 15, 2023 at 12:32:26PM +0300, Claudiu Beznea wrote:
> Switch SAMA7G5 clocks to use parent_hw and parent_data. Having
> parent_hw instead of parent names improves to clock registration
> speed and re-parenting. Extra time saved on registration is
> ~250us when running at 800MHz.
>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Maxime

--b6ft4lb6p72zt34b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZItBugAKCRDj7w1vZxhR
xZjVAP494WqCQFeGFN522UvNGP38XORsptssqszm5za6qI0kOAD/UrUEZIzOqdTb
cPhbMuEN5J2PqkVzCDJFy9Fd70g5gA8=
=v9/e
-----END PGP SIGNATURE-----

--b6ft4lb6p72zt34b--
