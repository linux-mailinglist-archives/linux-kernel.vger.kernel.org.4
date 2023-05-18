Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04C50708A05
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 23:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbjERVDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 17:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjERVDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 17:03:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B332512F;
        Thu, 18 May 2023 14:03:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 32CF06157E;
        Thu, 18 May 2023 21:03:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73627C433D2;
        Thu, 18 May 2023 21:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684443828;
        bh=vLaaNAsorEnigaIcnHbox5e9MfLDFmPSL02ltL0CThc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xtfyc3AH/Z4bEiPI2/cIIfL4R/TXTfp1LMdaPofy66BKsxmK4BCSsQ4y9ljtMcfxF
         kiPtieucFB3+htqZZzE2+x7w6bMzdTS8OScM2OSUePfozVQmEbJ4MiQy3mRQS2QDyM
         hSajpT4Y/gKJln3eeXNnXi2dXN16WKenTYIXeZLD93ioxks1aOUWklJWO5QGEBOvBr
         4ciez26YDs11RzI09tLT/dNpqo2bowWtux2dSgZsKncTH66zDDXOnrFOSybBddT1bi
         mtHqNwvSNWp6fY5Jik894EPfliNLso6ZfCWrpGB7kPLZtbz3ajBSggLqIq53Ma0XQr
         /0M/q9yNr05lw==
Date:   Thu, 18 May 2023 22:03:42 +0100
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
Subject: Re: [PATCH v2 7/9] riscv: dts: thead: add sipeed Lichee Pi 4A board
 device tree
Message-ID: <20230518-prewar-supervise-847839c67626@spud>
References: <20230518184541.2627-1-jszhang@kernel.org>
 <20230518184541.2627-8-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="LH4wKagUCviZfHUG"
Content-Disposition: inline
In-Reply-To: <20230518184541.2627-8-jszhang@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LH4wKagUCviZfHUG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 19, 2023 at 02:45:39AM +0800, Jisheng Zhang wrote:
> Sipeed's Lichee Pi 4A development board uses Lichee Module 4A core
> module which is powered by T-HEAD's TH1520 SoC. Add minimal device
> tree files for the core module and the development board.
>=20
> Support basic uart/gpio/dmac drivers, so supports booting to a basic
> shell.
>=20
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>

> +	compatible =3D "sipeed,lichee-pi-4a", "sipeed,lichee-module-4a", "thead=
,th1520";

This patch, modulo my comments elsewhere about the compatibles, seems
fine.

--LH4wKagUCviZfHUG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZGaSrgAKCRB4tDGHoIJi
0utXAQCaXuE/e3Se/xdiaQYsIeHovF8GgSLB6XrLFIXpCZiVxwEAvGsxWRFkwJv4
dQph4g75ONu0jX6GjCPQowUalTW/iQc=
=2zzp
-----END PGP SIGNATURE-----

--LH4wKagUCviZfHUG--
