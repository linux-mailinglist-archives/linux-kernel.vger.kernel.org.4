Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 129F5730555
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 18:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236321AbjFNQpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 12:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238639AbjFNQpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 12:45:11 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F22A326A6
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 09:45:00 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1b3dd3ca7adso24445735ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 09:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686761100; x=1689353100;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+mtQ9KRgsRV3qb9QuuaC8ZHbI3X0Zw+V38td7BGTBqI=;
        b=j6SmFN2Yd9SEmBnmduo/sXgL3GdVdW191lYP9PKrlEWZXDPohVmh21QZKCMmLFICfi
         2O5TkdEok4yQ27votYVvZIq31e0INlTtNojlFiJT0VXLC6SxwH9pQgavHqcsrENHs2sl
         kRAB3ufu1fxZxP+eibzvJSi7h9eJhEogFm9PSob8PoO7QTjrLwvRrnM7iQmrBaGUnA1V
         iVqkcgL7dG6nMMw7lE9q7Ib6H7UQHfwn4/GiaJbAv4gtJ17cYriuIaAgrYDfSYaJ2Vjl
         YVI3HxnOh4VbMeN7djrYL05w/WSLL7guZd1Ru7Ei+LmTSw70LGIQqCxQhHvRhMf1P/xa
         xXnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686761100; x=1689353100;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+mtQ9KRgsRV3qb9QuuaC8ZHbI3X0Zw+V38td7BGTBqI=;
        b=ir50GoOdUM73XIdFWo6isuexm1k2osFrAJOsr6r4RJ9wpeNAqzV+vVk5cLASU5Ue44
         mV5mP6w91vwQW9JR6fv7Cai6HKe2zGQBgxHcOYKI3q3fgEEsLFsqNgorIfOlUgHgEC/E
         FSlmhIVlD1qItVUi3x8xlRq+NnFD7IgVFWVtlYPqgUorZNvLZIF88uvOAAZix3YMECBh
         dPJJ33gux4lzYIJKCGEI/L/y5X1Ee7zkeTPumiWzZCWTiqH+E7U9EGfjOYv5+vFnpG6n
         mRwX1mzAfm/la5sjOKoR3g9N07sofk0CZD8gEfMwZ+fev7xKBrhVpoHAGM53Rh8qqK5k
         0k2g==
X-Gm-Message-State: AC+VfDyOJyQPjV1sPpIFXcvdbI5iM05Ixra0hNZIPQMOtiCxfws7aXFH
        pBHU3k9lWSAQdnSq4RWV8vZVwQsKScVJyiSI
X-Google-Smtp-Source: ACHHUZ6qVGJjFwohn/hFX5/jfRd/U83DOW+MztgzbSaWrfoIvYkCFtiHHzRfPBKD5NgSY+/aTbQzsQ==
X-Received: by 2002:a17:902:f7c3:b0:1b3:cc77:c8ba with SMTP id h3-20020a170902f7c300b001b3cc77c8bamr9063957plw.59.1686761100334;
        Wed, 14 Jun 2023 09:45:00 -0700 (PDT)
Received: from sumitra.com ([117.245.169.18])
        by smtp.gmail.com with ESMTPSA id jd4-20020a170903260400b001b3b83b7d4esm7576873plb.211.2023.06.14.09.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 09:44:59 -0700 (PDT)
Date:   Wed, 14 Jun 2023 09:44:54 -0700
From:   Sumitra Sharma <sumitraartsy@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Ira Weiny <ira.weiny@intel.com>, Fabio <fmdefrancesco@gmail.com>,
        Deepak R Varma <drv@mailo.com>,
        Sumitra Sharma <sumitraartsy@gmail.com>
Subject: [PATCH] drivers/target: Call page_address() on page acquired with
 GFP_KERNEL flag
Message-ID: <20230614164454.GA390511@sumitra.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rd_allocate_sgl_table() acquires a page with alloc_pages(GFP_KERNEL, 0).
Pages allocated with GFP_KERNEL cannot come from Highmem. This is why
there is no need to call kmap() on them.

Therefore, use a plain page_address() on that page.

Signed-off-by: Sumitra Sharma <sumitraartsy@gmail.com>
---
 drivers/target/target_core_rd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/target/target_core_rd.c b/drivers/target/target_core_rd.c
index 6648c1c90e19..d8ea6aff39a2 100644
--- a/drivers/target/target_core_rd.c
+++ b/drivers/target/target_core_rd.c
@@ -159,9 +159,8 @@ static int rd_allocate_sgl_table(struct rd_dev *rd_dev, struct rd_dev_sg_table *
 			sg_assign_page(&sg[j], pg);
 			sg[j].length = PAGE_SIZE;
 
-			p = kmap(pg);
+			p = page_address(pg);
 			memset(p, init_payload, PAGE_SIZE);
-			kunmap(pg);
 		}
 
 		page_offset += sg_per_table;
-- 
2.25.1

