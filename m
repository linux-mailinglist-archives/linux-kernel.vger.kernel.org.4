Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8EEE750A4E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 16:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232148AbjGLOB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 10:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232035AbjGLOBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 10:01:22 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19BB71FEB
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 07:00:57 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R1KC63L1czBR7bR
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 22:00:50 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689170450; x=1691762451; bh=xbcAafNuwHu1amOiPB4EBZkM1dk
        E8oL5vXWvxz0VKuA=; b=XaAWuWvSZ82Pcnd+9+zxF+fJAs8g06wz6tTrv+72yc4
        LKw/9/G2rM1eJ6T1f4k1WWOUZchWhlfJ9TtmymQ5r95mjvBVYJpJP0VM9CZPGUJN
        S6TS0f+LntI1nG2L5p6Qzu/9CvK3VzL3vxvQ4wiL/QIO9b1rrW5PJtiWZJI1HG8d
        QEdCWHfwnMx6GGOBLfdKL8H2eqNC8dV9JN5MJpFSgdzV+UjqGYU62JgZNHhFHh4C
        eWOHl/pugBVWO56hA8ekIdzbAp+vOaZlenRIbV1roOefoEQjBNUxQ6wWIkehY0LA
        Ww1ZN65tEAZPqVVaFUFRjCzdbP+Na9wOV5/knqkUxpg==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Dw80rPCKAkvW for <linux-kernel@vger.kernel.org>;
        Wed, 12 Jul 2023 22:00:50 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R1KC55yVQzBHXgf;
        Wed, 12 Jul 2023 22:00:49 +0800 (CST)
MIME-Version: 1.0
Date:   Wed, 12 Jul 2023 22:00:49 +0800
From:   huzhi001@208suo.com
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org
Cc:     hpa@zytor.com, wangkefeng.wang@huawei.com, catalin.marinas@arm.com,
        hca@linux.ibm.com, guoren@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm: Fix warnings in pgtable_32.h
In-Reply-To: <tencent_044DEB2A193CEC49B580CBDE6C846AE1AB09@qq.com>
References: <tencent_044DEB2A193CEC49B580CBDE6C846AE1AB09@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <234fb4ac35ddddc43dfeef62c8377bbe@208suo.com>
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
WARNING: Use #include <linux/processor.h> instead of <asm/processor.h>

Signed-off-by: ZhiHu <huzhi001@208suo.com>
---
  arch/x86/include/asm/pgtable_32.h | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/pgtable_32.h 
b/arch/x86/include/asm/pgtable_32.h
index 7d4ad8907297..f4c155055035 100644
--- a/arch/x86/include/asm/pgtable_32.h
+++ b/arch/x86/include/asm/pgtable_32.h
@@ -14,7 +14,7 @@
   * the i386 page table tree.
   */
  #ifndef __ASSEMBLY__
-#include <asm/processor.h>
+#include <linux/processor.h>
  #include <linux/threads.h>
  #include <asm/paravirt.h>
