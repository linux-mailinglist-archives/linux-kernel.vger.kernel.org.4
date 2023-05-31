Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64288717C19
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 11:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235570AbjEaJiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 05:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234834AbjEaJiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 05:38:15 -0400
X-Greylist: delayed 176 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 31 May 2023 02:38:13 PDT
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DDC3A0;
        Wed, 31 May 2023 02:38:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1685525704; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=LfFJAHA9jn/4VujsURIdyriv2IXX8zYIfMYI4WCCktq3UgZxD0eMRoixIAajgW+Wge
    C85EwVSJO4x79ckM9aRETeXJyzPrAFektxK1Q15zZ4eDdQUfWlGqZM8DviTFS3TbOgvR
    T8p0MxnI4LlrC4I9mz+SKYKhDZhgcaQB9wQ3Uv7tfgUwYYZ8Gk8l6B+gR+U07IMqExOe
    0VniY8smoSHOq8IU7U4TejqNMgueYDodV03kM+jR9GpGv+r1fqtXLFRfDatOBS7r99GG
    U4YyHEEmGwMn7JRxl4haqFsW3nmjZskiN3w+FKpBzkDolYiC8oHZ7qIk9fZbDml4PoaS
    H+0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1685525704;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:Message-Id:Subject:Date:From:Cc:Date:From:Subject:Sender;
    bh=vNvnCnYJbsNHMwaqcK7ojGETmhD0ewutX/72aDr+oxw=;
    b=avcv0obcpwAycFez00nFJZdlXdQKLqsZdayRvwtQAW9k3z11M0xlzLyJ4Kro2YAufA
    dMMJoxiUqmOJesbLf8oLJpwXS7l5Dj/fve1NQgsIOgNaHvrim5HtOHWFBVLrGMndMvzv
    6HiUA2sk71EEs9HetWE5r/UWs7a3Ym7TZ1StIfWSqxmfViTViOKG4+67cBiu/a0faz4B
    WuWZLWC3IRe/2ADyifAg3z8VGJ2hOy1gbdWqY+IZQaLNUWYf5NuQk3Y5OtWE/Ld0J3Wp
    TsnLr2UytWSV9H5eMrwItynNXIJ3MZEh5nSkEpAFhYm2svqmlzxZGwUClMk7Wx9O6mA7
    dFyA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1685525704;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:Message-Id:Subject:Date:From:Cc:Date:From:Subject:Sender;
    bh=vNvnCnYJbsNHMwaqcK7ojGETmhD0ewutX/72aDr+oxw=;
    b=HnVoT8HzCQTiAXLb/fpjtzOVLp1QJA0daKxscngYdsus9a4SVN4LogWihqUAsimGXl
    LQY1WkqUe1LLSPTIgS9lbjmgHfbggSEycdEu16HX2ZuiJmQsA6/rUmLxa/G8IQA7X5w3
    lDFkJ3wGRuAIAsVXeEFEZdan/poK08MibIuWv2YqzDmhEmJ5z3rY8b9iz3c0HRM2oIRH
    S0+nH/rtZwt4HGEx6vBtRbDpCLNM3XvvlQV8BXAR2slgQHSZgivrF4SQX1yDHCEfeLXg
    gDQfMXviTUQPYJwVfYr3FYDI2lE0UBnaSDnRDrRvQILFPZ88nVx5XmSWJe6jw7fjdVQu
    R98g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1685525704;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:Message-Id:Subject:Date:From:Cc:Date:From:Subject:Sender;
    bh=vNvnCnYJbsNHMwaqcK7ojGETmhD0ewutX/72aDr+oxw=;
    b=Z2Z0JBC24Gh3Ibe5B8Roo//q5LGX6KRRHBPz+W0bgjaboYT0EeE1wt35XSJu1ATj16
    KrGvK98tPinJ5iexZCBg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn8u493mw=="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.4.0 DYNA|AUTH)
    with ESMTPSA id j6420az4V9Z4lnF
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 31 May 2023 11:35:04 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Wed, 31 May 2023 11:34:54 +0200
Subject: [PATCH] remoteproc: qcom: Use of_reserved_mem_lookup()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230529-rproc-of-rmem-v1-1-5b1e38880aba@gerhold.net>
X-B4-Tracking: v=1; b=H4sIAL0Ud2QC/x2NQQqEMAxFryJZG9DqKHoVcVFrqgFtJcVhoHh3w
 8DfvA+PlyGRMCUYiwxCX04cg0JdFuB2GzZCXpXBVKapPmZAuSQ6jB7lpBP7dWhq3+laAnUWmwg
 XscHtaoX7OPS8hDz//pFpfp4XNCgZ8HQAAAA=
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
See e.g. [1] for an example of dynamically allocated reserved memory.
(This patch does *not* depend on [1] and is useful without as well...)

NOTE: Changes in qcom_q6v5_adsp.c and qcom_q6v5_pas.c are untested,
I only checked qcom_q6v5_mss.c and qcom_wcnss.c on MSM8916/DB410c.
The code changes are pretty similar for all of those though.

[1]: https://lore.kernel.org/linux-arm-msm/20230510-dt-resv-bottom-up-v1-5-3bf68873dbed@gerhold.net/
---
 drivers/remoteproc/qcom_q6v5_adsp.c | 22 ++++++++--------
 drivers/remoteproc/qcom_q6v5_mss.c  | 35 +++++++++++++++----------
 drivers/remoteproc/qcom_q6v5_pas.c  | 51 ++++++++++++++++++++-----------------
 drivers/remoteproc/qcom_wcnss.c     | 24 ++++++++---------
 4 files changed, 69 insertions(+), 63 deletions(-)

diff --git a/drivers/remoteproc/qcom_q6v5_adsp.c b/drivers/remoteproc/qcom_q6v5_adsp.c
index 6777a3bd6226..948b3d00a564 100644
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
+	if (node)
+		rmem = of_reserved_mem_lookup(node);
+	of_node_put(node);
+
 	if (!node) {
-		dev_err(adsp->dev, "no memory-region specified\n");
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
index 70bffc9f33f6..af815f3cb2d1 100644
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
@@ -1872,11 +1871,9 @@ static int q6v5_init_reset(struct q6v5 *qproc)
 
 static int q6v5_alloc_memory_region(struct q6v5 *qproc)
 {
-	struct device_node *child;
 	struct reserved_mem *rmem;
+	struct device_node *child;
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
index ca0155f41dac..82f498fa9237 100644
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
base-commit: 1ca04f21b204e99dd704146231adfb79ea2fb366
change-id: 20230529-rproc-of-rmem-7d931f61f64e

Best regards,
-- 
Stephan Gerhold <stephan@gerhold.net>

