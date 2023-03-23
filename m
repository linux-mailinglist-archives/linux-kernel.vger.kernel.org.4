Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10BFF6C62E0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 10:09:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjCWJJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 05:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbjCWJJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 05:09:17 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D6A11CBC4;
        Thu, 23 Mar 2023 02:08:31 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 528ED66030BA;
        Thu, 23 Mar 2023 09:08:29 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1679562510;
        bh=JcZeO7Hk3n9YL6Pyi7NcCAIvRNlewFD1uN9/JWGWjig=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pa1eBUYWyXpb6J00y4TJShK0pq0KPDk2f879FEVLsQS/INas4+9Ehex8ddiYIiGnc
         aNYvXWU++wlqJPqt2/7+doYWpek+TXZ7OXFhcA0wnmMKnxjK4HyPtO6mEOfwZv4ZM4
         OL7NfTXNN02l6vvqX4aMUIQMpid9TDYxhVIWh4MCweYQHlZqyYwRcs9TW7Gg/NmdCB
         brUy8qw8FRHcilSKhTzlEdsbJakep2aazUQw2SpinZ5N2mHG4U2zwCsxe5Don1RuBd
         CY1fwSKmFBbZyGCzFSpcgI3BU59qgnT1AxB8KVL5G9zY0v4dOaHDMYzkie8uXZCWGB
         xdZgMvvPGov6w==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     airlied@gmail.com
Cc:     daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wenst@chromium.org,
        steven.price@arm.com, alyssa.rosenzweig@collabora.com,
        robh@kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v1 RESEND 1/2] dt-bindings: gpu: mali-bifrost: Document nvmem for speedbin support
Date:   Thu, 23 Mar 2023 10:08:21 +0100
Message-Id: <20230323090822.61766-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230323090822.61766-1-angelogioacchino.delregno@collabora.com>
References: <20230323090822.61766-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some SoCs implementing ARM Mali GPUs may be subject to speed binning
and the usable bin is read from nvmem: document the addition of nvmem
and nvmem-cells for 'speed-bin'.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../devicetree/bindings/gpu/arm,mali-bifrost.yaml          | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
index 8a0083800810..1eecb014016c 100644
--- a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
@@ -104,6 +104,13 @@ properties:
 
   dma-coherent: true
 
+  nvmem-cell-names:
+    items:
+      - const: speed-bin
+
+  nvmem-cells:
+    maxItems: 1
+
 required:
   - compatible
   - reg
-- 
2.40.0

