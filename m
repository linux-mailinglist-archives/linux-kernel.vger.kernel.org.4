Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74FAC669F28
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 18:12:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjAMRMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 12:12:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjAMRMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 12:12:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 639F488DDA
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 09:11:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F1B7C6229E
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 17:11:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6A6EC433D2;
        Fri, 13 Jan 2023 17:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673629881;
        bh=LL/lMQywjl9XFUL9aiAeF5ZOmGV2ft5JIT2pLycXCfI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M6igAXCGYq20hp9tPeZhnyQfFftg0ni2mFKR8GoD3c/rsVLp+wUzE29g0k7QryUnf
         G+1UYdvGkI4AphrUu9WSqvQsV44juexlJpvVykjPgS37VqFU4sWvCo2LsRhF506bod
         CNTT1QY4f694co4Ff5096n3+tRahcvMIrFRJWcq5S3Gp7WEnYGWCiHKgPXxkGzOamM
         2YBxxkm2q5gfQknDAWMA7QEQyOsQrvKQSdAPlxVkTPlBXmdWUzcjY2Qs7VkHohdvvw
         wt+LBzvvwsXU70oXcSY5e6IqqvuOrQOTDSmCb2Lc6LaekeAROxapo/qhbrionlAl+N
         4r+YK9Ra1c6rg==
Date:   Fri, 13 Jan 2023 17:11:15 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>, vkoul@kernel.org,
        yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH 2/2] regmap: sdw: Remove 8-bit value size restriction
Message-ID: <Y8GQs6svuei0SnX6@sirena.org.uk>
References: <20230112171840.2098463-1-ckeepax@opensource.cirrus.com>
 <20230112171840.2098463-3-ckeepax@opensource.cirrus.com>
 <756fcb2d-d571-18cb-985e-d907ab682275@linux.intel.com>
 <Y8BOCpXyOyF3igfG@sirena.org.uk>
 <3320e6b8-28c7-d028-3c4c-2b4b25a963fb@linux.intel.com>
 <Y8BkiF8sfqPifYTO@sirena.org.uk>
 <4a6ae9b4-2748-c751-aec6-05979de95cfe@linux.intel.com>
 <20230113110252.GK36097@ediswmail.ad.cirrus.com>
 <487b7647-8304-8e36-00f2-c9ba3aa50004@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Z4kQJHcgSRHcgMz/"
Content-Disposition: inline
In-Reply-To: <487b7647-8304-8e36-00f2-c9ba3aa50004@linux.intel.com>
X-Cookie: I know how to do SPECIAL EFFECTS!!
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Z4kQJHcgSRHcgMz/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 13, 2023 at 10:57:39AM -0600, Pierre-Louis Bossart wrote:

> The change from reg_write/read_reg to write/read seems ok, what I was
> asking about was the gather_write.

> +	.write = regmap_sdw_write,
> +	.gather_write = regmap_sdw_gather_write,
> +	.read = regmap_sdw_read,

> what happens if you only have .write and .read? What does the
> .gather_write help with if you only use only address?

Like I said before it means that the core doesn't have to put the
register in a linear buffer with the values, meaning it can avoid
copying already formatted data around or allocating memory.

--Z4kQJHcgSRHcgMz/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmPBkLIACgkQJNaLcl1U
h9CVJgf9GMgtyJcMx5FSRjr5BEqOqFjs+LoFoue2wNLyCXl7cwU7l9BIVKNQpm8K
NL0JghhDvda6gGYrDbrLFp/Hd85ImgzJ1jN6W5cR2fIaP+K11BzJe+l9euqqannn
lUqNOt9FVbkjDKcXxXE1wgjfvy5EbZHs8cHG/EUiTzRj+idv9k2V5cUFxICu6g7k
qxzj0rX64flrsECenoTs9vcXPhUjvtqki6PxxkZKysbyrDCxISDYYSmKx1D6qn5P
nHSio8V6Me7vNGihfJlUr4l3OsBXOTGfJUNRo3EYF4OxAwasYz6FWoTf5NXxwsB9
GZBqtAMKplyND2JA7ZJc52nZ0r2DVA==
=7nwP
-----END PGP SIGNATURE-----

--Z4kQJHcgSRHcgMz/--
