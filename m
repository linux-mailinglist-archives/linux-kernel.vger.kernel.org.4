Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DABB9651C7A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 09:43:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbiLTInY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 03:43:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiLTInU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 03:43:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B8BBE9F;
        Tue, 20 Dec 2022 00:43:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 04FFC612B3;
        Tue, 20 Dec 2022 08:43:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07CCAC433D2;
        Tue, 20 Dec 2022 08:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1671525798;
        bh=OJcu6hA8zweHQLP87i9e4BjAh5/iVPitVMEfjntH0mk=;
        h=Date:From:To:Cc:Subject:From;
        b=pfARHx706HfMgzUbZTBCnsj7drKTlhRY4BoWE2T2RW9TtW28Bp0pbpZhaVNazhlCQ
         YWK/69SGY6lMHhWTqJIlAqkf/FgfhNG5z3Bk9w4MAGtsJ3ZOnsqki74dFib7N68hzW
         Xki8JB1YPa1qFUUiqps6G1I2fDNoQsOMi2uGRgYw=
Date:   Tue, 20 Dec 2022 09:43:15 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        linux-spdx@vger.kernel.org
Subject: [GIT PULL] SPDX/LICENSES update for 6.2-rc1
Message-ID: <Y6F1oyqcjVYmQ0pu@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit f0c4d9fc9cc9462659728d168387191387e903cc:

  Linux 6.1-rc4 (2022-11-06 15:07:11 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/spdx.git tags/spdx-6.2-rc1

for you to fetch changes up to 6cad1ecd4e3213d892b70afa999a81849d1f0206:

  testing: use the copyleft-next-0.3.1 SPDX tag (2022-11-08 15:44:02 +0100)

----------------------------------------------------------------
SPDX/License additions for 6.2-rc1

Here are 2 small updates for LICENSES and some kernel files that add the
Copyleft-next license and use it in a SPDX tag as a dual-license for
some kernel files.

These have been discussed thoroughly in public on the linux-spdx mailing
list, and have the needed acks on them, as well as having been in
linux-next with no reported issues for quite some time.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Luis Chamberlain (2):
      LICENSES: Add the copyleft-next-0.3.1 license
      testing: use the copyleft-next-0.3.1 SPDX tag

 LICENSES/dual/copyleft-next-0.3.1        | 236 +++++++++++++++++++++++++++++++
 lib/test_kmod.c                          |  12 +-
 lib/test_sysctl.c                        |  12 +-
 tools/testing/selftests/kmod/kmod.sh     |  13 +-
 tools/testing/selftests/sysctl/sysctl.sh |  12 +-
 5 files changed, 240 insertions(+), 45 deletions(-)
 create mode 100644 LICENSES/dual/copyleft-next-0.3.1
