Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 218706CD7B4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 12:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231592AbjC2Kb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 06:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbjC2Kbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 06:31:42 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C215C40E4;
        Wed, 29 Mar 2023 03:31:40 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32TAVNFV098558;
        Wed, 29 Mar 2023 05:31:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1680085883;
        bh=evH6NlSfC6ukDkHq1RYFqCNDtKO4XLbdcB7mFJAgoXY=;
        h=From:Date:Subject:References:In-Reply-To:To:CC;
        b=LNeGIa6DCpDOx5hoqr5uBRKqPf3cSwD/Sh/vYnnrWVw8E5pu+cbD3kPMwu34zpdkv
         +UyC7reF7Z5wm6M4DWvFnJrgJjwzfBb77BiewjQa3wJ8QwEyplgHGFFdYHWb/rmEnw
         sZfI96wYQdQhw9A/NaGiOujP3N6cbl/MS860bkoU=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32TAVNlf082055
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Mar 2023 05:31:23 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 29
 Mar 2023 05:31:23 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 29 Mar 2023 05:31:23 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32TAVMjt054052;
        Wed, 29 Mar 2023 05:31:23 -0500
From:   Jai Luthra <j-luthra@ti.com>
Date:   Wed, 29 Mar 2023 16:00:58 +0530
Subject: [PATCH v9 1/6] arm64: defconfig: Enable audio drivers for TI K3
 SoCs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230313-mcasp_upstream-v9-1-6d937efe4ec4@ti.com>
References: <20230313-mcasp_upstream-v9-0-6d937efe4ec4@ti.com>
In-Reply-To: <20230313-mcasp_upstream-v9-0-6d937efe4ec4@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Aradhya Bhatia <a-bhatia1@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        Jayesh Choudhary <j-choudhary@ti.com>,
        Andrew Davis <afd@ti.com>, Jai Luthra <j-luthra@ti.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=888; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=A/i+gSYF1tSPGzeqg5nnxVvjq+TjRkwOOWNkdTtifIo=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBkJBN0lDMaLFz4ghbIuN2+Qg7hUrXUXd5dn4CxI
 /r8JOq4rUiJAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZCQTdAAKCRBD3pH5JJpx
 RUY+D/9wSf3SEuetdWEN7EvluYe3r0n4fLCDZGarnIA5dcjKtucfAIemFo7h4DU7KjpWH4GPQ/q
 G3Q75j74pxH7tuIViU5330n1pV475M2iHWCalsKk5mehsadY1n5gGIxC9NVgDVNFOb5bqJOs2hG
 rVYv7IrDvTApyQZsJFrhPH1xvpeVLaBaya5T7AEwcCoJarjvwj7hUPssC62fSRuQOH07PggJBQB
 tD6AfBi4z/c7X6+bXocuKEwwr2o6aVsY+95j8kX+eyCMSP35t9ynl9SkfNuQRcpYDBGbr63zhEt
 /XzKj5VZk+BTugLwQdG7213pEVNZF7u5onbb4nhwIYkc4YgqwfYPH12sikSHRMOSr0iSKzV82NB
 9igDjqI8sj3hKX/pKNzMk1rLTodNF1hvLIv0MeaDTqtS335Y3eVn+2i87VpEa96tTOzPRdCBgSV
 xFZslPNTUu4FlQjIXs7Q6TBYwtqunrfyKFxZRr5kyagqP1sGalsHGh4k+TT43b18YsLq2d2A78W
 K0tca3picvwfsH/kSRc13ieN688CUh1HcvMyFzgwQ3j2Kk2fc/5nEWaNx6Lxx22nJ1Pa133glYH
 jOOxx6Uxy5jiGM0GSHSXbOXAXwPzXfBmRfPxL2c+HQSIaWyAdXXZjzKG3aHCOeIUkeKvf6WGJ5Y
 UzPedx4zheK1l3g==
X-Developer-Key: i=j-luthra@ti.com; a=openpgp;
 fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145
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
index ca3569261713..aa36792b6822 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -904,6 +904,8 @@ CONFIG_SND_SOC_LPASS_WSA_MACRO=m
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

