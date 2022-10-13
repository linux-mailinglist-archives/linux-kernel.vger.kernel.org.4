Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA795FE330
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 22:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbiJMUXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 16:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbiJMUXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 16:23:30 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44160159D51
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 13:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665692610; x=1697228610;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LPkLGLb6ct3NaqkfE/fcmAkN388PX6Fn1d7MFn2Rg6I=;
  b=AKsPAOgkoT9uYH8ql73lDu8lsHfzzmqrJPwNvZfTfyPJTJ9Vpq5AQS8c
   ymDogrT/rbUPs8046tfSwqEcSRSbDMgswO95fJ0agkD4/IuvCeS+WDYv3
   q6leno4kVs+9QgYx/HgZ7qqBO8I4FYkLlMrcEntArrPd1XtbUoztATvn5
   C3GjjIMuBEL8ghykc0DCuQyzQgkIOTkBjmHx4pHqWjX8Tm3JtUUsPGj2B
   mp2SrTTYnH8inVeMNt4PIzYF6OrIQaSiSRxxADa4K+AayzVJudKuCiJFz
   FcKdpC50vMvP0cYbNfZEn0mwXz3PXgX+7e7RXUqATVyZWyUS7C5hDCJPm
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10499"; a="302808952"
X-IronPort-AV: E=Sophos;i="5.95,182,1661842800"; 
   d="scan'208";a="302808952"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2022 13:23:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10499"; a="690271043"
X-IronPort-AV: E=Sophos;i="5.95,182,1661842800"; 
   d="scan'208";a="690271043"
Received: from unknown (HELO fred..) ([172.25.112.68])
  by fmsmga008.fm.intel.com with ESMTP; 13 Oct 2022 13:23:27 -0700
From:   Xin Li <xin3.li@intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, peterz@infradead.org,
        brgerst@gmail.com, chang.seok.bae@intel.com
Subject: [PATCH v3 2/6] x86/opcode: add LKGS instruction to x86-opcode-map
Date:   Thu, 13 Oct 2022 13:01:30 -0700
Message-Id: <20221013200134.1487-3-xin3.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221013200134.1487-1-xin3.li@intel.com>
References: <20221013200134.1487-1-xin3.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "H. Peter Anvin (Intel)" <hpa@zytor.com>

Add the instruction opcode used by LKGS.
Opcode number is per public FRED draft spec v3.0
https://cdrdv2.intel.com/v1/dl/getContent/678938.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Xin Li <xin3.li@intel.com>
---
 arch/x86/lib/x86-opcode-map.txt       | 1 +
 tools/arch/x86/lib/x86-opcode-map.txt | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/x86/lib/x86-opcode-map.txt b/arch/x86/lib/x86-opcode-map.txt
index d12d1358f96d..5168ee0360b2 100644
--- a/arch/x86/lib/x86-opcode-map.txt
+++ b/arch/x86/lib/x86-opcode-map.txt
@@ -1047,6 +1047,7 @@ GrpTable: Grp6
 3: LTR Ew
 4: VERR Ew
 5: VERW Ew
+6: LKGS Ew (F2)
 EndTable
 
 GrpTable: Grp7
diff --git a/tools/arch/x86/lib/x86-opcode-map.txt b/tools/arch/x86/lib/x86-opcode-map.txt
index d12d1358f96d..5168ee0360b2 100644
--- a/tools/arch/x86/lib/x86-opcode-map.txt
+++ b/tools/arch/x86/lib/x86-opcode-map.txt
@@ -1047,6 +1047,7 @@ GrpTable: Grp6
 3: LTR Ew
 4: VERR Ew
 5: VERW Ew
+6: LKGS Ew (F2)
 EndTable
 
 GrpTable: Grp7
-- 
2.34.1

