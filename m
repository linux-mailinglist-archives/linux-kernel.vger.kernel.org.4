Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E52305F78C5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 15:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbiJGNTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 09:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiJGNTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 09:19:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE386CF866
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 06:19:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 67CAEB822E6
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 13:19:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BB02C433C1;
        Fri,  7 Oct 2022 13:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665148750;
        bh=rjZ8VRh+9XrA5unwxSqZH1nchcvi1vaFClTkwRoMllE=;
        h=Date:From:To:Cc:Subject:From;
        b=HvNnegBA/J7KLGiArW0qR0pCRecbqth7GaQhKnE2jcC6qgv3C33QbXDkZ5fH3lZpr
         LF/sQzsqraT+3zuAg+pU7J/YanBfTKVRMih5lPm1xxEPQuoOddqguzM75StetrEp9k
         8pRlfCjXrKPOC9v+zStoAOHxrwLlYbsDE/xyGMDKo4Ry9cD7VdwZgwF3b56Saseiw5
         vHf2NVnqiaMLU3jpe+8TirQzdKyxmZruUTkE2yeLDxgbFZTinMJFDn8C5fLcWSdgfr
         MOvKtvx01JgWAgQueT5an1o1GNc8zj4LsjNh4XUuhwgx0i7ZYC/WLnj+DDOlK74wiN
         1G+buptL4ZrEg==
Date:   Fri, 7 Oct 2022 18:49:06 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: SoundWire subsystem updates for v6.1-rc1
Message-ID: <Y0AnSpbH3B9U0H8I@matsya>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="97CL+fIA6ey0rxtP"
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--97CL+fIA6ey0rxtP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linus,

Here is the soundwire subsystem pull request for you. Please pull to
receive updates for Intel, Cadence and Qualcomm drivers.

The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:

  Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/so=
undwire-6.1-rc1

for you to fetch changes up to 503ae285944a5e99ad3e0c36852ffe2680288418:

  soundwire: intel: add helper to stop bus (2022-09-20 10:39:23 +0530)

----------------------------------------------------------------
soundwire updates for 6.1-rc1

 - Pierre-Louis Bossart did another round of Intel driver cleanup to prepare
   for future code reorg which is expected in next cycle
 - Richard Fitzgerald provided bus unattach notifications processing during
   re-enumeration along with Cadence driver updates for this.
 - Srinivas Kandagatla added  Qualcomm driver updates to handle device0 sta=
tus

----------------------------------------------------------------
Khalid Masum (1):
      soundwire: intel: Remove unnecessary TODO

Pierre-Louis Bossart (28):
      soundwire: dmi-quirks: add remapping for HP Omen 16-k0005TX
      soundwire: bus: remove use of __func__ in dev_dbg
      soundwire: intel: remove use of __func__ in dev_dbg
      soundwire: bus: rename sdw_ida as sdw_bus_ida
      soundwire: bus: allow device number to be unique at system level
      soundwire: intel: set dev_num_ida_min
      soundwire: intel: cleanup definition of LCOUNT
      soundwire: intel: regroup definitions for LCTL
      soundwire: intel: remove IPPTR unused definition
      soundwire: intel: cleanup SHIM SYNC
      soundwire: intel: remove unused PDM capabilities
      soundwire: intel: add comment for control stream cap/chmap
      soundwire: intel: cleanup PCM stream capabilities
      soundwire: intel: cleanup PCM Stream channel map and channel count
      soundwire: intel: cleanup IO control
      soundwire: intel: cleanup AC Timing Control
      soundwire: intel: cleanup WakeEnable and WakeStatus
      soundwire: intel: fix error handling on dai registration issues
      soundwire: intel: simplify flow and use devm_ for DAI registration
      soundwire: intel: move DAI registration and debugfs init earlier
      soundwire: intel: move all PDI initialization under intel_register_da=
i()
      soundwire: intel: remove clock_stop parameter in intel_shim_init()
      soundwire: intel: move shim initialization before power up/down
      soundwire: intel: remove intel_init() wrapper
      soundwire: intel: simplify read ops assignment
      soundwire: intel: introduce intel_shim_check_wake() helper
      soundwire: intel: introduce helpers to start bus
      soundwire: intel: add helper to stop bus

Richard Fitzgerald (9):
      soundwire: bus: Don't lose unattach notifications
      soundwire: bus: Don't re-enumerate before status is UNATTACHED
      soundwire: cadence: Fix lost ATTACHED interrupts when enumerating
      soundwire: bus: Don't exit early if no device IDs were programmed
      soundwire: cadence: Don't overwrite msg->buf during write commands
      soundwire: bus: Fix wrong port number in sdw_handle_slave_alerts()
      soundwire: cadence: Write to correct address for each FIFO chunk
      soundwire: cadence: Fix error check in cdns_xfer_msg()
      soundwire: cadence: Simplify error paths in cdns_xfer_msg()

Simon Trimmer (1):
      soundwire: cadence: fix updating slave status when a bus has multiple=
 peripherals

Srinivas Kandagatla (2):
      soundwire: qcom: update status from device id 1
      soundwire: qcom: do not send status of device 0 during alert

Srinivasa Rao Mandadapu (1):
      soundwire: qcom: Update error prints to debug prints

 drivers/soundwire/bus.c             |  94 +++--
 drivers/soundwire/cadence_master.c  | 104 ++---
 drivers/soundwire/dmi-quirks.c      |  27 ++
 drivers/soundwire/intel.c           | 734 ++++++++++++++++++--------------=
----
 drivers/soundwire/intel_init.c      |   2 +-
 drivers/soundwire/qcom.c            |   9 +-
 include/linux/soundwire/sdw.h       |   4 +
 include/linux/soundwire/sdw_intel.h |  63 ++--
 8 files changed, 557 insertions(+), 480 deletions(-)

--=20
~Vinod

--97CL+fIA6ey0rxtP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmNAJ0kACgkQfBQHDyUj
g0erLw/+PkI/8Gp1qKwfzH/bwLyacpkGb/d5BHscNuL3TARIIJGCbTUNufQlwDC3
qNFS0KppzF2thVO4XH8TvGDSIc92y8y3wa3hF6BPiEIS8Z1/WgjyvOj7UqdbJOfZ
dZzf2hGTv8cFZIm1V3LP57perbaR6gQZMnYN+P5g1+vBVOBCnqC4/BCCTSKO72Ct
MAZFH5ExoUPyQfZ9c5R2whobowXHL8WPZs0eK401pIhbBlGAqKAsosO0X3Vr5wxh
Hvg4jKL69pNIwbXUgXDkrjdxt7TZmNyZ2eo+yxT1Rb85PZ8Jt/GDkecmht7Aai9T
Qg2D3twd5jQQWwhIF4K+UlxMf/SwwQm+DEFGRq3uTHKDjZA9bDAI5Vv/7cdRnRpo
FO6YuTXpzjTkuvcJASO2k/IfXGFTtHLPWyKrId4sxeFjmzrIHTTqmW0a/7HUVsxh
hLuwCg5ZCnhkkFBIZ+dYyDdVezQPQsSw8Ryy/a0aA9v4Ps1EqVGmEayFVBI7lNvq
+nAceAK6DOn7F8bNP7GAMXLkV+sfQsjuEIO/N0x2gR+xM85XnhLdG7PJKYWxMFVr
7ZAc84zeB4AYqV4vdqJ8p+k9ca4LBV5M7MfWv46NEzSEosxnnmc/6wcsTRdIor98
pHa/tOqqUmr3NNYjgf24evS1eaR0RU2QdjdPu1oU9XndBPu7x6g=
=T7S/
-----END PGP SIGNATURE-----

--97CL+fIA6ey0rxtP--
