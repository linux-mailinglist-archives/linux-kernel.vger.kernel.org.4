Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A793567DD8D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 07:40:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231902AbjA0GkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 01:40:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjA0GkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 01:40:17 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF69E6951F;
        Thu, 26 Jan 2023 22:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=W1j9Oe9+oMEpmfdxgJPUfEHqO35bMtxJ9yuaDvSPmv4=; b=PQtKxFsWfeWb/aiHnLcOaNSeIl
        YLzg9HAjgeoI4DIkXhZkTyvey3/FvJEZF+5UCigN/QalKfhz+Vo6zHLtZwoeLOuotMQmwCr2GbGNT
        miP0msrKxyt9BLufz7ipgpDac1KaJVBRZgXBIqKCimXXRwc4JCiRjVbNyHPWkXa/1wTsT221D17Cq
        UbMzEoNUpGI4NUAQuyAEMTQcMbJJYjcM1yyl85ycf2H+1JKjXUtnqPM1FeJ/vUHR/ge/9Liy+Tic1
        YNocxjeSDbK0R9dFQapnQn1Vwjo7C2fU4Ton3K718swszF0v5ahvhkW7RxCIk6svmts+4nIjnKyB+
        bjNumneQ==;
Received: from [2601:1c2:d80:3110::9307] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pLIPC-00DM0u-Jb; Fri, 27 Jan 2023 06:40:10 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH 01/35] Documentation: arm64: correct spelling
Date:   Thu, 26 Jan 2023 22:39:32 -0800
Message-Id: <20230127064005.1558-3-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230127064005.1558-1-rdunlap@infradead.org>
References: <20230127064005.1558-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct spelling problems for Documentation/arm64/ as reported
by codespell.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
 Documentation/arm64/booting.rst    |    2 +-
 Documentation/arm64/elf_hwcaps.rst |    2 +-
 Documentation/arm64/sve.rst        |    4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff -- a/Documentation/arm64/booting.rst b/Documentation/arm64/booting.rst
--- a/Documentation/arm64/booting.rst
+++ b/Documentation/arm64/booting.rst
@@ -223,7 +223,7 @@ Before jumping into the kernel, the foll
   For systems with a GICv3 interrupt controller to be used in v3 mode:
   - If EL3 is present:
 
-      - ICC_SRE_EL3.Enable (bit 3) must be initialiased to 0b1.
+      - ICC_SRE_EL3.Enable (bit 3) must be initialised to 0b1.
       - ICC_SRE_EL3.SRE (bit 0) must be initialised to 0b1.
       - ICC_CTLR_EL3.PMHE (bit 6) must be set to the same value across
         all CPUs the kernel is executing on, and must stay constant
diff -- a/Documentation/arm64/elf_hwcaps.rst b/Documentation/arm64/elf_hwcaps.rst
--- a/Documentation/arm64/elf_hwcaps.rst
+++ b/Documentation/arm64/elf_hwcaps.rst
@@ -14,7 +14,7 @@ Some hardware or software features are o
 implementations, and/or with certain kernel configurations, but have no
 architected discovery mechanism available to userspace code at EL0. The
 kernel exposes the presence of these features to userspace through a set
-of flags called hwcaps, exposed in the auxilliary vector.
+of flags called hwcaps, exposed in the auxiliary vector.
 
 Userspace software can test for features by acquiring the AT_HWCAP or
 AT_HWCAP2 entry of the auxiliary vector, and testing whether the relevant
diff -- a/Documentation/arm64/sve.rst b/Documentation/arm64/sve.rst
--- a/Documentation/arm64/sve.rst
+++ b/Documentation/arm64/sve.rst
@@ -175,7 +175,7 @@ the SVE instruction set architecture.
 When returning from a signal handler:
 
 * If there is no sve_context record in the signal frame, or if the record is
-  present but contains no register data as desribed in the previous section,
+  present but contains no register data as described in the previous section,
   then the SVE registers/bits become non-live and take unspecified values.
 
 * If sve_context is present in the signal frame and contains full register
@@ -223,7 +223,7 @@ prctl(PR_SVE_SET_VL, unsigned long arg)
 	    Defer the requested vector length change until the next execve()
 	    performed by this thread.
 
-	    The effect is equivalent to implicit exceution of the following
+	    The effect is equivalent to implicit execution of the following
 	    call immediately after the next execve() (if any) by the thread:
 
 		prctl(PR_SVE_SET_VL, arg & ~PR_SVE_SET_VL_ONEXEC)
