Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 189B76415C1
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 11:25:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbiLCKZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 05:25:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbiLCKZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 05:25:32 -0500
Received: from out203-205-251-66.mail.qq.com (out203-205-251-66.mail.qq.com [203.205.251.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 295A789333
        for <linux-kernel@vger.kernel.org>; Sat,  3 Dec 2022 02:25:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1670063125;
        bh=kjhHL5Y9sg0vFwa2Ffv/y68ja0+Pkp5Gy+WmvouEaXs=;
        h=From:To:Cc:Subject:Date;
        b=T8ZazCWM5O1DExBJtnHYBP40ZAOFIxIpwNfGAEhwOTx0/6R49DuSD4BCBylN2HbUX
         bae+9hgOGpob+y34SLsaMR7RrwciY1jjGp6ztIr8bWD4YSsfp1a1/AYZkLwmTVPpwF
         cAGsUbhu3I9Wq+x8NiwBUNyHbJhegTnhXzZrlSww=
Received: from rtoax.. ([111.199.188.128])
        by newxmesmtplogicsvrszc1-0.qq.com (NewEsmtp) with SMTP
        id 657AD691; Sat, 03 Dec 2022 18:25:23 +0800
X-QQ-mid: xmsmtpt1670063123t00503lin
Message-ID: <tencent_922CA94B789587D79FD154445D035AA19E07@qq.com>
X-QQ-XMAILINFO: Mm/8i8/T4yne99HUiRiR+7VHSIfb9B6KG4/kMJ956O6iWoBr0lzjkRVw5BOQt8
         lly3r7XEeO2nB4Ah1Ins8CUyyHCTwADPbYKsg4dLFLtuMZu3xo4xxhhzOVhrfBVCzufA2A3y8uHx
         a3m4q/8AEcX/OXxx78c/5PVJTvntV0HVXbZuoI6e6jpPBSPDBmiOUB80HppIbjOuAhVym8akXpSu
         JIW1whbTl1iPHaYuZitQmX4FSlbC60YJjyyOcv3FG4s/NLC09999Y94F0fHefpzYHjQg2cQ+Szb8
         S+B/DZST0RZIS0ULdUaNREQWP4/Dg20NmnFzBoKfium47pkiW+eHFBcW2WaDHsBD5C2KbxnziL7Z
         LWHJ9Q3Yl0F170d2LFTygeVKFP+lVt3zLzkjrU5s2nQ5sAZUQvFsfU9ul5ltKDeC/GrmGBgSknUB
         229kOrpL4xyUa3kez6D9zKQLrZ+sFo6PEy5SQB1gncFqZIjGTPXTqv/w1zgQLiAOlRe1MC0v318M
         Uez2pRvXlHb2yFwhlutf04IMYlpfqS2BCF+oEOHsETQucMoIwsyngmssS7uTCWVh4wDquA921qYU
         UvBrC26CUdkj5R1Iz4zaTXcBilO5bDkkQjWvvwDW2oXST6Ex6z/WVMfyCH5pu/n5qblq+Cw2H3Vn
         lZgZHQa31ZPeGsZITP8ubynwZZB605vnqHAIBTBjkUUQUJBx1qIwqJXvrMO4+HmHpx4OoodiHKC9
         WVDprKp2yYh5ZR2CB4NtWcod1h2P3Q8L0ucZQohjyHOKLzQcKzvkXkVozyF6nZlPawdUJCi5QKN2
         LeNe13LI6hjQbkc78pb7rVvhp4NUUzEBhpMoi05Qvq6WIg0ixvrBhiEd0/tkZcCrgVhVNPV843lS
         hqsvPUk823GSzlUc6PblRmgPpIV1e8ebMXXpywwEsNidbkCtawTrNsx0p7nv+itpi94Ajlhi4LMh
         2NiY6HDwoM3fBMARifsEJayMDhlDWAvJfIIU13FOo=
From:   Rong Tao <rtoax@foxmail.com>
To:     dvyukov@google.com
Cc:     Rong Tao <rongtao@cestc.cn>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        kasan-dev@googlegroups.com (open list:KCOV),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] kcov: fix spelling typos in comments
Date:   Sat,  3 Dec 2022 18:25:21 +0800
X-OQ-MSGID: <20221203102522.25347-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rong Tao <rongtao@cestc.cn>

Fix the typo of 'suport' in kcov.h

Signed-off-by: Rong Tao <rongtao@cestc.cn>
---
 include/linux/kcov.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/kcov.h b/include/linux/kcov.h
index 55dc338f6bcd..ee04256f28af 100644
--- a/include/linux/kcov.h
+++ b/include/linux/kcov.h
@@ -56,7 +56,7 @@ static inline void kcov_remote_start_usb(u64 id)
 /*
  * The softirq flavor of kcov_remote_*() functions is introduced as a temporary
  * work around for kcov's lack of nested remote coverage sections support in
- * task context. Adding suport for nested sections is tracked in:
+ * task context. Adding support for nested sections is tracked in:
  * https://bugzilla.kernel.org/show_bug.cgi?id=210337
  */
 
-- 
2.38.1

