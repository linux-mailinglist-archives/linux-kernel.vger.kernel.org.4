Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 606B0737371
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 20:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbjFTSCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 14:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbjFTSCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 14:02:04 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A3EF1995
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 11:01:56 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6687466137bso1557049b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 11:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687284115; x=1689876115;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3EwBl0XaiIO54g7L7UjAnszZLl2VR52IrplzddXZU+c=;
        b=iQW6+b1Oph+u6iCyX6ZODZCGY4R4Enf/2pvdZCVPk+5qz0m5sINbl02H8l+pmgabXu
         D/IvorfPuy5rw9GoMtJc6AyHg7Pb67Ad3hYRFoK3ZLj5q2UjCAO6YNChdl+cEO1wLXr4
         NbnobWQbw/Ke2bi+bwf/QOnhJe8hc1dfKhXjhnNei9t6etdxBmxGMTA36owsI+U6c8Nw
         jPA9pFnYwfLtiZs6OJksdJW7LXUSlYFhno+bs3qu/zNtsKqQNdFtT3+oDdaLJBC3GFqv
         ww945Ntn/t9mG2/xvrwYg/rYoL4ooSVSt0YHVZDf+t5NVAm38a+54LOoO/4+zI+nNEMS
         Imxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687284115; x=1689876115;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3EwBl0XaiIO54g7L7UjAnszZLl2VR52IrplzddXZU+c=;
        b=D2sxYPYg+phjvExQJcXOU3VyJMpx5U4kbRDlQ+7Pt8uSquTIcPCHVMj3pcGmNedKiP
         pWgZBRl6XLQQpmhcHJSsR5LTeGEusaHg1OUFQY5rzHoCTwbBCupN6KfpbIX3sU1sVWsq
         6IVCkolSpdKihyE4Pl2d+RME65Oku72W2cKlsmabLuH6Jleb16pv+gGBR/mZ11ehi/RC
         bkZMLOuGA8zH7jQwmH7st8xg+1hXP00CuV2BprT9hNjtAMYIphIgFUJgoP2wO1P+SCyd
         rlmcg5k8Rfwkemw0tl50TVvhv1uMRrZl9I8c3GsB9jTjBweo6ncXomntBO0BUGkupNCq
         Df6A==
X-Gm-Message-State: AC+VfDytPM8NyswFZZ1a1CMlYLva8Z9uj6/f2VMJhi7vAu0X+dxaXyDo
        qraE+Qhx7d/L7ej/+Fk7Uzs3tNUupKtk9IR0
X-Google-Smtp-Source: ACHHUZ4iyl7yHia6txNusntUMnGBSJEz1FTmrXLxRe5BhqHFADhX0t7zW+LF/J48D7lHEOtzBgcytw==
X-Received: by 2002:a05:6a20:3d85:b0:118:a48:8977 with SMTP id s5-20020a056a203d8500b001180a488977mr10390846pzi.3.1687284115289;
        Tue, 20 Jun 2023 11:01:55 -0700 (PDT)
Received: from sumitra.com ([106.207.162.67])
        by smtp.gmail.com with ESMTPSA id r8-20020a62e408000000b0064550f76efesm1596101pfh.29.2023.06.20.11.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 11:01:54 -0700 (PDT)
Date:   Tue, 20 Jun 2023 11:01:48 -0700
From:   Sumitra Sharma <sumitraartsy@gmail.com>
To:     Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Ira Weiny <ira.weiny@intel.com>, Fabio <fmdefrancesco@gmail.com>,
        Deepak R Varma <drv@mailo.com>,
        Sumitra Sharma <sumitraartsy@gmail.com>
Subject: [PATCH] drm/gma500: Replace kmap{,_atomic}() with page_address()
Message-ID: <20230620180148.GA419134@sumitra.com>
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

Remove unnecessary calls to kmap{,_atomic}() when acquiring
pages using GFP_DMA32.

The GFP_DMA32 uses the DMA32 zone to satisfy the allocation
requests. Therefore, pages allocated with GFP_DMA32 cannot
come from Highmem.

Avoid using calls to kmap_local_page() / kunmap_local() and
kmap() / kunmap() in the psb_mmu_alloc_pd function. Instead,
utilize page_address().

Remove the usage of kmap_atomic() / kunmap_atomic() in the
psb_mmu_alloc_pt function. Use page_address() instead.

Substitute kmap_atomic(pt->p) / kunmap_atomic(pt->v) calls
in the psb_mmu_pt_alloc_map_lock() and psb_mmu_pt_unmap_unlock()
functions with page_address(pt->p). This is possible as
pt = psb_mmu_alloc_pt(pd) allocates a page using
pt->p = alloc_page(GFP_DMA32).

Suggested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Sumitra Sharma <sumitraartsy@gmail.com>
---
 drivers/gpu/drm/gma500/mmu.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/gma500/mmu.c b/drivers/gpu/drm/gma500/mmu.c
index a70b01ccdf70..59aa5661e56a 100644
--- a/drivers/gpu/drm/gma500/mmu.c
+++ b/drivers/gpu/drm/gma500/mmu.c
@@ -184,20 +184,15 @@ struct psb_mmu_pd *psb_mmu_alloc_pd(struct psb_mmu_driver *driver,
 		pd->invalid_pte = 0;
 	}
 
-	v = kmap_local_page(pd->dummy_pt);
+	v = page_address(pd->dummy_pt);
 	for (i = 0; i < (PAGE_SIZE / sizeof(uint32_t)); ++i)
 		v[i] = pd->invalid_pte;
 
-	kunmap_local(v);
-
-	v = kmap_local_page(pd->p);
+	v = page_address(pd->p);
 	for (i = 0; i < (PAGE_SIZE / sizeof(uint32_t)); ++i)
 		v[i] = pd->invalid_pde;
 
-	kunmap_local(v);
-
-	clear_page(kmap(pd->dummy_page));
-	kunmap(pd->dummy_page);
+	clear_page(page_address(pd->dummy_page));
 
 	pd->tables = vmalloc_user(sizeof(struct psb_mmu_pt *) * 1024);
 	if (!pd->tables)
@@ -279,7 +274,7 @@ static struct psb_mmu_pt *psb_mmu_alloc_pt(struct psb_mmu_pd *pd)
 
 	spin_lock(lock);
 
-	v = kmap_atomic(pt->p);
+	v = page_address(pt->p);
 	clf = (uint8_t *) v;
 	ptes = (uint32_t *) v;
 	for (i = 0; i < (PAGE_SIZE / sizeof(uint32_t)); ++i)
@@ -293,7 +288,6 @@ static struct psb_mmu_pt *psb_mmu_alloc_pt(struct psb_mmu_pd *pd)
 		}
 		mb();
 	}
-	kunmap_atomic(v);
 	spin_unlock(lock);
 
 	pt->count = 0;
@@ -339,7 +333,7 @@ static struct psb_mmu_pt *psb_mmu_pt_alloc_map_lock(struct psb_mmu_pd *pd,
 			atomic_set(&pd->driver->needs_tlbflush, 1);
 		}
 	}
-	pt->v = kmap_atomic(pt->p);
+	pt->v = page_address(pt->p);
 	return pt;
 }
 
@@ -365,7 +359,6 @@ static void psb_mmu_pt_unmap_unlock(struct psb_mmu_pt *pt)
 	struct psb_mmu_pd *pd = pt->pd;
 	uint32_t *v;
 
-	kunmap_atomic(pt->v);
 	if (pt->count == 0) {
 		v = kmap_atomic(pd->p);
 		v[pt->index] = pd->invalid_pde;
-- 
2.25.1

