Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D67AF6C7A6C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 09:55:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbjCXIzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 04:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231831AbjCXIze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 04:55:34 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B24ED1C307;
        Fri, 24 Mar 2023 01:55:33 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32O8tMlS036541;
        Fri, 24 Mar 2023 03:55:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1679648122;
        bh=DxU0T2hXjJm5KDnQGJfy7ceGai8k87bWNWNnCsPtSsg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=vE4cCgVyUGVvZ+s5UtXpRT05sY3Wu9WNSKwNxMCg106jLYCwW82u7DMfvzDxh/T56
         W4AlwLwT8qJylchKk9pq1N/4HTvvv8vj9kiaFY5EQSXpqp5FX4DVuSS2cNooSKxn/9
         l1dzCRk2W/ncXfT5+aOsA7qIJCwFOlXYkzDPKmKI=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32O8tMG7063738
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 24 Mar 2023 03:55:22 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Fri, 24
 Mar 2023 03:55:22 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Fri, 24 Mar 2023 03:55:22 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32O8tL1L035697;
        Fri, 24 Mar 2023 03:55:22 -0500
From:   Jai Luthra <j-luthra@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis <afd@ti.com>,
        Jayesh Choudhary <j-choudhary@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        Aradhya Bhatia <a-bhatia1@ti.com>, Jai Luthra <j-luthra@ti.com>
Subject: [PATCH v7 1/6] arm64: defconfig: Enable audio drivers for TI K3 SoCs
Date:   Fri, 24 Mar 2023 14:25:15 +0530
Message-ID: <20230313-mcasp_upstream-v7-1-88168d0df9b8@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230313-mcasp_upstream-v7-0-88168d0df9b8@ti.com>
References: <20230313-mcasp_upstream-v7-0-88168d0df9b8@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=888; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=hIQSN4mjS08ZYCycYNHfEzTIDOJFDZotIHYpiJLGHB0=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBkHWSF4WBU+dLnvhwy7tPDpExx5s5Kzb0yL+8Tq
 3uNkbwMrAuJAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZB1khQAKCRBD3pH5JJpx
 RVo2D/4xazMXS3XLaWaX/2OPuKKlxw+27je+ea3tRojiVMSzqXzWE/fHVu0inpMgr0BMkVmoMWa
 ZHoCKjMuk+LB92G3hUenguYbFLHPMKer918cEx4TlLYmmGUHxBmjEqoJOy+B2uRMjCMqpDT5Qnx
 cuVsTG5aSmyoN9EKdohfywEnl1dNhdUNbOmDsXbpZp4F9YhEDYBHxE+nbFCp8Afwc+jtZS3SsiK
 LJTDiJA2HkEKBnLOvy4IRJ00qOFyaoP8o5HLDdWQxx+BkeBiG30TS/M1kLuhuNq5uas7Q8GcirE
 bnQHcocq+2exuZKwbU/MeW+enr6V/V7AKH2vVkKRAp8HJKcht0S3lH/jNBMVy4N2tzA/Qj88vEH
 gaoypgghWfCs0mQl/v/N3m7TTqmb2c4rRMaZ8uk1kTIUcuh2fC67OEdXJgMLs7/pTfKjvoBQLk+
 NnHfIoSmGhsubQ0W6sVMQo6tT6PvlHf9zK4COhgxX+/68IGV0UNZZeTPqrLI2OPiTo3R+LqDs8o
 lZsHruYYtfNZUkr1gDBjnWPdz8MteGT2WWnxiaCGrpUqymWq/Sg5Aj4AscgiUGnnhHA+ZNUqaMC
 QYQqyj9WussvvWbpn5o5hlaBXWQ/lUdUzgcyTqAINq8xqPJ02b+qkpa00XKoS5npdBEG187pLTq
 eDhnpfc1THDNhcw==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp; fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TI's K3 platform uses McASP as the digital audio interface on the SoCs.
AM62x and AM62A based starter kits also use the TLV320AIC3106 codec with
a 3.5mm jack for analog audio input and output.

Signed-off-by: Jai Luthra <j-luthra@ti.com>
Reviewed-by: Devarsh Thakkar <devarsht@ti.com>
---
 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index b6e437486537..f3b004cb2500 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -920,6 +920,8 @@ CONFIG_SND_SOC_LPASS_WSA_MACRO=m
 CONFIG_SND_SOC_LPASS_VA_MACRO=m
 CONFIG_SND_SOC_LPASS_RX_MACRO=m
 CONFIG_SND_SOC_LPASS_TX_MACRO=m
+CONFIG_SND_SOC_DAVINCI_MCASP=m
+CONFIG_SND_SOC_TLV320AIC3X_I2C=m
 CONFIG_SND_SIMPLE_CARD=m
 CONFIG_SND_AUDIO_GRAPH_CARD=m
 CONFIG_SND_AUDIO_GRAPH_CARD2=m

-- 
2.40.0

