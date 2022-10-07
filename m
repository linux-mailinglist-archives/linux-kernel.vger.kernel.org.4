Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 031485F778D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 13:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbiJGLhr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 7 Oct 2022 07:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiJGLhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 07:37:46 -0400
Received: from mx1.emlix.com (mx1.emlix.com [136.243.223.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB4153A44
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 04:37:44 -0700 (PDT)
Received: from mailer.emlix.com (unknown [81.20.119.6])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.emlix.com (Postfix) with ESMTPS id 6F5205FD3A;
        Fri,  7 Oct 2022 13:37:42 +0200 (CEST)
From:   Rolf Eike Beer <eb@emlix.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm: fix typo in struct vm_operations_struct comments
Date:   Fri, 07 Oct 2022 13:37:41 +0200
Message-ID: <2385684.8vm7BOzihM@mobilepool36.emlix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no eprotect(), so I assume this is about mprotect().

Signed-off-by: Rolf Eike Beer <eb@emlix.com>
---
 include/linux/mm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 21f8b27bd9fd..c9d248c11d69 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -549,7 +549,7 @@ struct vm_operations_struct {
 	/*
 	 * Called by mprotect() to make driver-specific permission
 	 * checks before mprotect() is finalised.   The VMA must not
-	 * be modified.  Returns 0 if eprotect() can proceed.
+	 * be modified.  Returns 0 if mprotect() can proceed.
 	 */
 	int (*mprotect)(struct vm_area_struct *vma, unsigned long start,
 			unsigned long end, unsigned long newflags);
-- 
2.37.3

-- 
Rolf Eike Beer, emlix GmbH, https://www.emlix.com
Fon +49 551 30664-0, Fax +49 551 30664-11
Gothaer Platz 3, 37083 Göttingen, Germany
Sitz der Gesellschaft: Göttingen, Amtsgericht Göttingen HR B 3160
Geschäftsführung: Heike Jordan, Dr. Uwe Kracke – Ust-IdNr.: DE 205 198 055

emlix - smart embedded open source


