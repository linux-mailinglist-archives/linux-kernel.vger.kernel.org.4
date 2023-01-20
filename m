Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4568E67543D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 13:12:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbjATMMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 07:12:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbjATMMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 07:12:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF990EC6C;
        Fri, 20 Jan 2023 04:12:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 86C8B61DEA;
        Fri, 20 Jan 2023 12:12:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 983BCC433EF;
        Fri, 20 Jan 2023 12:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674216767;
        bh=bYTCpxpMUaj0u9NVrjzlxJiwlSH7GhZL8wVTYhvi1kk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qoXeMA5IEcu8/YWtvxIdMEIAJOVuAuu0rHb3KldXH7yvXPpMMaipN0ptWsqquCLLr
         YGpaGwaJkGMl75bP9I0beehAiUZEgbK9RI6zxQnT/xueeKtx7wNbYnc7tRY3496dYc
         c7czRz4IT1hCuVGnsxUyTrnrmJVVs+18GGWLVZCDpG59qSXolyCdAP7YIdSHSqBx5/
         UeexsOh/Fq6NppIEkNK24lneWzF3Dfby1XsJyRYL5Kc5TusGA0mDLgghVpG+WQ7bXN
         oCeL6JDyMeZF8q0zsiEz1X5i+sAE6drGy8w+fNtsWsAEf2i1BNlmEkHRL5MzczBuKk
         V8FBgyAgoqqsw==
Date:   Fri, 20 Jan 2023 12:12:44 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 2/3] ASoC: codecs: Add support for the Renesas
 IDT821034 codec
Message-ID: <Y8qFPBEYJ1gH/Ycv@sirena.org.uk>
References: <20230120095036.514639-1-herve.codina@bootlin.com>
 <20230120095036.514639-3-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wlRMvD60qIyTikCQ"
Content-Disposition: inline
In-Reply-To: <20230120095036.514639-3-herve.codina@bootlin.com>
X-Cookie: Serving suggestion.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wlRMvD60qIyTikCQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 20, 2023 at 10:50:35AM +0100, Herve Codina wrote:

> +static int idt821034_kctrl_gain_put(struct snd_kcontrol *kcontrol,
> +				    struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct soc_mixer_control *mc = (struct soc_mixer_control *)kcontrol->private_value;
> +	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
> +	struct idt821034 *idt821034 = snd_soc_component_get_drvdata(component);
> +	struct idt821034_amp *amp;

> +
> +	amp->gain = val;
> +	ret = 0;
> +end:
> +	mutex_unlock(&idt821034->mutex);
> +	return ret;

_put() methods should return 1 if the value changed to generate
events - if you use the mixer-test selftest it'll spot this and
other issues for you.

Otherwise this looks fine.

--wlRMvD60qIyTikCQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmPKhTsACgkQJNaLcl1U
h9AQ4Af8De8E5PJEpMZ8aXgoqJ5oNtOF6fOh2uOEQ0Sl+8/7usPM9y8GqpAlyIxy
09ITOezWYsh9XvhCuHefFVr/Tr7KVbz34OoXwo1XNmzmkWXcezr6PrS1VAb1DaGT
qdOP6wEG+ei0PqHg6CX+oaRLnsqSVi1ojAbbN9GHAqNDRlXAzJfal0hIZuCUw9cp
JA9r1B+7/G83PP5UWFXYOydws1OqGg9fsny9D1FfEt1uuVWu/uXfGMAYCg0XeqOD
0y0yD4PaCUsv4g6Qp+eevMbsTHERfGb2YzjsZf73kE2YacIY4wATPBrt8SnFSYew
hVXpJFtOdhIyKL+8p1tHnJ0AtZDDYw==
=nMiM
-----END PGP SIGNATURE-----

--wlRMvD60qIyTikCQ--
