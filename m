Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41FA672C44A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 14:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235034AbjFLMcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 08:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235011AbjFLMcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 08:32:15 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 938CD10DA;
        Mon, 12 Jun 2023 05:31:45 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 851995C0130;
        Mon, 12 Jun 2023 08:31:23 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 12 Jun 2023 08:31:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1686573083; x=1686659483; bh=18
        ZmLcFszkml7bXV6xlP2cbQVd6SoNIPAXzHdGblAUo=; b=i00L+HAvsds1HR+Nt8
        U5hK/TCO+llTHSmmmGoOosh+8LtiCcZY8IDGJXozWJdX9Y2ea1syogRnfTYFs4BG
        Ly07en1f0lcAbq33nP7XYpjVwqVfgqtx0bHwD0ddsEG89PHCCdGiftCu4s3Xyq5Q
        dByucynJpaiLtI5MZdxTiHgwokAOcN2YKmDyh4px+X0TAW0fvmQtwDCqDSVuUe5C
        pHAgT5rAqIzIwd9VR14iiSyWzjfyzBltWGzqnFIfATvGc6GhdqCmhgCEMOc6SSwB
        ADXtwZH6OAIzPO/Pp5HI1q6f1jwyDMUYagxEjeaRB5AEaj+9xbdI5QbIdaFxYVOg
        WXDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1686573083; x=1686659483; bh=18ZmLcFszkml7
        bXV6xlP2cbQVd6SoNIPAXzHdGblAUo=; b=NYRwSONRkr5CKpdTIt8W3yzSlgVW+
        Z5cFqjOygHnJ093+g3AnUKT0YX7VDLtyLTZa+kKGAyZh8CSEO78KCGkJ9Ya2CeJN
        aQiXLboLoWMtfZoCbmkATLlF9Q8M4ffuBI2SkgupdYtCTIAx6FveQ+medpZMDm9c
        uFLJnox5bEGPmBeJHIcdwf7TXbYsa+591kM6eI0VLlgGjzv275pYEQ4Bf91wdAVB
        24+MyRfMHH+SzcBIfgiMptmAYYc956SrBuEFrDV9sKbIugC/4Py0KnnCIswqa6fl
        T4aN00qCdPEiJVWFxiAM02rcdeEZEQ3aQRMjDRElFO+yBzm+12joQszEQ==
X-ME-Sender: <xms:GxCHZDeugUV2gPbF-Jeb9t-H_Kwqk695K5F-bQcrGAUeKkGWSWQFAw>
    <xme:GxCHZJOzZq-cJ357p5MUhMB2_P-0e04ARW5_YH_8pBn5UP9Pj6RLQkdRwg2ytF5Cg
    WGqAspPSyEp4iqP7PU>
X-ME-Received: <xmr:GxCHZMjf9PCPel29z8amu9kkCPG5QB7zNYlIMUavPMbaipUqzAcuaKHLyz2X2p7g2YB7FxEHFg6VZTdR5540oA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeduhedghedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtsfertddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeeuveduheeutdekvefgudevjeeufedvvdevhfejgfelgfdtkeevueegteek
    gfelfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:GxCHZE9klJqOWO5JzTmR4_1Y2hGVFOZu-7EbvTSwPQU3r1KPwTfTSQ>
    <xmx:GxCHZPtzZVrtgxRmnsJqrK8KOFZZwude36EsVg_HCuFonsEyrgPUiA>
    <xmx:GxCHZDGAsLnDXR8CyH-_nmnIWazENhj66yWBQKSvWPIYz60moBIPEA>
    <xmx:GxCHZAn7zPw7dPcXEX_80-iyBsl0I5ZU96xwtsSVow8PFS7pyEsvKQ>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Jun 2023 08:31:22 -0400 (EDT)
Date:   Mon, 12 Jun 2023 14:31:21 +0200
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
Subject: Re: [PATCH v2 1/2] clk: sunxi-ng: nkm: consider alternative parent
 rates when finding rate
Message-ID: <sfni3vehkhotsqrrirklhzrxzkcxzkq6nbtqokeab5if3jgm53@frh7z3iowsfe>
References: <20230611090143.132257-1-frank@oltmanns.dev>
 <20230611090143.132257-2-frank@oltmanns.dev>
 <87edmh12s7.fsf@oltmanns.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kkj73vrcelww3r3q"
Content-Disposition: inline
In-Reply-To: <87edmh12s7.fsf@oltmanns.dev>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kkj73vrcelww3r3q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 12, 2023 at 10:51:52AM +0200, Frank Oltmanns wrote:
> > @@ -28,12 +68,17 @@ static unsigned long ccu_nkm_find_best(unsigned lon=
g parent, unsigned long rate,
> >  			for (_m =3D nkm->min_m; _m <=3D nkm->max_m; _m++) {
>=20
> According to the manual M/N has to be <=3D 3. Therefore we need a
> different maximum value for the _m-for-loop:
>=20
>         unsigned long max_m =3D min(3 * _n, nkm->max_m);
>         for (_m =3D nkm->min_m; _m <=3D max_m; _m++) {
>=20
> I suggest that I add an optional member max_mn_ratio to the structs
> ccu_nkm and _ccu_nkm. Optional meaning: Ignore if 0.

Which workload is affected by this restriction?

> >  				unsigned long tmp_rate;
> >
> > -				tmp_rate =3D parent * _n * _k / _m;
> > -
> > +				if (parent_hw) {
> > +					tmp_parent =3D optimal_parent_rate(rate, _n, _k, _m);
> > +					tmp_parent =3D clk_hw_round_rate(parent_hw, tmp_parent);
> > +				}
>=20
> Another constraint is PLL-VIDEO0 rate / M >=3D 24 MHz. Therefore we also =
need:
>         if (tmp_parent < 24000000 * _m)
>                 continue;
>
> So, we need another optional member min_m_times_parent or, for
> shortness, maybe min_m_parent. I could use help finding a good name for
> this.

Again, if it's not causing any harm I'd rather keep the code as simple
and maintainable as possible.

Maxime

--kkj73vrcelww3r3q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZIcQGQAKCRDj7w1vZxhR
xY3hAQCtAk7IaNBuR32MugoIudSv2GZ8z2nwVAfFQtk5TRpjdgD/f+kcH1jhaq0d
ykaty48CnAYO/yQevebm/aotTXaQgAA=
=VEfS
-----END PGP SIGNATURE-----

--kkj73vrcelww3r3q--
