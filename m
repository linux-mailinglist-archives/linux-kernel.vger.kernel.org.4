Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9CA6D5B19
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 10:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233977AbjDDInX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 04:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233890AbjDDInV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 04:43:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A799268A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 01:43:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 049D662EA7
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 08:43:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A8C7C433EF;
        Tue,  4 Apr 2023 08:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680597790;
        bh=+CwDQqmqGsUNWHze2us4Rgr7tqETv05FzxmPTtoaoB0=;
        h=From:To:Cc:Subject:Date:From;
        b=rmHMsmZq76ND8+h5A0Ul9SeGz586DdJO6WmX7VEu9ee6ASwMW6UMFZTes1N/MiSTb
         2T2VB9W0ysRk0E3ODoADJg78H1fb93wbMfRJmPKJF7U6PrYfUy+aV6Dvek367gYNLP
         a41KRtz9l315cknqpE88WmLUkwQ/FGKCeDZPBVO0nWZBFZIKjbjMUtMZzZIu1opnxd
         bAupba1Jf5mwVi1Rua1G4zy7oHdHXOeXBg9f39Ec/VYM1OYv7gSir87d9uRBWHVDQR
         N31ua/etgVZhgXacaole9hD0RLBQ6Ttm7inBESbKj0bFMFqNTcVV2OsvV7TReKiwxF
         IQ8F/w+Umtdiw==
From:   Roger Quadros <rogerq@kernel.org>
To:     linux@armlinux.org.uk, arnd@arndb.de
Cc:     krzysztof.kozlowski@linaro.org, Thinh.Nguyen@synopsys.com,
        nm@ti.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Roger Quadros <rogerq@kernel.org>
Subject: [PATCH] ARM: multi_v7_defconfig: make USB_DWC3 as a module instead of built-in
Date:   Tue,  4 Apr 2023 11:42:59 +0300
Message-Id: <20230404084259.13752-1-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

USB_DWC3 is not required for boot on most platforms make it
as a module instead of built-in.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 arch/arm/configs/multi_v7_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 084cc612ea23..755cc96f23c5 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -855,7 +855,7 @@ CONFIG_USB_UX500_DMA=y
 CONFIG_USB_INVENTRA_DMA=y
 CONFIG_USB_TI_CPPI41_DMA=y
 CONFIG_USB_TUSB_OMAP_DMA=y
-CONFIG_USB_DWC3=y
+CONFIG_USB_DWC3=m
 CONFIG_USB_DWC2=y
 CONFIG_USB_CHIPIDEA=y
 CONFIG_USB_CHIPIDEA_UDC=y
-- 
2.34.1

