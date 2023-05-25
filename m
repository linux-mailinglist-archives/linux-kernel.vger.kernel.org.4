Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1121C7105A5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 08:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237876AbjEYGXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 02:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232917AbjEYGXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 02:23:38 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 371E6189
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 23:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1684995817; x=1716531817;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ghme1meWK1ImCCdM1WzI68Ss/WXHp7TVgzNVm+Epnjc=;
  b=wScwTWOZ2He9tEUFUd56bmYgLTSvNZPjnRDc7MQ9VC7Q/LlQqZJn1Dp2
   vE/EtGTUIs4OvLhVjuxNZ5aO1Xy6TrQ+VomANeTAzGq7JaCIKkPXLcM0d
   DeSSD9zjOCkz7TGMgf6OjCNDP8elLy4jVDJQPQreHajDOcYDGnoyWrejI
   pl+0OWjKt34bpEi3GazO+ElsQNobTnZFAGRUjcSCQen/MyQm8HG6KPeA1
   DtkQrU63ziphB1DO+tKNp17Yv1w851Gj8td1Q5qEfaHuf5M0ZIJlTi4Tr
   1wPDwAyzfSXPWR7hiprOLBkNLk02CsMqFVLMdoj4n2aVzsrVCiNDMg7gt
   w==;
X-IronPort-AV: E=Sophos;i="6.00,190,1681196400"; 
   d="asc'?scan'208";a="226922975"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 May 2023 23:23:36 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 24 May 2023 23:23:36 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Wed, 24 May 2023 23:23:35 -0700
Date:   Thu, 25 May 2023 07:23:12 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Jia Jie Ho <jiajie.ho@starfivetech.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] riscv: Kconfig: Add select ARM_AMBA to SOC_STARFIVE
Message-ID: <20230525-palm-sponge-982d6591a791@wendy>
References: <20230525061836.79223-1-jiajie.ho@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ylMnpRf4XX0fWufC"
Content-Disposition: inline
In-Reply-To: <20230525061836.79223-1-jiajie.ho@starfivetech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--ylMnpRf4XX0fWufC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 25, 2023 at 02:18:36PM +0800, Jia Jie Ho wrote:
> Selects ARM_AMBA platform support for StarFive SoCs required by spi and
> crypto dma engine.

Thanks for sending this.
@Palmer, this depends on another commit not to introduce a build
breakage. I'll assign it to myself on patchwork and grab it when it is
okay to take.

Cheers,
Conor.

> Signed-off-by: Jia Jie Ho <jiajie.ho@starfivetech.com>
> ---
>  arch/riscv/Kconfig.socs | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
> index 1cf69f958f10..381cd46e6373 100644
> --- a/arch/riscv/Kconfig.socs
> +++ b/arch/riscv/Kconfig.socs
> @@ -29,6 +29,7 @@ config SOC_STARFIVE
>  	bool "StarFive SoCs"
>  	select PINCTRL
>  	select RESET_CONTROLLER
> +	select ARM_AMBA
>  	help
>  	  This enables support for StarFive SoC platform hardware.
> =20
> --=20
> 2.25.1
>=20

--ylMnpRf4XX0fWufC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZG7+xgAKCRB4tDGHoIJi
0k9pAQDUpqkrJRbYh5sYq+n3pPlZLrQc///FQAFjI7KN3QmScQD+MFimNIW8AIW7
pZdF4NL8P0bEjKDODFMC0ootIH+67A8=
=DagS
-----END PGP SIGNATURE-----

--ylMnpRf4XX0fWufC--
