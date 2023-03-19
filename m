Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 429DD6C00B3
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 12:08:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbjCSLIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 07:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjCSLIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 07:08:39 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D0E3A8E
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 04:08:37 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id w9so36536872edc.3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 04:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679224116;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KvKtR1SyAlL8ZclsQUDCqvyh4Wf6MUHzliuNE/yYx4s=;
        b=EWqzApqKGHadxWZtuIft3/9k1Z/U4tnCN8u/aqfrNv6utosGaFw523fJ6leRaqEll4
         EQ28CbfFXGQMNlxErCoLR+Qk5RC/HUMST2x7w6ufa6xR/Xo1z0LJM3VfO/JgBUrCEvso
         FTyn+GRt1ath2vas19mi3uVsa9U11EzxEPdR/ZwUw/WaQaV1mELNtTGWjT4q0euhB9i/
         rC36xSR3eVmaTVjGyeUUfk0Aja3WyroUNB+dVS8kdiMfVjFOkL6GqeN1gef7vJO9Dd2E
         qnCkh9xFyemZ1n+yg03sgw0m633doI8TJyS3h1BdE+4u7pnuI4oRPMKDyEIBe3twjMSf
         yU5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679224116;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KvKtR1SyAlL8ZclsQUDCqvyh4Wf6MUHzliuNE/yYx4s=;
        b=JWkEWUx0soUE8vtCOWLcxI7g9NVq2EG7teFKEnSYecz+ME+rd+GtnS4+FM3F9l+ZXh
         0W33THcqjujHT/e59ur381BfGDi2XEOjOwVyqmGLCuz1+LRbYkaHUHPnMN3FfsZeM07k
         ofvdfHTXiRG5UO3EY4tlRaradHyA29//oaJOABoqZr+AhanCPhMF4Ao5/n6wVUzg0NFc
         jSQ7eIKDK3QSx9gogUdVi7P+OncIURFL4XbTJDVkVzgIom1o9yL0e1hBoVpsI+5UMd5N
         iSZ26sd2/oxydtut2B+ofmC0iQNQjUhnkD7oq0blN4iCG/YLn164LztAhedPaJeU6PYU
         gc9Q==
X-Gm-Message-State: AO0yUKWo6z8dnkD3CsRZ49NYWOhKQXOrAcsH1RvK1+n5Fh2F/MN9Q1Rw
        hEGvygma5fNxxuq3rNrVO0s=
X-Google-Smtp-Source: AK7set+M2KsLZ2J+fCSTK7GAzj2ZqhFqHG2PxlB63b1Ee3POlZ7DfjOfSQV70skSwAKtdTXkkftrew==
X-Received: by 2002:a17:906:1991:b0:92e:c4c9:7a43 with SMTP id g17-20020a170906199100b0092ec4c97a43mr5679412ejd.25.1679224116271;
        Sun, 19 Mar 2023 04:08:36 -0700 (PDT)
Received: from alaa-emad.. ([41.42.177.251])
        by smtp.gmail.com with ESMTPSA id m20-20020a170906259400b0092b8c1f41ebsm3122889ejb.24.2023.03.19.04.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Mar 2023 04:08:35 -0700 (PDT)
From:   Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     outreachy@lists.linux.dev, johan@kernel.org, elder@kernel.org,
        greybus-dev@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, eng.mennamahmoud.mm@gmail.com
Subject: [PATCH] staging: greybus: add blank line after struct
Date:   Sun, 19 Mar 2023 13:08:31 +0200
Message-Id: <20230319110831.39931-1-eng.mennamahmoud.mm@gmail.com>
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

