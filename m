Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 002E2646B9E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 10:12:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbiLHJMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 04:12:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbiLHJLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 04:11:41 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BEB8197
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 01:11:04 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id w23so925877ply.12
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 01:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZT7juylwnKh3T2iugjGE5oqHsZy741d4XwrJwog0DPo=;
        b=iTJu2oQmIIxTq/b0KUP9hOUYl/olqaOeYRfF9fIC3y+Rhih6XLVy3OzYoG5j8ZJj2t
         9oLF6kml/VGVJhkN2zuesCATLot4K53gZtGB0Ap6X/zdn4ZOorJfTR5nFKg3l53qo2Ly
         akiRC5apxR6PMX1ykwe9OJAwHB5d9anrgwzYjVtaAntSaAXLFHAsT4J5XRZdoD7AWoMU
         Sa30dLJTILTIg+ySltTuHKmVhCzl1Ff4ZWEx99DkNXtB/v8ppAuPzm0FZSwRW7CKfAAK
         7dfzJ9WMycWynO6cvWyTajP6Zi90S/NO0JUiZXsLhko+Z1Fs1dc44yzQjU3m6ZpDHFFa
         SSAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZT7juylwnKh3T2iugjGE5oqHsZy741d4XwrJwog0DPo=;
        b=o4eKvl7se5g0hHXeNBYYBq2537Hm8McFJja1nlefgcVfIrFwIxvagCdnc7aDHHuA1R
         LRag6AIf86hrce9sx/9LObX5UX73++rQvdDfozbfVOb2OKsrRXvY8aVlhZXMcaSG+x/c
         i+LgWB4uiRZyANKAVHMGVOCPz/pKsFdcy+HBCtGgb7qStUyD/exO4lciL0X/9RAYyP2r
         xi7jjFAAUlExRU/TVHUuIs0yw8mln0+wtlx2reyfUroeD2deyQH4rKNxt8rZe7GxRh6K
         X8ZEUcsFxwNA5Qvm2emJUQqd0Y/GVuy/PgTm+zsXlx10JFfJsxfEhRVImb12zZj3mU0t
         6wbw==
X-Gm-Message-State: ANoB5pm1LnxX2Tog0cnnTspSrWcrNvK8sfN6uM81GZwWKcjf4fv3NiI4
        Huf2qtH5J0VGuBFn5R+sG2GNhYEeF4U18g==
X-Google-Smtp-Source: AA0mqf6zTBj0mVhpKSKEzhQFcO/21lA71JMOJqm2AgiU5mIRyTjlLz4hR7FGtmo37TePCLSda//EpQ==
X-Received: by 2002:a17:90a:ac0b:b0:219:9874:c7d3 with SMTP id o11-20020a17090aac0b00b002199874c7d3mr27001623pjq.221.1670490663653;
        Thu, 08 Dec 2022 01:11:03 -0800 (PST)
Received: from zoo868e (1-170-0-91.dynamic-ip.hinet.net. [1.170.0.91])
        by smtp.gmail.com with ESMTPSA id x12-20020a17090abc8c00b002132f3e71c6sm2430633pjr.52.2022.12.08.01.11.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 01:11:03 -0800 (PST)
Date:   Thu, 8 Dec 2022 17:11:00 +0800
From:   Matt Jan <zoo868e@gmail.com>
To:     Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH 1/3] staging: vme_user: add the spaces around the "*"
Message-ID: <20221208091100.GA95120@zoo868e>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a space around the "*" at vme_bridge.h to clear up a checkpatch
check.

Signed-off-by: Matt Jan <zoo868e@gmail.com>
---
 drivers/staging/vme_user/vme_bridge.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/vme_user/vme_bridge.h b/drivers/staging/vme_user/vme_bridge.h
index 0bbefe9851d7..e17a8f7de165 100644
--- a/drivers/staging/vme_user/vme_bridge.h
+++ b/drivers/staging/vme_user/vme_bridge.h
@@ -4,7 +4,7 @@
 
 #include "vme.h"
 
-#define VME_CRCSR_BUF_SIZE (508*1024)
+#define VME_CRCSR_BUF_SIZE (508 * 1024)
 /*
  * Resource structures
  */
-- 
2.25.1

