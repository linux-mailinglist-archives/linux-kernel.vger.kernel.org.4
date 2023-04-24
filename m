Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 952BC6EC562
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 07:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbjDXFvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 01:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231133AbjDXFuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 01:50:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 498D740E8
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 22:50:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EF86C61B97
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 05:50:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34D71C4339C;
        Mon, 24 Apr 2023 05:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682315402;
        bh=GqjCjCzxDv1vh6JLzidsl4OHL1YaVK3KZDQOaYrm0yU=;
        h=Date:From:To:Cc:Subject:From;
        b=fTwksnmzkecQ/scfjdtSL+jvLy2nUHHWRmZuWVqO82/U7dOH6K1yGTlUTEsZaBC8s
         UuN1FrFsWoCZUp35Dl/VItMHTGRAKRWUhAmfCzTrwScosM62bihxp/DFU3MWiRJQaJ
         XBBmd8LBqo/m6FyajREyxh9yyDquZ5fg6sXKLmP6AL66xLNJkCuMoqlCmJXni7cOHW
         26SwfVF15vBwxY9Wu9tUjNYcXJ3WhkPTAV1tP4sJE8GmY9ECVzLWc7mCDrLe1D780w
         v/X0qBXU6stKC/c48vTjO5r1QxzGOypfU6AlMJ47Ykgcba5B3YIRHy9fIQ5uMdkM8m
         s2GWJa8S+GjGw==
Date:   Mon, 24 Apr 2023 13:49:58 +0800
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     pmalani@chromium.org, bleung@chromium.org, groeck@chromium.org,
        tzungbi@kernel.org, linux-kernel@vger.kernel.org,
        chrome-platform@lists.linux.dev
Subject: [GIT PULL] chrome-platform changes for v6.4
Message-ID: <ZEYYhltzTDUzAV0q@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Y3LZ8OojVBnu1mnZ"
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


--Y3LZ8OojVBnu1mnZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull chrome-platform updates for v6.4.

Thanks,
TzungBi.

The following changes since commit 7e364e56293bb98cae1b55fd835f5991c4e96e7d:

  Linux 6.3-rc5 (2023-04-02 14:29:29 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git tags/tag-chrome-platform-for-v6.4

for you to fetch changes up to d184d60aa301e424cd0cf7de90b40744710a2417:

  platform/chrome: wilco_ec: remove return value check of debugfs_create_dir() (2023-04-24 13:35:12 +0800)

----------------------------------------------------------------
chrome platform changes for 6.4

* Improvements

  - Replace fake flexible arrays with flexible-array member.

* Misc

  - Minor cleanups and fixes.

----------------------------------------------------------------
Gustavo A. R. Silva (1):
      platform/chrome: Replace fake flexible arrays with flexible-array member

Liang He (1):
      platform/chrome: cros_typec_switch: Add missing fwnode_handle_put()

Rob Barnes (1):
      platform/chrome: cros_ec: Separate logic for getting panic info

Tzung-Bi Shih (2):
      platform/chrome: cros_ec: remove unneeded label and if-condition
      platform/chrome: cros_ec_debugfs: fix kernel-doc warning

Zhengkang Huang (1):
      platform/chrome: wilco_ec: remove return value check of debugfs_create_dir()

 drivers/platform/chrome/cros_ec.c              | 10 +++---
 drivers/platform/chrome/cros_ec_debugfs.c      | 42 ++++++++++++++++++++------
 drivers/platform/chrome/cros_typec_switch.c    |  1 +
 drivers/platform/chrome/wilco_ec/debugfs.c     |  2 --
 include/linux/platform_data/cros_ec_commands.h |  2 +-
 5 files changed, 39 insertions(+), 18 deletions(-)

--Y3LZ8OojVBnu1mnZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQS0yQeDP3cjLyifNRUrxTEGBto89AUCZEYYhAAKCRArxTEGBto8
9La7AQCtBHxGi8uQvNrTZiTmKIU3mc+AqHkD1t0tMggy9IhhFQD5ASEH4JTkqWFc
BeRXArlxa9oqdaYPmlTtLYZ4JGCoFAU=
=JNxv
-----END PGP SIGNATURE-----

--Y3LZ8OojVBnu1mnZ--
