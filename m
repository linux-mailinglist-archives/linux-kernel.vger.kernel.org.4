Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F15D672488C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 18:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236771AbjFFQKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 12:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbjFFQKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 12:10:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B8B10D5;
        Tue,  6 Jun 2023 09:10:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 20CE762F49;
        Tue,  6 Jun 2023 16:10:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBB1AC433D2;
        Tue,  6 Jun 2023 16:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686067820;
        bh=gRgcx3PlM1lkDs/ejUMYDSVg/Hy+quxERjLKcCkMACM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hAZQk+On2KXCEEAO9ksHbkS7d3It/UE7DcVEcHqfVi48gnnZR/OT2AIjZ+jjyEIri
         p1DHw9bGh5dRBvbnesVuKNwxRSOXTdtMV03eTh+PFvU4YFgPgibrm8ZurACIykorFt
         Imxzr96VmZUaX9FMxduNL5OOaMZGmKQumJ9u0uA0atPU4MLHDDfeTmOj1vCHA/2PCm
         lg9FvP4e7bY4hWqNAB8Kas4JAYEglD1UZkLUpx9GNulbCa2L9PU3/xYUI4BblSB6o7
         Y132ddlFjV0SVyJGAro8FcxrUOB9kqnWzXOPDCftciXsLusNYDxI2M9OQskTwjwmw5
         Dz+SUVB33iAzA==
Date:   Tue, 6 Jun 2023 17:10:13 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Shenghao Ding <13916275206@139.com>, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        lgirdwood@gmail.com, perex@perex.cz,
        pierre-louis.bossart@linux.intel.com, kevin-lu@ti.com,
        shenghao-ding@ti.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, x1077012@ti.com, peeyush@ti.com,
        navada@ti.com, gentuser@gmail.com, Ryan_Chu@wistron.com,
        Sam_Wu@wistron.com
Subject: Re: [PATCH v4 5/6] ALSA: hda/tas2781: Add tas2781 HDA driver
Message-ID: <65ef4914-dc0e-4f0f-a6f8-3016931488bd@sirena.org.uk>
References: <20230527223613.11106-1-13916275206@139.com>
 <874jnkfu98.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lEOJfeNRUJcYTo9Q"
Content-Disposition: inline
In-Reply-To: <874jnkfu98.wl-tiwai@suse.de>
X-Cookie: Keep out of the sunlight.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lEOJfeNRUJcYTo9Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 06, 2023 at 06:08:51PM +0200, Takashi Iwai wrote:
> Shenghao Ding wrote:

> > +	//Lenovo devices
> > +	if ((subid == 0x387d) || (subid == 0x387e) || (subid == 0x3881)
> > +		|| (subid == 0x3884) || (subid == 0x3886) || (subid == 0x38a7)
> > +		|| (subid == 0x38a8) || (subid == 0x38ba) || (subid == 0x38bb)
> > +		|| (subid == 0x38be) || (subid == 0x38bf) || (subid == 0x38c3)
> > +		|| (subid == 0x38cb) || (subid == 0x38cd))
> > +		tas_priv->catlog_id = LENOVO;
> > +	else
> > +		tas_priv->catlog_id = OTHERS;

> Hmm, I don't like checking subid here, but we can live with it for
> now...

Might be more idiomatically/neatly written as a switch statement though.

--lEOJfeNRUJcYTo9Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmR/WmQACgkQJNaLcl1U
h9DX7Qf8D1/so4MXwyyoryqUqBwhZILjp3cE1N3KqUivAOfiCwP4EU67H1I76Q/C
4FJiHX5VWstaLjPa0VyxetmE2HizEf1gZrwKlUWK8d1i4j9Z+17nCK9K51ErRKfF
+bh+7o3MQWugxzVVCbwtcErGwoM+qbh29rsQXpUqJLS26oTh1lE+/bafxZEJIl4t
Tl+UErh4wWdD+KspoYgN+E1DEhUdH5SexOrLOekZmvi5mZMT8dXeeiKaHgo4Xvx9
v1UjUVA/kjgVlAx9dR4SyQPYvol76iAxv4EU/jWaR1IPh8lVEHR/wKCCqMAUduy8
f0MrL9Fm9g0HhxzaljsrSH9P2xUPzg==
=MogT
-----END PGP SIGNATURE-----

--lEOJfeNRUJcYTo9Q--
