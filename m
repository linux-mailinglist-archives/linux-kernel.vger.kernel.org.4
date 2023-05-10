Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBBD66FD3BF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 04:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbjEJCK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 22:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjEJCKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 22:10:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6805C4201;
        Tue,  9 May 2023 19:10:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD94562F2F;
        Wed, 10 May 2023 02:10:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BB05C433EF;
        Wed, 10 May 2023 02:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683684619;
        bh=poI666OI/xsZPVnr06pLwQAkEzT1SEYPhOfJQcJRHw8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WvYIzReuFXvL7NWwO5OG68hV84RKTLdKoP1oCl2TR8I1Y0FOR6/EdqJsLSr4PSPiv
         3LrFhIJSEZ4ijpVINxD5n51oDYBfbSdvft/Z1ejFYfRUAt9UB1LI5vaalQKi9thGyD
         kqFZDd4/zKyUzRR8567MvtoWIpn61Q6asj/L0dy3aisq0e5+LQhzkS/5uZwdPP2+4r
         Ee5oR5s0cUwTggR4m79UHTcbKg5c7XB+mOzo4JG/qRRc08zUa9l5S3GY+PfFddKWjV
         YZ0xEoRbnDNK9m56cqXEGWC6B33PjLW9aN47OhxOoxP1+474T8kHMm2XY7+lKBqKMn
         5FxwMnevFYVdg==
Date:   Wed, 10 May 2023 11:10:16 +0900
From:   Mark Brown <broonie@kernel.org>
To:     Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>
Cc:     Conor Dooley <conor@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        asahi@lists.linux.dev, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ASoC: dt-bindings: Add adi,ssm3515 amp schema
Message-ID: <ZFr9CP3Dfmb/3LzP@finisterre.sirena.org.uk>
References: <20230509163828.86003-1-povik+lin@cutebit.org>
 <20230509-marxism-plug-759c99ac601c@spud>
 <0216884B-A6F4-46B0-AEB9-AA16B3F24C8C@cutebit.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="x8yWm22KI+W3sa7J"
Content-Disposition: inline
In-Reply-To: <0216884B-A6F4-46B0-AEB9-AA16B3F24C8C@cutebit.org>
X-Cookie: Avoid contact with eyes.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--x8yWm22KI+W3sa7J
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 09, 2023 at 09:38:46PM +0200, Martin Povi=C5=A1er wrote:
> > On 9. 5. 2023, at 20:25, Conor Dooley <conor@kernel.org> wrote:

> >> +        00: 8.4 V Full-Scale Gain Mapping
> >> +        01: 12.6 V Full-Scale Gain Mapping
> >> +        10: 14 V Full-Scale Gain Mapping
> >> +        11: 15 V Full-Scale Gain Mapping

> > Putting register values into the DT does not seem correct, although
> > I know nothing about sound and will have to defer to Krzysztof & Co. on
> > that front.

> I thought this should be here, and not with the other gain controls to be
> exported to userspace, since it relates to the supply voltage. You probab=
ly
> can=E2=80=99t select a gain value close or over the amp=E2=80=99s supply =
and expect proper
> functioning, so the value here should be the system=E2=80=99s integrator =
choice.

> On second thought there doesn=E2=80=99t seem to be any risk of damage to =
the amp
> itself, so the knowledge of what=E2=80=99s the optimal value could be lef=
t up to
> ALSA use-case configuration, and there=E2=80=99s no real downside in trea=
ting it
> like other gain controls.

Alternatively why not just query the supply voltage via the regulator
API?  Those are kind of weird numbers (eg, 12.6V rather than 12V)
though, it looks like they're not expected to be the actual maximum
supply values but rather something slightly less.

--x8yWm22KI+W3sa7J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRa/QcACgkQJNaLcl1U
h9BY4QgAhWukkwf/Q+KJ/O1mA+WDot7Z/4HgoZ6HQ1Ah1oeMY2KKVMctkt+Fjjsu
71JOb30GLBJNLiU71/915kUVu6da4KdpfvWJAPT94yfishybk+Kvre0c4YsSuPnR
oToqrQLzMr14EHPYMgCB6xEOGyUgpQHJ+FXhhvlTaYme5wEwpUYrx7lNLCZCN5Xh
pBUJEWWAlImA/FqNICvl9pHooolRe/nkvvPb0m0RgWnQ90cxJXtfRQ5Louixv7l5
jmOqaO2hSFCuoRED54pUqOVKq3qGj/rzEGONEwxdSlIKaKYQWmkCzdx+xt+pCW8i
KwhMWrajFDoxxoo+t43SuOqOZyLsDg==
=Vdq1
-----END PGP SIGNATURE-----

--x8yWm22KI+W3sa7J--
