Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8ED77089F9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 22:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjERU6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 16:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjERU61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 16:58:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C398115;
        Thu, 18 May 2023 13:58:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD2706521F;
        Thu, 18 May 2023 20:58:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B490C433EF;
        Thu, 18 May 2023 20:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684443506;
        bh=dLOqt+9eV007gsCn+QJROL9TL+gcr3DnH80bjs11dTw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ghOoRo84b6E7kyxQLeDNZYUc6PNoV+AyjnKXYinVqFVenQpnua9Xmctigo7X+/pmg
         feBLtbo/luYvzoxcz1dQooW92z0SdxsnO9EtcsNgKAFXCxvMryrHcIeMQulHX3zZGo
         1HhGAErdVqSHXwY6Zls9+8CRSTvU+K1IxpVKqtMNIiDk7/jeAHwVhNX+fjWKfAxFgT
         Q5thZgUru3wiNwon4wdvLYmNiltBcol030p2XpKuwD+FaIK+/WB7FUMQi6/OeU8vN0
         UPnksA6k931vnsU0erhjui/JmXDSfRJp4mOAq4ZAjodusntHDyMvEjTgUhhYidHPfe
         vl7ihD1B6oljw==
Date:   Thu, 18 May 2023 21:58:20 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, Yangtao Li <frank.li@vivo.com>,
        Wei Fu <wefu@redhat.com>, Icenowy Zheng <uwu@icenowy.me>
Subject: Re: [PATCH v2 9/9] riscv: defconfig: enable T-HEAD SoC
Message-ID: <20230518-dipping-hydrogen-7e6b673d327a@spud>
References: <20230518184541.2627-1-jszhang@kernel.org>
 <20230518184541.2627-10-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ZtJ462ZAP8whGsyR"
Content-Disposition: inline
In-Reply-To: <20230518184541.2627-10-jszhang@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZtJ462ZAP8whGsyR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 19, 2023 at 02:45:41AM +0800, Jisheng Zhang wrote:
> Enable T-HEAD SoC config in defconfig to allow the default
> upstream kernel to boot on Sipeed Lichee Pi 4A board.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

>=20
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  arch/riscv/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
> index d98d6e90b2b8..109e4b5b003c 100644
> --- a/arch/riscv/configs/defconfig
> +++ b/arch/riscv/configs/defconfig
> @@ -27,6 +27,7 @@ CONFIG_EXPERT=3Dy
>  CONFIG_PROFILING=3Dy
>  CONFIG_SOC_MICROCHIP_POLARFIRE=3Dy
>  CONFIG_ARCH_RENESAS=3Dy
> +CONFIG_ARCH_THEAD=3Dy
>  CONFIG_SOC_SIFIVE=3Dy
>  CONFIG_SOC_STARFIVE=3Dy
>  CONFIG_ARCH_SUNXI=3Dy
> --=20
> 2.40.0
>=20

--ZtJ462ZAP8whGsyR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZGaRbAAKCRB4tDGHoIJi
0iwVAQCZaep0aot5SLQOxVlXewZFM+OzCDth81alDYBTu7U83wEA7GvEJfaF5xSx
ZcEw14AURtjj8F8VE+YYldFTsAwrwwk=
=fE/E
-----END PGP SIGNATURE-----

--ZtJ462ZAP8whGsyR--
