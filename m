Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2489974D93A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 16:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232382AbjGJOnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 10:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231786AbjGJOmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 10:42:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2BC1C3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 07:42:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8554D6103E
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 14:42:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89EA2C433C7;
        Mon, 10 Jul 2023 14:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689000161;
        bh=Wu+duyOH7hgJOuFokRvIdbi+c935axibdDhN7x79hL8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WyO5YjjyoFiKVOWDebCbwAk1wJw1SqM+YKCVmI4cUNbYxYZ6AN18AhiIUEiRVsLL3
         5IqymXfvWU/K2isVwk04dCZX2e85p6z+QJyTZgbT22l0rrtKlC304r869z8EMpubQt
         6yWCQRZmAxQa52mKkI7gzbndc9Ks1SoXLgCn5QgB6vBrzSPPuY7rm5xJWBV0QbWn3p
         tVHp6xcTk48loiqTRd9v1blPRQ5HCUSUMK3E9S/NVam/wW16g0Sebjl1ssThU+/QV2
         hbQDF3qXhmAnWo/lNIqpEjRcD/a28MT/ufvhmdg+g+myUfDN5UWE/RFrSY2fIzZpa8
         GRowH0sVmkQQw==
Date:   Mon, 10 Jul 2023 15:42:31 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Yang Shi <shy828301@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Steven Price <steven.price@arm.com>,
        SeongJae Park <sj@kernel.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Huang Ying <ying.huang@intel.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Zack Rusin <zackr@vmware.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Song Liu <song@kernel.org>,
        Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        regressions@leemhuis.info, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 12/32] mm/vmalloc: vmalloc_to_page() use
 pte_offset_kernel()
Message-ID: <42279f1f-7b82-40dc-8546-86171018729c@sirena.org.uk>
References: <c1c9a74a-bc5b-15ea-e5d2-8ec34bc921d@google.com>
 <696386a-84f8-b33c-82e5-f865ed6eb39@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6EsuOK1fDi4bcNLc"
Content-Disposition: inline
In-Reply-To: <696386a-84f8-b33c-82e5-f865ed6eb39@google.com>
X-Cookie: You have taken yourself too seriously.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6EsuOK1fDi4bcNLc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 08, 2023 at 06:21:41PM -0700, Hugh Dickins wrote:
> vmalloc_to_page() was using pte_offset_map() (followed by pte_unmap()),
> but it's intended for userspace page tables: prefer pte_offset_kernel().
>=20
> Signed-off-by: Hugh Dickins <hughd@google.com>
> Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>

Currently Linus' tree is reliably failing to boot on pine64plus, an
arm64 SBC.  Most other boards seem fine, though I am seeing some
additional instability on Tritium which is another Allwinner platform,
I've not dug into that yet and Tritium is generally less stable.

We end up seeing NULL or otherwise bad pointer dereferences, the
specific error does vary a bit though it mostly appears to be in the
pinctrl code.  A bisect (full log below) identified this patch as
introducing the failure, nothing is jumping out at me about the patch
and it's not affecting everything so I'd not be surprised if it's just
unconvering some bug in the platform support but I'm not super familiar
with the code.

Sample backtrace:

[    1.919725] Unable to handle kernel NULL pointer dereference at virtual =
address 0000000000000000
[    1.928551] Mem abort info:
[    1.931359]   ESR =3D 0x0000000096000044

=2E..

[    1.968870] [0000000000000000] user address but active_mm is swapper

=2E..

[    2.093969] Call trace:
[    2.096414]  dt_remember_or_free_map+0xc8/0x120
[    2.100949]  pinctrl_dt_to_map+0x23c/0x364
[    2.105050]  create_pinctrl+0x68/0x3ec
[    2.108803]  pinctrl_get+0xb0/0x124
[    2.112294]  devm_pinctrl_get+0x48/0x90
[    2.116133]  pinctrl_bind_pins+0x58/0x158
[    2.120148]  really_probe+0x54/0x2b0
[    2.123724]  __driver_probe_device+0x78/0x12c

Another common theme is the same but with an address like 0x4c and:

[    2.098328]  __kmem_cache_alloc_node+0x1bc/0x2dc
[    2.102947]  kmalloc_trace+0x20/0x2c
[    2.106524]  pinctrl_register_mappings+0x98/0x178

Full boot log from a failure:

    https://lava.sirena.org.uk/scheduler/job/712456

git bisect start
# bad: [06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5] Linux 6.5-rc1
git bisect bad 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
# good: [6995e2de6891c724bfeb2db33d7b87775f913ad1] Linux 6.4
git bisect good 6995e2de6891c724bfeb2db33d7b87775f913ad1
# bad: [1b722407a13b7f8658d2e26917791f32805980a2] Merge tag 'drm-next-2023-=
06-29' of git://anongit.freedesktop.org/drm/drm
git bisect bad 1b722407a13b7f8658d2e26917791f32805980a2
# bad: [3a8a670eeeaa40d87bd38a587438952741980c18] Merge tag 'net-next-6.5' =
of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next
git bisect bad 3a8a670eeeaa40d87bd38a587438952741980c18
# bad: [6e17c6de3ddf3073741d9c91a796ee696914d8a0] Merge tag 'mm-stable-2023=
-06-24-19-15' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
git bisect bad 6e17c6de3ddf3073741d9c91a796ee696914d8a0
# good: [2605e80d3438c77190f55b821c6575048c68268e] Merge tag 'arm64-upstrea=
m' of git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux
git bisect good 2605e80d3438c77190f55b821c6575048c68268e
# good: [72dc6db7e3b692f46f3386b8dd5101d3f431adef] Merge tag 'wq-for-6.5-cl=
eanup-ordered' of git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq
git bisect good 72dc6db7e3b692f46f3386b8dd5101d3f431adef
# bad: [179d3e4f3bfa5947821c1b1bc6aa49a4797b7f21] mm/madvise: clean up forc=
e_shm_swapin_readahead()
git bisect bad 179d3e4f3bfa5947821c1b1bc6aa49a4797b7f21
# good: [523716770e63e229dbb6307d663f03d990dfefc5] maple_tree: rework mtree=
_alloc_{range,rrange}()
git bisect good 523716770e63e229dbb6307d663f03d990dfefc5
# good: [b764253c18821da31c49a260f92f5d093cf1637e] selftests/mm: fix "warni=
ng: expression which evaluates to zero..." in mlock2-tests.c
git bisect good b764253c18821da31c49a260f92f5d093cf1637e
# good: [5c7f3bf04a6cf266567fdea1ae4987875e92619f] s390: allow pte_offset_m=
ap_lock() to fail
git bisect good 5c7f3bf04a6cf266567fdea1ae4987875e92619f
# good: [0d940a9b270b9220dcff74d8e9123c9788365751] mm/pgtable: allow pte_of=
fset_map[_lock]() to fail
git bisect good 0d940a9b270b9220dcff74d8e9123c9788365751
# bad: [0d1c81edc61e553ed7a5db18fb8074c8b78e1538] mm/vmalloc: vmalloc_to_pa=
ge() use pte_offset_kernel()
git bisect bad 0d1c81edc61e553ed7a5db18fb8074c8b78e1538
# good: [2798bbe75b9c2752b46d292e5c2a49f49da36418] mm/page_vma_mapped: pte_=
offset_map_nolock() not pte_lockptr()
git bisect good 2798bbe75b9c2752b46d292e5c2a49f49da36418
# good: [be872f83bf571f4f9a0ac25e2c9c36e905a36619] mm/pagewalk: walk_pte_ra=
nge() allow for pte_offset_map()
git bisect good be872f83bf571f4f9a0ac25e2c9c36e905a36619
# good: [e5ad581c7f1c32d309ae4e895eea0cd1a3d9f363] mm/vmwgfx: simplify pmd =
& pud mapping dirty helpers
git bisect good e5ad581c7f1c32d309ae4e895eea0cd1a3d9f363
# first bad commit: [0d1c81edc61e553ed7a5db18fb8074c8b78e1538] mm/vmalloc: =
vmalloc_to_page() use pte_offset_kernel()

--6EsuOK1fDi4bcNLc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSsGNYACgkQJNaLcl1U
h9A3dwf9HcI/brPRam8JmuslRrwSUKfGz416vFe73WUvxrAmgk+wclCndU4Ntgl1
xZsSpEVcJkI9LpnPudX/letTj9LdMxBcIDGw1OIXYjGFysv+4Rnwqnt9aKM06nQG
m4B3XlTNG0L0q6p125iuz4lGJRU2Jum/VRGdtM1hgg+jBa96wxFdP1T+JZgPRRq5
7b66rlzClMJmzPiXx6mNaol0jhu7ex1ltrn0Rfsq47zpgobIrG6Q0pKOlcIT5yT6
1IP+GoOVaR1DkATN7G35PF4vHSl56xd4lCyG0+KZJvWtQOWQNJYIAdgWwu4/GQfJ
/5y10aucaSA7vu2WeTafTU9wYj+YxA==
=cEJt
-----END PGP SIGNATURE-----

--6EsuOK1fDi4bcNLc--
