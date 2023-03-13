Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4413C6B7B07
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 15:51:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbjCMOvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 10:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbjCMOuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 10:50:46 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B50F573AD9;
        Mon, 13 Mar 2023 07:50:05 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32DEne6I049179;
        Mon, 13 Mar 2023 09:49:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1678718980;
        bh=KmiYo0Mp/7UOsWp+C/ZJZUsUsiy/rrCL5FhE3tFewDs=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=SKd9Z+mgcxyIqIbal0owo/zuLbzqDOTpdcKaNCqIoUlWFacUwMeECmsD3wFobRcGN
         W5K0devXLIC1UxfqDEx9W+F2fihRvgUeIlZK6pzt9JwQoxqxrn+7Tt6opiVFlK9RnA
         lyiQyAPnJbox9ia9cIikr3siuVTXddIDR4BXOL2o=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32DEnevi013609
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 13 Mar 2023 09:49:40 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 13
 Mar 2023 09:49:39 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 13 Mar 2023 09:49:39 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32DEncAR034152;
        Mon, 13 Mar 2023 09:49:39 -0500
From:   Jai Luthra <j-luthra@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jai Luthra <j-luthra@ti.com>
Subject: [PATCH v5 1/6] arm64: defconfig: Enable audio drivers for TI K3 SoCs
Date:   Mon, 13 Mar 2023 20:19:30 +0530
Message-ID: <20230313-mcasp_upstream-v5-1-d6844707aa8a@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230313-mcasp_upstream-v5-0-d6844707aa8a@ti.com>
References: <20230313-mcasp_upstream-v5-0-d6844707aa8a@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=840; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=HwVDODIMEdhkR4OZ+E+QhHZzJZLC2RvE10il4WYmg/w=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBkDzbSa9JVTxMnEeWN0igOUAK9GGBPe5WDrbHy+
 F1kPDbMZ2OJAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZA820gAKCRBD3pH5JJpx
 RV9RD/9TyT40gbWcd6ZdFMfcZbFdVo8mrQbFI9EqK9pW21SGIuUFnTb1VBwzQSQkBydZEasdpi/
 Njz9ve66Cdn/KOIwGEuSWF9haob0PsaxTqJur3JohRK1ev6BjKQZOFBEtoWahgAIuvJ/TRFmLMG
 QQiIdbtSSTnaecPxJisKC4JMFKYHwMDRSJjhFpXk4+pFm81J+fbdDOt+GBcQJK//HO2ql139e0L
 Yrv1wS7inKh8hWk2JBekhPP7AB7qzsg3oWVF3pOj2JDDIAFMkJuTE+ELlv3/H+1afrmsuRAoPM+
 py2vifnq9vnFC5+hSDI4Oi2qqYKxJBCRkc7d6NqWbpb9lrgNLUXn7tkxpnzC64Kf7UfPgCq7mLL
 80tGRNyoWG+5xzuax8h3p8LlKNa9lahqspdpRiY1KnxhppdgMLTxIejHuDKVXEdK+K3YEJzqwqE
 2doEgHzzKWg2hKA6teOx/2q1IaE0BUdhEpks2q9XGI7cXEqVLi2Hy2HsPqZ8fF3UXneU+hL20By
 pgfzoPCM2zHU6QoRViQe0k9iTgFYbQMKJvBrORaCLSHNxz3oY+v4HlWHKl7qIoKMl4xqZq+LFkS
 ObzG/UpmWzU2fosGZKoyYaRfd3Ui9W+GNo6w/VAZPYkJTMT5wPErQJiZA4/QiyLpuuur4IxK5AE
 +EzvKTFFXW66aYQ==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp; fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
