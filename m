Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F254D615E12
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 09:41:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbiKBIln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 04:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbiKBIlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 04:41:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD4814008
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 01:41:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CC9D8B82152
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 08:41:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B60C4C433D6;
        Wed,  2 Nov 2022 08:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667378498;
        bh=rizl8tamS/NRsQVE/uKdFMa7h4dMhInIwUz8JbTcrkY=;
        h=From:To:Cc:Subject:Date:From;
        b=VHoDtTIGt9YCGcD0RsHcG4jhUiANf9fuIWDC/Bi+l4si0sFfi0fMTRcSr+fDhJHJs
         8pmsIYWzSd13EnYdtmPD59I/8zlMttZBNSfBk02BKspASBmJLn19vv5CsF2075olYx
         q4ZIuD4/hd6+CA1+gXux2E7DbrfIqqosjmTdFmm037Jo+AxIM3h/MFVm3kSkofpMMb
         6setnthxjLUCA2u1+tkYdJgp6uyDNp8HE6S2qfSJL6ixWMBbsIJZVpSUqkDwoMFhwA
         qoLVDekDftmZTZ8lBX4wrJ1Kso+FeEO2RShSnBzURMNAlwBqqaP3RnlCmf6eVZXVJW
         CakEUREUiymtQ==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Jason Baron <jbaron@akamai.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH] MAINTAINERS: add static_call_inline.c to STATIC BRANCH/CALL
Date:   Wed,  2 Nov 2022 09:41:34 +0100
Message-Id: <20221102084134.4094-1-jirislaby@kernel.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Slaby <jslaby@suse.cz>

Commit 8fd4ddda2f49 (static_call: Don't make __static_call_return0
static) split static_call.c and static_call_inline.c was created. This
was not reflected in MAINTAINERS.

Fix it now by adding a static_call*.c glob.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Jason Baron <jbaron@akamai.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 379945f82a64..401b170a168d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19634,7 +19634,7 @@ F:	arch/*/kernel/static_call.c
 F:	include/linux/jump_label*.h
 F:	include/linux/static_call*.h
 F:	kernel/jump_label.c
-F:	kernel/static_call.c
+F:	kernel/static_call*.c
 
 STI AUDIO (ASoC) DRIVERS
 M:	Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
-- 
2.38.1

