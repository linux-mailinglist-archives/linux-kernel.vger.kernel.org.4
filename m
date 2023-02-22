Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9A9F69F246
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 10:55:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbjBVJzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 04:55:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232327AbjBVJyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 04:54:45 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F0F42DE53
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 01:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1677059585; x=1708595585;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2RqkXhBHRqKKh7yKN8gC72GWgC3HgxWAprIYnydv3Fc=;
  b=k12CXiv5PZXLzST1G/IRv/MCc+8pdsZQI0wKIZLDgmdTCwHTr3WR7sgc
   f3mbyRV/nkZcJ2F4Zv+w5apf4Tc8/ueq7hvvQCpX6XJXHWrl9StfH+Skf
   py3X2p8sSRJ4zxdGTE1QwCJBg/OYzmXRlKWsH3oWAQqMEvSsaWKV0cvNK
   mQUaAAwCx8pjj4OnQAp8KF7jYYs11NzYxelrz/27U+5pH7+2pFmZ0YQbn
   E2B6v3546cyNWaAeF1CTCHD8N6Sk9lCbzWPhaNtHgwce+Dk+FamJodMhH
   0HwT9QrxYuShoUdrp6MWD42tDTod/1aA3RhoYOP9AuLscNjNyfKuXaYff
   A==;
X-IronPort-AV: E=Sophos;i="5.97,318,1669100400"; 
   d="asc'?scan'208";a="201788162"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Feb 2023 02:52:58 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 22 Feb 2023 02:52:55 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Wed, 22 Feb 2023 02:52:53 -0700
Date:   Wed, 22 Feb 2023 09:52:27 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Song Shuai <suagrfillet@gmail.com>
CC:     <jan.kiszka@siemens.com>, <kbingham@kernel.org>,
        <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <akpm@linux-foundation.org>
Subject: Re: [PATCH RESEND] scripts/gdb: add lx_current support for riscv
Message-ID: <Y/Xl2/pfGYq5e89y@wendy>
References: <20230222093730.1826523-1-suagrfillet@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="aifrjwnhPlKH9ODp"
Content-Disposition: inline
In-Reply-To: <20230222093730.1826523-1-suagrfillet@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--aifrjwnhPlKH9ODp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Song

On Wed, Feb 22, 2023 at 05:37:30PM +0800, Song Shuai wrote:
> RISC-V uses the tp register to save the current task_struct address
> as its current() defines. So lx_current() of riscv just returns the
> dereference of the address cast via task_ptr_type.

FYI, there's already been some patches posted for this:
https://lore.kernel.org/all/mhng-bdcd75a5-e6d6-4090-8292-a32eb46e4464@palme=
r-ri-x1c9a/

That version already has review and ack tags from Palmer and others.
It seems to me that Andrew is the usual applier of patches for this
script, so I'm gonna add him to CC here so he is aware - but as it is
the middle of the merge window the best course of action might just be
reposting that patch, CCing Andrew, after v6.3-rc1.

Cheers,
Conor.

>=20
> Signed-off-by: Song Shuai <suagrfillet@gmail.com>
> ---
>  scripts/gdb/linux/cpus.py | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/scripts/gdb/linux/cpus.py b/scripts/gdb/linux/cpus.py
> index 15fc4626d236..6825a9834394 100644
> --- a/scripts/gdb/linux/cpus.py
> +++ b/scripts/gdb/linux/cpus.py
> @@ -173,6 +173,9 @@ def get_current_task(cpu):
>           else:
>               raise gdb.GdbError("Sorry, obtaining the current task is no=
t allowed "
>                                  "while running in userspace(EL0)")
> +    elif utils.is_target_arch("riscv"):
> +         current_task_addr =3D gdb.parse_and_eval("$tp")
> +         return current_task_addr.cast(task_ptr_type).dereference()
>      else:
>          raise gdb.GdbError("Sorry, obtaining the current task is not yet=
 "
>                             "supported with this arch")
> --=20
> 2.20.1
>=20
>=20

--aifrjwnhPlKH9ODp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY/XlzQAKCRB4tDGHoIJi
0tRLAQDG1U1qHvLWSIibUh10+p//HtrVXBHL8Wyta+Zbs0vsfgD/XVcfoiveLvdP
UT1+3Dmz6nKcFKElg0//KE/+lJOAtgw=
=5ZMg
-----END PGP SIGNATURE-----

--aifrjwnhPlKH9ODp--
