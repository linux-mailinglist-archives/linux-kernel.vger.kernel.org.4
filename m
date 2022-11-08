Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27250622045
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 00:23:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbiKHXX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 18:23:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbiKHXXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 18:23:06 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 096E826573
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 15:23:00 -0800 (PST)
Received: from notapiano.myfiosgateway.com (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 859A566029B4;
        Tue,  8 Nov 2022 23:22:56 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667949778;
        bh=N7EK7kKhEVKpHA7dJ/bAYyESVVrpoSMoTC6+PMXVR5Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RRfuzsiTDM99KtAT731vAuyEczrMkWK6H+AmoRx81fvPk8tQuLknnrdtuL5InsEMd
         5DrVfrhAt3Rgw2lIZvir8d/AiY8I9RQnavGcf+tTUtXas0PfEm8QKT/jhLAj9ws2yO
         YPhiRQ6GiMyz41GuefJDvckpr9dGWxPZdAcq8Hhu/4RpkRsiP3kdtN+ivWGN32MGKB
         gfGrjrgiB1mzWAUJx+1xRexp8QWRYVUB6CgqPi82OC2u6i7TtDAXLe3gYM6451pJ+E
         jV4Czak4HOOXsUEIe1Tx+aRnOewzkYcuhmH2dgc1spojyyDkpGZn/fB+IPHH8tN7hx
         hQ0glEWNppaiA==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>, Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Mark Brown <broonie@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 09/13] arm64: defconfig: Enable MTK_SCP
Date:   Tue,  8 Nov 2022 18:22:24 -0500
Message-Id: <20221108232228.1177199-10-nfraprado@collabora.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221108232228.1177199-1-nfraprado@collabora.com>
References: <20221108232228.1177199-1-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable support for the MediaTek System Companion Processor (SCP). It is
a required component in order to have working hardware video decoding on
several MediaTek SoCs.

By enabling this on the defconfig we make it effortless to test the
relevant hardware on CI systems like KernelCI.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index c54a85679d40..1070ecc68b08 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1124,6 +1124,7 @@ CONFIG_ARM_SMMU_V3=y
 CONFIG_MTK_IOMMU=y
 CONFIG_QCOM_IOMMU=y
 CONFIG_REMOTEPROC=y
+CONFIG_MTK_SCP=m
 CONFIG_QCOM_Q6V5_ADSP=m
 CONFIG_QCOM_Q6V5_MSS=m
 CONFIG_QCOM_Q6V5_PAS=m
-- 
2.38.1

