Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F200663707
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 02:59:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbjAJB7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 20:59:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjAJB72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 20:59:28 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA8AC70;
        Mon,  9 Jan 2023 17:59:26 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NrYs847SJz4xND;
        Tue, 10 Jan 2023 12:59:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1673315964;
        bh=CZB/NBuXurOE5DBX2iCjm1WpTnyOMvTGm4vHIPc5kGM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JEh4Kaw5VAucoY4O5LkxFPnP/X/FQauZtP2Nvw2xofn41J2Y5535dIzw5WhyYo51q
         4KNBezs7DNLV+AQCJ1E+jYtZi6Z1qBR5TkZfjFWUsIf/uDcW8nQ+SRCA1yeF9/sQOh
         X5hxjyd8eMySDh/JNU6NaXGXoaCBVSJN5/v7P+2ctePs3j6bMkg8j/ad/lYLgW9ZQj
         RIJfGcymfW8kjx9BIUxCjAAhv0L2511DE3t20AjWigAfnqzwCTdSVHwcbuEkLd82uA
         vwlf4kNyCdJRiJvv/Uztp6F4plUx7GigqB4YNqk+eDE2MF0D2pIydSdyFCzvZf8IFt
         6gM9/4Z/zvJkQ==
Date:   Tue, 10 Jan 2023 12:59:23 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: please clean up the folio tree
Message-ID: <20230110125923.6c030146@canb.auug.org.au>
In-Reply-To: <20230101153330.7bf359af@canb.auug.org.au>
References: <20221215105539.72da7ceb@canb.auug.org.au>
        <20230101153330.7bf359af@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/GSS/lNmNP.lm.x0DkYZQudm";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/GSS/lNmNP.lm.x0DkYZQudm
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Willy,

On Sun, 1 Jan 2023 15:33:30 +1100 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> On Thu, 15 Dec 2022 10:55:39 +1100 Stephen Rothwell <sfr@canb.auug.org.au=
> wrote:
> >
> > The folio tree seems to contain a number of commits that duplicate
> > commits in Linus' tree. =20
>=20
> I fact, all but the first commit in the folio tree were merged by Linus
> in v6.0-rc1.  And the folio tree has not bee updates since mid June ...
>=20
> $ git cherry -v v6.0-rc1 folio/for-next
> + 964688b32d9ada55a7fce2e650d85ef24188f73f btrfs: Use a folio in wait_dev=
_supers()
> - ba457436991abc8e3cc830cfc91e9f54b53a07ed buffer: Don't test folio error=
 in block_read_full_folio()
> - 2c62b172802a648cb9bad9b1ad2415a8ecbb7f41 squashfs: Return the actual er=
ror from squashfs_read_folio()
> - 4188e3e2860d65a43397d4658f74136bf3297808 hostfs: Handle page write erro=
rs correctly
> - 437084d7c5b825e714d0b50ba6624e6ba840fa32 ocfs2: Use filemap_write_and_w=
ait_range() in ocfs2_cow_sync_writeback()
> - 0ba02b002594cc1809da3a05a44bb5b9654448f6 cramfs: read_mapping_page() is=
 synchronous
> - 1cf29f882fa8e28e18cccc9b0a7e94e391b3291f block: Simplify read_part_sect=
or()
> - a340b79b299109ded6928157dc24cf0fb6a90823 block: Handle partition read e=
rrors more consistently
> - 4639d0da923efd6704974893ba19eb1aaf396538 block: Use PAGE_SECTORS_SHIFT
> - 5b15f72a828b44a06d50ab739e89ac492298bec4 block: Convert read_part_secto=
r() to use a folio
> - fa19fbd23186e43714bf7694ec83b7a519e618c0 befs: Convert befs_symlink_rea=
d_folio() to use a folio
> - 1a6b7e5cb5504bf4f0f4e63b8bedaff8aad5798b coda: Convert coda_symlink_fil=
ler() to use a folio
> - 6e2a48222bc97d4028b1ff8b8bfdfadec7a72923 freevxfs: Convert vxfs_immed_r=
ead_folio() to use a folio
> - 71864cbf4617f06ff2434235049e9c3daa2806a6 ocfs2: Convert ocfs2_read_foli=
o() to use a folio
> - d862e2d593685f8a895202493f1a059932cdb0e0 gfs2: Convert gfs2_jhead_proce=
ss_page() to use a folio
> - 1662afcecae535147b1cb143fde8d99a6a98d8fe ext2: Use a folio in ext2_get_=
page()
> - 1a22e12f94c9f647cdd8e4e56bc313043e9eb5c2 secretmem: Remove isolate_page
> - b361f39863ed2d6ca644a2d53638c3fd87d32d14 mm: Convert all PageMovable us=
ers to movable_operations
> - 662389777689c17a77849af822bac1677be56e37 fs: Add aops->migrate_folio
> - 765acf9085a1188244ec6294e3039637685c209e mm/migrate: Convert fallback_m=
igrate_page() to fallback_migrate_folio()
> - 7d474706ff4fb035f896710fa1274e3050afb461 mm/migrate: Convert writeout()=
 to take a folio
> - e267a3198014ec93389b1930b776047082bb271f mm/migrate: Convert buffer_mig=
rate_page() to buffer_migrate_folio()
> - 55553f3437c8b185b71fe4bd8106141a4e4192de mm/migrate: Convert expected_p=
age_refs() to folio_expected_refs()
> - e8172b8e1728b41160dc8fef7fdd9ffbcaa152c6 btrfs: Convert btree_migratepa=
ge to migrate_folio
> - 27826326e888a185d7d191670cf445dec88e9218 nfs: Convert to migrate_folio
> - af9c33968b722c5871974541067dc180377501df mm/migrate: Convert migrate_pa=
ge() to migrate_folio()
> - 441b3afcb2e31aca89f6e2cd6642f141c7bbe142 mm/migrate: Add filemap_migrat=
e_folio()
> - 9c5161d1eefb24389a077b43e8e11322f2e4cd42 btrfs: Convert btrfs_migratepa=
ge to migrate_folio
> - 9f11d68b27211e6a73b0540dc757c91c01ae74bf ubifs: Convert to filemap_migr=
ate_folio()
> - 9c16c4c68213afc512aadb854c9603f4eff6b977 f2fs: Convert to filemap_migra=
te_folio()
> - 9b553d25025600ecaeb903b9250279b50c1c6054 aio: Convert to migrate_folio
> - 5567427fd70edcd4809a5b1df03f363e72f997bf hugetlb: Convert to migrate_fo=
lio
> - 48e7ede1b860e44edfd0231f888a7f16af86d6a0 secretmem: Convert to migrate_=
folio
> - c33b866a97842ac96f4373f737ba608dd157f08a fs: Remove aops->migratepage()
> - 84578adbb0e0657003e646e0af699ef74b99386e mm/folio-compat: Remove migrat=
ion compatibility functions
> - 9594da4cec1db0491d35b38d5988eb989720d6f4 ntfs3: refactor ntfs_writepages
> - 8862fa5da9f144d0554c2177aea7ce0b6f97d8c0 ext2: remove nobh support
> - 3f05372ce9ddbd643a763f60c0d2a115cb2de008 jfs: stop using the nobh helper
> - 215e71b6ee7ad3363c6e6bd979adbb56e070f6de fs: remove the nobh helpers
> - cf95d50205f62c4f5f538676def847292cf39fa9 fs: don't call ->writepage fro=
m __mpage_writepage
> - 03b33c09ea22fa89dd204ad0a2058e512c691b9f fs: remove the NULL get_block =
case in mpage_writepages
>=20
> And the presence of these commits in the folio tree produces the
> following output when I merge it:
>=20
> Auto-merging Documentation/filesystems/locking.rst
> Auto-merging Documentation/filesystems/vfs.rst
> Auto-merging block/fops.c
> Auto-merging block/partitions/core.c
> Auto-merging drivers/gpu/drm/i915/gem/i915_gem_userptr.c
> Auto-merging drivers/misc/vmw_balloon.c
> Auto-merging drivers/virtio/virtio_balloon.c
> Auto-merging fs/aio.c
> Auto-merging fs/btrfs/disk-io.c
> Auto-merging fs/btrfs/inode.c
> Auto-merging fs/buffer.c
> Auto-merging fs/ext2/dir.c
> Auto-merging fs/ext2/inode.c
> Auto-merging fs/ext2/namei.c
> Auto-merging fs/ext2/super.c
> Auto-merging fs/ext4/inode.c
> Auto-merging fs/f2fs/checkpoint.c
> Auto-merging fs/f2fs/data.c
> Auto-merging fs/f2fs/f2fs.h
> Auto-merging fs/f2fs/node.c
> Auto-merging fs/gfs2/aops.c
> Auto-merging fs/gfs2/lops.c
> Auto-merging fs/hostfs/hostfs_kern.c
> Auto-merging fs/hugetlbfs/inode.c
> CONFLICT (content): Merge conflict in fs/hugetlbfs/inode.c
> Auto-merging fs/iomap/buffered-io.c
> Auto-merging fs/jfs/inode.c
> Auto-merging fs/mpage.c
> Auto-merging fs/nfs/file.c
> Auto-merging fs/nfs/internal.h
> Auto-merging fs/nfs/write.c
> Auto-merging fs/ntfs/aops.c
> Auto-merging fs/ntfs3/inode.c
> Auto-merging fs/ocfs2/aops.c
> Auto-merging fs/ocfs2/refcounttree.c
> Auto-merging fs/squashfs/file.c
> Auto-merging fs/ubifs/file.c
> Auto-merging fs/xfs/xfs_aops.c
> Auto-merging fs/zonefs/super.c
> Auto-merging include/linux/buffer_head.h
> Auto-merging include/linux/fs.h
> Auto-merging include/linux/iomap.h
> Auto-merging include/linux/migrate.h
> CONFLICT (content): Merge conflict in include/linux/migrate.h
> Auto-merging include/linux/page-flags.h
> Auto-merging include/linux/pagemap.h
> Auto-merging mm/compaction.c
> Auto-merging mm/folio-compat.c
> Auto-merging mm/ksm.c
> Auto-merging mm/migrate.c
> CONFLICT (content): Merge conflict in mm/migrate.c
> Auto-merging mm/migrate_device.c
> CONFLICT (content): Merge conflict in mm/migrate_device.c
> Auto-merging mm/secretmem.c
> Auto-merging mm/shmem.c
> Auto-merging mm/swap_state.c
> Auto-merging mm/util.c
> Auto-merging mm/z3fold.c
> Auto-merging mm/zsmalloc.c
> CONFLICT (content): Merge conflict in mm/zsmalloc.c
> Resolved 'fs/hugetlbfs/inode.c' using previous resolution.
> Resolved 'include/linux/migrate.h' using previous resolution.
> Resolved 'mm/migrate.c' using previous resolution.
> Resolved 'mm/migrate_device.c' using previous resolution.
> Resolved 'mm/zsmalloc.c' using previous resolution.
> Automatic merge failed; fix conflicts and then commit the result.
> $ git commit --no-edit -v -a
> [master 5d9bea6f818b] Merge branch 'for-next' of git://git.infradead.org/=
users/willy/pagecache.git
> $ git diff -M --stat --summary HEAD^..
>  fs/btrfs/disk-io.c | 19 ++++++++-----------
>  1 file changed, 8 insertions(+), 11 deletions(-)

And I got a new unnecessary conflict when merging the folio tree today ...

PLEASE can you clean this up :-(

--=20
Cheers,
Stephen Rothwell

--Sig_/GSS/lNmNP.lm.x0DkYZQudm
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmO8xnsACgkQAVBC80lX
0GzY3AgAnMzoflgyMYzNlZTA3Zaw6hjGkbF7uDZWZ8w9pCHP7Chvri+cRirjlxT3
Q/4fOHq7XeMGFdAPCdC4Gm+4xhTo9rgKaTHO9a6kk2OOivfwuRj0n/OOBNfWjzZ4
n4kzQQZVOoF6Nbp/nnolnR1c+BZVGcaUNMa/hIxAHlE4QbAA32PL7hdjuOw10VF0
3KuAEfOF38mUkEexM/w70RbImWW+lMlvBtyegC6JkLryvwiN5tzLKajAyJPDc7zM
Zic+08jilfyxePL9QLg4V1mlp1nYbr5cqSEHujQ3A0CTz0kQ88Nlw3GajgGgVHNu
5JPBDnEXLKziYNv1FZKRRsusRaGqPw==
=CJsb
-----END PGP SIGNATURE-----

--Sig_/GSS/lNmNP.lm.x0DkYZQudm--
