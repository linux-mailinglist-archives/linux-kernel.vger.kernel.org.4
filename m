Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED17E68989D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 13:29:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232529AbjBCM2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 07:28:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232372AbjBCM2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 07:28:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFFB954578;
        Fri,  3 Feb 2023 04:28:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 57C6B61F18;
        Fri,  3 Feb 2023 12:28:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59EEFC433EF;
        Fri,  3 Feb 2023 12:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675427317;
        bh=mYTdB2Xij/3o5p2M+sxGz+Hi0V7347ewrKK7gMJsp9s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D0udOCq9uJqPzXtkpm+ryU+EHeK+Po7AoWR2egYehW+UNkXQb9s302AQZ/3x/+hmB
         DmiusZSso8E+20oANsQpbakrgECdJgbAfvQwJST/0N7ciqDxfrecQzAhhqwLqX8Bsq
         a7d5/mHtLOIo/ajpIPxIp9V7xVwkrx/gUvYAF31hHQHtJ5VeC5ROYSekKMxNH4X4Wq
         U8gxBXzgzU4/wUzFhi1Ul7kybRCIjxwFJK7L853K88YjA4SfYk3mc4BiPYwJkpcDle
         XF/gyc1DbNUqQYxDVooCjhbHzLM9dOxE2EGEWm80CETT2BU81vNOu0f/LNN2z0w/o8
         ORToIWjIWpvhQ==
Date:   Fri, 3 Feb 2023 12:28:32 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 2/3] ASoC: codecs: Add support for the Renesas X9250
 potentiometers
Message-ID: <Y9z98CXXyI7UkrkZ@sirena.org.uk>
References: <20230203111422.142479-1-herve.codina@bootlin.com>
 <20230203111422.142479-3-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="h0liV1/NW0xnlBov"
Content-Disposition: inline
In-Reply-To: <20230203111422.142479-3-herve.codina@bootlin.com>
X-Cookie: No animals were injured.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--h0liV1/NW0xnlBov
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 03, 2023 at 12:14:21PM +0100, Herve Codina wrote:

> +static const struct snd_kcontrol_new x9250_controls_std[] = {
> +	SOC_SINGLE_EXT("CMD0", 0, 0, 255, 0, x8250_kctrl_cmd_get, x8250_kctrl_cmd_put),
> +	SOC_SINGLE_EXT("CMD1", 1, 0, 255, 0, x8250_kctrl_cmd_get, x8250_kctrl_cmd_put),
> +	SOC_SINGLE_EXT("CMD2", 2, 0, 255, 0, x8250_kctrl_cmd_get, x8250_kctrl_cmd_put),
> +	SOC_SINGLE_EXT("CMD3", 3, 0, 255, 0, x8250_kctrl_cmd_get, x8250_kctrl_cmd_put),
> +};

These control names feel a bit icky but given that they have board
specific functions I don't see a way to sensibly rewrite them.  However
I do wonder if we might be better off having this as an IIO driver and
having a binding that lets us import IIO outputs into sound cards - I'm
guessing there are other non-audio applications for this hardware?

--h0liV1/NW0xnlBov
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmPc/e8ACgkQJNaLcl1U
h9DANgf8Drcef0r+SN0lM5Hjl/HwDavvrxI99u+GtYEKjIhU0tvGOR/va8iwO2H9
ELv+YEOqHmHQu8jafBktqSqFXMo5Ji/BUPt4N4OU0OtDrpzKkM4MvTYREYWLVlLs
AVq125SrM0p7rLLfeKwjUP6QB8qB65nBoIjUazcEqYaHtHeZUJhoXJMskoH6tbCv
3/BD8dylapfR1wKbjIXNgUyMXCVD17Oeul+n0s63ZrxXfrrPXSRD/A/nrl21q1H4
nRfD2uUZfdfmzQ3so3n5DW2AVmnM4TV2uvZbcfgfc66eJAm+koamH8kd6thLIJ0P
vP7HXp8cy9ZBETaseK+rgEMZ7z9uag==
=LGok
-----END PGP SIGNATURE-----

--h0liV1/NW0xnlBov--
