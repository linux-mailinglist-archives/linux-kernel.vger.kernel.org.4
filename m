Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E49D6D3891
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 16:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbjDBOu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 10:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjDBOuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 10:50:24 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73BC34C1A
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 07:50:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C7849CE0E2A
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 14:50:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A80B2C433EF;
        Sun,  2 Apr 2023 14:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1680447018;
        bh=JQAFxZywOYe2Lt9NTkR8UxfRbrQ5QtXCyjpRBO+6+y4=;
        h=Date:From:To:Cc:Subject:From;
        b=ZnCbzxyDyjpZERD2j5X2JgCnIjJYewD4n/uqZKF6srFtI39/zzTL1iD9oHP3rgHb+
         u/WgufT7qH27xvCs1Kjedi+MKytJl+DPfTVXE7cQgs8feyYp9TfT9CTHxrA8OfefOg
         kdFseZmpqaYFe0By9JLXP26iQVvo5rErqDKiiTuA=
Date:   Sun, 2 Apr 2023 16:50:15 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Saravana Kannan <saravanak@google.com>
Subject: [GIT PULL] Driver core fixes for 6.3-rc5
Message-ID: <ZCmWJ_E1FKCf3aEW@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit fe15c26ee26efa11741a7b632e9f23b01aca4cc6:

  Linux 6.3-rc1 (2023-03-05 14:52:03 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-6.3-rc5

for you to fetch changes up to 5c2712387d4850e0b64121d5fd3e6c4e84ea3266:

  cacheinfo: Fix LLC is not exported through sysfs (2023-03-29 12:04:10 +0200)

----------------------------------------------------------------
Driver core fixes for 6.3-rc5

Here are 3 small changes for 6.3-rc5 semi-related to driver core stuff:
  - documentation update where we move the security_bugs file to a more
    relevant location.
  - mdt/spi-nor debugfs memory leak fix that's been floating around for
    a long time and acked by the maintainer
  - cacheinfo bugfix for a regression in 6.3-rc1

All have been in linux-next with no reported problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Greg Kroah-Hartman (1):
      mtd: spi-nor: fix memory leak when using debugfs_lookup()

Vegard Nossum (1):
      Documentation/security-bugs: move from admin-guide/ to process/

Yicong Yang (1):
      cacheinfo: Fix LLC is not exported through sysfs

 Documentation/admin-guide/index.rst                      |  1 -
 Documentation/admin-guide/reporting-issues.rst           |  4 ++--
 Documentation/process/howto.rst                          |  2 +-
 Documentation/process/index.rst                          |  9 ++++++++-
 Documentation/process/researcher-guidelines.rst          |  2 +-
 Documentation/{admin-guide => process}/security-bugs.rst |  0
 Documentation/process/stable-kernel-rules.rst            |  2 +-
 Documentation/process/submitting-patches.rst             |  2 +-
 .../translations/it_IT/admin-guide/security-bugs.rst     |  2 +-
 .../translations/it_IT/process/submitting-patches.rst    |  2 +-
 Documentation/translations/ja_JP/howto.rst               |  2 +-
 Documentation/translations/ko_KR/howto.rst               |  2 +-
 Documentation/translations/sp_SP/howto.rst               |  2 +-
 .../translations/sp_SP/process/submitting-patches.rst    |  2 +-
 .../translations/zh_CN/admin-guide/security-bugs.rst     |  2 +-
 Documentation/translations/zh_CN/process/howto.rst       |  2 +-
 .../translations/zh_TW/admin-guide/security-bugs.rst     |  2 +-
 Documentation/translations/zh_TW/process/howto.rst       |  2 +-
 MAINTAINERS                                              |  4 ++--
 drivers/base/cacheinfo.c                                 | 16 +++++++++++-----
 drivers/mtd/spi-nor/core.c                               | 14 +++++++++++++-
 drivers/mtd/spi-nor/core.h                               |  2 ++
 drivers/mtd/spi-nor/debugfs.c                            | 11 ++++++++---
 23 files changed, 60 insertions(+), 29 deletions(-)
 rename Documentation/{admin-guide => process}/security-bugs.rst (100%)
