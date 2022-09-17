Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4FC25BB6E9
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 09:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbiIQHY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 03:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiIQHYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 03:24:09 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B1E422DB
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 00:24:05 -0700 (PDT)
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220917072359epoutp03392c1d3d711fae2b36a63f7f609322ce~VlPosMtN31145111451epoutp03E
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 07:23:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220917072359epoutp03392c1d3d711fae2b36a63f7f609322ce~VlPosMtN31145111451epoutp03E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1663399439;
        bh=jiZzG4vFrxosmTJYB/0JAWBu8ckbz2PQUosr1RdVHDA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J5TcmBovO6O5WMscn4c459KDu1toVYoBzvV7qF7FUqEJaTK5hnL5SQF9fAmS+ECKl
         SitZqtIo2u/eitAFyybHeXR9oWVnC4qjPFeQDiOCmzCO3iLMKHLbIpyL5w70SS9gON
         jZqNT526Aq24eNsRYZfTxFpg0tAh3s4quDG5aQY0=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20220917072358epcas1p45371dc7da50414e7cf19b1a78607611d~VlPoB6g_u2970529705epcas1p4O;
        Sat, 17 Sep 2022 07:23:58 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.38.234]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4MV2Vj65JJz4x9Pr; Sat, 17 Sep
        2022 07:23:57 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        B1.ED.07691.D0675236; Sat, 17 Sep 2022 16:23:57 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220917072357epcas1p1bc8d924080c5dabafee1db779369078d~VlPmrWA9W0249502495epcas1p1S;
        Sat, 17 Sep 2022 07:23:57 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220917072357epsmtrp1f725e391d3d36a3346ac0516b1c22274~VlPmqqInW0556805568epsmtrp1b;
        Sat, 17 Sep 2022 07:23:57 +0000 (GMT)
X-AuditID: b6c32a38-31ffb70000021e0b-79-6325760dc465
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        24.F0.18644.D0675236; Sat, 17 Sep 2022 16:23:57 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.113.58]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220917072357epsmtip202868a444d99d97e1966c115e61422db~VlPmWQ11y2857028570epsmtip20;
        Sat, 17 Sep 2022 07:23:57 +0000 (GMT)
From:   Jiho Chu <jiho.chu@samsung.com>
To:     gregkh@linuxfoundation.org, arnd@arndb.de, ogabbay@kernel.org,
        krzysztof.kozlowski@linaro.org, broonie@kernel.org
Cc:     linux-kernel@vger.kernel.org, yelini.jeong@samsung.com,
        myungjoo.ham@samsung.com, jiho.chu@samsung.com
Subject: [PATCH v2 02/13] tirnity: Add memory module
Date:   Sat, 17 Sep 2022 16:23:45 +0900
Message-Id: <20220917072356.2255620-3-jiho.chu@samsung.com>
In-Reply-To: <20220917072356.2255620-1-jiho.chu@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnk+LIzCtJLcpLzFFi42LZdlhTX5e3TDXZ4OYZTYu/k46xW0x9+ITN
        onnxejaL9927mS32vt7KbnF51xw2i9uNK9gs9vV8ZLR4Pu06iwOnx+9fkxg9Nq3qZPO4c20P
        m8f+uWvYPfq2rGL0+LxJLoAtKtsmIzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX0NLCXEkh
        LzE31VbJxSdA1y0zB+gqJYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpBSk6BaYFecWJu
        cWleul5eaomVoYGBkSlQYUJ2xoX2WawFC+YyVtxf18zUwHi5kbGLkZNDQsBEYuvS+0xdjFwc
        QgI7GCXuX58B5XxilDjx+ToTSJWQwGdGiSdbtGE61n55wgpRtItRYkfnGzYIB6ios+8YG0gV
        m4CqxMwZa9hBbBGBconmjSfAbGaBHIknd5qYQWxhoElNs5qB6jk4WIDqL3cWg4R5Bawl1v68
        AFbOKWAjcXNTEwtEXFDi5MwnLBBj5CWat85mBtkrIfCVXWLb+hMsENe5SLz/3skGYQtLvDq+
        hR3ClpJ42d8GZWdLTOlYBFVfIHHu+VZmkBskBIwlLq5IATGZBTQl1u/Sh6hQlNj5ey4jxFo+
        iXdfe1ghqnklOtqEIEqUJJb8OQw1XEJi6oxvTBC2h8T9vSCLQKHTzyixdPpqtgmM8rOQfDML
        yTezEDYvYGRexSiWWlCcm55abFhgAo/V5PzcTYzglKllsYNx7tsPeocYmTgYDzFKcDArifCq
        eqokC/GmJFZWpRblxxeV5qQWH2I0BQbvRGYp0eR8YNLOK4k3NLE0MDEzMjaxMDQzVBLn1dNm
        TBYSSE8sSc1OTS1ILYLpY+LglGpganW4OHXS03NOaQq5u+5V1wu5TPtbUMTs/tl+3VpJVlff
        WfeOy3tv5P84iytIRfx6kFPZ7wfPGlcvV27t3FM5VUJ+GvfJhW+c3i9/w5LSPnGr9ZPIK6X6
        rIqLDY+JV6uoTjtpYrVzV0jku8q4d4m/XaX+cHq7SG2P0U53/vhM2MLjeQ/vlJypa9cn5Xye
        XW6SbiKq+sqKs8ahaH2Qoo5Fpl10QseORFaxBWd2dO1cwySzbfnj+ZOPWFf1PehIfpqwZ+bX
        DMGEqLxig138RfMPx24oM0pYtT+76Hna1rSfmjV/Z68XOs47yWz1xNDnIkp+saqSbSUZhj5n
        a+7KTN74wIHx8pyXM85wil6Kk7dXYinOSDTUYi4qTgQAlrct4iIEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFLMWRmVeSWpSXmKPExsWy7bCSvC5vmWqywaMp/BZ/Jx1jt5j68Amb
        RfPi9WwW77t3M1vsfb2V3eLyrjlsFrcbV7BZ7Ov5yGjxfNp1FgdOj9+/JjF6bFrVyeZx59oe
        No/9c9ewe/RtWcXo8XmTXABbFJdNSmpOZllqkb5dAlfGhfZZrAUL5jJW3F/XzNTAeLmRsYuR
        k0NCwERi7ZcnrF2MXBxCAjsYJf6/P8EEkZCQ2HRvOXMXIweQLSxx+HAxRM1HRon1rU/YQWrY
        BFQlZs5YA2aLCNRKHDw6nxnEZhYokJj9dCYLiC0MtKBpVjMbyBwWoPrLncUgYV4Ba4m1Py+A
        tXIK2Ejc3NQEVi4EFJ89fS4TRI2gxMmZT1ggRspLNG+dzTyBkX8WktQsJKkFjEyrGCVTC4pz
        03OLDQuM8lLL9YoTc4tL89L1kvNzNzGCg1tLawfjnlUf9A4xMnEwHmKU4GBWEuFV9VRJFuJN
        SaysSi3Kjy8qzUktPsQozcGiJM57oetkvJBAemJJanZqakFqEUyWiYNTqoEpka/1XeaEm1uX
        iTgIlXHNr/6xQOrJgtwczsLXKgeNfBVjLjPeetNauXHvGXXmHxcPzBJstJkiuYVvlvPfKfxP
        lG9LGU1oFw/UmWsf5FMWt9YoS/xyTX7XhPyEA08fsT+f4ZH5a0vc5kmftItvP3i/5czm5dEV
        +95u9NB44zGzcob0OkaTBP9LWRsf/XWuF+6xnL2/T3hLl/4MjQtHek30hT4c6FqbV75MoaFw
        a3OM+7fIv7FZtS7P5j6zdhc14FcK5ldxUq44wPBtwX/HhqeMTscz39z/vSvc4NRx+4uCxs2+
        UWJv4u8fkVn4/xifIGvgsgXhNuWKOnPjfjb+THnf8GV7v9ENk4hP+d1Nh9OVWIozEg21mIuK
        EwHxEzJZ3QIAAA==
X-CMS-MailID: 20220917072357epcas1p1bc8d924080c5dabafee1db779369078d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220917072357epcas1p1bc8d924080c5dabafee1db779369078d
References: <20220917072356.2255620-1-jiho.chu@samsung.com>
        <CGME20220917072357epcas1p1bc8d924080c5dabafee1db779369078d@epcas1p1.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch includes DMA memory modules.

It handles DMA buffer using general DMA APIs with reserved
area for NPU device. The reserved area is used for IDU binary,
statistics and profiling data. Another hwmem modules are
provided to handle user requests of memory allocation which
are used for model data or inputa data.

Signed-off-by: Jiho Chu <jiho.chu@samsung.com>
Signed-off-by: Yelin Jeong <yelini.jeong@samsung.com>
Signed-off-by: Dongju Chae <dongju.chae@samsung.com>
Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
---
 drivers/misc/trinity/Makefile        |   1 +
 drivers/misc/trinity/trinity.c       |   1 +
 drivers/misc/trinity/trinity_dma.c   |  83 ++++++
 drivers/misc/trinity/trinity_dma.h   |  87 ++++++
 drivers/misc/trinity/trinity_hwmem.c | 380 +++++++++++++++++++++++++++
 drivers/misc/trinity/trinity_hwmem.h |  81 ++++++
 6 files changed, 633 insertions(+)
 create mode 100644 drivers/misc/trinity/trinity_dma.c
 create mode 100644 drivers/misc/trinity/trinity_dma.h
 create mode 100644 drivers/misc/trinity/trinity_hwmem.c
 create mode 100644 drivers/misc/trinity/trinity_hwmem.h

diff --git a/drivers/misc/trinity/Makefile b/drivers/misc/trinity/Makefile
index a8e5697d6d85..5d2b75112482 100644
--- a/drivers/misc/trinity/Makefile
+++ b/drivers/misc/trinity/Makefile
@@ -3,5 +3,6 @@
 obj-$(CONFIG_TRINITY_VISION2) += trinity_vision2.o
 
 trinity-y := trinity.o
+trinity-y += trinity_dma.o trinity_hwmem.o
 
 trinity_vision2-objs := $(trinity-y) trinity_vision2_drv.o
diff --git a/drivers/misc/trinity/trinity.c b/drivers/misc/trinity/trinity.c
index 1704eecfc439..3a492eef011f 100644
--- a/drivers/misc/trinity/trinity.c
+++ b/drivers/misc/trinity/trinity.c
@@ -11,6 +11,7 @@
  */
 
 #include <linux/of_address.h>
+#include <linux/of_reserved_mem.h>
 
 #include "trinity_common.h"
 
diff --git a/drivers/misc/trinity/trinity_dma.c b/drivers/misc/trinity/trinity_dma.c
new file mode 100644
index 000000000000..c93a9187ee9d
--- /dev/null
+++ b/drivers/misc/trinity/trinity_dma.c
@@ -0,0 +1,83 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/**
+ * DMA memory for Trinity device drivers
+ *
+ * Copyright (C) 2022 Samsung Electronics
+ * Copyright (C) 2022 Jiho Chu <jiho.chu@samsung.com>
+ */
+
+#include <linux/dma-mapping.h>
+#include <linux/of_reserved_mem.h>
+
+#include "trinity_dma.h"
+
+int trinity_dma_init(struct device *dev)
+{
+	return of_reserved_mem_device_init(dev);
+}
+
+void trinity_dma_exit(struct device *dev)
+{
+	of_reserved_mem_device_release(dev);
+}
+
+int trinity_dma_alloc(struct device *dev, size_t size, struct trinity_dma *dma)
+{
+	void *addr;
+	dma_addr_t dma_handle;
+	size_t aligned_size;
+
+	aligned_size = PAGE_ALIGN(size);
+	addr = dma_alloc_noncoherent(dev, aligned_size, &dma_handle,
+				DMA_BIDIRECTIONAL, GFP_ATOMIC);
+
+	if (!addr) {
+		dev_err(dev, "Failed to alloc DMA memory");
+		return -1;
+	}
+
+	dma->addr = addr;
+	dma->dma_handle = dma_handle;
+	dma->size = aligned_size;
+
+	memset(addr, '\x00', aligned_size);
+	return 0;
+}
+
+void trinity_dma_free(struct device *dev, struct trinity_dma *dma)
+{
+	dma_free_noncoherent(dev, dma->size, dma->addr, dma->dma_handle,
+			DMA_BIDIRECTIONAL);
+}
+
+int trinity_dma_alloc_coherent(struct device *dev, size_t size, struct trinity_dma *dma)
+{
+	void *addr;
+	dma_addr_t dma_handle;
+	size_t aligned_size;
+
+	aligned_size = PAGE_ALIGN(size);
+	addr = dma_alloc_wc(dev, aligned_size, &dma_handle, GFP_KERNEL);
+	if (!addr) {
+		dev_err(dev, "Failed to alloc DMA memory");
+		return -1;
+	}
+
+	dma->addr = addr;
+	dma->dma_handle = dma_handle;
+	dma->size = aligned_size;
+
+	memset(addr, '\x00', aligned_size);
+	return 0;
+}
+
+void trinity_dma_free_coherent(struct device *dev, struct trinity_dma *dma)
+{
+	dma_free_wc(dev, dma->size, dma->addr, dma->dma_handle);
+}
+
+int trinity_dma_mmap(struct device *dev, struct vm_area_struct *vma, void *addr,
+			dma_addr_t dma_handle, size_t size)
+{
+	return dma_mmap_wc(dev, vma, addr, dma_handle, size);
+}
diff --git a/drivers/misc/trinity/trinity_dma.h b/drivers/misc/trinity/trinity_dma.h
new file mode 100644
index 000000000000..a7824196ff15
--- /dev/null
+++ b/drivers/misc/trinity/trinity_dma.h
@@ -0,0 +1,87 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/**
+ * DMA memory for Trinity device drivers
+ *
+ * Copyright (C) 2022 Samsung Electronics
+ * Copyright (C) 2022 Jiho Chu <jiho.chu@samsung.com>
+ */
+
+#ifndef __DRIVERS_MISC_TRINITY_DMA_H__
+#define __DRIVERS_MISC_TRINITY_DMA_H__
+
+/**
+ * struct trinity_dma - A data structure for DMA information
+ *
+ * @addr: A virtual address of memory
+ * @dma_handle: a handle for DMA
+ * @size: size of DMA memory
+ */
+struct trinity_dma {
+	void *addr;
+	dma_addr_t dma_handle;
+	size_t size;
+};
+
+/**
+ * trinity_dma_init() - Initialize DMA memory
+ * @dev: A pointer to the instance of the device
+ *
+ * Return: 0 on success. Otherwise, returns negative error.
+ */
+int trinity_dma_init(struct device *dev);
+
+/**
+ * trinity_dma_exit() - Allocate DMA memory
+ * @dev: A pointer to the instance of the device
+ * @fd: A file descriptor for a allocated memory
+ */
+void trinity_dma_exit(struct device *dev);
+
+/**
+ * trinity_dma_alloc() - Allocate DMA memory
+ * @dev: A pointer to the instance of the device
+ * @size: size of DMA memory
+ * @dma: A structure of DMA information
+ *
+ * Return: 0 on success. Otherwise, returns negative error.
+ */
+int trinity_dma_alloc(struct device *dev, size_t size, struct trinity_dma *dma);
+
+/**
+ * trinity_dma_free() - Free DMA memory
+ * @dev: A pointer to the instance of the device
+ * @dma: A structure of DMA information
+ */
+void trinity_dma_free(struct device *dev, struct trinity_dma *dma);
+
+/**
+ * trinity_dma_alloc_coherent() - Allocate coherent DMA memory
+ * @dev: A pointer to the instance of the device
+ * @size: size of DMA memory
+ * @dma: A structure of DMA information
+ *
+ * Return: 0 on success. Otherwise, returns negative error.
+ */
+int trinity_dma_alloc_coherent(struct device *dev, size_t size, struct trinity_dma *dma);
+
+/**
+ * trinity_dma_free_coherent() - Free coherent DMA memory
+ * @dev: A pointer to the instance of the device
+ * @dma: A structure of DMA information
+ */
+void trinity_dma_free_coherent(struct device *dev, struct trinity_dma *dma);
+
+/**
+ * trinity_dma_mmap() - mmap for DMA memory
+ * @dev: A pointer to the instance of the device
+ * @vma: A struct for virtual memory area
+ * @addr: virtual address of memory
+ * @dma_handle: a handle for dma
+ * @size: size of mapped DMA memory
+ *
+ * Return: 0 on success. Otherwise, returns negative error.
+ */
+int trinity_dma_mmap(struct device *dev, struct vm_area_struct *vma, void *addr,
+		dma_addr_t dma_handle, size_t size);
+
+#endif /* __DRIVERS_MISC_TRINITY_DMA_H__ */
diff --git a/drivers/misc/trinity/trinity_hwmem.c b/drivers/misc/trinity/trinity_hwmem.c
new file mode 100644
index 000000000000..afc2cc9193c6
--- /dev/null
+++ b/drivers/misc/trinity/trinity_hwmem.c
@@ -0,0 +1,380 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/**
+ * DMA memory buffers for Trinity device driver
+ *
+ * Copyright (C) 2020-2022 Samsung Electronics
+ * Copyright (C) 2020 Dongju Chae <dongju.chae@samsung.com>
+ * Copyright (C) 2020 Wook Song <wook16.song@samsung.com>
+ * Copyright (C) 2022 MyungJoo Ham <myungjoo.ham@samsung.com>
+ * Copyright (C) 2022 Yelin Jeong <yelini.jeong@samsung.com>
+ * Copyright (C) 2022 Jiho Chu <jiho.chu@samsung.com>
+ */
+
+#include <linux/dma-buf.h>
+#include <linux/mutex.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/version.h>
+
+#include "trinity_dma.h"
+#include "trinity_hwmem.h"
+
+#define dbuf_to_trnt_hwmem(d) ((struct trinity_hwmem *)d->priv)
+#define vma_to_trnt_hwmem(v) ((struct trinity_hwmem *)v->vm_private_data)
+
+/**
+ * struct trinity_hwmem - A data structure for Trinity DMA buffer management
+ * @dev: A pointer to device which this hwmem belongs to.
+ * @dbuf: The dma_buf instance.
+ * @refcnt: Reference counts.
+ * @direction: A variable indicating the DMA data direction in allocating this
+ *		dma_buf.
+ * @attrs: Attributes used in allocating this dma_buf.
+ * @req_size: The size of the DMA buffer that the user request to allocate.
+ * @alc_size: The size of the DMA buffer which is actually allocated.
+ * @addr: The DMA (physical) address of this dma_buf.
+ * @cookie: The DMA cookies.
+ */
+struct trinity_hwmem {
+	struct device *dev;
+	struct dma_buf *dbuf;
+	struct kref refcnt;
+
+	enum dma_data_direction direction;
+	enum trinity_hwmem_type type;
+
+	unsigned long attrs;
+	size_t req_size;
+	size_t alc_size;
+
+	bool is_cont;
+	dma_addr_t addr;
+	void *cookie;
+};
+
+static void __trinity_hwmem_free(struct kref *refcnt)
+{
+	struct trinity_hwmem *mem =
+		container_of(refcnt, struct trinity_hwmem, refcnt);
+	/**
+	 * when the dmabuf reference counter becomes zero,
+	 * trinity_hwmem_dbuf_ops_release() is triggered.
+	 */
+	dma_buf_put(mem->dbuf);
+}
+
+static void __trinity_hwmem_put(struct trinity_hwmem *mem)
+{
+	kref_put(&mem->refcnt, __trinity_hwmem_free);
+}
+
+static void __trinity_hwmem_put_dmabuf(struct dma_buf *dbuf)
+{
+	__trinity_hwmem_put(dbuf_to_trnt_hwmem(dbuf));
+}
+
+static struct trinity_hwmem *__trinity_hwmem_get(struct trinity_hwmem *mem)
+{
+	kref_get(&mem->refcnt);
+
+	return mem;
+}
+
+static void trinity_hwmem_dbuf_ops_detach(struct dma_buf *dbuf,
+					  struct dma_buf_attachment *attachment)
+{
+	struct trinity_hwmem *mem = dbuf_to_trnt_hwmem(dbuf);
+
+	/* Decrease ref count of the backing storage */
+	__trinity_hwmem_put(mem);
+}
+
+static int trinity_hwmem_dbuf_ops_attach(struct dma_buf *dbuf,
+					 struct dma_buf_attachment *attachment)
+{
+	struct trinity_hwmem *mem = dbuf_to_trnt_hwmem(dbuf);
+
+	/* Increase ref count of the backing storage */
+	mem = __trinity_hwmem_get(mem);
+	attachment->priv = mem;
+
+	return 0;
+}
+
+static struct sg_table *
+trinity_hwmem_dbuf_ops_map_dma_buf(struct dma_buf_attachment *attachment,
+				   enum dma_data_direction dir)
+{
+	return NULL;
+}
+
+static void
+trinity_hwmem_dbuf_ops_unmap_dma_buf(struct dma_buf_attachment *attachment,
+				     struct sg_table *sgt,
+				     enum dma_data_direction dir)
+{
+}
+
+static void trinity_hwmem_vm_ops_open(struct vm_area_struct *vma)
+{
+	struct trinity_hwmem *mem = vma_to_trnt_hwmem(vma);
+
+	__trinity_hwmem_get(mem);
+}
+
+static void trinity_hwmem_vm_ops_close(struct vm_area_struct *vma)
+{
+	struct trinity_hwmem *mem = vma_to_trnt_hwmem(vma);
+
+	__trinity_hwmem_put(mem);
+}
+
+static const struct vm_operations_struct trinity_hwmem_vm_ops = {
+	.open = trinity_hwmem_vm_ops_open,
+	.close = trinity_hwmem_vm_ops_close,
+};
+
+static int32_t trinity_hwmem_dbuf_ops_mmap(struct dma_buf *dbuf,
+					   struct vm_area_struct *vma)
+{
+	struct trinity_hwmem *mem;
+	int32_t ret;
+
+	if (!dbuf)
+		return -EINVAL;
+
+	mem = dbuf_to_trnt_hwmem(dbuf);
+	if (!mem)
+		return -EINVAL;
+
+	vma->vm_pgoff = 0;
+
+	ret = trinity_dma_mmap(mem->dev, vma, mem->cookie, mem->addr, mem->alc_size);
+	if (ret)
+		return ret;
+
+	vma->vm_flags |= VM_DONTEXPAND | VM_DONTDUMP;
+	vma->vm_private_data = mem;
+	vma->vm_ops = &trinity_hwmem_vm_ops;
+
+	vma->vm_ops->open(vma);
+
+	return 0;
+}
+
+static void trinity_hwmem_dbuf_ops_release(struct dma_buf *dbuf)
+{
+	struct trinity_dma dma_mem;
+	struct trinity_hwmem *mem = dbuf_to_trnt_hwmem(dbuf);
+
+	dma_mem.addr = mem->cookie;
+	dma_mem.dma_handle = mem->addr;
+	dma_mem.size = mem->alc_size;
+
+	if (mem->type == TRINITY_HWMEM_DMA_CONT)
+		trinity_dma_free_coherent(mem->dev, &dma_mem);
+	else
+		trinity_dma_free(mem->dev, &dma_mem);
+
+	put_device(mem->dev);
+
+	mem->dbuf->priv = NULL;
+
+	kfree(mem);
+}
+
+static int trinity_hwmem_dbuf_ops_vmap(struct dma_buf *dbuf,
+				       struct iosys_map *map)
+{
+	struct trinity_hwmem *mem;
+
+	if (!dbuf)
+		return -EINVAL;
+
+	mem = dbuf_to_trnt_hwmem(dbuf);
+	if (!mem)
+		return -ENOENT;
+
+	map->vaddr = mem->cookie;
+
+	return 0;
+}
+
+static struct dma_buf_ops trinity_hwmem_dbuf_ops = {
+	.vmap = trinity_hwmem_dbuf_ops_vmap,
+	.attach = trinity_hwmem_dbuf_ops_attach,
+	.detach = trinity_hwmem_dbuf_ops_detach,
+	.map_dma_buf = trinity_hwmem_dbuf_ops_map_dma_buf,
+	.unmap_dma_buf = trinity_hwmem_dbuf_ops_unmap_dma_buf,
+	.release = trinity_hwmem_dbuf_ops_release,
+	.mmap = trinity_hwmem_dbuf_ops_mmap,
+};
+
+static void *__trinity_hwmem_alloc(struct device *dev, const size_t size,
+				   const enum dma_data_direction dir,
+				   const enum trinity_hwmem_type type)
+{
+	size_t aligned_size = ALIGN(size, PAGE_SIZE);
+	struct trinity_hwmem *mem;
+	struct trinity_dma dma_mem;
+	int ret;
+
+	if (WARN_ON(!dev))
+		return ERR_PTR(-EINVAL);
+
+	mem = kzalloc(sizeof(*mem), GFP_KERNEL);
+	if (!mem)
+		return ERR_PTR(-ENOMEM);
+
+	mem->dev = get_device(dev);
+	mem->req_size = size;
+	mem->alc_size = aligned_size;
+	mem->direction = dir;
+	mem->type = TRINITY_HWMEM_DMA_IOMMU;
+	mem->is_cont = (type == TRINITY_HWMEM_DMA_CONT);
+
+	mem->attrs |= DMA_ATTR_WRITE_COMBINE;
+	mem->attrs |= DMA_ATTR_SKIP_CPU_SYNC;
+
+	if (mem->is_cont)
+		ret = trinity_dma_alloc_coherent(dev, aligned_size, &dma_mem);
+	else
+		ret = trinity_dma_alloc(dev, aligned_size, &dma_mem);
+
+	if (ret < 0) {
+		dev_err(mem->dev,
+			"Unable alloc memory: %d\n", ret);
+		kfree(mem);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	mem->addr = dma_mem.dma_handle;
+	mem->cookie = dma_mem.addr;
+
+	kref_init(&mem->refcnt);
+
+	return mem;
+}
+
+static struct dma_buf *__trinity_hwmem_get_dmabuf(struct trinity_hwmem *mem,
+						  unsigned long flags)
+{
+	DEFINE_DMA_BUF_EXPORT_INFO(einfo);
+	struct dma_buf *dbuf;
+
+	einfo.ops = &trinity_hwmem_dbuf_ops;
+	einfo.size = mem->alc_size;
+	einfo.flags = flags;
+	einfo.priv = (void *)mem;
+
+	dbuf = dma_buf_export(&einfo);
+	if (IS_ERR(dbuf))
+		return dbuf;
+
+	/* Increase ref count of the backing storage */
+	dbuf->priv = __trinity_hwmem_get(mem);
+	mem->dbuf = dbuf;
+
+	return dbuf;
+}
+
+int32_t trinity_hwmem_alloc(struct device *dev, const size_t size,
+			    enum trinity_hwmem_type type)
+{
+	struct trinity_hwmem *mem;
+	struct dma_buf *dbuf;
+	int32_t ret;
+
+	mem = __trinity_hwmem_alloc(dev, size, DMA_BIDIRECTIONAL, type);
+	if (IS_ERR(mem))
+		return PTR_ERR(mem);
+
+	dbuf = __trinity_hwmem_get_dmabuf(mem, O_CLOEXEC | O_RDWR);
+	if (IS_ERR(dbuf)) {
+		ret = PTR_ERR(dbuf);
+		goto err_put_mem;
+	}
+
+	ret = dma_buf_fd(dbuf, O_CLOEXEC);
+	if (ret < 0)
+		goto err_put_mem;
+
+	return ret;
+
+err_put_mem:
+	__trinity_hwmem_put(mem);
+
+	return ret;
+}
+
+int32_t trinity_hwmem_free(struct device *dev, const int32_t fd)
+{
+	struct dma_buf *dbuf;
+	struct trinity_hwmem *mem;
+
+	dbuf = dma_buf_get(fd);
+	if (IS_ERR(dbuf)) {
+		dev_err(dev,
+			"failed to free the dma_buf structure with %ld\n",
+			PTR_ERR(dbuf));
+
+		return PTR_ERR(dbuf);
+	}
+
+	mem = dbuf_to_trnt_hwmem(dbuf);
+	__trinity_hwmem_put_dmabuf(dbuf);
+	__trinity_hwmem_put(mem);
+
+	dma_buf_put(dbuf);
+	return 0;
+}
+
+int32_t
+trinity_hwmem_import_dmabuf_begin(struct device *dev, const int32_t dbuf_fd,
+				  struct trinity_hwmem_import *import_info)
+{
+	struct dma_buf_attachment *attachment;
+	struct dma_buf *buf;
+	struct trinity_hwmem *mem;
+	struct iosys_map map;
+	int32_t ret;
+
+	if (!import_info)
+		return -EINVAL;
+
+	buf = dma_buf_get(dbuf_fd);
+	if (IS_ERR(buf))
+		return PTR_ERR(buf);
+
+	attachment = dma_buf_attach(buf, dev);
+	if (IS_ERR(attachment)) {
+		ret = PTR_ERR(attachment);
+		goto err_dbuf_put;
+	}
+
+	mem = attachment->priv;
+	import_info->dma_addr = mem->addr;
+	ret = dma_buf_vmap(buf, &map);
+	if (ret)
+		goto err_dbuf_put;
+
+	import_info->addr = map.vaddr;
+	import_info->attachment = attachment;
+	import_info->buf = buf;
+
+	return 0;
+
+err_dbuf_put:
+	dma_buf_put(buf);
+
+	return ret;
+}
+
+void trinity_hwmem_import_dmabuf_end(struct trinity_hwmem_import *import_info)
+{
+	if (!import_info || !import_info->buf)
+		return;
+	dma_buf_vunmap(import_info->buf, import_info->addr);
+	dma_buf_detach(import_info->buf, import_info->attachment);
+	dma_buf_put(import_info->buf);
+}
diff --git a/drivers/misc/trinity/trinity_hwmem.h b/drivers/misc/trinity/trinity_hwmem.h
new file mode 100644
index 000000000000..b75f3f14c537
--- /dev/null
+++ b/drivers/misc/trinity/trinity_hwmem.h
@@ -0,0 +1,81 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/**
+ * DMA memory buffers for Trinity device driver
+ *
+ * Copyright (C) 2020-2022 Samsung Electronics
+ * Copyright (C) 2020 Dongju Chae <dongju.chae@samsung.com>
+ * Copyright (C) 2020 Wook Song <wook16.song@samsung.com>
+ * Copyright (C) 2022 MyungJoo Ham <myungjoo.ham@samsung.com>
+ * Copyright (C) 2022 Yelin Jeong <yelini.jeong@samsung.com>
+ * Copyright (C) 2022 Jiho Chu <jiho.chu@samsung.com>
+ */
+
+#ifndef __DRIVERS_MISC_TRINITY_HWMEM_H__
+#define __DRIVERS_MISC_TRINITY_HWMEM_H__
+
+#include <linux/dma-buf.h>
+#include <linux/dma-mapping.h>
+#include <linux/kref.h>
+#include <uapi/misc/trinity.h>
+
+/**
+ * struct trinity_hwmem_import - A data structure to maintain imported hwmem
+ *   (that is Trinity DMA buffer).
+ * @dma_addr: The physical DMA address of this DMA buffer.
+ * @addr: A virtual address of this DMA buffer.
+ * @attachment: A pointer to &struct dma_buf_attachment.
+ * @buf: &struct dma_buf that this hwmem wrapped.
+ */
+struct trinity_hwmem_import {
+	dma_addr_t dma_addr;
+	void *addr;
+	struct dma_buf_attachment *attachment;
+	struct dma_buf *buf;
+};
+
+/**
+ * trinity_hwmem_import_dmabuf_begin() - Defines the beginning of a section to
+ *    import a given DMA buffer file descriptor.
+ * @dev: A pointer to the instance of the device to be attached the DMA buffer
+ * @dbuf_fd: The file descriptor of the DMA buffer to be imported.
+ * @import_info: If importing is successful, information such as the DMA
+ *    address, the virtual address which is mapped to the DMA address,
+ *    &struct dma_buf_attachment, a scatter-gather table, and &struct
+ *    dma_buf corresponding to the file descriptor will be passed
+ *    using this parameter.
+ *
+ * Return: 0 on success. Otherwise, returns negative error.
+ */
+int32_t
+trinity_hwmem_import_dmabuf_begin(struct device *dev, const int32_t dbuf_fd,
+				  struct trinity_hwmem_import *import_info);
+
+/**
+ * trinity_hwmem_import_dmabuf_end() - Defines the ending of the section related
+ *    to the given pointer to &strut trinity_hwmem_import.
+ * @import_info: Importing information related to the section to be ended.
+ */
+void trinity_hwmem_import_dmabuf_end(struct trinity_hwmem_import *import_info);
+
+/**
+ * trinity_hwmem_alloc() - Allocate Hardware memory according to type
+ * @dev: A pointer to the instance of the device to be attached the DMA buffer
+ * @size: Requested memory size
+ * @type: Requested memory type. It will try to allocate from reserved memory first
+ *
+ * Return: a file descriptor for the dma buffer on success.
+ *         Otherwise, returns negative error.
+ */
+int32_t trinity_hwmem_alloc(struct device *dev, const size_t size,
+			    enum trinity_hwmem_type type);
+
+/**
+ * trinity_hwmem_free() - Free Hardware memory
+ * @dev: A pointer to the instance of the device to be attached the DMA buffer
+ * @fd: A file descriptor for a allocated memory
+ *
+ * Return: 0 on success. Otherwise, returns negative error.
+ */
+int32_t trinity_hwmem_free(struct device *dev, const int32_t fd);
+
+#endif /* __DRIVERS_MISC_TRINITY_HWMEM_H__ */
-- 
2.25.1

