Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF9F5605FE2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 14:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbiJTMOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 08:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbiJTMOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 08:14:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 828E562F7;
        Thu, 20 Oct 2022 05:14:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2C510B8274B;
        Thu, 20 Oct 2022 12:14:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15CC3C433D6;
        Thu, 20 Oct 2022 12:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666268065;
        bh=wVmcHlw2nMWp1f7t5TKKyu1OLkzG6V28/hn1UezvJGs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J/TIeT+b0yIYlY447mZpkCn1+wp8Rqn+KzsH9bO9Hbb4OjbO1KlQMW2E8dICUbYNq
         hNrLBOPa2rJ+uNHFUJnW+Uq/LcX/XLtE9XU+YoP+IOh+Bx3M6/kLdjPZscGzd2cWLH
         H21WQsFiPWTVH2IIH0WjD2TDHvmnopG8Z3PlRSYqqVhdkXdHKPzy7ZqSBT8o4TI//k
         1NIk7XEo+gXTZ9ZNK6ILdUnZA5qqxNRsTRsk6noPaFwTH2uiwV61YH9KqFYQIbAoGq
         EGSJBLiviN3HuS7CZIAYnrUbbYT3EsnVblgqvpJsxC2WQIVQdWTCTNgifN8gMAI+Hq
         /5HIQj6785M+w==
Date:   Thu, 20 Oct 2022 13:14:20 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Siarhei Volkau <lis8215@gmail.com>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-mips@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH v3 0/7] ASoC: codecs: jz4725b: Various improvements and
 fixes
Message-ID: <Y1E7nFC9DcdqegKX@sirena.org.uk>
References: <20221016132648.3011729-1-lis8215@gmail.com>
 <166609251307.155136.11548088283059583394.b4-ty@kernel.org>
 <CAKNVLfbfRRE3O2uFH6MQxoa_cdqTUcvpGzmcxFm3oCLKFfHv6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="20Qlq5zpxv26BWqP"
Content-Disposition: inline
In-Reply-To: <CAKNVLfbfRRE3O2uFH6MQxoa_cdqTUcvpGzmcxFm3oCLKFfHv6w@mail.gmail.com>
X-Cookie: Today is what happened to yesterday.
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--20Qlq5zpxv26BWqP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 20, 2022 at 02:58:51PM +0300, Siarhei Volkau wrote:
> =D0=B2=D1=82, 18 =D0=BE=D0=BA=D1=82. 2022 =D0=B3. =D0=B2 14:28, Mark Brow=
n <broonie@kernel.org>:

> > If any updates are required or you are submitting further changes they
> > should be sent as incremental updates against current git, existing
> > patches will not be replaced.

> What are mailing lists it needs to be sent to?

The same ones as for any other patch submission - alsa-devel in this
case.

> Any additional tags needed? I know about Fixes tag.

No.

> Do I need to keep a link on this patchset somehow?

The fixes tag should be enough.

> Do I need to mail a patch with the fix to this thread or
> create a new one?

Please create a new thread.

> PS: the patch will look like:
>  - {"ADC Sourc Capture Routee", "Line In", "Line In"},
>  + {"ADC Source Capture Route", "Line In", "Line In"},

This was already fixed by Colin...

--20Qlq5zpxv26BWqP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmNRO5sACgkQJNaLcl1U
h9C01Af/UywbN7ofuJYAnuTxfZYjGiVc3HZXaAVqY5cjTm2P8mBTY84rQshG4OHA
x7WYG1lpu51e4oHyci+cAEIlJ8c2ptRm2v7NMk9DCZpU8VeSkSG1EmWQnKj0Q7qH
tumNm/ecmEFRehPkVliFfJ/AQyb3T1Hv3Q5JYPWUTJbIY5L09msI9QNOBHfmYi70
cCew1lfF8VT6EwuElrM/YIFBW4w2attkFLkpMSqPFsBgd6rPkjFnZf1+w/SUJU1l
eEbJdI2S+l0hPQEVA+YaPmFhwCHq1N72C239kMLX5lICmAN/yQPpOivmuKYV79i3
PWRyQloaqv8bzeknu6z2hIyAgpqvFw==
=P7gj
-----END PGP SIGNATURE-----

--20Qlq5zpxv26BWqP--
