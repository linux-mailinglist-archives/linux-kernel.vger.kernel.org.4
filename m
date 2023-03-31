Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC77A6D2783
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 20:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232715AbjCaSFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 14:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbjCaSFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 14:05:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 429371115F;
        Fri, 31 Mar 2023 11:05:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A7C38B82EAD;
        Fri, 31 Mar 2023 18:05:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4836C433EF;
        Fri, 31 Mar 2023 18:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680285915;
        bh=yhcavFdyZAlXWQO8EApfE+E9GTxovJYaD/pUnichZz0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L0k8seiS11xBTJAujqyXzQ//L9p/LdHzmCHVFeyDUgIsMpM7tSz5hx6qWke2G9xbR
         BEY/6T0imbYxxl08CO9kcNv/cI4o7XEZqqm4VAN9erLOx6HNoabWTd0rZPxdpKxLSa
         sOP+IhUAA96DLkD23XgTnI7euo4tZD7iIYFj6fDZOVbNTbmSNmCfsZCXH6NfxurBZT
         Hwv0LN8fZzUg1mNh/8Lbfg0GKkWvJOLTf5nl9iX1CmM+sQXBkZOEPs/RB4NwcsPlCK
         ikXaw2381vMyNXIa1lCRKXv5GX1IS6bp71jkkqeeeQVTa0AZ0b+r/+jr/gOeq7zNUL
         LW8YOT5ZFOsdQ==
Date:   Fri, 31 Mar 2023 19:05:09 +0100
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
Subject: Re: [PATCH v7 0/6] RISC-V non-coherent function pointer based CMO +
 non-coherent DMA support for AX45MP
Message-ID: <b2dcda17-5850-47c1-94bc-4ca87f900581@spud>
References: <20230330204217.47666-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bVgU0rnp1uDT6zu5"
Content-Disposition: inline
In-Reply-To: <20230330204217.47666-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bVgU0rnp1uDT6zu5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 30, 2023 at 09:42:11PM +0100, Prabhakar wrote:

> - This series requires testing on Cores with zicbom and T-Head SoCs

I don't actually know if there are Zicbom parts, may need to test that
on QEMU.
I had to revert unrelated content to boot, but my D1 NFS setup seems to
work fine with these changes, so where it is relevant:
Tested-by: Conor Dooley <conor.dooley@microchip.com> # tyre-kicking on D1

Cheers,
Conor.

--bVgU0rnp1uDT6zu5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZCcg0gAKCRB4tDGHoIJi
0olCAQCODgwigBuDYnHh9SF7jlHE8FV8O/wdkD8XBah6GNMDWAD/djjcC5dOGg3O
+9LnK+BLDW/pLsgfMrjK3UpuiS7xYQ4=
=R6x2
-----END PGP SIGNATURE-----

--bVgU0rnp1uDT6zu5--
