Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AEBE74DF63
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 22:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbjGJUfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 16:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbjGJUfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 16:35:20 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A919319A;
        Mon, 10 Jul 2023 13:35:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1689021304; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=DNg5rL5+sCVoiV6TmCQrGiA61e4SEX0d3Em8DuAVgRi0GtAq3ZJd/mLU54lFjrIGKD
    1xhgMDp/Ib5QbDS4USilcorvbvOhVT9V1Q1LGWD6wj03XMoy6h6FB3iYgvxUeg+226qI
    kjIlUzVXojyiWV8t3CY7UXKiMF1MKLHCtldbzuI3HjPctrDMkrsypeaxDetrJ1Wpka7t
    NQyOlY5zHnUp3SGEbTqcaFhDmt3UJUwUMShivTZsEDbyKtlR4nMopPB+G5lPKC8NsSj5
    KtuiCD+5/x+SdsvKWzFRARxc4ythrqf8kPauHVV0N71xScdjdRFh94h1GAdUcJuyqz87
    KBAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1689021304;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:Message-Id:Subject:Date:From:Cc:Date:From:Subject:Sender;
    bh=EgkGBW2vWZBjdhXymr3xsa79kz5LK9EjluZIRwNQy6s=;
    b=ROyQ7xeW/X+9SjX719qZdfd2Vt5GUMgIoKxmzD4DCy/Owkk94586xQ30Lg5TdS13ph
    apQFor2dB/aZlen42S6gdvnUjX/i0tRqxMD+qDql9AXfrShRnJR02JdqL/gz/m32VBil
    Cgj8YZiNtLw/289noN0PRNUWfe8zI5NVAz/TP0hHfeGWhKZC/xUN5OcbWg7lgd9CJE8q
    IAPUz5SrTvjx4qE59gvDD96V5K35U8VgIxikM2Ag6qC37u2hKyx9HzIza7VNHEigf8ip
    QcRSJv2OdOPACWX2gUGpRU6z58tyhXnquP+QkMvJyrVrXuhgFYkmbAVU0Qtdjdi6NmVX
    bY+Q==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1689021304;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:Message-Id:Subject:Date:From:Cc:Date:From:Subject:Sender;
    bh=EgkGBW2vWZBjdhXymr3xsa79kz5LK9EjluZIRwNQy6s=;
    b=gj0X9hMd9gqG1K1mBhhQ/E0NZoOQ5IQQS6XQRS28EE3DxHDvLI6OwP5zN44cPnkbLv
    MD6MuCoARD9GxIGODQZfKApNASQlQ61HrsLja2Tl3PdVUehrlvYAhRXxYnqXw2Fy4pWT
    UxMOZ/+q+jjPZu2HqDhri44Dp8UfajW/DYbkT4vOUCPtnZ08xUOxYA8mtSRbY6KhBLOV
    0or3FhJXB8yGDbE4t9KYt9guCJoifnOBU5s/LF2sszfGYbtzxuAXsd3wsDg3AR1XLmM+
    gjeKOLTvafSgCKaB8I7BEHYGZPAsz4fh0+6dHRVrY2R097kTCRsYmakiOXGZQvJ1Y7rX
    ED9w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1689021304;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:Message-Id:Subject:Date:From:Cc:Date:From:Subject:Sender;
    bh=EgkGBW2vWZBjdhXymr3xsa79kz5LK9EjluZIRwNQy6s=;
    b=JwDht8Qzba5Iq9svVBZbDDJQVfvArgNRjDER7qZ+kXg/N7jbut6ZfL04+2PYNMK3r8
    hyoHSRX5EFHbBXoq//DQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn9VOj79w=="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.6.0 DYNA|AUTH)
    with ESMTPSA id D0d0a8z6AKZ3Eoi
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 10 Jul 2023 22:35:03 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Mon, 10 Jul 2023 22:34:52 +0200
Subject: [PATCH v3] remoteproc: qcom: Use of_reserved_mem_lookup()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230710-rproc-of-rmem-v3-1-eea7f0a33590@gerhold.net>
X-B4-Tracking: v=1; b=H4sIAGtrrGQC/32NQQ6CMBREr0K69hvaWqWuvIdx0cIHmkBLfrHRE
 O5uYedCk9m8Sd7MwiKSw8iuxcIIk4su+AzyULC6N75DcE1mJkohSyU00EShhtACjTjCpdGSt+e
 cE7LsWBMRLBlf99nyz2HI5UTYutd+cn9k7l2cA733z8S39td84sBBWY6yqqrSWHPrkPowNEePM
 9u2kvjrCyhBK5TaaqVVpb79dV0/Q6TSbgEBAAA=
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reserved memory can be either looked up using the generic function
of_address_to_resource() or using the special of_reserved_mem_lookup().
The latter has the advantage that it ensures that the referenced memory
region was really reserved and is not e.g. status = "disabled".

of_reserved_mem also supports allocating reserved memory dynamically at
boot time. This works only when using of_reserved_mem_lookup() since
there won't be a fixed address in the device tree.

Switch the code to use of_reserved_mem_lookup(), similar to
qcom_q6v5_wcss.c which is using it already. There is no functional
difference for static reserved memory allocations.

While at it this also adds two missing of_node_put() calls in
qcom_q6v5_pas.c.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
Changes in v3:
- Revert additional rmem->size checks: None of the existing users of
  of_reserved_mem_lookup() have it so it sounds better to handle this 
  internally in of_reserved_mem. I'll work on a separate patch series
  to improve this independently of this one. (Caleb)
- Link to v2: https://lore.kernel.org/r/20230529-rproc-of-rmem-v2-0-95e39b959585@gerhold.net

Changes in v2:
- Add missing check for rmem (Bjorn)
- Add checks for rmem->size to ensure dynamic reserved memory was 
  really allocated
- Link to v1: https://lore.kernel.org/r/20230529-rproc-of-rmem-v1-1-5b1e38880aba@gerhold.net
---
See e.g. [1] for an example of dynamically allocated reserved memory.
(This patch does *not* depend on [1] and is useful without as well...)

NOTE: Changes in qcom_q6v5_adsp.c and qcom_q6v5_pas.c are untested,
I only checked qcom_q6v5_mss.c and qcom_wcnss.c on MSM8916/DB410c.
The code changes are pretty similar for all of those though.

[1]: https://lore.kernel.org/linux-arm-msm/20230510-dt-resv-bottom-up-v1-5-3bf68873dbed@gerhold.net/
---
 drivers/remoteproc/qcom_q6v5_adsp.c | 24 ++++++++---------
 drivers/remoteproc/qcom_q6v5_mss.c  | 33 ++++++++++++++----------
 drivers/remoteproc/qcom_q6v5_pas.c  | 51 ++++++++++++++++++++-----------------
 drivers/remoteproc/qcom_wcnss.c     | 24 ++++++++---------
 4 files changed, 69 insertions(+), 63 deletions(-)

diff --git a/drivers/remoteproc/qcom_q6v5_adsp.c b/drivers/remoteproc/qcom_q6v5_adsp.c
index 6777a3bd6226..d3caaa551916 100644
--- a/drivers/remoteproc/qcom_q6v5_adsp.c
+++ b/drivers/remoteproc/qcom_q6v5_adsp.c
@@ -14,8 +14,8 @@
 #include <linux/kernel.h>
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
-#include <linux/of_address.h>
 #include <linux/of_device.h>
+#include <linux/of_reserved_mem.h>
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
@@ -637,28 +637,26 @@ static int adsp_init_mmio(struct qcom_adsp *adsp,
 
 static int adsp_alloc_memory_region(struct qcom_adsp *adsp)
 {
+	struct reserved_mem *rmem = NULL;
 	struct device_node *node;
-	struct resource r;
-	int ret;
 
 	node = of_parse_phandle(adsp->dev->of_node, "memory-region", 0);
-	if (!node) {
-		dev_err(adsp->dev, "no memory-region specified\n");
+	if (node)
+		rmem = of_reserved_mem_lookup(node);
+	of_node_put(node);
+
+	if (!rmem) {
+		dev_err(adsp->dev, "unable to resolve memory-region\n");
 		return -EINVAL;
 	}
 
-	ret = of_address_to_resource(node, 0, &r);
-	of_node_put(node);
-	if (ret)
-		return ret;
-
-	adsp->mem_phys = adsp->mem_reloc = r.start;
-	adsp->mem_size = resource_size(&r);
+	adsp->mem_phys = adsp->mem_reloc = rmem->base;
+	adsp->mem_size = rmem->size;
 	adsp->mem_region = devm_ioremap_wc(adsp->dev,
 				adsp->mem_phys, adsp->mem_size);
 	if (!adsp->mem_region) {
 		dev_err(adsp->dev, "unable to map memory region: %pa+%zx\n",
-			&r.start, adsp->mem_size);
+			&rmem->base, adsp->mem_size);
 		return -EBUSY;
 	}
 
diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
index 70bffc9f33f6..69b90dc32d8a 100644
--- a/drivers/remoteproc/qcom_q6v5_mss.c
+++ b/drivers/remoteproc/qcom_q6v5_mss.c
@@ -15,7 +15,6 @@
 #include <linux/kernel.h>
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
-#include <linux/of_address.h>
 #include <linux/of_device.h>
 #include <linux/of_reserved_mem.h>
 #include <linux/platform_device.h>
@@ -1875,8 +1874,6 @@ static int q6v5_alloc_memory_region(struct q6v5 *qproc)
 	struct device_node *child;
 	struct reserved_mem *rmem;
 	struct device_node *node;
-	struct resource r;
-	int ret;
 
 	/*
 	 * In the absence of mba/mpss sub-child, extract the mba and mpss
@@ -1891,15 +1888,20 @@ static int q6v5_alloc_memory_region(struct q6v5 *qproc)
 		of_node_put(child);
 	}
 
-	ret = of_address_to_resource(node, 0, &r);
+	if (!node) {
+		dev_err(qproc->dev, "no mba memory-region specified\n");
+		return -EINVAL;
+	}
+
+	rmem = of_reserved_mem_lookup(node);
 	of_node_put(node);
-	if (ret) {
+	if (!rmem) {
 		dev_err(qproc->dev, "unable to resolve mba region\n");
-		return ret;
+		return -EINVAL;
 	}
 
-	qproc->mba_phys = r.start;
-	qproc->mba_size = resource_size(&r);
+	qproc->mba_phys = rmem->base;
+	qproc->mba_size = rmem->size;
 
 	if (!child) {
 		node = of_parse_phandle(qproc->dev->of_node,
@@ -1910,15 +1912,20 @@ static int q6v5_alloc_memory_region(struct q6v5 *qproc)
 		of_node_put(child);
 	}
 
-	ret = of_address_to_resource(node, 0, &r);
+	if (!node) {
+		dev_err(qproc->dev, "no mpss memory-region specified\n");
+		return -EINVAL;
+	}
+
+	rmem = of_reserved_mem_lookup(node);
 	of_node_put(node);
-	if (ret) {
+	if (!rmem) {
 		dev_err(qproc->dev, "unable to resolve mpss region\n");
-		return ret;
+		return -EINVAL;
 	}
 
-	qproc->mpss_phys = qproc->mpss_reloc = r.start;
-	qproc->mpss_size = resource_size(&r);
+	qproc->mpss_phys = qproc->mpss_reloc = rmem->base;
+	qproc->mpss_size = rmem->size;
 
 	if (!child) {
 		node = of_parse_phandle(qproc->dev->of_node, "memory-region", 2);
diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
index 3153d82037e7..58f8b81f6d52 100644
--- a/drivers/remoteproc/qcom_q6v5_pas.c
+++ b/drivers/remoteproc/qcom_q6v5_pas.c
@@ -13,8 +13,8 @@
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/of_address.h>
 #include <linux/of_device.h>
+#include <linux/of_reserved_mem.h>
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
@@ -533,9 +533,8 @@ static void adsp_pds_detach(struct qcom_adsp *adsp, struct device **pds,
 
 static int adsp_alloc_memory_region(struct qcom_adsp *adsp)
 {
+	struct reserved_mem *rmem;
 	struct device_node *node;
-	struct resource r;
-	int ret;
 
 	node = of_parse_phandle(adsp->dev->of_node, "memory-region", 0);
 	if (!node) {
@@ -543,17 +542,19 @@ static int adsp_alloc_memory_region(struct qcom_adsp *adsp)
 		return -EINVAL;
 	}
 
-	ret = of_address_to_resource(node, 0, &r);
+	rmem = of_reserved_mem_lookup(node);
 	of_node_put(node);
-	if (ret)
-		return ret;
+	if (!rmem) {
+		dev_err(adsp->dev, "unable to resolve memory-region\n");
+		return -EINVAL;
+	}
 
-	adsp->mem_phys = adsp->mem_reloc = r.start;
-	adsp->mem_size = resource_size(&r);
+	adsp->mem_phys = adsp->mem_reloc = rmem->base;
+	adsp->mem_size = rmem->size;
 	adsp->mem_region = devm_ioremap_wc(adsp->dev, adsp->mem_phys, adsp->mem_size);
 	if (!adsp->mem_region) {
 		dev_err(adsp->dev, "unable to map memory region: %pa+%zx\n",
-			&r.start, adsp->mem_size);
+			&rmem->base, adsp->mem_size);
 		return -EBUSY;
 	}
 
@@ -566,16 +567,19 @@ static int adsp_alloc_memory_region(struct qcom_adsp *adsp)
 		return -EINVAL;
 	}
 
-	ret = of_address_to_resource(node, 0, &r);
-	if (ret)
-		return ret;
+	rmem = of_reserved_mem_lookup(node);
+	of_node_put(node);
+	if (!rmem) {
+		dev_err(adsp->dev, "unable to resolve dtb memory-region\n");
+		return -EINVAL;
+	}
 
-	adsp->dtb_mem_phys = adsp->dtb_mem_reloc = r.start;
-	adsp->dtb_mem_size = resource_size(&r);
+	adsp->dtb_mem_phys = adsp->dtb_mem_reloc = rmem->base;
+	adsp->dtb_mem_size = rmem->size;
 	adsp->dtb_mem_region = devm_ioremap_wc(adsp->dev, adsp->dtb_mem_phys, adsp->dtb_mem_size);
 	if (!adsp->dtb_mem_region) {
 		dev_err(adsp->dev, "unable to map dtb memory region: %pa+%zx\n",
-			&r.start, adsp->dtb_mem_size);
+			&rmem->base, adsp->dtb_mem_size);
 		return -EBUSY;
 	}
 
@@ -584,29 +588,28 @@ static int adsp_alloc_memory_region(struct qcom_adsp *adsp)
 
 static int adsp_assign_memory_region(struct qcom_adsp *adsp)
 {
+	struct reserved_mem *rmem = NULL;
 	struct qcom_scm_vmperm perm;
 	struct device_node *node;
-	struct resource r;
 	int ret;
 
 	if (!adsp->region_assign_idx)
 		return 0;
 
 	node = of_parse_phandle(adsp->dev->of_node, "memory-region", adsp->region_assign_idx);
-	if (!node) {
-		dev_err(adsp->dev, "missing shareable memory-region\n");
+	if (node)
+		rmem = of_reserved_mem_lookup(node);
+	of_node_put(node);
+	if (!rmem) {
+		dev_err(adsp->dev, "unable to resolve shareable memory-region\n");
 		return -EINVAL;
 	}
 
-	ret = of_address_to_resource(node, 0, &r);
-	if (ret)
-		return ret;
-
 	perm.vmid = QCOM_SCM_VMID_MSS_MSA;
 	perm.perm = QCOM_SCM_PERM_RW;
 
-	adsp->region_assign_phys = r.start;
-	adsp->region_assign_size = resource_size(&r);
+	adsp->region_assign_phys = rmem->base;
+	adsp->region_assign_size = rmem->size;
 	adsp->region_assign_perms = BIT(QCOM_SCM_VMID_HLOS);
 
 	ret = qcom_scm_assign_mem(adsp->region_assign_phys,
diff --git a/drivers/remoteproc/qcom_wcnss.c b/drivers/remoteproc/qcom_wcnss.c
index 1ed0647bc962..334a9c75dad6 100644
--- a/drivers/remoteproc/qcom_wcnss.c
+++ b/drivers/remoteproc/qcom_wcnss.c
@@ -14,8 +14,8 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/io.h>
-#include <linux/of_address.h>
 #include <linux/of_device.h>
+#include <linux/of_reserved_mem.h>
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
@@ -506,27 +506,25 @@ static int wcnss_request_irq(struct qcom_wcnss *wcnss,
 
 static int wcnss_alloc_memory_region(struct qcom_wcnss *wcnss)
 {
+	struct reserved_mem *rmem = NULL;
 	struct device_node *node;
-	struct resource r;
-	int ret;
 
 	node = of_parse_phandle(wcnss->dev->of_node, "memory-region", 0);
-	if (!node) {
-		dev_err(wcnss->dev, "no memory-region specified\n");
+	if (node)
+		rmem = of_reserved_mem_lookup(node);
+	of_node_put(node);
+
+	if (!rmem) {
+		dev_err(wcnss->dev, "unable to resolve memory-region\n");
 		return -EINVAL;
 	}
 
-	ret = of_address_to_resource(node, 0, &r);
-	of_node_put(node);
-	if (ret)
-		return ret;
-
-	wcnss->mem_phys = wcnss->mem_reloc = r.start;
-	wcnss->mem_size = resource_size(&r);
+	wcnss->mem_phys = wcnss->mem_reloc = rmem->base;
+	wcnss->mem_size = rmem->size;
 	wcnss->mem_region = devm_ioremap_wc(wcnss->dev, wcnss->mem_phys, wcnss->mem_size);
 	if (!wcnss->mem_region) {
 		dev_err(wcnss->dev, "unable to map memory region: %pa+%zx\n",
-			&r.start, wcnss->mem_size);
+			&rmem->base, wcnss->mem_size);
 		return -EBUSY;
 	}
 

---
base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
change-id: 20230529-rproc-of-rmem-7d931f61f64e

Best regards,
-- 
Stephan Gerhold <stephan@gerhold.net>

