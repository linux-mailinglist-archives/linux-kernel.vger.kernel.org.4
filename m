Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9870772A13C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 19:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbjFIR3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 13:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjFIR3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 13:29:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C4A530DD
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 10:29:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA0E160EB6
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 17:29:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B5EDC433D2;
        Fri,  9 Jun 2023 17:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686331769;
        bh=NC+PelqBRP6Lg3YTLTSt+qH4fkXysv+wA08x+tKVtng=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jxEmZnxsGvyOYl4QrZMutJGLfdgO7/EmGqh0zVP0sFRXV43f3Q1acMr59+zRGhxeZ
         pToIWeGSTUobkgP9zn5x36xhMeca2uZHrM63eDo3OhjbW0EG2Yr4VygdF7K6EhsZ/R
         mwMrd2INZp52jvYg2XCsObF8yUNUTQfXVx+eEzcSi1eAKhRgpVeNsUpA5xJQ1Dv1+I
         5kli6NjpP2d2LgseidM+0HFuSYdJBvxCfQBSuTaHjDZtoXGSWTY1r2TSCLkajqUnM7
         YdmuttoA6T5uqz5euZlApHWhzb1rVKWDQk6z0SBr0EpXg1JT9U2M1rStYtPwgGHOd1
         1kpS0u7QZgbDA==
Date:   Fri, 9 Jun 2023 18:29:23 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com,
        ckeepax@opensource.cirrus.com, kuninori.morimoto.gx@renesas.com,
        linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.intel.com,
        alsa-devel@alsa-project.org,
        Mohammad Rafi Shaik <quic_mohs@quicinc.com>
Subject: Re: [PATCH v2 07/11] ASoC: q6dsp: q6apm-dai: Add open/free compress
 DAI callbacks
Message-ID: <0db2eb29-2145-4ab7-b29e-ef662a15b632@sirena.org.uk>
References: <20230609145407.18774-1-srinivas.kandagatla@linaro.org>
 <20230609145407.18774-8-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="igFIi0cBzzlH21p6"
Content-Disposition: inline
In-Reply-To: <20230609145407.18774-8-srinivas.kandagatla@linaro.org>
X-Cookie: Tom's hungry, time to eat lunch.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--igFIi0cBzzlH21p6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 09, 2023 at 03:54:03PM +0100, Srinivas Kandagatla wrote:
> Add q6apm open and free compress DAI callbacks to support compress
> offload playback.
> Include compress event handler callback also.
>=20
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Co-developed-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>
> Signed-off-by: Mohammad Rafi Shaik <quic_mohs@quicinc.com>

If you're sending the mail your signoff should really be last.

--igFIi0cBzzlH21p6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSDYXIACgkQJNaLcl1U
h9Aclgf/ZAnupwqwFFLAgWmo2XqfIBzS4s1rg5ir8LHFN1RQzieI7HN8f7TngDvZ
aOXrswHRAjc78l6Y2QrY3QhHSmkG2kZ4pCln/eMLkPLwbJW6pXRZNSbZ7Ct4Rgzz
EJRPTyM1wFwZptGJTeHjFomKWmCMh46ursPwCLnZ9kfOzyhXMA6UmdjjqQG4jhQX
/OuCtkbuzV5V7yVKRdV1BiGlCCmkCG5FQgv5l6pP+qcBUQ9mfT+iAO+tTX2+/V9W
gyrVMZzE7sLYSFyUFpdkBET4mJXnz1GtwqY0Hjsc7deoFg9Up96lYb3ozizGXJ0a
H0fsG7IXxO5bazlyeYggKiEFex1h+Q==
=/4lL
-----END PGP SIGNATURE-----

--igFIi0cBzzlH21p6--
