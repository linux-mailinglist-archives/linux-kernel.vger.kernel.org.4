Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2021A62203D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 00:22:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbiKHXWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 18:22:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbiKHXWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 18:22:41 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5B2624F12
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 15:22:40 -0800 (PST)
Received: from notapiano.myfiosgateway.com (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 62CC666029AF;
        Tue,  8 Nov 2022 23:22:37 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667949759;
        bh=dQcS6syYK2R0ziG0xFov3LcWWytzaiHW+di5SWFAS6M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DGZlld16gU3AKahH82Dq+/V81h1jMezuNR/RX/zb39W5c4PeV6e1h7QqLA74n9KS2
         LYGkZe2LvJYKN7ZSl9yojsea5Z5R0+mbqvjQHzEEV9LTKnXXKLv1sBqKbV2/A3FbL+
         AliT5PULY4UsA6lH9OAxgec83yG5XiEJaDoNDMsKfnYVj9V7Ngxv4TFRlCIaJ7mx3Y
         L1aSgExJ8Cxim/YovfGZH5n2QX1TXoO5FzxsL/ifLYo0X7kaL7ninw6D/7ge+i0IbL
         55p6+dQoeTdvwi1DH0N0o+1DKm2w9Zmi+FzXI6ti1MxNqkr/7f5wX7EV2WZN2Eh0nP
         x3B2V1HpAJP+Q==
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
Subject: [PATCH 02/13] arm64: defconfig: Enable ATH10K_SDIO
Date:   Tue,  8 Nov 2022 18:22:17 -0500
Message-Id: <20221108232228.1177199-3-nfraprado@collabora.com>
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

Enable support for the ATH10K wireless adapter when connected through a
SDIO/MMC bus. It is used by mt8183-kukui based devices.

By enabling this on the defconfig we make it effortless to test the
relevant hardware on CI systems like KernelCI.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 171fbecd7372..af072b47f762 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -392,6 +392,7 @@ CONFIG_USB_NET_PLUSB=m
 CONFIG_USB_NET_MCS7830=m
 CONFIG_ATH10K=m
 CONFIG_ATH10K_PCI=m
+CONFIG_ATH10K_SDIO=m
 CONFIG_ATH10K_SNOC=m
 CONFIG_WCN36XX=m
 CONFIG_ATH11K=m
-- 
2.38.1

