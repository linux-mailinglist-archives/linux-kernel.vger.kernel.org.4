Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1510264FF0F
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Dec 2022 15:10:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbiLROKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Dec 2022 09:10:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbiLROKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Dec 2022 09:10:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16CB78FF3
        for <linux-kernel@vger.kernel.org>; Sun, 18 Dec 2022 06:10:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9AA69B80066
        for <linux-kernel@vger.kernel.org>; Sun, 18 Dec 2022 14:10:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 815E7C433EF;
        Sun, 18 Dec 2022 14:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671372607;
        bh=lMmomLT/+/qODfP0owxRBMpyUJhoTYwHlMmWExbvlP4=;
        h=Date:From:To:Cc:Subject:From;
        b=LhobgyqYu307HL3zkYswvcxBdshVARaPyG8mqPnANaw3teFr+nqKlanhH8/Y8KPUc
         BJf47S6DlDz8jdw0d2633pHz1aUUbvM8R5DugAFAOv+/jAR6OHx5Djs1WHsUAL7HpF
         pS5f83T8TS6gmYQ4uGgXu55sWVgXD5F2N087JdJxkj//sZcdoxfCEgbVXQky1Zpm39
         TToNncr2qTFiMPMl7L3oWHAv72qCRsbTG9eoWJek1ntLLLE+VimOm1Cxs1ywcukg3g
         JBjUbbgJnBTZe/aqZaMz9lZ3ldBgz+WvfOUJVwn+BM3XoHWAWkpYX2Q1kPn0SwaFnX
         MonoVojZjfDgg==
Date:   Sun, 18 Dec 2022 19:40:03 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: Soundwire updates for 6.2
Message-ID: <Y58fOznGkV+MjdQR@matsya>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5aPRpzzwu9WLoKWt"
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5aPRpzzwu9WLoKWt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linus,

Please pull to receive updates for SoundWire subsystem for 6.2. This
include bunch of Intel driver code reorganization and support for qcom
v1.7.0 controller. The pull is based on tag soundwire-6.1-fixes pulled
by you earlier.

The following changes since commit 49a467310dc4fae591a3547860ee04d8730780f4:

  soundwire: qcom: check for outanding writes before doing a read (2022-10-=
28 17:00:38 +0530)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/so=
undwire-6.2-rc1

for you to fetch changes up to 7cbf00bd4142cd88ac7ecbc4ea7b917a220cb721:

  soundwire: intel: split auxdevice to different file (2022-11-23 20:11:49 =
+0530)

----------------------------------------------------------------
soundwire updates for 6.2

 - intel: reorganization of hw_ops callbacks, splitting files etc
 - qcom: support for v1.7.0 qcom controllers

----------------------------------------------------------------
Pierre-Louis Bossart (10):
      soundwire: dmi-quirks: add quirk variant for LAPBC710 NUC15
      soundwire: cadence: rename sdw_cdns_dai_dma_data as sdw_cdns_dai_runt=
ime
      soundwire: cadence: use dai_runtime_array instead of dma_data
      soundwire: intel: start using hw_ops
      soundwire: intel: add debugfs callbacks in hw_ops
      soundwire: intel: add register_dai callback in hw_ops
      soundwire: intel: add bus management callbacks in hw_ops
      soundwire: intel: add link power management callbacks in hw_ops
      soundwire: intel: add in-band wake callbacks in hw_ops
      soundwire: intel: split auxdevice to different file

Srinivas Kandagatla (4):
      soundwire: qcom: remove unused SWRM_SPECIAL_CMD_ID
      soundwire: qcom: make reset optional for v1.6 controller
      dt-bindings: soundwire: qcom: add v1.7.0 support
      soundwire: qcom: add support for v1.7 Soundwire Controller

Srinivasa Rao Mandadapu (1):
      dt-bindings: soundwire: Convert text bindings to DT Schema

Vinod Koul (1):
      Merge branch 'fixes' into next

 .../devicetree/bindings/soundwire/qcom,sdw.txt     | 214 ------
 .../bindings/soundwire/qcom,soundwire.yaml         | 270 ++++++++
 drivers/soundwire/Makefile                         |   2 +-
 drivers/soundwire/cadence_master.c                 |  50 +-
 drivers/soundwire/cadence_master.h                 |   9 +-
 drivers/soundwire/dmi-quirks.c                     |   8 +
 drivers/soundwire/intel.c                          | 769 ++---------------=
----
 drivers/soundwire/intel.h                          |  96 ++-
 drivers/soundwire/intel_auxdevice.c                | 678 ++++++++++++++++++
 drivers/soundwire/intel_auxdevice.h                |  18 +
 drivers/soundwire/intel_init.c                     |   2 +
 drivers/soundwire/qcom.c                           |  25 +-
 include/linux/soundwire/sdw_intel.h                |  44 ++
 sound/soc/sof/intel/hda.c                          |   2 +
 14 files changed, 1237 insertions(+), 950 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/soundwire/qcom,sdw.txt
 create mode 100644 Documentation/devicetree/bindings/soundwire/qcom,soundw=
ire.yaml
 create mode 100644 drivers/soundwire/intel_auxdevice.c
 create mode 100644 drivers/soundwire/intel_auxdevice.h

--=20
~Vinod

--5aPRpzzwu9WLoKWt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmOfHzsACgkQfBQHDyUj
g0dNMA//b2N0thSVF6Gymb1e7kinHsgPIxSaAx9mHoLsh2ZWdq6DwB0h7CvHGOEy
GMV2nsW2/wYYpfT3cNU+3eftT1agRkm3SY81rJrnTl+p8IPaCE83Xd/trXJilD4e
Rzfhed6lJ0PzefDMLB9VfuMvys2dQWvJbsUKjWL1A4i7ZidXbIRibnx99XVB2L+4
51g/YAH+cYxofZTTxSFl28qUIIRDAuTGmrgtd7eHI+Y6sNGXCC+e/Zs87EQlgUUK
yGufWp6OixY2GqMujeKjPB4RPa1K5Ed1r8w+WV/AAwTb0XucwNmQBb9rwCpiU999
hFC34PvjOi00ESkK4Wc6GnIrtmLMPP+0cxQ1P5SRJyTvXAYTvSlTx6WgByfpC5LS
3r9doj95GG3tQzwj6ezSFoSBJJ20JMn+LmiGbEKoBN8dVI3Ah9ouMR+VKpqZcY+x
tqfjB+IvAS/wPwN3NGZdfwxwTL8xr5b7OhttnSDzZT4tncnK2Tq896kIGV8LNBLZ
4bHrjwrqJOM06igM2EVcpjGxhq4sY5DWSYcW6n6yGASka0eialAb/ctfNqBoHmKC
6WDV/r5uaMAiBM5x25zCVkEwitcYG6opwcZX+ABIx7Ufe0TzVDEVChIxbICAsWHQ
DIQ0FLBDO//IEoVYk/H8jnF5lP7bS+lHuE01Ne1aIIrjdiXKIV0=
=7s0y
-----END PGP SIGNATURE-----

--5aPRpzzwu9WLoKWt--
