Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E90AD74F6A4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 19:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231528AbjGKRNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 13:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231418AbjGKRNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 13:13:38 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 303F5E75;
        Tue, 11 Jul 2023 10:13:36 -0700 (PDT)
Received: from jupiter.universe (dyndsl-091-248-213-212.ewe-ip-backbone.de [91.248.213.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BB6D36606FD5;
        Tue, 11 Jul 2023 18:13:34 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1689095614;
        bh=zkoGz/x1Q/pDR1kqIW7+X33wiVyNSQbwTUWJIEyKbJk=;
        h=From:To:Cc:Subject:Date:From;
        b=XxW8O4kegDe7y7iFxSSWFaHGyFYv6U7oJxPJFJrPmmfer8VWjoZE5sspjYF/wjdJK
         WWC/rPljbhJWgTKjAnX8H7SHJqj1JyzuvOd4OV0Cn65dvbMGM/o2+2c3RUK8FPb9jb
         qVxleJuJoDkeyY03v/93tfpzDJQN4hodflopUGHvXP4YhM7fxmmV/UAfgmyC6mD54F
         EuvBLtG1ETOJB9TvpwWwivho7pBPaBKsW3qL3e/eyk6dEokdZbrCSK+GWeleaqmV5Z
         p2F46fuQdg+3Zqr425H0Sa9C7hF9AJJMOeeazorx51YXPMeM1ilblB2zhl9SgryvE6
         HZkIqbmK6uPuw==
Received: by jupiter.universe (Postfix, from userid 1000)
        id DFD18480592; Tue, 11 Jul 2023 19:13:32 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v1 1/1] arm64: dts: rockchip: rk3588-evb1: add SATA
Date:   Tue, 11 Jul 2023 19:13:30 +0200
Message-Id: <20230711171330.52535-1-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the SATA0_0 port found on the RK3588 EVB1. The
second port (SATA0_1) does not work, which matches the downstream
behaviour.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts b/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts
index f06b2ddcfcb6..eeab8f0478a5 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts
@@ -49,6 +49,10 @@ vcc5v0_sys: vcc5v0-sys-regulator {
 	};
 };
 
+&combphy0_ps {
+	status = "okay";
+};
+
 &cpu_b0 {
 	cpu-supply = <&vdd_cpu_big0_s0>;
 };
@@ -759,6 +763,10 @@ regulator-state-mem {
 	};
 };
 
+&sata0 {
+	status = "okay";
+};
+
 &uart2 {
 	pinctrl-0 = <&uart2m0_xfer>;
 	status = "okay";
-- 
2.40.1

