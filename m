Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 621FF748911
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 18:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232619AbjGEQQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 12:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbjGEQQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 12:16:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E9EC1700
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 09:16:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0195461610
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 16:16:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C08AEC433C8;
        Wed,  5 Jul 2023 16:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688573799;
        bh=GeYO4hEs6xDOK/p1n1fFk3HqkeUFQ9DVjoLNHuXTWGQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AwgiDq7611IvY8AjeW2W+C4dKuQWb1y8pGtbXxWXJgopfGLg4YXY6wy/wZZN9q/xu
         hCI+qDM+72j4PzE4r8kjFyybE96Yek5lzGw5EcXvhEtATVEIAAmrgdzGhYV+jyA9DW
         48qPHw/xXbaYsHEfZNhjnNaJ8jCJzPHFxhhNKjf6/UV1tUTx0QR4jddZoWbG8WvtCD
         EPx0TvXxq20B8Z4wBNzgyW4fpAawzi5fI9yHxmDpIkgSywRWs+hEJNVnrntmxLX+j5
         RmVrOmfnv38XBoQtxH+jcBO7Z/n20H33fCMlzy8d8PFeCjHVs/JLnJoJJ/o1yxNj8b
         sXEpg/g/6hiBA==
Date:   Wed, 5 Jul 2023 17:16:33 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH v2 3/3] ASoC: amd: vangogh: Add support for
 NAU8821/MAX98388 variant
Message-ID: <a414b971-381b-4695-9ba4-d2c777bff330@sirena.org.uk>
References: <20230705134341.175889-1-cristian.ciocaltea@collabora.com>
 <20230705134341.175889-4-cristian.ciocaltea@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ov8aIt3YF8eAYNFc"
Content-Disposition: inline
In-Reply-To: <20230705134341.175889-4-cristian.ciocaltea@collabora.com>
X-Cookie: Don't feed the bats tonight.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ov8aIt3YF8eAYNFc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 05, 2023 at 04:43:41PM +0300, Cristian Ciocaltea wrote:

> +static int acp5x_max98388_hw_params(struct snd_pcm_substream *substream,
> +				    struct snd_pcm_hw_params *params)
> +{
> +	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
> +	struct snd_soc_dai *dai = snd_soc_card_get_codec_dai(rtd->card,
> +							     ACP5X_MAX98388_DAI_NAME);
> +	int ret;
> +
> +	ret = snd_soc_dai_set_fmt(dai,
> +				  SND_SOC_DAIFMT_CBS_CFS | SND_SOC_DAIFMT_I2S |
> +				  SND_SOC_DAIFMT_NB_NF);
> +	if (ret < 0)
> +		dev_err(dai->dev, "Failed to set format: %d\n", ret);
> +
> +	return ret;
> +}

This never varies, why not just set it up statically in the dai_link?

--ov8aIt3YF8eAYNFc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSll2EACgkQJNaLcl1U
h9BLLQf5AXp0pzyXPku8zlANe/5Bg+G+xI8VK0dpRTbhe2rDvtHwHsmTBIcTmLfZ
XNv2UEuQwYYaegA6aXufWlK43fbE2GR6TyA3APAsPSRaUf6rzGCmxC8tp4fPsvxA
9UIEY0VlAZAo/nTTfIdChqLiN1lUnZblGX6dLiZTsO52Ab734FEXf4ULlsR9b6bk
uVErEGnYAh9vbgRb87ztzp0IOlMumX9mgfLojCx8srQkETvrzS2N5yzmBlEJDa7s
wdtw7152EEwJiR3wIUiZULcfbLDIRiuc/k8BKRt05Ja8gZCxi2TwZ9OvVIJtmLHP
SwqXo1B1+3QraZpAIYQfdDUwFsV/og==
=WIYi
-----END PGP SIGNATURE-----

--ov8aIt3YF8eAYNFc--
