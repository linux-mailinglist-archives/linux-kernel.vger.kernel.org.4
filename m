Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 292A4674EFC
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 09:07:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbjATIHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 03:07:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjATIHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 03:07:13 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC3740D6
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 00:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1674202032; x=1705738032;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Nj4qwETRubMj/7izseQtk6cz1ZsfPsRki/sm74Um4Lk=;
  b=E1POXk2AToy71Cfi/wBMr1XWKNOhVkkxaTWI7lxj+ZqKaThSg2pXnGrM
   c/XEKQfa+GkJhbhjj2+HwJAofFoPS5OfhaOR0NWIMjrrqCCI7Z+c4qMgT
   L8TN/6Rf4QVtlfNyYQq8r+AjPoc8bwpnGUTlJIoxe6XjZzi08AqJBXWal
   QT3bH1Oia7Ab266mSkOJ2FxlYLL4pWICor0/lZaK8W0d3GFZ+dxNlIfPV
   K1T7SvFrcTQ7udAdB55jheQnBWcv96XEY+v1tJCd7TeIbpCuyWOWH8lGi
   TEsEGyAeEVNzVU9Fy8V8Yh8B1bgzbBqse5QAMyBuWoQ0MqhKnnXCk9ivi
   A==;
X-IronPort-AV: E=Sophos;i="5.97,231,1669100400"; 
   d="asc'?scan'208";a="133248756"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Jan 2023 01:07:11 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 20 Jan 2023 01:07:08 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Fri, 20 Jan 2023 01:07:06 -0700
Date:   Fri, 20 Jan 2023 08:06:43 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Jisheng Zhang <jszhang@kernel.org>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Conor Dooley <conor@kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 5/5] riscv: select ARCH_WANT_LD_ORPHAN_WARN for
 !XIP_KERNEL
Message-ID: <Y8pLk18Y+Jn4NI8f@wendy>
References: <20230119155417.2600-1-jszhang@kernel.org>
 <20230119155417.2600-6-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="co02PEkryjRdO7+H"
Content-Disposition: inline
In-Reply-To: <20230119155417.2600-6-jszhang@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--co02PEkryjRdO7+H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 19, 2023 at 11:54:17PM +0800, Jisheng Zhang wrote:
> Now, after that all the sections are explicitly described and
> declared in vmlinux.lds.S, we can enable ld orphan warnings for
> !XIP_KERNEL to prevent from missing any new sections in future.
>=20
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>

Warnings that the automation picked up are now gone in v2, thanks!
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

> ---
>  arch/riscv/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index e2b656043abf..335e0c45cced 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -46,6 +46,7 @@ config RISCV
>  	select ARCH_WANT_FRAME_POINTERS
>  	select ARCH_WANT_GENERAL_HUGETLB
>  	select ARCH_WANT_HUGE_PMD_SHARE if 64BIT
> +	select ARCH_WANT_LD_ORPHAN_WARN if !XIP_KERNEL
>  	select ARCH_WANTS_THP_SWAP if HAVE_ARCH_TRANSPARENT_HUGEPAGE
>  	select BINFMT_FLAT_NO_DATA_START_OFFSET if !MMU
>  	select BUILDTIME_TABLE_SORT if MMU
> --=20
> 2.38.1
>=20

--co02PEkryjRdO7+H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY8pLkwAKCRB4tDGHoIJi
0ugMAP9Dtdasv+Ucfm8ro1/RC9MvuaXtDAS68fInTuAe3ffwYAEAn+1tR7N9WYfp
APblBwTpPB1jUvJX1Hg3YNFGDGGINwk=
=AEBc
-----END PGP SIGNATURE-----

--co02PEkryjRdO7+H--
