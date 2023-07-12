Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9ED2750796
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 14:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232448AbjGLMJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 08:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjGLMJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 08:09:09 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA52E4D
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 05:09:06 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R1Gk11W1YzBS5q3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 20:08:57 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689163736; x=1691755737; bh=g937xAIz/+X0n9l8I8UCt3NvU73
        51Bt2unZKBkZtWlA=; b=uBEnk4uEID5Th1JrLG8zqum800XMfXbg71lDDKZ/4o6
        oMGMUbgcKP50to8jOFrUHtc5w5IbshMt99vrCtktw8qGBgnyNiUZ/o/d/92RipoR
        todzCaBYl4FcYznvhl52+gT6fJqLeX7Da5AxdorQ17nqwjbSWQ8JIRx76HzjGdoU
        k6vIVP7ZeKfhR+i8XzrGUOzx/q6d+ouUCSHXzaekwZscQX+LZwbas4oLYHpcfS1x
        mkD+0eAzMpvRw1riKQCAN/HesuacVYbSV32QVE9H1rDCgvgCPu3s8C+gQeWRAlOk
        pxSIVliJoqvJZSd2KJSFhOvZGajU+nIKVr75u84gJ/w==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id iNwTlJmle4ms for <linux-kernel@vger.kernel.org>;
        Wed, 12 Jul 2023 20:08:56 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R1Gk02lSGzBJFS7;
        Wed, 12 Jul 2023 20:08:56 +0800 (CST)
MIME-Version: 1.0
Date:   Wed, 12 Jul 2023 20:08:56 +0800
From:   huzhi001@208suo.com
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org
Cc:     hpa@zytor.com, linux-kernel@vger.kernel.org
Subject: [PATCH] x86: Fix warnings in dmi.h
In-Reply-To: <tencent_068F41CEDE5E2BBE8CCEE6AC16AE3ABFCE05@qq.com>
References: <tencent_068F41CEDE5E2BBE8CCEE6AC16AE3ABFCE05@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <a8e317ccea3c96a4f8dd97ef27e78850@208suo.com>
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

The following checkpatch warnings are removed:
WARNING: Prefer 'unsigned int' to bare use of 'unsigned'

Signed-off-by: ZhiHu <huzhi001@208suo.com>
---
  arch/x86/include/asm/dmi.h | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/dmi.h b/arch/x86/include/asm/dmi.h
index b825cb201251..ca2f6254ca4f 100644
--- a/arch/x86/include/asm/dmi.h
+++ b/arch/x86/include/asm/dmi.h
@@ -8,7 +8,7 @@

  #include <asm/setup.h>

-static __always_inline __init void *dmi_alloc(unsigned len)
+static __always_inline __init void *dmi_alloc(unsigned int len)
  {
      return extend_brk(len, sizeof(int));
  }
