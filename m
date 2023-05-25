Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B99F071165B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 21:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242704AbjEYSwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 14:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243133AbjEYSuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 14:50:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 062CC1BFE;
        Thu, 25 May 2023 11:43:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B290A6491B;
        Thu, 25 May 2023 18:42:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B64C4C433EF;
        Thu, 25 May 2023 18:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685040137;
        bh=z8swA6wW5Oo1wnkuZhe0uKr1ZhFWOED7/UaCBJAtm+c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NWnsXAMCGQ/+AAvodv5MGeI7yRdrWVSmYGrAoaUjEdvIwDlqGtvjyDvv+g0VEFeOS
         8nnMC+86UIbWWIbQdIIQcCvo7v6HfL7cuQsZb2Kw5G2jSPkh1UT88IQRjc2dVm1pqr
         EgrT09LjwJee9KOVO8orYyjv3xFkgkUJP3JmFQe+TiDH/tVVxBKu+sPOCsWeRhB8t3
         yHYKd3Ctt+5n9Y3CMMmdKvVdjMjselxitbKZLw/QKsUY51c4teCJfHI8MRjwbpkP6N
         Nxpj3lHBWDHsMaGlZmh20lZemzExycm63hHNPjT3vrJ0/Do2ot1MixCNxdtuMFnTy0
         LKKKkBQwV6OXQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Min-Hua Chen <minhuadotchen@gmail.com>,
        kernel test robot <lkp@intel.com>,
        Will Deacon <will@kernel.org>, Sasha Levin <sashal@kernel.org>,
        catalin.marinas@arm.com, ardb@kernel.org,
        akpm@linux-foundation.org, cohuck@redhat.com, surenb@google.com,
        willy@infradead.org, mark.rutland@arm.com, peterx@redhat.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.10 24/31] arm64/mm: mark private VM_FAULT_X defines as vm_fault_t
Date:   Thu, 25 May 2023 14:40:55 -0400
Message-Id: <20230525184105.1909399-24-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230525184105.1909399-1-sashal@kernel.org>
References: <20230525184105.1909399-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Min-Hua Chen <minhuadotchen@gmail.com>

[ Upstream commit d91d580878064b880f3574ac35b98d8b70ee8620 ]

This patch fixes several sparse warnings for fault.c:

arch/arm64/mm/fault.c:493:24: sparse: warning: incorrect type in return expression (different base types)
arch/arm64/mm/fault.c:493:24: sparse:    expected restricted vm_fault_t
arch/arm64/mm/fault.c:493:24: sparse:    got int
arch/arm64/mm/fault.c:501:32: sparse: warning: incorrect type in return expression (different base types)
arch/arm64/mm/fault.c:501:32: sparse:    expected restricted vm_fault_t
arch/arm64/mm/fault.c:501:32: sparse:    got int
arch/arm64/mm/fault.c:503:32: sparse: warning: incorrect type in return expression (different base types)
arch/arm64/mm/fault.c:503:32: sparse:    expected restricted vm_fault_t
arch/arm64/mm/fault.c:503:32: sparse:    got int
arch/arm64/mm/fault.c:511:24: sparse: warning: incorrect type in return expression (different base types)
arch/arm64/mm/fault.c:511:24: sparse:    expected restricted vm_fault_t
arch/arm64/mm/fault.c:511:24: sparse:    got int
arch/arm64/mm/fault.c:670:13: sparse: warning: restricted vm_fault_t degrades to integer
arch/arm64/mm/fault.c:670:13: sparse: warning: restricted vm_fault_t degrades to integer
arch/arm64/mm/fault.c:713:39: sparse: warning: restricted vm_fault_t degrades to integer

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Min-Hua Chen <minhuadotchen@gmail.com>
Link: https://lore.kernel.org/r/20230502151909.128810-1-minhuadotchen@gmail.com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/mm/fault.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 2be856731e817..d8baedd160de0 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -402,8 +402,8 @@ static void do_bad_area(unsigned long addr, unsigned int esr, struct pt_regs *re
 	}
 }
 
-#define VM_FAULT_BADMAP		0x010000
-#define VM_FAULT_BADACCESS	0x020000
+#define VM_FAULT_BADMAP		((__force vm_fault_t)0x010000)
+#define VM_FAULT_BADACCESS	((__force vm_fault_t)0x020000)
 
 static vm_fault_t __do_page_fault(struct mm_struct *mm, unsigned long addr,
 				  unsigned int mm_flags, unsigned long vm_flags,
-- 
2.39.2

