Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEA01722A46
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 17:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233754AbjFEPIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 11:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233691AbjFEPII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 11:08:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E44D9F7;
        Mon,  5 Jun 2023 08:08:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 66F1961A33;
        Mon,  5 Jun 2023 15:08:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96EDBC433D2;
        Mon,  5 Jun 2023 15:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685977686;
        bh=TUnJ2BXVl10ANhL4RWDXm6wNiv5IcJXcwpqMUue5pMk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lu1c1KUbihrACAZM1WwkhlEc2SjxpozUb7R3/hWKHvBodTdd+k0vJ5jHNVZXF7p1H
         QU3OOUHV5iizqplgo9tz1Dz35cYSjVLP3YTdvbq7Pte0BR42A9FB3izWmoLYQ/WPmU
         WaB8MfFZ8jnXjGki1AOPR3+JKf8zViE5lAmSX+qhF4uceYl5PPvtlxJ4GFihhnqNYV
         A8s2MnOm0bdNu9FSRpHmpRf8SyqX9fUOZco5cs8CuHHut1Xh2S+Q/TwxQmHfs6keLJ
         5nkpG3ii+iNTrkDUNsOEdLouO9FAzIZIPvbfSBuLV8yFpoL6E1hw6EdqkNin/Y8Hx5
         D7A9VBTkXHo3g==
Date:   Mon, 5 Jun 2023 16:08:02 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Paulo Pavacic <pavacic.p@gmail.com>
Cc:     neil.armstrong@linaro.org, sam@ravnborg.org, airlied@gmail.com,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: display: panel: add fannal,c3004
Message-ID: <20230605-untracked-trillion-d30cb9cb77c5@spud>
References: <20230519142456.2588145-1-pavacic.p@gmail.com>
 <20230519142456.2588145-2-pavacic.p@gmail.com>
 <20230519-emerald-void-066fad80950a@spud>
 <CAO9szn2sYRezCUQKFZ_qsVfne0gpWoirZoE-HpWTPS4G1U5fNQ@mail.gmail.com>
 <20230605-handyman-rebound-0c10df9dfaf2@spud>
 <CAO9szn0crQzy0L2Y-NZGKEVbpspxZMkO0oPpYr1WMS081ZxKRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="GT4Wjy9c0rngJLum"
Content-Disposition: inline
In-Reply-To: <CAO9szn0crQzy0L2Y-NZGKEVbpspxZMkO0oPpYr1WMS081ZxKRw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GT4Wjy9c0rngJLum
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 05, 2023 at 04:56:13PM +0200, Paulo Pavacic wrote:
> Hello Conor,
>=20
> pon, 5. lip 2023. u 16:43 Conor Dooley <conor@kernel.org> napisao je:


> Sorry this is my first patch, I still don't understand, why should I
> add `maxItems: 1` to the 'reg:' ?
> Isn't  part of the code:
> > required:
> >  - compatible
> >  - reg
> >  - reset-gpios
>=20
> making `minItems: 1` redundant for reg properties?

I went and had another look, and you get enforcement of this from the
dsi-controller binding if extra reg entries are added.
Sorry for the noise.



--GT4Wjy9c0rngJLum
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZH36UgAKCRB4tDGHoIJi
0oonAQD3lGSB2k18Pg6DEw5Bz+u2pdmbiD39MplQ8K9WA5ojCgD5Aco+KHU0HRlL
h6BQhlYAo5Sm6sACbPSTCiSyVp/qIwY=
=RxHH
-----END PGP SIGNATURE-----

--GT4Wjy9c0rngJLum--
