Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF85A6F2D61
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 05:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232332AbjEADLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 23:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232991AbjEADKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 23:10:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA6C2103;
        Sun, 30 Apr 2023 20:04:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ABCAE617B4;
        Mon,  1 May 2023 03:03:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28B12C433D2;
        Mon,  1 May 2023 03:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682910198;
        bh=SQXTV5XZGquC+Z8pmbTqaeIjqNcDZfTBI15ivXYNAyI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hIdtagklPEIz1wOkrwgJMaxTpyrOgMlFFbBjFAHxDnzll6iMwlGWODm0+bCjyvlbA
         NwS1VxQut7Q4ofsGoNPXQveDJudAh600JVPC21e+P3AUzrfL3Rg8dK97EeR3CLH5ko
         1Mb2EvBkNl0oB53DafpgORT9xYIiExDZkP9il45p5Wav85Jbu1fDJO7NAypPUv7nLr
         MITSyrog/KdP7r6VSLo4GW280Wl5I5+JbwEsqE2AUCGuu7t0eDRLRG8QZJhbUqNrEM
         8qB/ZDYxlUJ1ar8zKS9cFW00120nVcAFwzX2+gLLKdqxbm1feuznafHeboNJJJiUOZ
         2/Tcim+DvJ3fw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
        Martin Kepplinger <martin.kepplinger@puri.sm>,
        Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <sashal@kernel.org>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 16/33] arm64: dts: imx8mq-librem5: Remove dis_u3_susphy_quirk from usb_dwc3_0
Date:   Sun, 30 Apr 2023 23:02:10 -0400
Message-Id: <20230501030227.3254266-16-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230501030227.3254266-1-sashal@kernel.org>
References: <20230501030227.3254266-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
index ae08556b2ef2f..1499d5d8bbc04 100644
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

