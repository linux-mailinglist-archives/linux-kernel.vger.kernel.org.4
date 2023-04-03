Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D21496D507E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 20:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232094AbjDCScI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 14:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231701AbjDCScD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 14:32:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 583DF30D3;
        Mon,  3 Apr 2023 11:31:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DBBD16269A;
        Mon,  3 Apr 2023 18:31:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 955B1C433EF;
        Mon,  3 Apr 2023 18:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680546704;
        bh=o3RwlIhCEYrO4ntJi9qqgqGqIZpIGhhKYmBaW6wiPB4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Nl2aNxeK+tyv2h7Xtc3R6vMLqTxpdf26KonLrTUAaO0lMgylMBpw/EejnDB1bCQgF
         T1BABIWDQ44VCTNscPgGmtkkpm0ziUM0AqLkc4LhAZ9Mvg1clKGkjUVoeW/ema3zPq
         Zx96UQcBfLyh1DRKuWoFXh2T4Vk/RdUx6+HXapepur1qdNIy6FUoLqhLOsrqZF2lEY
         +U2q4NJ0EQw1WVoCKeyeJfk2+EGgjtJm/UKVdLKmfSRHQlXBa9jlKX0b0I+xQY69iU
         7Eu4/M1Y+vis85ilDZWwOOm8VVIy5FwgxkkBmSt/STmzzh4ENycyzpPy63n5kmqd0E
         Ad7VG/PjG5vbg==
Date:   Mon, 3 Apr 2023 19:31:38 +0100
From:   Conor Dooley <conor@kernel.org>
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Arnd Bergmann <arnd@arndb.de>,
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
Subject: Re: [PATCH v7 1/6] riscv: mm: dma-noncoherent: Switch using function
 pointers for cache management
Message-ID: <20230403-peroxide-retail-d7046cb806fe@spud>
References: <20230330204217.47666-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20230330204217.47666-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <f12f9773-77b5-4ba6-9e9e-adbc67ca0110@spud>
 <CA+V-a8s0UViJ0tBSyiL0ZG8iVT3QSW77=VujJJOfiuM8T=9ntg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="b/tLN+10ke3HU7wD"
Content-Disposition: inline
In-Reply-To: <CA+V-a8s0UViJ0tBSyiL0ZG8iVT3QSW77=VujJJOfiuM8T=9ntg@mail.gmail.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--b/tLN+10ke3HU7wD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 03, 2023 at 07:23:37PM +0100, Lad, Prabhakar wrote:
> > I think all of the above should be prefixed with riscv_cbom to match the
> > other riscv_cbom stuff we already have.
> Just to clarify, the riscv_cbom prefix should just be applied to the
> ZICOM functions and not to T-HEAD?

Yah, can leave the T-HEAD stuff as is IMO.

Cheers,
Conor.

--b/tLN+10ke3HU7wD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZCsbigAKCRB4tDGHoIJi
0p60AQCszeJEQpmXWuGiboXB8Hchy8tk2SJUYIcxRG/FXjMr1QEAxg/uIZdyzwLe
3Zibwoth4VJ2MTUzPgfVuRO6IPUtswE=
=S+Sw
-----END PGP SIGNATURE-----

--b/tLN+10ke3HU7wD--
