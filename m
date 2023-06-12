Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3AB72CD28
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 19:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjFLRpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 13:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236691AbjFLRo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 13:44:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72677C7;
        Mon, 12 Jun 2023 10:44:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0DB3062C64;
        Mon, 12 Jun 2023 17:44:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44B7BC433EF;
        Mon, 12 Jun 2023 17:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686591895;
        bh=eI6fIoMUgSoE+G73OUjoTl05RN1AaQwDyQOnx0TU2bk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tfJUH6LUNWWA3FoOA6nZIe5AWvLJPVgdzxi2Nao2A//0mc3bPPf42vEMIeCTMcCZY
         KBaROnGtlOw54pddRX4sUfpmJ/HlB1is7xHR9FBUO7rGpMyoVh/fezfklTrxB/fDm0
         FNbkFeup1b7HGt9nXkhP8jWdfIUJlNVJQR9938zWkk2y7msb77iOyraG7imvpkVa07
         jf6kz+oCrqGeLFlXNHyfNIRlA1c65M3QIBl7kBIdOZ2D4X4BpjQJ6j67B3kyE8yCVc
         9M4ArKrgi5JRG0lqbAGEP7ycnB/qIXrVsnzC8oqIBP5oSO9iTxgBuuH7W49jdFCcC7
         hZIK9s8ewxn1w==
Date:   Mon, 12 Jun 2023 18:44:50 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        dri-devel@lists.freedesktop.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v2 2/5] dt-bindings: display: ssd1307fb: Remove default
 width and height values
Message-ID: <20230612-parade-sauciness-16225ce0a643@spud>
References: <20230609170941.1150941-1-javierm@redhat.com>
 <20230609170941.1150941-3-javierm@redhat.com>
 <20230610-opposite-quality-81d4a1561c88@spud>
 <87r0qj19zs.fsf@minerva.mail-host-address-is-not-set>
 <20230610-unused-engaged-c1f4119cff08@spud>
 <87jzwa29ff.fsf@minerva.mail-host-address-is-not-set>
 <d4828a3d-639a-a207-ff36-45c8c5d4d311@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5DyWqCbkPsD3ovzU"
Content-Disposition: inline
In-Reply-To: <d4828a3d-639a-a207-ff36-45c8c5d4d311@suse.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5DyWqCbkPsD3ovzU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 12, 2023 at 09:47:12AM +0200, Thomas Zimmermann wrote:
> Am 11.06.23 um 01:18 schrieb Javier Martinez Canillas:

> > But I will be OK to drop the "solomon,ssd130?fb-i2c" compatible strings
> > from the DRM driver and only match against the new "solomon,ssd130?-i2c"
> > compatible strings. And add a different DT binding schema for the ssd13=
0x
> > driver, if that would mean being able to fix things like the one mentio=
ned
> > in this patch.

If there are different compatibles, then it can always be sorted out
later iff it turns out to be a problem, since new devicetrees should not
be using the deprecated compatibles anyway. I didn't realise that those
deprecated compatibles existed, thanks for your patience.

> > In my opinion, trying to always make the drivers backward compatible wi=
th
> > old DTBs only makes the drivers code more complicated for unclear benef=
it.
> >=20
> > Usually this just ends being code that is neither used nor tested. Beca=
use
> > in practice most people update the DTBs and kernels, instead of trying =
to
> > make the DTB a stable ABI like firmware.
> >=20
>=20
> From my understanding, fixing the resolution is the correct thing to do
> here. Userspace needs to be able to handle these differences.

Fixing meaning correcting, or fixing meaning using a fixed resolution?
Not clear to me what you mean, sorry.


--5DyWqCbkPsD3ovzU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZIdZkgAKCRB4tDGHoIJi
0hy6APsHDkPD8VrqTNelS7nbRrC8vr5zxL5uQULyMVymFgX2jwEAwbyuKGaOgdoP
9WRjHxaFMkPMiyl4EYe1IBwp3iJSeQU=
=PcwL
-----END PGP SIGNATURE-----

--5DyWqCbkPsD3ovzU--
