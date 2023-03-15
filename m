Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E07DD6BAA88
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 09:14:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbjCOIOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 04:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjCOIOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 04:14:19 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7453A24117;
        Wed, 15 Mar 2023 01:14:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 835C3CE1905;
        Wed, 15 Mar 2023 08:14:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66742C433D2;
        Wed, 15 Mar 2023 08:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678868052;
        bh=RYBEOk+HK2aRj9LqS2VuCmRmezqPOUjCPLS3OrVq21o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=It7x0u2QWNI01AxqasCNsexzhbUEwlriKjOKPlU9dy1pPQR+mW0uMLAPF3YAeoUd3
         sH44L4IVmHXaHJoxrr5ECxgJCLWTE1FZLViiH+SMfafccYu+Xk3icuKLb5JO93jqBI
         FDOACRMCojYOw1j320frZcsO2VFKbDsKgnBnpnHthkSUxa9I8L+8L7My3vUSYvsC5e
         15PG6UnTZrQlHsNnYSn5P8qAzrpnc3084BpyUmVQgVqQ+TUG9HZzJGx5u+YpaEHLgp
         V1rIg+uy/JFhoKVnQhO9adsCJDSYvnlUZNB1IolAHtu4On3bJ023VbjED+TRCMfAcT
         ypfdd6PSkWlMw==
Date:   Wed, 15 Mar 2023 08:14:06 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Xingyu Wu <xingyu.wu@starfivetech.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Hal Feng <hal.feng@starfivetech.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v3 00/11] Add new partial clock and reset drivers for
 StarFive JH7110
Message-ID: <e895fea6-e13b-450f-97e8-34ecfe075691@spud>
References: <20230314124404.117592-1-xingyu.wu@starfivetech.com>
 <de14f63beb2b3e424ec2375187c8087f.sboyd@kernel.org>
 <729b1b69-aba6-4623-cf78-b08562d30d76@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="KCsBIXoje4qDVRrt"
Content-Disposition: inline
In-Reply-To: <729b1b69-aba6-4623-cf78-b08562d30d76@starfivetech.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KCsBIXoje4qDVRrt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Stephen,

On Wed, Mar 15, 2023 at 11:44:00AM +0800, Xingyu Wu wrote:
> On 2023/3/15 8:30, Stephen Boyd wrote:
> > Quoting Xingyu Wu (2023-03-14 05:43:53)
> >> This patch serises are to add new partial clock drivers and reset
> >> supports about System-Top-Group(STG), Image-Signal-Process(ISP)
> >> and Video-Output(VOUT) for the StarFive JH7110 RISC-V SoC.
> >=20
> > What is your merge plan for this series? Did you intend for clk tree to
> > take the majority of patches? We won't take the dts changes through the
> > clk tree.

FWIW, I've been waiting for the "main" clock/reset series [1] to be ready
to go, before suggesting that I take it (the main series) via the soc
tree. This one is kinda in the same boat, with defines in the dt-binding
headers that are used by both drivers and dts, so splitting the two
doesn't make all that much sense.

As Xingyu points out below, this series depends on the main one, so if I
was to take that via soc, this one would need to go on top, or be
delayed.
At what point does that become too much to go via soc and some sort of
shared tag become needed?

Thanks,
Conor.

> >=20
> > I think Philipp Zabel reviewed some earlier version of the patches and
> > provided reviewed-by tags. Can you check if they can be added here? If
> > so, please resend again, or get those merged through the reset tree.
>=20
> These patches add new clock & reset providers based on the basic clock & =
reset
> of the minimal system which Hal.feng had submitted[1], which are used in =
USB, DMA,
> VIN and Display modules that are merging.
[1]: https://lore.kernel.org/all/20230311090733.56918-1-hal.feng@starfivete=
ch.com/
>=20
> Oh I checked and had not received any comments from Philipp Zabel in earl=
ier version
> of these patches. Maybe it was confused with the patches of the minimal s=
ystem.
>=20
> Best regards,
> Xingyu Wu

--KCsBIXoje4qDVRrt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZBF+SgAKCRB4tDGHoIJi
0m5xAQDTPvvjhBE832qUHY52KqkLnWO+zVLbPmehlEo0xNwyOgEAyLmITy69AFwW
1sNnZiP3T9rxdKwPr1lXTsdPnIjPtA0=
=kWwU
-----END PGP SIGNATURE-----

--KCsBIXoje4qDVRrt--
