Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA3D874C4AF
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 16:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbjGIOUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 10:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjGIOT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 10:19:58 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3EC1F4
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 07:19:56 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4QzTmR1mzszBRpqR
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 22:19:51 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1688912391; x=1691504392; bh=7eoWH2OhnKn9YKT20iRjoC4FMLZ
        NE5srvIsHhiRwjVc=; b=lpwIuW/GOLf76Y0eMfFP1XXKE4yowGuCkvkmSXVmlmG
        s0B1Xh0WXpReF2S6ekzahDIBWZeEwgTih4UuUo/3MeSDuBUnF3G4msiKsUwQFi1a
        xhq25voU7zTyP1fRr6gAnCa0/SFGAJOeEoObuqGwE/AJb1ytqrLU2fI0z8p+wASj
        Z18LgoY5up+4EHSezFTeV9qIbKCeSjfQJZdb95ogg3dcfFj8NIhIRPwnitgSOmzy
        Oa2Edj/Q+Gw6phNmSFLUulJXaVZwDSWy210g5isgjVyzqQumI3jhRsNf0+3ndw8M
        1RaeBCMuEuqhgG4RAEvCWH8ZpBoK6GwbS67CbNtni9g==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id in7N1B0W8sjQ for <linux-kernel@vger.kernel.org>;
        Sun,  9 Jul 2023 22:19:51 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4QzTmQ6jYPzBRYfX;
        Sun,  9 Jul 2023 22:19:50 +0800 (CST)
MIME-Version: 1.0
Date:   Sun, 09 Jul 2023 22:19:50 +0800
From:   xuanzhenggang001@208suo.com
To:     tsbogend@alpha.franken.de
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] MIPS: prefer 'unsigned int' to bare use of 'unsigned'
In-Reply-To: <20230709141701.16324-1-denghuilong@cdjrlc.com>
References: <20230709141701.16324-1-denghuilong@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <e30eb541f2fc615b264a70af2f40a5f9@208suo.com>
X-Sender: xuanzhenggang001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following warnings reported by checkpatch:

arch/mips/kernel/linux32.c:128: WARNING: Prefer 'unsigned int' to bare 
use of 'unsigned'
arch/mips/kernel/linux32.c:129: WARNING: Prefer 'unsigned int' to bare 
use of 'unsigned'
arch/mips/kernel/linux32.c:129: WARNING: Prefer 'unsigned int' to bare 
use of 'unsigned'
arch/mips/kernel/linux32.c:129: WARNING: Prefer 'unsigned int' to bare 
use of 'unsigned'

Signed-off-by: Zhenggang Xuan <xuanzhenggang001@208suo.com>
---
  arch/mips/kernel/linux32.c | 4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/linux32.c b/arch/mips/kernel/linux32.c
index 6b61be486303..4bd52b38dd00 100644
--- a/arch/mips/kernel/linux32.c
+++ b/arch/mips/kernel/linux32.c
@@ -125,8 +125,8 @@ asmlinkage long sys32_fadvise64_64(int fd, int 
__pad,
              flags);
  }

-asmlinkage long sys32_fallocate(int fd, int mode, unsigned offset_a2,
-    unsigned offset_a3, unsigned len_a4, unsigned len_a5)
+asmlinkage long sys32_fallocate(int fd, int mode, unsigned int 
offset_a2,
+    unsigned int offset_a3, unsigned int len_a4, unsigned int len_a5)
  {
      return ksys_fallocate(fd, mode, merge_64(offset_a2, offset_a3),
                    merge_64(len_a4, len_a5));
