Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39D737246A5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 16:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238212AbjFFOqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 10:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238885AbjFFOpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 10:45:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B891A1FC0;
        Tue,  6 Jun 2023 07:44:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CFB0862B8A;
        Tue,  6 Jun 2023 14:44:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 026F9C433EF;
        Tue,  6 Jun 2023 14:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686062657;
        bh=wFUgnv9X7h+10TvBMgGnbWC8jZFNlyHek1/kayw6i4w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dPgXlMXM9+tUnPCqQC8K9lL66aMDmmv6YC1LEtfxW9cwJMlfPSjEnkDJ6K0qGvlXa
         /wynmBuDOsCJb1wbdYBWIT2ydTpFmbkT+9r2YNSyVHibmd2IBrt9YtKFVOw7LON65o
         Ea7G+1D/3OLF/YrZkyQGyXT6yuEW8x7tFU/fPJg6uh1sa6C0yVqObNhBYahVRb69+x
         ekrDxvRzFcVrTxoBsDRAy+KXCoiduv62hy2LQHmqxiTsaqHt6ioWZd7FA5E4dhOK8n
         h6hgKE1aiHmZxaVE8dd2ifAMYT3IvFvWrv/UUm1Uvc2Fkw3Q+MQ6Buq24tlcMDafCE
         UpclfIJtHt1gg==
Date:   Tue, 6 Jun 2023 15:44:11 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux@ew.tq-group.com
Subject: Re: [PATCH 1/2] spi: dt-bindings: introduce linux,use-rt-queue flag
Message-ID: <a1a1bf95-6333-40a8-9f08-4c952cd070df@sirena.org.uk>
References: <20230602115201.415718-1-matthias.schiffer@ew.tq-group.com>
 <628b7411-7d12-4915-80c8-cabb74ac6590@sirena.org.uk>
 <CACRpkdYhFmG-Cb-5+dt1Huktnm+tkOjSGO5ZFPjGeOXRott6Dw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MqPioFIbuFc0cwHs"
Content-Disposition: inline
In-Reply-To: <CACRpkdYhFmG-Cb-5+dt1Huktnm+tkOjSGO5ZFPjGeOXRott6Dw@mail.gmail.com>
X-Cookie: Keep out of the sunlight.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MqPioFIbuFc0cwHs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 06, 2023 at 04:37:08PM +0200, Linus Walleij wrote:
> On Fri, Jun 2, 2023 at 2:22=E2=80=AFPM Mark Brown <broonie@kernel.org> wr=
ote:
> > On Fri, Jun 02, 2023 at 01:52:00PM +0200, Matthias Schiffer wrote:

> > > We have seen a number of downstream patches that allow enabling the
> > > realtime feature of the SPI subsystem to reduce latency. These were
> > > usually implemented for a specific SPI driver, even though the actual
> > > handling of the rt flag is happening in the generic SPI controller co=
de.

> > > Introduce a generic linux,use-rt-queue flag that can be used with any
> > > controller driver. The now redundant driver-specific pl022,rt flag is
> > > marked as deprecated.

> > This is clearly OS specific tuning so out of scope for DT...

> In a sense, but to be fair anything prefixed linux,* is out of scope for =
DT,
> Documentation/devicetree/bindings/input/matrix-keymap.yaml being
> the most obvious offender.

That's at least a description of hardware though.  This is a performance
tuning thing, if it needs to be configured at all it should be
configured at runtime.  Some applications might see things work better,
some might see performance reduced and new versions might have different
performance characteristics and need different configuration.

--MqPioFIbuFc0cwHs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmR/RjoACgkQJNaLcl1U
h9AUVwf8CyAFfKVAo6ZDMUEq91ADRzXoi6CPFs0i/7YXDA4Bn+W7SBBAPcKlRntJ
pVeTavERw1fr6/DDrDwUBZFFAVGZVUIEi7PIk7f6im3YXyNNS8OXA7MN7W6SKJ+R
n2U1q+52cc+HbL8G3YDb4LQEtZMswrQfo9GC3SvsjDiWGwfIEyHArmOQPNzdK9dE
v2d1MqoBBGfLQWObYaiZ2nhtvvwr/K4q+VetO71CoG9daEJH2DBmSNIzsAG89dHE
8sViWI52rk21q7VzDsFtTFcmzlQbavd449EaNuCoooB5mBgkfZ3F3qRvj1d57W7r
HAwIdgBeFqzA8E5CExcO2zlNRc2bLA==
=VCQk
-----END PGP SIGNATURE-----

--MqPioFIbuFc0cwHs--
