Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A807C73D761
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 07:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjFZF5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 01:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjFZF5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 01:57:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA38AB
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 22:57:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C075660C8A
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 05:57:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F247CC433C0;
        Mon, 26 Jun 2023 05:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687759070;
        bh=fE+oEgKMU5/b6WdHkLPE6jmxrV6m1rqT0ujhbJyilkc=;
        h=Date:From:To:Cc:Subject:From;
        b=SaTUTDp1xU2XSs4KtgpaL9Z8eMtp6PVF4u5AtAzNt9O2X8m9LoHzapBLokghuthzh
         XZsxzKlRHYSYIe9d34QhoUJ8qc49jpr4ZMxtk8YV+e00wRJDtZuVDXBWxAbw7R4o5o
         nBgKsI+g9eeB4v02QMxY0K2qJ+9SjwJ4mCizkSNBHG0ODoTfXro+tXFvMtaRFmPKh7
         FUl3jpc14CjymjnQuS1Ji8FWbCEblvBeWKjGM9KZcjQgRxTI4btBMpbMVG/gFnif/c
         aMwAm1paFwkdevPOx0OLa2AbjQ7aWeKTv3freR7ezSRF3bPN7n/Fq+f1o9S1zQMmFw
         Iqyt+qxazHctg==
Date:   Mon, 26 Jun 2023 13:57:46 +0800
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     pmalani@chromium.org, bleung@chromium.org, groeck@chromium.org,
        tzungbi@kernel.org, linux-kernel@vger.kernel.org,
        chrome-platform@lists.linux.dev
Subject: [GIT PULL] chrome-platform changes for v6.5
Message-ID: <ZJko2ipBSy8eM/+2@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="NzEMEGZtFlnXQpS0"
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


--NzEMEGZtFlnXQpS0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The following changes since commit ac9a78681b921877518763ba0e89202254349d1b:

  Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git=
 tags/tag-chrome-platform-for-v6.5

for you to fetch changes up to 2b8cc5858a07ab75ce98cae720e263e1c1b0d1d9:

  platform/chrome: cros_ec_spi: Use %*ph for printing hexdump of a small bu=
ffer (2023-06-13 12:28:36 +0800)

----------------------------------------------------------------
chrome platform changes for 6.5

* Improvements

  - Support Pin Assignment D in getting mux state.
  - Emit an uevent when EC panics so that userland programs get chance
    to capture EC coredumps (LPC interface only).
  - Send EC_CMD_HOST_SLEEP_EVENT to EC at the very beginning/end of
    system suspend/resume so that EC can watch the duration more
    accurately (LPC interface only).

* Misc

  - Switch back from I2C .probe_new() to .probe().
  - Use %*ph for printing hexdump of small buffers.

----------------------------------------------------------------
Andy Shevchenko (1):
      platform/chrome: cros_ec_spi: Use %*ph for printing hexdump of a smal=
l buffer

Prashant Malani (1):
      platform/chrome: cros_typec_switch: Add Pin D support

Rob Barnes (1):
      platform/chrome: cros_ec: Report EC panic as uevent

Tim Van Patten (1):
      platform/chrome: cros_ec_lpc: Move host command to prepare/complete

Uwe Kleine-K=F6nig (1):
      platform/chrome: Switch i2c drivers back to use .probe()

 drivers/platform/chrome/cros_ec_i2c.c       |  2 +-
 drivers/platform/chrome/cros_ec_lpc.c       | 15 ++++++++++-----
 drivers/platform/chrome/cros_ec_spi.c       |  8 +-------
 drivers/platform/chrome/cros_hps_i2c.c      |  2 +-
 drivers/platform/chrome/cros_typec_switch.c | 11 ++++++++---
 5 files changed, 21 insertions(+), 17 deletions(-)

--NzEMEGZtFlnXQpS0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQS0yQeDP3cjLyifNRUrxTEGBto89AUCZJko2AAKCRArxTEGBto8
9DpmAP4km134DcEB/GDAm5yEGU0oia0U0YhsYOlkHyLF5tjrIQEAvhL8P1qVxwNV
E83HUbH0Dq+gi4vioatji7cU5D5+fAM=
=XqxV
-----END PGP SIGNATURE-----

--NzEMEGZtFlnXQpS0--
