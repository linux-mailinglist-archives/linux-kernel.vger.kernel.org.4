Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2D2762FF69
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 22:36:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbiKRVgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 16:36:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiKRVgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 16:36:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AFD1A4641
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 13:36:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD55562579
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 21:36:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D566C433D6;
        Fri, 18 Nov 2022 21:36:39 +0000 (UTC)
Date:   Fri, 18 Nov 2022 21:36:36 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] arm64 fixes for 6.1-rc6
Message-ID: <Y3f65PV9KYD8DvY2@arm.com>
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

The following changes since commit f0c4d9fc9cc9462659728d168387191387e903cc:

  Linux 6.1-rc4 (2022-11-06 15:07:11 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to 5b47348fc0b18a78c96f8474cc90b7525ad1bbfe:

  arm64/mm: fix incorrect file_map_count for non-leaf pmd/pud (2022-11-18 19:31:54 +0000)

----------------------------------------------------------------
arm64 fixes:

- Fix a build error with CONFIG_CFI_CLANG + CONFIG_FTRACE when
  CONFIG_FUNCTION_GRAPH_TRACER is not enabled.

- Fix a BUG_ON triggered by the page table checker due to incorrect
  file_map_count for non-leaf pmd/pud (the arm64
  pmd_user_accessible_page() not checking whether it's a leaf entry).

----------------------------------------------------------------
Liu Shixin (1):
      arm64/mm: fix incorrect file_map_count for non-leaf pmd/pud

Sami Tolvanen (1):
      arm64: ftrace: Define ftrace_stub_graph only with FUNCTION_GRAPH_TRACER

 arch/arm64/include/asm/pgtable.h | 4 ++--
 arch/arm64/kernel/entry-ftrace.S | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
Catalin
