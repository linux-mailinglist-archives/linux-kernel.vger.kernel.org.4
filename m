Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC736C00EB
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 12:42:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbjCSLmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 07:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbjCSLmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 07:42:17 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BAD820A03
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 04:42:02 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id ek18so36654790edb.6
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 04:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679226121;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KvKtR1SyAlL8ZclsQUDCqvyh4Wf6MUHzliuNE/yYx4s=;
        b=J+tF2zg0Iwm2XC+tSURltnxNQztJUX8K2WBuYczagLH8I+10V1lWzZ5v61uH41iLz1
         hTz0VBA00NC6qtRR8wAcrvnzUWf8qhVIu6rczb2cXmHUKO/9/Xz+qqabybsloeKJ6PJ3
         mkw06RzTkMj0rSO6xJ975aATHmtkSRNf3I/EiMIzc8ERd6WMYTwwmzEHhXBXr/bbuOPd
         tUK30bE3M16oN0Lql1vYjFiIyeArdecNTrvlaUDLx4TyVSI+5K1jz7GWtUaGySW8PAw1
         tCU3rYSEr0EsaxZPpgmVKhTsL2w3V3XwqwxbOggLZv8uzIMsvj7AUYDJfMsSmFK4nL53
         nqYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679226121;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KvKtR1SyAlL8ZclsQUDCqvyh4Wf6MUHzliuNE/yYx4s=;
        b=0SY6BNfPgD0uEsDMo0PMn6lIH0dRPmSlEuETjilCYUCOLelJiZidxsDue1N8MkugNd
         kdchVNDKh7kgmUiGXboTh0mFPesswMW+7y3zM873VdoddkZgXjbPu5kGs0+JI5jp9Q7/
         0WLy7/BwICyHOxT6af/R0KqHc3ynFQ4HT4E7OKBlknTXJ17FVWhOdcrCRQxqBcEi0lD+
         rkV/ccJ2ssJhfc5RzIGRSxXjfxlQjIDg9e8/EnOaedBHEedzMtHTOuj1hMS2JDfJuG0l
         LiYpmOtqjNbXxCMTBa4WWIEeAJQNVUzXoFw8AnD7C+IdrQlThughhQ2XUdQvIYSQI9re
         VULw==
X-Gm-Message-State: AO0yUKWfNp6SNsLygo0JYAQaeRjC7VT5Jvjt2S56pVJkLbTsRIM1HJmQ
        kDB2K/vgsDC0ecrV/dykJIg=
X-Google-Smtp-Source: AK7set9gVBgC4A/48cDFSZl0RptXfN5NNcuDRCsURmwXed/2ruJCIN2pBCGb46OVpt06wbLi5JNwBQ==
X-Received: by 2002:a17:907:720a:b0:933:f310:34f7 with SMTP id dr10-20020a170907720a00b00933f31034f7mr1309456ejc.15.1679226120887;
        Sun, 19 Mar 2023 04:42:00 -0700 (PDT)
Received: from alaa-emad.. ([41.42.177.251])
        by smtp.gmail.com with ESMTPSA id b7-20020a1709063f8700b008eddbd46d7esm3180681ejj.31.2023.03.19.04.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Mar 2023 04:42:00 -0700 (PDT)
From:   Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     outreachy@lists.linux.dev, vireshk@kernel.org, johan@kernel.org,
        elder@kernel.org, greybus-dev@lists.linaro.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        eng.mennamahmoud.mm@gmail.com
Subject: [PATCH] staging: greybus: add blank line after struct
Date:   Sun, 19 Mar 2023 13:41:54 +0200
Message-Id: <20230319114155.42148-1-eng.mennamahmoud.mm@gmail.com>
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

add blank line after struct for readability as
reported by checkpatch script

" CHECK: Please use a blank line after function/struct/union/enum
declarations"

Signed-off-by: Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
---
 drivers/staging/greybus/gbphy.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/greybus/gbphy.h b/drivers/staging/greybus/gbphy.h
index d4a225b76338..1de510499480 100644
--- a/drivers/staging/greybus/gbphy.h
+++ b/drivers/staging/greybus/gbphy.h
@@ -15,6 +15,7 @@ struct gbphy_device {
 	struct list_head list;
 	struct device dev;
 };
+
 #define to_gbphy_dev(d) container_of(d, struct gbphy_device, dev)
 
 static inline void *gb_gbphy_get_data(struct gbphy_device *gdev)
@@ -43,6 +44,7 @@ struct gbphy_driver {
 
 	struct device_driver driver;
 };
+
 #define to_gbphy_driver(d) container_of(d, struct gbphy_driver, driver)
 
 int gb_gbphy_register_driver(struct gbphy_driver *driver,
-- 
2.34.1

