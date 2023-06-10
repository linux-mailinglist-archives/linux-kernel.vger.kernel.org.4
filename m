Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F87C72AC43
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 16:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233406AbjFJOZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 10:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233239AbjFJOZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 10:25:37 -0400
Received: from smtp.smtpout.orange.fr (smtp-19.smtpout.orange.fr [80.12.242.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E32A13A98
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 07:25:35 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id 7zX3qD8gIesxi7zX3qZACp; Sat, 10 Jun 2023 16:25:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1686407134;
        bh=OesB7QjVdvM9ATk6240RUwjhucS48HFh/O5XYkyqKNA=;
        h=From:To:Cc:Subject:Date;
        b=M0AlTevRVUoqzRZ5JN0ZssDLIEffQDx40BR5DsuQMaPQiwV+X866NJ7znhAzRSjvQ
         qVT3sf/zryB1byA3NX6sduDM4PRj6erJTXs3//27+gMY/jurynWLdZDl0xHMnl8NA/
         CmQcA75DEAVaXxLNBYLITWOiI4I9FFEgmH0gTSg4DyolbT4KdM4PaOb8MMEmx7+7p/
         QGEN9LXVMbVT4JcB+wFxL0PpDpotLcJtCYDlzW9QvKPdvKc8IJQXawc92Ac3U5/L5Q
         vyQAunq+5cA8FSex3+vi2Xox/IDFC1M+2jQr6snDeulXH+KLQ4BQ1FN+qe4JfXHeei
         eDbvsAhZPJsOQ==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 10 Jun 2023 16:25:34 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-s390@vger.kernel.org
Subject: [PATCH] s390: ebcdic: Fix a typo in a comment
Date:   Sat, 10 Jun 2023 16:25:28 +0200
Message-Id: <08ed63331699177b3354458da66a2f63c0217e49.1686407113.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/ECBDIC/EBCDIC/ 	(C and B are swapped)

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 arch/s390/kernel/ebcdic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kernel/ebcdic.c b/arch/s390/kernel/ebcdic.c
index 7f8246c9be08..0e51fa537262 100644
--- a/arch/s390/kernel/ebcdic.c
+++ b/arch/s390/kernel/ebcdic.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- *    ECBDIC -> ASCII, ASCII -> ECBDIC,
+ *    EBCDIC -> ASCII, ASCII -> EBCDIC,
  *    upper to lower case (EBCDIC) conversion tables.
  *
  *  S390 version
-- 
2.34.1

