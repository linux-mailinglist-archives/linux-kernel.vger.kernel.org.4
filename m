Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00A3F5EB465
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 00:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbiIZWQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 18:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231328AbiIZWPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 18:15:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 782BA43E58;
        Mon, 26 Sep 2022 15:15:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 366D0B812A5;
        Mon, 26 Sep 2022 22:13:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D6D0C433D6;
        Mon, 26 Sep 2022 22:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664230382;
        bh=2Qt3W8FkIMIE55ctoj3YAHUay0CBFTZXAHMd7mn4hp8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uSbK6VxMdhw8e8KNUVvQk9DkPang+WcxCaiI8iR6i0u49/s7tfeSlA1U3qzG3PP7E
         0hLSTj7XSuBf+iaaSaVTCQnf/b8SWpXqgygr7nPZ1N0ZYsuyn5yozA0OaQ0owDr4U2
         14DUv7Cwf7I12Z49AD/pWdzVKIaa4aDGRC9lnEfIGlPhAGsnOpqAdpdDBrRn0Zatl6
         P8tbfFj01gpS7UaWt/nHhBio+KU3IwCbfigYZMlUw7B/T2VVO8ehrhwEjnfhdANoi5
         o6cSjiEIgIntgdVhhDQs5AWedaOX4MtFDDHxHcMs4D6TcyuW3DlVxZWyv2AZKPTIop
         Y8jWhLS7QmvAg==
Date:   Mon, 26 Sep 2022 23:12:58 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] ASoC: SOF: control.h: Replace zero-length array
 with DECLARE_FLEX_ARRAY() helper
Message-ID: <YzIj6tdtDe9YrX+I@sirena.org.uk>
References: <YzIcZ11k8RiQtS2T@work>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="34yM7OTcCN4YfrhM"
Content-Disposition: inline
In-Reply-To: <YzIcZ11k8RiQtS2T@work>
X-Cookie: You may be recognized soon.  Hide.
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--34yM7OTcCN4YfrhM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 26, 2022 at 04:40:55PM -0500, Gustavo A. R. Silva wrote:
> Zero-length arrays are deprecated and we are moving towards adopting
> C99 flexible-array members, instead. So, replace zero-length arrays
> declarations in anonymous union with the new DECLARE_FLEX_ARRAY()
> helper macro.
>=20
> This helper allows for flexible-array members in unions.

As documented in submitting-patches.rst please send patches to the=20
maintainers for the code you would like to change.  The normal kernel
workflow is that people apply patches from their inboxes, if they aren't
copied they are likely to not see the patch at all and it is much more
difficult to apply patches.

--34yM7OTcCN4YfrhM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmMyI+kACgkQJNaLcl1U
h9Bl2Af/eq17arOKqHYbB+7ToUShw/rDWN00EYpGJ1L4MTJ0Hrt4JHoK/KoB0pVo
D4zPrWxnFc/aIvlHvf5zkwHqQvhNMsL+FfB++tS8oLWXdskaSwdZAJOHqU2t5sfb
6whvYoNoYUD/5acGyMfX2RLCQbIxIAz8q6J7bJY+QfqbXVUHxMHbNSKJ5rkHJTnN
Bsx1DpzXc10p1PwhVhepbCuJXl+shGRXw6WgjyubQtHjmSWNACm9QF+Hm7w3z3DB
2dIWI7LQ6x63u+i5vxsInZczO1qWLQmqWHlse4UKKekRIDrfBCVJdS0NEqT48Zpn
f6yov8ZJ3+TQx64+wsjISFZriatSQw==
=fi4G
-----END PGP SIGNATURE-----

--34yM7OTcCN4YfrhM--
