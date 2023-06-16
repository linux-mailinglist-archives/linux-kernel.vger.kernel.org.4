Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEE1773303C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 13:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344747AbjFPLpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 07:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345220AbjFPLo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 07:44:57 -0400
Received: from imap5.colo.codethink.co.uk (imap5.colo.codethink.co.uk [78.40.148.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC37630F9
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 04:44:31 -0700 (PDT)
Received: from [167.98.27.226] (helo=rainbowdash)
        by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
        id 1qA7rx-009P8n-QE; Fri, 16 Jun 2023 12:43:58 +0100
Received: from ben by rainbowdash with local (Exim 4.96)
        (envelope-from <ben@rainbowdash>)
        id 1qA7ry-000fWQ-1H;
        Fri, 16 Jun 2023 12:43:58 +0100
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH] riscv: vdso: include vdso/vsyscall.h for vdso_data
Date:   Fri, 16 Jun 2023 12:43:57 +0100
Message-Id: <20230616114357.159601-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add include of <vdso/vsyscall.h> to pull in the defition of vdso_data
to remove the following sparse warning:

arch/riscv/kernel/vdso.c:39:18: warning: symbol 'vdso_data' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 arch/riscv/kernel/vdso.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/kernel/vdso.c b/arch/riscv/kernel/vdso.c
index 9a68e7eaae4d..2cf76218a5bd 100644
--- a/arch/riscv/kernel/vdso.c
+++ b/arch/riscv/kernel/vdso.c
@@ -15,6 +15,7 @@
 #include <asm/vdso.h>
 #include <linux/time_namespace.h>
 #include <vdso/datapage.h>
+#include <vdso/vsyscall.h>
 
 enum vvar_pages {
 	VVAR_DATA_PAGE_OFFSET,
-- 
2.39.2

