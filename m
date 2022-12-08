Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87646646BA1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 10:12:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbiLHJM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 04:12:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbiLHJLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 04:11:46 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EDBF1B790
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 01:11:37 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id cm20so1057731pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 01:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kMozxrhekUqthR/ZzwbfPqWM+5U9HTscLOB3qLeUQfY=;
        b=DBsimqLIo+qEE89hMxiDEss3nJ2pNnaSSoIITz+tZkSCSpOOMi9BfHHyh/D9aJhTUW
         +cLQyqcYWxVIc7CkFK6IvGYa5AvWgzczgw7F7Nog/uByh073u6U7WTRYdExJwarBvhGq
         /bLDVRO3zkCZqO9qEF94XaY0FYPuRvGVZM8wPol2XpcALH+q3PLQ4kr+Qm441egmZZ9q
         2IkpF5oyaJw1XsXUqZvln7togEZiyIRx9i8nQhS0XsNqVbJafjRXWpbgfgHWECKkVJ2f
         ecwLuSPT3cfbwsld5ldAuijnMxgJzspAV+qByDxxTRE7orj6pMY73Z8z67KS8SPAEZOW
         Vytw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kMozxrhekUqthR/ZzwbfPqWM+5U9HTscLOB3qLeUQfY=;
        b=eK+ieddEWUjaDy3M99j8pa2qfWsmbKqKqYqC+KGTcHL444QnAMjqyXdLz3q5HYyp0G
         qLTtVInepCz0LvJKVA4/FuYRdl1cIDDeSGrb7uPbVBkXY/qv7TPB+WFoZSN8VHioZSjB
         T2FYzR9moslABTnZ5m2erXituWF/CLgFGGdDcyeD8Oyk/548lzrFexQhqmqHW+kdRRjo
         EzI3nFOHeSGaRAiLCLc5Ey98RLyHFZOBn415jEm49l/4H8i/dAjrstq5MRCGx5ew7zNL
         CXdxWIjhPye2awP/oljbuPvLPYl5GrBJ16ZzLymS2fj1c+N8E54Rf5op+3pH/URyLQEG
         d8Rg==
X-Gm-Message-State: ANoB5pm9cvnTpes2XkglCOW76oZNRU6kxzRERPWHN9HbzoHTUXFTVjbb
        faOoP+LBeum3bm2I4rYRKJc=
X-Google-Smtp-Source: AA0mqf6C2QSUugE5UVSkvjHjxR1eVa2jk+YidS6ZFLPvirzkPbRo28j3ULWyI9VDM+gJYlx2nMT/OA==
X-Received: by 2002:a17:902:82c2:b0:189:a208:d124 with SMTP id u2-20020a17090282c200b00189a208d124mr41050534plz.143.1670490696690;
        Thu, 08 Dec 2022 01:11:36 -0800 (PST)
Received: from zoo868e (1-170-0-91.dynamic-ip.hinet.net. [1.170.0.91])
        by smtp.gmail.com with ESMTPSA id n1-20020a632701000000b0047899d0d62csm8246766pgn.52.2022.12.08.01.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 01:11:36 -0800 (PST)
Date:   Thu, 8 Dec 2022 17:11:34 +0800
From:   Matt Jan <zoo868e@gmail.com>
To:     Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH 3/3] staging: vme_user: remove unnecessary spaces
Message-ID: <20221208091134.GA95310@zoo868e>
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

Remove unnecessary spaces before function pointer arguments in
vme_bridge.h. This is done with command ':%s/) (/)('.

Signed-off-by: Matt Jan <zoo868e@gmail.com>
---
 drivers/staging/vme_user/vme_bridge.h | 32 +++++++++++++--------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/vme_user/vme_bridge.h b/drivers/staging/vme_user/vme_bridge.h
index 9a127f6fefca..ab2e24d3b625 100644
--- a/drivers/staging/vme_user/vme_bridge.h
+++ b/drivers/staging/vme_user/vme_bridge.h
@@ -128,45 +128,45 @@ struct vme_bridge {
 	struct mutex irq_mtx;
 
 	/* Slave Functions */
-	int (*slave_get) (struct vme_slave_resource *, int *,
+	int (*slave_get)(struct vme_slave_resource *, int *,
 		unsigned long long *, unsigned long long *, dma_addr_t *,
 		u32 *, u32 *);
-	int (*slave_set) (struct vme_slave_resource *, int, unsigned long long,
+	int (*slave_set)(struct vme_slave_resource *, int, unsigned long long,
 		unsigned long long, dma_addr_t, u32, u32);
 
 	/* Master Functions */
-	int (*master_get) (struct vme_master_resource *, int *,
+	int (*master_get)(struct vme_master_resource *, int *,
 		unsigned long long *, unsigned long long *, u32 *, u32 *,
 		u32 *);
-	int (*master_set) (struct vme_master_resource *, int,
+	int (*master_set)(struct vme_master_resource *, int,
 		unsigned long long, unsigned long long,  u32, u32, u32);
-	ssize_t (*master_read) (struct vme_master_resource *, void *, size_t,
+	ssize_t (*master_read)(struct vme_master_resource *, void *, size_t,
 		loff_t);
-	ssize_t (*master_write) (struct vme_master_resource *, void *, size_t,
+	ssize_t (*master_write)(struct vme_master_resource *, void *, size_t,
 		loff_t);
-	unsigned int (*master_rmw) (struct vme_master_resource *, unsigned int,
+	unsigned int (*master_rmw)(struct vme_master_resource *, unsigned int,
 		unsigned int, unsigned int, loff_t);
 
 	/* DMA Functions */
-	int (*dma_list_add) (struct vme_dma_list *, struct vme_dma_attr *,
+	int (*dma_list_add)(struct vme_dma_list *, struct vme_dma_attr *,
 		struct vme_dma_attr *, size_t);
-	int (*dma_list_exec) (struct vme_dma_list *);
-	int (*dma_list_empty) (struct vme_dma_list *);
+	int (*dma_list_exec)(struct vme_dma_list *);
+	int (*dma_list_empty)(struct vme_dma_list *);
 
 	/* Interrupt Functions */
-	void (*irq_set) (struct vme_bridge *, int, int, int);
-	int (*irq_generate) (struct vme_bridge *, int, int);
+	void (*irq_set)(struct vme_bridge *, int, int, int);
+	int (*irq_generate)(struct vme_bridge *, int, int);
 
 	/* Location monitor functions */
-	int (*lm_set) (struct vme_lm_resource *, unsigned long long, u32, u32);
-	int (*lm_get) (struct vme_lm_resource *, unsigned long long *, u32 *,
+	int (*lm_set)(struct vme_lm_resource *, unsigned long long, u32, u32);
+	int (*lm_get)(struct vme_lm_resource *, unsigned long long *, u32 *,
 		u32 *);
 	int (*lm_attach)(struct vme_lm_resource *, int,
 			 void (*callback)(void *), void *);
-	int (*lm_detach) (struct vme_lm_resource *, int);
+	int (*lm_detach)(struct vme_lm_resource *, int);
 
 	/* CR/CSR space functions */
-	int (*slot_get) (struct vme_bridge *);
+	int (*slot_get)(struct vme_bridge *);
 
 	/* Bridge parent interface */
 	void *(*alloc_consistent)(struct device *dev, size_t size,
-- 
2.25.1

