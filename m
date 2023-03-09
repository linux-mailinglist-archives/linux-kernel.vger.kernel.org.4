Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 362B46B2F03
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 21:48:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbjCIUr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 15:47:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjCIUr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 15:47:28 -0500
Received: from comms.puri.sm (comms.puri.sm [159.203.221.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8529FA8CF;
        Thu,  9 Mar 2023 12:46:53 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 7EEE3E9843;
        Thu,  9 Mar 2023 12:46:34 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id XdmdtZIwla9w; Thu,  9 Mar 2023 12:46:33 -0800 (PST)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=puri.sm; s=comms;
        t=1678394793; bh=kH7aQE7e3IvmrZCyAx9WYSO5F0vKvEHVshKC+bqbnCY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FYVNVUsaCVPykbjqFdNC0ILcsb6ok2OyJDxYKnOSri1oJiGf1COpJYVoLouRMAqkB
         h0+srzrDFfOzW/55iVR5snboIdU6bsMNtQ71WMzfrPTiXlysY+ETNK3OJWyXxglRkb
         6z7+2wHCGuhNZkkmhoVY6tyONSTJyyxHG7sUNtdI3nIvfu10lpz/OQke/mTCT9zrUg
         e2KijTmBsHU/df/hhzxFCZlr3eRi9vx4YJHtG7F9104ZA7Vp7sU+gvDeh05uH79atJ
         LLw1f3mXNQDYveEbkocjrXIkC9+BibKEUEYVIKbTVbK3jGxUBk1bP0CJ//bGhEdDUz
         TBIkia55cjMiA==
To:     robh@kernel.org, krzysztof.kozlowski@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com
Cc:     kernel@puri.sm, linux-imx@nxp.com, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH v1 01/14] arm64: dts: imx8mq-librem5: lower the mipi csi 1 frequencies
Date:   Thu,  9 Mar 2023 21:45:55 +0100
Message-Id: <20230309204608.237605-2-martin.kepplinger@puri.sm>
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

No frames are streamed when using the default frequencies. I'm not yet
sure why the fastest ones don't work here but we've been using these
frequencies successfully for a long time now.

Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
---
 arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
index 6895bcc121651..c81cf3e6582b1 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
@@ -1143,6 +1143,7 @@ &lcdif {
 };
 
 &mipi_csi1 {
+	assigned-clock-rates = <266000000>, <200000000>, <66000000>;
 	status = "okay";
 
 	ports {
-- 
2.30.2

