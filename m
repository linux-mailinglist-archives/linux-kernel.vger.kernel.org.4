Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4F326F5338
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 10:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbjECIex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 04:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbjECIet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 04:34:49 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D8BA4C1D;
        Wed,  3 May 2023 01:34:48 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:8234:977e:ebbe:d70b])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2D1D96603137;
        Wed,  3 May 2023 09:34:46 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1683102886;
        bh=c/o6S4gK4umgsF4a3y+fftCuLrrfGz9SJS/paJ0m888=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MffejI9gVp1h2xoVcl3wwMP27jgvjHLDDVLTWs6Me3R51ZquhhWB7jq+weQpi8FJB
         CbX/8gcxguDun6+abC3CZKShdWxeqUnU8Nng6imk9MCMI6dXvSPS5p9E5Zs/jR+W04
         aBxyvhzChZWZoXEPFyf9JRe3tCwtdT504lV8E8khz9bpnkOYgNvgRhsXi1wjy/q0+P
         o03K0J3QPciVKXXxZDo8Mh2X9maLw7n/5u+T01bnXe9ZHYlZvxb9KM1Smt5sYzsevc
         p7Im9JdcUm71UFhJ3X3CYWBz/4T0ryN+3H4rHY0pBTd8pPdpqrLaNUAV/c+uJT2ufY
         OW4e7VrLfmBHA==
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
Subject: [PATCH v7 01/13] dt-bindings: media: rockchip-vpu: Add rk3588 vpu compatible
Date:   Wed,  3 May 2023 10:34:26 +0200
Message-Id: <20230503083438.85139-2-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230503083438.85139-1-benjamin.gaignard@collabora.com>
References: <20230503083438.85139-1-benjamin.gaignard@collabora.com>
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

Add compatible for rk3588 AV1 vpu decoder.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/media/rockchip-vpu.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/media/rockchip-vpu.yaml b/Documentation/devicetree/bindings/media/rockchip-vpu.yaml
index ee622a8ee1cc..772ec3283bc6 100644
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

