Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F32D574DB9D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 18:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbjGJQxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 12:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbjGJQwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 12:52:36 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C37812B;
        Mon, 10 Jul 2023 09:52:35 -0700 (PDT)
Received: from jupiter.universe (dyndsl-091-248-189-246.ewe-ip-backbone.de [91.248.189.246])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A3BB26607012;
        Mon, 10 Jul 2023 17:52:32 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1689007952;
        bh=uaW3HH5gaQAF27KPDqGks6sLcRizP/fPz2qLsQGc7Ag=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=El/Zs90obycRKg1fy0jYWamDvct6KGWlzWQXcBL1MSvVC/4k+P9Kh1i1KqfGC0hJj
         hOZ9oiS4waXnI7t21Zl0QMgZ7ynyM/m11vfwyZyns7YxEsxwMIunhcznA1Rq0hUVQn
         AEN+5LG5ERQBFJ/WNuBPnyJGBoQ+RKgYyBeuRhRCKYqDJxAlpuj4KV7AyA1RkCOWFn
         kDGuoNE3x0e/s6GO8Fhszf5CIUvjKeFVKjY7O9m6dsxwqGkMTBjYPkTPhrtLMrQCFx
         jQNsjKJJYjECl/2E4zRwu/2YQHhWNuBn0YwOiOIC7wIqiee9w6JPpkuPXV0UqMVOHt
         AaAJ3qOVcRYig==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 29FEC4807F1; Mon, 10 Jul 2023 18:52:28 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v1 12/13] arm64: dts: rockchip: rock-5a: add ADC
Date:   Mon, 10 Jul 2023 18:52:27 +0200
Message-Id: <20230710165228.105983-13-sebastian.reichel@collabora.com>
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

Enable ADC support for Rock 5A, which has the following ADC channels:

Channel 0 = Boot Mode Config
Channel 1 = Recovery Key
Channel 2 = PWM Fan
Channel 3 = Headphone Hook
Channel 4 = System Input Voltage
Channel 5 = Board ID Config

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts b/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts
index 01822dda0b2d..156c93b22382 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts
@@ -286,6 +286,11 @@ rtl8211f_rst: rtl8211f-rst {
 	};
 };
 
+&saradc {
+	vref-supply = <&avcc_1v8_s0>;
+	status = "okay";
+};
+
 &sdhci {
 	bus-width = <8>;
 	no-sdio;
-- 
2.40.1

