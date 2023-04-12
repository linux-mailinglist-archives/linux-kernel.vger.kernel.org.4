Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1092C6DFFCE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 22:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbjDLU3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 16:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbjDLU3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 16:29:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5461C19AF;
        Wed, 12 Apr 2023 13:29:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B3B9A6301E;
        Wed, 12 Apr 2023 20:29:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75E2FC433D2;
        Wed, 12 Apr 2023 20:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681331369;
        bh=SMFTrtm8F56BYtO7WRy9KbxTslw280tD5lb7SokAxHY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i7KJP/r/6+Bc/+yOJfGLfQZa2f0ZTkVQEelMhSCMZbgcGYrJ68ShWlVt0/o0vqX/a
         33WHUt0pT2PIO6ip/s/dNX1NgQWScquNHAZAkx9vYtwIgVNTw4htluZONiua5uptlL
         I1MN+zgDA6WJ6j8asLMWRVV3GYYVLvxqoQATRpYTdvor43lFvy4X7Xzwao6ZZ94tAr
         mZus7L1DbdPJHK9JFo6QTvDYao+1LGiHzv+sPyIoOtlIeklCmHVa+gi/XfGiXVud5W
         VubXYiZ+o2RVLRZwT3Qc2MluUk4nfkm6wNGcqSHwY/GxjfbBwAJmT4vzXXWzl8y0nT
         oeoIxs6CDn5cw==
Date:   Wed, 12 Apr 2023 21:29:23 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Conor Dooley <conor.dooley@microchip.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Heiko Stuebner <heiko@sntech.de>, Guo Ren <guoren@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Samuel Holland <samuel@sholland.org>,
        linux-riscv@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v8 6/7] riscv: errata: Hookup the Andes AX45MP
 non-coherent handling
Message-ID: <20230412-undamaged-tinkling-f09480a79a3f@spud>
References: <20230412110900.69738-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20230412110900.69738-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="CsvZMM4EQwWB31I3"
Content-Disposition: inline
In-Reply-To: <20230412110900.69738-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--CsvZMM4EQwWB31I3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 12, 2023 at 12:08:59PM +0100, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> Hookup the Andes AX45MP non-coherent handling by updating the
> ALT_CMO_OP() macro which will be used by dma-noncoherent.c for
> non-coherent platforms.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--CsvZMM4EQwWB31I3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZDcUogAKCRB4tDGHoIJi
0lKwAQC9uoLrdeMxDWMXGtkSEJctgAv/TAAU1M4M8iQMfnze6wD+Ij9zAaoQkdio
DeUOQEeiUfKrN0A/v3ag6RtQXTCzWAo=
=ua6z
-----END PGP SIGNATURE-----

--CsvZMM4EQwWB31I3--
