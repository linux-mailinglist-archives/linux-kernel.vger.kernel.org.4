Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4AB680388
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 02:41:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235200AbjA3Blv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 20:41:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjA3Blt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 20:41:49 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21CFB193F2;
        Sun, 29 Jan 2023 17:41:47 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4P4rWX1wX1z4x1f;
        Mon, 30 Jan 2023 12:41:44 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1675042905;
        bh=/g4ovl4VjuYGQh76xlaD70mVDhhK8pT7E6XlQz3Er1c=;
        h=Date:From:To:Cc:Subject:From;
        b=mydGL8neFpL2lMrIaTOb+FIucMafa5Bbfabz2PAWKv7omSAl7aFwV3igmKJmHrkFb
         QujG5koweEBr3a7c+1ILVlytxG/YgDU3GEUu2C8c2m6fb3FBmsrrcyYi5uS3NH//LI
         0BssbYYAldIPOzLo8ouqHcZrM4oM/bqx3nUG+VCGWOc3yL8ISbi3cIfRbyC68m0D8+
         hiRuXKDAU5E5+T1yLZSshvr7OQ/QFl3slP6kgrEncQq54PmwGme6Vs9VVgaThucbqN
         q5u1l+Z2Ngno2hISkQX/CU7mPrCaff6bp5KeXG4XHX720O3o+8UToYDDGHh/Gv5snK
         58NNrnsf/nVXA==
Date:   Mon, 30 Jan 2023 12:41:43 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alasdair G Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the device-mapper tree
Message-ID: <20230130124143.210b5149@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/doeHGov9QMIdfFOG3F41NZW";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/doeHGov9QMIdfFOG3F41NZW
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in the block tree as different commits
(but the same patches):

  08a39c820686 ("blk-iocost: avoid 64-bit division in ioc_timer_fn")
  11fd02522aae ("block, bfq: turn bfqq_data into an array in bfq_io_cq")
  204a9e1eeb4b ("blk-iocost: don't allow to configure bio based device")
  2192a93eb4ac ("ps3vram: remove bio splitting")
  3187f22498f6 ("drbd: remove unnecessary assignment in vli_encode_bits")
  346122e09011 ("block, bfq: retrieve independent access ranges from reques=
t queue")
  38d6577f1e01 ("drbd: fix DRBD_VOLUME_MAX 65535 -> 65534")
  3b1c494c4317 ("block: add a new helper bdev_{is_zone_start, offset_from_z=
one_start}")
  3bf6e7ac9a43 ("drbd: remove macros using require_context")
  419363fec82a ("block: add a BUILD_BUG_ON() for adding more bio flags than=
 we have space")
  4e952a32301a ("blk-iocost: fix divide by 0 error in calc_lcoefs()")
  51ec2387623a ("block, bfq: split sync bfq_queues on a per-actuator basis")
  55ee20573bd6 ("drbd: make limits unsigned")
  56f5160bc1b8 ("ublk_drv: add mechanism for supporting unprivileged ublk d=
evice")
  5d5ce3a05940 ("block: ublk: fix doc build warning")
  612307b9e29b ("block: make BLK_DEF_MAX_SECTORS unsigned")
  615b51f2a7ec ("block, bfq: forbid stable merging of queues associated wit=
h dif
ferent actuators")
  620183fd3cda ("ublk_drv: add device parameter UBLK_PARAM_TYPE_DEVT")
  6b5bcbd01de8 ("drbd: split off drbd_config into separate file")
  6e45a73ca9d6 ("drbd: adjust drbd_limits license header")
  6faa01c8bf3b ("ublk_drv: don't probe partitions if the ubq daemon isn't t=
ruste
d")
  707107e3c830 ("drbd: drbd_insert_interval(): Clarify comment")
  7a5841d1701d ("block, bfq: balance I/O injection among underutilized actu=
ators
")
  7a69a19ae640 ("block, bfq: inject I/O to underutilized actuators")
  7b6a2c89052b ("blk-iocost: check return value of match_u64()")
  7b810b50390b ("blk-iocost: read params inside lock in sysfs apis")
  7f0e2433880b ("block: save user max_sectors limit")
  803e2ec47623 ("block: introduce bdev_zone_no helper")
  8564135fe5b0 ("block: don't allow multiple bios for IOCB_NOWAIT issue")
  934f178446b1 ("block: extend bio-cache for non-polled requests")
  93cfbaba481c ("drbd: split off drbd_buildtag into separate file")
  961ccca54ad5 ("ublk_drv: add module parameter of ublks_max for limiting m=
ax al
lowed ublk dev")
  988136a30715 ("nvme: set REQ_ALLOC_CACHE for uring-passthru request")
  9d1d75e23110 ("drbd: drop API_VERSION define")
  a2aea8f56f9e ("s390/dcssblk:: don't call bio_split_to_limits")
  a5d140c503b6 ("ublk_drv: move ublk_get_device_from_id into ublk_ctrl_urin=
g_cmd
")
  aa70bcb25683 ("drbd: interval tree: make removing an "empty" interval a n=
o-op"
)
  abc42d89596a ("MAINTAINERS: add drbd headers")
  ad5572498be1 ("blk-iocost: change div64_u64 to DIV64_U64_ROUND_UP in ioc_=
refre
sh_params()")
  ba0b61d03ce3 ("block: treat poll queue enter similarly to timeouts")
  d5ff0182856b ("block, bfq: move io_cq-persistent bfqq data into a dedicat=
ed st
ruct")
  d66a012deb65 ("ublk_drv: remove nr_aborted_queues from ublk_device")
  ef0e0afd782e ("block: remove superfluous check for request queue in bdev_=
is_zo
ned()")
  fd44c9c683bc ("block, bfq: split also async bfq_queues on a per-actuator =
basis
")

It looks like the block tree was rebased ...

--=20
Cheers,
Stephen Rothwell

--Sig_/doeHGov9QMIdfFOG3F41NZW
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPXIFcACgkQAVBC80lX
0GyBOwf/X8jUfXlUKssR4Rxmp6sYd9X9lyq4BGDXCJpdh1e2DfHDBW3mTUYtI5Yr
y5QFWoUXrRx9Rc4WQKRnLvjZRuo6ttQ7kWbOUp2aJqUJeC7Gb0aS+SuIZA4hnKif
h2LQR5Y/eIgDy7luwOc0qWyR4iGKO+5x77WDwwdxEyzO5QDudoZtwxADMijx/aZg
cVv5B895gvwWg0amWUpx3Zi7+nifDbhKvw5jiisiXs5aS3Ds14RGfwydRNgRv93/
6TTmvfzRLhQbzyAEVEPf46atuBbppUzLUocXuPCF4LRqX2+aVuD0+GDDEHLs5E70
EsN/6ACUHDvexn5eUngEfMncyroOMw==
=WJec
-----END PGP SIGNATURE-----

--Sig_/doeHGov9QMIdfFOG3F41NZW--
