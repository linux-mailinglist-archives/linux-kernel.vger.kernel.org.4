Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 836866C04F1
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 21:49:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjCSUtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 16:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjCSUtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 16:49:47 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED3310418
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 13:49:46 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id z21so39551660edb.4
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 13:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679258985;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L5CLt5l4TCz1CmnxOdt+WgUKYgrA3LVqAot+WuRXqlA=;
        b=HTciBLqcsxjQsKrrZaKrQBKJb05epJEzu/YvZe7+r1jdosOareVKQQRXiSteVVTGVL
         5ttb0pAiDAH/EjxTKEgTdoIADo5HUncf+YAIy5+L6xfw6Pf42lQZHYRqBUYXigVyD38p
         qfFtGR2NrCH+U7UJMlKUFlnVZmCoc4IPkWIoChJHwrwBQaIHVoTTejZevp4hQQN2/pfb
         f/wRDsetcWyFgfTTseaG4G2794tTGmLl953N+ey0uqCjuKwR7Ci13ywEKOr0yBUepLHq
         dmflQ2e5vcDebYxsDBUveVkl5DjN87Td5RjuCRU+ek9H1gLvG/ekC24mnMHOW6PcdX38
         22GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679258985;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L5CLt5l4TCz1CmnxOdt+WgUKYgrA3LVqAot+WuRXqlA=;
        b=toOmhiZOLtG0eLVOlFI76WS6ZnqS6Ji+ThlA9CHqFJrfAyQnrBkR0uzHnKHWeDcTmK
         1xRmKmnqe7LbbPnUL8HKYico7+skz6abNwuz2GUd2NcVbsl8zpphajatgRjklwaTQ3Np
         u8djERLfxLOmzV1hU0PKCK22YKBuJWVo+9uPwsp2hxQkUvoskMrw93rY3i+qhw70cLwD
         DS97ZG9U2PR1IfPYAButfCV9JBRTEvuRWaUaalY6oJ3j8ef36RZfeAH/j/AXOMWtXzBR
         RA8zrvIN5dxJneN+zomjf1oxnZhi+CrfctHmccAwnls034GfeKGiefSBvfQ/qFelgI6i
         VerA==
X-Gm-Message-State: AO0yUKU3n6/cGPisbPX0ICZuhd4JQusjenCInB+otJnnXzOMs4VynLKh
        6r2crPdmab6/OSuZ2O6Atbo=
X-Google-Smtp-Source: AK7set+hOHTt0i9nlpUrmYUdJsFFLqBmF7VGZ3UHdlitwTFKimwuNTjzvOGv6RkYHNWLm3T5+3EzFg==
X-Received: by 2002:a05:6402:4ca:b0:4ad:738b:6706 with SMTP id n10-20020a05640204ca00b004ad738b6706mr10982836edw.2.1679258984926;
        Sun, 19 Mar 2023 13:49:44 -0700 (PDT)
Received: from alaa-emad.. ([41.42.177.251])
        by smtp.gmail.com with ESMTPSA id v6-20020a50d086000000b004fb00831851sm3882901edd.66.2023.03.19.13.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Mar 2023 13:49:44 -0700 (PDT)
From:   Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     outreachy@lists.linux.dev, johan@kernel.org, elder@kernel.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        eng.mennamahmoud.mm@gmail.com, Julia Lawall <julia.lawall@inria.fr>
Subject: [PATCH v2] staging: greybus: use inline function for macros
Date:   Sun, 19 Mar 2023 22:49:35 +0200
Message-Id: <20230319204935.259217-1-eng.mennamahmoud.mm@gmail.com>
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
static inline function.

it is not great to have macro that use `container_of` macro,
because from looking at the definition one cannot tell what type
it applies to.

One can get the same benefit from an efficiency point of view
by making an inline function.

Suggested-by: Julia Lawall <julia.lawall@inria.fr>
Signed-off-by: Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
---
changes in v2:
	remove newlines added in previous patch.
---
 drivers/staging/greybus/gbphy.h | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/greybus/gbphy.h b/drivers/staging/greybus/gbphy.h
index 1de510499480..03a977056637 100644
--- a/drivers/staging/greybus/gbphy.h
+++ b/drivers/staging/greybus/gbphy.h
@@ -15,8 +15,10 @@ struct gbphy_device {
 	struct list_head list;
 	struct device dev;
 };
-
-#define to_gbphy_dev(d) container_of(d, struct gbphy_device, dev)
+static inline struct gbphy_device *to_gbphy_dev(const struct device *d)
+{
+	return container_of(d, struct gbphy_device, dev);
+}
 
 static inline void *gb_gbphy_get_data(struct gbphy_device *gdev)
 {
@@ -44,8 +46,10 @@ struct gbphy_driver {
 
 	struct device_driver driver;
 };
-
-#define to_gbphy_driver(d) container_of(d, struct gbphy_driver, driver)
+static inline struct gbphy_driver *to_gbphy_driver(struct device_driver *d)
+{
+	return container_of(d, struct gbphy_driver, driver);
+}
 
 int gb_gbphy_register_driver(struct gbphy_driver *driver,
 			     struct module *owner, const char *mod_name);
-- 
2.34.1

