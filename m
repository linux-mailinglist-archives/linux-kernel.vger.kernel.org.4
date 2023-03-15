Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0AAD6BAF90
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 12:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231723AbjCOLt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 07:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbjCOLsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 07:48:31 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E04618B9;
        Wed, 15 Mar 2023 04:48:25 -0700 (PDT)
Received: from localhost (unknown [188.24.156.231])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E48736603096;
        Wed, 15 Mar 2023 11:48:23 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678880904;
        bh=YwZI6+CLTozcM4IgrIwS1wTY3wwS+KWhUpPNYpE/v00=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qropq4Q+2KIPDKb8oulyDdLLdKidkeIaxE6cEqGDobvYvZJSicrbKSejWC57Akq4y
         3+C3mUOFhLb/hZFq7zC9h9SwXbMmdqcsaPmDbwW9JLebFmfIuAfUSFYbQwQReRJIsB
         QdvFJ/y+TS6DpMqpCcY9QN/0Lg044+VLJJ7WoXieurU7FgmQrCoMzSihT2iajfCVot
         NZyozTqz3IZgUnlD7E4A/oC+5MctDSwbb61qrUD3EY/8nBtRRaSRX7unMhT+lXZQ9e
         z2ebjHd5Ps8s2HejE1/GHliq+XQ3IAhJeR79AAgou2IuqxasHfsl/6zMRMAo+b2YWg
         Df9+S2Tn/U4tA==
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Drake <drake@endlessm.com>,
        Katsuhiro Suzuki <katsuhiro@katsuster.net>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-rockchip@lists.infradead.org,
        linux-riscv@lists.infradead.org, kernel@collabora.com
Subject: [PATCH 04/11] ASoC: dt-bindings: rockchip: Document audio graph port
Date:   Wed, 15 Mar 2023 13:47:59 +0200
Message-Id: <20230315114806.3819515-5-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230315114806.3819515-1-cristian.ciocaltea@collabora.com>
References: <20230315114806.3819515-1-cristian.ciocaltea@collabora.com>
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

The Rockchip I2S controller is currently used in conjunction with
audio-graph-card to provide an endpoint for binding with the other side
of the audio link.

This is achieved via the 'port' property, which is not allowed:

  rk3399-rockpro64.dtb: i2s@ff890000: Unevaluated properties are not allowed ('port' was unexpected)

Fix the issue by documenting the missing property.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 Documentation/devicetree/bindings/sound/rockchip-i2s.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/rockchip-i2s.yaml b/Documentation/devicetree/bindings/sound/rockchip-i2s.yaml
index 1cb4da300607..c32b4750651c 100644
--- a/Documentation/devicetree/bindings/sound/rockchip-i2s.yaml
+++ b/Documentation/devicetree/bindings/sound/rockchip-i2s.yaml
@@ -82,6 +82,10 @@ properties:
   resets:
     maxItems: 2
 
+  port:
+    $ref: audio-graph-port.yaml#
+    unevaluatedProperties: false
+
   rockchip,capture-channels:
     $ref: /schemas/types.yaml#/definitions/uint32
     default: 2
-- 
2.39.1

