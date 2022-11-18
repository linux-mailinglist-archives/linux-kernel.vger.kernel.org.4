Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0FD62FC9D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 19:24:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242751AbiKRSYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 13:24:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242740AbiKRSXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 13:23:23 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C86097AB3;
        Fri, 18 Nov 2022 10:23:22 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id x18so4011628qki.4;
        Fri, 18 Nov 2022 10:23:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kFhfTRZE04WgcQuF4GSi7Znz8Feql0HEC4e01K8E/t8=;
        b=J/BdePGFFJCe26Q3hhZTT85fJXbohAS8/AFvrrJtFyNQIvzF1h22fgrMiUGPCpATb+
         TIsSll4zWtskKOQYWUgkd15ZkOvnjwIiHhN6pwQgZa2sZWgJ1QYG8i16hsDAf/tnrrT4
         66E1om9G0Rwms7yVowsL5P3gyonEvUeHqv6UxpZKL6MM83D956ZcD+aqCwnVIZnVy2CF
         2pYre5MipdLGqzCqusa2bGfDkAsSw7fKW4OvIlozRwl3kgHCZsKkCHg3S+Bc0H1Tiq+q
         tnO/ZcMmtiGXeWJk4uCIIsYRpkkAuB37LX2L9qWVe62DRr2KU72tgUywLAIwTgt5vQUp
         tRIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kFhfTRZE04WgcQuF4GSi7Znz8Feql0HEC4e01K8E/t8=;
        b=fGI4oyLZyjQaFGK97Im9tPVmbeUzKvQ5Ralxku1snaAUsO7tEWrOwr0os0edXZW8Tj
         V3aMZrWBA71ODwdoAu0EfIrqEOnDO+XXEB+a+Q1Tq3Q2lsXOWypOn+W/5VgppKnzewWS
         ahs14jOUGjVIeK8jmeWgVfA8eJ8ilLYgiXKmhEt4UFtPeCv+nmnhuds1vA/GWcTL2Zoa
         nbmyoowBfAhYq9xbL26dNBVQZhrXFnKrHrZipRiIeMwcjBZizhB4G7aQfJojklwmZaMQ
         /EY8tDIv9UCtn0CPofLKSn1weoXy7i2Kr0d1WIhFfkM5AK+diT9IUB9qU7PueHsuwpY5
         AwOw==
X-Gm-Message-State: ANoB5pm59NXQCNB0zBTY69xpf5OeZjYmQnBC4KZO6/zfackbGrcWzzW8
        74AOfLhR2H/zTp0PgvD/iIE6phnGHmg=
X-Google-Smtp-Source: AA0mqf4IQtvzkhOuQGVqLJRsZe8X3zEtvoktr10FgptMN1YHM7zArHXgltBj5RMrJkfsZ+A7YxZ9SA==
X-Received: by 2002:a05:620a:43a9:b0:6fa:18a5:376d with SMTP id a41-20020a05620a43a900b006fa18a5376dmr7011427qkp.220.1668795801766;
        Fri, 18 Nov 2022 10:23:21 -0800 (PST)
Received: from shaak.xiphos.ca (modemcable055.92-163-184.mc.videotron.ca. [184.163.92.55])
        by smtp.gmail.com with ESMTPSA id q46-20020a05620a2a6e00b006fbcab95d70sm2349025qkp.101.2022.11.18.10.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 10:23:21 -0800 (PST)
From:   Liam Beguin <liambeguin@gmail.com>
To:     Liam Beguin <liambeguin@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] math64: fix kernel-doc return value warnings
Date:   Fri, 18 Nov 2022 13:23:09 -0500
Message-Id: <20221118182309.3824530-3-liambeguin@gmail.com>
X-Mailer: git-send-email 2.37.1.223.g6a475b71f8c4
In-Reply-To: <20221118182309.3824530-1-liambeguin@gmail.com>
References: <20221118182309.3824530-1-liambeguin@gmail.com>
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

Fix the following kernel-doc warnings by adding a description for return
values of div_[us]64.

	math64.h:126: warning: No description found for return value of 'div_u64'
	math64.h:139: warning: No description found for return value of 'div_s64'

Signed-off-by: Liam Beguin <liambeguin@gmail.com>
---
 include/linux/math64.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/math64.h b/include/linux/math64.h
index cf3b0099674a..8958f4c005c1 100644
--- a/include/linux/math64.h
+++ b/include/linux/math64.h
@@ -120,6 +120,8 @@ extern s64 div64_s64(s64 dividend, s64 divisor);
  * This is the most common 64bit divide and should be used if possible,
  * as many 32bit archs can optimize this variant better than a full 64bit
  * divide.
+ *
+ * Return: dividend / divisor
  */
 #ifndef div_u64
 static inline u64 div_u64(u64 dividend, u32 divisor)
@@ -133,6 +135,8 @@ static inline u64 div_u64(u64 dividend, u32 divisor)
  * div_s64 - signed 64bit divide with 32bit divisor
  * @dividend: signed 64bit dividend
  * @divisor: signed 32bit divisor
+ *
+ * Return: dividend / divisor
  */
 #ifndef div_s64
 static inline s64 div_s64(s64 dividend, s32 divisor)
-- 
2.37.1.223.g6a475b71f8c4

