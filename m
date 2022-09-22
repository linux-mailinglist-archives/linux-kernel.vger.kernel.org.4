Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6D575E6C05
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 21:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbiIVTuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 15:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232312AbiIVTut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 15:50:49 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 496F0D62C0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 12:50:48 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id l10so9771416plb.10
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 12:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=5tt7YLxb3iDcVpONdfVeohLCDRWuffI/hhfrEZ2pSF8=;
        b=h6xPN0Bjf71EYlB5n0zzVKm2rMfxWHbN8Qtm9w++gJd9s4D3wX0a+xO5brKr+kql9U
         icW2Zo7Ws4YwHc4i3wCPPiMtQzlgZW6x/0ktbU+BpnXSJed18PsUovhmCHq6fnPw4CPE
         JIfD6j/JsHZ8ft6Rk2g4KR20wEYmEiXSOJvodW1pctYaztBzZwcmPz1bFgtD4fQUV2t1
         1BajaKC6U+x2NDN5OQsS3KMlkxCk+rOkwk4f9mUdSbpY4xlxHkW/OYXauvZD+lcdyXKH
         uppNjM79vRC0iBPhZUhO5sGsg+WJWHdr2Q57UD6uE7QX6LjQGLkmNS1xbMtmyCJUfyJn
         pz6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=5tt7YLxb3iDcVpONdfVeohLCDRWuffI/hhfrEZ2pSF8=;
        b=zyRrxf+5w9PMyfScdBlfGHozOzPHshKG5hPSJ/kKituo6UbGpR0frSPbPT8LGViZTc
         nctZl7DlOe4ljFtJGMKHqVp7EQ92mcGguTTTk/XM77ElIbD980FIowY3gRSt1h0IYrBc
         /GCIaF1pEKLDZ0BnzEfbI2KFDlaHvcGAMcEy9FBoFfaMWh9phB7RYKFmR+klbkVgpKJp
         OPKa7f+QR2r0yPpGSYx+88fjWhY/P/lvp/1kOogvX12nsX38DfNDzIRhd4RSlIsoqv4J
         1e+Ru6O0qIve7psc1V6kA2v4mMxNMI57D7XJc4cUMXTpGuEO6Wt1AQtr5oUxEBxXIXet
         SG3g==
X-Gm-Message-State: ACrzQf1HTers9sHAx4hO0B1wRNow0qiUq7FPTeibqwi0BCbk1PUCVwd0
        Dy7YeuzBEy9Un3+WXg0MkS8=
X-Google-Smtp-Source: AMsMyM4BX2JAjVqDC5m12Arx98zHe3YmAcgOamIu6cZboc2pfDVDhkYwlkHNaehZJX/65gJcF6g5Gw==
X-Received: by 2002:a17:90a:d3c2:b0:202:acc2:1686 with SMTP id d2-20020a17090ad3c200b00202acc21686mr5413161pjw.126.1663876247691;
        Thu, 22 Sep 2022 12:50:47 -0700 (PDT)
Received: from archl-hc1t.. ([103.51.72.15])
        by smtp.gmail.com with ESMTPSA id n3-20020a170902e54300b001768517f99esm4446775plf.244.2022.09.22.12.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 12:50:47 -0700 (PDT)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Anand Moon <linux.amoon@gmail.com>,
        linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: defconfig: Enable Synopsys DWC MSHC driver
Date:   Thu, 22 Sep 2022 19:20:48 +0000
Message-Id: <20220922192050.2031-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the driver SDHCI support for the Synopsys DWC MSHC
controller which can be found on Rockchip 356x SoCs.

Cc: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index d5b2d2dd4904..be1afd1020c6 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -914,6 +914,7 @@ CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_ACPI=y
 CONFIG_MMC_SDHCI_PLTFM=y
 CONFIG_MMC_SDHCI_OF_ARASAN=y
+CONFIG_MMC_SDHCI_OF_DWCMSHC=y
 CONFIG_MMC_SDHCI_OF_ESDHC=y
 CONFIG_MMC_SDHCI_CADENCE=y
 CONFIG_MMC_SDHCI_ESDHC_IMX=y
-- 
2.37.3

