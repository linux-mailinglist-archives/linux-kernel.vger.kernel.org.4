Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1519F664CD4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 20:54:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233058AbjAJTyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 14:54:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232977AbjAJTyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 14:54:03 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 277E712D06;
        Tue, 10 Jan 2023 11:53:59 -0800 (PST)
Received: from obbardc-t14.home (unknown [IPv6:2a00:23c7:6883:e501:329c:8425:8e97:eae9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: obbardc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D21096602D93;
        Tue, 10 Jan 2023 19:53:57 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1673380438;
        bh=DQ1lSSmLlKw1V2qE5V5/GrXF6T+Z9D5U9iRwAWX3sco=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PaxMQglptCncEgUmVaIoHY/w5I4emzip73uVg5J1MPZrLZfODx5o+wDyrhIy21VIq
         QyrZ70GRR9Q5vgsRbVgdYF2mlNRuu20K2M2mShwqizAZ6Xlq6Yzeps5sRTW4HuvKeS
         kOUhusrp3QVh+XbEIUhhO5tmxLKjALq0Md3Pj8ZNUK3cxFZr7H6jstBiIFtDTG+46x
         zwMlFOVuCJFALG5iQCFLTOlESvPvgYZEmpQdhKFqhCLJsfuGD7geBOOmNIREwI1sWi
         1WTFDv+9yNC+RN53e9mx+xY43tAocU6KkXsd6OU6TXstjz28VNggwI1b8U0ER7U8Fw
         4A6AdS5FgL9HA==
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
Subject: [PATCH v2 3/3] arm64: dts: rockchip: Update sdhci alias for rock-5b
Date:   Tue, 10 Jan 2023 19:53:52 +0000
Message-Id: <20230110195352.272360-4-chris.obbard@collabora.com>
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

In the previous version, the sdhci alias was set to mmc1: an artifact
leftover from the port from vendor kernel. Update the alias to mmc0 to
match the device's boot order.

Fixes: 6fb2d1549786 ("arm64: dts: rockchip: Add rock-5b board")
Signed-off-by: Christopher Obbard <chris.obbard@collabora.com>
---
 arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
index d2f1e963ce06..95805cb0adfa 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
@@ -9,7 +9,7 @@ / {
 	compatible = "radxa,rock-5b", "rockchip,rk3588";
 
 	aliases {
-		mmc1 = &sdhci;
+		mmc0 = &sdhci;
 		serial2 = &uart2;
 	};
 
-- 
2.39.0

