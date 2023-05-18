Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 495677089F7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 22:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjERU6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 16:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjERU6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 16:58:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B85EEE;
        Thu, 18 May 2023 13:58:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 27E4461483;
        Thu, 18 May 2023 20:58:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82181C433EF;
        Thu, 18 May 2023 20:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684443480;
        bh=gztsp3fF7F7lE0Gq7hFjQZFysPQRZ4MJDfLKBKu76S8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Myapdnf7TO6ObDDUVUsZTadfQ3aUQr9ByHv3ssFF9IVGAJh7jqnv/RFlm1SeFvafu
         b16toAhROaXkq4gOWRp0allqQT00zQ7NKxfPL4S8Js98phdqY7fE5gVflhjIW/tsye
         QrcHPoM7Ol3XsLhjuWGsuFPjZvKpINh9nn5cOA/ydHYcXvr82Be4mOEvG0a3lAZ3vH
         NNQWxB+AmlErDf+I4oO+rd7KhgnVqw9EFuPG/hqkPGdaBn8C5DylXQsWPL0K0RT6P0
         yWKtGnLEzlbhLdpz+Txg6a/2ijktxVN20gbUwe3IEJ2IlhLN0psb+NtLF3T25QX2/e
         O5jXFCyaGabhA==
Date:   Thu, 18 May 2023 21:57:55 +0100
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
Subject: Re: [PATCH v2 8/9] MAINTAINERS: add entry for T-HEAD RISC-V SoC
Message-ID: <20230518-unharmed-stencil-2a18bbdd3651@spud>
References: <20230518184541.2627-1-jszhang@kernel.org>
 <20230518184541.2627-9-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wXJR5fk22KSm3hPO"
Content-Disposition: inline
In-Reply-To: <20230518184541.2627-9-jszhang@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wXJR5fk22KSm3hPO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 19, 2023 at 02:45:40AM +0800, Jisheng Zhang wrote:
> Currently, I would like to maintain the T-HEAD RISC-V SoC support.
>=20
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
>  MAINTAINERS | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e0ad886d3163..6df20c65798a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18162,6 +18162,12 @@ F:	drivers/perf/riscv_pmu.c
>  F:	drivers/perf/riscv_pmu_legacy.c
>  F:	drivers/perf/riscv_pmu_sbi.c
> =20
> +RISC-V THEAD SoC SUPPORT
> +M:	Jisheng Zhang <jszhang@kernel.org>
> +L:	linux-riscv@lists.infradead.org
> +S:	Maintained
> +F:	arch/riscv/boot/dts/thead/
> +
>  RNBD BLOCK DRIVERS
>  M:	Md. Haris Iqbal <haris.iqbal@ionos.com>
>  M:	Jack Wang <jinpu.wang@ionos.com>
> --=20
> 2.40.0
>=20

--wXJR5fk22KSm3hPO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZGaRUgAKCRB4tDGHoIJi
0o7QAP9iQ1BXkMIsQtr3zaOwvROUr5+2+UTjp+d2++QKI5bStgD/Xbdu1dJDE1Z6
T1DtDEc65WjaVS7QlpnDfGrWT1HTQA8=
=2+6X
-----END PGP SIGNATURE-----

--wXJR5fk22KSm3hPO--
