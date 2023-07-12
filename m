Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A842074FF81
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 08:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbjGLGjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 02:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbjGLGjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 02:39:44 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C236510EF
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 23:39:41 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R17Q12LhBzBR5lL
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 14:39:37 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689143977; x=1691735978; bh=z94Ttp2NEkt0uQ5BRVL4EQ86t1k
        vhLE7CzPuTyxhELk=; b=sM+KjtGGp3neXNhPVEoLNfvAeHdJyC6jNMZFwuAIBMB
        J7mFxmSsMD/0Yl/nHD7qm5G64YXlN9wrrHCK6NEE92imtdUgSfLLyWwFYOuhcAP5
        oJiFBKQganS2DJyxPeTBRsWoz9tlVm0ITxWCZuPOMtBZz4WJyA4KM/q7r7goEuO5
        0a+vZUShfKXBxgG3vqgWZY31ER23vvcTD2NG7tPAqRU4cDIMnebHV3ndaErntrMD
        MX5pC3xZTxB2LSycgYptH3wh0N1Qi5tT2y3p58o7O1NULsrN3BiM3/4pSO62Hrz2
        xXZiOEcIcZz5b4scYBjNFhs79A+3ByAxv0ueP5LaZeA==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id F9t5YiG9Xz0z for <linux-kernel@vger.kernel.org>;
        Wed, 12 Jul 2023 14:39:37 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R17Q06W6lzBR5CX;
        Wed, 12 Jul 2023 14:39:36 +0800 (CST)
MIME-Version: 1.0
Date:   Wed, 12 Jul 2023 14:39:36 +0800
From:   huzhi001@208suo.com
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org
Cc:     hpa@zytor.com, linux-kernel@vger.kernel.org
Subject: [PATCH] License cleanup: Fix errors in pm-trace.h
In-Reply-To: <tencent_63ABC5EB46186CEC43B598CA146CC66ACB09@qq.com>
References: <tencent_63ABC5EB46186CEC43B598CA146CC66ACB09@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <ebf95047b809d2eee29561082391c76b@208suo.com>
X-Sender: huzhi001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following checkpatch errors are removed:
ERROR: spaces required around that ':' (ctx:ExV)

Signed-off-by: ZhiHu <huzhi001@208suo.com>
---
  arch/x86/include/asm/pm-trace.h | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/pm-trace.h 
b/arch/x86/include/asm/pm-trace.h
index bfa32aa428e5..230c0332d7ef 100644
--- a/arch/x86/include/asm/pm-trace.h
+++ b/arch/x86/include/asm/pm-trace.h
@@ -13,7 +13,7 @@ do {                                \
                   "1:\t.word %c1\n\t"        \
                   _ASM_PTR " %c2\n"            \
                   ".previous"            \
-                 :"=r" (tracedata)            \
+                 : "=r" (tracedata)            \
                   : "i" (__LINE__), "i" (__FILE__));    \
          generate_pm_trace(tracedata, user);        \
      }                            \
