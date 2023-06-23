Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3360573B06E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 07:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbjFWF44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 01:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbjFWF4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 01:56:53 -0400
Received: from mail.tkos.co.il (mail.tkos.co.il [84.110.109.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEFCEA2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 22:56:52 -0700 (PDT)
Received: from tarshish.tkos.co.il (unknown [10.0.8.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.tkos.co.il (Postfix) with ESMTPS id 69661440537;
        Fri, 23 Jun 2023 08:56:48 +0300 (IDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
        s=default; t=1687499808;
        bh=9omoLWfJGD4Niuvz0Vex+7+GL+qM11yeK77A2ircFmI=;
        h=From:To:Cc:Subject:Date:From;
        b=CRGDgc1J0aW8kX2irt0PlQZ4KF+D85jsr3P9G9cLpLQaffFrLUKahjVYnyLA8mWYl
         oJ1RjaNzjZZn89BKT8Eipt/bq8Tijip4Yiauqj+8fFHHXURxijKlKza+JhjdLKPxlx
         mi8MNUaOQnKZj//HbHu5ONVOk4bhE5NqSL98PyATP4sbJ1JE8GMZyDfzfrdoCsUZa6
         9g7AWs2sYLid+VQkcQoKWTt8l3GWaT16JEXPJnsugVXX/Se3jUggsO5MbJz9cF4WAZ
         Fi/D7VNUzi5xR5kmuW7SKa2bbkodO3YshlP1xyrROnnnPWIQ/Sx8NMBelOXJzecFE1
         45FdlGwTtyrHQ==
From:   Baruch Siach <baruch@tkos.co.il>
To:     Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Baruch Siach <baruch@tkos.co.il>
Subject: [PATCH RESEND] binfmt_elf: fix comment typo s/reset/regset/
Date:   Fri, 23 Jun 2023 08:56:44 +0300
Message-Id: <0b2967c4a4141875c493e835d5a6f8f2d19ae2d6.1687499804.git.baruch@tkos.co.il>
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

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---

Resending with LKML in Cc. kvack.org MX does not like our mail server.
---
 fs/binfmt_elf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git fs/binfmt_elf.c fs/binfmt_elf.c
index 8a884e795f6a..f304a3434c5a 100644
--- fs/binfmt_elf.c
+++ fs/binfmt_elf.c
@@ -1773,7 +1773,7 @@ static int fill_thread_core_info(struct elf_thread_core_info *t,
 	/*
 	 * NT_PRSTATUS is the one special case, because the regset data
 	 * goes into the pr_reg field inside the note contents, rather
-	 * than being the whole note contents.  We fill the reset in here.
+	 * than being the whole note contents.  We fill the regset in here.
 	 * We assume that regset 0 is NT_PRSTATUS.
 	 */
 	fill_prstatus(&t->prstatus.common, t->task, signr);
-- 
2.40.1

