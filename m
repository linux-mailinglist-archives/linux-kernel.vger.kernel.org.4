Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10E4A6978E5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 10:25:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233697AbjBOJZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 04:25:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjBOJZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 04:25:26 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4338537703
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 01:24:49 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id o1so6836814ioo.10
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 01:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U58GCmaC1la8M68RT2H2QUDegMYE9gldonYav+YFNps=;
        b=hIBciBgLYrCDYkPB9WdMlWrowGQkvEoZCrK6UqtB4maXJqa/aF1tjiGMPGV3/xfM7M
         nt6DjDVmT6o21gaSF2mggZNW6upMQCMVHkVoy2SeWTFDtF1XkDFl3o7zGfi/fY3n3/Qu
         TkJrE4Vp+ltwTJw84u4O0ETXkeUyqOtwV8LQ8xHR3eMomd3va8elvMPiimt9tMk1tbsI
         v4JBDcaDHe2FQ7Vh0JVj1ZFZtF7ZqOCbIIHRHE3kSl2SR1WdhwcS/FIF46833AHyllG3
         m/kYLxF58TCPaWg25y7wRr/23Ay4C29vnX70rLJtL/jG3bMwmfi3YciiKU1+bqo1qP57
         e+Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U58GCmaC1la8M68RT2H2QUDegMYE9gldonYav+YFNps=;
        b=dqxA+J5LMbXZC77UDAprjcHvOb0mNL2UD4XGYAsMG6gt+EGjh8um8OBG12c7fyd+uH
         iA/XN0gvyV679KMrFvovErtcEypfhXicdsbFlOFqPxsMjwCPyhM6wT2QU95mort9FsOZ
         h8Xp5IPGKeS44u8d31m8bO67nH0Vplds9TNrekNPPC859RuJXVkMjWvZcJZatMU6LiDK
         NKp2YKZKkVx++29vOAGSOOCcIgSJCNZEWmmMkPydu0MFIQZS6crGXG3UcMPUEkkUbzMx
         Is0pqf6f6bNsSU9Llzlkvj7go78G8VByTDN2RRfWIdliEatgG5z0VOdfduP0K/gMH/7k
         rZzw==
X-Gm-Message-State: AO0yUKXgUpT5BcCnmo+6glN9BIzwLGbKlOwutzXW8tRXX1mnqhHq0TDR
        a/0jSvNLtiHfDfPfpGs7RgtSjZNwZN7raw==
X-Google-Smtp-Source: AK7set8dcZjBk3wOyeykdWw1sVtoX9HMZk25EmgDP9DG7NSN6ZyUdmfI84pRKT7OK/egJe/ludo48A==
X-Received: by 2002:a5d:9f17:0:b0:735:5bdc:7a73 with SMTP id q23-20020a5d9f17000000b007355bdc7a73mr1167324iot.7.1676453080896;
        Wed, 15 Feb 2023 01:24:40 -0800 (PST)
Received: from localhost.localdomain ([154.16.192.42])
        by smtp.gmail.com with ESMTPSA id v26-20020a02cbba000000b0038a06a14b37sm5702423jap.103.2023.02.15.01.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 01:24:07 -0800 (PST)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     unixbhaskar@gmail.com, linux-kernel@vger.kernel.org
Cc:     jolsa@kernel.org
Subject: [PATCH] tools:build: Fix few spells
Date:   Wed, 15 Feb 2023 14:50:13 +0530
Message-Id: <20230215092013.21833-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/borow/borrow/
s/dependecies/dependencies/
s/commandline/command iine/ ------> this one does't matter but for sanity.

cc: jolsa@kernel.org

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 tools/build/fixdep.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/build/fixdep.c b/tools/build/fixdep.c
index 2501fea7aa3e..266cf9a1a871 100644
--- a/tools/build/fixdep.c
+++ b/tools/build/fixdep.c
@@ -7,8 +7,8 @@
  *   Copyright    2002 by Kai Germaschewski  <kai.germaschewski@gmx.de>
  *
  * This code has been borrowed from kbuild's fixdep (scripts/basic/fixdep.c),
- * Please check it for detailed explanation. This fixdep borow only the
- * base transformation of dependecies without the CONFIG mangle.
+ * Please check it for detailed explanation. This fixdep borrow only the
+ * base transformation of dependencies without the CONFIG mangle.
  */

 #include <sys/types.h>
@@ -32,7 +32,7 @@ static void usage(void)
 }

 /*
- * Print out the commandline prefixed with cmd_<target filename> :=
+ * Print out the command line prefixed with cmd_<target filename> :=
  */
 static void print_cmdline(void)
 {
--
2.39.1

