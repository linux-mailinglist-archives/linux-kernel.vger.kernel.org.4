Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48A3968351E
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 19:23:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbjAaSXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 13:23:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjAaSXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 13:23:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DADB27D7E
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 10:23:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E9E49B81E21
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 18:23:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C99C3C433EF;
        Tue, 31 Jan 2023 18:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675189429;
        bh=VnD9d4+w/3Jfx127g1aQktEJStJ9dQ+jfi150fUwax4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mtc0jMNUrXXop6WwNpS7fLWyH1YMqKs+EpcAX/QMXhb+qtd0A1HrLOAeaeF0etXxm
         2Y4ogTZMtQvbUzLtqVmPYZp9Wwy6uaci6eS2teya/w6zqRr0XuqogzIh7sGZvVJDeB
         alFpPIKIJ3WlttnKpx5Ad8RL4J5o88uodg/FQl3p1vq9fPf7ylbGsM8w9qDGzuVi24
         zGMmvXwdYnxjL5K4KUyC+0QAYQHQ1bwa9u3ivgpZAkbDO8yl3HXWTS9cxhls+9euTb
         wSnGEnY5L2qh8ZnXlooFthxzW/eMJHsy2wpKI4tujjYwcuQJ5wMdfh0hPISpJBOYZp
         RO7NnPeor7wyA==
Date:   Tue, 31 Jan 2023 18:23:45 +0000
From:   Conor Dooley <conor@kernel.org>
To:     guoren@kernel.org
Cc:     tongtiangen@huawei.com, alexandre.ghiti@canonical.com,
        muchun.song@linux.dev, palmer@rivosinc.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH -next V2] riscv: mm: hugetlb: Enable
 ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
Message-ID: <Y9lcsajzIpS5ZkDT@spud>
References: <20230127050421.1920048-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jzDCvYMAFAxxEvI8"
Content-Disposition: inline
In-Reply-To: <20230127050421.1920048-1-guoren@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jzDCvYMAFAxxEvI8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 27, 2023 at 12:04:21AM -0500, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
>=20
> Add HVO support for RISC-V; see commit 6be24bed9da3 ("mm: hugetlb:
> introduce a new config HUGETLB_PAGE_FREE_VMEMMAP"). This patch is
> similar to commit 1e63ac088f20 ("arm64: mm: hugetlb: enable
> HUGETLB_PAGE_FREE_VMEMMAP for arm64"), and riscv's motivation is the
> same as arm64. The current riscv was ready to enable HVO after fixup,
> ref commit d33deda095d3 ("riscv/mm: hugepage's PG_dcache_clean flag
> is only set in head page").
>=20
> The HugeTLB VmemmapvOptimization (HVO) defaults to off in Kconfig.
>=20
> Here is the riscv test log:
> cat /proc/sys/vm/hugetlb_optimize_vmemmap
> echo 8 > /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages
> mount -t hugetlbfs none test/ -o pagesize=3D2048k
> <Try some simple hugetlb test in test dir, no problem found.>
>=20
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> Link: https://lore.kernel.org/linux-riscv/1F5AF29D-708A-483B-A29F-CAEE6F5=
54866@linux.dev/
> Acked-by: Muchun Song <songmuchun@bytedance.com>
> ---
> Changelog:
> V2:
>  - Optimize the commit log
>  - Remove riscv page compound_head fixup which has been merged.
>  - Rebase on riscv for-next (20230127)
>  - Add HVO author's acked-by
>=20
> V1:
> https://lore.kernel.org/linux-riscv/20221023133205.3493564-1-guoren@kerne=
l.org/
> ---
>  arch/riscv/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index e2b656043abf..949974a38a41 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -46,6 +46,7 @@ config RISCV
>  	select ARCH_WANT_FRAME_POINTERS
>  	select ARCH_WANT_GENERAL_HUGETLB
>  	select ARCH_WANT_HUGE_PMD_SHARE if 64BIT
> +	select ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP

CI is telling me that this is added out of order. I suppose that means
that T is before _ in the "alphabet", and this should be moved up one
line.
Perhaps it can be fixed on application!

>  	select ARCH_WANTS_THP_SWAP if HAVE_ARCH_TRANSPARENT_HUGEPAGE
>  	select BINFMT_FLAT_NO_DATA_START_OFFSET if !MMU
>  	select BUILDTIME_TABLE_SORT if MMU
> --=20
> 2.36.1
>=20

--jzDCvYMAFAxxEvI8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY9lcsQAKCRB4tDGHoIJi
0unmAQDThJqtWFmjK8UJeucxod5elztkEGFbVBGc/3NVd0lUdwEAgTM9IjxSoOIn
sHAzccTxl07PcjJhG5qwPwcnNc1eTA8=
=hf/N
-----END PGP SIGNATURE-----

--jzDCvYMAFAxxEvI8--
