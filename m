Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B44072C3E0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 14:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232246AbjFLMVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 08:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjFLMVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 08:21:04 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E746A8F;
        Mon, 12 Jun 2023 05:21:03 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 5CA985C00DE;
        Mon, 12 Jun 2023 08:21:03 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 12 Jun 2023 08:21:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1686572463; x=1686658863; bh=CQ
        ngQrp3m88sfmNQ6jwb/0MCwpSvf6b3yAjboq72bpA=; b=eGsRRoLH5t8ydsG2kG
        3wVfFqAXc8gTdaQYlJOkHzdZhJwr6veVnTPbwn96vfiLfswW8BU41MUdniRuMRmp
        Nfz2cydtyf3iiZPGKHuRVEj5/h02Xl/YRIKh4HKgKFmD8AZls/VSLh8uXILGxBlS
        eLVhc2i+lWq8g8L57/CnjUwdiksy3+u7vCE1uzeQni09FwqXNM5ByOaRq+rzob7S
        5QRawbHTkq6U2BezQHkwgXj61S756h10qj+aGzQlnr3rfR4fgjz0UA1csVVO+bRJ
        LiU5xAa4wTSvxCjmTOJ1AebY6YSEdiVyQK3jKSFCOaxGEqVCLjlDOuXsif61qD1O
        U9wA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1686572463; x=1686658863; bh=CQngQrp3m88sf
        mNQ6jwb/0MCwpSvf6b3yAjboq72bpA=; b=D5y7RDRvVSzB/6ssAwBCRtWlJtIoX
        GyZU9cUu+oJCZAfV6yvrZualKX+lExaUGxgKyk/elY7x8KvhrjfypHI8DgVgsEo8
        seJBYlPk5cqfzJQD4HTE/RCOXqMJkqWrjJqaUMuwEIkUjNZ/B4XrOD7bxJqUuMNa
        kF6Q1chkEwVJB+1Af+RslaB8g0NK3RhwwWesZXSyK/+1FI3SUTGmuUFRkFZzRlSY
        w4xsl3oqb0OrTau8qCTh0T8DSgJIsNBEVeeFEOqwCUTN1be7LcFYJ33AB4cK1oAg
        7MwtUWtA74/LWn3Sxd3C1kT+WNyYS6RxvzMypPrWYi80f5JZm0fbcsMRg==
X-ME-Sender: <xms:rg2HZCGGMg_gR_EbRWAArkPOBMHpI1YPpSBEWdj6E5KegjhXySElsw>
    <xme:rg2HZDXeZmlhD-nOF-UFgAh9qh0nRC7NkZh3PuRa9wUIzTsYYBiKR-7QpG5lw57-A
    JO2vcvMibhkv2mH8EM>
X-ME-Received: <xmr:rg2HZMKSrBI0Ijh8JlrwjUfVgDvyTlNpgoG_-m7bFjGwYBcFGJthFR7xuAMs-6xAx9peYYFdrsBLu61xB9leag>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeduhedghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtsfertddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeeuveduheeutdekvefgudevjeeufedvvdevhfejgfelgfdtkeevueegteek
    gfelfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:rw2HZME0EMuStbxoX7OGPtg4J6l9Rtw2q7ohuMOIoQ84g9hUozXFpA>
    <xmx:rw2HZIWge0FdmLPfuVYu21pPNhh4eZpqLmxV-JVCIj5cJwmZVwx2qg>
    <xmx:rw2HZPNyXcX1Y1LX21ufXOUxY7X1QhBpu3iBXW7_aWtQVSvjC2ievQ>
    <xmx:rw2HZBNeT8Q9uM9GB8C8swn1-cVMljsIqzZ3so9IDy6xbfptYo3rNg>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Jun 2023 08:21:02 -0400 (EDT)
Date:   Mon, 12 Jun 2023 14:21:01 +0200
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
Message-ID: <oo534q7hgmves7pd665ut356xpksw7oonrjk22tu4h4mg6mwhd@dwoc5a5c5wn3>
References: <20230611090143.132257-1-frank@oltmanns.dev>
 <20230611090143.132257-2-frank@oltmanns.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="e4wbpxmfzpclxccx"
Content-Disposition: inline
In-Reply-To: <20230611090143.132257-2-frank@oltmanns.dev>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--e4wbpxmfzpclxccx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Jun 11, 2023 at 11:01:42AM +0200, Frank Oltmanns wrote:
> In case the CLK_SET_RATE_PARENT flag is set, consider using a different
> parent rate when determining a new rate.
>=20
> To find the best match for the requested rate, perform the following
> steps for each NKM combination:
>  - calculate the optimal parent rate,
>  - find the best parent rate that the parent clock actually supports
>  - use that parent rate to calculate the effective rate.
>=20
> In case the clk does not support setting the parent rate, use the same
> algorithm as before.
>=20
> Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>

Most of the comments I had on v1 still apply there, so let's figure them
out before sending a v3.

Maxime

--e4wbpxmfzpclxccx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZIcNrQAKCRDj7w1vZxhR
xYjBAP4zxaQPtCC3bLmbBvqxb8o92BcM76cTi9dor6Y96WivRwD7BPrLB9GMmbgP
qaL3OlTIIIndIP66M8PVuTjVjm6tCQw=
=EEt7
-----END PGP SIGNATURE-----

--e4wbpxmfzpclxccx--
