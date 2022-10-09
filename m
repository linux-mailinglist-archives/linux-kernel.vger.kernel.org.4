Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79FB85F8A4A
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 11:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbiJIJIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 05:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbiJIJH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 05:07:58 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB23A31377
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 02:07:46 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id i6so8465444pfb.2
        for <linux-kernel@vger.kernel.org>; Sun, 09 Oct 2022 02:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yuRbPyGZZsBm+5IGqHamjUR/zxD3kPUYp8Ab64laoNc=;
        b=oOmLwkPegZkRA22IheBP7jpj4rmN4FNV+6EnSr8jIB4n5RzMMUBb94GoepCq8HsBWc
         wToGz+fobeVepMARste1oDCCsKjfC5vJ3MkWqQukaYD4qtrGqrEZq3tH6F+DfrHOdfHb
         kPbYtXBxq2sTBcE0H0EKh7MhwrpKsuyWl3O88=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yuRbPyGZZsBm+5IGqHamjUR/zxD3kPUYp8Ab64laoNc=;
        b=uyGTJX449Xqs9ajK0+U6e7Irt0yBXrGTzP6q6DBXQryFG07OsgXuCBiORKgcJ4qP7B
         Fsqb3RPF1CAobSmz7m2hpQ31Sx5BrH9uxkH67LCbXsiTvlaOBAPQn3UWuCTaP1lhjvkl
         /r8g3QXeJYxEdOVWrcOfh2pfEelNIj7YUeeMYgDok3fNfi0ImxP5QRbMyelA4oUy2TNm
         l00Z1SMQTvCF4aezYipWGBj/zAPCpJzXvBA8ZasJQQpCynJxQoKxeb0wNuGSvFEhv0Rz
         K20DXKQqflQquNMuZxT8GhZThGzIM9uqQNnkZmxlrEM5KwIfpa5SJ6kR9cBrstMFuhqH
         msEw==
X-Gm-Message-State: ACrzQf2DDSDbtautVKVHnV6BBAx63KIKPxdKfGl6FjD2XICfPGNPH0Bk
        T/zFwCA8dyd4/csIil5w+AEWOknT/G59wg==
X-Google-Smtp-Source: AMsMyM7emD3Idi1m55hr8/6YiYa0jBoU5n5s7t3oFzxQwBHDrOMjbsnZwwXmfSQt4BFw/i9VJmJBOQ==
X-Received: by 2002:a63:6905:0:b0:43c:d4:eef4 with SMTP id e5-20020a636905000000b0043c00d4eef4mr11578195pgc.126.1665306466139;
        Sun, 09 Oct 2022 02:07:46 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:8517:d51e:5fe9:9be7])
        by smtp.gmail.com with ESMTPSA id q194-20020a632acb000000b00439d071c110sm4335148pgq.43.2022.10.09.02.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Oct 2022 02:07:45 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv3 8/8] zram: correct typos
Date:   Sun,  9 Oct 2022 18:07:20 +0900
Message-Id: <20221009090720.1040633-9-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
In-Reply-To: <20221009090720.1040633-1-senozhatsky@chromium.org>
References: <20221009090720.1040633-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Trivial comment typos fixes.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 34bb21691cee..ecbc5963b5b8 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -759,7 +759,7 @@ static ssize_t writeback_store(struct device *dev,
 			zram_slot_unlock(zram, index);
 			/*
 			 * Return last IO error unless every IO were
-			 * not suceeded.
+			 * not succeeded.
 			 */
 			ret = err;
 			continue;
@@ -1658,7 +1658,7 @@ static int zram_recompress(struct zram *zram, u32 index, struct page *page,
 	/*
 	 * Either a compression error or we failed to compressed the object
 	 * in a way that will save us memory. Mark the object so that we
-	 * don't attemp to re-compress it again (RECOMP_SKIP).
+	 * don't attempt to re-compress it again (RECOMP_SKIP).
 	 */
 	if (comp_len_next >= huge_class_size ||
 	    comp_len_next >= comp_len_prev ||
-- 
2.38.0.rc1.362.ged0d419d3c-goog

