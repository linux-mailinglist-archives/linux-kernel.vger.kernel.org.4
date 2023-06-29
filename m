Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9ED5742A71
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 18:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231996AbjF2QQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 12:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231984AbjF2QQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 12:16:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06ED8A1;
        Thu, 29 Jun 2023 09:16:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8FAB96156D;
        Thu, 29 Jun 2023 16:16:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27D71C433C8;
        Thu, 29 Jun 2023 16:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688055412;
        bh=RyrvUeSls0qvEKZJFoV24QIDqfyNFR3a9bEQhu56rhU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i1/e5Mlxfsmwuko+4qXrz9N4uq2VK/X1Fk2A4GyX1SoMGZXg6YAYLjnC4s/tdwImf
         gQeOzq8r66+glvUi7Cafu3rcunkJzaBRr2GDZDzAfuCAeEIdDRMIjtKbH06QB0NlL7
         u6WcqL7EDUviSWEdGlNosZ50rn/ocLoT1+iv3tPfSKZ9BNLFpjOrarKi0SUDvmMTER
         +pRP917Z08QQzGYBeInW4oej+M+aOzUThA1N/HwVrTnA/YQtEZZX6RvrzucosebSDc
         LhP7fHdU5qs/B1uRbg1kLb3p519Q+EQ4Q43EvtuhxMwGTviphgBJGbJ11WGgjhlObY
         RnjBO+5vlalXg==
Date:   Thu, 29 Jun 2023 17:16:44 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Greg KH <greg@kroah.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        johan+linaro@kernel.org, perex@perex.cz, tiwai@suse.com,
        lgirdwood@gmail.com, ckeepax@opensource.cirrus.com,
        kuninori.morimoto.gx@renesas.com, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        Stable@vger.kernel.org
Subject: Re: [PATCH] ASoC: qdsp6: q6apm: use dai link pcm id as pcm device
 number
Message-ID: <9699a960-74b0-4064-b264-6cde06cd16fc@sirena.org.uk>
References: <20230628092404.13927-1-srinivas.kandagatla@linaro.org>
 <c22fcc94-aa41-4ffd-bfe8-f0b9f15a76c0@sirena.org.uk>
 <2023062940-snore-brick-419b@gregkh>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="waVp8T61GontOc/b"
Content-Disposition: inline
In-Reply-To: <2023062940-snore-brick-419b@gregkh>
X-Cookie: Surprise due today.  Also the rent.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--waVp8T61GontOc/b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 29, 2023 at 06:06:05PM +0200, Greg KH wrote:
> On Thu, Jun 29, 2023 at 04:43:57PM +0100, Mark Brown wrote:

> > Won't this be an ABI change?  That seems like it'd disrupt things in
> > stable.

> ABI changes should disrupt things just the same in Linus's tree, why is
> stable any different?

This is a numbering resulting from enumeration thing so it gets to be
like the issues we've had with the order in which block and ethernet
devices appear, it's on the edge the extent to which people might be
relying on it.  If it's causing some problem as is and there's a reason
to do something (see the first half of my reply...) but the case gets
even harder to make with stable.

--waVp8T61GontOc/b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSdrmwACgkQJNaLcl1U
h9D4vwf/fXMdNGrJPn2JH9J6748ugvE0hNd8LXepjctqeXsD5EzrA7KlHE+5Hcqj
FTGN1gBEhcjOp9fSqdi/mELLWVe2MXlYtyXv5iO5RU2Z9OJu1XjrSM6Jnx0ljKnu
D5oXlY6ai/ohFCHiOO1Zbk1pDyLeUvfG+D/bAOWroHjlQVPYXZwKxINuwK1MfeAj
wEWnl9DMSGWK6/PN7dNtapwreM1RN+a5k7REd9jFH4jVPBmX17YhEYBBEb41TBVR
u7fZZBEYo0Ja0TfAdEc601yfdqpe0N4AAL+aav/EaMA93JVnhhvugFqbFxIc6ArF
1x/LABsliWTKZpEoKyjLdGRba/zVUw==
=W9gZ
-----END PGP SIGNATURE-----

--waVp8T61GontOc/b--
