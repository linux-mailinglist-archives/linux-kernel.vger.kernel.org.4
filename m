Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17CF66CD434
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 10:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbjC2IPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 04:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbjC2IPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 04:15:09 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B31F49CA;
        Wed, 29 Mar 2023 01:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1680077702; x=1711613702;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QbNn2qOdg3KN2SXSyc2jEkL22WW9OfBopNhlEH8Wr1k=;
  b=m+5cFkWLoIgxpE8+ewVGgpYXkIAGtVmvTybqGQCs4R72yFZ1hHMEiQFd
   k6WRLEtm/99juU6HZ0N/WbVDycCNw2An6V+KhbbmMbI8fGNKPlnEUEfUK
   EMYqDvOjXoUIUe2ktMsLaLdB2BWWmrsghoiUD+u3cICIkVi23t9/L76e0
   GJaNRs5xYPKqfHm1sQMdx0JeR7zWQTaF76yxnnVXTclMO49L8GfBjx3OQ
   by8S3byLtMRoRz+cUtuLqS4TO+4WrkjItWA4XsY+8RcDst8gW1cZWw3ji
   tPluX2QDKpiwzB+ttAEWFqfqslP5QLJZPI67wuGKnTYB3ZABpOTnVIPiz
   A==;
X-IronPort-AV: E=Sophos;i="5.98,300,1673938800"; 
   d="asc'?scan'208";a="144444774"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Mar 2023 01:15:00 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 29 Mar 2023 01:14:59 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Wed, 29 Mar 2023 01:14:57 -0700
Date:   Wed, 29 Mar 2023 09:14:44 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Alexandre Ghiti <alex@ghiti.fr>
CC:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, <linux-doc@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -fixes 2/2] riscv: Do not set initial_boot_params to the
 linear address of the dtb
Message-ID: <234aaac9-d5d0-427f-8666-7f257d385358@spud>
References: <20230323163347.182895-1-alexghiti@rivosinc.com>
 <20230323163347.182895-3-alexghiti@rivosinc.com>
 <831ec4a4-694b-4ace-9500-9b2189a7f16d@spud>
 <08c3a597-0950-9756-9665-c017942de81f@ghiti.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="R/pXHIszXQL98hTd"
Content-Disposition: inline
In-Reply-To: <08c3a597-0950-9756-9665-c017942de81f@ghiti.fr>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--R/pXHIszXQL98hTd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 29, 2023 at 10:09:13AM +0200, Alexandre Ghiti wrote:
> On 3/27/23 13:16, Conor Dooley wrote:
> > On Thu, Mar 23, 2023 at 05:33:47PM +0100, Alexandre Ghiti wrote:
> > > diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> > > index 542eed85ad2c..a059b73f4ddb 100644
> > > --- a/arch/riscv/kernel/setup.c
> > > +++ b/arch/riscv/kernel/setup.c
> > > @@ -278,10 +278,7 @@ void __init setup_arch(char **cmdline_p)
> > >   #if IS_ENABLED(CONFIG_BUILTIN_DTB)
> > >   	unflatten_and_copy_device_tree();
> > >   #else
> > > -	if (early_init_dt_verify(__va(XIP_FIXUP(dtb_early_pa))))
>=20
> > btw, how come it is safe now to drop this? This feels like a separate
> > change that should be its own commit, no?
>=20
>=20
> It is safe because early_init_dt_verify is already called in parse_dtb and

Yah, that's what I figured. Cool.

> since the dtb address does not change anymore, no need to reset
> initial_boot_params. So I'll split this one, thanks.

Worth noting the point at which this became redundant in your commit
message when you do.

Thanks,
Conor.


--R/pXHIszXQL98hTd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZCPzdAAKCRB4tDGHoIJi
0rSKAP9Ntw+oq3rTUBam25Gv5Uu4LY+aMFWlek/LTpoJTOruNwEA/55TL5zj0G8R
KShM5nzDlD9LAQb+NVa8Vu2dNaukUA4=
=2iF6
-----END PGP SIGNATURE-----

--R/pXHIszXQL98hTd--
