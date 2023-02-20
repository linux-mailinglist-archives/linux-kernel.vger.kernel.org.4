Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4BF69CF9D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 15:44:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232199AbjBTOo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 09:44:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjBTOo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 09:44:26 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 816211555D;
        Mon, 20 Feb 2023 06:44:25 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id bg37-20020a05600c3ca500b003e21e018039so2075249wmb.3;
        Mon, 20 Feb 2023 06:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GoVGloOBZkw+ZVyAnbX/LJByXhmIlf+jL2epYX5xU4w=;
        b=hYs7rM8UbOBWW4+Ml0n9QHWF2Jr1aO+fwKAQ/Oge7K740EcTNzWOkbSWX4CJ2rM1lg
         dU/oYDQLhNs7B5WF8M7+VNWdWVFWDinFUHzYs/PHYr0yUd/mOMq8ZL1QLMsTzaVmh+TU
         iFD8vUx9YyspA0O7Ufcl3rubUo71ay4NApKqrRenPWnX1C/hbhzuUZE8adbIoiUyOrAs
         0t8uxMlMqKQBdNjGsHyHMW+2Y2J3ckGT8XKqv3paORf9Q3FQzbeCYu0dXrGsdcKr1eRE
         8RQqIz0qwxr0Wt/vkrDcJxOsXRQK2Yol/90/F6cywOoHrS/scG+4bmhoaNQnaekR6m41
         TkeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GoVGloOBZkw+ZVyAnbX/LJByXhmIlf+jL2epYX5xU4w=;
        b=CBlqHYPZRCw+XFwk98FLgKQrbIG81g2DY8vBjmbzOWlAK09F/COptp9xearcrdNUmD
         RHmVGEyhR2JoI+jM61SVMvvkkd+mFbRAdUOlPdX9j6XJTRbPFpjxDPRUv5ztj8kDXqpD
         i17PL0w9FzbEP+w29WEoxBFEYzl8P4hLXsn5VWRN1WfKKT4jPjJaGCYtlBIuLIOOuPn5
         JGiDtZ+xYySwlPla+L5W/wUXyYqB2b3xQ3h8CwFh2VGqYTGLkmLy6nEnyAXKMs1t+3as
         LrfIPhAajJJ4Rq6POBWVuUposQ8o8pd96d8aVGyrYhAS+QQjpksIHZ9XnzVPczK/Au7R
         ipwg==
X-Gm-Message-State: AO0yUKU97tGMzNL7mjErMHT2KX5BUMTHZ+GRL6mymCivsfGjx7kLisjn
        0qsj71fYgtPfDvlqY1D74B8=
X-Google-Smtp-Source: AK7set9IE7HOSZDZgMmccuHfWHe65GIO0gQQEpfT9G+zufqe0IBsuL7NA0ndfQe6bju3HPRc5qJeww==
X-Received: by 2002:a05:600c:198e:b0:3e2:1f00:bff7 with SMTP id t14-20020a05600c198e00b003e21f00bff7mr1069910wmq.12.1676904263882;
        Mon, 20 Feb 2023 06:44:23 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id r5-20020a1c2b05000000b003ddf2865aeasm1339840wmr.41.2023.02.20.06.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 06:44:23 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] of: dynamic: Fix spelling mistake "kojbect" -> "kobject"
Date:   Mon, 20 Feb 2023 14:44:22 +0000
Message-Id: <20230220144422.873356-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.30.2
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

There is a spelling mistake in a pr_err message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/of/dynamic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
index 12aa99018969..07d93753b12f 100644
--- a/drivers/of/dynamic.c
+++ b/drivers/of/dynamic.c
@@ -350,7 +350,7 @@ void of_node_release(struct kobject *kobj)
 		if (!IS_ENABLED(CONFIG_OF_UNITTEST) ||
 		    strcmp(node->parent->full_name, "testcase-data")) {
 			dump_stack();
-			pr_err("ERROR: next of_node_put() on this node will result in a kboject warning 'refcount_t: underflow; use-after-free.'\n");
+			pr_err("ERROR: next of_node_put() on this node will result in a kobject warning 'refcount_t: underflow; use-after-free.'\n");
 		}
 
 		return;
-- 
2.30.2

