Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A63676C0F02
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 11:35:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbjCTKfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 06:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbjCTKfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 06:35:23 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C2723643
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 03:34:49 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id eg48so44589604edb.13
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 03:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679308486;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v0YON+Je37l5rNH4i+NhItyHzULx6NYE6uyGW+1TbDg=;
        b=qdGK3JLlynirCfpYsq2enpE1iu8iadQJO5cUlAxFy+JMKgkRgYTZLFG+u5KD546xQc
         T0XYJAFAd8hrmEKvI4todGkTV1qbnBGsSJ0Ur06KT9ta8qfSWenHR/6kM70bRYTEFBfN
         67uwHteZDRU6Apd6DSu3ABxOOi3i1eUn36ncxuRNa7jH+vmAlGishyu6fFSvK9KL2wL4
         u0zl15/MiZY01ESdPQOUogHJ3dsP9ychc+bgweae3v+LmVy+0uGZJ1qs624koV5bHXRs
         72SM5pVaBLekPuXrEm6x/ygEyzRBOen56LhCivprZ4bB1GYUqlbA2oNnweyC2GpbDs2N
         A7ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679308486;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v0YON+Je37l5rNH4i+NhItyHzULx6NYE6uyGW+1TbDg=;
        b=k0E9Jy6CVEuyFmLmS7teItaSNjt1OyEAjUFkuVgHUGTzo2Xg4zRXq5auZga6UxNlRr
         R+EXsEtDCY7D5V/9iFi2kwEcCQL4G6jtNWwEuxJjPMKy6VZyVE9Acaog9ee4QocO51ZE
         pdVw1Z0r2j/zAhjbdw5pxae/jKxex5fg1YIDMLYD0HVezqFQZfsTnuQ5cw7REoq41Q3h
         1gDZQQyq9LK2u3YmplvsxIFGc9nxX4eWhLA/GEXHoycar45u13M9jJ+kHZDuRmqx1f6e
         WNLk/MRdnCtGZzpbP4gbGD8GfIvC7OxI0Ced+H9/FTQ6iEhgDggUknlNoWAI6IXALdVn
         LSLg==
X-Gm-Message-State: AO0yUKVshGIg1PYkh5UmRq8GhY2M0Dk4G2m1QFDNql9/uh+Iuvw2xtG/
        XIn+/GFQXXxxz8hKQUqP6Z4VTliUYKE=
X-Google-Smtp-Source: AK7set/yDflInru6nyu/C75gNAtSOaLhUN4WZSH7nppGQk6eU80Mrd5X0iVQ5sAQkHhWV9oUMAITYQ==
X-Received: by 2002:a17:906:40d1:b0:932:748a:f0ea with SMTP id a17-20020a17090640d100b00932748af0eamr8458784ejk.63.1679308486325;
        Mon, 20 Mar 2023 03:34:46 -0700 (PDT)
Received: from alaa-emad.. ([41.42.177.251])
        by smtp.gmail.com with ESMTPSA id q18-20020a170906b29200b008c607dd7cefsm4235244ejz.79.2023.03.20.03.34.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 03:34:46 -0700 (PDT)
From:   Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     outreachy@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, eng.mennamahmoud.mm@gmail.com,
        Julia Lawall <julia.lawall@inria.fr>
Subject: [PATCH] staging: rtl8723bs: use inline functions for dev_to_sdio_func
Date:   Mon, 20 Mar 2023 12:34:41 +0200
Message-Id: <20230320103441.6537-1-eng.mennamahmoud.mm@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Convert `dev_to_sdio_func` macro into a static inline function.
it is not great to have macro that use `container_of` macro,
because from looking at the definition one cannot tell
what type it applies to.

One can get the same benefit from an efficiency point of view
by making an inline function.

Suggested-by: Julia Lawall <julia.lawall@inria.fr>
Signed-off-by: Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/sdio_intf.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
index 490431484524..7ee821dbbae0 100644
--- a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
+++ b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
@@ -10,7 +10,10 @@
 #include <linux/jiffies.h>
 
 #ifndef dev_to_sdio_func
-#define dev_to_sdio_func(d)     container_of(d, struct sdio_func, dev)
+static inline struct sdio_func *dev_to_sdio_func(struct device *d)
+{
+	return container_of(d, struct sdio_func, dev);
+}
 #endif
 
 static const struct sdio_device_id sdio_ids[] = {
-- 
2.34.1

