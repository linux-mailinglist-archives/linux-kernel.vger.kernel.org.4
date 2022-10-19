Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55405604452
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 14:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbiJSMBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 08:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbiJSMAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 08:00:03 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 874C8F01A6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 04:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666179487; x=1697715487;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LPkLGLb6ct3NaqkfE/fcmAkN388PX6Fn1d7MFn2Rg6I=;
  b=DwhpCYb0A6UYEzxVgCBxYgEPaaFihKWUGhL/lM5cKwltJ9tvNGq5nxlS
   MngdJUHWZfVxZtK9xSZGMUKc4QQjNoyquXvSm16aAHZpaPfkjKr11sDP1
   RJQWuubk3ApxItO8eS4YBr8D7OEMaTxHOwUYk3NglcT87kpjSkPtJTT3q
   Vk7reYIG1gtufVbD5wvrvjvxhJ4hkaSG3z5WZ/N4Qfg4HfZJmiF/Ti0Od
   G/HwWb/b+FbsFlHeP10cpjY99v8K4amgnpolCMEKusb/vw+xuprL3mP11
   qgyRr8QrzbH9kebz9WCL5/Al8TvabWXuUqjCY7ZIECEBz019itdAK5cZj
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="308054294"
X-IronPort-AV: E=Sophos;i="5.95,195,1661842800"; 
   d="scan'208";a="308054294"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 03:13:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="692312613"
X-IronPort-AV: E=Sophos;i="5.95,195,1661842800"; 
   d="scan'208";a="692312613"
Received: from unknown (HELO fred..) ([172.25.112.68])
  by fmsmga008.fm.intel.com with ESMTP; 19 Oct 2022 03:13:32 -0700
From:   Xin Li <xin3.li@intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, peterz@infradead.org,
        brgerst@gmail.com, chang.seok.bae@intel.com
Subject: [PATCH v4 2/5] x86/opcode: add the LKGS instruction to x86-opcode-map
Date:   Wed, 19 Oct 2022 02:50:32 -0700
Message-Id: <20221019095035.10823-3-xin3.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221019095035.10823-1-xin3.li@intel.com>
References: <20221019095035.10823-1-xin3.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

