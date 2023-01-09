Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9969F662732
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 14:34:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234750AbjAINea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 08:34:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237192AbjAINdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 08:33:32 -0500
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 970561EAC3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 05:33:30 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed10:c32c:cc7a:25f1:127a])
        by baptiste.telenet-ops.be with bizsmtp
        id 6dZU2900J2RK3VH01dZUot; Mon, 09 Jan 2023 14:33:28 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pEsHG-001LkU-Cs;
        Mon, 09 Jan 2023 14:33:28 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1pEsHI-00EOlh-84;
        Mon, 09 Jan 2023 14:33:28 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Lee Jones <lee@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH trivial v2] mfd: core: Spelling s/compement/complement/
Date:   Mon,  9 Jan 2023 14:33:22 +0100
Message-Id: <aa7abd7103a0e4be954ea63de78f12e8251b2964.1673271092.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
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
v2:
  - Do not reflow the comment, as requested by Lee.
---
 include/linux/mfd/core.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mfd/core.h b/include/linux/mfd/core.h
index 0bc7cba798a34a7b..14ca7b471576ef39 100644
--- a/include/linux/mfd/core.h
+++ b/include/linux/mfd/core.h
@@ -88,7 +88,7 @@ struct mfd_cell {
 	const char		*of_compatible;
 
 	/*
-	 * Address as defined in Device Tree.  Used to compement 'of_compatible'
+	 * Address as defined in Device Tree.  Used to complement 'of_compatible'
 	 * (above) when matching OF nodes with devices that have identical
 	 * compatible strings
 	 */
-- 
2.34.1

