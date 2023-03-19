Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5C056C04B7
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 21:13:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbjCSUNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 16:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjCSUNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 16:13:44 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB6E71B33B
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 13:13:37 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id cy23so39244032edb.12
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 13:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679256816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hgnQ+h5zd1AueyynbINK8XAtTpd+QQVfh8Mi4U0c3Fo=;
        b=ZliHulYrzEg7jMD7jC/tO8w/HGO57r9H3GDrGhhnO/uCQ9/YKgngMPBLGTxBp817vA
         qHPN1g9gNFzEpQasqLqSmcc5I63MkWEtEE1JIc7p9BI45DNDLFXGn7Owssp5Sx5xTrW1
         EYxbyfUdvyifu/v9Fbp2AaONaWffg2GUHBmo0Irpjy+oXoCyWL0beQbdkvAyPJH1QQlY
         f/+pTmoMm544mnN9GfYM3WMIl2qpOMtRR26rxWqnf4lmRkB4haGAm717IIojkW7Y0ynQ
         IKCko+W+o/u6xTHwjezZAF+tmwbUvzaPnRc6Y+n3gsH9YTdGEGWvzyH5AwzJ2KtGqtki
         QIHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679256816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hgnQ+h5zd1AueyynbINK8XAtTpd+QQVfh8Mi4U0c3Fo=;
        b=kfRSAO5REvkuiY5CGCjJQQbTqjm1sKAuBWo3Vssq6DYRBXSSFq4Tzt+XXG3IwxIx/v
         RhJevNgLo4EO84WAqCikJ6bWxWNYEpQrYMAxxAsWAza7EQXX+Mmm5b7QlvL+4uYvss/Z
         pzopPczjhA66KI+mcAabE1PU6YmWTqf5qe4qfYiUzZdVFAkrajS6S1+uR6mqUfG1oo6A
         C0ENNiD5u6oWZuRJJiuS/lOIch6Y/QS9jow7ysiEmKXIJAgVsVT1lg5v0pL+UbDw+gMU
         /R6cBNEVEVYNa2z6lUWRl4zLbJMgYyCPzY/n0OqQF3WJzufg+NH1FgHr11xu/WVZt1i9
         wBZQ==
X-Gm-Message-State: AO0yUKWgsId74Ii++orrqXgj73K90ohHlAISIMgs0HQLpxQ8yEwqvCZN
        jK5qjm+wluhF5i5MEcgQJT4=
X-Google-Smtp-Source: AK7set+ODMQXplVES5UGk7JyY6zEtWt49I9FbAbBtYNQcQF3NOBn8tHA0lQmBHVOZkDBvYPTghdH/Q==
X-Received: by 2002:aa7:cb4f:0:b0:4fb:1b0d:9f84 with SMTP id w15-20020aa7cb4f000000b004fb1b0d9f84mr10307130edt.6.1679256815931;
        Sun, 19 Mar 2023 13:13:35 -0700 (PDT)
Received: from alaa-emad.. ([41.42.177.251])
        by smtp.gmail.com with ESMTPSA id g22-20020a170906199600b008b1797b77b2sm3511654ejd.221.2023.03.19.13.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Mar 2023 13:13:35 -0700 (PDT)
From:   Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     outreachy@lists.linux.dev, johan@kernel.org, elder@kernel.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        eng.mennamahmoud.mm@gmail.com, Julia Lawall <julia.lawall@inria.fr>
Subject: [PATCH] staging: greybus: use inline function for macros
Date:   Sun, 19 Mar 2023 22:13:24 +0200
Message-Id: <20230319201324.253874-1-eng.mennamahmoud.mm@gmail.com>
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

Convert `to_gbphy_dev` and `to_gbphy_driver` macros into a
static inline functions.

it is not great to have macro that use `container_of` macro,
because from looking at the definition one cannot tell what type
it applies to.

One can get the same benefit from an efficiency point of view
by making an inline function.

Suggested-by: Julia Lawall <julia.lawall@inria.fr>
Signed-off-by: Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
---
 drivers/staging/greybus/gbphy.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/greybus/gbphy.h b/drivers/staging/greybus/gbphy.h
index 1de510499480..42c4e3fe307c 100644
--- a/drivers/staging/greybus/gbphy.h
+++ b/drivers/staging/greybus/gbphy.h
@@ -16,7 +16,10 @@ struct gbphy_device {
 	struct device dev;
 };
 
-#define to_gbphy_dev(d) container_of(d, struct gbphy_device, dev)
+static inline struct gbphy_device *to_gbphy_dev(const struct device *d)
+{
+	return container_of(d, struct gbphy_device, dev);
+}
 
 static inline void *gb_gbphy_get_data(struct gbphy_device *gdev)
 {
@@ -45,7 +48,10 @@ struct gbphy_driver {
 	struct device_driver driver;
 };
 
-#define to_gbphy_driver(d) container_of(d, struct gbphy_driver, driver)
+static inline struct gbphy_driver *to_gbphy_driver(struct device_driver *d)
+{
+	return container_of(d, struct gbphy_driver, driver);
+}
 
 int gb_gbphy_register_driver(struct gbphy_driver *driver,
 			     struct module *owner, const char *mod_name);
-- 
2.34.1

