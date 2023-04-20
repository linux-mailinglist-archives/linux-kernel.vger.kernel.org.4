Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86BBC6E8B69
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 09:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234005AbjDTH1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 03:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234079AbjDTH1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 03:27:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE83140E7
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 00:27:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C60C6457C
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 07:27:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDA04C4339C;
        Thu, 20 Apr 2023 07:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681975647;
        bh=nLYlbVPXbkQhw3xO61r9sU3kjNoF334X7TCrjFKx+Ic=;
        h=From:To:Cc:Subject:Date:From;
        b=H2f/Nisjpr3Ya3m04NmdNRvLgEo1wi+RMZtxzNBDYfQHKsS4QL61ETxstUmVTDIvn
         eB2R/Ilsu10ZSAQGkyXlyNFes+sa04HQFi3bZp6ZjBtMI88duJu8zVXfmNDT+2qhoV
         mseL4rGIEHcQi0+g78hukGb1oK3OhfQAqsG40OaoGYwKaWK3K6+ArUZxmoKtBltj2g
         HcGwZT9IdoM+I9GbiI7jXl4Ywc0f/9E6xQMBdtxM5pAoLih/WClrBrRggFlNFhhNh5
         HRWZyYbZLBz2bCew5ylfsXC9zHmtVxYCwq2vsgIEmSk6eo0bsI+YAJNQxw0kODNkYF
         Oiph0sthEdf7g==
From:   Lee Jones <lee@kernel.org>
To:     lee@kernel.org, jassisinghbrar@gmail.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] mailbox: mailbox-test: Explicitly include header for spinlock support
Date:   Thu, 20 Apr 2023 08:27:17 +0100
Message-ID: <20230420072718.881079-1-lee@kernel.org>
X-Mailer: git-send-email 2.40.0.396.gfff15efe05-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Presently the support appears to be implied.

Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/mailbox/mailbox-test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mailbox/mailbox-test.c b/drivers/mailbox/mailbox-test.c
index 4555d678fadda..51e62817f2438 100644
--- a/drivers/mailbox/mailbox-test.c
+++ b/drivers/mailbox/mailbox-test.c
@@ -16,6 +16,7 @@
 #include <linux/platform_device.h>
 #include <linux/poll.h>
 #include <linux/slab.h>
+#include <linux/spinlock.h>
 #include <linux/uaccess.h>
 #include <linux/sched/signal.h>
 
-- 
2.40.0.396.gfff15efe05-goog

