Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF11664CD5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 20:54:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233257AbjAJTye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 14:54:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232999AbjAJTyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 14:54:04 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D25295BA32;
        Tue, 10 Jan 2023 11:53:59 -0800 (PST)
Received: from obbardc-t14.home (unknown [IPv6:2a00:23c7:6883:e501:329c:8425:8e97:eae9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: obbardc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 98A3F6602D8F;
        Tue, 10 Jan 2023 19:53:57 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1673380437;
        bh=NifcOS43y+N68BurrSuB+JMF2pV8C2qpP/aWsRXSUKk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N0fRjUzXMP3KKEK371KCiEY6xzuepwB3W220WKNzyE8Cl+fA2WBxL98pvTueApZV2
         2UwtBaIFvF+beMw7bgIChN0ZL9GIJkjovDsoRv+odSa80yhywUJCLqZlHRCQ9nLNU/
         bJBgfFgd0a1FNselkgwfbN5D6cUIF/RMdhcpWYypgqoO2Y68he8LfcBG4rtqO0uGDx
         q0Bq0woKucT6tSEny8LypHxCldBJvhtIt/b7y4u7sYrbuMTsNwas5FVFgqjOKlO+sK
         whLu5tV7MpD+SZooXqNWEq0X7wk0FyZ1HfW/ZoG9UQiR716POq0q1bdpUTtGzqGb9v
         /iU3fmYCFlHfQ==
From:   Christopher Obbard <chris.obbard@collabora.com>
To:     Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Christopher Obbard <chris.obbard@collabora.com>
Subject: [PATCH v2 2/3] arm64: dts: rockchip: Remove empty line from rock-5a
Date:   Tue, 10 Jan 2023 19:53:51 +0000
Message-Id: <20230110195352.272360-3-chris.obbard@collabora.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230110195352.272360-1-chris.obbard@collabora.com>
References: <20230110195352.272360-1-chris.obbard@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a line which is empty. Remove it.

Fixes: a4a8f1afb360 ("arm64: dts: rockchip: Add rock-5a board")
Signed-off-by: Christopher Obbard <chris.obbard@collabora.com>
---
 arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts b/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts
index c85af1334c05..6432b586bf5a 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts
@@ -52,7 +52,6 @@ rtl8211f {
 		rtl8211f_rst: rtl8211f-rst {
 			rockchip,pins = <3 RK_PB7 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
-
 	};
 };
 
-- 
2.39.0

