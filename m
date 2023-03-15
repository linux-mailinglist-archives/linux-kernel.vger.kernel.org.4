Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4F4D6BAF86
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 12:48:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbjCOLsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 07:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231706AbjCOLsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 07:48:25 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC3DF509A6;
        Wed, 15 Mar 2023 04:48:22 -0700 (PDT)
Received: from localhost (unknown [188.24.156.231])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2435D660305A;
        Wed, 15 Mar 2023 11:48:21 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678880901;
        bh=ZuudVlc08qJkqAcQq3C5hE5Igxbt5HAMhYKp817ykE8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QnqfcjIpg5gttJFa+xtfCRjgiVBae3/YzdOmBS16b1OuDD46PK8oVxkSaACkGJBkk
         klYXjhs5023D3QNkXny0M6lJuOwWsNPun8rClZlYAdehPDXHxPvdlylk+okNUiD4jt
         VonMl5KJLV4eHNeiAeDOyl8S2jbBFcBcLZ31s8LtByhkGkzSsG8+vcHHyHIgb0euJE
         Ca0t2/7YsZJ2dzSAUcIOy0EDddNaCpnfSI/7lrXovZOsMqsZEo7uE9B1UuAj/APL+Z
         zuvAQ+GUXLkWOWrRzq8l5cEpPfnYqRXer+uUnUTOD2uryVHe9qzwLoFn6SwidkBm2u
         NlxzqTnfY4y0w==
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
Subject: [PATCH 03/11] ASoC: dt-bindings: everest,es8316: Document audio graph port
Date:   Wed, 15 Mar 2023 13:47:58 +0200
Message-Id: <20230315114806.3819515-4-cristian.ciocaltea@collabora.com>
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

The ES8316 codec is currently used in conjunction with audio-graph-card
to provide an endpoint for binding with the other side of the audio
link.

This is achieved via the 'port' property, which is not allowed:

  rk3399-rockpro64.dtb: codec@11: Unevaluated properties are not allowed ('port' was unexpected)

Fix the issue by documenting the missing property.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 Documentation/devicetree/bindings/sound/everest,es8316.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/everest,es8316.yaml b/Documentation/devicetree/bindings/sound/everest,es8316.yaml
index d9f8f0c7f6bb..80cd81ecae6f 100644
--- a/Documentation/devicetree/bindings/sound/everest,es8316.yaml
+++ b/Documentation/devicetree/bindings/sound/everest,es8316.yaml
@@ -28,6 +28,10 @@ properties:
     items:
       - const: mclk
 
+  port:
+    $ref: audio-graph-port.yaml#
+    unevaluatedProperties: false
+
   "#sound-dai-cells":
     const: 0
 
-- 
2.39.1

