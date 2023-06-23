Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3CD73B057
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 07:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231529AbjFWFvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 01:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231655AbjFWFuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 01:50:52 -0400
Received: from mail.tkos.co.il (wiki.tkos.co.il [84.110.109.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5517D1B4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 22:50:51 -0700 (PDT)
Received: from tarshish.tkos.co.il (unknown [10.0.8.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.tkos.co.il (Postfix) with ESMTPS id 4348E440537;
        Fri, 23 Jun 2023 08:50:45 +0300 (IDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
        s=default; t=1687499445;
        bh=9jEJgdq2Xd4QhhL1CN6tgeLdCWprH78WEI6H8wMuOog=;
        h=From:To:Cc:Subject:Date:From;
        b=jpenR1P21YYDhPHwWhHqO6KTBhbbkvbIUWzIfneujr9FMoUHiS5eouw18NwK5Yp/Q
         pN75u1z0+7O47PSpUOHEzHZKet4OU+AMm89sFitD4Xhn56RKHySaf8lAnYD5t8gQGx
         IgJq1MCoK5bMTdIkzLa4ZI/HzitMAm4u5FdZFG+XZq/z0KDA9pOrx5RgYsc0cQAqq9
         OBdyyn+HvfvpmVqJdnm6veOwnpRd5JlidBGjt/HILHODeFJQfS4BVbRlF5Kefn7iOe
         7d8OINSAQ6vEwmtm8b4PYzKluBL/69kWYM0xkFnAKn/bgxIHwvMuZxtB77FKTavsMc
         GGSzLr4TOdQ1A==
From:   Baruch Siach <baruch@tkos.co.il>
To:     Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Baruch Siach <baruch@tkos.co.il>
Subject: [PATCH v2] elf: correct note name comment
Date:   Fri, 23 Jun 2023 08:50:11 +0300
Message-Id: <455b22b986de4d3bc6d9bfd522378e442943de5f.1687499411.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NT_PRFPREG note is named "CORE". Correct the comment accordingly.

Fixes: 00e19ceec80b ("ELF: Add ELF program property parsing support")
Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---

v2: Swap "CORE" and "LINUX" as noted by Kees
---
 include/uapi/linux/elf.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git include/uapi/linux/elf.h include/uapi/linux/elf.h
index ac3da855fb19..4d1c8d46e7f0 100644
--- include/uapi/linux/elf.h
+++ include/uapi/linux/elf.h
@@ -372,7 +372,8 @@ typedef struct elf64_shdr {
  * Notes used in ET_CORE. Architectures export some of the arch register sets
  * using the corresponding note types via the PTRACE_GETREGSET and
  * PTRACE_SETREGSET requests.
- * The note name for all these is "LINUX".
+ * The note name for these types is "LINUX", except NT_PRFPREG that is named
+ * "CORE".
  */
 #define NT_PRSTATUS	1
 #define NT_PRFPREG	2
-- 
2.40.1

