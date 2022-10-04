Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36B5F5F3C0C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 06:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiJDEPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 00:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiJDEOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 00:14:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F86310FDC
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 21:14:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BA1EDB818F3
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 04:14:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54F68C433C1;
        Tue,  4 Oct 2022 04:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664856885;
        bh=EElg5vjBCrY2XxmKEcT2g6gZOtlK8Lr5Lo6T2o59WC4=;
        h=Date:From:To:Cc:Subject:From;
        b=PJKdoST9tikphDKheUQFh3Ap/Zm9+hQqZIBjbFGmK17dUv3yVx2hV7iRhWVuOSNV8
         J1zZk4R3BVv/XjkyPt9yrU7J7mtp/J1apVGUFnrSsxk+LZOgU0QOP2XbzpBA6S0JI2
         DTVdxXAUqfpyThnN7YFpaVITrDijeC0HJEnF4PfUzEuxYhJJvGIYLUX+jGTINpChGq
         TaTk9eFyyYgn6DzRt1ILTxn1oyqPyfEVI9CQyjP0fVXzgTQR7L6qf5F38r0YuRfEOV
         Pzw3baCzdkhxUEmb8I3FtqFIuk2g8mbiY8Ao63W8jVBFoCPzLAdKSlSQwCL8+xHyq+
         Hqu9syCfMqFrQ==
Date:   Tue, 4 Oct 2022 12:14:42 +0800
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     pmalani@chromium.org, bleung@chromium.org, groeck@chromium.org,
        tzungbi@kernel.org, linux-kernel@vger.kernel.org,
        chrome-platform@lists.linux.dev
Subject: [GIT,PULL] chrome-platform changes for v6.1
Message-ID: <YzuzMpp5SfvgpXzm@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="iJZqw/d2jSZPpne7"
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--iJZqw/d2jSZPpne7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull chrome-platform updates for v6.1.

Thanks,
TzungBi


The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:

  Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git tags/tag-chrome-platform-for-v6.1

for you to fetch changes up to 8edd2752b0aa498b3a61f3caee8f79f7e0567fad:

  platform/chrome: cros_ec: Notify the PM of wake events during resume (2022-09-19 10:34:38 +0800)

----------------------------------------------------------------
chrome platform changes for v6.1

cros_ec_proto:
* Fix protocol failure if EC firmware jumps to RO part.

cros_typec_switch:
* Add USB Type-C switch driver for mode switches and retimers.
* Integrate to EC for retimers, status update, and mode switches.
* Clean-ups.

cros_ec_typec:
* Clean-ups.
* Use partner PDOs to register USB PD capabilities.

chromeos_laptop:
* Fix a double-free.

cros_ec_chardev:
* Check data length from userland to avoid a memory corruption.

cros_ec:
* Expose suspend_timeout_ms in debugfs.
* Notify the PM about wake events during resume.

----------------------------------------------------------------
Dan Carpenter (1):
      platform/chrome: fix memory corruption in ioctl

Evan Green (1):
      platform/chrome: cros_ec: Expose suspend_timeout_ms in debugfs

Jameson Thies (1):
      platform/chrome: cros_ec: Notify the PM of wake events during resume

Patryk Duda (1):
      platform/chrome: cros_ec_proto: Update version on GET_NEXT_EVENT failure

Prashant Malani (10):
      platform/chrome: Add Type-C mux set command definitions
      platform/chrome: cros_typec_switch: Add switch driver
      platform/chrome: cros_typec_switch: Set EC retimer
      platform/chrome: cros_typec_switch: Add event check
      platform/chrome: cros_typec_switch: Register mode switches
      platform/chrome: cros_ec_typec: Cleanup switch handle return paths
      platform/chrome: cros_ec_typec: Get retimer handle
      platform/chrome: cros_ec_typec: Add bit offset for DP VDO
      platform/chrome: cros_ec_typec: Correct alt mode index
      platform/chrome: cros_ec_typec: Register partner PDOs

Rustam Subkhankulov (1):
      platform/chrome: fix double-free in chromeos_laptop_prepare()

Stephen Boyd (4):
      platform/chrome: cros_typec_switch: Add missing newline on printk
      platform/chrome: cros_typec_switch: Remove impossible condition
      platform/chrome: cros_typec_switch: Use PTR_ERR_OR_ZERO() to simplify
      platform/chrome: cros_typec_switch: Inline DRV_NAME

 Documentation/ABI/testing/debugfs-cros-ec      |  22 ++
 MAINTAINERS                                    |   1 +
 drivers/platform/chrome/Kconfig                |  11 +
 drivers/platform/chrome/Makefile               |   1 +
 drivers/platform/chrome/chromeos_laptop.c      |  24 +-
 drivers/platform/chrome/cros_ec.c              |  11 +-
 drivers/platform/chrome/cros_ec_chardev.c      |   3 +
 drivers/platform/chrome/cros_ec_debugfs.c      |   3 +
 drivers/platform/chrome/cros_ec_proto.c        |  32 +++
 drivers/platform/chrome/cros_ec_typec.c        | 110 ++++++++-
 drivers/platform/chrome/cros_typec_switch.c    | 321 +++++++++++++++++++++++++
 include/linux/platform_data/cros_ec_commands.h |  18 ++
 include/linux/platform_data/cros_ec_proto.h    |   1 +
 13 files changed, 536 insertions(+), 22 deletions(-)
 create mode 100644 drivers/platform/chrome/cros_typec_switch.c

--iJZqw/d2jSZPpne7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQS0yQeDP3cjLyifNRUrxTEGBto89AUCYzuzLQAKCRArxTEGBto8
9LHPAPwKEzP/LL5OQdSRXlwEHHGwrzsk4OCECYsIQziBOYST+gD+OjecKgq3qGKl
bJoYSxgd3NQt1XiNUQxRLqY0SI28PAk=
=jyK3
-----END PGP SIGNATURE-----

--iJZqw/d2jSZPpne7--
