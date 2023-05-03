Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87B4A6F5697
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 12:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbjECKuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 06:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjECKui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 06:50:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59BB512F
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 03:50:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E6FBE612D4
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 10:50:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0444C433EF;
        Wed,  3 May 2023 10:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683111036;
        bh=raHLGW/5wOoOVfcN05BeVL2g0OOm/nSLn1A5PFvHSwg=;
        h=Date:From:To:Cc:Subject:From;
        b=QJCS10aZl4b5yjmgjHNhFu8sDZ1hnScahyZspM85Ph3yu79mC1PRyyvOdBVa2GP6A
         d6Nkh6xWmPpA7W20tF9zKxa6/m0RCWoIgrcsDb0ZhUABz2FNt229NimP0ivpLxr1sY
         08Z1aGqn6DDXryOcbCGVvXiIMJiNpbm/Ab1s88DHhLOoa1PrBWU7wCfilIuroO1WuZ
         F/IoWHZaXIT3O+uAJf8GGp9BT/ZkCd5d4gNDY2bMNCSdRulm1qt1maHu2QeBqB/tsJ
         AoOatPcAxksR1TepmyyaYRc2/aJ4Sjw9EEHmnF0l2Qa7+90suyIOcoQm5mQ5D44/gF
         UTm/dKYXzr4bg==
Date:   Wed, 3 May 2023 16:20:32 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]; soundwire updates for v6.4
Message-ID: <ZFI8eBCZ1Nx6IpUk@matsya>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ltne6evhRDaeIHdT"
Content-Disposition: inline
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ltne6evhRDaeIHdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linus,

Please pull to receive updates for soundwire subsystem. This features
AMD soundwire controller driver, bunch of Intel changes for future
platform support, sdw API updates etc.

The following changes since commit fe15c26ee26efa11741a7b632e9f23b01aca4cc6:

  Linux 6.3-rc1 (2023-03-05 14:52:03 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/so=
undwire-6.4-rc1

for you to fetch changes up to 67572c8dc64412880b81d4bbc2f354dd5eddaa7d:

  soundwire: intel_auxdevice: improve pm_prepare step (2023-04-12 15:36:55 =
+0530)

----------------------------------------------------------------
soundwire updates for 6.4-rc1

 - Support for AMD soundwire controller
 - Intel driver updates to support future platforms
 - Core API sdw_nread/nwrite_no_pm updates to handle page boundaries

----------------------------------------------------------------
Charles Keepax (3):
      soundwire: bus: Remove now outdated comments on no_pm IO
      soundwire: bus: Update kernel doc for no_pm functions
      soundwire: bus: Update sdw_nread/nwrite_no_pm to handle page boundari=
es

Eugene Huang (1):
      soundwire: dmi-quirks: add remapping for Intel 'Rooks County' NUC M15

Krzysztof Kozlowski (3):
      soundwire: qcom: correct setting ignore bit on v1.5.1
      soundwire: qcom: define hardcoded version magic numbers
      soundwire: qcom: gracefully handle too many ports in DT

Pierre-Louis Bossart (20):
      soundwire: intel: move common definitions to header file
      soundwire: intel: remove stale/misleading comment
      soundwire: intel: remove PDI-level restrictions on rates and formats
      soundwire: intel: remove useless abstraction
      soundwire: intel: simplify sync_go sequence
      soundwire: intel: add sync_arm/sync_go to ops
      soundwire: intel: use indirection before moving bus start/stop sequen=
ces
      soundwire: intel: move bus common sequences to different file
      soundwire: intel: add abstraction for cmdsync check
      soundwire: intel: move bank switch routine to common intel_bus_common=
=2Ec
      soundwire: cadence: remove CDNS_MCP_CONFIG_SSPMOD
      soundwire: cadence: add helpers to access IP_MCP registers
      soundwire: cadence: split access to IP_MCP_CONFIG fields
      soundwire: cadence: split access to IP_MCP_CONTROL fields
      soundwire: cadence: split access to IP_MCP_CMDCTRL fields
      soundwire: cadence: change access to IP_MCP_CMD_BASE
      soundwire: stream: remove bus->dev from logs on multiple buses
      soundwire: stream: uniquify dev_err() logs
      soundwire: intel: don't save hw_params for use in prepare
      soundwire: intel_auxdevice: improve pm_prepare step

Richard Fitzgerald (2):
      soundwire: bandwidth allocation: Use hweight32() to calculate set bits
      soundwire: bus: Fix unbalanced pm_runtime_put() causing usage count u=
nderflow

Shuming Fan (1):
      soundwire: stream: restore cumulative bus bandwidth when compute_para=
ms callback failed

Vijendar Mukunda (8):
      soundwire: export sdw_compute_slave_ports() function
      soundwire: amd: Add support for AMD Manager driver
      soundwire: amd: register SoundWire manager dai ops
      soundwire: amd: enable build for AMD SoundWire manager driver
      soundwire: amd: add SoundWire manager interrupt handling
      soundwire: amd: add runtime pm ops for AMD SoundWire manager driver
      soundwire: amd: handle SoundWire wake enable interrupt
      soundwire: amd: add pm_prepare callback and pm ops support

 drivers/soundwire/Kconfig                        |   10 +
 drivers/soundwire/Makefile                       |    7 +-
 drivers/soundwire/amd_manager.c                  | 1208 ++++++++++++++++++=
++++
 drivers/soundwire/amd_manager.h                  |  258 +++++
 drivers/soundwire/bus.c                          |  112 +-
 drivers/soundwire/bus.h                          |   20 +-
 drivers/soundwire/cadence_master.c               |  139 ++-
 drivers/soundwire/cadence_master.h               |    5 +-
 drivers/soundwire/dmi-quirks.c                   |   25 +
 drivers/soundwire/generic_bandwidth_allocation.c |   15 +-
 drivers/soundwire/intel.c                        |  336 +-----
 drivers/soundwire/intel.h                        |   67 ++
 drivers/soundwire/intel_auxdevice.c              |    6 +-
 drivers/soundwire/intel_bus_common.c             |  259 +++++
 drivers/soundwire/qcom.c                         |   20 +-
 drivers/soundwire/stream.c                       |   20 +-
 include/linux/soundwire/sdw_amd.h                |  109 ++
 include/linux/soundwire/sdw_intel.h              |   11 +
 18 files changed, 2189 insertions(+), 438 deletions(-)
 create mode 100644 drivers/soundwire/amd_manager.c
 create mode 100644 drivers/soundwire/amd_manager.h
 create mode 100644 drivers/soundwire/intel_bus_common.c
 create mode 100644 include/linux/soundwire/sdw_amd.h

--=20
~Vinod

--ltne6evhRDaeIHdT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmRSPHgACgkQfBQHDyUj
g0eKNg//WDEssSQyRlpGZG+tjXIYFanpkvDjjGQlr6p2dJbUdIH7lrzyIIW3QfZd
04qeyKua87LKtopaTyZ67dCSPQ5hdiG3XeoPaKTpn+PvcKsOk48s27dbzlVx6K31
Yadh2y1pDSj8wYFH2x0qyyOM9gKzwI+eaCej41MPVgo3G7KAJ5jSy39vx1jLbta8
oVS0yw/HOxuasbGbz9o7suxi2KGjdQe5K5QS9VKgvXtRK8S4ELzSoGN1YKRvKobl
zBAHzqy6YulCQd0NPUuc8F+uOuYioHm82Wb+8RMsxsDbToK5dT1hkDD25nsoeZwY
uORg7DeikVzt+sM00AtRjRsc4pHtYdsMmEu552NI9OE0IKa7SQfs4Sh0yXpOSxfw
xbIwFU9mN4E7n3EkP54jt9rM1Ajn9a84djWL2kzuoh22odBU5uVftDnIeToRTGer
vWvJ8MF2LoZhDuTcx0QiN7C79zY1LqGnW3kMPNlzNm5O0i0zIJVM201XBsc/5whI
SJ6NWqGI63qibCzP/080p8V5SxtbY2z3kzerxEYiecRZYZJFFGam5/nxzIgfvMfS
oZBHYGQo5Z7U7QOAInrXKo2yaTIDwZNAeiOut5IXz07aElIIy9Tl0p/1q1eC527Z
7wohh/9kuzETD3YXJuY1xXyQ/VbcjCkNgt3cYVzyOpjLTqYUyNk=
=ziY1
-----END PGP SIGNATURE-----

--ltne6evhRDaeIHdT--
