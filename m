Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42BF5750198
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 10:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232756AbjGLIcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 04:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbjGLIcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 04:32:09 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B94C21FFA
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 01:27:55 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R19pw5JqJzBS5qk
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 16:27:52 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689150472; x=1691742473; bh=pVG2KRhBkX+h4vwKxOn1YBJEIOC
        1SKvNKjE1lffnTJE=; b=j7E7wFQ2M3Z07qolPAsnnDxwB2sLNqVKOLLd2Nd4VC7
        KPdQk9pvSbPkBnbwp5R/OmweXFyJX+wGVni8extY6WyzR+nBDzgFzdhW/fneTSpQ
        0wPKXeTr42essykp7JHUukSCoYUuGoi7ia4dAdLfZdElZhh6cq1hrNAcOHuqBnGh
        G3fIJ5Vgw7jvj2JgNny+hP9xbU2RTs4Og1KsHrYweSfO+YHZDfkoRhihMjwtmAie
        HClrL9HESJQAt70GbMM+FmEH0Gwy4XHYrQ3bTT68vWQPgVC8Dmo0w7wI7bDopruB
        CgvIijHZsEJH9xIXqq/UKdYsaTLaDXEHqgNE0zV79Zw==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id lW-ffqnPk3IX for <linux-kernel@vger.kernel.org>;
        Wed, 12 Jul 2023 16:27:52 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R19pw2NBDzBS5qf;
        Wed, 12 Jul 2023 16:27:52 +0800 (CST)
MIME-Version: 1.0
Date:   Wed, 12 Jul 2023 16:27:52 +0800
From:   huzhi001@208suo.com
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org
Cc:     hpa@zytor.com, linux-kernel@vger.kernel.org
Subject: [PATCH] sched/cputime: Fix errors in div64.h
In-Reply-To: <tencent_3F6EAD72B55BDD00C3BA7D941648D9A38D06@qq.com>
References: <tencent_3F6EAD72B55BDD00C3BA7D941648D9A38D06@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <2424861c7a397e0e3a94890e2c381439@208suo.com>
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

The following checkpatch errors are removed:
ERROR: space prohibited before that close parenthesis ')'

Signed-off-by: ZhiHu <huzhi001@208suo.com>
---
  arch/x86/include/asm/div64.h | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/div64.h b/arch/x86/include/asm/div64.h
index b8f1dc0761e4..c8fd84d1b54d 100644
--- a/arch/x86/include/asm/div64.h
+++ b/arch/x86/include/asm/div64.h
@@ -65,7 +65,7 @@ static inline u64 mul_u32_u32(u32 a, u32 b)
      u32 high, low;

      asm ("mull %[b]" : "=a" (low), "=d" (high)
-             : [a] "a" (a), [b] "rm" (b) );
+             : [a] "a" (a), [b] "rm" (b));

      return low | ((u64)high) << 32;
  }
