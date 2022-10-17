Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4076008C1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 10:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbiJQIdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 04:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbiJQIc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 04:32:56 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCCE941D15
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 01:32:53 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 9A8E1320090C;
        Mon, 17 Oct 2022 04:32:52 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 17 Oct 2022 04:32:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1665995572; x=1666081972; bh=vfsvd9CTl2
        4WpjCJfpHOGgqX7cMRyQoeUUmvS7hw4JE=; b=yqB39uchBFDFdpU7edGGVG25dx
        aKw6fPf2wBTwUlR4BwOQEC0kLQQSGlCXUWwJx5WokhbT65KH3DLabU0FnAg32c+c
        a0r241gxfbuUQdLWRD+v4a9AoTmrlLDhE+Hr/6iZVTRuvkMDAix8/gHFKrjLh9Lo
        yvwAl6o0RIygPnL1iKCc7RZ4gI+rc9Wl+jpyKBW+OO3jCP+67C1Nb2hfZG1mC6QP
        5nsAdIB7EDPtUAydMkrEsPE5P6sCnsDm4y4n2Oe9/9OpOavGit/nE02YzRJV+z/3
        mL1gPaBxY8TSVMt8JX7y6994M6xW8BRsAeGcBwnlzUImSc9n5W3+E1BpwPzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1665995572; x=1666081972; bh=vfsvd9CTl24WpjCJfpHOGgqX7cMR
        yQoeUUmvS7hw4JE=; b=OSKairYEAThgyD5C5rrDOPvLSP0dihfwX2qci9L5skmm
        bEVHk1asvZjQTfWT0W3DI/GsrciSS5lnlBDQ7AO6DhVOpDCJ97gh2X12KsknYDIe
        mRnFXpk2xEamClI+Ug8E2BVA3Ivce/2aFej8DjesexiLrBavlOp1I1BspqYAegBr
        QRmhlgme8eR1KMrJMDoI1DOVOBeg0xc4jxWSpnludqUw/EXQ47Y7AOK7QGkuVRr0
        xLcjjuWzvuI86oSFH+fJJl4ytV+iaMQkOBb+4DtxfKsX9Qejy/7cp30wOoRJDsQF
        7wK4TmJ8YU6nkCQBoSiFGPteHzZiV+sOy+VM6bd3Nw==
X-ME-Sender: <xms:NBNNYw0hEFP63O-BD3foc-GyRizw-B6kRVwheE93QsKFsiQX7GNzCQ>
    <xme:NBNNY7HcgeEsdAoNIgH22LJ8Wt4gN06rxRrmDh9TwbBfXgV1zIjOiIlujFB8UPyfA
    KgDYERKoGqqKy6y3fM>
X-ME-Received: <xmr:NBNNY45VHpmG8KMkCh7zTyIV7lyzSPGsqbk08kh32XLp3G6pHNuP7fvVCd33>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeekledgtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeeujefgkeekgfeiuddugfefteeivedthfelgedutdetueeihfffkeffkeek
    tdetieenucffohhmrghinhepmhhitghrohgthhhiphdrtghomhdpghhithhhuhgsrdgslh
    hoghdpghhithhhuhgsrdgtohhmpdhfrhgvvgguvghskhhtohhprdhorhhgnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvg
    hrnhhordhtvggthh
X-ME-Proxy: <xmx:NBNNY51tk7rU4HjzNA4u-WW4H5L7Hp-RtElnEjE-9XBK7R5q6EL7LA>
    <xmx:NBNNYzF-QFR7ZqaqrVXyho8ltBZ6963r-M0p8722DJsH78WNyupKGQ>
    <xmx:NBNNYy9d6CRBUSaQEmpnuAtKSGeIZoU2ErKaIuU9eJFUhC3IpiOthw>
    <xmx:NBNNY47jq7wvr4dEs_XrbvtUKAwrcd9zytPqu2OO7aU4dat1HVIs5A>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Oct 2022 04:32:51 -0400 (EDT)
Date:   Mon, 17 Oct 2022 10:32:50 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     emma@anholt.net, linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH] MAINTAINERS: git://github -> https://github.com for
 anholt
Message-ID: <20221017083250.hlwrkp5heokitser@houat>
References: <20221013214638.31014-1-palmer@rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fanxg26yfezs7q65"
Content-Disposition: inline
In-Reply-To: <20221013214638.31014-1-palmer@rivosinc.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fanxg26yfezs7q65
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Oct 13, 2022 at 02:46:38PM -0700, Palmer Dabbelt wrote:
> Github deprecated the git:// links about a year ago, so let's move to
> the https:// URLs instead.
>=20
> Reported-by: Conor Dooley <conor.dooley@microchip.com>
> Link: https://github.blog/2021-09-01-improving-git-protocol-security-gith=
ub/
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> ---
> I've split these up by github username so folks can take them
> independently, as some of these repos have been renamed at github and
> thus need more than just a sed to fix them.
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 22a9acc7be07..6a4e8144198b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7003,7 +7003,7 @@ DRM DRIVERS FOR VC4
>  M:	Emma Anholt <emma@anholt.net>
>  M:	Maxime Ripard <mripard@kernel.org>
>  S:	Supported
> -T:	git git://github.com/anholt/linux
> +T:	git https://github.com/anholt/linux
>  T:	git git://anongit.freedesktop.org/drm/drm-misc
>  F:	Documentation/devicetree/bindings/display/brcm,bcm2835-*.yaml
>  F:	drivers/gpu/drm/vc4/

As far as I can tell, we're not using that git tree at all anymore, so
we should just get rid of it.

Maxime

--fanxg26yfezs7q65
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCY00TMgAKCRDj7w1vZxhR
xY9xAP44Rlk+M1ZDDq1r5GnPYDaArqSm2dDgOliX7sb+qhdc9QEA+KdlpOx2h3gR
kZi5h+rOKUKyjuwlMzV2U/fE/KzQkgU=
=OQNU
-----END PGP SIGNATURE-----

--fanxg26yfezs7q65--
