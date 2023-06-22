Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8C5739733
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 08:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbjFVGGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 02:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjFVGGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 02:06:38 -0400
Received: from mail.tkos.co.il (wiki.tkos.co.il [84.110.109.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A08EA
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 23:06:36 -0700 (PDT)
Received: from tarshish.tkos.co.il (unknown [10.0.8.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.tkos.co.il (Postfix) with ESMTPS id 1AFB3440787;
        Thu, 22 Jun 2023 09:06:32 +0300 (IDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
        s=default; t=1687413992;
        bh=Sfj0v/aDHVfdFzCSfmen4SNgS2aH8ZdF/uSqTWw1sPY=;
        h=From:To:Cc:Subject:Date:From;
        b=K6M/lKu/0d26BedDPRypgXV/dp+BIO4ZMYMiZ1AunIRsCKsqCAtA0zUlGDz9L2Eif
         CHKAFkO5iWwxUWrxaT0yNrsJvxsqhTFmko7NlFzF3x6/chvmO14i2eeu/DO8NwW2b7
         Ytzk7BNSV0uYL6fm3bZP4SNssPadsbKvb+W66so4xH/0NMekj3AqK0eUA1jllXgW2c
         S1YgQ927ApViCahnwD2AoigGbeOP9UyL25qU8EcqeDNsYBI4jQ2D/8U7B5KNKUoRX5
         RrqYY9DPy7sdrjB/f6mjJ6XISvpehKaWKINMt6KEGAUxpt8QWnn481rBp6pRT+BbcZ
         DuYruGFjc97QQ==
From:   Baruch Siach <baruch@tkos.co.il>
To:     Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Baruch Siach <baruch@tkos.co.il>
Subject: [PATCH RESEND] elf: correct note name comment
Date:   Thu, 22 Jun 2023 09:02:43 +0300
Message-Id: <a7e56e9c0f821348a4c833ac07e7518f457cbdb8.1687413763.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only the NT_PRFPREG note is named "LINUX". Correct the comment
accordingly.

Fixes: 00e19ceec80b ("ELF: Add ELF program property parsing support")
Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---

Resending in hope kvack.org mail server would be willing to accept my
submission this time.

Adding LKML as a safety net.
---
 include/uapi/linux/elf.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git include/uapi/linux/elf.h include/uapi/linux/elf.h
index ac3da855fb19..a8a0cced62c6 100644
--- include/uapi/linux/elf.h
+++ include/uapi/linux/elf.h
@@ -372,7 +372,7 @@ typedef struct elf64_shdr {
  * Notes used in ET_CORE. Architectures export some of the arch register sets
  * using the corresponding note types via the PTRACE_GETREGSET and
  * PTRACE_SETREGSET requests.
- * The note name for all these is "LINUX".
+ * The note name for most types is "CORE". NT_PRFPREG note is named "LINUX".
  */
 #define NT_PRSTATUS	1
 #define NT_PRFPREG	2
-- 
2.40.1

