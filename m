Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B52776454BB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 08:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbiLGHkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 02:40:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiLGHkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 02:40:18 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92BC9338
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 23:40:17 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id w37so15547575pga.5
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 23:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dC4TMwQXle2CEuFAKSViCaKm4V2S4kBREOfxx+v90hQ=;
        b=JLZSrHm7cSdoOaZ6GlESOfZDxTaEa++sKJcTtmT0lKqgVVhXCB225oOwm2a4u/L5r7
         6//xjS+hxn91j4BMwxCG26Vvve0qqtVMU1Ra2nv/p+1yFowXTc5Ad4WAYBbl5XQuzEcQ
         ANf0NBxgSqFnPLw0i8MigD5QDbf0HfwOy7ztUcb+KprWP6Oy7DCx2LIKEgUmL70TL5Fj
         rr0Xi0nsUwnjihUIKooo9IwimcxY6paJD90sPqq8blCifpoeI5hn1ETu0JMPSJASRoyn
         OCLStPQW3hjDhV+OfGzFD3jz2m9Y0bDqN8BY4cm1fuSsCzwAqKT4pfnSjP/tSI89H+DQ
         7MHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dC4TMwQXle2CEuFAKSViCaKm4V2S4kBREOfxx+v90hQ=;
        b=2i3bzyejV5F5WQ+NmCpsBMtetJ48+ZTrKGHnjnPw8Kdhv3NuPhqUs4GYTa0iOxaBM6
         W25M8iwl4DblgunbuRUxmO8bCA2Ufy1BSVMvtb5T5juZasqaqMdLinubzkAOoV2+t57w
         pNr8JgKVIKNWwkww9Jvh4MaFnrCrhOgEVBVtAZln+vR2CnM5b/2wrcHQelwV9+SxZ/ZE
         tImThju1be8ZDIvOXsADULCdqPZw1h7zDN4hPlBT7MRntN0dzTXW8rYt0nHWr8K1JUE1
         SkpMyckEIEwy3T6BglRIGjwYnx3zrqMgwNdkbXhuGVYL724jh0RwbKLfnZoFVXB2x/VI
         1SxQ==
X-Gm-Message-State: ANoB5pnt9M/7ba9wd7oMsVzUtkDUm+gjjNvqdUhFOU8wbcJKK1W/ZNs1
        aCJLit+SIi1wE0m4qAisn4U=
X-Google-Smtp-Source: AA0mqf7qcVeLATWy21idezbozBqYcnn4qlbqDeTQX+XJeK4Cfsu8ABNaGuG+pBX78UPky/vtZ6qSwQ==
X-Received: by 2002:a63:ff0e:0:b0:434:aa69:bba2 with SMTP id k14-20020a63ff0e000000b00434aa69bba2mr79320896pgi.567.1670398817084;
        Tue, 06 Dec 2022 23:40:17 -0800 (PST)
Received: from cloud ([185.216.119.110])
        by smtp.gmail.com with ESMTPSA id t12-20020a170902e84c00b001867fdec154sm13930840plg.224.2022.12.06.23.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 23:40:16 -0800 (PST)
Date:   Wed, 7 Dec 2022 07:40:11 +0000
From:   Wang Yong <yongw.kernel@gmail.com>
To:     akpm@linux-foundation.org, ying.huang@intel.com,
        baolin.wang@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm: fix typo in struct pglist_data code comment
Message-ID: <20221207074011.GA151242@cloud>
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

change "stat" to "start".

Fixes: c959924b0dc5 ("memory tiering: adjust hot threshold automatically")
Signed-off-by: Wang Yong <yongw.kernel@gmail.com>
---
 include/linux/mmzone.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 5f74891556f3..128f3cde800c 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1200,7 +1200,7 @@ typedef struct pglist_data {
 	/* start time in ms of current promote threshold adjustment period */
 	unsigned int nbp_th_start;
 	/*
-	 * number of promote candidate pages at stat time of current promote
+	 * number of promote candidate pages at start time of current promote
 	 * threshold adjustment period
 	 */
 	unsigned long nbp_th_nr_cand;
-- 
2.25.1

