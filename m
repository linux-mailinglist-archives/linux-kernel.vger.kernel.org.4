Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4E0731106
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 09:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245058AbjFOHlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 03:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245312AbjFOHkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 03:40:03 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE1112D4B
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 00:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1686814778; x=1718350778;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PyAZ+UQySht1Ggox4vj01CIS3UNR5OIbU5jcrfJvb9c=;
  b=ukJZJukQgnKMjSsZBmtaCSlvjetmkKNMmNiqRddxEwonJck/zNc3Wfq6
   y91GVtFQlYplsMgAuaUW413gcE5JWoNfhyBd3NR1ql9F0LCc7/YibetuW
   mFL/bjqqXq3og6Iari3qlYTe3IPeAnUZrmppWxiBUupBerJ9vgp1g+DFe
   3DUsa5jdLwJTrjo6XYNVa061Iwr/2FzS6NgewG/4mVo707nF1omR7eWNO
   59PoNSKQsSkzjEEThCR1MwJVDkIdJdd2qJ26eRxR55WtNJOtY8LlWQhqT
   R/iiu0ewzITkp5huzNF2tW94S3+yRZ3OlxVEMea4mrreq3k7v2qxkSHD4
   Q==;
X-IronPort-AV: E=Sophos;i="6.00,244,1681196400"; 
   d="asc'?scan'208";a="220398517"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Jun 2023 00:38:30 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 15 Jun 2023 00:38:27 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 15 Jun 2023 00:38:25 -0700
Date:   Thu, 15 Jun 2023 08:37:59 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Nylon Chen <nylon.chen@sifive.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <jszhang@kernel.org>, <ajones@ventanamicro.com>,
        <aou@eecs.berkeley.edu>, <palmer@dabbelt.com>,
        <paul.walmsley@sifive.com>, <greentime.hu@sifive.com>,
        <zong.li@sifive.com>, <nylon7717@gmail.com>
Subject: Re: [PATCH v2] RISC-V: Support 32_PCREL relocation type in kernel
 module
Message-ID: <20230615-unvisited-deceit-9beab8ce987a@wendy>
References: <20230615072302.25638-1-nylon.chen@sifive.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="X3uZfQHN9blau7pK"
Content-Disposition: inline
In-Reply-To: <20230615072302.25638-1-nylon.chen@sifive.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--X3uZfQHN9blau7pK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Nylon, thanks for the update.

On Thu, Jun 15, 2023 at 03:23:02PM +0800, Nylon Chen wrote:
> Fix the 'unsupported relocation type' error caused by
> enabling the -fasynchronous-unwind-tables flag,
> which generates relocation types that are not supported.

What commit adds the -fasynchronous-unwind-tables flag?
Should there be a Fixes: tag for that commit?

Cheers,
Conor.

>=20
> Signed-off-by: Nylon Chen <nylon.chen@sifive.com>
> Reviewed-by: Zong Li <zong.li@sifive.com>
> ---
> Changed in v2:
> - add commit message.
>=20
>  arch/riscv/kernel/module.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/arch/riscv/kernel/module.c b/arch/riscv/kernel/module.c
> index 7c651d55fcbd..65be0360a494 100644
> --- a/arch/riscv/kernel/module.c
> +++ b/arch/riscv/kernel/module.c
> @@ -310,6 +310,15 @@ static int apply_r_riscv_sub64_rela(struct module *m=
e, u32 *location,
>  	return 0;
>  }
> =20
> +static int apply_r_riscv_pcrel_32_rela(struct module *me, u32 *location,
> +				       Elf_Addr v)
> +{
> +	ptrdiff_t offset =3D (void *)v - (void *)location;
> +
> +	*location =3D (*location & 0xffff0000) | (offset & 0xffff);
> +	return 0;
> +}
> +
>  static int (*reloc_handlers_rela[]) (struct module *me, u32 *location,
>  				Elf_Addr v) =3D {
>  	[R_RISCV_32]			=3D apply_r_riscv_32_rela,
> @@ -335,6 +344,7 @@ static int (*reloc_handlers_rela[]) (struct module *m=
e, u32 *location,
>  	[R_RISCV_SUB16]			=3D apply_r_riscv_sub16_rela,
>  	[R_RISCV_SUB32]			=3D apply_r_riscv_sub32_rela,
>  	[R_RISCV_SUB64]			=3D apply_r_riscv_sub64_rela,
> +	[R_RISCV_32_PCREL]		=3D apply_r_riscv_pcrel_32_rela,
>  };
> =20
>  int apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
> --=20
> 2.40.1
>=20

--X3uZfQHN9blau7pK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZIq/ywAKCRB4tDGHoIJi
0keJAQDIkc/zpv4sa2yC/D7U/ZNdjXyjn1F4e5TOctnC6ykUpAD+KeZHi+Wx/6e9
ONGjEQkKXwjDw/MTgIei7DiKwsSShAw=
=bAj9
-----END PGP SIGNATURE-----

--X3uZfQHN9blau7pK--
