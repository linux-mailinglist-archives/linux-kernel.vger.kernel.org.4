Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 076DF750913
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 15:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233372AbjGLNCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 09:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233351AbjGLNCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 09:02:23 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 655FE1BFD
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 06:02:14 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R1HvM0fnHzBS5qF
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 21:02:07 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689166926; x=1691758927; bh=4od89dqIBIBSI1x32z4NB5DsT+j
        ExWVixROiKHZ+kq4=; b=0REIecocrzdcOPtwzIBx3ZVywM3o88Uc1P+70O3dtVh
        FelwISF/nT3Na0eKGZm+vJ+MNk37w1HiSGVls6SREKgZcQX7znOnEld93vf/JOYC
        klNg/xK75CR4ezQFBk9eYMbhBpzhY0YO8AfJJSxl8IYnsb4B8nWZwW/1ggelGx3X
        1blVhYrg2eN/r4sj7/0A9IhTiN9xT4XZPSdrNqI7LV00i/4lN7+0C97irr6cACbp
        xXCV+YZKJlIHQwCrDWBb8kHaQDCD6aBCcnvlxVBFH6JZeBN6GwtLfgQ0hs18vXMM
        +htnEEAJTeI/mCfwTCQkGXLEvlj/3+moN/39eaSr3tQ==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id qfhrCW-yxwHf for <linux-kernel@vger.kernel.org>;
        Wed, 12 Jul 2023 21:02:06 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R1HvL1tSKzBS5q7;
        Wed, 12 Jul 2023 21:02:06 +0800 (CST)
MIME-Version: 1.0
Date:   Wed, 12 Jul 2023 21:02:06 +0800
From:   huzhi001@208suo.com
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org
Cc:     hpa@zytor.com, linux-kernel@vger.kernel.org
Subject: [PATCH] x86/amd_nb: Fix warnings in amd_nb.h
In-Reply-To: <tencent_D99F165759804D6F6D54F55E9D09438AFD06@qq.com>
References: <tencent_D99F165759804D6F6D54F55E9D09438AFD06@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <a230e226d36fae8d173c39d4ea844af5@208suo.com>
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
WARNING: function definition argument 'int' should also-
-have an identifier name
WARNING: function definition argument 'int' should also-
-have an identifier name
WARNING: function definition argument 'unsigned long'-
-should also have an identifier name
WARNING: Prefer 'unsigned int' to bare use of 'unsigned'

Signed-off-by: ZhiHu <huzhi001@208suo.com>
---
  arch/x86/include/asm/amd_nb.h | 6 +++---
  1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/amd_nb.h 
b/arch/x86/include/asm/amd_nb.h
index ed0eaf65c437..73a70daa919d 100644
--- a/arch/x86/include/asm/amd_nb.h
+++ b/arch/x86/include/asm/amd_nb.h
@@ -18,14 +18,14 @@ extern bool early_is_amd_nb(u32 value);
  extern struct resource *amd_get_mmconfig_range(struct resource *res);
  extern void amd_flush_garts(void);
  extern int amd_numa_init(void);
-extern int amd_get_subcaches(int);
-extern int amd_set_subcaches(int, unsigned long);
+extern int amd_get_subcaches(int value1);
+extern int amd_set_subcaches(int value2, unsigned long value3);

  extern int amd_smn_read(u16 node, u32 address, u32 *value);
  extern int amd_smn_write(u16 node, u32 address, u32 value);

  struct amd_l3_cache {
-    unsigned indices;
+    unsigned int indices;
      u8     subcaches[4];
  };
