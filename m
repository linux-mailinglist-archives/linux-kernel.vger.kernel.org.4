Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC175BFA9D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 11:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbiIUJTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 05:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231743AbiIUJSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 05:18:53 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D219971BC4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 02:18:16 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 6BE4121A86;
        Wed, 21 Sep 2022 09:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1663751857; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=tfNl4o9+urnDQa8kJpnjW95lk/YUU1fVTkOxttWkYV0=;
        b=bJA9yq+tvPSgDOqW0hGseYqWjf1OycU778ZoYFcVNfnWYQCC/yJDUsax1jvqhrK5d+Gz21
        9dMnpw3yvmmesMpS2nVEN4hZ6wisfTuyKzpLO2/m8Mq3KRikMXq4PREUNh2t/+cn2UHbP7
        MzhzkHZdPlyl17LjRWVxAnKmQMCz21Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1663751857;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=tfNl4o9+urnDQa8kJpnjW95lk/YUU1fVTkOxttWkYV0=;
        b=IXai/28aksOC8RhTwLXeZzaikswsNejvvEoTpXJHAzKL2umq7/WJfBbtZUTXGo5ndUhztz
        5widlaBb2Kd5K9Bw==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C9FA92C142;
        Wed, 21 Sep 2022 09:17:36 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Jason Baron <jbaron@akamai.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH] MAINTAINERS: add static_call_inline.c to STATIC BRANCH/CALL
Date:   Wed, 21 Sep 2022 11:17:33 +0200
Message-Id: <20220921091733.13146-1-jslaby@suse.cz>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index 9ae989b32ebb..22b2b12d0478 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19430,7 +19430,7 @@ F:	arch/*/kernel/static_call.c
 F:	include/linux/jump_label*.h
 F:	include/linux/static_call*.h
 F:	kernel/jump_label.c
-F:	kernel/static_call.c
+F:	kernel/static_call*.c
 
 STI AUDIO (ASoC) DRIVERS
 M:	Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
-- 
2.37.3

