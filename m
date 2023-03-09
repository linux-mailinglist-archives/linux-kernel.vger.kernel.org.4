Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 468876B2F1A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 21:49:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbjCIUtZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 15:49:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231358AbjCIUsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 15:48:09 -0500
Received: from comms.puri.sm (comms.puri.sm [159.203.221.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D561783CE;
        Thu,  9 Mar 2023 12:48:07 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 4C316E972E;
        Thu,  9 Mar 2023 12:47:15 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 7OxTexIafk1Y; Thu,  9 Mar 2023 12:47:14 -0800 (PST)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=puri.sm; s=comms;
        t=1678394834; bh=b23CjwT84vb1HvVrTGFwqQ7/Y0c4Q+X1AAE+BUxN8bU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=guz7X2pehUeo8q9uB//1aK/PqbFzbajwXs/BR37rIq9qgy1DVdNSfvjUnKHcmNaCA
         BbXGGUU4v+bsgguYjLs1l0+J2aNAl2EX5a9Quho26a9ANRa04t6z6PTsNro398TXP6
         Dt+C2LMLPyAV0tx8ziFx7WBCDzdLgGWL2mEe823D6uZ8UMRst0qmJ19aZp0OvZkOoB
         AOzI929fpRExrYOuBAlgaBZ6/RQhz3QOfYqJBagToEs+rjLZgsU3U6qXY1uJdrNMYP
         FJb2a3oKvrGkytLRYAJcGrrPrtrpNLKVO66m4NL3b4Wsgd64aZcOp1UndusKopVri7
         DH5ju/d3TYoLA==
To:     robh@kernel.org, krzysztof.kozlowski@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com
Cc:     kernel@puri.sm, linux-imx@nxp.com, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH v1 14/14] arm64: dts: imx8mq-librem5: Add 166MHz to DDRC OPP table
Date:   Thu,  9 Mar 2023 21:46:08 +0100
Message-Id: <20230309204608.237605-15-martin.kepplinger@puri.sm>
In-Reply-To: <20230309204608.237605-1-martin.kepplinger@puri.sm>
References: <20230309204608.237605-1-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>

This is the lowest frequency supported by older iMX8MQ SoC
revisions.

Signed-off-by: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
---
 arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
index 35bde8d41e8e7..ceced6bc4e898 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
@@ -329,6 +329,10 @@ opp-100000000 {
 			opp-hz = /bits/ 64 <100000000>;
 		};
 
+		opp-166000000 {
+			opp-hz = /bits/ 64 <166935483>;
+		};
+
 		opp-800000000 {
 			opp-hz = /bits/ 64 <800000000>;
 		};
-- 
2.30.2

