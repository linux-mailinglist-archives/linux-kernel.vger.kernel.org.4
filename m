Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2F8747E6C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 09:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231886AbjGEHnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 03:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbjGEHnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 03:43:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C399EE6E
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 00:43:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5369961449
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 07:43:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3511FC433C7;
        Wed,  5 Jul 2023 07:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688543011;
        bh=5h5EH97WbSMzl/kM2e2lEVC37p17Q+zgSqIjLBZKolM=;
        h=Date:From:To:Cc:Subject:From;
        b=d7BdqQQ4qDVRuA5wmytLgCq4CtgR9idvw4uEBM5aEGIMVcFqkdJNQP88QdWtLVrYQ
         pcmhv6v5Cu4CzJ+2mnBBdOEdMt0Egtp/eBNZrrH96L4PQGWCt0m5kbtH6jZlEpCZmE
         Kl7UT1ahRXfa7ekYyLRSePhL8eMoeVTSsSRBiQSr9js776gdt4SeY/AMHVxxgX9Rrg
         tm7K7jCkfoSrduDDJKLwDCuhEBSx/dvLFfKiok74ZjIQ4/YWqrJBggF3MjjSuMe28M
         IW41b++cY0LnWyy7wnY/jCSLyMV9M/ZP5X+M/1Ol7D1ee+f/bBaI/BAVpiPiQOireb
         ffG7o2kx/HGUg==
Date:   Wed, 5 Jul 2023 13:13:27 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: soundwire updates for v6.5-rc1
Message-ID: <ZKUfH+9OswEIGEyR@matsya>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6o3kjr3wHop6arOX"
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6o3kjr3wHop6arOX
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linus,

Please pull to receive the soundwire subsystem updates which include
support for Qualcomm controller version, Intel upcoming platform support
and stream handling updates etc

Please note this is based on soundwire fixes pull request already
merged.

The following changes since commit 58d95889f3c2064c6139ee94bb0e4d86e1ad4eab:

  soundwire: stream: Add missing clear of alloc_slave_rt (2023-06-08 17:08:=
04 +0530)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/so=
undwire-6.5-rc1

for you to fetch changes up to a4857d1afdd1fa7ff763e1d07b1c2db521a5f9b1:

  soundwire: stream: Make master_list ordered to prevent deadlocks (2023-06=
-21 16:31:45 +0530)

----------------------------------------------------------------
soundwire updates for 6.5

 - Stream handling and slave alert handling
 - Qualcomm Soundwire v2.0.0 controller support
 - Intel ACE2.x initial support and code reorganization

----------------------------------------------------------------
Arnd Bergmann (1):
      soundwire: intel_ace2x: fix SND_SOC_SOF_HDA_MLINK dependency

Chao Song (1):
      soundwire: intel: read AC timing control register before updating it

Charles Keepax (5):
      soundwire: bus: Don't filter slave alerts
      soundwire: bandwidth allocation: Remove pointless variable
      soundwire: stream: Remove unneeded checks for NULL bus
      soundwire: stream: Invert logic on runtime alloc flags
      soundwire: stream: Remove unnecessary gotos

Krzysztof Kozlowski (11):
      dt-bindings: soundwire: qcom: add Qualcomm Soundwire v2.0.0
      dt-bindings: soundwire: qcom: add 16-bit sample interval
      soundwire: qcom: allow 16-bit sample interval for ports
      soundwire: qcom: use consistently 'ctrl' as state variable name
      soundwire: qcom: prepare for handling different register layouts
      soundwire: qcom: add support for v2.0.0 controller
      soundwire: qcom: use tabs for indentation in defines
      soundwire: qcom: drop unused struct qcom_swrm_ctrl members
      soundwire: qcom: fix unbalanced pm_runtime_put()
      soundwire: debugfs: fix unbalanced pm_runtime_put()
      soundwire: qcom: fix storing port config out-of-bounds

Pierre-Louis Bossart (30):
      ASoC: SOF: Intel: shim: add enum for ACE 2.0 IP used in LunarLake
      soundwire: intel: add ACE2.x SHIM definitions
      soundwire: intel_ace2x: add empty new ops for LunarLake
      soundwire/ASOC: Intel: update offsets for LunarLake
      soundwire: intel/cadence: set ip_offset at run-time
      ASoC/soundwire: intel: pass hdac_bus pointer for link management
      soundwire: intel: add eml_lock in the interface for new platforms
      ASoC: SOF: Intel: hda: retrieve SoundWire eml_lock and pass pointer
      soundwire: intel_init: use eml_lock parameter
      soundwire: intel_ace2x: add debugfs support
      soundwire: intel_ace2x: add link power-up/down helpers
      soundwire: intel_ace2x: set SYNCPRD before powering-up
      soundwire: intel_ace2x: configure link PHY
      soundwire: intel_ace2x: add DAI registration
      soundwire: intel_ace2x: add sync_arm/sync_go helpers
      soundwire: intel_ace2x: use common helpers for bus start/stop
      soundwire: intel_ace2x: enable wake support
      soundwire: intel_ace2x: add check_cmdsync_unlocked helper
      soundwire: bus: add new manager callback to deal with peripheral enum=
eration
      soundwire: intel_ace2x: add new_peripheral_assigned callback
      soundwire: intel_ace2x: add pre/post bank switch callbacks
      ASoC: SOF/soundwire: re-add substream in params_stream structure
      soundwire: intel: remove .trigger callback implementation
      soundwire: intel: use substream for .trigger callback
      soundwire: intel: remove .free callback implementation
      soundwire: intel: use substream for .free callback
      soundwire: intel_bus_common: update error log
      soundwire: intel_bus_common: enable interrupts last
      soundwire: intel/cadence: update hardware reset sequence
      soundwire: cadence: revisit parity injection

Richard Fitzgerald (2):
      soundwire: bus: Prevent lockdep asserts when stream has multiple buses
      soundwire: stream: Make master_list ordered to prevent deadlocks

Srinivas Kandagatla (3):
      soundwire: qcom: wait for fifo to be empty before suspend
      soundwire: qcom: add software workaround for bus clash interrupt asse=
rtion
      soundwire: qcom: set clk stop need reset flag at runtime

Uday M Bhat (1):
      soundwire: debugfs: Add missing SCP registers

Uwe Kleine-K=F6nig (1):
      soundwire: amd: Improve error message in remove callback

Vinod Koul (1):
      Merge branch 'fixes' into next

 .../bindings/soundwire/qcom,soundwire.yaml         |  39 +-
 drivers/soundwire/Kconfig                          |   1 +
 drivers/soundwire/Makefile                         |   3 +-
 drivers/soundwire/amd_manager.c                    |   9 +-
 drivers/soundwire/bus.c                            |  30 +-
 drivers/soundwire/cadence_master.c                 |  50 ++-
 drivers/soundwire/cadence_master.h                 |   5 +
 drivers/soundwire/debugfs.c                        |  12 +-
 drivers/soundwire/generic_bandwidth_allocation.c   |  10 +-
 drivers/soundwire/intel.c                          |  57 +--
 drivers/soundwire/intel.h                          |  16 +
 drivers/soundwire/intel_ace2x.c                    | 393 ++++++++++++++++
 drivers/soundwire/intel_ace2x_debugfs.c            | 147 ++++++
 drivers/soundwire/intel_auxdevice.c                |  17 +
 drivers/soundwire/intel_bus_common.c               |  96 ++--
 drivers/soundwire/intel_init.c                     |  21 +-
 drivers/soundwire/qcom.c                           | 500 ++++++++++++++---=
----
 drivers/soundwire/stream.c                         | 161 ++++---
 include/linux/soundwire/sdw.h                      |   6 +-
 include/linux/soundwire/sdw_intel.h                |  94 +++-
 sound/soc/sof/intel/hda.c                          |  33 +-
 sound/soc/sof/intel/shim.h                         |   1 +
 22 files changed, 1293 insertions(+), 408 deletions(-)
 create mode 100644 drivers/soundwire/intel_ace2x.c
 create mode 100644 drivers/soundwire/intel_ace2x_debugfs.c

--=20
~Vinod

--6o3kjr3wHop6arOX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmSlHx8ACgkQfBQHDyUj
g0ffpRAAjHhzOikidKkI3BYc5DKl0sJhZY2aCXRt8qwur5318m2meWIP9OdQBn56
Lug8crQ+LOj4zsyHC2XsYQRxZ67vNask6A3cIOSCm029kN0QNqlUohbv4B5SQIsP
no4jy5G6Ond44RiILtofDIQUqA+svcRpC/5TKVZ+pNdtT6rmqVGdylfXozqKVHOF
9Bly2rIzZq0KJEMDiRnIeGACROidEVSiaCAgxR1oFxYWy7wW+rhaZA5OWLtGyE5v
Rf7rdm8n+cYF3+BeFdPqJqFDsShgyuab3I4zqlAE9bLceU6wzPa+4uX0fMJ7Hlv0
CwGiZ+iXkZcSjA4t7qv2xx/1fRAOTAyVnKwfoI6SplGt8LJmQxUT6imtkvUgs4iC
Qvk7jknD3vi9DP5xdBBrVVTUONEqNLXDIxPYhL7lV4CskG8wRYNoEnZMdjAHRW6W
HFI69S908QbtfOTHCnxyvwTzTZDNcjXaZ6ZqKSS3njRzeQmGk6jkA0/Pcbgj97+7
H+HK9kG2MxHJJewKn0/uJEFoj96Ask0mxifuHMD9Ltobzj8sjGxdi9dGmL2hYB4F
aX4gW9i5e95rYvXjDdK2Cs9Koq63n3iwuSQq/HpfJjrkqh2tl9uVbjRfs5Ar7KyA
uawRZ08fFzaCncbqn3yxY/xrV8LPmCeJ04f4W3JiucoMlj4fh8I=
=w/am
-----END PGP SIGNATURE-----

--6o3kjr3wHop6arOX--
