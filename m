Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04A146B639F
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 08:15:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjCLHOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 03:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCLHOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 03:14:49 -0400
Received: from m126.mail.126.com (m126.mail.126.com [220.181.12.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 35D94457DE
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 23:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=U4G7v
        qSZcFnlDeK2LsxIplWYUEzY4kg4lUQol+no3JM=; b=YM198w7LVrTPEFLHWoGUM
        Eg/t1fo9OCdgUK3LOp5jJDrBLibQQ2myhXElyZtQYUABGVOWG4938NjvpRXbEJQn
        /jpydIb66SpYg1CVCqXJ4aHH9IeVxo2SYdz1D6Afv+EFum5+nq9SGJjBrDLbLiAM
        Uq0u09Q9KIJOF1OQBjC71c=
Received: from localhost.localdomain (unknown [119.123.34.9])
        by zwqz-smtp-mta-g4-0 (Coremail) with SMTP id _____wB3b8nUew1kH0hTAA--.46303S2;
        Sun, 12 Mar 2023 15:14:29 +0800 (CST)
From:   Xujun Leng <lengxujun2007@126.com>
To:     corbet@lwn.net
Cc:     linux@leemhuis.info, lengxujun2007@126.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] docs: process: submitting-patches: fix typo in section "Respond to review comments"
Date:   Sun, 12 Mar 2023 15:14:23 +0800
Message-Id: <20230312071423.3042-1-lengxujun2007@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wB3b8nUew1kH0hTAA--.46303S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKFyUCw1DZw18XF4rWF15urg_yoWkCrb_C3
        90yFWjkw4qyr1IqF45CFs8XrsavF4I9w18Cr1kJFsrZayYyanxXa4kG3sav3yjvrWF9F15
        Wa98Wr4UAF129jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRtksgUUUUUU==
X-Originating-IP: [119.123.34.9]
X-CM-SenderInfo: pohqw5hxmx0jqqqxqiyswou0bp/1tbiaRUwd1pEIyxcBQAAsz
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the second paragraph of section "Respond to review comments", there is
a spelling mistake: "aganst" should be "against".

Signed-off-by: Xujun Leng <lengxujun2007@126.com>
---
 Documentation/process/submitting-patches.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
index eac7167dce83..69ce64e03c70 100644
--- a/Documentation/process/submitting-patches.rst
+++ b/Documentation/process/submitting-patches.rst
@@ -320,7 +320,7 @@ for their time.  Code review is a tiring and time-consuming process, and
 reviewers sometimes get grumpy.  Even in that case, though, respond
 politely and address the problems they have pointed out.  When sending a next
 version, add a ``patch changelog`` to the cover letter or to individual patches
-explaining difference aganst previous submission (see
+explaining difference against previous submission (see
 :ref:`the_canonical_patch_format`).
 
 See Documentation/process/email-clients.rst for recommendations on email
-- 
2.25.1

