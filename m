Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34C935FD9E2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 15:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbiJMNGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 09:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbiJMNGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 09:06:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B704DC90C9;
        Thu, 13 Oct 2022 06:06:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 68096B81E24;
        Thu, 13 Oct 2022 13:06:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B706C433D6;
        Thu, 13 Oct 2022 13:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665666367;
        bh=JHAw2W7prYpOOgCccUOYji7QcBQLE5R+0+cCc0zhULY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uStcIrFqZDyUctkzYCTRX6VjcmLA682Ex50GQLamZqei2XpT3BV9rInyEAfAFcay0
         NCcBfJqru0qoAu7fUzgTACNygIQkaEEQ2e1r6KbmpUfngdy1R/wPnjyqrAwSEu8YOi
         r0a8shHWYfrMDPQpAuMokkuWOqQO3/7kvWcw/IaTtnhHbMytyhVYF7Qw+R2xgbDY82
         XD8CeR+9HUV4G8/uuc7f27QKoj8AgrhL+ua+fTO45WOpRyZPxn5t3c0jS4HJeAx8sp
         iv1lxCWMCLatC11zy0tZHdarIbJV0k3PpuE0Ce6gOCZpXxIFcuJZIcdkIvCePlDydF
         2alM4N0xle84w==
Date:   Thu, 13 Oct 2022 14:05:59 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Liao, Bard" <yung-chuan.liao@linux.intel.com>
Cc:     Jeff Chang <richtek.jeff.chang@gmail.com>, jeff_chang@ricthek.com,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org, tiwai@suse.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        Jeff <jeff_chang@richtek.com>
Subject: Re: [PATCH] ASoC: Add Richtek RT5512 Speaker Amp Driver
Message-ID: <Y0gNN/HB53ISvwI3@sirena.org.uk>
References: <20221013080643.6509-1-richtek.jeff.chang@gmail.com>
 <Y0f98d0A04f8dzQV@sirena.org.uk>
 <f84e2722-ca56-8440-a5af-550080bd1f8f@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1DqoBQP/S/2TsyJM"
Content-Disposition: inline
In-Reply-To: <f84e2722-ca56-8440-a5af-550080bd1f8f@linux.intel.com>
X-Cookie: Do you like "TENDER VITTLES"?
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1DqoBQP/S/2TsyJM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 13, 2022 at 08:46:26PM +0800, Liao, Bard wrote:
>=20
> On 10/13/2022 8:00 PM, Mark Brown wrote:
> > On Thu, Oct 13, 2022 at 04:06:43PM +0800, Jeff Chang wrote:
> >=20
> > > +config SND_SOC_RT5512
> > > +	tristate "Mediatek RT5512 speaker amplifier"
> > Looks like there's some Richtek/Mediatek branding confusion with this -
> > it's a bit unclear.  It's all the same company in the end I guess so it
> > doesn't matter.

> Interesting, the naming of RT5512 looks like a Realtek codec. ^^

Yeah, exactly.

--1DqoBQP/S/2TsyJM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmNIDTcACgkQJNaLcl1U
h9C8ZQf/Wg+lRkhpkE6ejB/Grl8dHwI6yoskSk9Bxa3ybD4gTRzJxgl4h63BBm+q
yiY0Npm/r59c8/nAiVucxEQBzNYqZ3jVuS/XIRkZYlDl0FJtwnqmYwOkFu4r37Rq
5eP6UG6xxBhQOovHRd0Von68ofEKC0UIqFogaqQeivNrCZFJ5URcOzZ9eeMFbs5y
bdejtGzvggeS5I+sUfw9Uja8I9eMQxn9phHeLObzwQmJVScbAjGwor5tf9pbm7G0
qyYOAaGVyBcRMQHPg8CFiLXjy1Vl4GcOhGzVgX8B9plEVx3uuVxSx6N3dkV18gS0
gcVZu5wqfcejMC6IPyfjc0bt/UYU1Q==
=ACP+
-----END PGP SIGNATURE-----

--1DqoBQP/S/2TsyJM--
