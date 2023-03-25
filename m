Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36FB16C8CA2
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 09:32:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbjCYIcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 04:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbjCYIcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 04:32:50 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A8B18155
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 01:32:48 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id dw14so2649085pfb.6
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 01:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679733168;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rZRk78dM+sIDcTF06PFu8cSmlnVuUZmfpf5YGgQ/R64=;
        b=HgZotS7CNv8U8GKTbwzwaX9ktzODi2OfWdl7CnvyiyiZBIvcGFPB9aZYPtM0+NxAAa
         65o2MsIyYii9yQz7c1Y0VQw4HafGwYxCOXn3N2E1jWpfTZVOE+sc1l0Sj8Gp9ZlkHFjD
         eeEsi1WzsA3Pnd/lId0u2m0rA3PgHJlJS5mrIe5pdUUbGLXKtRVgmdsVyAXysNf3LdbV
         0FpEbGccM8JNzG6oz9cjdByjZikUo0673yJI4A4uvJa8PpIUbmi9LjniUCHq5x7KLqCX
         vY3Veu32Gm/HvmjeYEeRkMpmP15EimNKRqj4SuUQaipnZRxKCASMxkQzffLByQeOf0T1
         vwZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679733168;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rZRk78dM+sIDcTF06PFu8cSmlnVuUZmfpf5YGgQ/R64=;
        b=E0hrECwAcZ995huvSlo6vpIJrXo9yjSSXZTcGycBFDp1XGS5pdt6WDU2Bzo1sosUfe
         4vQ0uUctYXbfC6clax76LD7rd5TIuX3FsylGBv5sCj8I9qIoETs3+FsiWR33DSX/tqxg
         haKwRBKSuLJDBgDEnSyAsuRopVcMd8oWidhR7L1b/AHiK5By688K4LjHQXJZkspa0ZZY
         eI8uTVmdrKQfzQgpyZm2nNI7clR/BY52iUKtVPxvve0m3XOu5L24N31RqQYT9mOhySaL
         NDOz7HFhjq5Zr6hbw708/lyCFeaYr27++5aHQVjA6GoY+/mCiTT3NBqo6ScTe6/9siC4
         F/hA==
X-Gm-Message-State: AAQBX9eIgCMrBgVZczus9VcvwM7a4sj5cTwR3jeDNV+qe86bzS/4aZQB
        Bp5pKQqv8uVVm9zABjYz89mbhmTz2XbAL44r
X-Google-Smtp-Source: AKy350bTu6uj1pG9dejrYD50lwhf789Tv6IN/ryzCGZ3bDUe0DQDTLTZqN5rKPJ53FnBKsaiGEkevw==
X-Received: by 2002:a62:5e81:0:b0:627:fd49:9ab with SMTP id s123-20020a625e81000000b00627fd4909abmr5191177pfb.28.1679733168222;
        Sat, 25 Mar 2023 01:32:48 -0700 (PDT)
Received: from ubuntu.localdomain ([117.245.251.101])
        by smtp.gmail.com with ESMTPSA id m33-20020a635821000000b0050927cb606asm14290224pgb.13.2023.03.25.01.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Mar 2023 01:32:47 -0700 (PDT)
From:   Sumitra Sharma <sumitraartsy@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     johan@kernel.org, elder@kernel.org, gregkh@linuxfoundation.org,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Sumitra Sharma <sumitraartsy@gmail.com>
Subject: [PATCH v3 2/3] staging: greybus: Inline gb_audio_manager_module()
Date:   Sat, 25 Mar 2023 01:31:06 -0700
Message-Id: <7470bf9d9a57e8bf27e55bd5e3791c5e0ee31385.1679732179.git.sumitraartsy@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1679732179.git.sumitraartsy@gmail.com>
References: <cover.1679732179.git.sumitraartsy@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert 'gb_audio_manager_module' from a macro to a static
inline function, to make the relevant types apparent in the
definition and to benefit from the type checking performed by
the compiler at call sites.

Signed-off-by: Sumitra Sharma <sumitraartsy@gmail.com>
---
 drivers/staging/greybus/audio_manager_module.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/greybus/audio_manager_module.c b/drivers/staging/greybus/audio_manager_module.c
index 81b4ba607a0e..5f9dcbdbc191 100644
--- a/drivers/staging/greybus/audio_manager_module.c
+++ b/drivers/staging/greybus/audio_manager_module.c
@@ -12,8 +12,11 @@
 
 #define to_gb_audio_module_attr(x)	\
 		container_of(x, struct gb_audio_manager_module_attribute, attr)
-#define to_gb_audio_module(x)		\
-		container_of(x, struct gb_audio_manager_module, kobj)
+
+static inline struct gb_audio_manager_module *to_gb_audio_module(struct kobject *kobj)
+{
+	return container_of(kobj, struct gb_audio_manager_module, kobj);
+}
 
 struct gb_audio_manager_module_attribute {
 	struct attribute attr;
-- 
2.25.1

