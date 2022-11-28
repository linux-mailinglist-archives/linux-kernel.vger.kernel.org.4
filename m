Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9C1463AE61
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 18:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231964AbiK1RFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 12:05:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232763AbiK1REb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 12:04:31 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6216F39
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 09:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669655061; x=1701191061;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LPkLGLb6ct3NaqkfE/fcmAkN388PX6Fn1d7MFn2Rg6I=;
  b=M3nYsWdFKvn1CF8W3WaKyyOH221qbuMG9QPna0uQuDcvp4rwmIqI+TBh
   kVDk4nRCnXbCgHEO99sRXGt9tmX2y6eYExMgvab4fBShTJ8ncpziVW5j4
   lreT2Z7YALlQzyEv3rA2UkUqlUB0mxqGtiPGDPikGcic3BpU+iDW5SWLT
   oiHInsAE5v2X2mQrA8Zuk5NyQmVGTmNzwTfLkkFmug8arpm9FDWtJcAii
   uY9ao5Em8BLdWw7ZL+ifDK9PbGK/X/DYsdr7mjhbaoDYhAUJrziT+eKj3
   8RtwH0yRNZjc//5LgxQSFkQME5YSssOXduZ6I6UZT/aKRSj/UqzyQCHwa
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="313591631"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="313591631"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2022 09:04:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10545"; a="706864624"
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="706864624"
Received: from unknown (HELO fred..) ([172.25.112.68])
  by fmsmga008.fm.intel.com with ESMTP; 28 Nov 2022 09:04:20 -0800
From:   Xin Li <xin3.li@intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, peterz@infradead.org,
        brgerst@gmail.com, chang.seok.bae@intel.com, jgross@suse.com
Subject: [PATCH v5 2/5] x86/opcode: add the LKGS instruction to x86-opcode-map
Date:   Mon, 28 Nov 2022 08:40:25 -0800
Message-Id: <20221128164028.4570-3-xin3.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221128164028.4570-1-xin3.li@intel.com>
References: <20221128164028.4570-1-xin3.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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

