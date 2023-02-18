Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 945F969BD19
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 22:31:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbjBRVbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 16:31:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbjBRVbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 16:31:42 -0500
Received: from trent.utfs.org (trent.utfs.org [94.185.90.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7648B13D55
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 13:31:08 -0800 (PST)
Received: from localhost (localhost [IPv6:::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by trent.utfs.org (Postfix) with ESMTPS id B43AD5F8DA;
        Sat, 18 Feb 2023 22:29:44 +0100 (CET)
Date:   Sat, 18 Feb 2023 22:29:44 +0100 (CET)
From:   Christian Kujau <lists@nerdbynature.de>
To:     Borislav Petkov <bp@alien8.de>
cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation/process: Explain when tip branches get merged
 into mainline
Message-ID: <bd85b781-c5a5-0dbe-f353-5b87a2de26bd@nerdbynature.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Explain when tip branches get merged into mainline.
    
Signed-off-by: Christian Kujau <lists@nerdbynature.de>
Suggested-by: Borislav Petkov <bp@alien8.de>

---
diff --git a/Documentation/process/maintainer-tip.rst b/Documentation/process/maintainer-tip.rst
index 572a3289c9cb..d43cc2272e83 100644
--- a/Documentation/process/maintainer-tip.rst
+++ b/Documentation/process/maintainer-tip.rst
@@ -421,6 +421,9 @@ allowing themselves a breath. Please respect that.
 The release candidate -rc1 is the starting point for new patches to be
 applied which are targeted for the next merge window.
 
+So called _urgent_ branches will be merged into mainline during the
+stabilization phase of each release.
+
 
 Git
 ^^^

-- 
BOFH excuse #282:

High altitude condensation from U.S.A.F prototype aircraft has contaminated the primary subnet mask. Turn off your computer for 9 days to avoid damaging it.
