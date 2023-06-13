Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D61E972DC77
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 10:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239218AbjFMI2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 04:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241157AbjFMIYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 04:24:49 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B24BF130;
        Tue, 13 Jun 2023 01:24:48 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 2859A5C00BB;
        Tue, 13 Jun 2023 04:24:48 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 13 Jun 2023 04:24:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1686644688; x=1686731088; bh=oH
        tuGXfObvG6JqogzKiY0jhHFJOWy6f1SPfbrwqsgYE=; b=i3/Xfi2I8OfeEVE4t2
        UI9bW7uDI6m48qaypn1OSSEMC4JJQizs2GNu4MP4EpeJ3yLe/IBtPJanKd96N43V
        yBOn73nJIs5WJpAzec+DO+7MLn0clCEa0zT3fRzb1iTNh7tmizFWsPphk+dAUAOQ
        qB59r+8RO2H5+qXEgHQwXsmNsRrsboczMCJmEk2GhDkl+887LbD+Xq0sy+9ZYebK
        cTdKCK5+yHv/Or72q6Gu8Ij2hwkiqrBjf01XC8oUCP7DRRjRCkCkKPQzsEwEsrTa
        TKl9ajH6stQrxZks1KqLIMRI/Qd6+EszrLhEjN3tghlbwlo6OG2xS2fSHX9S4wSz
        prfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1686644688; x=1686731088; bh=oHtuGXfObvG6J
        qogzKiY0jhHFJOWy6f1SPfbrwqsgYE=; b=Fvuv7iFcfzRoChsypLWevgOwbsjhL
        uBAGNmFojNMInc//nSd2wOZyKIckVwrVLs2pjfrDje9f2UqFUGMJ951acCZ+bKdZ
        BwAEgtk3uRoFfSPcd1KZNg9iBS609cULuLAZIuSR5D9qMdzzX5l7FXQMKa2vNpfg
        RQyJz1Uj2Jx02ESmlXgR/qGBMNa9iwaI2CoDdfimTHN3hBgH7yK5u0uhHRsR5O+H
        H6NsLv8e2mOQWXeZBpfIgaPbf0oLy1A8SKgwLpRcRiGHopTkQIyHhzF7ES1GfwHQ
        vYEU6CV0ttXZiPngZz0lMMUbXFoBgTr+NPHIxHmrS/EkjFKRz7pP8H4Ag==
X-ME-Sender: <xms:zyeIZHjVh6FYAEIgGiHJ4_x3EBnmoTy5Y0PyA0SPEjwPqKk_dYKKJg>
    <xme:zyeIZEDQNfOCD0l_0qOorQVKPvyaJe0DQSWCP3Dw6NAHMMQ3tCXREpXEey1mfIgr-
    1C2ovjit9iUzFhl_38>
X-ME-Received: <xmr:zyeIZHGDY1mZ9pHNSqdUuuyFG2zN5JuUKlhdvKT2b4Yl4f3fReN5atcJ8TlDCRUvmMwmofOQ6GzLyw_kX_fG0g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedujecutefuodetggdotefrodftvfcurf
    hrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehgtdfsredttddvnecuhfhrohhmpeforgigihhmvgcu
    tfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrthhtvg
    hrnheptdfgudekieeguefhleehfedthffggeefgfduueeihfeuueelkeevtedviedtvdei
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:zyeIZETphebno6GKA4cCEzEZo-IQo8ZzJ1HjaU6cG_Poh4xKBxVZpw>
    <xmx:zyeIZEwui7U6eXASVQxRxa16zZABB4mQsMHlkBszXPWNX8oolWMWlQ>
    <xmx:zyeIZK6a0W7xhTpIJbjebnOPGgHhtdaavBC2CFQbDPWyjSoOjHAIOQ>
    <xmx:0CeIZOtnkkcZc9yV37a4UeHmATOPs0y4fM3l1G6oKvrqgwTZ-LsG6w>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Jun 2023 04:24:47 -0400 (EDT)
Date:   Tue, 13 Jun 2023 10:24:46 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        patches@lists.linux.dev, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] ASoC: tlv320aic32x4: pll: Remove impossible condition in
 clk_aic32x4_pll_determine_rate()
Message-ID: <qiagoqg65b2tocnqgpd6svlsv2gthjodwq5yyg6mb3nk23smwx@dhjmsbiagl73>
References: <20230613011201.1166753-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kkh5a6zwtk6q5tyt"
Content-Disposition: inline
In-Reply-To: <20230613011201.1166753-1-sboyd@kernel.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kkh5a6zwtk6q5tyt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 12, 2023 at 06:12:00PM -0700, Stephen Boyd wrote:
> Smatch warns:
>=20
> sound/soc/codecs/tlv320aic32x4-clk.c:219 clk_aic32x4_pll_determine_rate()=
 warn: unsigned 'rate' is never less than zero.
>=20
> Cc: Maxime Ripard <maxime@cerno.tech>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202306101217.08CRVGcK-lkp@i=
ntel.com/
> Fixes: 25d43ec352ea ("ASoC: tlv320aic32x4: pll: Switch to determine_rate")
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>

Thanks for taking care of this

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Maxime

--kkh5a6zwtk6q5tyt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZIgnzgAKCRDj7w1vZxhR
xWlHAQDh6MlBFURx5GSBlD+YAUwiOewdZzgg4uV/hhl/zV2pygEAjvl95latE2uM
E3gmQLfoQxwYRTDXoYD+Deg2DDx02wk=
=MqzC
-----END PGP SIGNATURE-----

--kkh5a6zwtk6q5tyt--
