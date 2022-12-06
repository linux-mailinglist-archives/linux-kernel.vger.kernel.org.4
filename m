Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 280F3644AB1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 18:57:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbiLFR53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 12:57:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiLFR51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 12:57:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D970209BB
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 09:57:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E589C61821
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 17:57:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20CB7C433C1;
        Tue,  6 Dec 2022 17:57:23 +0000 (UTC)
Date:   Tue, 6 Dec 2022 17:57:21 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>, regressions@leemhuis.info,
        manivannan.sadhasivam@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] arm64 fix/revert for 6.1
Message-ID: <Y4+CgaxbC0BVlE6h@arm.com>
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

Please pull the revert below. The qcom driver fix is being worked on but
not in time for 6.1, so revert the arm64 change that highlighted the
issue.

Thanks.

The following changes since commit 5b47348fc0b18a78c96f8474cc90b7525ad1bbfe:

  arm64/mm: fix incorrect file_map_count for non-leaf pmd/pud (2022-11-18 19:31:54 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to b7d9aae404841d9999b7476170867ae441e948d2:

  Revert "arm64: dma: Drop cache invalidation from arch_dma_prep_coherent()" (2022-12-06 17:30:39 +0000)

----------------------------------------------------------------
Revert the dropping of the cache invalidation from the arm64
arch_dma_prep_coherent() as it caused a regression in the qcom_q6v5_mss
remoteproc driver. The driver is already buggy but the original arm64
change made the problem obvious. The change will be re-introduced once
the driver is fixed.

----------------------------------------------------------------
Will Deacon (1):
      Revert "arm64: dma: Drop cache invalidation from arch_dma_prep_coherent()"

 arch/arm64/mm/dma-mapping.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

-- 
Catalin
