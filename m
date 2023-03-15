Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDDC56BBC14
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 19:32:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbjCOScB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 14:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjCOSb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 14:31:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A9FC8C801
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 11:31:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EB226B81ED4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 18:31:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1F0FC4339B;
        Wed, 15 Mar 2023 18:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678905114;
        bh=Ncb0gJdx1/flmrdCUnpBam8TTRy0fLGXaXnanEBF8js=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eamlRSsJ27eJUlcEAVpLsYZRacIt4E6Zu5/a6HFgZ9sYbHQdwaUNzw1SsXJXSB+az
         3ghywPTyRf6b9sdLp8lxpI1pM/eHn0hWYAbBJhBPU6KhDOtJAA76MxGW7QhM6ecIB3
         AMzNdskUthD0X3PjZ0YdbEnBJV+zOE3j/fEx7l+VMVDUW9OLp7+cLLDo09za5mz2q1
         LsoUUl7fSpSGCIucwgTpLPYf1c938J3tfSC95fmFxNphBDY8llM26gzaz1Sp4M2QP2
         nf21rFV7J0MZPKeDmtmbY7LeIfpwNi1GAcVOh75hI6zJHyYlwKFoEBK8a6GJz3nzu1
         tDd2T8mF7eL5A==
Date:   Wed, 15 Mar 2023 18:31:50 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     palmer@dabbelt.com, linux-riscv@lists.infradead.org,
        samuel@sholland.org, guoren@kernel.org,
        christoph.muellner@vrull.eu, conor.dooley@microchip.com,
        linux-kernel@vger.kernel.org,
        Heiko Stuebner <heiko.stuebner@vrull.eu>
Subject: Re: [PATCH RFC 1/2] RISC-V: define the elements of the VCSR vector
 CSR
Message-ID: <7aac603a-6e9a-4e72-b41b-9412e2fe904d@spud>
References: <20230228215435.3366914-1-heiko@sntech.de>
 <20230228215435.3366914-2-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="1grvyHc0dstNVZsj"
Content-Disposition: inline
In-Reply-To: <20230228215435.3366914-2-heiko@sntech.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1grvyHc0dstNVZsj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 28, 2023 at 10:54:34PM +0100, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@vrull.eu>
>=20
> The VCSR CSR contains two elements VXRM[2:1] and VXSAT[0].
>=20
> Define constants for those to access the elements in a readable way.
>=20
> Signed-off-by: Heiko Stuebner <heiko.stuebner@vrull.eu>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

> ---
>  arch/riscv/include/asm/csr.h | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
> index add51662b7c3..8b06f2472915 100644
> --- a/arch/riscv/include/asm/csr.h
> +++ b/arch/riscv/include/asm/csr.h
> @@ -176,6 +176,11 @@
>  #define ENVCFG_CBIE_INV			_AC(0x3, UL)
>  #define ENVCFG_FIOM			_AC(0x1, UL)
> =20
> +/* VCSR flags */
> +#define VCSR_VXRM_MASK			3
> +#define VCSR_VXRM_SHIFT			1
> +#define VCSR_VXSAT_MASK			1
> +
>  /* symbolic CSR names: */
>  #define CSR_CYCLE		0xc00
>  #define CSR_TIME		0xc01
> --=20
> 2.39.0
>=20

--1grvyHc0dstNVZsj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZBIPFgAKCRB4tDGHoIJi
0sCCAP9uVtBPvDs3b/mh7wVe0vAWF+NNvUE1PNSr3aXv2QEc4wD9H1mI9C++SCPF
F8E/gmmYVFJxXY3gP63CWtf0+4H39Aw=
=16jT
-----END PGP SIGNATURE-----

--1grvyHc0dstNVZsj--
