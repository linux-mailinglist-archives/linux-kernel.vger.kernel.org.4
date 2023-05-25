Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23D75711668
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 21:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243320AbjEYS41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 14:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242972AbjEYSyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 14:54:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 099523C23;
        Thu, 25 May 2023 11:46:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 663E960B51;
        Thu, 25 May 2023 18:43:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6869DC433D2;
        Thu, 25 May 2023 18:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685040217;
        bh=lRszj8c8nrCfK5xuDq5S/n49YLwti7gEva5S+XlmNAE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TLSbMh4yRXuN8ihCzDCO5RM7/9SPSTwBPwtEQFro3NnEmXL2n41yOx10IntVvM3hg
         Ey5YzQewigwiJ3OdAyWyE+M+E9f0HJYDVXNQ01YhTztOVoWBJqBRFuVh/7zUbBrLDH
         36ALHVQwQKBp8igyhMENIHkHULG12VpFaXZaHBmijF3taEsEPskSz6XpW76zpd6eoG
         5amO2bi0uwF/Zvd9YXcKfte6YoLWVwzAIfNryfNPqLsBN5RS1pWS1RIBPpZ/rfzdA3
         1WzeVOv1nCQNhhuBPJ5F+mlsH4/P/OgYPRTZG/R58ZWGsReRwmBfoUyUWW0i9LvmHZ
         tWPgg59x22Jgg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Min-Hua Chen <minhuadotchen@gmail.com>,
        kernel test robot <lkp@intel.com>,
        Will Deacon <will@kernel.org>, Sasha Levin <sashal@kernel.org>,
        catalin.marinas@arm.com, ardb@kernel.org,
        akpm@linux-foundation.org, maz@kernel.org, peterx@redhat.com,
        mark.rutland@arm.com, surenb@google.com, willy@infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.4 21/27] arm64/mm: mark private VM_FAULT_X defines as vm_fault_t
Date:   Thu, 25 May 2023 14:42:30 -0400
Message-Id: <20230525184238.1943072-21-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230525184238.1943072-1-sashal@kernel.org>
References: <20230525184238.1943072-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
index a8e9c98147a19..af9a6e1fa0d3d 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -403,8 +403,8 @@ static void do_bad_area(unsigned long addr, unsigned int esr, struct pt_regs *re
 	}
 }
 
-#define VM_FAULT_BADMAP		0x010000
-#define VM_FAULT_BADACCESS	0x020000
+#define VM_FAULT_BADMAP		((__force vm_fault_t)0x010000)
+#define VM_FAULT_BADACCESS	((__force vm_fault_t)0x020000)
 
 static vm_fault_t __do_page_fault(struct mm_struct *mm, unsigned long addr,
 			   unsigned int mm_flags, unsigned long vm_flags)
-- 
2.39.2

