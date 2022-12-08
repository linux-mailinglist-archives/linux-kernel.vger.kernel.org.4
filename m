Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C151E646D4E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 11:43:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbiLHKnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 05:43:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiLHKmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 05:42:45 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C1177DA52
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 02:39:15 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id 130so952890pfu.8
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 02:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EM9XDkM0kdpm93Xos1U4iZn+vpJvsChiHhm6+GOqbHs=;
        b=n0lYvR0R4CkYqr8Fn6qjW6uylGig6i3EjcFXXrXv49HU0Y4P6x+nJnhZvkrKgccznq
         Tqiias5qApau128FrQO9qoAvTc+ZVnoA4Nrd54/AQEtY5P9NvL6hbBSWwk0xJkknbjQl
         N2IcUrJsZzksddKavbVkDggnAgODQX9TZE2QR8sIXYg3EjY1vDf4RKnNtWzA8WJL6Dbh
         /ciOOHroCIo+oInm/YPUx2YEVv1sneV8uDMapPPWlRoxO+KEeZgshEPHTklv5vgzX5rh
         /b5kH6MmbhkiOJcpYpBOwF/9Ue+UNPGJeKAJmkECvomXg+yK4lEXKhgjk2cZNyy/ZQ/q
         hrwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EM9XDkM0kdpm93Xos1U4iZn+vpJvsChiHhm6+GOqbHs=;
        b=lI2cWEdvrvxp6sROhgHyuMVu338SO1Am3zi2P04L4tHHh5ofWi+Fj2laiBGdiBhYLI
         ReTGdk9wT9RWoE5Wvlp5CnzEtCS/N4M7/5wfHJZL5yO5pum2o/kCjb8S60NUgU1QUH44
         zAu3AIEBmditEQ5W1wGfbLVcGLlKq6EtThjKy1SASA4fcK844K+mL3ul8ymawyAHzbKy
         Eg5m43gLucUSgeL23aqlpssmyfoHJSaGBfU9hp9RDcaR+rMB/mF8zGCndqIFmTfn4vFa
         3ncmbD08gN+0pUANz1mDCFRtAexbvf5d9sDq2Uk4HKlE1zem5iDKVcRMbKQROvQv25E/
         L4YA==
X-Gm-Message-State: ANoB5pkzSe2sMoNe77Rj9A34AjOhesQb6M1ltQB3+wwe5cTD2JdnrkDH
        MCf3Jqthe9DKPxQ56eCI5ic=
X-Google-Smtp-Source: AA0mqf5JIMmFlKvvzXBqcMyNk9owDgwTNcql54ZieSry8plQ2MSuZEHkSMMefw7IfPngGzXsZyrFqQ==
X-Received: by 2002:a05:6a00:84d:b0:56d:5709:a03e with SMTP id q13-20020a056a00084d00b0056d5709a03emr97619222pfk.23.1670495955216;
        Thu, 08 Dec 2022 02:39:15 -0800 (PST)
Received: from zoo868e (1-170-0-91.dynamic-ip.hinet.net. [1.170.0.91])
        by smtp.gmail.com with ESMTPSA id fv3-20020a17090b0e8300b00217090ece49sm2624888pjb.31.2022.12.08.02.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 02:39:14 -0800 (PST)
Date:   Thu, 8 Dec 2022 18:39:12 +0800
From:   Matt Jan <zoo868e@gmail.com>
To:     Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH v2 2/3] staging: vme_user: remove unnecessary spaces
Message-ID: <20221208103912.GA100281@zoo868e>
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
index e17a8f7de165..5da2643e20d5 100644
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
v2: Resend the correct patch set, noted by Greg Kroah-Hartmamn <gregkh@linuxfoundation.org>

