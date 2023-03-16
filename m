Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC496BD5A1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 17:31:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbjCPQbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 12:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjCPQbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 12:31:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3235E20DE
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 09:31:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0860E620A3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 16:31:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ECBCC433D2;
        Thu, 16 Mar 2023 16:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678984279;
        bh=pirosOyYPxb7gdRU1NPpfNvNnz15Z33y9681TnHTFlM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l6mv/K/P87rQtBc+pauTpDhxdURklyAnTWHyzHqnWtLN8gyTfdngQVD+JY+UBJjiZ
         McKhk7fRcBG7iIkrlx0AMU3r28X13AkoeHcBwYkZaJJ3Bz58Ayd47bTzB9rDHAqmbz
         tbwmNtXZ5O0KHEDzJoeHLtKABDVXKF1uHixkCIWs9nUtiPbk5lvrYUvhPECpSJv8j/
         5tC4OKR0FyM0aEBVsek45kzbTfTwgQl5jPm+8q6DX7oxYzdS1EKTSPRIZY/oIa19FV
         8jdU2xQk3iRybalVS6EShGE4AdWS1c9Y0KbJXfDF8sbYRZVPPe/9+EjdB+28+kA4re
         QR9w/0HcH1DjA==
Date:   Thu, 16 Mar 2023 16:31:14 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Ravulapati Vishnu Vardhan Rao <quic_visr@quicinc.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "moderated list:QCOM AUDIO (ASoC) DRIVERS" 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: codecs:rx-macro: Fixing uninitialized variables.
Message-ID: <e3165099-96c9-4326-af73-6020f0276f7b@sirena.org.uk>
References: <20230316162249.17044-1-quic_visr@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+5Ml4SivzgiYppgJ"
Content-Disposition: inline
In-Reply-To: <20230316162249.17044-1-quic_visr@quicinc.com>
X-Cookie: ... I have read the INSTRUCTIONS ...
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+5Ml4SivzgiYppgJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 16, 2023 at 09:52:49PM +0530, Ravulapati Vishnu Vardhan Rao wro=
te:

>  {
>  	u16 hd2_scale_reg, hd2_enable_reg;
> +	hd2_scale_reg =3D 0;
> +	hd2_enable_reg =3D 0;
> =20
>  	switch (interp_idx) {
>  	case INTERP_HPHL:

This is just shutting the warning up, it's not like 0 is ever a sensible
value to use there.

--+5Ml4SivzgiYppgJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQTRFEACgkQJNaLcl1U
h9BQCgf9EcoNSrCHri4SWhSYpoQdenmY3y0ta3Qssx4xLq5Qzeq/jtkdcXRjhuXh
nA0uDYje3v5CDwZi7Hd6rew/iuryk4wDz2tHXxGDIcQ3e4xrRDrTKtj5VcyH0Dm/
s0XtLWw8z0KHpFAlKSAxf90h0/oAOblT3Q+BtQ6+2V62gcPSCdfckiVii7TJPN8V
O+vqfM7XRUy4twlstCuxnUqJe+3A5r38L8RQDpfIRhiSJOeIHnmxBlG3oswxWryr
Huyio2s1fC1MU7iigW6bO9SEMEgZFiMA5Zqqc0cPinseQ8QzpRIrPN++Y7Mca0Bq
VfzTC+k1FiasIBVh3/B64k5RFWdppA==
=Jnv4
-----END PGP SIGNATURE-----

--+5Ml4SivzgiYppgJ--
