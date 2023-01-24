Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A922679947
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 14:31:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234200AbjAXNbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 08:31:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232855AbjAXNbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 08:31:39 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94891420D
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 05:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1674567097; x=1706103097;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=K2lHqDxHA1j9+i0Zq00dJ1rYZq4W/0cdhAmEOjB/Gzk=;
  b=R92zLriidgUsNwd0jw3Bgb35F1VDwOXYqnIeDO6ioDsXHj4Y0lNQDfOM
   C888QuM0Bqmxe0B3ouXs+OJLGmq6uqh/RyAEEv4pjhXblICSas4pdouug
   nBOBsTm6f7Xw0M4DmghbpS+842ovPjc6Jm3jncTqUgge2FriefUc6UQe/
   ZpBzsMorXgXR23QMegAwsG/WSSRlguAQx9THZLQzGjnrQe9LZkhWZ+65U
   l1Icyd24qmQQVEMTINAIBa+i+OY280l2FsT201Zet4y52ocIVfNr5y1J7
   zTOjfFt1G0zeyCaX6BTLdwgOLwZB/3CnOKJxULlppqNQwpRMfru8x65jb
   A==;
X-IronPort-AV: E=Sophos;i="5.97,242,1669100400"; 
   d="asc'?scan'208";a="193624415"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Jan 2023 06:31:36 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 24 Jan 2023 06:31:31 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Tue, 24 Jan 2023 06:31:29 -0700
Date:   Tue, 24 Jan 2023 13:31:06 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Pierre Gondois <pierre.gondois@arm.com>
CC:     <linux-kernel@vger.kernel.org>, Dan Carpenter <error27@gmail.com>,
        kernel test robot <lkp@intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Gavin Shan <gshan@redhat.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH -next] cacheinfo: Correctly handle new
 acpi_get_cache_info() prototype
Message-ID: <Y8/dmlR7p5rIbRLF@wendy>
References: <20230124123450.321852-1-pierre.gondois@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nk57ke8/f2usmaAy"
Content-Disposition: inline
In-Reply-To: <20230124123450.321852-1-pierre.gondois@arm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nk57ke8/f2usmaAy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey!

On Tue, Jan 24, 2023 at 01:34:46PM +0100, Pierre Gondois wrote:
> commit bd500361a937 ("ACPI: PPTT: Update acpi_find_last_cache_level()
> to acpi_get_cache_info()")
> updates the function acpi_get_cache_info().
>=20
> If CONFIG_ACPI_PPTT is not defined, acpi_get_cache_info() doesn't
> update its *levels and *split_levels parameters and returns 0.
> This can lead to a faulty behaviour.
>=20
> Make acpi_get_cache_info() return an error code if CONFIG_ACPI_PPTT
> is not defined. Initialize levels and split_levels before passing
> their address to acpi_get_cache_info().
>=20
> Also, in init_cache_level():

Hmm...

> - commit e75d18cecbb3 ("arm64: cacheinfo: Fix incorrect
>   assignment of signed error value to unsigned fw_level")
>   checks the fw_level value in init_cache_level() in case
>   the value is negative. Remove this check as the error code
>   is not returned through fw_level anymore.
> - if no PPTT is present or CONFIG_ACPI_PPTT is not defined,
>   it is still possible to use the cache information from clidr_el1.
>   Instead of aborting if acpi_get_cache_info() returns an error
>   code, just continue.

To be honest, these feel like entirely separate things that should be
in different patches. You've got:
- Dan's smatch fixes
- a redundant check being removed
- a behaviour change for if acpi_get_cache_info() returns an error

> Reported-by: Dan Carpenter <error27@gmail.com>
> Reported-by: kernel test robot <lkp@intel.com>

How about Link: to the LKP/Dan's report?
Link: https://lore.kernel.org/all/Y86iruJPuwNN7rZw@kili/

I did a quick check but didn't don't see the LKP report...

Also a Fixes: tag too, no?

Thanks,
Conor.

--nk57ke8/f2usmaAy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY8/djQAKCRB4tDGHoIJi
0ullAQCykmFyIh/vjpHYTKvq97fTTrk+p6uQxzD/5NrxVPUh6gEAvlyvCAfISQHE
QRsAEdOLOyv31XHz9mXhbr+UM7vmcgo=
=fhiN
-----END PGP SIGNATURE-----

--nk57ke8/f2usmaAy--
