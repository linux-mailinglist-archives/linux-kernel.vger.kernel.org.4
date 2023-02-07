Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB84E68CB31
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 01:32:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjBGAc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 19:32:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbjBGAc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 19:32:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1CB7DB4;
        Mon,  6 Feb 2023 16:32:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 56C79B816A4;
        Tue,  7 Feb 2023 00:32:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 991E0C433D2;
        Tue,  7 Feb 2023 00:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675729943;
        bh=iZCN6sGc9yW2zYcxaQotSvnk+ZA53AaN/sDVv0yII50=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r7OTSPs0ofYJfz2HfC9yS/lpbY7S0BFzpXiLK3x7Ke/Y6aWFhktLvs6Bvgj2Al5Wk
         B6UkcQ+D4VR40u7HKhXzSQ4KgoVE+1waBFZlM5JqHCpnVJMmvdP6KTKtVHMcYXlvDW
         HvMYz5Nv/QvWcqkqgdC8HtG5iSFLz+5CT0wM3dg+r8XfX8Uoay6JHXFHAsy/jvcyaE
         Y+YyyHfN2C/hXNPxeqGA7nAR2Ackxd1K6CCBh1BVMg4QrPnhB6To8MjHdG4AQb2uIw
         smNsNDMgzHTMzUtoipazT928V76wO/Qhc/hW1DhF+HtdqhyqNOakQKfsfeblr/+0mf
         LLy3JzbNDtsBw==
Date:   Tue, 7 Feb 2023 00:32:12 +0000
From:   Mark Brown <broonie@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Nadav Amit <namit@vmware.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
        x86@kernel.org, linux-alpha@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, openrisc@lists.librecores.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org,
        Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH mm-unstable v1 04/26] arm/mm: support
 __HAVE_ARCH_PTE_SWP_EXCLUSIVE
Message-ID: <Y+GcDFMNHw2cdDN1@sirena.org.uk>
References: <20230113171026.582290-1-david@redhat.com>
 <20230113171026.582290-5-david@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NWKvUnutYufNxY+M"
Content-Disposition: inline
In-Reply-To: <20230113171026.582290-5-david@redhat.com>
X-Cookie: No guts, no glory.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NWKvUnutYufNxY+M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 13, 2023 at 06:10:04PM +0100, David Hildenbrand wrote:
> Let's support __HAVE_ARCH_PTE_SWP_EXCLUSIVE by stealing one bit from the
> offset. This reduces the maximum swap space per file to 64 GiB (was 128
> GiB).
>=20
> While at it drop the PTE_TYPE_FAULT from __swp_entry_to_pte() which is
> defined to be 0 and is rather confusing because we should be dealing
> with "Linux PTEs" not "hardware PTEs". Also, properly mask the type in
> __swp_entry().

Today's -next (and at least back to Friday, older logs are unclear - I
only noticed -next issues today) fails to NFS boot on an AT91SAM9G20-EK
(an old ARMv5 platform) with multi_v5_defconfig, a bisect appears to
point to this patch (20aae9eff5acd8f5 in today's -next) as the culprit.

The failure happens at some point after starting userspace, the kernel
starts spamming the console with messages in the form:

    get_swap_device: Bad swap file entry 10120d20

repeating the same entry number, though different numbers per boot.  The
system is booting a Debian userspace and shouldn't have swap configured
(I verfified that successful boots don't), though it only has 64M of RAM
so there will be some memory pressure, especially during boot.  The
exact point things fall over seems to vary a little.

A sample failing job with the full log is here:

    https://lava.sirena.org.uk/scheduler/job/262719

Full bisect log:

git bisect start
# bad: [129af770823407ee115a56c69a04b440fd2fbe61] Add linux-next specific f=
iles for 20230206
git bisect bad 129af770823407ee115a56c69a04b440fd2fbe61
# good: [4ec5183ec48656cec489c49f989c508b68b518e3] Linux 6.2-rc7
git bisect good 53b3c6467004c627f42d96ef839b223a749bcdd9
# good: [17b9d0b05d4fa79afb7bd00edb1b97397418a57a] Merge branch 'master' of=
 git://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git
git bisect good 17b9d0b05d4fa79afb7bd00edb1b97397418a57a
# good: [7044a4e1fab22f437d275b1cf85f5c925741276b] Merge branch 'for-next' =
of git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
git bisect good 7044a4e1fab22f437d275b1cf85f5c925741276b
# good: [bef6844b00f0c24543d60b79c558f353a43709f1] Merge branch 'staging-ne=
xt' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git
git bisect good bef6844b00f0c24543d60b79c558f353a43709f1
# good: [f6737c53676f9db99daee069407daf203e75bc0f] Merge branch 'for-next' =
of git://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock.git
git bisect good f6737c53676f9db99daee069407daf203e75bc0f
# bad: [05cda97ecb7046f4192a921741aae33b300dd628] mm: factor out a swap_wri=
tepage_bdev helper
git bisect bad 05cda97ecb7046f4192a921741aae33b300dd628
# good: [ee0800c2f6a9e605947ce499d79fb7e2be16d6dd] mm: convert page_add_ano=
n_rmap() to use a folio internally
git bisect good ee0800c2f6a9e605947ce499d79fb7e2be16d6dd
# bad: [590a2b5f0a9b740e415e0d52bd8a0f87fc15b87b] ceph: convert ceph_writep=
ages_start() to use filemap_get_folios_tag()
git bisect bad 590a2b5f0a9b740e415e0d52bd8a0f87fc15b87b
# good: [92644f583d5124b60bc20a3dd21b0bc9142f020c] mm/khugepaged: introduce=
 release_pte_folio() to replace release_pte_page()
git bisect good 92644f583d5124b60bc20a3dd21b0bc9142f020c
# bad: [cca10df1029373cda5904887544ca6fcbbd2bac7] sh/mm: support __HAVE_ARC=
H_PTE_SWP_EXCLUSIVE
git bisect bad cca10df1029373cda5904887544ca6fcbbd2bac7
# bad: [ad464ff2c0f91fcacc24167fc435aa45fe0b7d1b] m68k/mm: remove dummy __s=
wp definitions for nommu
git bisect bad ad464ff2c0f91fcacc24167fc435aa45fe0b7d1b
# bad: [20aae9eff5acd8f50f72adca1176f9269a46b827] arm/mm: support __HAVE_AR=
CH_PTE_SWP_EXCLUSIVE
git bisect bad 20aae9eff5acd8f50f72adca1176f9269a46b827
# good: [2321ba3e3733f513e46e29b9c70512ecddbf1085] mm/debug_vm_pgtable: mor=
e pte_swp_exclusive() sanity checks
git bisect good 2321ba3e3733f513e46e29b9c70512ecddbf1085
# good: [4a446b3dd335d0bd14a5ca3e563688de3637be0c] arc/mm: support __HAVE_A=
RCH_PTE_SWP_EXCLUSIVE
git bisect good 4a446b3dd335d0bd14a5ca3e563688de3637be0c
# first bad commit: [20aae9eff5acd8f50f72adca1176f9269a46b827] arm/mm: supp=
ort __HAVE_ARCH_PTE_SWP_EXCLUSIVE

--NWKvUnutYufNxY+M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmPhnAwACgkQJNaLcl1U
h9D7vgf/U3zBEYllgLPQkDLvGQVNlA4YlBJWjoZUOxdqvOZpwxsxFZ/aia+43O0B
TMZThl9G4WF69YEjqEYV7m4FyfodFzxRw67Z/BCVTINhlSPp8SakUVz0PyMB6IzP
CpyMhm1L4Qk4wu+FOVPxQ2pEdWlYa2RWWD3TUQUIw/kTwiBILlQAQocSsrKSHSya
QoivSxIlvDbX1b3D2XPYaTnnQfHnGrcTXKHxR+r01jHeLvwrQ/Q8wEVSsB/lgItx
bcLc4KvDG0yCWfPa30KHM30ccbZvLmWVw7D7WqT0ASjc2Rkvgi1G7q3QpOOZPWC+
QjoJLvNMLQb/bbvVbDMElcjLaSuyQw==
=EHrm
-----END PGP SIGNATURE-----

--NWKvUnutYufNxY+M--
