Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B76166458DE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 12:22:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbiLGLWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 06:22:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbiLGLWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 06:22:32 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF4712E695;
        Wed,  7 Dec 2022 03:22:30 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id y4so16738648plb.2;
        Wed, 07 Dec 2022 03:22:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G43qICGmW3svAz/Oqna8zUPfVdBeq81tXpFt94ZZJn4=;
        b=RsuVDwA7faWz631xDIv+QgFb8PsQynqPNNird4vSN5DMYxSjIOHhcx8Mgg41WMxyPT
         Ex2kXHayr/uHbgDrz924HxW87fecO+4+T0H8Bf8VYRbYCO/xRDEWe0wS7y2oazy6H3Vi
         uX3v2LyGBe7tOWx8VJ+aK6QkD7hjL7bBYG4AAYR789cP6fRViwCy65wSw9YlmamfbOIN
         QmzmeRtP6yO8EsfZnRELRZon7Vte42KR3P3UWRR9xojQcIOQnn/7TbtJBMNvPjovBK+8
         pdcjT+jELnNGnWE4+BxlIR5ZRoVZWFjQoeVEfuOIfmXrgEN7TryGPidOlperNQkK/tXQ
         6IBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G43qICGmW3svAz/Oqna8zUPfVdBeq81tXpFt94ZZJn4=;
        b=ShFrhf8v2EsdOdlGIV1ByU7kM1l4O2JQahbfrzqEhiVuII6FiB6rDxFv7OfHif+bg4
         9FBYwKxGGviuaXZwYF6bDAs91Ek7hN+O264RNzQIKZpsHB6TfdNo5f4SXsFMfjkZzo31
         6JhBu8fFGb1mJ0KSIJkO4y1UyzBUbH7KmfnMRP04kUfajzD3dcPGS+G0FZLcBdUyGMKH
         hl13GKO0WO5RRC1N6Cbs4KZHX2xj5rRregkV66x/z270Q4G5bwHbc6hTIwXBrkkw9a+x
         vGUsMYHJhiGZK0CPspTwgFJ0ZCb1pqVmixi+cV8uKKY8eQ1R7IrMbm/eW3GHJLHJ83vU
         v1qw==
X-Gm-Message-State: ANoB5pnlIJJs14GNVchTJ/I0kiB+0dfUn9KIAFQFGCjQ71ZodMVp8yt8
        Sc9duD6yefi/6PawFTosM54=
X-Google-Smtp-Source: AA0mqf4CnN8oN9NIvpwszl6rDgmDVJ8EZR6IPv58LP8dKR5u/9BO4YWo+pTxKwXYPGlsYM6J6NwDnQ==
X-Received: by 2002:a17:903:248c:b0:189:c8d9:42e9 with SMTP id p12-20020a170903248c00b00189c8d942e9mr19671158plw.124.1670412150109;
        Wed, 07 Dec 2022 03:22:30 -0800 (PST)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id im15-20020a170902bb0f00b00189812a5397sm14273280plb.180.2022.12.07.03.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 03:22:29 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] device property: Fix documentation for fwnode_get_next_parent()
Date:   Wed,  7 Dec 2022 15:22:18 +0400
Message-Id: <20221207112219.2652411-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use fwnode_handle_put() on the node pointer to release the refcount.
Change fwnode_handle_node() to fwnode_handle_put().

Fixes: 233872585de1 ("device property: Add fwnode_get_next_parent()")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/base/property.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 2a5a37fcd998..daa1e379762b 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -601,7 +601,7 @@ EXPORT_SYMBOL_GPL(fwnode_get_parent);
  * node's parents.
  *
  * Returns a node pointer with refcount incremented, use
- * fwnode_handle_node() on it when done.
+ * fwnode_handle_put() on it when done.
  */
 struct fwnode_handle *fwnode_get_next_parent(struct fwnode_handle *fwnode)
 {
-- 
2.25.1

