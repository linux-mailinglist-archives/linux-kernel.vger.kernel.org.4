Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC66D750286
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 11:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232944AbjGLJHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 05:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjGLJHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 05:07:24 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A7201BE6
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 02:07:17 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R1BhK3S3czBR5lZ
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 17:07:13 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689152833; x=1691744834; bh=rnx2YsFWymU6M2isSb8AsLw+W4o
        KCd+XVG6DZdNQj1U=; b=eBpwNO9fyCaYSMm8PUq5cjLN8Kag/wYW3cNmqFFap0A
        WgF7lP+WUqLyhwUkCAi/U5ZI3ue4WeD3OqRi9Rm5U7T6jfhLj74ET0fHkKoGH53w
        4Y8lVjD8SmNybH5cCtCsytQN64tWbuoFoy+oFhcoE8HAg1fCzOgms7EqCLjh2fAC
        5N005IqEUQE5zfRp0JfyNTJuwFRWQPxmVcSEoh5Pjg0drkbcLfrIRj60A9eRjNa3
        I5ETe6ZF+TZjgdRUDu6bakRtqLKo/pMtQ8PtLgG4IdgmyBoECHuqkZrXtTbEoDf/
        69mGmMIZnEuxx86/BgAsHrn6DMvPMK5YXPsKzQuiyWQ==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id s7UC5zGBqXC5 for <linux-kernel@vger.kernel.org>;
        Wed, 12 Jul 2023 17:07:13 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R1BhK1948zBQR4f;
        Wed, 12 Jul 2023 17:07:13 +0800 (CST)
MIME-Version: 1.0
Date:   Wed, 12 Jul 2023 17:07:13 +0800
From:   huzhi001@208suo.com
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org
Cc:     hpa@zytor.com, linux-kernel@vger.kernel.org
Subject: [PATCH] x86/mm: Fix warnings in mmzone_32.h
In-Reply-To: <tencent_D97F5A9B657B360DB521D53075270C09F608@qq.com>
References: <tencent_D97F5A9B657B360DB521D53075270C09F608@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <37068cae09dccc86b1ed2d6b3fdbde91@208suo.com>
X-Sender: huzhi001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following checkpatch warnings are removed:
WARNING: Use #include <linux/smp.h> instead of <asm/smp.h>

Signed-off-by: ZhiHu <huzhi001@208suo.com>
---
  arch/x86/include/asm/mmzone_32.h | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/mmzone_32.h 
b/arch/x86/include/asm/mmzone_32.h
index 2d4515e8b7df..97ca734a5de9 100644
--- a/arch/x86/include/asm/mmzone_32.h
+++ b/arch/x86/include/asm/mmzone_32.h
@@ -7,7 +7,7 @@
  #ifndef _ASM_X86_MMZONE_32_H
  #define _ASM_X86_MMZONE_32_H

-#include <asm/smp.h>
+#include <linux/smp.h>

  #ifdef CONFIG_NUMA
  extern struct pglist_data *node_data[];
