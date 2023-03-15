Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4769F6BAF95
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 12:49:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbjCOLta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 07:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231774AbjCOLtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 07:49:00 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA2F07B4A4;
        Wed, 15 Mar 2023 04:48:28 -0700 (PDT)
Received: from localhost (unknown [188.24.156.231])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 31F936603097;
        Wed, 15 Mar 2023 11:48:27 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678880907;
        bh=WmlYIXlwpuzhwVps27jROqCbyY1XeyxnNcY6/AOT2zA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M9RJ6PAceWIS/F096ZRjHDj6oq/zdzauVQqUYqZFKTB41xuqK+bIYLQCdzTH7R6vj
         EpRExyRFTXNKOIejNh0gMkOrd6TXyIGI3nrGofgMH4W6sdkyO7APNWQPnc5/cNsaA7
         G86qX2OLQOv2jgP/mjvNUOg1a87Dd/fJXDazjiZLpvt4Gt4l7WKY/eUrvHAykmFDGi
         fhUhlaqtnz7kT/OnyzLZvesOhgPIoG4l/T7TsCmX/oIRv/Qc5HTqPxkfAiXiTL0DOo
         zrPAIVTNOTAP3oaZPO1vDSO36JpG19cT+BlQg7MLvsWyAvAGDx/RfTBPXHSSyQHsYH
         WnhWObIAbXJsw==
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
Subject: [PATCH 05/11] ASoC: dt-bindings: rockchip: i2s-tdm: Document audio graph port
Date:   Wed, 15 Mar 2023 13:48:00 +0200
Message-Id: <20230315114806.3819515-6-cristian.ciocaltea@collabora.com>
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

Document the 'port' property to allow the Rockchip I2S TDM controller to
be used in conjunction with the audio-graph-card.

The property will be used to provide an endpoint for binding to the
other side of the audio link.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 Documentation/devicetree/bindings/sound/rockchip,i2s-tdm.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/rockchip,i2s-tdm.yaml b/Documentation/devicetree/bindings/sound/rockchip,i2s-tdm.yaml
index 4c95895de75e..7d2c2991c566 100644
--- a/Documentation/devicetree/bindings/sound/rockchip,i2s-tdm.yaml
+++ b/Documentation/devicetree/bindings/sound/rockchip,i2s-tdm.yaml
@@ -86,6 +86,10 @@ properties:
         - tx-m
         - rx-m
 
+  port:
+    $ref: audio-graph-port.yaml#
+    unevaluatedProperties: false
+
   rockchip,grf:
     $ref: /schemas/types.yaml#/definitions/phandle
     description:
-- 
2.39.1

