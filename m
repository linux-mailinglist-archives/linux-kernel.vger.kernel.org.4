Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A38AA5F4DD9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 04:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbiJEClZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 22:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbiJECk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 22:40:57 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2017F7285C
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 19:40:42 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id 20so141229pfv.10
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 19:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=DN/b5T+8kphGI07HeDS7OSncXPJKUwL2fM68wERZKzg=;
        b=A5kGZyAc89qJ6kCK+avCVDOQG1rFYV91pRcMvTTasAf2EYsXRpQpjJUbxTIZWNYp/U
         tR3G2yINER6ubc6Bspe9CVNl7paAZ6+T+Y3aMg58w8aCubOInq9g1WosGIEw+NKywp79
         pycw5By4BANOR5O+SdakZ0LlV2uX+3hYKKI1A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=DN/b5T+8kphGI07HeDS7OSncXPJKUwL2fM68wERZKzg=;
        b=08DJzm19aRQ+cGLzHzKVF7GarJBEazP1qm09GHfo6fi3RI8XTTugy+vxuozu4WSOm7
         A80LH05GmjLeZBq2B/6E1To2qirQFiGn7dAH82eFS9yWD/FNbLh2YqNlhjLRyn1W+skO
         Z4xPpWL6lUC5Ryl2fnjTOmsZkxgW1hTIVxMxWNHvoKQjdpuTNXU2Nf76BUpBThPe5TH3
         OdqFZeL9e9OG1agrQ2EuNaswOVry3VQvGK3C9x/QuALRvM0qbBqXIJfWKNJ15FWHtesO
         mxhjGvh30UGoT0aEcH286hxYmECmNZ5tgw3s9hHxNdq6GWiDKAFxkUhUIhlnY0iuYsLo
         Mmzw==
X-Gm-Message-State: ACrzQf0qVlpSaI0SnIdCzN0zgA/0Fr4ATjes63CXUbAqLgH3ttMTsc++
        UpSgSiVy3vhp1RWy9DaHx8UBMd3g4LORpA==
X-Google-Smtp-Source: AMsMyM4qnyp8LALoSSGOuSMXcvCq/sedhpFwnyOvLhb01JSAifeO2MfhxV2+H5u4J+CRxx8WwkrqAA==
X-Received: by 2002:a63:2cc2:0:b0:41c:681d:60d2 with SMTP id s185-20020a632cc2000000b0041c681d60d2mr24659853pgs.502.1664937642099;
        Tue, 04 Oct 2022 19:40:42 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:a9d9:6396:ee12:8be8])
        by smtp.gmail.com with ESMTPSA id a14-20020aa794ae000000b00561e010a309sm1673579pfl.19.2022.10.04.19.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 19:40:41 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv2 8/8] zram: correct typos
Date:   Wed,  5 Oct 2022 11:40:14 +0900
Message-Id: <20221005024014.22914-9-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
In-Reply-To: <20221005024014.22914-1-senozhatsky@chromium.org>
References: <20221005024014.22914-1-senozhatsky@chromium.org>
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
index ce9413040ad4..9d54dbc72cb0 100644
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
@@ -1657,7 +1657,7 @@ static int zram_recompress(struct zram *zram, u32 index, struct page *page,
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

