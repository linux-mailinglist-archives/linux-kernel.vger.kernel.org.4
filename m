Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92C95603A1F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 08:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbiJSGw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 02:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiJSGwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 02:52:19 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B75706C12F;
        Tue, 18 Oct 2022 23:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=1w6iARXkcU5udr40SXfE+pLZ56UmQ/8xdX5bxFQ1ePc=; b=Y+FB9sR7gOWgn9WpyzFoXQmUvD
        m6n64RUEP8cQo0gKhz0hZ4ZA+u3P5po72+Hu/KVZkGUcIxGd/qeX7GjmMl32T3+i9Ow2BVd+xySXN
        TEoa2f9cBgQoZaj5WYrMDf+qvjWfbX7LTfdIKv2l8BYVcuC5HN2qY7q/gsrPA+EKqpaF7OGzmvNh8
        9qSu9t6goBkxLTlQM6xDZIO+xFYDjKxP97Z7adCuxCYfdqEQnNNDOVZ129pzl2trgnve7Sz4I9meY
        kiwWwkcjw7t32xx3oyCDkIdHeK8C8ThoNoBaLsQE2W02wjEA9bE76xQQG3v5HCSxtvv1xxljRKffE
        FKC8mNbQ==;
Received: from p200300ccff064b001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff06:4b00:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1ol2vr-00045r-0h; Wed, 19 Oct 2022 08:52:03 +0200
Received: from andi by aktux with local (Exim 4.94.2)
        (envelope-from <andreas@kemnade.info>)
        id 1ol2vq-0044Jl-HI; Wed, 19 Oct 2022 08:52:02 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        j.neuschaefer@gmx.net
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH 2/2] ARM: dts: imx6sl-tolino-shine2hd: Add backlight boost
Date:   Wed, 19 Oct 2022 08:51:59 +0200
Message-Id: <20221019065159.969852-3-andreas@kemnade.info>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221019065159.969852-1-andreas@kemnade.info>
References: <20221019065159.969852-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.0 (-)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vendor system has a separate checkbox for increasing brightness of the
backlight combined with a big warning that power consumption will
greatly increase. With that checkbox enabled there is a greater range in
which backlight brightness can be adjusted
Add a switch to achieve the same, since the backlight is actually LED,
this seems to be the most appopiate place to add it. Nothing fits
perfectly.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 arch/arm/boot/dts/imx6sl-tolino-shine2hd.dts | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6sl-tolino-shine2hd.dts b/arch/arm/boot/dts/imx6sl-tolino-shine2hd.dts
index ea0ce59aa4f1..da1399057634 100644
--- a/arch/arm/boot/dts/imx6sl-tolino-shine2hd.dts
+++ b/arch/arm/boot/dts/imx6sl-tolino-shine2hd.dts
@@ -80,6 +80,12 @@ led-0 {
 			gpios = <&gpio5 13 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "timer";
 		};
+
+		led-1 {
+			label = "tolinoshine2hd:white:backlightboost";
+			gpios = <&gpio1 29 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "off";
+		};
 	};
 
 	memory@80000000 {
@@ -404,7 +410,8 @@ MX6SL_PAD_REF_CLK_32K__I2C3_SDA  0x4001f8b1
 
 	pinctrl_led: ledgrp {
 		fsl,pins = <
-			MX6SL_PAD_SD1_DAT2__GPIO5_IO13 0x17059
+			MX6SL_PAD_SD1_DAT2__GPIO5_IO13    0x17059
+			MX6SL_PAD_EPDC_SDCE2__GPIO1_IO29  0x17059
 		>;
 	};
 
-- 
2.30.2

