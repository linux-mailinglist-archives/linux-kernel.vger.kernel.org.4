Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1083F644F48
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 00:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiLFXFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 18:05:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiLFXFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 18:05:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEFE8B6A;
        Tue,  6 Dec 2022 15:05:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6C4F0B81A68;
        Tue,  6 Dec 2022 23:05:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50D9EC433D7;
        Tue,  6 Dec 2022 23:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670367914;
        bh=og+XXRY2fcLp4gyF1cWGrNQBduIHbwxbJ9D95CNM7Ok=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=umT7knoeOpvPszf6KmB4AiA4y/HSTcRedLIFNwXhTf0A1KEFJzXgh4Zz8XEpILLLl
         w8OeIYneZ+B52rdVoywZiSMDpKBn4knhvD14tNPX6NGrewdF5r6AyQxbM3hWv3rL7C
         6lAqtIKwdtfsGeMOtupyCHk14w4fHcyB4sewVB00bPCiWwQ2oFxzjd+PANn1Rrfy70
         YFVdIatqoVfh+WPvf0vkDIpScqmvBy2odt7AO35IttAOAeZRULI18c59y+r/ZCqxAX
         H3FTqf54Pbxf/VuHXasDtm6Hjif4p4SmWoqtLg/2VZHYimxkyT/JIvWbSTnln+UvO4
         jb/UP6+RRIpmw==
Date:   Tue, 6 Dec 2022 23:05:06 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Palmer Dabbelt <palmer@rivosinc.com>,
        Xianting Tian <xianting.tian@linux.alibaba.com>
Cc:     mick@ics.forth.gr, corbet@lwn.net, alexandre.ghiti@canonical.com,
        vgoyal@redhat.com, bhe@redhat.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        bagasdotme@gmail.com, dyoung@redhat.com,
        Palmer Dabbelt <palmer@dabbelt.com>, heiko@sntech.de,
        Xianting Tian <xianting.tian@linux.alibaba.com>,
        guoren@kernel.org, anup@brainfault.org, aou@eecs.berkeley.edu,
        hschauhan@nulltrace.org, yixun.lan@gmail.com,
        kexec@lists.infradead.org, heinrich.schuchardt@canonical.com,
        linux-doc@vger.kernel.org, crash-utility@redhat.com,
        linux-kernel@vger.kernel.org, k-hagio-ab@nec.com,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH V5 0/2] Support VMCOREINFO export for RISCV64
Message-ID: <Y4/KoiFhdvRBDdzH@spud>
References: <20221026144208.373504-1-xianting.tian@linux.alibaba.com>
 <167002857934.4256.16584443879212253129.b4-ty@rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wfcBHXZ3OW3XTejR"
Content-Disposition: inline
In-Reply-To: <167002857934.4256.16584443879212253129.b4-ty@rivosinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wfcBHXZ3OW3XTejR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Palmer, Xianting,

On Fri, Dec 02, 2022 at 04:49:39PM -0800, Palmer Dabbelt wrote:
> On Wed, 26 Oct 2022 22:42:06 +0800, Xianting Tian wrote:
> > As disscussed in below patch set, the patch of 'describe VMCOREINFO exp=
ort in Documentation'
> > need to update according to Bagas's comments.
> > https://lore.kernel.org/linux-riscv/22AAF52E-8CC8-4D11-99CB-88DE4D11344=
4@kernel.org/
> >=20
> > As others patches in above patch set already applied, so this patch set=
 only contains below two
> > patches.
> >=20
> > [...]
>=20
> Applied, thanks!
>=20
> [1/2] RISC-V: Add arch_crash_save_vmcoreinfo support
>       https://git.kernel.org/palmer/c/649d6b1019a2

So this patch seems to be causing issues for the nommu build:
https://lore.kernel.org/oe-kbuild-all/202212062250.tR0otHcz-lkp@intel.com/

I had a bit of a poke at trying to see if there were some headers we
could pull in before actually checking the .config only to see:
# CONFIG_MMU is not set

Do we have to wrap the whole thing in a `#ifdef CONFIG_MMU` to fix
compilation here?

Thanks,
Conor.


--wfcBHXZ3OW3XTejR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY4/KogAKCRB4tDGHoIJi
0pEgAQDO1wUgu3/ufYbAAAOzCbPjVQcdX8ujzegnAAh5TgId0gD/ZtqmgZf/j7Cp
hVtujGiLlEEzQkgyBIg36ipLFTYYsQ8=
=gIhU
-----END PGP SIGNATURE-----

--wfcBHXZ3OW3XTejR--
