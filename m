Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A58D65DF54
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 22:50:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240035AbjADVux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 16:50:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232953AbjADVut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 16:50:49 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4612FBB7;
        Wed,  4 Jan 2023 13:50:48 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NnNZZ6k2zz4xyP;
        Thu,  5 Jan 2023 08:50:46 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1672869047;
        bh=DUONSb0b08+jTM8/fHpPDGL4KNbHRrJ+G7Qbm89uQP0=;
        h=Date:From:To:Cc:Subject:From;
        b=mAzwEwHCCS09zo8lfu10LWuSfhkZVmHOnHXmyhL5mhSV4EMoen67LTZbBdcmkEXKr
         4o7idvPx95guNHdU5DWdqVcNK/ssBx4thXJyYfQZGoGmkeMGKVVapJQp5eehcktl5l
         k7U38XZq40fBkpvQ6/bUHdPp6Cb49Tw//d16AsUssmXnT134EXU3xNPQDmt/Z7YcXK
         gQ6WDbORyoMjmK9aayjev4vDu3UzmCyZmdhvF76CM6Nsj9bwQVH9/grvjIPT+uzdgg
         se802v0Sb0/BEdyt0GFtq/okzvIotXgFgxF0SPWYvMHT5DID76+/zOxCfw5GTqiBTs
         jP0Fh0urw+B5A==
Date:   Thu, 5 Jan 2023 08:50:45 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the folio tree
Message-ID: <20230105085045.4bd2e6aa@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/zG6zOa1/pYzAjHmR9mDsifm";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/zG6zOa1/pYzAjHmR9mDsifm
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits already exist in Linus Torvald's tree as different
commits (but the same patches):

  ba457436991a ("buffer: Don't test folio error in block_read_full_folio()")
  2c62b172802a ("squashfs: Return the actual error from squashfs_read_folio=
()")
  4188e3e2860d ("hostfs: Handle page write errors correctly")
  437084d7c5b8 ("ocfs2: Use filemap_write_and_wait_range() in ocfs2_cow_syn=
c_writeback()")
  0ba02b002594 ("cramfs: read_mapping_page() is synchronous")
  1cf29f882fa8 ("block: Simplify read_part_sector()")
  a340b79b2991 ("block: Handle partition read errors more consistently")
  4639d0da923e ("block: Use PAGE_SECTORS_SHIFT")
  5b15f72a828b ("block: Convert read_part_sector() to use a folio")
  fa19fbd23186 ("befs: Convert befs_symlink_read_folio() to use a folio")
  1a6b7e5cb550 ("coda: Convert coda_symlink_filler() to use a folio")
  6e2a48222bc9 ("freevxfs: Convert vxfs_immed_read_folio() to use a folio")
  71864cbf4617 ("ocfs2: Convert ocfs2_read_folio() to use a folio")
  d862e2d59368 ("gfs2: Convert gfs2_jhead_process_page() to use a folio")
  1662afcecae5 ("ext2: Use a folio in ext2_get_page()")
  1a22e12f94c9 ("secretmem: Remove isolate_page")
  b361f39863ed ("mm: Convert all PageMovable users to movable_operations")
  662389777689 ("fs: Add aops->migrate_folio")
  765acf9085a1 ("mm/migrate: Convert fallback_migrate_page() to fallback_mi=
grate_folio()")
  7d474706ff4f ("mm/migrate: Convert writeout() to take a folio")
  e267a3198014 ("mm/migrate: Convert buffer_migrate_page() to buffer_migrat=
e_folio()")
  55553f3437c8 ("mm/migrate: Convert expected_page_refs() to folio_expected=
_refs()")
  e8172b8e1728 ("btrfs: Convert btree_migratepage to migrate_folio")
  27826326e888 ("nfs: Convert to migrate_folio")
  af9c33968b72 ("mm/migrate: Convert migrate_page() to migrate_folio()")
  441b3afcb2e3 ("mm/migrate: Add filemap_migrate_folio()")
  9c5161d1eefb ("btrfs: Convert btrfs_migratepage to migrate_folio")
  9f11d68b2721 ("ubifs: Convert to filemap_migrate_folio()")
  9c16c4c68213 ("f2fs: Convert to filemap_migrate_folio()")
  9b553d250256 ("aio: Convert to migrate_folio")
  5567427fd70e ("hugetlb: Convert to migrate_folio")
  48e7ede1b860 ("secretmem: Convert to migrate_folio")
  c33b866a9784 ("fs: Remove aops->migratepage()")
  84578adbb0e0 ("mm/folio-compat: Remove migration compatibility functions")
  9594da4cec1d ("ntfs3: refactor ntfs_writepages")
  8862fa5da9f1 ("ext2: remove nobh support")
  3f05372ce9dd ("jfs: stop using the nobh helper")
  215e71b6ee7a ("fs: remove the nobh helpers")
  cf95d50205f6 ("fs: don't call ->writepage from __mpage_writepage")
  03b33c09ea22 ("fs: remove the NULL get_block case in mpage_writepages")

--=20
Cheers,
Stephen Rothwell

--Sig_/zG6zOa1/pYzAjHmR9mDsifm
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmO19LUACgkQAVBC80lX
0GwtRQgAjZ+ZpqOQo+oqimvDutgYTMdQEfxhKgIKXq0AoAA8vFcR9FMx2PfjOPZw
mkhrFLVGMak+48Jk2I4s+tJHvQD6feZSDBA9DLuOM5Vc5vGjU7a2YejUIA7B3K7X
N3vi/ZPeVeEtDBReuPKohBwM+rLnifIpJyHwTUwSlvjywPfrC3BMhGlwVOGT+d4H
zZsBGkmIPl8Zy8dWuRKgbqS/rUdSMYz7TNOmgSKGK+4ZgJtOTko7qKvCgnPFHre6
/PwfMFULp2kDRGa9xlQpKXWUnJVn9+2NnCwrfFSJx4o7rimMDf9aGCjngCv5+RPB
hYtvLbedOwEwxYV9XKEzgSdYd4cDOw==
=20BV
-----END PGP SIGNATURE-----

--Sig_/zG6zOa1/pYzAjHmR9mDsifm--
