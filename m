Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2F9566455E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 16:53:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238740AbjAJPxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 10:53:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238669AbjAJPxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 10:53:00 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46EDD3BE91;
        Tue, 10 Jan 2023 07:53:00 -0800 (PST)
Received: from obbardc-t14.home (unknown [IPv6:2a00:23c7:6883:e501:329c:8425:8e97:eae9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: obbardc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BC95C6602D81;
        Tue, 10 Jan 2023 15:52:58 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1673365978;
        bh=37/eGoyWURxAWAvYGjV9ek4VQtScHfjgbrz67unm7Cg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kRn2WxT00nphHOBV0lgXu6r09P4TGCYkoxo1gcIACuWrtH6gkfrK9YupJCcNe22cp
         sQuNA0XnAFSogJEsG1nxp7YxxiktWoiANHe1lmsczjpJQkPTTfrbUEAuk8EyPvGn7w
         eBKvjPWjbTc6FXtXHfnuf8LUFwMdf3o3RoH3JU8h6YCRyKAE761d8jIYNW/1wLdk66
         dNu9KkrEhwTkKdXNKzEgkS8xO3eys5pF5e/yY0S6hCotQwEnnm5eAc1Fih2Nj7KfXz
         mMxg9xFcDvZqibmfQsono5ap4/vz1Y6aT/92tOZAsxpMuG492ooZbW5UYDC6pbdAx9
         nKWCtWDdVPI+A==
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
Subject: [PATCH v1 1/3] arm64: dts: rockchip: Update sdhci alias for rock-5a
Date:   Tue, 10 Jan 2023 15:52:50 +0000
Message-Id: <20230110155252.189300-2-chris.obbard@collabora.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230110155252.189300-1-chris.obbard@collabora.com>
References: <20230110155252.189300-1-chris.obbard@collabora.com>
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

In the previous version, the sdhci alias was set
to mmc1: an artifact leftover from the port from
vendor kernel. Update the alias to mmc0 to match
the device's boot order.

Fixes: a4a8f1afb360 ("arm64: dts: rockchip: Add rock-5a board")
Signed-off-by: Christopher Obbard <chris.obbard@collabora.com>
---
 arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts b/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts
index 409a43d059d8..c85af1334c05 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts
@@ -11,7 +11,7 @@ / {
 	compatible = "radxa,rock-5a", "rockchip,rk3588s";
 
 	aliases {
-		mmc1 = &sdhci;
+		mmc0 = &sdhci;
 		serial2 = &uart2;
 	};
 
-- 
2.39.0

