Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA2586756E7
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 15:20:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbjATOUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 09:20:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbjATOTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 09:19:30 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2340E1EFEF;
        Fri, 20 Jan 2023 06:18:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1674224344; x=1705760344;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8wOj9+QwCLtyXBCLcRQBXGg6eCl/vXY57DMzFXi9tbY=;
  b=eT6MtJZ78i7mb0PYUvlIZLeldnd+xq0R8qCjgQ6TfEj6U0E/2Fu2ufn8
   8MhvHJhLyuHE7kCwTgl6nP0W6hkXPuFzLg/Yyif6scTjLsvLJU2+BzQQK
   Xco+9pCZUve+6YLMEFQK6XkE7x/NB+pETk81gjgbM/EwE36NPlRfrVNS/
   tPXn8OqR0qApERsJvOSDbp/zaydbBviFqZMZfhh4b6seez9GzD65SZU1N
   Pxfk1s0s2+GH6CWg9epLvccgQ9reXWIzlHGvl0NJxaYA9c8IYmbXVPDET
   qygcCTZwgpnNuk/EcgQI2veU2OcKv0hunmDkarG6GDZKiuHDHx+074oEx
   g==;
X-IronPort-AV: E=Sophos;i="5.97,232,1669100400"; 
   d="asc'?scan'208";a="196710524"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Jan 2023 07:17:16 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 20 Jan 2023 07:17:13 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Fri, 20 Jan 2023 07:17:11 -0700
Date:   Fri, 20 Jan 2023 14:16:48 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Andrew Jones <ajones@ventanamicro.com>
CC:     <linux-riscv@lists.infradead.org>,
        Palmer Dabbelt <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
        <conor@kernel.org>, <corbet@lwn.net>, <guoren@kernel.org>,
        <heiko@sntech.de>, <paul.walmsley@sifive.com>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>
Subject: Re: [PATCH v2 2/3] RISC-V: resort all extensions in consistent orders
Message-ID: <Y8qiUCH6ERYmAdgg@wendy>
References: <20221205144525.2148448-1-conor.dooley@microchip.com>
 <20221205144525.2148448-3-conor.dooley@microchip.com>
 <20230120135632.vb7ncvoapnaixluu@orel>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="8B9vR+0VfvRQQXio"
Content-Disposition: inline
In-Reply-To: <20230120135632.vb7ncvoapnaixluu@orel>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--8B9vR+0VfvRQQXio
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 20, 2023 at 02:56:32PM +0100, Andrew Jones wrote:
> Hi Conor,
>=20
> I'm digging this back up because I'm basing Zicboz on it.
>=20
> If we take "riscv: improve boot time isa extensions handling", then this
> becomes a bunch of manually enumerated defines
>=20
>  #define RISCV_ISA_EXT_SSCOFPMF         26
>  #define RISCV_ISA_EXT_SVPBMT           27
>  #define RISCV_ISA_EXT_ZICBOM           28
>  #define RISCV_ISA_EXT_ZIHINTPAUSE      29
>  #define RISCV_ISA_EXT_SSTC             30
>  #define RISCV_ISA_EXT_SVINVAL          31
>=20
> Keeping those in alphabetical order would either require manually
> reenumerating them or to allow the numbers to be out of order as
> we add more extensions. I think I'd prefer we just add new
> extensions at the bottom and keep the numbers in order.

Yes. I mentioned that on one of the earlier versions of Jisheng's
patchset - initially I blindly said "alphabetical please".
I quickly realised that that was a really stupid idea as it is would
just be an _invitiation_ for bugs if we did, since names are far more
easily searchable than figuring out the max in the manual enumeration.

Since Jisheng's patchset just deleted what I had resorted, I left this
change as-was. Just need to make sure any comment about ordering also
gets removed when the enum goes away.
I'll keep an eye on for-next to make sure that it does.

TL;DR I agree!

Thanks,
Conor.


--8B9vR+0VfvRQQXio
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY8qiUAAKCRB4tDGHoIJi
0oSKAP9zqiy1G7Sw0cg7bsoy8fmPLJPzS1bNJZ4BX4E8lRk5wAD9Enm99HDzo50d
wtYphmEGxPoxpyWwxNwDASSWnlStzQk=
=C1Iw
-----END PGP SIGNATURE-----

--8B9vR+0VfvRQQXio--
