Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A251699907
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 16:37:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbjBPPhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 10:37:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbjBPPh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 10:37:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DBB554552
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 07:37:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B193A61843
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 15:37:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0770C433EF;
        Thu, 16 Feb 2023 15:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676561844;
        bh=2+KPvuaCpQD+82YcuDgvuCuUe3Ns8wL0cUpK01igajg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tXysuqPsAs6J2ADpVDn3NaSd6flR4exuDGjBW74aRiQyJN2pDl4rAUOfH/nNfJQK1
         XS2Ig7Ly2vqYyyQxyRF4CeuJy/EafnvwX+bSfYLBgPPYGg/emI9CZW4KTCNNUeyk6y
         XAycS4nRkZK9QH2V1EHzJmuKkqVvI/qSH/Axr3GxXhwM8mU+tdhv7aMSbpcc6Jc/bS
         rckyp9C6ogk8/r7+ZgfXlYZb2I9viKSb+UuKEG9jyANrOxLbuEpDvvTLi/c2O7sYoi
         Wqv2Idj3cjcZpAwfRp7ec1J3vbVmx7MtqusrR/exBUnwjzsT3Hp35ovK2wrw2Z7VjN
         XWPAJuRtj1cPg==
Date:   Thu, 16 Feb 2023 15:37:20 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Lucas Tanure <lucas.tanure@collabora.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH 8/9] ASoC: amd: vangogh: Centralize strings definition
Message-ID: <Y+5NsB/Z5P+rVGbX@sirena.org.uk>
References: <20230216103300.360016-1-lucas.tanure@collabora.com>
 <20230216103300.360016-9-lucas.tanure@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qdQDcYIyMx1V5VX8"
Content-Disposition: inline
In-Reply-To: <20230216103300.360016-9-lucas.tanure@collabora.com>
X-Cookie: Serving suggestion.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qdQDcYIyMx1V5VX8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 16, 2023 at 10:32:59AM +0000, Lucas Tanure wrote:

> Replace occurrences of strings by their definition, avoiding bugs where
> the string changed, but not all places have been modified

>  #define DRV_NAME			"acp5x_mach"
>  #define DUAL_CHANNEL			2
> -#define ACP5X_NUVOTON_CODEC_DAI		"nau8821-hifi"
>  #define VG_JUPITER			1
> -#define ACP5X_NUVOTON_BCLK		3072000
> -#define ACP5X_NAU8821_FREQ_OUT		12288000
> +#define NAU8821_BCLK			3072000
> +#define NAU8821_FREQ_OUT		12288000
> +#define NAU8821_DAI			"nau8821-hifi"
> +#define CS35L41_LNAME			"spi-VLV1776:00"
> +#define CS35L41_RNAME			"spi-VLV1776:01"
> +#define CS35L41_DAI			"cs35l41-pcm"

These changes don't obviously correspond to the description of
the patch.  It looks like there's at least some renaming and
reindentation of things not related to DAI names here.  TBH I'm
not sure the removal of namespacing is a good idea, it's probably
not *super* likely but we might run into collisions.

--qdQDcYIyMx1V5VX8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmPuTbAACgkQJNaLcl1U
h9CM/wgAhRWIiQuG2HbuVN3no2Nu6aNxDlLnUyWqA56pB1z0yMBH8FUpGknpjCN2
gdXiAARXV9SzsasDJuDR7j1K7XDGV0HzQfmkRTsr7tFdvcmGqcX1VJpfPZHUaYLT
TbrM3xmhCxJl0b4q9SErRcVnXigBqliQdQKP059F3S6QqSn0TfMu6be5Dem5AhS1
BMuk64l4HKZkpn6zEJqmGzDv2gM+goq4gEZpo7MCwYdpSehUUT0xY1eR0T8/tUfr
HC50ADfLeWqb3iMCN0kuUVPh/8lEELOY5dxpUSzb+B8oZ+i6lrDJQWWjUXEDw0iE
b7W3A65dk2wwRFiL8K18FpSMdj3D9w==
=xmrC
-----END PGP SIGNATURE-----

--qdQDcYIyMx1V5VX8--
