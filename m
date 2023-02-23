Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B80D06A0F1C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 19:06:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbjBWSGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 13:06:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbjBWSGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 13:06:13 -0500
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EACAC580FF;
        Thu, 23 Feb 2023 10:06:11 -0800 (PST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31NHUZqV027017;
        Thu, 23 Feb 2023 10:05:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=QJOWFJmvLNjPQ3cK/VFiHx9zeHs9QVtLszvjB+5MdRM=;
 b=Eag5Vm1FUQVc9LL2QOsZL5j8oAiKWo95jXAkZZiJ9szRRSG/khqTNHb7StHZ8pVXdLAE
 rF/QlSCRVoXxuwMzGs5F8nHmcfj7rqnup7wb+manf6q4tI01hryHklr5SIKB5gYpJzdE
 JM/TQa/1FP8lU4elUSrfaj8sJW3xLxeyuNjFM7aZwt+iHDtqhyJNHUH0hNXU0rp44vNV
 X0h9lBXn4WUcwq2V4l6tY5nnUBZbOOrPCo8/BTfLIw1chc/8q+Wntaw69lssuh1HhmkB
 VY0iijC/DkEuibu9+ksfBjp/L2Mh/M2Zh5FVJMtyqHnw1/RSvc3Q4e3v9nCBwIKBaLxS pA== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3nwy5h2cv6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 23 Feb 2023 10:05:54 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 23 Feb
 2023 10:05:52 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.42 via Frontend
 Transport; Thu, 23 Feb 2023 10:05:52 -0800
Received: from jupiter073.il.marvell.com (unknown [10.5.116.85])
        by maili.marvell.com (Postfix) with ESMTP id 369FB3F708C;
        Thu, 23 Feb 2023 10:05:50 -0800 (PST)
From:   Elad Nachman <enachman@marvell.com>
To:     <thomas.petazzoni@bootlin.com>, <bhelgaas@google.com>,
        <lpieralisi@kernel.org>, <robh@kernel.org>, <kw@linux.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Vadym Kochan <vadym.kochan@plvision.eu>
Subject: [PATCH v3 1/7] dt-bindings: PCI: armada8k: Add compatible string for AC5 SoC
Date:   Thu, 23 Feb 2023 20:05:25 +0200
Message-ID: <20230223180531.15148-2-enachman@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230223180531.15148-1-enachman@marvell.com>
References: <20230223180531.15148-1-enachman@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: r_4iGGjlhGyVKxlNajb7L28XPQ-x3psJ
X-Proofpoint-ORIG-GUID: r_4iGGjlhGyVKxlNajb7L28XPQ-x3psJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-23_11,2023-02-23_01,2023-02-09_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vadym Kochan <vadym.kochan@plvision.eu>

AC5 SoC has armada8k PCIe IP so add compatible string for it.

Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/pci/pci-armada8k.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/pci-armada8k.txt b/Documentation/devicetree/bindings/pci/pci-armada8k.txt
index ff25a134befa..b272fa4f08b5 100644
--- a/Documentation/devicetree/bindings/pci/pci-armada8k.txt
+++ b/Documentation/devicetree/bindings/pci/pci-armada8k.txt
@@ -4,7 +4,9 @@ This PCIe host controller is based on the Synopsys DesignWare PCIe IP
 and thus inherits all the common properties defined in snps,dw-pcie.yaml.
 
 Required properties:
-- compatible: "marvell,armada8k-pcie"
+- compatible: Should be set to one of the following:
+   - "marvell,armada8k-pcie" : For A7K/8K family of SoCs
+   - "marvell,ac5-pcie"      : For AC5 family of SoCs
 - reg: must contain two register regions
    - the control register region
    - the config space region
-- 
2.17.1

