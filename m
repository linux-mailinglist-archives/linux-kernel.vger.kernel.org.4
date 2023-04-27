Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5C46F03F5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 12:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243491AbjD0KLv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 06:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243378AbjD0KLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 06:11:49 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDF0226A8
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 03:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1682590308; x=1714126308;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=llj1k7SyZo897TodgO+NWeNu2kbu92eWibZnQxYXlIo=;
  b=xcsCMiL0JBAv34qkuPSItd6S1iVxht3o8T7NevLUef0PW7D7Am3wO9XS
   tMgiEn1hogyQqcwI38cqsJ2XJAZoPa1n4n6QXB/RCk2Y8sjFSxANYlIPb
   SXbo4NU4wNDuTt1jPPMsftlW1MgkngjqlyiDrlrZsazmIYr3c3u7xdUhi
   EWr7Tv6n/LL8qyQwB6Kmn42zzvJmOg5EjVC16IsPt4Hf38RK4cx29cFxA
   nVVvOepyvdDVwbUolpN0mFz3eGxiTCyvK+LmTuAOUPnhmuxaTQIxMhAFV
   jUTTu+2frH1GMnagUN8is3LIC6sprErnJctKl7YON0nPbpcI/OCmDJeKo
   w==;
X-IronPort-AV: E=Sophos;i="5.99,230,1677567600"; 
   d="asc'?scan'208";a="149214073"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Apr 2023 03:11:46 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 27 Apr 2023 03:11:41 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 27 Apr 2023 03:11:39 -0700
Date:   Thu, 27 Apr 2023 11:11:22 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Song Shuai <suagrfillet@gmail.com>
CC:     <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <alexghiti@rivosinc.com>,
        <heiko@sntech.de>, <guoren@kernel.org>,
        <anshuman.khandual@arm.com>, <mick@ics.forth.gr>,
        <samuel@sholland.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -fixes] riscv: mm: remove redundant parameter of
 create_fdt_early_page_table
Message-ID: <20230427-lecturer-goon-a7c1245fa2bb@wendy>
References: <20230426091511.674496-1-suagrfillet@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="B4nDN1w4sHZ1Joe6"
Content-Disposition: inline
In-Reply-To: <20230426091511.674496-1-suagrfillet@gmail.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--B4nDN1w4sHZ1Joe6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 26, 2023 at 05:15:11PM +0800, Song Shuai wrote:
> create_fdt_early_page_table() explicitly uses early_pg_dir for
> 32-bit ftb mapping and the pgdir parameter is redundant here.
> So remove it and its caller.

"and its caller" sounds like you're removing the caller itself when
that's not what you're doing!
I am certainly not suggesting that you resubmit because of that though.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--B4nDN1w4sHZ1Joe6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZEpKSgAKCRB4tDGHoIJi
0tdyAP9IYmb79WDRFsH48lzLc2Tk5z6eDoSPuuP8mLa3KlnjRQEAjzhtySq7Mq/m
xlkT1FzflYgXZJShfdRO0yJ6DEQL/Qw=
=2zWl
-----END PGP SIGNATURE-----

--B4nDN1w4sHZ1Joe6--
