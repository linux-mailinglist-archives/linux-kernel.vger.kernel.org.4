Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB0A4714820
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 12:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231942AbjE2Km7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 06:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231847AbjE2Km4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 06:42:56 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE0BC2
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 03:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1685356974; x=1716892974;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ug5Jg3/4sbwIlh2QltBO6iJS1rNkCP1duwwxuNqPy5M=;
  b=RBq0h8bjIG4s95EFmo5JwlIzn1zf5gxvjMVcUrd7IKvSVj+D3PIC2W1G
   Tgh8c0uWTa5/ufFZCENsrZzwLxv3O20QBeX7N5JhDf07CiDxDt/rqS1vX
   79MywUv4DlEiygNmMo7EIg0hNCLITcK5e4ndQttg+pbHpDIEoddAxxRE9
   NgK5cUcOidC2xv7mzD20lLIYyHdL7W0OSocMZ4Gx1q8J6/QtcPKzyeUzq
   MmQTL5N68smvXnu7qaIRF3fRy9ssUfimSCZR2K5IKZOnhUfwPoq1N4YvU
   syQY9gQYnFl2EwHdb7l+3pQf89cSOCE7yM3w9eSX5mWnnHy5smEth197H
   w==;
X-IronPort-AV: E=Sophos;i="6.00,201,1681196400"; 
   d="asc'?scan'208";a="215294251"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 May 2023 03:42:53 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 29 May 2023 03:42:53 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 29 May 2023 03:42:52 -0700
Date:   Mon, 29 May 2023 11:42:29 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Jisheng Zhang <jszhang@kernel.org>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 1/6] riscv: errata: thead: only set cbom size &
 noncoherent during boot
Message-ID: <20230529-dispersal-jubilance-db31c377914d@wendy>
References: <20230526165958.908-1-jszhang@kernel.org>
 <20230526165958.908-2-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="UhbdhvEUKHbFIVls"
Content-Disposition: inline
In-Reply-To: <20230526165958.908-2-jszhang@kernel.org>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--UhbdhvEUKHbFIVls
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 27, 2023 at 12:59:53AM +0800, Jisheng Zhang wrote:
> The CBOM size and whether the HW is noncoherent is known and
> determined during booting and won't change after that.
>=20
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>

Makes sense to me,
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--UhbdhvEUKHbFIVls
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZHSBlQAKCRB4tDGHoIJi
0sJKAQCghJ4X0vtB8qoMZ/+dRGa89ITMtCcdetB02d46ok7ZdgEA5T1asK3Ii/b6
i8zQoIUwFFQAYfCaO58yV4Sd3M6aGwU=
=FsUP
-----END PGP SIGNATURE-----

--UhbdhvEUKHbFIVls--
