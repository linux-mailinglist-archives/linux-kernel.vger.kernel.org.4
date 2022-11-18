Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B63E662F96D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 16:37:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242393AbiKRPhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 10:37:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242505AbiKRPhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 10:37:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB51B781B3;
        Fri, 18 Nov 2022 07:37:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A790625A4;
        Fri, 18 Nov 2022 15:37:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10CE0C433C1;
        Fri, 18 Nov 2022 15:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668785819;
        bh=57l+idEGxs6Fkigjt1SVVkSFa0sb7GM3WUToVsS/X0s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CNQJv7YCmb/p2EUHOadQ6N0/2Iz71suMvoYHthTIdQkYbn8qD4Ep5pcQPiCcAx7Pc
         l6E3ETQbn8DiLockjrEG75xSFmYzev0LIXloqNOP5OeCCHizU6It0QPIuwku9sB5tQ
         4wwdj1nR7IW78mpHQ6EavBYe+TZ/0hQNAZi8V5J8+LXecfu4B8cTGDbz+w3lthevuc
         ZxCv7Osc5NshwS57RGNbdHLWlsqzqgQjP0roOD3J5h/d7FnVXyqoBoAHStnMTceIN8
         OIFcaFnVMR0tYD2u5LBDandx2D8/QDY6LeFxdZWoYCtW8eVD3YDalEtP8MAoJMBbIX
         WUII+FTZ1ut8Q==
Date:   Fri, 18 Nov 2022 15:36:56 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: spi: Add Socionext F_OSPI controller
 bindings
Message-ID: <Y3emmHGM6uS0m5kd@sirena.org.uk>
References: <20221118005904.23557-1-hayashi.kunihiko@socionext.com>
 <20221118005904.23557-2-hayashi.kunihiko@socionext.com>
 <Y3du24GWN/enGORf@sirena.org.uk>
 <5483711f-504c-bcf3-0fbf-65d04530d188@socionext.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MRUeBLnPLiUD0O8l"
Content-Disposition: inline
In-Reply-To: <5483711f-504c-bcf3-0fbf-65d04530d188@socionext.com>
X-Cookie: Ego sum ens omnipotens.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MRUeBLnPLiUD0O8l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 18, 2022 at 11:16:22PM +0900, Kunihiko Hayashi wrote:
> On 2022/11/18 20:39, Mark Brown wrote:
> > On Fri, Nov 18, 2022 at 09:59:03AM +0900, Kunihiko Hayashi wrote:

> > > +  socionext,cs-start-cycle:
> > > +  socionext,cs-end-cycle:
> > > +  socionext,cs-deassert-clk-cycle:

> > These are all generic SPI properties so we should add them
> > generically, on the device rather than the controller since this
> > is something that might vary per client device.  There was also a
> > core function spi_set_cs_timing() which was in earlier versions
> > and is about to get reintroduced.

> So I understand you mean that these properties should be defined like
> spi-peripheral-props.yaml for the devices.

> If yes, I'll drop these properties once and define our vendor-specific
> "peripheral-props" in the next series.

Yes, sounds good.

> > > +    $ref: /schemas/types.yaml#/definitions/uint32-array
> > > +    items:
> > > +      - description: the number of bytes to transfer
> > > +        maximum: 4
> > > +      - description: value to transfer
> > > +        default: 0
> > > +      - description: bit-width to transfer
> > > +        enum: [0, 1, 2, 4, 8]

> > This is also something SPI device should set up, as far as I can
> > tell this should be set vis spi_mem_op.dummy.nbytes.

> Yes, but the controller also supports dummy cycles, and can send
> extra bytes before the dummy cycles.

Ah, so this is some additional thing on top of dummy cycles?  I'd
not realised that.  It probably wants to be added into spi-mem I
guess.

> > > +  socionext,data-swap-2byte:
> > > +    description:
> > > +      Indicates swap byte order per 2-bytes.
> > > +    type: boolean
> >=20
> > > +  socionext,data-swap-4byte:
> > > +    description:
> > > +      Indicates swap byte order per 4-bytes.
> > > +    type: boolean

> > Again these should be set by the device.  I think these should be
> > set based on a combination of bits per word and if the host is in
> > big endian or little endian mode.

> I see. This feature is complicated to use, so I'll not add it here.

That also works, someone can always add additional support later
when they have a concrete use case.

--MRUeBLnPLiUD0O8l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmN3ppcACgkQJNaLcl1U
h9C7MAf/ZniKmhRdAWeZsowY/qy6zpAwJiATBzqTv3G24VqhieLk+azOeSJKHJPR
FEkFj1RiVTh3UOtX9dx9arInJfIj2fcPNHHBJTU+YDX5OCSKX81Md+6Cp2CwAYsA
JiDZs3d8OXFoLxo39D5sFFHRonMx01/bbzSZ9ipdjo81dkThNFKD6KLA8Sg23sr6
mAPx1ZNF3i5fnLftPM5DSM8gMLIFFIo4UIJhtaY5i+X6nfcusmpQayTyIwUXmUoG
vcVwUtbI9y6r2HTjYQAsxRi3vKS0h+g8R5xMXiElVwL/TH85J/eHOXJ6Gr7iD+5L
dZ2eYQHbIjVKkvkHe+Ye0jq6NSkvqA==
=9Unj
-----END PGP SIGNATURE-----

--MRUeBLnPLiUD0O8l--
