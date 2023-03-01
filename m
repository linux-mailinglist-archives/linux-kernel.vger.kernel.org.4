Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 299F06A7171
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 17:44:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjCAQox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 11:44:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjCAQov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 11:44:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA7121F4B8
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 08:44:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9028FB81035
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 16:44:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C771EC433D2;
        Wed,  1 Mar 2023 16:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677689087;
        bh=A3if92ZIohjfUBi/BTR1cZ3prMiSwf6LZ1x22PE7Efc=;
        h=Date:From:To:Cc:Subject:From;
        b=XNNeSONyDjl/BKjCrTm6bysN2FrKOX/gN/58FQgoxD5krTecAPBm1AxvIuYLTpgoH
         3qnlFz5yfYhgmRwZL8Deh3Y1XMP+OrIDl9psAazY1jjAUbL8qrmjHywTdnxBPELSG4
         3S3Kd9Eb60nSHiB6EAIqDneVVI2wfpEuTThlT/hz/ScvKrw93Xh7K/914QCOz+AurI
         2EOC4PDFmWLdpuiaQP3F0fGSt7BkVCdA98dTV7053fea2cnQtLr1eO9sFv4+CfvOSE
         QeZW57ReVzFNZ+hDuVbmDMV/8nQaRNCISLyIjnI7+2yVmWnmho01Y1ZPHRDBE+Axfd
         bFGoRmlfCB94w==
Date:   Wed, 1 Mar 2023 16:44:44 +0000
From:   Eric Van Hensbergen <ericvh@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net
Subject: [GIT PULL] 9p patches for 6.3 merge window (part 1)
Message-ID: <Y/+A/K4/2A8iRj2m@thundercleese.milagro.dyndns.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uGc9we6eFnb3BmzY"
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uGc9we6eFnb3BmzY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 88603b6dc419445847923fcb7fe5080067a30f98:

  Linux 6.2-rc2 (2023-01-01 13:53:16 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ericvh/v9fs.git tags/9p-6.3-for-linus-part1

for you to fetch changes up to 89c58cb395ec0fb58df5475dced1093eaf5896ad:

  fs/9p: fix error reporting in v9fs_dir_release (2023-02-24 13:42:40 +0000)

----------------------------------------------------------------
9p patches for 6.3 merge window (part 1)

Here is the 9p patches for the 6.3 merge window combining
the tested and reviewed patches from both Dominique's
for-next tree and my for-next tree.  Most of these
patches have been in for-next since December with only
some reword in the description:

- some fixes and cleanup setting up for a larger set
  of performance patches I've been working on
- a contributed fixes relating to 9p/rdma
- some contributed fixes relating to 9p/xen

I've marked this as part 1, I'm not sure I'll be
submitting part 2.  There were several performance
patches that I wanted to get in, but the revisions
after review only went out last week so while they
have been tested, I haven't received reviews on the
revisions.

Its been about a decade since I've submitted a pull
request, sorry if I messed anything up.

       -eric

----------------------------------------------------------------
Eric Van Hensbergen (4):
      net/9p: Adjust maximum MSIZE to account for p9 header
      fs/9p: Expand setup of writeback cache to all levels
      net/9p: fix bug in client create for .L
      fs/9p: fix error reporting in v9fs_dir_release

Juergen Gross (2):
      9p/xen: fix version parsing
      9p/xen: fix connection sequence

Zhengchao Shao (1):
      9p/rdma: unmap receive dma buffer in rdma_request()/post_recv()

 fs/9p/v9fs.c           |  2 +-
 fs/9p/vfs_addr.c       |  2 --
 fs/9p/vfs_dir.c        |  7 ++++---
 fs/9p/vfs_file.c       |  7 ++++---
 fs/9p/vfs_inode.c      |  3 +--
 fs/9p/vfs_inode_dotl.c |  7 ++++---
 net/9p/client.c        |  8 ++++++--
 net/9p/trans_rdma.c    | 15 ++++++++++++---
 net/9p/trans_xen.c     | 48 +++++++++++++++++++++++++++++++-----------------
 9 files changed, 63 insertions(+), 36 deletions(-)


--uGc9we6eFnb3BmzY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEElpbw0ZalkJikytFRiP/V+0pf/5gFAmP/gPwACgkQiP/V+0pf
/5ij1g/+L2pwdloG4Rd8kOOZSg3oP9tKAiv/FfJQEhp9Hj5JHpCL8lI2wIRKqgzI
VW4WN1YpXyFxRK3QlDxFzJEdJcsIVEDl5Sua+qBSM+/CmCyhqgNqFyCplAcLDt6y
9MBbiAvFqUHKJzvwU7q19zhka1K/Bf/ratv5o8pLfHwkF7d2ZdbEb6hZdq+o2O7/
PHsUuMHqB/HdqqJbsRKkmMlR7r4iyfuFuolAxa0Vv5+N8/51cPKRVvjh0hS5E+rC
UbSrS7HekNT5xbM1x9kgSdPi3Ribdh7Ky2ZCv079wcbaWjYeu2HbgCdua9ktmMGb
3PCZOyE6AY9m4itJl/SeRQQSRqP+emIh+5k0pK6MrIpAz7JF2y/idV7tkWm9TBxm
yAzNv2iID5KFQvMIrAYalhpdiWKVbDrwBa1zYKcC3+lTOShpWJJfOSLOBj81Lupy
8Rd4VAAQZ11H93ohAkGSc4hvRCFxH7MFay4HhJZ6O889JCm7YuAVQRg/i/T3OiDU
L5TgcwCzZxDTgMmAXf6y4xuwVv0JQ6VkWVm/e3553Y/RIbEEh0ztes+Wlba6UOTt
BEAKrpm3ne2HYehZI/BjCZMYPEJoCwML/z+qm6LQkHs9GnI5gNGocRySXfdUQJe4
Rhd0PrHS8e8yf3rFhrby4Ybv9j/fTIIsk71Ncq9JVqUG1HQ5pnk=
=6EoQ
-----END PGP SIGNATURE-----

--uGc9we6eFnb3BmzY--
