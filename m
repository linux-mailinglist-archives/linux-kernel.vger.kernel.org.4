Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF2F274E89F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 10:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbjGKIB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 04:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbjGKIB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 04:01:57 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F4C1987
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 01:01:21 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R0YGX54zlzBJJjv
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 16:01:08 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689062468; x=1691654469; bh=erzoiOTROmFl5E7/xLzDHeK6/4m
        /cAdwA43dbhkJWxw=; b=m06eH1CYh8gGU7Vn3n5WHTDfmukT+ICIVImhJrGtAD/
        YAXWR220vDNanmMLFrDzW0q7UF1aVhhsgZgK56UVaEYY1+RIHy4Lscv+GP6ptNHi
        LDhqQbFRXvPhkEliJInJeNam+omsQSMqtOhM1pRorGQ3WOW1bBu2dnn8xLU+rer1
        AJEgITKTIy8/K0EJsflP9fE92Ylkg0low8BuCGu70sOTh2iImHNxPRmtQjBr5NJb
        W+GSPYhRftheqNzUn6UPrZc9Abu8OOtpdyuVckv8rh/CQ5lvSpGW7U7EqEMzTtxV
        p+nIbqwj+FgLLDGNHs79+MDHDH4tB9DZ4i441zuobhg==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id YSmljia9c9Tz for <linux-kernel@vger.kernel.org>;
        Tue, 11 Jul 2023 16:01:08 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R0YGX29hwzBHXkY;
        Tue, 11 Jul 2023 16:01:08 +0800 (CST)
MIME-Version: 1.0
Date:   Tue, 11 Jul 2023 16:01:08 +0800
From:   shijie001@208suo.com
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, hpa@zytor.com
Subject: [PATCH] x86/amd: Fix warnings in hw_breakpoint.c
In-Reply-To: <tencent_AFA3A930A2A72F79197FAA5B352CBD4B4407@qq.com>
References: <tencent_AFA3A930A2A72F79197FAA5B352CBD4B4407@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <d1b81b3fcd0608d792cd52b0fab46db9@208suo.com>
X-Sender: shijie001@208suo.com
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

The following checkpatch warnings are removed:
WARNING: Use #include <linux/processor.h> instead of <asm/processor.h>
WARNING: Use #include <linux/user.h> instead of <asm/user.h>
WARNING: Prefer 'unsigned int *' to bare use of 'unsigned *'
WARNING: Prefer 'unsigned int *' to bare use of 'unsigned *'

Signed-off-by: Jie Shi <shijie001@208suo.com>
---
  arch/x86/kernel/hw_breakpoint.c | 6 +++---
  1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/hw_breakpoint.c 
b/arch/x86/kernel/hw_breakpoint.c
index b01644c949b2..2a6b5427575e 100644
--- a/arch/x86/kernel/hw_breakpoint.c
+++ b/arch/x86/kernel/hw_breakpoint.c
@@ -29,9 +29,9 @@
  #include <linux/smp.h>

  #include <asm/hw_breakpoint.h>
-#include <asm/processor.h>
+#include <linux/processor.h>
  #include <asm/debugreg.h>
-#include <asm/user.h>
+#include <linux/user.h>
  #include <asm/desc.h>
  #include <asm/tlbflush.h>

@@ -74,7 +74,7 @@ unsigned long encode_dr7(int drnum, unsigned int len, 
unsigned int type)
   * Decode the length and type bits for a particular breakpoint as
   * stored in debug register 7.  Return the "enabled" status.
   */
-int decode_dr7(unsigned long dr7, int bpnum, unsigned *len, unsigned 
*type)
+int decode_dr7(unsigned long dr7, int bpnum, unsigned int *len, 
unsigned int *type)
  {
      int bp_info = dr7 >> (DR_CONTROL_SHIFT + bpnum * DR_CONTROL_SIZE);
