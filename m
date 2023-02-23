Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A41069FFD4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 01:02:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232808AbjBWACr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 19:02:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbjBWACp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 19:02:45 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D186539B81;
        Wed, 22 Feb 2023 16:02:42 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id f16so9536518ljq.10;
        Wed, 22 Feb 2023 16:02:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HTqpIUSYGRFM/YbU8bpVwwd1UiA0bcO2B2Jv+esFV2Y=;
        b=c6ndu+5+Y+rlfGnAb8GMn4JzhgTFRV0U5CC5LpxSUSSc8AfZvK+aSvj/7X9gN0QhH2
         L3T223XNgg6G9n3bn1h1IeABa4LZLnTroqUFmvhD7AeNljMeDUV77riSMoM6gCkij+n7
         iB+o9gjMw+wU+tFh/GZmRmk3UBJETUsu4aiL3qAf7jCx1XaDTQmM9nld/ihkIIa1bjrY
         T+5CX3O/Nk6N/pAvgb2LXcg2jsMez9IsceDVRwCwRa0BF2ytnKxlMj54P3S1t+iWwbFD
         /65Bsua+OQl57SvGbFXKH8SugbVbhsGO9aWPJEYHObHgxAzbAqMRsAM/M1CGHCgxpzDa
         WteQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HTqpIUSYGRFM/YbU8bpVwwd1UiA0bcO2B2Jv+esFV2Y=;
        b=xLTfn/H65lmNRAbXdpNHjfwlhjJS09iKgUM79WBJWCAqK/hHtJ1GE4kUNW4pAWm524
         7uxSIIZHBdmHizgKu2+OF+HUgDzuE6pbKHBbprJkZYOy/yDr6YAQ5cgMQi/N8uRJq8bh
         i4GQrnMuS16KIE3KTiUqROMppXC5dQOncosLKg1CkNlJeVsrmDdW+kgEKEbrpgBqF89M
         o8gqSkT1oOsIDcAgS1n7CeyZqaz2twYmW0KO1rKBPciMK9XPU0uIahA6r3e9j4o0MiQ8
         WhkvPsaleTwfP7902nDlp53hiriI4PKDOFYlq1vJSCGvAibmpfv+eNH5/EvES3SRi4vw
         K6Xw==
X-Gm-Message-State: AO0yUKVnuzHAxD4UAaW6z07IPLzpW02zgAxgEEDBbhG3LGKlCTOCcuYZ
        fp4lulaPTUHUmsRp+j4eIw36AgKnrKuN2PzDBPWOFAA4l1E=
X-Google-Smtp-Source: AK7set+LDFqiXNaqr1hI6UkxEuWSkrhTSrZIxjRjnRc6l8TEKnIkSB2kqPG1gqjjq6rqPUge2PyUR2nIJYxBuI+qO80=
X-Received: by 2002:a05:651c:1699:b0:294:6f14:235b with SMTP id
 bd25-20020a05651c169900b002946f14235bmr3207367ljb.5.1677110560735; Wed, 22
 Feb 2023 16:02:40 -0800 (PST)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Wed, 22 Feb 2023 18:02:29 -0600
Message-ID: <CAH2r5muxu2YppXOLhwJ7hHjhaUZmEUHyc7O8GKekNnH44nd1EA@mail.gmail.com>
Subject: [GIT PULL] smb3 client fixes
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        CIFS <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull the following changes since commit
c9c3395d5e3dcc6daee66c6908354d47bf98cb0c:

  Linux 6.2 (2023-02-19 14:24:22 -0800)

are available in the Git repository at:

  git://git.samba.org/sfrench/cifs-2.6.git tags/6.3-rc-smb3-client-fixes

for you to fetch changes up to fdbf807215250217c83f1cb715b883cd910102fa:

  update internal module version number for cifs.ko (2023-02-21 01:25:44 -0600)

----------------------------------------------------------------
46 fs/cifs (smb3 client) changesets, 37 for the fs/cifs directory and 9
outside (for related helper functions and cleanup of now unused
functions) from David Howells and Willy.

Note that there's a conflict with the mm tree with regard to the
replacement of find_get_pages_range_tag() with
filemap_get_folios_tag() which can be resolved by the patch David
provided: https://lore.kernel.org/lkml/2885897.1676990364@warthog.procyon.org.uk/
or what Stephen Rothwell did:
https://lore.kernel.org/lkml/20230222134927.459b036b@canb.auug.org.au/
in linux-next

The largest subset of this P/R is from David Howells et al: making the cifs/smb3
driver pass iov_iters down to the lowest layers, directly to the
network transport rather than passing lists of pages around, helping
multiple areas:
 (-) Pin user pages, thereby fixing the race between concurrent DIO read and
     fork, where the pages containing the DIO read buffer may end up
     belonging to the child process and not the parent - with the result
     that the parent might not see the retrieved data.
 (-) cifs shouldn't take refs on pages extracted from non-user-backed
     iterators (eg. KVEC).  With these changes, cifs will apply the
     appropriate cleanup.
 (-) Making it easier to transition to using folios in cifs rather than
     pages by dealing with them through BVEC and XARRAY iterators.
 (-) Allowing cifs to use the new splice function

The remainder are:
- ten fixes for stable, including various fixes for uninitialized
memory, wrong length field causing mount issue to very old servers,
important directory lease fixes and reconnect fixes
- 9 cleanups (unused code removal, change one element array usage, and
a change form strtobool to kstrtobool, and 2 Kconfig cleanups)
- 6 SMBDIRECT (RDMA) fixes including iov_iter integration and UAF fixes
- 2 reconnect fixes
- 3 multichannel fixes, including improving channel allocation (to
least used channel)
- remove last use of lock_page_killable by moving to folio_lock_killable

Also FYI there are additional important directory lease (metadata
caching fixes) and multichannel fixes being tested that are not
included in this P/R but should be ready next week.  And two small
fixes to David's series were also identified that I can send next week
(I also wanted to reduce risk of merge conflicts)
----------------------------------------------------------------
Andy Shevchenko (1):
      cifs: Get rid of unneeded conditional in the smb2_get_aead_req()

Christophe JAILLET (1):
      cifs: Use kstrtobool() instead of strtobool()

David Howells (17):
      mm: Pass info, not iter, into filemap_get_pages()
      splice: Add a func to do a splice from a buffered file without ITER_PIPE
      splice: Add a func to do a splice from an O_DIRECT file without ITER_PIPE
      iov_iter: Define flags to qualify page extraction.
      iov_iter: Add a function to extract a page list from an iterator
      splice: Export filemap/direct_splice_read()
      cifs: Implement splice_read to pass down ITER_BVEC not ITER_PIPE
      netfs: Add a function to extract a UBUF or IOVEC into a BVEC iterator
      netfs: Add a function to extract an iterator into a scatterlist
      cifs: Add a function to build an RDMA SGE list from an iterator
      cifs: Add a function to Hash the contents of an iterator
      cifs: Add some helper functions
      cifs: Add a function to read into an iter from a socket
      cifs: Change the I/O paths to use an iterator rather than a page list
      cifs: Build the RDMA SGE list directly from an iterator
      cifs: Remove unused code
      cifs: DIO to/from KVEC-type iterators should now work

Gustavo A. R. Silva (1):
      cifs: Replace zero-length arrays with flexible-array members

Kees Cook (3):
      cifs: Convert struct fealist away from 1-element array
      cifs: Replace remaining 1-element arrays
      smb3: Replace smb2pdu 1-element arrays with flex-arrays

Matthew Wilcox (Oracle) (2):
      cifs: Use a folio in cifs_page_mkwrite()
      filemap: Remove lock_page_killable()

Namjae Jeon (1):
      cifs: remove unneeded 2bytes of padding from smb2 tree connect

Paulo Alcantara (4):
      cifs: prevent data race in smb2_reconnect()
      cifs: get rid of unneeded conditional in cifs_get_num_sgs()
      cifs: fix mount on old smb servers
      cifs: get rid of dns resolve worker

Ronnie Sahlberg (2):
      cifs: Check the lease context if we actually got a lease
      cifs: return a single-use cfid if we did not get a lease

Shyam Prasad N (4):
      cifs: print last update time for interface list
      cifs: use the least loaded channel for sending requests
      cifs: use tcon allocation functions even for dummy tcon
      cifs: update ip_addr for ses only for primary chan setup

Stefan Metzmacher (3):
      cifs: introduce cifs_io_parms in smb2_async_writev()
      cifs: split out smb3_use_rdma_offload() helper
      cifs: don't try to use rdma offload on encrypted connections

Steve French (3):
      cifs: update Kconfig description
      cifs: fix indentation in make menuconfig options
      update internal module version number for cifs.ko

Volker Lendecke (2):
      cifs: Fix uninitialized memory read in smb3_qfs_tcon()
      cifs: Fix uninitialized memory reads for oparms.mode

Zhang Xiaoxu (2):
      cifs: Fix lost destroy smbd connection when MR allocate failed
      cifs: Fix warning and UAF when destroy the MR list

 block/bio.c               |    6 +-
 block/blk-map.c           |    8 +-
 fs/cifs/Kconfig           |   66 ++--
 fs/cifs/cached_dir.c      |   43 ++-
 fs/cifs/cifs_debug.c      |   11 +-
 fs/cifs/cifs_spnego.h     |    2 +-
 fs/cifs/cifsacl.c         |   34 +-
 fs/cifs/cifsencrypt.c     |  172 ++++++++--
 fs/cifs/cifsfs.c          |   12 +-
 fs/cifs/cifsfs.h          |    8 +-
 fs/cifs/cifsglob.h        |   81 +++--
 fs/cifs/cifspdu.h         |   98 +++---
 fs/cifs/cifsproto.h       |   11 +-
 fs/cifs/cifssmb.c         |   48 ++-
 fs/cifs/connect.c         |  179 ++++------
 fs/cifs/dir.c             |   19 +-
 fs/cifs/file.c            | 1810
+++++++++++++++++++++++++++++++++++++++++++-------------------------------------------------------
 fs/cifs/fscache.c         |   22 +-
 fs/cifs/fscache.h         |   10 +-
 fs/cifs/inode.c           |   53 +--
 fs/cifs/link.c            |   66 ++--
 fs/cifs/misc.c            |  128 +------
 fs/cifs/ntlmssp.h         |    4 +-
 fs/cifs/readdir.c         |    6 +-
 fs/cifs/sess.c            |    1 -
 fs/cifs/smb1ops.c         |   72 ++--
 fs/cifs/smb2file.c        |    2 +-
 fs/cifs/smb2inode.c       |   17 +-
 fs/cifs/smb2misc.c        |    2 +-
 fs/cifs/smb2ops.c         |  606 ++++++++++++++++-----------------
 fs/cifs/smb2pdu.c         |  291 +++++++++-------
 fs/cifs/smb2pdu.h         |    4 +-
 fs/cifs/smbdirect.c       |  539 +++++++++++++++++------------
 fs/cifs/smbdirect.h       |    7 +-
 fs/cifs/transport.c       |   87 ++---
 fs/ksmbd/smb2ops.c        |    8 +-
 fs/ksmbd/smb2pdu.c        |    6 +-
 fs/netfs/Makefile         |    1 +
 fs/netfs/iterator.c       |  371 ++++++++++++++++++++
 fs/smbfs_common/smb2pdu.h |   42 ++-
 fs/splice.c               |   93 +++++
 include/linux/fs.h        |    6 +
 include/linux/netfs.h     |    8 +
 include/linux/pagemap.h   |   10 -
 include/linux/pipe_fs_i.h |   20 ++
 include/linux/uio.h       |   35 +-
 lib/iov_iter.c            |  284 +++++++++++++++-
 mm/filemap.c              |  157 ++++++++-
 mm/internal.h             |    6 +
 mm/vmalloc.c              |    1 +
 50 files changed, 3220 insertions(+), 2353 deletions(-)
 create mode 100644 fs/netfs/iterator.c

-- 
Thanks,

Steve
