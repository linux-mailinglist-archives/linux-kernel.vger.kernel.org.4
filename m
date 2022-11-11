Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEEE66259B8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 12:46:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233239AbiKKLqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 06:46:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbiKKLqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 06:46:35 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10FFBE0BB;
        Fri, 11 Nov 2022 03:46:34 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id j4so8027906lfk.0;
        Fri, 11 Nov 2022 03:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8+TGbcI0QMZONMioawRdiUS9+5vmjoD8ChogAY21Oa0=;
        b=K5nlJPYQZx78+Mgn7RBBkCqYmu3Rn6ArgOwGOf2XXY7HAgZoJ9QjWVGhyg1cE6r9Rw
         kEQDEI+qTn83kiYVLHOOLrwoMQ5SCSru6awifHCwiI1tmWgqW7b1oa8ab36hG/fMWV2W
         ciFYrd6x3q5OcT7sYB9b0as4UqBgI9MAe5/vyuoHAKS+qPV89g6qVnLb3NKIrYMFZye3
         rxHA0LvaUTUFkaLK+k7im6nbFwPvI3Ek1hPhrTbUpu4WR+sZQoDcnxBXKugB0Le3HpUc
         TQgeC4cYZWc3HBPSa5vA3e3mgnb2b5GWUkLAmkF2qtIscMbhLPxFP3N2xXIiVGAV8bxm
         BE0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8+TGbcI0QMZONMioawRdiUS9+5vmjoD8ChogAY21Oa0=;
        b=gDjDMohFLwoQEA+MMURID1VYGv5tFmQgRwg7K0GwiTFS3DhzY/Amm0ZmO8q/YlY/sF
         jg63RiW2y4Sfgqy/tcPikvO1aY5H/mi7bxHUs1Sc7efDefCPkRXO6B6VxSyI+F3USlPB
         fp2Knj3fUOG5620URMTsPe/mLYtjvVIrUOXY83c36rfLmY2byWdH0uQdBUbmDvvudXWG
         kEAFXMrCYdSqJMnbNewUhkyL/J7aVMdnSgW2tL1DzNklDJbUDzngjx8MxJoigAn19i/S
         agNIDtJ9tAfzLAIzdutOAMooSNjz8HduR3Y/Q5qAKDB/VG/OEhmyhw25D0hLZ3Zrrdca
         OyzA==
X-Gm-Message-State: ANoB5pmxG+lU/1ptncTX8MhWUkxv6Rv9t3eEe5nZQZ+vOht4AygUOaMB
        aqVwpo1rFd7T+8lKPagWX8I=
X-Google-Smtp-Source: AA0mqf4wiSpCasQPxQc2XZal1V3LS9Za3jYalQQVWS8JERfMTmHASiNZacgz6jFLRAGzfiUbS2gPpA==
X-Received: by 2002:a19:e601:0:b0:4a8:e955:77e7 with SMTP id d1-20020a19e601000000b004a8e95577e7mr565011lfh.573.1668167192277;
        Fri, 11 Nov 2022 03:46:32 -0800 (PST)
Received: from localhost.localdomain ([78.133.163.249])
        by smtp.googlemail.com with ESMTPSA id 10-20020ac25f4a000000b004979ec19380sm281616lfz.285.2022.11.11.03.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 03:46:31 -0800 (PST)
From:   Lukasz Wiecaszek <lukasz.wiecaszek@googlemail.com>
X-Google-Original-From: Lukasz Wiecaszek <lukasz.wiecaszek@gmail.com>
To:     kraxel@redhat.com
Cc:     Lukasz Wiecaszek <lukasz.wiecaszek@gmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH] udmabuf: add vmap method to udmabuf_ops
Date:   Fri, 11 Nov 2022 12:45:28 +0100
Message-Id: <20221111114528.608801-1-lukasz.wiecaszek@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
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

The reason behind that patch is associated with videobuf2 subsystem
(or more genrally with v4l2 framework) and user created
dma buffers (udmabuf). In some circumstances
when dealing with V4L2_MEMORY_DMABUF buffers videobuf2 subsystem
wants to use dma_buf_vmap() method on the attached dma buffer.
As udmabuf does not have .vmap operation implemented,
such dma_buf_vmap() natually fails.

videobuf2_common: [cap-000000003473b2f1] __vb2_queue_alloc: allocated 3 buffers, 1 plane(s) each
videobuf2_common: [cap-000000003473b2f1] __prepare_dmabuf: buffer for plane 0 changed
videobuf2_common: [cap-000000003473b2f1] __prepare_dmabuf: failed to map dmabuf for plane 0
videobuf2_common: [cap-000000003473b2f1] __buf_prepare: buffer preparation failed: -14

The patch itself seems to be strighforward.
It adds implementation of .vmap method to 'struct dma_buf_ops udmabuf_ops'.
.vmap method itself uses vm_map_ram() to map pages linearly
into the kernel virtual address space (only if such mapping
hasn't been created yet).

Signed-off-by: Lukasz Wiecaszek <lukasz.wiecaszek@gmail.com>
---
 drivers/dma-buf/udmabuf.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
index 2bcdb935a3ac..8649fcbd05c4 100644
--- a/drivers/dma-buf/udmabuf.c
+++ b/drivers/dma-buf/udmabuf.c
@@ -12,6 +12,7 @@
 #include <linux/slab.h>
 #include <linux/udmabuf.h>
 #include <linux/hugetlb.h>
+#include <linux/vmalloc.h>
 
 static int list_limit = 1024;
 module_param(list_limit, int, 0644);
@@ -26,6 +27,7 @@ struct udmabuf {
 	struct page **pages;
 	struct sg_table *sg;
 	struct miscdevice *device;
+	void *vaddr;
 };
 
 static vm_fault_t udmabuf_vm_fault(struct vm_fault *vmf)
@@ -57,6 +59,21 @@ static int mmap_udmabuf(struct dma_buf *buf, struct vm_area_struct *vma)
 	return 0;
 }
 
+static int vmap_udmabuf(struct dma_buf *buf, struct dma_buf_map *map)
+{
+	struct udmabuf *ubuf = buf->priv;
+
+	if (!ubuf->vaddr) {
+		ubuf->vaddr = vm_map_ram(ubuf->pages, ubuf->pagecount, -1);
+		if (!ubuf->vaddr)
+			return -EINVAL;
+	}
+
+	dma_buf_map_set_vaddr(map, ubuf->vaddr);
+
+	return 0;
+}
+
 static struct sg_table *get_sg_table(struct device *dev, struct dma_buf *buf,
 				     enum dma_data_direction direction)
 {
@@ -159,6 +176,7 @@ static const struct dma_buf_ops udmabuf_ops = {
 	.unmap_dma_buf	   = unmap_udmabuf,
 	.release	   = release_udmabuf,
 	.mmap		   = mmap_udmabuf,
+	.vmap		   = vmap_udmabuf,
 	.begin_cpu_access  = begin_cpu_udmabuf,
 	.end_cpu_access    = end_cpu_udmabuf,
 };
-- 
2.25.1

