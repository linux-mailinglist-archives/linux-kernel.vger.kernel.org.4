Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC39B613F39
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 21:48:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbiJaUsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 16:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiJaUsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 16:48:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B56E413F82;
        Mon, 31 Oct 2022 13:48:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5F97AB81A5F;
        Mon, 31 Oct 2022 20:48:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25DF4C433D6;
        Mon, 31 Oct 2022 20:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667249283;
        bh=O1v863hX945DEcIME2b4UEzO+vPVa0QHCHXH0He84SE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lKpgE8UBzPnYE8ZIlS9EGGNr9CAT9sceJxbPtgUhThoajOrAecoZ0vPcZ8ah1tWo1
         hwwfXUyEGcWhpin0jwG2LpHUKnLoWDkeEinaP8h1zHn1wjd108e3It0LMrjKFaKPuB
         kEH+FKBQl3Mpu6OG6PU0OI0bpDhsuv5dthQFr70iA5QuxE1hdHRHNHkU205EX/ZBCF
         Ir1vIX7jv80QzH/dGbThZzXqy0evDjw2D5OVZEUYL8y1yNAuybCgA016r4lax0U8fB
         XJcXsFZrCfM89PUTMI1reDy2MKSlWcp7+qbo4FiOEwPVWw4wgv2M3nWJBZ7g4Bw08w
         RVOvVfQdjVhEA==
Date:   Mon, 31 Oct 2022 20:47:57 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Ajye Huang <ajye_huang@compal.corp-partner.google.com>,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        angelogioacchino.delregno@collabora.corp-partner.google.com,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH v1 1/2] ASoC: dt-bindings: Document dmic_sel-gpios
 optional prop for two DMICs case
Message-ID: <Y2A0fdwnHTqw/NDw@sirena.org.uk>
References: <20221028102450.1161382-1-ajye_huang@compal.corp-partner.google.com>
 <20221028102450.1161382-2-ajye_huang@compal.corp-partner.google.com>
 <Y1vDYNOwZNOco1hq@sirena.org.uk>
 <20221031184343.GA3235956-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pRY+kIEVcpKIGhxD"
Content-Disposition: inline
In-Reply-To: <20221031184343.GA3235956-robh@kernel.org>
X-Cookie: Are you still an ALCOHOLIC?
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pRY+kIEVcpKIGhxD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 31, 2022 at 01:43:43PM -0500, Rob Herring wrote:
> On Fri, Oct 28, 2022 at 12:56:16PM +0100, Mark Brown wrote:

> > If we're going to do this we should also allow the bindings to label the
> > mics appropriately so that the control presented can reflect the actual
> > hardware.  It does feel like it might fit better to do this separately
> > to the DMIC driver as a mux between the DMIC and the DAI it's connected
> > to but equally with the way things are at the minute that feels like
> > it's probably disproportionate effort.

> Are there other needs for DAI muxes? We already have a mux binding, so=20
> defining a DAI mux would work for any type of muxing control, not just=20
> GPIO.

I suspect that anything that is more complex than a GPIO should be a
full fledged CODEC with the muxing internal to the CODEC and just
described that way.

--pRY+kIEVcpKIGhxD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmNgNH0ACgkQJNaLcl1U
h9CPiQf+LUWw1ke44xSDRkole2tffbqEgGrQ0COXYU/ML5N5/q7uaKxeDi1B+9d6
d1ApwJ8uynaEU6uxxoBlgI1DECj4+1nKYVTujWBinU9jHlqNqbHld6urtcqC/CLC
eNUAl/BvuvlgbPDnZVuRL5452ra73bPqZShjx3ZHEgDRBvBQ0Rk5sAms8TGIdg51
yI4FY9XhHr3XCF/4GfZj2wKjip1mszPFOTvvwlmu6Dm1GQtTHffyMH5N2/u59MAy
7F0qRipL6HTKkJ0aiPPOULHJfWX72vCik1o5VvlDTRGswbw/+9UWR2rM9Mj00F2F
sv6gCaIhR0tvygxrEokN2LZkfFK9Lg==
=gzmB
-----END PGP SIGNATURE-----

--pRY+kIEVcpKIGhxD--
