Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECAF96497F3
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 03:30:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbiLLCad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 21:30:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiLLCaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 21:30:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CF1265A6
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 18:30:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3A7CFB80B3C
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 02:30:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF5F4C433EF;
        Mon, 12 Dec 2022 02:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670812227;
        bh=SUajL3u9pLdX2ZmC9K7q3rHAyWiQVdNPsqS1Q0dx42E=;
        h=Date:From:To:Cc:Subject:From;
        b=QZ3Gx85966ze7370Cn6IZhv2zQtO5zzclXUAkMMeMbYJsiSe+nnAqqz4lA6r8NquP
         yFms1ecqwuMU7c9czAXHgVQtf+e0YYOEy99hkZ78X/Uc8wc82/t61gYt4qPbe435VL
         /3kDU2WZzqzE9GoFFQbDPmoA8kP9MP3XCWiEsXX/ofhQjt+wpugcSN7uBpEpCQTQEB
         DQUwyGke5/dCEyL1j+65Ajkg/Esy0bUP7xMFYqBN0yEOq6gLPlBSOyfp5VM4vjRJQ/
         ZW7A+kSRRylEygwb6vx5CvFyCnVo2I24KMEBPVnR7CMODnn1oCJnnLce/PADKLpSEj
         cX9+sOz+WLkDw==
Date:   Mon, 12 Dec 2022 10:30:23 +0800
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     pmalani@chromium.org, bleung@chromium.org, groeck@chromium.org,
        tzungbi@kernel.org, linux-kernel@vger.kernel.org,
        chrome-platform@lists.linux.dev
Subject: [GIT,PULL] chrome-platform changes for v6.2
Message-ID: <Y5aSPxsxWqmkstFb@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ZfTIS9a9xhGZ53AG"
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZfTIS9a9xhGZ53AG
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Linus,

Please pull chrome-platform updates for v6.2.

Thanks,
TzungBi


The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc780:

  Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git=
 tags/tag-chrome-platform-for-v6.2

for you to fetch changes up to 9a8aadcf0b459c1257b9477fd6402e1d5952ae07:

  platform/chrome: cros_ec_typec: zero out stale pointers (2022-12-08 09:44=
:48 +0800)

----------------------------------------------------------------
chrome platform changes for 6.2

* New drivers

  - Driver cros_hps_i2c for ChromeOS human presence sensor.

* Cleanups

  - Add missing property in dt-binding example.
  - Update the availability of properties in dt-binding.
  - Separate dt-binding for ChromeOS fingerprint sensor.

* Improvements

  - Set PROBE_PREFER_ASYNCHRONOUS for some drivers for shortening boot time.

* Fixes

  - Fix an use-after-free in cros_ec_typec.

* Minor fixes and cleanups

----------------------------------------------------------------
Brian Norris (6):
      platform/chrome: cros_ec_lpc: Move mec_init to device probe
      platform/chrome: cros_ec_lpc: Mark PROBE_PREFER_ASYNCHRONOUS
      platform/chrome: cros_ec_debugfs: Set PROBE_PREFER_ASYNCHRONOUS
      platform/chrome: cros_ec_lightbar: Set PROBE_PREFER_ASYNCHRONOUS
      platform/chrome: cros_ec_spi: Set PROBE_PREFER_ASYNCHRONOUS
      platform/chrome: cros_ec_lpc: Force synchronous probe

Christophe JAILLET (1):
      platform/chrome: Use kstrtobool() instead of strtobool()

Dan Callaghan (2):
      platform/chrome: add a driver for HPS
      platform/chrome: cros_hps_i2c: make remove callback return void

Stephen Boyd (2):
      dt-bindings: cros-ec: Reorganize and enforce property availability
      dt-bindings: cros-ec: Add ChromeOS fingerprint binding

Tzung-Bi Shih (1):
      platform/chrome: cros_ec_lpc_mec: remove cros_ec_lpc_mec_destroy()

Uwe Kleine-K=F6nig (1):
      platform/chrome: cros_ec: Convert to i2c's .probe_new()

Victor Ding (1):
      platform/chrome: cros_ec_typec: zero out stale pointers

Yuan Can (1):
      platform/chrome: cros_usbpd_notify: Fix error handling in cros_usbpd_=
notify_init()

 .../bindings/chrome/google,cros-ec-typec.yaml      |   1 +
 .../chrome/google,cros-kbd-led-backlight.yaml      |   1 +
 .../bindings/extcon/extcon-usbc-cros-ec.yaml       |   1 +
 .../bindings/i2c/google,cros-ec-i2c-tunnel.yaml    |   1 +
 .../devicetree/bindings/mfd/google,cros-ec.yaml    | 103 +++++++++++--
 .../bindings/pwm/google,cros-ec-pwm.yaml           |   1 +
 .../regulator/google,cros-ec-regulator.yaml        |   1 +
 .../bindings/sound/google,cros-ec-codec.yaml       |   1 +
 MAINTAINERS                                        |   6 +
 drivers/platform/chrome/Kconfig                    |  10 ++
 drivers/platform/chrome/Makefile                   |   1 +
 drivers/platform/chrome/cros_ec_debugfs.c          |   1 +
 drivers/platform/chrome/cros_ec_i2c.c              |   5 +-
 drivers/platform/chrome/cros_ec_lightbar.c         |   4 +-
 drivers/platform/chrome/cros_ec_lpc.c              |  15 +-
 drivers/platform/chrome/cros_ec_lpc_mec.c          |   6 -
 drivers/platform/chrome/cros_ec_lpc_mec.h          |   7 -
 drivers/platform/chrome/cros_ec_spi.c              |   1 +
 drivers/platform/chrome/cros_ec_typec.c            |   3 +
 drivers/platform/chrome/cros_hps_i2c.c             | 160 +++++++++++++++++=
++++
 drivers/platform/chrome/cros_usbpd_notify.c        |   6 +-
 drivers/platform/chrome/wilco_ec/core.c            |   5 -
 22 files changed, 298 insertions(+), 42 deletions(-)
 create mode 100644 drivers/platform/chrome/cros_hps_i2c.c

--ZfTIS9a9xhGZ53AG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQS0yQeDP3cjLyifNRUrxTEGBto89AUCY5aSPwAKCRArxTEGBto8
9EoJAQDwIAVLDk14JZHuXIgm6oSXyMgxu2lca5sv9cbettScSwEAjXtnAI/rab6Y
zDgH3+pRqBIuoctzfP54vP9dUQ6u9Ak=
=fKDd
-----END PGP SIGNATURE-----

--ZfTIS9a9xhGZ53AG--
