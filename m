Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD3DF61A57C
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 00:13:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbiKDXNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 19:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbiKDXNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 19:13:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C19A3450A1
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 16:13:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7CE3DB83031
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 23:13:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35F43C433D7;
        Fri,  4 Nov 2022 23:12:59 +0000 (UTC)
Date:   Fri, 4 Nov 2022 23:12:45 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] arm64 fixes for 6.1-rc4
Message-ID: <Y2WcbQM5P2aJrf7o@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull the arm64 fixes below. Thanks.

The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc780:

  Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to 85f1506337f0c79a4955edfeee86a18628e3735f:

  arm64: cpufeature: Fix the visibility of compat hwcaps (2022-11-03 18:04:56 +0000)

----------------------------------------------------------------
arm64 fixes:

- Avoid kprobe recursion when cortex_a76_erratum_1463225_debug_handler()
  is not inlined (change to __always_inline).

- Fix the visibility of compat hwcaps, broken by recent changes to
  consolidate the visibility of hwcaps and the user-space view of the ID
  registers.

----------------------------------------------------------------
Amit Daniel Kachhap (1):
      arm64: cpufeature: Fix the visibility of compat hwcaps

Mark Rutland (1):
      arm64: entry: avoid kprobe recursion

 Documentation/arm64/cpu-feature-registers.rst | 38 +++++++++++++++++++++++-
 arch/arm64/kernel/cpufeature.c                | 42 +++++++++++++++++++++------
 arch/arm64/kernel/entry-common.c              |  3 +-
 3 files changed, 72 insertions(+), 11 deletions(-)

-- 
Catalin
