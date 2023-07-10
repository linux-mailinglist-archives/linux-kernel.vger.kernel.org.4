Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E617874DBA0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 18:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbjGJQxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 12:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbjGJQwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 12:52:36 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4245E3;
        Mon, 10 Jul 2023 09:52:35 -0700 (PDT)
Received: from jupiter.universe (dyndsl-091-248-189-246.ewe-ip-backbone.de [91.248.189.246])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A8CCA6607013;
        Mon, 10 Jul 2023 17:52:32 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1689007953;
        bh=Tt7uUAjNgNzRuuG1D8AKfKaibOhh6srEjpIfBkMqmqY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T2rWDUoRmK60Z8jFi0D5hZ2iF9hLhNMlkn86LM8HLig14/WAMprxcy+jUhJnyJ1/j
         EvxSq0p659Lj9R8DJsdStkW3HTtnc08VRWbG+MaHJNS/UCUdoojwK4XO+PSxT8DQtd
         Yxmu9MlhBhV4nzThGuFaqqFMkDA/comV8OVV6p35PFPliUn+RrsIMbaGJg5Fab1Wb9
         SK0U12SeVbBnOSgKRkCcqkUn6naZmGC13PkFXxWAU9syPLrHaCrP4IivpZABIUnDOL
         bx8aMkmf77YRXGYFekJzSJwvVzy9BNZ4gCPCiWeU7grQOViZ6UVWd/g5qZXQIWgv58
         7jwlbaUxK/WEQ==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 28A114807F0; Mon, 10 Jul 2023 18:52:28 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v1 11/13] arm64: dts: rockchip: rock-5a: enable I2C interface from DSI and CSI connectors
Date:   Mon, 10 Jul 2023 18:52:26 +0200
Message-Id: <20230710165228.105983-12-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230710165228.105983-1-sebastian.reichel@collabora.com>
References: <20230710165228.105983-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I2C3 is routed to the Camera connector and I2C5 is routed to the LCD
connector. On I2C5 additionally there is an unpopulated footprint for
a HYM8563TS RTC.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts b/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts
index c4471dfe574f..01822dda0b2d 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts
@@ -190,6 +190,16 @@ eeprom: eeprom@50 {
 	};
 };
 
+&i2c3 {
+	status = "okay";
+};
+
+&i2c5 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c5m2_xfer>;
+};
+
 &i2c7 {
 	status = "okay";
 
-- 
2.40.1

