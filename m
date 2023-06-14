Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 214FD7304F8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 18:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234107AbjFNQcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 12:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233828AbjFNQcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 12:32:16 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 736C62130;
        Wed, 14 Jun 2023 09:32:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1686760326; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=okOjjl8veV+oeEje8GL2Fc+8r4BpKlqo8hJHJdcuaH9FEGdcIPNi679+4xt/7s1+ai
    2Dak8gdcrAjHoakNZH/t1cCz2rI3GrmcJOmLssQbBk5XIJR5deuTU1MzfQJPBpcwHWiW
    sTbbT9DJRhbLXgHrHaBj8TxCckkBtbuL2c4AoOrPwZUTMqerq0brH2U4qIoEw5vBkHhz
    0Iu65fTPJlWk3XCD2Yf+JU1kqteY3aDZe1+12IlCgS6QveD0H8TSSoIvDn8tFKKal0Wx
    yYIyx0n5YJWSQER3zbujbVQoNMVF87B35HEqbjEdAgjcfFu9tJMFZ0uZbA3QcEl9MqVj
    B3Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1686760326;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=8VChFjwSwm7NjkinO0t+vZkFyF4jH/l5wQUQYOlqibU=;
    b=fb944jlC8YqD156z+sRu5J6hV7ezoysdoZ6RH1XMarNwWSRYPf6z0EkQsBn1xJRoCl
    8M66HStjxVBIjGnhF6p6YZHVfDQP86ucF9HmWP8P7JYBdx0cH0LruuaEfVMEVZB4yQ/B
    MdBOln/ZKPKSQf6lXNc8D08lNcwiAIQ5/IDGlrZv0KhX/AwU8z4+cHVDW3VzzND2wme/
    IQv257wpuA0BAYO46yhbGbSrPevQXMWIx7riHwlPlLh9NRWwTTd/psekF0r6Kd1ih8t7
    2DfQBo77YKnqNGrb3G5vAi1LDjQFwsfShPeppEOD34mOb+rvIxhGkBRkqRcVtYGWCfZe
    aY5g==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1686760325;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=8VChFjwSwm7NjkinO0t+vZkFyF4jH/l5wQUQYOlqibU=;
    b=nJlw8ey+FF7ci0tkl57NFD/vDa3Sg9d2ubR1BWoDgEfTzn/tt87XbDAuf2/0EWR6VF
    KyDNxg8o8feZrp+AmK9AZ9SlASjrkdb2/8opXm4MVDamg7srWEajrSyYzD4NIP7FpF2h
    550crwJCmYRpI+dk2wclQK/HQG41jS1IXi+z/tosYtQdf+hV2o/dk7wfFmEKs6G72dz9
    N+NFOU1sazoQmvxDkkDWGquK+OzWySBB+KD+Mb+5HkD8lQZVol++wBNrUkIfPj8eRo2F
    TxpBNFEey1VtJub18CzxulVzh4lwjFYOJ5eqGDz8FM2YHxm75pvarYbs8Gib/ULBtBPe
    NM5w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1686760325;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=8VChFjwSwm7NjkinO0t+vZkFyF4jH/l5wQUQYOlqibU=;
    b=G64pqNNX1Vf2kLJWW8rq8HwrYWladHLUFBxHChn/Fmt6c4o1b0NbectN5k7AW0eb1D
    v6+5ALBvr1dnzdi4OEAg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn8u4xxmw=="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.6.0 DYNA|AUTH)
    with ESMTPSA id D0d0a8z5EGW50U4
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 14 Jun 2023 18:32:05 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Wed, 14 Jun 2023 18:31:55 +0200
Subject: [PATCH v2 2/2] remoteproc: qcom: Use of_reserved_mem_lookup()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230529-rproc-of-rmem-v2-2-95e39b959585@gerhold.net>
References: <20230529-rproc-of-rmem-v2-0-95e39b959585@gerhold.net>
In-Reply-To: <20230529-rproc-of-rmem-v2-0-95e39b959585@gerhold.net>
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

Link: https://lore.kernel.org/r/20230529-rproc-of-rmem-v1-1-5b1e38880aba@gerhold.net
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 drivers/remoteproc/qcom_q6v5_adsp.c | 24 ++++++++---------
 drivers/remoteproc/qcom_q6v5_mss.c  | 33 ++++++++++++++----------
 drivers/remoteproc/qcom_q6v5_pas.c  | 51 ++++++++++++++++++++-----------------
 drivers/remoteproc/qcom_wcnss.c     | 24 ++++++++---------
 4 files changed, 69 insertions(+), 63 deletions(-)

diff --git a/drivers/remoteproc/qcom_q6v5_adsp.c b/drivers/remoteproc/qcom_q6v5_adsp.c
index 6777a3bd6226..c87ab77fec16 100644
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
+	if (!rmem || !rmem->size) {
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
index a35ab6e860f3..dbd8bc53d0c9 100644
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
+	if (!rmem || !rmem->size) {
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
+	if (!rmem || !rmem->size) {
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
index ca0155f41dac..dd3fba4dae33 100644
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
+	if (!rmem || !rmem->size) {
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
+	if (!rmem || !rmem->size) {
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
+	if (!rmem || !rmem->size) {
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
index 1ed0647bc962..8bb0c8ef0771 100644
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
+	if (!rmem || !rmem->size) {
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
 

-- 
2.40.1

