Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32F406B2F07
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 21:48:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbjCIUsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 15:48:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbjCIUrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 15:47:32 -0500
Received: from comms.puri.sm (comms.puri.sm [159.203.221.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3300FD2B2;
        Thu,  9 Mar 2023 12:46:56 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 78388E9897;
        Thu,  9 Mar 2023 12:46:40 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id AmyielLRyqtc; Thu,  9 Mar 2023 12:46:39 -0800 (PST)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=puri.sm; s=comms;
        t=1678394799; bh=Zcg/QS78kOfaAlJQvFM2hpwItcK3AD7jlh3JN46lhH0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DmAut43WgyHKOeNqw8pMn/2bW2gIXNT85NRQMAHsUs+s6qNuL7Y+7rJorAJQdsVpO
         bKMWXVtWBdfCzk3MUf3pakhRmdhg6MeAbHEmtna6yCmDOpI1lUxDqRyQcuBBFtfCmC
         t1wb5jcvx818vUrOWj+tcInGyqEoOGNivgUvT9RrnIkE3zAylGHDWiESw0WtkTuQGn
         gobxwWFMOTO5/7Y7zT4G7E464IfUyXFPQT8QBChuYWiiKfOvk024RRn1mwYuW1HXYH
         M63WPTUb2TGX9kcWCOewubCUWrQMEU4nKcF9hKsWAJyGkoXWHxpO10ICONiHe2SN/7
         30BqXQck/fq5A==
To:     robh@kernel.org, krzysztof.kozlowski@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com
Cc:     kernel@puri.sm, linux-imx@nxp.com, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH v1 03/14] arm64: dts: imx8mq-librem5: fix audio-1v8 regulator name
Date:   Thu,  9 Mar 2023 21:45:57 +0100
Message-Id: <20230309204608.237605-4-martin.kepplinger@puri.sm>
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

Fix the regulator name for the audio-1v8 regulator.

Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
---
 arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
index fd1f6fb6d6f6f..6c44af94ac02b 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
@@ -84,7 +84,7 @@ reg_aud_1v8: regulator-audio-1v8 {
 		compatible = "regulator-fixed";
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_audiopwr>;
-		regulator-name = "AUDIO_PWR_EN";
+		regulator-name = "AUD_1V8";
 		regulator-min-microvolt = <1800000>;
 		regulator-max-microvolt = <1800000>;
 		gpio = <&gpio1 4 GPIO_ACTIVE_HIGH>;
-- 
2.30.2

