Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BAA16C1D04
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 17:59:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233230AbjCTQ7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 12:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232820AbjCTQ6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 12:58:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D0018B14
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 09:51:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 23650616FE
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 16:50:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37C5BC433D2;
        Mon, 20 Mar 2023 16:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679331037;
        bh=E0ClaU5YCHQBfzgXU30uuxfmPFXZyvuONYhWTPogYUE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H0EscW+DR0mPhT3QtBlpDa7AOZkr5gLAthRiYn5FTINn2m90qil1B2yyqIHijePVs
         zspxjDzllLPFn1fdAITUAWbNdv2DkFYdqY++kgTjz6l+QY3K/pzAWQo0WVmp2+JYLN
         Cxpyo4zAmRvMEPOry+Dm1/XLc6WjmyBrFi/X0ma0FOZro2f8vpMFy316vH1PhzSNqK
         JmEAketSXrwiWemVSyfGFg9u44CtxUxoQA82N+E/nV5QKERvDTWQCypTMrRMQBP1/N
         oAjgk+pSFFOSaR5o3iWB3PKg6+9be1t4OoWxEEGlSOPztqHMfNef9QloTia7GwcCRy
         NTnghhXpPkJ1g==
Date:   Mon, 20 Mar 2023 16:50:31 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Shenghao Ding <13916275206@139.com>, lgirdwood@gmail.com,
        perex@perex.cz, kevin-lu@ti.com, shenghao-ding@ti.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        x1077012@ti.com, peeyush@ti.com, navada@ti.com
Subject: Re: [PATCH v4] ASoC: tas2781: Add tas2781 driver
Message-ID: <160416ce-a262-4012-84af-16873588cee7@sirena.org.uk>
References: <20230320150726.20573-1-13916275206@139.com>
 <aea0c730-898d-7326-d245-79bc124bca0d@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kyRgx4I2BnEQBwi+"
Content-Disposition: inline
In-Reply-To: <aea0c730-898d-7326-d245-79bc124bca0d@linux.intel.com>
X-Cookie: Keep away from fire or flame.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kyRgx4I2BnEQBwi+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 20, 2023 at 10:47:08AM -0500, Pierre-Louis Bossart wrote:

> > +#define BINFILE_VER				0
> > +#define DRV_VER				1
> > +#define	PPC_DRIVER_CRCCHK			0x00000200

> indentation after define?

That's a value for the DRV_VER field - that's a thing people do, it's
fine.

--kyRgx4I2BnEQBwi+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQYjtcACgkQJNaLcl1U
h9DHXAf/dpmPmlYmze3xNFrCCmS8YhPy8RbOsqEPQQtXoRhNxk8Jg8Pb2Tc//eSh
kogvV04aaVs0dDKiU94nsGwPT1nR7FNjMXEKCS/OIgcLQajxRHNnvESp7gFSWzFu
igWlcABy646MPtds6ttgiakT97/SX9bOKyyXi1YPWCYN+5Isr6IpJed++oY2w2k5
F4gJDthUKk8S2FgJyDqvlwcLgY/iJ+5TMb7M2ZbR7T8Ot9gXXiUEEkzbZRjuAg6/
LcNibrXeY429OZqT6Qw3jxApz8RiNlSKEA9EECOIIQJuBb+ARKcg5rAXyoDnpCbh
wu/x1va0GRzwvK2OEOA/93T0XqdVXA==
=GzKh
-----END PGP SIGNATURE-----

--kyRgx4I2BnEQBwi+--
