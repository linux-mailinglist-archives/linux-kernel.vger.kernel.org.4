Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E42265A8D6
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jan 2023 05:34:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbjAAEd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 23:33:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjAAEdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 23:33:55 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E721311;
        Sat, 31 Dec 2022 20:33:49 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Nl5jM6Ts8z4xwv;
        Sun,  1 Jan 2023 15:33:43 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1672547624;
        bh=UejO2L/LFa0oi0WTQr18IUKuQjzDNjc3EZbDW5L0VqE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SPktc+wC6NjlIKs+sKihNgIw/r3c2dXV97VX4LmZQMZqLTTiFLrOrxJoeHtQ7wQgO
         P/24t/aL99tmMceLCERsd44UAOcpDmsV4zsBfIbbVX8K0rr9LJNwWPrmeh8Ek811W+
         Dvg7+yYTEAxjuUMnoQe94U7LFFeUwbpTQv4xX/n3Q+yVOyQLxErhVzz+CZiq1u0V/7
         Kor1Zd1LorBNrWzJT/4uTYBkRjiANVg25Oa322v8c7W1v6QByb0kHoQ5cETIRL3Hz1
         zkKEDtPzzjxuErUeKuR8y3Vj+UlMIbcOBh6WqTDhe5CqmGqfMFI9fHgcGczNUODnRc
         20kDv1jM7uBjw==
Date:   Sun, 1 Jan 2023 15:33:30 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: please clean up the folio tree
Message-ID: <20230101153330.7bf359af@canb.auug.org.au>
In-Reply-To: <20221215105539.72da7ceb@canb.auug.org.au>
References: <20221215105539.72da7ceb@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/LPv.oYnYy=Fk=g3pPX26Qat";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/LPv.oYnYy=Fk=g3pPX26Qat
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Willy,

On Thu, 15 Dec 2022 10:55:39 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> The folio tree seems to contain a number of commits that duplicate
> commits in Linus' tree.

I fact, all but the first commit in the folio tree were merged by Linus
in v6.0-rc1.  And the folio tree has not bee updates since mid June ...

$ git cherry -v v6.0-rc1 folio/for-next
+ 964688b32d9ada55a7fce2e650d85ef24188f73f btrfs: Use a folio in wait_dev_s=
upers()
- ba457436991abc8e3cc830cfc91e9f54b53a07ed buffer: Don't test folio error i=
n block_read_full_folio()
- 2c62b172802a648cb9bad9b1ad2415a8ecbb7f41 squashfs: Return the actual erro=
r from squashfs_read_folio()
- 4188e3e2860d65a43397d4658f74136bf3297808 hostfs: Handle page write errors=
 correctly
- 437084d7c5b825e714d0b50ba6624e6ba840fa32 ocfs2: Use filemap_write_and_wai=
t_range() in ocfs2_cow_sync_writeback()
- 0ba02b002594cc1809da3a05a44bb5b9654448f6 cramfs: read_mapping_page() is s=
ynchronous
- 1cf29f882fa8e28e18cccc9b0a7e94e391b3291f block: Simplify read_part_sector=
()
- a340b79b299109ded6928157dc24cf0fb6a90823 block: Handle partition read err=
ors more consistently
- 4639d0da923efd6704974893ba19eb1aaf396538 block: Use PAGE_SECTORS_SHIFT
- 5b15f72a828b44a06d50ab739e89ac492298bec4 block: Convert read_part_sector(=
) to use a folio
- fa19fbd23186e43714bf7694ec83b7a519e618c0 befs: Convert befs_symlink_read_=
folio() to use a folio
- 1a6b7e5cb5504bf4f0f4e63b8bedaff8aad5798b coda: Convert coda_symlink_fille=
r() to use a folio
- 6e2a48222bc97d4028b1ff8b8bfdfadec7a72923 freevxfs: Convert vxfs_immed_rea=
d_folio() to use a folio
- 71864cbf4617f06ff2434235049e9c3daa2806a6 ocfs2: Convert ocfs2_read_folio(=
) to use a folio
- d862e2d593685f8a895202493f1a059932cdb0e0 gfs2: Convert gfs2_jhead_process=
_page() to use a folio
- 1662afcecae535147b1cb143fde8d99a6a98d8fe ext2: Use a folio in ext2_get_pa=
ge()
- 1a22e12f94c9f647cdd8e4e56bc313043e9eb5c2 secretmem: Remove isolate_page
- b361f39863ed2d6ca644a2d53638c3fd87d32d14 mm: Convert all PageMovable user=
s to movable_operations
- 662389777689c17a77849af822bac1677be56e37 fs: Add aops->migrate_folio
- 765acf9085a1188244ec6294e3039637685c209e mm/migrate: Convert fallback_mig=
rate_page() to fallback_migrate_folio()
- 7d474706ff4fb035f896710fa1274e3050afb461 mm/migrate: Convert writeout() t=
o take a folio
- e267a3198014ec93389b1930b776047082bb271f mm/migrate: Convert buffer_migra=
te_page() to buffer_migrate_folio()
- 55553f3437c8b185b71fe4bd8106141a4e4192de mm/migrate: Convert expected_pag=
e_refs() to folio_expected_refs()
- e8172b8e1728b41160dc8fef7fdd9ffbcaa152c6 btrfs: Convert btree_migratepage=
 to migrate_folio
- 27826326e888a185d7d191670cf445dec88e9218 nfs: Convert to migrate_folio
- af9c33968b722c5871974541067dc180377501df mm/migrate: Convert migrate_page=
() to migrate_folio()
- 441b3afcb2e31aca89f6e2cd6642f141c7bbe142 mm/migrate: Add filemap_migrate_=
folio()
- 9c5161d1eefb24389a077b43e8e11322f2e4cd42 btrfs: Convert btrfs_migratepage=
 to migrate_folio
- 9f11d68b27211e6a73b0540dc757c91c01ae74bf ubifs: Convert to filemap_migrat=
e_folio()
- 9c16c4c68213afc512aadb854c9603f4eff6b977 f2fs: Convert to filemap_migrate=
_folio()
- 9b553d25025600ecaeb903b9250279b50c1c6054 aio: Convert to migrate_folio
- 5567427fd70edcd4809a5b1df03f363e72f997bf hugetlb: Convert to migrate_folio
- 48e7ede1b860e44edfd0231f888a7f16af86d6a0 secretmem: Convert to migrate_fo=
lio
- c33b866a97842ac96f4373f737ba608dd157f08a fs: Remove aops->migratepage()
- 84578adbb0e0657003e646e0af699ef74b99386e mm/folio-compat: Remove migratio=
n compatibility functions
- 9594da4cec1db0491d35b38d5988eb989720d6f4 ntfs3: refactor ntfs_writepages
- 8862fa5da9f144d0554c2177aea7ce0b6f97d8c0 ext2: remove nobh support
- 3f05372ce9ddbd643a763f60c0d2a115cb2de008 jfs: stop using the nobh helper
- 215e71b6ee7ad3363c6e6bd979adbb56e070f6de fs: remove the nobh helpers
- cf95d50205f62c4f5f538676def847292cf39fa9 fs: don't call ->writepage from =
__mpage_writepage
- 03b33c09ea22fa89dd204ad0a2058e512c691b9f fs: remove the NULL get_block ca=
se in mpage_writepages

And the presence of these commits in the folio tree produces the
following output when I merge it:

Auto-merging Documentation/filesystems/locking.rst
Auto-merging Documentation/filesystems/vfs.rst
Auto-merging block/fops.c
Auto-merging block/partitions/core.c
Auto-merging drivers/gpu/drm/i915/gem/i915_gem_userptr.c
Auto-merging drivers/misc/vmw_balloon.c
Auto-merging drivers/virtio/virtio_balloon.c
Auto-merging fs/aio.c
Auto-merging fs/btrfs/disk-io.c
Auto-merging fs/btrfs/inode.c
Auto-merging fs/buffer.c
Auto-merging fs/ext2/dir.c
Auto-merging fs/ext2/inode.c
Auto-merging fs/ext2/namei.c
Auto-merging fs/ext2/super.c
Auto-merging fs/ext4/inode.c
Auto-merging fs/f2fs/checkpoint.c
Auto-merging fs/f2fs/data.c
Auto-merging fs/f2fs/f2fs.h
Auto-merging fs/f2fs/node.c
Auto-merging fs/gfs2/aops.c
Auto-merging fs/gfs2/lops.c
Auto-merging fs/hostfs/hostfs_kern.c
Auto-merging fs/hugetlbfs/inode.c
CONFLICT (content): Merge conflict in fs/hugetlbfs/inode.c
Auto-merging fs/iomap/buffered-io.c
Auto-merging fs/jfs/inode.c
Auto-merging fs/mpage.c
Auto-merging fs/nfs/file.c
Auto-merging fs/nfs/internal.h
Auto-merging fs/nfs/write.c
Auto-merging fs/ntfs/aops.c
Auto-merging fs/ntfs3/inode.c
Auto-merging fs/ocfs2/aops.c
Auto-merging fs/ocfs2/refcounttree.c
Auto-merging fs/squashfs/file.c
Auto-merging fs/ubifs/file.c
Auto-merging fs/xfs/xfs_aops.c
Auto-merging fs/zonefs/super.c
Auto-merging include/linux/buffer_head.h
Auto-merging include/linux/fs.h
Auto-merging include/linux/iomap.h
Auto-merging include/linux/migrate.h
CONFLICT (content): Merge conflict in include/linux/migrate.h
Auto-merging include/linux/page-flags.h
Auto-merging include/linux/pagemap.h
Auto-merging mm/compaction.c
Auto-merging mm/folio-compat.c
Auto-merging mm/ksm.c
Auto-merging mm/migrate.c
CONFLICT (content): Merge conflict in mm/migrate.c
Auto-merging mm/migrate_device.c
CONFLICT (content): Merge conflict in mm/migrate_device.c
Auto-merging mm/secretmem.c
Auto-merging mm/shmem.c
Auto-merging mm/swap_state.c
Auto-merging mm/util.c
Auto-merging mm/z3fold.c
Auto-merging mm/zsmalloc.c
CONFLICT (content): Merge conflict in mm/zsmalloc.c
Resolved 'fs/hugetlbfs/inode.c' using previous resolution.
Resolved 'include/linux/migrate.h' using previous resolution.
Resolved 'mm/migrate.c' using previous resolution.
Resolved 'mm/migrate_device.c' using previous resolution.
Resolved 'mm/zsmalloc.c' using previous resolution.
Automatic merge failed; fix conflicts and then commit the result.
$ git commit --no-edit -v -a
[master 5d9bea6f818b] Merge branch 'for-next' of git://git.infradead.org/us=
ers/willy/pagecache.git
$ git diff -M --stat --summary HEAD^..
 fs/btrfs/disk-io.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

--=20
Cheers,
Stephen Rothwell

--Sig_/LPv.oYnYy=Fk=g3pPX26Qat
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmOxDRoACgkQAVBC80lX
0GzB7gf+ItJ3qc/78raBG1/3jKOhEEzC7EGbrlZ5U+12GEW55jJ9IGfoicQSt07i
YpHyDDqCA8Dkn8qB773DQUzD0K951+dzQJwkCukic8lpjsRSaCO03aG4XBSpOs+1
MxcOdtksiOMvSqRcWHBNHbd+eXjGss8CH4h6CqqrSPA6uFjcKl+See32gSEah65A
MnQPMvuGk/HDTnJ3sM4mJg6g+tRFgLYomCiIKwZ9AdBiJreKYAyAlnmLbZTGLVPA
vUsnp0qUbH8CPi7JausPBvrpvovl8qru5knmV4enlYA89uGPwzyeaxvk5Y+sTl7z
qYgwEYGRzYfGgRfVVa4IOKd73Hveew==
=JBAB
-----END PGP SIGNATURE-----

--Sig_/LPv.oYnYy=Fk=g3pPX26Qat--
