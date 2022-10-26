Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 319DB60DCBC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 10:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232944AbiJZIFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 04:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiJZIFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 04:05:36 -0400
Received: from mail.nfschina.com (unknown [124.16.136.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2AAFA8C47A
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 01:05:35 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 4834E1E80C82;
        Wed, 26 Oct 2022 16:04:08 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id j28Ig8SDSj4C; Wed, 26 Oct 2022 16:04:05 +0800 (CST)
Received: from localhost.localdomain.localdomain (unknown [219.141.250.2])
        (Authenticated sender: xupengfei@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 676A31E80C80;
        Wed, 26 Oct 2022 16:04:05 +0800 (CST)
From:   XU pengfei <xupengfei@nfschina.com>
To:     akpm@linux-foundation.org, ddiss@suse.de, brauner@kernel.org,
        mwilck@suse.com, rppt@kernel.org, wuchi.zero@gmail.com,
        ebiederm@xmission.com
Cc:     linux-kernel@vger.kernel.org, XU pengfei <xupengfei@nfschina.com>
Subject: [PATCH 1/1] initramfs: remove unnecessary (void*) conversions
Date:   Wed, 26 Oct 2022 16:05:18 +0800
Message-Id: <20221026080517.3221-1-xupengfei@nfschina.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unnecessary void* type casting.

Signed-off-by: XU pengfei <xupengfei@nfschina.com>
---
 init/initramfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/init/initramfs.c b/init/initramfs.c
index 2f5bfb7d7652..62321883fe61 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -461,7 +461,7 @@ static long __init write_buffer(char *buf, unsigned long len)
 
 static long __init flush_buffer(void *bufv, unsigned long len)
 {
-	char *buf = (char *) bufv;
+	char *buf = bufv;
 	long written;
 	long origLen = len;
 	if (message)
-- 
2.18.2

