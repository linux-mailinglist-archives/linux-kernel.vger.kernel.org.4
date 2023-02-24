Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1AA66A1D25
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 14:53:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbjBXNxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 08:53:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjBXNxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 08:53:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 707A020049
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 05:53:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 02DCC618D8
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 13:53:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5CC7C433D2;
        Fri, 24 Feb 2023 13:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677246788;
        bh=j1lRIIFwUewZc1+d+gHqvk0VXGdTAT0UfazS3PjzUmY=;
        h=Date:From:To:Cc:Subject:From;
        b=t4GDcXdGUtKWCkIkjcJURARTKLMmUTDyir9KNLE535taRM0VpKxtm4uYAgJwuA4yy
         vOb5KuDoHoAk9PWQ0HOMVew/c+QZsUXK0q0U/HN9D/hBeLQAvEz0CthkMqW7qq8YQa
         ZE7VYKIcLA4kj20l2HJ2S3cw1ZclOEGjeuGKrxbg2jv4GaNVdFv2kyYtFw6XuZTok4
         2HJj/19gF7o9BKiNd552rYj2AG6SSadTp9Y0KnBcHCesWReXxsOonN+QJnLtPmKLvT
         5TSg+T4Hm2uVsY3rxErVPd9XbDnJYbh09KdKClEyv7s9g6fd+/PNZwrLG37df551UO
         T6MJUdX8TT6XA==
Date:   Fri, 24 Feb 2023 19:23:04 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: Soundwire updates for v6.3
Message-ID: <Y/jBQIZi8JJFSkaN@matsya>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Ls8CglPlf3ZT6bV2"
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Ls8CglPlf3ZT6bV2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linus,

Please pull to receive updates for SoundWire subsystem for v6.3. This is
small updates which features bit of core changes and driver updates in
Intel and cadence driver.

The following changes since commit 1b929c02afd37871d5afb9d498426f83432e71c2:

  Linux 6.2-rc1 (2022-12-25 13:41:39 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/so=
undwire-6.3-rc1

for you to fetch changes up to 66f95de7c13be5e442d8ed4cf00e13f8dbdc1315:

  soundwire: cadence: further simplify low-level xfer_msg_defer() callback =
(2023-01-31 20:01:52 +0530)

----------------------------------------------------------------
soundwire updates for 6.3

  - Core:
	- sdw_transfer_defer() API change to dropan argument
	- Reset page address rework
	- Exporting sdw_nwrite_no_pm and sdw_nread_no_pm APIs

  - Drivers:
	- Cadence and related intel driver updates for FIFO handling and
	  low level msg transfers

----------------------------------------------------------------
Charles Keepax (3):
      soundwire: Provide build stubs for common functions
      soundwire: debugfs: Switch to sdw_read_no_pm
      soundwire: stream: Move remaining register accesses over to no_pm

Gaosheng Cui (1):
      soundwire: cadence: remove unused sdw_cdns_master_ops declaration

Pierre-Louis Bossart (7):
      soundwire: intel: remove DAI startup/shutdown
      ASoC/soundwire: remove is_sdca boolean property
      soundwire: enable optional clock registers for SoundWire 1.2 devices
      soundwire: stream: use consistent pattern for freeing buffers
      soundwire: bus: remove sdw_defer argument in sdw_transfer_defer()
      soundwire: cadence: use directly bus sdw_defer structure
      soundwire: cadence: further simplify low-level xfer_msg_defer() callb=
ack

Richard Fitzgerald (6):
      soundwire: cadence: Don't overflow the command FIFOs
      soundwire: cadence: Remove wasted space in response_buf
      soundwire: cadence: Drain the RX FIFO after an IO timeout
      soundwire: bus_type: Avoid lockdep assert in sdw_drv_probe()
      soundwire: bus: Don't zero page registers after every transaction
      soundwire: bus: Remove unused reset_page_addr() callback

Simon Trimmer (1):
      soundwire: bus: export sdw_nwrite_no_pm and sdw_nread_no_pm functions

 drivers/soundwire/bus.c             |  56 +++++------------
 drivers/soundwire/bus.h             |   3 +-
 drivers/soundwire/bus_type.c        |   9 +--
 drivers/soundwire/cadence_master.c  |  80 ++++++++++++-----------
 drivers/soundwire/cadence_master.h  |  22 ++++---
 drivers/soundwire/debugfs.c         |  13 +++-
 drivers/soundwire/intel.c           |  27 --------
 drivers/soundwire/intel_auxdevice.c |   1 -
 drivers/soundwire/stream.c          |  38 +++++------
 include/linux/soundwire/sdw.h       | 122 ++++++++++++++++++++++++++++++--=
----
 sound/soc/codecs/rt1316-sdw.c       |   1 -
 sound/soc/codecs/rt1318-sdw.c       |   1 -
 sound/soc/codecs/rt711-sdca-sdw.c   |   1 -
 13 files changed, 207 insertions(+), 167 deletions(-)
--=20
~Vinod

--Ls8CglPlf3ZT6bV2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmP4wT8ACgkQfBQHDyUj
g0czCg/+OuEkydc0F+n4yJ9p8wMmfZ7ROwTkMcZ3fhgmVdvcEubPp/FEughDXnf4
/14lsP1m71m34PDVwcScsqQPVycrcn+41mCpkiQWGW+wFykQGx6lI/x/0AqYXbu2
F9803wgg5j0KUNqrXBCAx7B7WXKDZDQPIEHDvPCuqdND21Jn6lnkA1CBy5cfgSHB
j+yHtqcnLvDbNSZOCKID5hV9LOSM3Jp97EnrgtCfryrNd5JCD4L3WkL7333fnNce
PFPKDTJqG6XWF35556tSb23D6jd7IQP6NJghAspoo8htawC9PQT0MAG6tNcsrxfE
dC9z9hKCTc5JEbZdIFaLQM95huYEKHbWXgnMH8fD02XzuK02prcAH3d+jFh5BJ0T
mBtZ44lJ0RrGvaqtw4LLuylRJKR0JR0LZNW6d6/7KkRC0ZAR2yE4YeVfTpE4nzP7
ToEZTiHKbEKvFV2EXIJn57rJHVjwpJTpi2CEkK90iQwmcwWxBbFFoQS1RAFbSXM4
DfxiTxzDwozLn/EdimB8l/A0rnFQ/F1vcZmRMsOqiN+yzifxbdUE7vq+5LC3HVmq
cwsHq9trHsLMuLsaCvCufxrn0I1tR1vQuL/ZK39bkJgBIjvXCV6T+GhMftDmKLSg
JA99D7uxBN8TQqpES6gsP/Z/EolAMtAuG6dxPSPHNFg26VHqVnE=
=LAne
-----END PGP SIGNATURE-----

--Ls8CglPlf3ZT6bV2--
