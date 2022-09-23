Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEFC35E82A7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 21:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232142AbiIWTrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 15:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiIWTro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 15:47:44 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E425B12E421;
        Fri, 23 Sep 2022 12:47:43 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id u69so1192831pgd.2;
        Fri, 23 Sep 2022 12:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=dYW2QvrbYPxRlGnPxo3uZr3e/x2sb01bmiBhimSNx+g=;
        b=qZX3vRZuZ+fRu6tDcq0SK4OgJZ6DD+ik97Xmvg+swWF9LVCQktV9X7ebQ5e360CPfh
         51YBE9eelQ0/VWnng4ARoGc9rIa8CWWQRE9rU4JiFVxQ3zfbXe/tvt86P1EL1pErvQa6
         O92lSeukBSSqPRZ3ubs8dJpin2MabE1TZ2LhTkr/VJn1XeJPZsQ4fqDVTQUM2nrSxiT1
         2U6Fl+f54qTeUPQhg2WgXCLlwTmhvf2eC9Tl2VwidesfgAsoA9lbPwqvfKU4xzlTS4TA
         Dnj8PYwBtciBGe0oVCcD3QpZtA3TK5xDCzkEgN98CCdUhtOYO2eO6Atu7Rpin4g12l8c
         5AdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=dYW2QvrbYPxRlGnPxo3uZr3e/x2sb01bmiBhimSNx+g=;
        b=Jgj14qeh61QoJLDIpF5nx3DkXSFyRqAG9zw5sLEsiEtuuiN0pgeA+kk11XbnrU0/5S
         H0IRvbtHlxP5Pau5aDsfzigkUiMFCbXkyt8S4GkqZRYAcbzawST2pLPEkYYEctJ9Li1u
         X5O5ypgoWKtz9eIWLpwr/ZVLum5dqCPpdb5ahK35R1J7hr1g9Sej3Fk9i6xr5vICnlFl
         VqCljCdvy20XBAZLMncFYZBEij37grdLJoX+jcdwvpGj50CyoIFteNUa/qJuLWD4WEgO
         ohDVine1CvsKKQ0ML38jAS2gcy1AD50Nl0U+AHvzp4legWzE2NJMIi07rq+DwJEJqsqc
         koEw==
X-Gm-Message-State: ACrzQf0sUyQPFL7JJ3RID7Zc527AqHk8Q5bPJpQxwOr2ia6NHDI1H6L9
        JBAhKh6PWkAMwfuOQufZnqQ=
X-Google-Smtp-Source: AMsMyM4cCqqysTgzMQTMKzRJROfgK/UDjNAB2DNKRBILlYpsh6gy8TqUFLGkYmPoV8PdF1ZnQZwdVg==
X-Received: by 2002:a63:4752:0:b0:439:5dcc:fd78 with SMTP id w18-20020a634752000000b004395dccfd78mr8777279pgk.104.1663962463312;
        Fri, 23 Sep 2022 12:47:43 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:8b46:be3c:2c54:68a5])
        by smtp.gmail.com with ESMTPSA id e7-20020a170902784700b001753cb9893csm6405187pln.187.2022.09.23.12.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 12:47:42 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-input@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] Input: lm8333 - add missing linux/input.h include
Date:   Fri, 23 Sep 2022 12:47:34 -0700
Message-Id: <20220923194738.927408-1-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
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

We are going to clean up matrix_keymap.h from unnecessary includes,
so the driver needs to include API that it uses directly.

Also let's sort includes alphabetically and drop unneeded irq.h

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/keyboard/lm8333.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/input/keyboard/lm8333.c b/drivers/input/keyboard/lm8333.c
index 9dac22c14125..3052cd6dedac 100644
--- a/drivers/input/keyboard/lm8333.c
+++ b/drivers/input/keyboard/lm8333.c
@@ -4,13 +4,13 @@
  * Copyright (C) 2012 Wolfram Sang, Pengutronix <kernel@pengutronix.de>
  */
 
-#include <linux/module.h>
-#include <linux/slab.h>
-#include <linux/irq.h>
 #include <linux/i2c.h>
-#include <linux/interrupt.h>
+#include <linux/input.h>
 #include <linux/input/matrix_keypad.h>
 #include <linux/input/lm8333.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/slab.h>
 
 #define LM8333_FIFO_READ		0x20
 #define LM8333_DEBOUNCE			0x22
-- 
2.37.3.998.g577e59143f-goog

