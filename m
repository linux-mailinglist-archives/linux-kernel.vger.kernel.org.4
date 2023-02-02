Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA6568753B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 06:30:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjBBFaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 00:30:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232112AbjBBF3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 00:29:08 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 249004DCF6;
        Wed,  1 Feb 2023 21:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=w67uANH4ICcPjfB8P29IxwXnWVdeW1WrLI1ybFP3zFc=; b=EgFOqzZgATVHmdjgAO46/5IsWl
        RsxdGD2hL0Ruted5K+p7hu/ejZk6XfT+eQJetFvQSbrZhg7jfypEoXIKhQ5Z0d1elKhuKSsL4Ub18
        W8w0Lb0Dd63DFKAoWs2Qy72lFcFO1N4jIsrO0KQMsACEcvQyRnWFOKvKuKgCcxjoYOI+yC9BTJghY
        8LRhYT73bu82wd2BXbPv/xjhL6lsfxnq/9vnCXoruE9P184k9seNMKni6zWzxy3Cc50EEzkf3w+b1
        0iOlj30H6PeZxWQ27SrEXpR8Gb3x7WOeWNoTAUdz3k4wYjY+WUCR+PGUxJvTEmD2LrE0JlHklgtMS
        N2biYzzg==;
Received: from [2601:1c2:d00:6a60::9526] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pNS8u-00ERRM-FW; Thu, 02 Feb 2023 05:28:16 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] >>>>>>>>>>>>>>>>>>>>>>>>> BLURB <<<<<<<<<<<<<<<<<<<
Date:   Wed,  1 Feb 2023 21:28:13 -0800
Message-Id: <20230202052813.27427-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,SUBJ_ALL_CAPS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


../arch/sh/include/asm/checksum_32.h: In function 'csum_and_copy_from_user':
../arch/sh/include/asm/checksum_32.h:53:14: error: implicit declaration of function 'access_ok' [-Werror=implicit-function-declaration]
   53 |         if (!access_ok(src, len))
      |              ^~~~~~~~~

Fixes: 7fe8970a78a1 ("sh32: convert to csum_and_copy_from_user()")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 arch/sh/include/asm/checksum_32.h |    1 +
 1 file changed, 1 insertion(+)

diff -- a/arch/sh/include/asm/checksum_32.h b/arch/sh/include/asm/checksum_32.h
--- a/arch/sh/include/asm/checksum_32.h
+++ b/arch/sh/include/asm/checksum_32.h
@@ -7,6 +7,7 @@
  */
 
 #include <linux/in6.h>
+#include <asm-generic/access_ok.h>
 
 /*
  * computes the checksum of a memory block at buff, length len,
