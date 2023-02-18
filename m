Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFE3E69B7D9
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 04:13:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjBRDNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 22:13:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBRDNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 22:13:02 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A33D119F0B;
        Fri, 17 Feb 2023 19:12:58 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id u14-20020a17090a4bce00b002341fadc370so3160902pjl.1;
        Fri, 17 Feb 2023 19:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Go/rrb42F/i0f8PVYoy8oUwA/BFEAezoQHrQtZBPKeQ=;
        b=S0jKcsmQGoogHrpeU1NrfXgmk0MTiRqFtheVmPi+zbKzd5R0ZLdndMJtl9/SDHSpFh
         7ELqFz7Ap1Glj5DiFwIrowahLwf2XWwnSWwxuObJl/nqFJo9XkwDWMzL4bDMKi+Zg1+y
         u0I+x4W1T7c5Pdyyf/p+zgfGCRQzsj3mV9M4l+oTrdU8W5CSaLTLnYnErkpSFy5BArUd
         CFkWfMRDcwbYTa7HQuHuQjEocASmzGmGW61nBf/5Xs/BVp9G1ZuRW4iKlvFN/5SVLPgf
         KzyE/YGHtFN8r9p99uCsC1EzXcwRg7/4r73jJQCoCq21xvQ4qTiNBItzFttAghOdeY8e
         IXrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Go/rrb42F/i0f8PVYoy8oUwA/BFEAezoQHrQtZBPKeQ=;
        b=0rYPkq56uc2M6fQJXoxAKqDv+xQzOnUYXqe+8jsyiF257aKIGcmXIBRqwJCiGIKKrV
         7nbDSA0Yj+12vX7hxne7ww+bvbHot4CwloGfS5dzIga+wM/rTos5Ns5MOtDJNeCBouKV
         EjRKxzg+6ycyUTNahzlFSQzYMkCY9Sb0y9ySlTFXsfzINMhvMu+cCKw2CXFDssdVyrN6
         lx3bvhqpxdpUYNcX19ptHnFDU3M6sqQvPWHe6sbFUJ5oKC2z5K3hEjhNYgwCsM4dMfkd
         ZDjK1rYxSBMyDPzcVZ7/e+ac1u6LGtk3lhx+LfTv6rG5M6R0leuLNALbAfkjH+d7QTjj
         dNyA==
X-Gm-Message-State: AO0yUKVxr6P7udWR5IokW5pC5cAbp2TQ4wcGT/Iu6ZKVKFtnClvow8SP
        BlIFnNy7EJ8rEmh/jkzIAZk=
X-Google-Smtp-Source: AK7set/zisvzpVF1oVA+rUrz5DdY9o/hLU9ndApIrHUKrNKXORjyY3Ko0UX5Gtp6FPym29v9PopdzA==
X-Received: by 2002:a17:902:f686:b0:19a:a647:1891 with SMTP id l6-20020a170902f68600b0019aa6471891mr2455870plg.67.1676689978086;
        Fri, 17 Feb 2023 19:12:58 -0800 (PST)
Received: from striker.. ([2401:4900:1c80:ffd7:ef1b:ca8:f52:fad])
        by smtp.gmail.com with ESMTPSA id u9-20020a17090341c900b00198f36a8941sm3757490ple.221.2023.02.17.19.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 19:12:57 -0800 (PST)
From:   Vishal Parmar <vishistriker@gmail.com>
To:     laurent.pinchart@ideasonboard.com, mchehab@kernel.org
Cc:     Vishal Parmar <vishistriker@gmail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] first patch test
Date:   Sat, 18 Feb 2023 08:42:37 +0530
Message-Id: <20230218031238.5747-1-vishistriker@gmail.com>
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

Signed-off-by: Vishal Parmar <vishistriker@gmail.com>
---
 drivers/media/usb/uvc/uvc_driver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index e4bcb5011360..c79dcee2213f 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -2082,7 +2082,7 @@ static int uvc_probe(struct usb_interface *intf,
 		(const struct uvc_device_info *)id->driver_info;
 	int function;
 	int ret;
-
+        pr_info("I changed uvcvideo driver in the Linux Kernel\n");
 	/* Allocate memory for the device and initialize it. */
 	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
 	if (dev == NULL)
-- 
2.34.1

