Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8776BBB96
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 19:00:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232106AbjCOSAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 14:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232286AbjCOSAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 14:00:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 720B83586
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 11:00:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 041BFB81E9C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 18:00:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F5FEC433EF;
        Wed, 15 Mar 2023 17:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678903199;
        bh=PSttNc6w/mKtHV5D1XaitgEFAhnPrAUkkifCk8iGO4w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AdBV017y2/fk2NDEMtjbyfZ6C8bt2Ik/OyybYbGjLGmUbekGVKzKGzV445ka5mEXt
         Y1Pd/aI5Cw6wKcD3QRu6tEf+zJxN5i8SHAGP9sEb0fXeXBvGlNncX/p68figDA1pjJ
         OaTYXuIoLfFDOcjCkmdvAdQJuv0wOi33cEMrmJDhxuZnOLLdJwFDlSi0HUNZaPf4T2
         53KbZJGyC7pVGzzfCl9GUbw50BkMTOBO+cecBSzmmADirUFrSMHD9hGaoFXj7j9q5j
         qgQanyDMxJ8qe1of8CjO8aDFR6JXW5oXvKXH39Ro/1nvsHleoHTEfSOVY0gVb5Sqb4
         doR8N6+uH30Lg==
Date:   Wed, 15 Mar 2023 17:59:55 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Song Shuai <suagrfillet@gmail.com>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: Kconfig: enable SCHED_MC kconfig
Message-ID: <d8cb0d9e-6b73-4f44-9165-ee66c2835906@spud>
References: <20230310110336.970985-1-suagrfillet@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="OWpXPeGNXXDj5/uS"
Content-Disposition: inline
In-Reply-To: <20230310110336.970985-1-suagrfillet@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OWpXPeGNXXDj5/uS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 10, 2023 at 07:03:36PM +0800, Song Shuai wrote:
> RISC-V now builds the sched domain based on the simple possible map.
>=20
> Enable SCHED_MC to make the building based on cpu_coregroup_mask()
> which also takes care of the NUMA and cores with LLC.
>=20
> Signed-off-by: Song Shuai <suagrfillet@gmail.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
>  arch/riscv/Kconfig | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index c5e42cc37604..5b9fdc1a619a 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -320,6 +320,14 @@ config SMP
> =20
>  	  If you don't know what to do here, say N.
> =20
> +config SCHED_MC
> +	bool "Multi-core scheduler support"
> +	depends on SMP
> +	help
> +	  Multi-core scheduler support improves the CPU scheduler's decision
> +	  making when dealing with multi-core CPU chips at a cost of slightly
> +	  increased overhead in some places. If unsure say N here.
> +
>  config NR_CPUS
>  	int "Maximum number of CPUs (2-512)"
>  	depends on SMP
> --=20
> 2.20.1
>=20

--OWpXPeGNXXDj5/uS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZBIHmwAKCRB4tDGHoIJi
0u3TAP4p7X1bFKHYWqXvJF9w0POBVQsE9vMmHTim/pXkpvfhswD/eudv8JIfFjAE
ObulOfSDaYtba9N8J3sKD68ezsbIIAY=
=Jj/C
-----END PGP SIGNATURE-----

--OWpXPeGNXXDj5/uS--
