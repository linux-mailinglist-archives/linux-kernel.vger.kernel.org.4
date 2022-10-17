Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA5B601B58
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 23:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbiJQVdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 17:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbiJQVdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 17:33:08 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC9757CB60;
        Mon, 17 Oct 2022 14:33:06 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id bk15so20461124wrb.13;
        Mon, 17 Oct 2022 14:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Mrrqbi0ETnzpqhsWzfV/EevlRMo1cT5WVvO8a9vtxFI=;
        b=UdHksNN5rbd+RRvD3BeLgx17CdEj+flAObUVYgo/sRpGqkAIUan5iaac3ySA8qkQkd
         hx7QqP4GyoXDJhwSq3nVouYXs6WH+8+GTb+0iu6RVkOhL900KXB7x7y3mGx9tc3w2Cbt
         daLkdaGHUZJo6LlVfb1DWX4A2IsthEaCLoc2LHEOzJIrcxVNXwqUC0+BWwPDjqluTxgP
         g78+v+UbeomWaUKDZf/8J1WCBJKwbJUFE5bLuQJ4WdR0jVVIi4J5Mtsanij9uK5V8mFm
         81nr5Won27d5y53ictdytiaZ+tJ0BWHwR8w9aA26c82fwwJ294zaE1C9DIXDqM/3av4V
         8/WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mrrqbi0ETnzpqhsWzfV/EevlRMo1cT5WVvO8a9vtxFI=;
        b=mnBHvreezLu1JVEuQh4xOVXQR+T1jSawIS8tcPzPq6dFdtpiAYI/mxBXypZArPKxFx
         CrUv8gWjVEFH2UokOBLeJOPl9ZVZBfbBlACahncQHRQksDqWbIyiQKq+prkYDUqkSqhQ
         sSBUGBVU8CbHWoC8WRpjP89KB/JuKfoo3ZeIZmofp/hp44wwYEbs17UMJqDXqW2JgPxd
         4RD4XXcgtB9gw57v5lr7gGvFWQAuhykSKmXZaGILUXjskvURBQobm59vgOBi2nEcrmr8
         vNSCUudLDVzvRdv6d3wm0n5YpWVTF83GMRN/W8gf4ozzcPL/O1/qqSoaXtfTP0PEUMQM
         hUVQ==
X-Gm-Message-State: ACrzQf2421HoXUqRuJs1xlrFvxJr6LbO3HTMgsgEn5dFP/aGGmqRXRDj
        9VggbuAgSbib0nri2HKzYmQ=
X-Google-Smtp-Source: AMsMyM477UyaymfEn2BUTuCU3QmLWSbebTtZ9HUU9ZTvd0l6IBA7/FDwH3gmK40/MblMYKXehCNNOA==
X-Received: by 2002:a5d:6745:0:b0:22f:ed4:65d7 with SMTP id l5-20020a5d6745000000b0022f0ed465d7mr7549035wrw.259.1666042384871;
        Mon, 17 Oct 2022 14:33:04 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id j19-20020a05600c1c1300b003c6c1686b10sm18151187wms.7.2022.10.17.14.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 14:33:04 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Anton Altaparmakov <anton@tuxera.com>,
        linux-ntfs-dev@lists.sourceforge.net
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fs/ntfs: remove redundant assignment to pointer m
Date:   Mon, 17 Oct 2022 22:33:03 +0100
Message-Id: <20221017213303.862794-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.37.3
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

The pointer m is being assigned a value that is never read, it
is being re-assigned to a NULL later on. The assignment is
redundant and can be removed.

Cleans up clang scan build warning:
fs/ntfs/file.c:194:3: warning: Value stored to 'm' is never
read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 fs/ntfs/file.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
index c481b14e4fd9..56d08374739a 100644
--- a/fs/ntfs/file.c
+++ b/fs/ntfs/file.c
@@ -191,7 +191,6 @@ static int ntfs_attr_extend_initialized(ntfs_inode *ni, const s64 new_init_size)
 				err = -EIO;
 			goto err_out;
 		}
-		m = ctx->mrec;
 		a = ctx->attr;
 		BUG_ON(!a->non_resident);
 		BUG_ON(old_i_size != (loff_t)
-- 
2.37.3

