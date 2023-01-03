Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8DB865C41D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 17:40:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233594AbjACQjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 11:39:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233316AbjACQjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 11:39:37 -0500
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 464EBE032
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 08:39:36 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed10:f1ca:ff0d:9dea:806e])
        by laurent.telenet-ops.be with bizsmtp
        id 4Gfa2900H2YHDVW01GfadT; Tue, 03 Jan 2023 17:39:34 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1pCkK6-00202Z-32; Tue, 03 Jan 2023 17:39:34 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1pCkK5-001T84-C1; Tue, 03 Jan 2023 17:39:33 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Lee Jones <lee@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH trivial] mfd: core: Spelling s/compement/complement/
Date:   Tue,  3 Jan 2023 17:39:32 +0100
Message-Id: <547be5f648b6f3579b1834bac3e1b4fc82c54716.1672763938.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a misspelling of "complement".

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 include/linux/mfd/core.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/mfd/core.h b/include/linux/mfd/core.h
index 0bc7cba798a34a7b..2b138fa0abfc3e17 100644
--- a/include/linux/mfd/core.h
+++ b/include/linux/mfd/core.h
@@ -88,9 +88,9 @@ struct mfd_cell {
 	const char		*of_compatible;
 
 	/*
-	 * Address as defined in Device Tree.  Used to compement 'of_compatible'
-	 * (above) when matching OF nodes with devices that have identical
-	 * compatible strings
+	 * Address as defined in Device Tree.  Used to complement
+	 * 'of_compatible' (above) when matching OF nodes with devices that
+	 * have identical compatible strings
 	 */
 	const u64 of_reg;
 
-- 
2.25.1

