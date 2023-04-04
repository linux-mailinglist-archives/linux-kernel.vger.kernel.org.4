Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5510E6D5B2B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 10:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234046AbjDDIqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 04:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233594AbjDDIqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 04:46:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94EF1197
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 01:46:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2511D62FB9
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 08:46:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 442C4C433D2;
        Tue,  4 Apr 2023 08:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680598001;
        bh=yJOvZrwI7QotGIHmmKCaUwkx2y4WFem7FTsz2slq3+s=;
        h=From:To:Cc:Subject:Date:From;
        b=qSDTq/hVmvB8rBI+rQNk5TdhdUE3WdigH4IoOi8HUYZtmc3RQI2l8s1JiP42HblnL
         SXhRrXqxqWHNpVPXIR0YXw8ZzDIVvVp0HMzVgBF1u4seGv2sp/dGffKBggWUEECMZO
         wPra5s4SZey9N7odxHnDP9NJ9/CRMHpNxADH6opeaVKqf4DkhKsPkXJ+s9bro99hT7
         vKrig+CqM1FqJPa7Fmk2wrNmCsyXpFraISQ40zQpkjx9cw5l1eEvBv7gmQEYQp16AN
         MAlI8S6+P35DHcCAMmfaFtN9ZkpB0idk4nVfW2Bz8M8I/xYXA/+SOv/QASIQlsRGMI
         Rm22pcTqqLa5Q==
From:   Roger Quadros <rogerq@kernel.org>
To:     catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de
Cc:     krzysztof.kozlowski@linaro.org, Thinh.Nguyen@synopsys.com,
        nm@ti.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Roger Quadros <rogerq@kernel.org>
Subject: [PATCH] arm64: defconfig: make USB_DWC3 as a module instead of built-in
Date:   Tue,  4 Apr 2023 11:46:35 +0300
Message-Id: <20230404084635.13911-1-rogerq@kernel.org>
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

DWC3 is not required for boot on most platforms so make it
as a module instead of built-in.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 arch/arm64/configs/defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 7790ee42c68a..3009655632c8 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -927,7 +927,7 @@ CONFIG_USB_CDNS3_HOST=y
 CONFIG_USB_MTU3=y
 CONFIG_USB_MUSB_HDRC=y
 CONFIG_USB_MUSB_SUNXI=y
-CONFIG_USB_DWC3=y
+CONFIG_USB_DWC3=m
 CONFIG_USB_DWC2=y
 CONFIG_USB_CHIPIDEA=y
 CONFIG_USB_CHIPIDEA_UDC=y
-- 
2.34.1

