Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDDA36F2D11
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 05:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232622AbjEADGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 23:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232564AbjEADEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 23:04:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA75ADE;
        Sun, 30 Apr 2023 20:01:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0CDBE61774;
        Mon,  1 May 2023 03:00:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E38CC433EF;
        Mon,  1 May 2023 03:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682910056;
        bh=J6LbNaFIM1YU3bRKpGJb8CNQO+uadHaxuFTIa6EkB94=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t0t2bRMKo/ax/fNiTD9+GxLhQcSBKEQhAktQE9sZeo/hpZd2sc7p6Bes8gv2pdAb+
         t1GYXa4ZIoFA/n0v/bnNDJTIG2eaXDWvixFGELdCc1DEqnZkv3JBrvhE6NjNy3MEKj
         yx12UIuCUvcTbclGAOgYrTZR1AwxsnpLlHeJdtDXhqYnJYcgtu5okEiR2jEhTMNUV+
         uhSKTZdlUUONJBL0zNm46nmecFR6nrffKaSEm3p8i3Nd+x3abuNC3g2Gra66ihFghm
         GP29jQ2KMqSNZbhn3aRPeP9zZXdk3M08e3v65JLUNS7CZBjoF7S4WLihQl9zMmQkFQ
         Dx5Zj8zd1+f/g==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
        Martin Kepplinger <martin.kepplinger@puri.sm>,
        Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <sashal@kernel.org>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.2 19/37] arm64: dts: imx8mq-librem5: Remove dis_u3_susphy_quirk from usb_dwc3_0
Date:   Sun, 30 Apr 2023 22:59:27 -0400
Message-Id: <20230501025945.3253774-19-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230501025945.3253774-1-sashal@kernel.org>
References: <20230501025945.3253774-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>

[ Upstream commit cfe9de291bd2bbce18c5cd79e1dd582cbbacdb4f ]

This reduces power consumption in system suspend by about 10%.

Signed-off-by: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
index ddf0e330dc7c4..6f7157fe1a0a8 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
@@ -1299,7 +1299,6 @@ &usb_dwc3_0 {
 	#address-cells = <1>;
 	#size-cells = <0>;
 	dr_mode = "otg";
-	snps,dis_u3_susphy_quirk;
 	usb-role-switch;
 	status = "okay";
 
-- 
2.39.2

