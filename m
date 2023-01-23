Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D074E677DAC
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 15:11:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231723AbjAWOLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 09:11:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbjAWOLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 09:11:06 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CACE3173C;
        Mon, 23 Jan 2023 06:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1674483066; x=1706019066;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=S0d9Nb/yC6VAaBIa1D02pKGjTNBVJ6RLf6lkHDss3E8=;
  b=DdqzycnLUjlpHHGJ/ZsEII428O7Wo3cDvf0B80fWQGIJU6Y7hYQKZgIE
   0EqC8uecE0b2ML2teWHJB6trKk2cKrYO3GxmM54x6e8kBqbpUQeISmEjS
   4sios8oEwn6gI2VDTVbQaXTt6pt/bMceAfuEOOpWy4KD9nIt4PcBT5LmH
   H/+buTFFmQ/XA24Y1gQIQwkWmjiOdj96XQEeHti0DPIURC7Dp/IMESwoC
   ZOqI1Yk/MbPjJxDxJPDD6XD452tzk6n1tg9rsBDgqtX+dawguA52Om1v/
   k0V5FJVY/J28Z1N7XkHTsjE/yI0f+V1o6pvxuFSghU26dcyGGmTsF+quP
   A==;
X-IronPort-AV: E=Sophos;i="5.97,239,1669100400"; 
   d="asc'?scan'208";a="197739625"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Jan 2023 07:11:05 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 23 Jan 2023 07:11:04 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Mon, 23 Jan 2023 07:11:03 -0700
Date:   Mon, 23 Jan 2023 14:10:39 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
CC:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor@kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>
Subject: Re: [PATCH resend v3] riscv: Allow to downgrade paging mode from the
 command line
Message-ID: <Y86VX3zhoSRHsewb@wendy>
References: <20230123105135.814154-1-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yXobd+UY1nEQhU1d"
Content-Disposition: inline
In-Reply-To: <20230123105135.814154-1-alexghiti@rivosinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--yXobd+UY1nEQhU1d
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 23, 2023 at 11:51:35AM +0100, Alexandre Ghiti wrote:
> Add 2 early command line parameters that allow to downgrade satp mode
> (using the same naming as x86):
> - "no5lvl": use a 4-level page table (down from sv57 to sv48)
> - "no4lvl": use a 3-level page table (down from sv57/sv48 to sv39)
>=20
> Note that going through the device tree to get the kernel command line
> works with ACPI too since the efi stub creates a device tree anyway with
> the command line.
>=20
> Also, as those params are treated very early in the boot process and we
> use standard device tree functions that may be kasan instrumented, we
> only enable them for !KASAN configurations.
>=20
> Reviewed-by: Bj=F6rn T=F6pel <bjorn@kernel.org>
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>=20
> v3:
> - Massage commit log to make no4lvl clearer, as asked by Conor
> - Add a note to kernel-parameters.txt regarding the impossibility to use
>   those parameters when KASAN is enabled, as suggested by Conor

For the improved descriptions & commit message:
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Apologies for complaining about the missing changelog earlier!

Conor.


--yXobd+UY1nEQhU1d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY86VXwAKCRB4tDGHoIJi
0jY5AP4u/lkQ5s1usVmQJyS6cnYs6jE7Ft+3KsAeLXCPetcYhQD+MS7SEq+uA2kL
FsNU/AncvpfJtWmuEP1UDkLCS8DFwAM=
=gOqR
-----END PGP SIGNATURE-----

--yXobd+UY1nEQhU1d--
