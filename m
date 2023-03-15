Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA4E6BAB7D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 10:04:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjCOJET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 05:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjCOJEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 05:04:16 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EAD824124;
        Wed, 15 Mar 2023 02:03:52 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32F93eZr127348;
        Wed, 15 Mar 2023 04:03:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1678871021;
        bh=KmiYo0Mp/7UOsWp+C/ZJZUsUsiy/rrCL5FhE3tFewDs=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=HiClqlSekjRUGVyA4HA4B/lp6sbHgEqGm6Li+euW1kgUyT+jAIJ0XOgQuBTXwySlW
         3/88Vxz5G7/tGR/G3UVrrEcfY90drGvQcPd/GK/qbN5WVA1B5pqiFqUKJawz7ix207
         jqK69oENRIMx/Tj7/G8QHmbgwsxdjjS04lCNIMrA=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32F93eWG005946
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 15 Mar 2023 04:03:40 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 15
 Mar 2023 04:03:40 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 15 Mar 2023 04:03:40 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32F93dbK055346;
        Wed, 15 Mar 2023 04:03:40 -0500
From:   Jai Luthra <j-luthra@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis <afd@ti.com>,
        Jayesh Choudhary <j-choudhary@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        Aradhya Bhatia <a-bhatia1@ti.com>, Jai Luthra <j-luthra@ti.com>
Subject: [PATCH v6 1/6] arm64: defconfig: Enable audio drivers for TI K3 SoCs
Date:   Wed, 15 Mar 2023 14:33:30 +0530
Message-ID: <20230313-mcasp_upstream-v6-1-77685d7cbeb8@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230313-mcasp_upstream-v6-0-77685d7cbeb8@ti.com>
References: <20230313-mcasp_upstream-v6-0-77685d7cbeb8@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=840; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=HwVDODIMEdhkR4OZ+E+QhHZzJZLC2RvE10il4WYmg/w=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBkEYdWkJG1mF8uNjfE7WqYPLm3Fxfhj49x4rx5r
 0ZdzfG2rn+JAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZBGHVgAKCRBD3pH5JJpx
 RWuTEACLGecPCJpEA1HYo5G1/8Gze5zn0Sbe0czlj8QERUTDnhQhOgik/Y/IZzgAoXxoJLIrquL
 KHWK7jVPmdXQN5o9mx2qFApXVDly0FngDjsCZ9ZnY7rg1+t20Nw0dGaiIM78CkJZfM4Crv9Vk7k
 mf+s8vqRdvxtZzpqEWHnzo9lP4Vr1jiG7UVUC4xFdzMxlwiY4px12BL+64NKq0TFwPDXNgm0a+e
 9GcY7mXYSVWyKcS6gDLPjzkY7gyrlcA7sfhkK07B8+vvgErMdUa0xasibQ4QeIjv3jHIFbqCKRq
 ww2Sh9lj4GSAUl9HQzHLDZD/Ns+ziVJZW9/ohWUfccUjaxfdQ7Jt2jbz/kdsJNvwRsSXlqD6/Mi
 SMqV0AbQ9GB3McREXNxL3SSeX8zAT8cjwr1DEx7j+TQHnYw6r4AQ+duQmzR0fOeISYcF9UOHKsp
 5TzbFDtVgXkGBJulzGSTF6IjkwzW3JDwHMXdds+PRh0N19iPDNWglKTvatuspdChVZvP7v50FFg
 KopQSlVTR9M4m0w59xnYreFwK51+XEe0fZu6UZhOwpeVqf2BjziGcPD91z3uB3Gonj1KAK6MdOU
 wau548tRTJZEarM/TIPPAkq+rXJRcOF5btlB8Adpu225z3leH2DDa6G8WHPoZltGmUoAgZTM6zR
 5+rPAXtXK1D4yNQ==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp; fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TI's K3 platform uses McASP as the digital audio interface on the SoCs.
AM62x and AM62A based starter kits also use the TLV320AIC3106 codec with
a 3.5mm jack for analog audio input and output.

Signed-off-by: Jai Luthra <j-luthra@ti.com>
---
 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 7790ee42c68a..7e0ce1833904 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -898,6 +898,8 @@ CONFIG_SND_SOC_LPASS_WSA_MACRO=m
 CONFIG_SND_SOC_LPASS_VA_MACRO=m
 CONFIG_SND_SOC_LPASS_RX_MACRO=m
 CONFIG_SND_SOC_LPASS_TX_MACRO=m
+CONFIG_SND_SOC_DAVINCI_MCASP=m
+CONFIG_SND_SOC_TLV320AIC3X_I2C=m
 CONFIG_SND_SIMPLE_CARD=m
 CONFIG_SND_AUDIO_GRAPH_CARD=m
 CONFIG_SND_AUDIO_GRAPH_CARD2=m

-- 
2.39.2
