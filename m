Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1466DF46E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 13:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbjDLL5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 07:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbjDLL5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 07:57:07 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC3FBEA;
        Wed, 12 Apr 2023 04:57:05 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:c2e:89bd:4b8e:9e98])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id F07826603206;
        Wed, 12 Apr 2023 12:57:03 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681300624;
        bh=bhnO24On4r3VyKtUOKpWBYh2OEyQQ5x6bFUZv59MOAw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TXjlbNLH1htw+z7aPVYqS0elZD+yc8ouq4DcG/NobZMKuz5y/ApoVdFrPg5mLuVrP
         tOsmr6cPRaJBUpGySRzgCex/avNT8gOhBnfphWPRXrfMzOr88J2j5DOJ86s2YL/NtQ
         c7od9tap9Gs4bgTQwNV3sbbgNu52iAc2ALiD5ed6MnBgaLILe/5BgBApvLTeF8dYwV
         9KWWzKWwn6TFMg0K2aNYN2K5eCx8plmLm3hZhvAECEmoUzJWlMQPVOTZvwSwMPz/oN
         MRLsFq6xp3PC2II37V2qktberyo+KkksYkUGPtZUjJESsuta3ePIzfjZRAKmW3yIh+
         VlknfVzrUiU2g==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        hverkuil-cisco@xs4all.nl, nicolas.dufresne@collabora.com
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v6 01/13] dt-bindings: media: rockchip-vpu: Add rk3588 vpu compatible
Date:   Wed, 12 Apr 2023 13:56:40 +0200
Message-Id: <20230412115652.403949-2-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230412115652.403949-1-benjamin.gaignard@collabora.com>
References: <20230412115652.403949-1-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible for rk3588 AV1 vpu decoder.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/media/rockchip-vpu.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/media/rockchip-vpu.yaml b/Documentation/devicetree/bindings/media/rockchip-vpu.yaml
index 6cc4d3e5a61d..8454df53f5cb 100644
--- a/Documentation/devicetree/bindings/media/rockchip-vpu.yaml
+++ b/Documentation/devicetree/bindings/media/rockchip-vpu.yaml
@@ -24,6 +24,7 @@ properties:
           - rockchip,rk3399-vpu
           - rockchip,px30-vpu
           - rockchip,rk3568-vpu
+          - rockchip,rk3588-av1-vpu
       - items:
           - const: rockchip,rk3188-vpu
           - const: rockchip,rk3066-vpu
-- 
2.34.1

