Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EFA36CC0D8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 15:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233145AbjC1NaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 09:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233121AbjC1N3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 09:29:48 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A815BDC8;
        Tue, 28 Mar 2023 06:29:44 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32SDTWO7039861;
        Tue, 28 Mar 2023 08:29:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1680010172;
        bh=1GtChf5uKiuwn7OvNybLChaTrFxr5FfqKFgP6cHU+XU=;
        h=From:Date:Subject:References:In-Reply-To:To:CC;
        b=RaPe6qr/eUSvgdq7gdaINnE89PcLw8rXJh8J9n4lNS8tCuN6ebgQPKrlClSap3x9d
         D0yrmOB1f7LlNbHVjh3dOxIsSTcHI6y4TMQArgDyYjJX5jlkJapbIqcCTv722GAUQj
         /V/Cs3q6Vv3RYV/esgxEqUr6dNpgjMGjo4oXCL3U=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32SDTWBV125950
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 28 Mar 2023 08:29:32 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 28
 Mar 2023 08:29:32 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 28 Mar 2023 08:29:32 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32SDTVRG007386;
        Tue, 28 Mar 2023 08:29:32 -0500
From:   Jai Luthra <j-luthra@ti.com>
Date:   Tue, 28 Mar 2023 18:59:19 +0530
Subject: [PATCH v8 1/6] arm64: defconfig: Enable audio drivers for TI K3
 SoCs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230313-mcasp_upstream-v8-1-4408134eb2f3@ti.com>
References: <20230313-mcasp_upstream-v8-0-4408134eb2f3@ti.com>
In-Reply-To: <20230313-mcasp_upstream-v8-0-4408134eb2f3@ti.com>
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
 h=from:subject:message-id; bh=wZfBiEbhTUv8dcdW1NR4C+wvCaboQpeHbYEligjEsOw=;
 b=owEBbQKS/ZANAwAIAUPekfkkmnFFAcsmYgBkIuu1Y3gBEMt3pQZinkVQlD679Ouwg8mvAq9SG
 4uaam78UuOJAjMEAAEIAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZCLrtQAKCRBD3pH5JJpx
 RSnCEACqiRCaXfxy9vr4bhwJd70MUgE8Uw1vn8X4Xp3Uxj6MrjYCzzmBdEkTrV8hphRGHZclGNl
 MlR9240I2sqK+fNHgboZY2fKNNWmBzhifxaSzvWbsKMJdMJ7/tp1LioYJAxSj5HyWSV7enWGExM
 Vbxpl2ZX5jpABKqjtK4JD/7OPzdlfVVIDFcVAUCu/aDnLPNKVMkcts9KGM9FatIcMAumSBNbvhK
 NEGYGll5O42Yw4SPnjNWhEXulVrZtZE6EA6J3fd/AhvaRUN3ffok1ne1kkOF/Q3faPzCr1W9Po+
 tDrwvhxkg0tDz+i2rWZIB0oqMOjjnHWUOLAesCNoGjxATI+fBok4X6tCxkuZ4erHHMAz2uMFkzo
 mQFBNMcDbuCpdBDruigcM2kMKaj1Z/1YUEPlcxakmj+dnTkLzxdGQaDta5ZcJZUNHIDLaD4dmh8
 Y21WtBs7LCQoEZ1fahv/FfxdnEXvRXSbpv7IC10nJipId7AUKxFGqZuaXcZQByARbdyqiM1Ecwc
 emqpAZWuY2zN38Fg3sHhIYmGwb/ktBM5k4h6r8dcArzKb77JukE+sbosHYxDZjKjunrAqRH4uCl
 77iXGE3+M6Rad0s58GRETaCN0xmzECiZ5MhW7siRpkQ9OMp89klHg2I5mmqAGTmzO7uMyoytkg8
 yWrnRN6ywonRMzQ==
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
2.40.0

