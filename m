Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4A5D6370F1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 04:21:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbiKXDVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 22:21:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbiKXDVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 22:21:13 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B6AD02D1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 19:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=/0CU48Zw70eP8gCcZfPtoIrEyWctIOGQrz7h9ITawzM=; b=FV0+g+vmEupfkxS4tOfXBQQCuc
        vyYs1LIkXNg39zFCkUQUog+lGgqn5g4k2Srgabz2b0Gla8opOI01o7ELzuKW2OJDf2bqkIkXnE0Xf
        ZmipRtwC3N0BPuKj6rvarLrYkYRKjaaBbsKw12LHkRe7ajmaSGrvOXG7dCGnnlLTtSjmPbiVbVleA
        Jj3X1bbKQS7vWfAECK6/SnnvKkHfLKPDVBgZocMYwu4ACtj3Rxzfu/o6YqZwNSPRX4DSW0ZyJG4Cy
        RNhKVstJKZRD0MySW59hOYjlvheT4y4Z01lqiYcSJTz1OnBzjm6KYxzC+dy7IcaMYKDCXQwf70iBq
        ILtUKmig==;
Received: from [2601:1c2:d80:3110::a2e7] (helo=casper.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oy2nd-008Kry-7w; Thu, 24 Nov 2022 03:21:17 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Christian Brauner <christian@brauner.io>
Subject: [PATCH] nios2: support clone3() syscall
Date:   Wed, 23 Nov 2022 19:21:07 -0800
Message-Id: <20221124032107.11223-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.38.1
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

Add support for the clone3() syscall to prevent a warning from
checksyscalls.sh:

<stdin>:1517:2: warning: #warning syscall clone3 not implemented [-Wcpp]

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Dinh Nguyen <dinguyen@kernel.org>
Cc: Christian Brauner <christian@brauner.io>
---
Is there some reason that NIOS2 should not (does not) support clone3()?

 arch/nios2/include/uapi/asm/unistd.h |    1 +
 1 file changed, 1 insertion(+)

diff -- a/arch/nios2/include/uapi/asm/unistd.h b/arch/nios2/include/uapi/asm/unistd.h
--- a/arch/nios2/include/uapi/asm/unistd.h
+++ b/arch/nios2/include/uapi/asm/unistd.h
@@ -22,6 +22,7 @@
 #define __ARCH_WANT_STAT64
 #define __ARCH_WANT_SET_GET_RLIMIT
 #define __ARCH_WANT_TIME32_SYSCALLS
+#define __ARCH_WANT_SYS_CLONE3
 
 /* Use the standard ABI for syscalls */
 #include <asm-generic/unistd.h>
