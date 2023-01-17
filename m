Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F117766D90A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 10:00:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236311AbjAQJAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 04:00:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236110AbjAQI7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 03:59:51 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22348193F2;
        Tue, 17 Jan 2023 00:59:42 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30H7PwGT011648;
        Tue, 17 Jan 2023 08:59:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=Wg3yhR5SDIpApUjcoq7ZePYqqmXILfpMuduRw0RRF2M=;
 b=Frw1XRVxj8YceyQoM8LU0RdA0OBT2QgjOQt35N0jJyB7sdpv1nsQA0tRfdxqWXXbnVnW
 AdnT6eAPa15xEuwLwonCbxiLNy/IYJXUhYAq7FgqFGVnlHRLbIqYaAyCFdKdQvRYFLvP
 62AnUfD1hQL9545qMFVlj1er2gzeSvQHlzhZm4KH3BD8jt4R5NaL7nrYoVomrVYWloqR
 +azn2kUKEApMnsTxqQSNbJsiPM8ZCIUbIvx4AUnoN2wsg5VJQ+UII4KK5/YjIFsgUI9S
 qNrAM9Zj6f5Gn/7UKUQGqM0Z2hro5Fsd3qPw5N43j+3Zwx6MwP969lWnMWFZwix8gRAJ vw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n5b18958u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Jan 2023 08:59:26 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30H8xPIC028650
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Jan 2023 08:59:25 GMT
Received: from blr-ubuntu-87.ap.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 17 Jan 2023 00:59:20 -0800
From:   Sibi Sankar <quic_sibis@quicinc.com>
To:     <andersson@kernel.org>, <manivannan.sadhasivam@linaro.org>
CC:     <agross@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
        <konrad.dybcio@somainline.org>, <amit.pundir@linaro.org>,
        <regressions@leemhuis.info>, <sumit.semwal@linaro.org>,
        <will@kernel.org>, <catalin.marinas@arm.com>,
        <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
        Sibi Sankar <quic_sibis@quicinc.com>
Subject: [PATCH V4 05/11] Revert "remoteproc: qcom_q6v5_mss: map/unmap metadata region before/after use"
Date:   Tue, 17 Jan 2023 14:28:34 +0530
Message-ID: <20230117085840.32356-6-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230117085840.32356-1-quic_sibis@quicinc.com>
References: <20230117085840.32356-1-quic_sibis@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Yqdgvsmbpf6-tLAAC5qLVgvr4UySjd5t
X-Proofpoint-ORIG-GUID: Yqdgvsmbpf6-tLAAC5qLVgvr4UySjd5t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-17_04,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 lowpriorityscore=0 phishscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 impostorscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2301170075
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

This reverts commit fc156629b23a21181e473e60341e3a78af25a1d4.

This commit manages to do three API violations at once:

 - dereference the return value of dma_alloc_attrs with the
   DMA_ATTR_NO_KERNEL_MAPPING mapping, which is clearly forbidden and
   will do the wrong thing on various dma mapping implementations.  The
   fact that dma-direct uses a struct page as a cookie is an undocumented
   implementation detail
 - include dma-map-ops.h and use pgprot_dmacoherent despite a clear
   comment documenting that this is not acceptable
 - use of the VM_DMA_COHERENT for something that is not the dma-mapping
   code
 - use of VM_FLUSH_RESET_PERMS for vmap, while it is only supported for
   vmalloc

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
---
 drivers/remoteproc/qcom_q6v5_mss.c | 38 +++++-------------------------
 1 file changed, 6 insertions(+), 32 deletions(-)

diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
index 2f4027664a0e..e2f765f87ec9 100644
--- a/drivers/remoteproc/qcom_q6v5_mss.c
+++ b/drivers/remoteproc/qcom_q6v5_mss.c
@@ -10,7 +10,6 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/devcoredump.h>
-#include <linux/dma-map-ops.h>
 #include <linux/dma-mapping.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
@@ -961,52 +960,27 @@ static void q6v5proc_halt_axi_port(struct q6v5 *qproc,
 static int q6v5_mpss_init_image(struct q6v5 *qproc, const struct firmware *fw,
 				const char *fw_name)
 {
-	unsigned long dma_attrs = DMA_ATTR_FORCE_CONTIGUOUS | DMA_ATTR_NO_KERNEL_MAPPING;
-	unsigned long flags = VM_DMA_COHERENT | VM_FLUSH_RESET_PERMS;
-	struct page **pages;
-	struct page *page;
+	unsigned long dma_attrs = DMA_ATTR_FORCE_CONTIGUOUS;
 	dma_addr_t phys;
 	void *metadata;
 	int mdata_perm;
 	int xferop_ret;
 	size_t size;
-	void *vaddr;
-	int count;
+	void *ptr;
 	int ret;
-	int i;
 
 	metadata = qcom_mdt_read_metadata(fw, &size, fw_name, qproc->dev);
 	if (IS_ERR(metadata))
 		return PTR_ERR(metadata);
 
-	page = dma_alloc_attrs(qproc->dev, size, &phys, GFP_KERNEL, dma_attrs);
-	if (!page) {
+	ptr = dma_alloc_attrs(qproc->dev, size, &phys, GFP_KERNEL, dma_attrs);
+	if (!ptr) {
 		kfree(metadata);
 		dev_err(qproc->dev, "failed to allocate mdt buffer\n");
 		return -ENOMEM;
 	}
 
-	count = PAGE_ALIGN(size) >> PAGE_SHIFT;
-	pages = kmalloc_array(count, sizeof(struct page *), GFP_KERNEL);
-	if (!pages) {
-		ret = -ENOMEM;
-		goto free_dma_attrs;
-	}
-
-	for (i = 0; i < count; i++)
-		pages[i] = nth_page(page, i);
-
-	vaddr = vmap(pages, count, flags, pgprot_dmacoherent(PAGE_KERNEL));
-	kfree(pages);
-	if (!vaddr) {
-		dev_err(qproc->dev, "unable to map memory region: %pa+%zx\n", &phys, size);
-		ret = -EBUSY;
-		goto free_dma_attrs;
-	}
-
-	memcpy(vaddr, metadata, size);
-
-	vunmap(vaddr);
+	memcpy(ptr, metadata, size);
 
 	/* Hypervisor mapping to access metadata by modem */
 	mdata_perm = BIT(QCOM_SCM_VMID_HLOS);
@@ -1036,7 +1010,7 @@ static int q6v5_mpss_init_image(struct q6v5 *qproc, const struct firmware *fw,
 			 "mdt buffer not reclaimed system may become unstable\n");
 
 free_dma_attrs:
-	dma_free_attrs(qproc->dev, size, page, phys, dma_attrs);
+	dma_free_attrs(qproc->dev, size, ptr, phys, dma_attrs);
 	kfree(metadata);
 
 	return ret < 0 ? ret : 0;
-- 
2.17.1

