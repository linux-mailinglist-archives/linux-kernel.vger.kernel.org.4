Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C250860380D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 04:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbiJSC0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 22:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbiJSC0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 22:26:46 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5329AE3197;
        Tue, 18 Oct 2022 19:26:30 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id a6-20020a17090abe0600b0020d7c0c6650so19249965pjs.0;
        Tue, 18 Oct 2022 19:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Tryy+T8k8LtGGtricW5LfvH+7TvK0uVdc6l7ZzgoMvc=;
        b=ONiC1mewbWRJzEqkfIaNJEk+17H2VF2kLKN8+g7BNGc2YhPJpT2WxtqK2jbbAQJvTR
         xIWGaUgLasai5m8c97d+d9tlToDwdsu4jaftbqKJF8tPhRlXMdMqtHFIE2EXS0RtMOhf
         P0duIYuLlOuRhI7iowavHCeJMS8KaqUpGuqmPUhhASaIrZhrABO0I3j/wO4Z40ah11ez
         wwn0jXmK4Q13cHqBZCXpxsd50qdcYTmu2kIKs3xHzWULBUrK3V9UM4OLpwzt3Pv1Bdou
         /OwlgXJ0JKrvOonipM2j1jFHE0Oz1GNg1QvWXmLrDnafDZK2AoFxV7nK+L0ruFJSXjlT
         nb6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tryy+T8k8LtGGtricW5LfvH+7TvK0uVdc6l7ZzgoMvc=;
        b=JEsk1hlizXqjSwYNkY+DJ6mTR9Y9vo8F6KUMOW4eLONJCegO9BZhDmrUBs1xhuJFte
         I/Uua1qI+CngQoAiUXhqw5/E3dcbLQb28h203eenPpjjamEu/LZcj6Y8tjKMnvVv5ecu
         VgJOY74G9iAoWn4TwAm8BbADPrA/mOCSu50J8emmRvrqQnVy7zLeF+5VShqZyyBPpXT2
         ivISIqnmbdnRvFY8iCaXiClB7xoy6CvC3HZxyAndqmyBa6JeeMZRmU7eM3lnk5R50Ve8
         yxY6mpIg7SEyFTuj4Mx9cDTKkDmUhc8eshhV31MuAy0scbRnYWG62KErWMoVC9CAUxrv
         E0PQ==
X-Gm-Message-State: ACrzQf0DIm0+myzc0AL8hZZoHrt6/z21HBfl30eOiG4X21Yv37g1TRsC
        oLNQAWBmFJxDJcPwC2BKkg==
X-Google-Smtp-Source: AMsMyM4/XWRaazryepPYKfOqegg9nar3UenRsypsdLeuWcvecUttVn4H5ujTcPjGxBzKvyuQ+xtqiQ==
X-Received: by 2002:a17:90b:1649:b0:20d:2d96:6b05 with SMTP id il9-20020a17090b164900b0020d2d966b05mr42773234pjb.9.1666146389152;
        Tue, 18 Oct 2022 19:26:29 -0700 (PDT)
Received: from localhost.localdomain ([106.104.115.142])
        by smtp.gmail.com with ESMTPSA id x185-20020a6263c2000000b00562a526cd2esm9855880pfb.55.2022.10.18.19.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 19:26:28 -0700 (PDT)
From:   chengwei <foxfly.lai.tw@gmail.com>
X-Google-Original-From: chengwei <larry.lai@yunjingtech.com>
To:     lee@kernel.org, broonie@kernel.org, rafael@kernel.org,
        mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com,
        linus.walleij@linaro.org, brgl@bgdev.pl
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-gpio@vger.kernel.org, GaryWang@aaeon.com.tw,
        musa.lin@yunjingtech.com, jack.chang@yunjingtech.com,
        chengwei <larry.lai@yunjingtech.com>
Subject: [PATCH 3/5] ACPI: acpi_node_add_pin_mapping added to header file
Date:   Wed, 19 Oct 2022 10:24:48 +0800
Message-Id: <20221019022450.16851-4-larry.lai@yunjingtech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221019022450.16851-1-larry.lai@yunjingtech.com>
References: <20221019022450.16851-1-larry.lai@yunjingtech.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Declare acpi_node_add_pin_mapping added for pinctrl-upboard
reference.

Signed-off-by: chengwei <larry.lai@yunjingtech.com>
---
 include/linux/acpi.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 6f64b2f3dc54..7b4668342de0 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1203,6 +1203,11 @@ bool acpi_gpio_get_irq_resource(struct acpi_resource *ares,
 bool acpi_gpio_get_io_resource(struct acpi_resource *ares,
 			       struct acpi_resource_gpio **agpio);
 int acpi_dev_gpio_irq_get_by(struct acpi_device *adev, const char *name, int index);
+int acpi_node_add_pin_mapping(struct fwnode_handle *fwnode,
+			      const char *propname,
+			      const char *pinctl_name,
+			      unsigned int pin_offset,
+			      unsigned int npins);
 #else
 static inline bool acpi_gpio_get_irq_resource(struct acpi_resource *ares,
 					      struct acpi_resource_gpio **agpio)
@@ -1219,6 +1224,15 @@ static inline int acpi_dev_gpio_irq_get_by(struct acpi_device *adev,
 {
 	return -ENXIO;
 }
+
+static inline int acpi_node_add_pin_mapping(struct fwnode_handle *fwnode,
+					    const char *propname,
+					    const char *pinctl_name,
+					    unsigned int pin_offset,
+					    unsigned int npins)
+{
+	return -ENXIO;
+}
 #endif
 
 static inline int acpi_dev_gpio_irq_get(struct acpi_device *adev, int index)
-- 
2.17.1

