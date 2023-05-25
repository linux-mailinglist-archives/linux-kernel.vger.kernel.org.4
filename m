Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA867111A7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 19:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235784AbjEYRHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 13:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbjEYRHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 13:07:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AAE4194
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 10:07:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 96D5B6479A
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 17:07:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1E6CC433EF;
        Thu, 25 May 2023 17:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685034461;
        bh=DNU4fQ+vudSHdI1LleI6ZcbJQBl+IJL2QbN82Q47QK0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m6aMBjQvdrAgMzmNDk7hWFfKS1dtDuOz8gvlN++/RKvf9AAQLUdxli42Dg9Ur+SZh
         AyKrWrMwYGoqQkP8KQYRfMfvCr5bBcTYWvIzStOyPcLzIpKkBsftKEGLqi3H2NYsn/
         3zI+KlWjbY3uMTAV4s7Xd/fTESDberIWiiNgKY10Fm5dHAh1NmxT6dpLjpjke9o/FK
         opeu1ry0WMyvt2Rc9+o1VUvuLe4yj6PhYkUH0V+gCH66Go9lOd5aRHhSWTEzRjGCdJ
         uPcPUyL5e2w/KhfVpA6phq/ZR+QjX1mfGR1UCQITzm6G9wXvOo5v3REzhhLN95BRV8
         Rfq0KV6UKvbvg==
Date:   Thu, 25 May 2023 18:07:35 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Daniel Baluta <daniel.baluta@oss.nxp.com>
Cc:     alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com,
        lgirdwood@gmail.com, yung-chuan.liao@linux.intel.com,
        ranjani.sridharan@linux.intel.com, daniel.baluta@gmail.com,
        kai.vehmanen@linux.intel.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ASoC: SOF: imx: Add OF machine descriptors for i.MX
 platforms
Message-ID: <69c2b7cd-f211-47ef-b42a-609ee792de11@sirena.org.uk>
References: <20230525122837.649627-1-daniel.baluta@oss.nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bsKLXEtTI1c6xDxo"
Content-Disposition: inline
In-Reply-To: <20230525122837.649627-1-daniel.baluta@oss.nxp.com>
X-Cookie: I demand IMPUNITY!
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bsKLXEtTI1c6xDxo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 25, 2023 at 03:28:37PM +0300, Daniel Baluta wrote:

> +static struct snd_sof_of_mach sof_imx8_machs[] =3D {
> +	{
> +		.compatible =3D "fsl,imx8qxp",
> +		.drv_name =3D "asoc-simple-card",
> +		.sof_tplg_filename =3D "sof-imx8.tplg",
> +	},
> +	{
> +		.compatible =3D "fsl,imx8qm",
> +		.drv_name =3D "asoc-simple-card",
> +		.sof_tplg_filename =3D "sof-imx8.tplg",
> +	},
> +	{}

It seems a bit sad to be adding simple-card rather than audio-graph-card
at this point - is there some great reason for this? =20

--bsKLXEtTI1c6xDxo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRvldYACgkQJNaLcl1U
h9BQ2gf9F+zQnrSs7m+xrfMV/NzYq/C/oSC5PkOfwI4qM/pBbjKAzmM3fKu9DLZX
hFBuYscJN9qvcEkismhsI7RIH8bkPtXQjMol5fR5YCasuNZsQXTh6ZzJnqshFiqe
NeVJfLvMEp08sQolN0wyPru/Vnsb7nSVrk7YGStSQbePWZ5zaGMgDyz8REzCHK6g
L/yzjc7KMNa5JtXR86i6WUGiV/CPsH0xtP2FQ9A7u5szVYWAVYFGF8hxcNn7a7If
CHtKsu2yJOGVml5azHgEsY6CFAWMTJAx0sGqPNE1vMfxpklJyrb8s3MzodcY0kzX
8FjMRtmukvQIk8XQod2a1pDpXr7XVA==
=oqat
-----END PGP SIGNATURE-----

--bsKLXEtTI1c6xDxo--
