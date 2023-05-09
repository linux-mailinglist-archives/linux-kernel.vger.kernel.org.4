Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A70E46FCFB5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 22:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235105AbjEIUlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 16:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235087AbjEIUlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 16:41:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EAB2E4A;
        Tue,  9 May 2023 13:41:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D72962E9A;
        Tue,  9 May 2023 20:41:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E0BDC433EF;
        Tue,  9 May 2023 20:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683664907;
        bh=p7gqrjaa3BLpQFidpX4R4K9UjjHkyxfu2VmA/bZDg4o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zh8SgB1qAxHsKtO9C1bFv1mRmgH1gELHqELdIX6SRGYExXHrfFNFaRSrg7yyzCJ5a
         VPrRf99KWWVorUjkQ216ZuZG6iA4EIecaWaxQ5yqTMIsuFAW1b4SHAhM4UsdfkApci
         Hv6EC1kVbWTJonTgGZRCcI5rHN7UVPwJEMPY33SYJzxZtWxCm2Q12rcFISJbke132B
         0orLwyKxNtiesi+TCmA/IhxBbHh0mRexxclGE6pSZeHRyunmtOgLIu9GuaEeVhBIvX
         y5m8nhoGOcrP5EmE91eceGPYABWT9pSYJsuGomiiSX600JJrmRDlLCgwHoqmbIybdI
         CFKD05dUhfVeg==
Date:   Tue, 9 May 2023 21:41:42 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 6.1 000/610] 6.1.28-rc2 review
Message-ID: <20230509-robust-crate-5fe128d00e6d@spud>
References: <20230509030653.039732630@linuxfoundation.org>
 <0837e157-8615-418a-a3d3-1c14af11aba5@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dPlG/RYuOnEulgQG"
Content-Disposition: inline
In-Reply-To: <0837e157-8615-418a-a3d3-1c14af11aba5@roeck-us.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dPlG/RYuOnEulgQG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 09, 2023 at 12:57:58PM -0700, Guenter Roeck wrote:
> On Tue, May 09, 2023 at 05:26:31AM +0200, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 6.1.28 release.
> > There are 610 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >=20
> > Responses should be made by Thu, 11 May 2023 03:05:05 +0000.
> > Anything received after that time might be too late.
> >=20
>=20
> Build results:
> 	total: 155 pass: 155 fail: 0
> Qemu test results:
> 	total: 519 pass: 519 fail: 0
>=20
> New persistent runtime warning when booting riscv32/64 images:

You sure this is new? I seem to be able to reproduce for QEMU (which I
don't usually test) in several versions of 6.1. Don't see it in (my)
hardware though, as the particular platform doesn't end up calling the
offending function. Out of curiosity, what's your QEMU invocation?

Anyways, looks like a partial backport is the cause. How's it look with:

diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 694267d1fe81..fd1238df6149 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -9,6 +9,7 @@
 #include <linux/bitmap.h>
 #include <linux/ctype.h>
 #include <linux/libfdt.h>
+#include <linux/memory.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <asm/alternative.h>
@@ -316,8 +317,11 @@ void __init_or_module riscv_cpufeature_patch_func(stru=
ct alt_entry *begin,
 		}
=20
 		tmp =3D (1U << alt->errata_id);
-		if (cpu_req_feature & tmp)
+		if (cpu_req_feature & tmp) {
+			mutex_lock(&text_mutex);
 			patch_text_nosync(alt->old_ptr, alt->alt_ptr, alt->alt_len);
+			mutex_unlock(&text_mutex);
+		}
 	}
 }
 #endif


--dPlG/RYuOnEulgQG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZFqwBQAKCRB4tDGHoIJi
0kM+AP9mKBjfrOyYoDc67TNucbnE9c6dNPmztCZ0QCsJmIB+oAD9EIjXXj2Lt/JO
9RCBwNWZe7IRi0/mz287+r4DFtmmwgY=
=eiF8
-----END PGP SIGNATURE-----

--dPlG/RYuOnEulgQG--
