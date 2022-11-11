Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1C63625FE8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 17:57:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233977AbiKKQ5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 11:57:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233180AbiKKQ52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 11:57:28 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C33CF14083;
        Fri, 11 Nov 2022 08:57:27 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id v7so3277943wmn.0;
        Fri, 11 Nov 2022 08:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mZWE3AHjm+gVGD7RjCCyAAkQNQ6fQcTinGqa03Nm0yY=;
        b=M57CLED+h6xY1FdHDVIKLrr7HuIBw1ojq+s7RW+ZVVLFwCms6Sln9BMUam1LKX9MMZ
         1PY3I48TtXvWDU8MoccKdaEww2T043SS1049ZnY5Vzu7N8W3JY4SXNioIt2Vk0cH8o/Z
         oOiKodoMiJNL2SM/V4k1EmQrzdfAOAJGhq99hBquE6a9QxKHRYAbVThXwDCqjNoIeEt+
         +hZuL3jJ2KfbZyk+NJ1ZPFdIN38C+jfyIdOSHglSgX/3RyV28hTatew3zU3g2X7JRsS3
         aHOcjXg5SkfE3aZNTAtomPFoOp/ANaUZLPzNdKVv2jAaaPaQCoN0gNl6rAg7xUDUpXtK
         6jWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mZWE3AHjm+gVGD7RjCCyAAkQNQ6fQcTinGqa03Nm0yY=;
        b=mAA3P7Kvy2ngqY2pbuUnwVaurHI4/noW5yQOXT9yI3jSJdKESWqxv44LebCrHB03M/
         vytYslF6luIOuh/CqM3pHj0Wjz7htsE68XPW7cuDcW5gyQMJ+WwIwOJ8Nup5Q6CK2hvi
         veF++qSIxHGk9ANsi37Iu1iP/Rzp8IET2UL9oqafd8PFoRIAcRsriLgzkLbItSr8hFvq
         62ZZTGmqmDp9AjFhaHP4nyn5fmNVD3E7CqGsKnV7cCZkaIy6kR7UXPprNz+GrSQmBg8W
         lFfnDP1coh47+hdD82VpNfXNrXcIx+X393VgjxVHNvx/QXpv9OySvLJIJU8jcUcmuAcn
         5IXw==
X-Gm-Message-State: ANoB5plcmL4ymT8hxmaAAQfBdIu9y8NgW4Ap/7eamU4eG/s0+a0XP3lQ
        IL237OpUYQ60f/Us9iAAgnVMsk15n2DR8g==
X-Google-Smtp-Source: AA0mqf7a6cJmLgQuXV2EMAULPMVyJhpIuKWjQrCUXJmxXe7mNEM/97RVv5bU3KVaJEUAGgklO6L4cA==
X-Received: by 2002:a05:600c:3b83:b0:3cf:5d41:b74b with SMTP id n3-20020a05600c3b8300b003cf5d41b74bmr1849391wms.184.1668185846282;
        Fri, 11 Nov 2022 08:57:26 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id f7-20020adfe907000000b0023677081f3asm2302241wrm.42.2022.11.11.08.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 08:57:25 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wei Yongjun <weiyongjun1@huawei.com>, linux-usb@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: ftdi-elan: remove variable l
Date:   Fri, 11 Nov 2022 16:57:24 +0000
Message-Id: <20221111165724.557152-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

Variable l is just being accumulated and it's never used
anywhere else. The variable and the addition are redundant so
remove it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/usb/misc/ftdi-elan.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/usb/misc/ftdi-elan.c b/drivers/usb/misc/ftdi-elan.c
index 33b35788bd0b..8ce191e3a4c0 100644
--- a/drivers/usb/misc/ftdi-elan.c
+++ b/drivers/usb/misc/ftdi-elan.c
@@ -1624,7 +1624,6 @@ wait:if (ftdi->disconnected > 0) {
 			char data[30 *3 + 4];
 			char *d = data;
 			int m = (sizeof(data) - 1) / 3 - 1;
-			int l = 0;
 			struct u132_target *target = &ftdi->target[ed];
 			struct u132_command *command = &ftdi->command[
 				COMMAND_MASK & ftdi->command_next];
@@ -1647,7 +1646,6 @@ wait:if (ftdi->disconnected > 0) {
 				} else if (i++ < m) {
 					int w = sprintf(d, " %02X", *b++);
 					d += w;
-					l += w;
 				} else
 					d += sprintf(d, " ..");
 			}
-- 
2.38.1

