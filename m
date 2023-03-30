Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8626C6D000B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 11:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbjC3JpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 05:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbjC3JpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 05:45:02 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB55A83C8;
        Thu, 30 Mar 2023 02:45:00 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32U9isxB096122;
        Thu, 30 Mar 2023 04:44:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1680169494;
        bh=soXE9bktBToEycLhN2zBXHfzs7BMojhJ2uSbbRGceRg=;
        h=From:Date:Subject:References:In-Reply-To:To:CC;
        b=RxGwGMxvxqN9FQFS/ng2/gWJFwRB9iKQ415zy27lNl/KlGS01lHv5jbQi3NsrNVwk
         5nK1iZyEkB0Vg/6ZDweFuJHTE8TmoM3B/PQzmwNPoF2JRHvRRprDNtHsTu54hlh0b2
         6Mp2P+23ciEOCUbzYEumQaTz5RDUY/C/72LCS7RM=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32U9is3C003683
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 30 Mar 2023 04:44:54 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Thu, 30
 Mar 2023 04:44:53 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Thu, 30 Mar 2023 04:44:53 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32U9iq9n107081;
        Thu, 30 Mar 2023 04:44:53 -0500
From:   Jai Luthra <j-luthra@ti.com>
Date:   Thu, 30 Mar 2023 15:14:07 +0530
Subject: [PATCH v10 3/3] arm64: defconfig: Enable audio drivers for SK-AM62
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230313-mcasp_upstream-v10-3-94332149657a@ti.com>
References: <20230313-mcasp_upstream-v10-0-94332149657a@ti.com>
In-Reply-To: <20230313-mcasp_upstream-v10-0-94332149657a@ti.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1095; i=j-luthra@ti.com;
 h=from:subject:message-id; bh=ZO8au2iG1cOBrDND8B5Vouipf0z2YJCHnxzIsKjkbGw=;
 b=owEBbQKS/ZANAwAKAUPekfkkmnFFAcsmYgBkJVoG+woVuZG1ZDiiAsh6vvTVTjXZ0bVKGZkff
 w8XogN7X1mJAjMEAAEKAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCZCVaBgAKCRBD3pH5JJpx
 Rf9eD/0T6B2Tokl85gKZuEBLPLVA8xMT+WJrFLE7ueXloWjkrz2TBcq9N3L2RwTqX0/B5PqwEjz
 0VsI2LtN+5uNRPipwU5QpWJ2cwAzU45lklmFJnscrdBu8KSJ5snJBx6RQ1Wl/pvYPhJzb37s/kX
 yigjsRe6VnbX8CI6OwfcmrCdv3LDVr7s+55c73QluVSZ3ySOez6Ay+/CgDYBHyd6QwKgExAK/W7
 aflxGsni8tc57+ISnz1T7GRvQ3PCoMMmROvpNhKCUUvPuX96QvEqrR3wABoc8fZG+1Qp+9vqQKT
 WYkY8o4byRQ0e2HC4fr8wHRtX6Ki1L95hWLf84hqfDSRvjlUM7rmWeu4u4mXOEIjqKKfJ+qktki
 NVimR6x3ZdIDZlCXaHNLjAIC3D++yoM/p+bOqHThTjHSQm5Q2FOLxB9UzA5fcxsStn/KQHfeJCU
 fAQ//23xauZq4toQ+mCkFig4QOsz9T1rzSvKGBl88LjAeqUm22Y7TfSYcMy7RRu6+SfSLywQYit
 8crN/QWym1nwedCIAZJTAq5kWTtDJh2R3u0zp6/j6zdHH4aWtM/JL6E5O1MdAM/KR34lQxu6JYD
 55y7aScbgLUF9SgpBp/x0TUH/fgEdejUv2z72wdTT4FVIBNLlXxZYlL0yv/QMZT7VJYmSaMPg/U
 zEvt5jyUpXxubnA==
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
SK-AM62, SK-AM62-LP and SK-AM62A also use the TLV320AIC3106 codec with a
3.5mm jack for analog audio input and output.

Signed-off-by: Jai Luthra <j-luthra@ti.com>
Reviewed-by: Devarsh Thakkar <devarsht@ti.com>
---
 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index ca3569261713..a13119aecaa1 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -877,6 +877,7 @@ CONFIG_SND_SOC_TEGRA210_AMX=m
 CONFIG_SND_SOC_TEGRA210_ADX=m
 CONFIG_SND_SOC_TEGRA210_MIXER=m
 CONFIG_SND_SOC_TEGRA_AUDIO_GRAPH_CARD=m
+CONFIG_SND_SOC_DAVINCI_MCASP=m
 CONFIG_SND_SOC_AK4613=m
 CONFIG_SND_SOC_ES7134=m
 CONFIG_SND_SOC_ES7241=m
@@ -891,6 +892,7 @@ CONFIG_SND_SOC_SIMPLE_MUX=m
 CONFIG_SND_SOC_TAS2552=m
 CONFIG_SND_SOC_TAS571X=m
 CONFIG_SND_SOC_TLV320AIC32X4_I2C=m
+CONFIG_SND_SOC_TLV320AIC3X_I2C=m
 CONFIG_SND_SOC_WCD9335=m
 CONFIG_SND_SOC_WCD934X=m
 CONFIG_SND_SOC_WM8524=m

-- 
2.34.1

