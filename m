Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E56106E0B01
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 12:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbjDMKGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 06:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbjDMKGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 06:06:30 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54AC3903D
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 03:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1681380389; x=1712916389;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MahB42LmzX7QN0BqdafUMTqdpJKiPq953vM8bvDKx2Y=;
  b=y5/MMoVyR5umzf8oZA+CblQa+/hDwjhMZszx2MFaaq88LZquKPrTnsOZ
   KJmJv0gsvcYzFwkcKIEI8tyAowebMrfzZDA76zfEkbn8tdAhvavg3UI/W
   OtdQ+VGj6ZuytwhxXDw+hCBLeOlvuKK9nLSO21e8efjEX2mj9H0kb5vhR
   A+jPpjJcXblCKUudHqfKeMU2zmsF4D1RCfzZkNlX/4yvQTx6/0O+Y6Gcn
   eiLPy4btLj8JOY9ZWFKc8ltMs2LfmpHdfgjFTbzfhCFhzy7IORpkSSqoJ
   MxIhF0ggbJXl7chct6LQqiRxWAyBETPsMfvsj5kJRzVAgmk24bABdEUB0
   A==;
X-IronPort-AV: E=Sophos;i="5.98,341,1673938800"; 
   d="asc'?scan'208";a="146868096"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Apr 2023 03:06:28 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 13 Apr 2023 03:06:25 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 13 Apr 2023 03:06:24 -0700
Date:   Thu, 13 Apr 2023 11:06:08 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Pierre Gondois <pierre.gondois@arm.com>
CC:     <linux-kernel@vger.kernel.org>, Radu Rendec <rrendec@redhat.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Will Deacon <will@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v3 2/4] cacheinfo: Check cache properties are present in
 DT
Message-ID: <20230413-dimness-shove-5ecd9d69bfff@wendy>
References: <20230413091436.230134-1-pierre.gondois@arm.com>
 <20230413091436.230134-3-pierre.gondois@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dQquVz6905+48oFs"
Content-Disposition: inline
In-Reply-To: <20230413091436.230134-3-pierre.gondois@arm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--dQquVz6905+48oFs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 13, 2023 at 11:14:32AM +0200, Pierre Gondois wrote:
> If a Device Tree (DT) is used, the presence of cache properties is
> assumed. Not finding any is not considered. For arm64 platforms,
> cache information can be fetched from the clidr_el1 register.
> Checking whether cache information is available in the DT
> allows to switch to using clidr_el1.
>=20
> init_of_cache_level()
> \-of_count_cache_leaves()
> will assume there a 2 cache leaves (L1 data/instruction caches), which
> can be different from clidr_el1 information.
>=20
> cache_setup_of_node() tries to read cache properties in the DT.
> If there are none, this is considered a success. Knowing no
> information was available would allow to switch to using clidr_el1.
>=20
> Fixes: de0df442ee49 ("cacheinfo: Check 'cache-unified' property to count =
cache leaves")
> Reported-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> Link: https://lore.kernel.org/all/20230404-hatred-swimmer-6fecdf33b57a@sp=
ud/
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>


Since there's no longer an error printed
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks for the update Pierre,
Conor.

--dQquVz6905+48oFs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZDfUEAAKCRB4tDGHoIJi
0gghAQCTRxTbb6SwSqB9GdjRpJ6WWL9YQP9e2xv61t0mE/HVDQD+KBkTQ7rvk/HN
4pYNhhCVpNQcDagMZ0UZdRfbNKTj2g8=
=mM+f
-----END PGP SIGNATURE-----

--dQquVz6905+48oFs--
