Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B131F5FA419
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 21:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbiJJTX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 15:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiJJTXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 15:23:52 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A84EF61119
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 12:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665429831; x=1696965831;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LPkLGLb6ct3NaqkfE/fcmAkN388PX6Fn1d7MFn2Rg6I=;
  b=gcFt76w5TSVOZdxW5BMyTsQGTWLYvuu0C+Ffs4Y1EPTQJ6VGy8k1yzeJ
   6MTDJMbFmXUQU9EcCAG2TgH/vV6IlKyYyAYxwQdkaYa26FV61EojR0zjH
   uh06TYdNUVFqO95kGKebH/TaozytCN+pTvk/V4zcb2hdM10Jya1Y0ay+6
   bqnm81bSTpwsqN8L5dmjbtlZ7g4V7MfjLNaoZCIU7WwIURQKQglYUo0AB
   n+0MOoJl3pbWYQlDKjxTbQ57gc8xN9i66NlJtHUlIdEnk96E0achIeuP6
   faHEk3OZzInymOVUDI4l7XBV41VBjW9YJWdkWi2dHRqgMhJToJznO3Dul
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="284044531"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="284044531"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2022 12:23:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="694762689"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="694762689"
Received: from unknown (HELO fred..) ([172.25.112.68])
  by fmsmga004.fm.intel.com with ESMTP; 10 Oct 2022 12:23:50 -0700
From:   Xin Li <xin3.li@intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, peterz@infradead.org
Subject: [PATCH v2 2/6] x86/opcode: add LKGS instruction to x86-opcode-map
Date:   Mon, 10 Oct 2022 12:01:55 -0700
Message-Id: <20221010190159.11920-3-xin3.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221010190159.11920-1-xin3.li@intel.com>
References: <20221010190159.11920-1-xin3.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

