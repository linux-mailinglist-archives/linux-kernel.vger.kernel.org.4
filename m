Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A16BD743E68
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 17:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232756AbjF3PPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 11:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232790AbjF3PO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 11:14:56 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFAE01FCB;
        Fri, 30 Jun 2023 08:14:55 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 14A546606E9D;
        Fri, 30 Jun 2023 16:14:50 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1688138094;
        bh=9a46aNnESj501/E03oYlm9sAjEXaazXllJOV13stIS8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mN2fz2HIBrCFzuVGExEGiFCckflxkFPgk47NSQBsW/fp5IjkFDaC8+RoE2UmxFMDR
         9kRn6U1onXpfrh0uOQJMQt9HmGj6fApXvbOxc5IjHZFFp9Ia4CTL4Yr2QAxAHbCDKB
         1ERtxVQ0TPEiodTdayckWUUyU5kiL+ZaA8QSkZB1R4zHTKyaV96dLHvS+Cx6v85kMM
         AkVxQlUA5vtU0KYYxrIne41Iku2OGDLIp0Y5XUqx0ahDeA2hUzvGKXfzWYa7H09SxN
         W5i47XkK/F/e8aqZ7F6l1mTcHMZb/Awpf+/U8KwGsgzJN4D+FcsLXdpXmgPbz7SBhO
         i7xyXoCQgKZbw==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v5 2/7] media: dt-bindings: mediatek,vcodec: Don't require assigned-clocks
Date:   Fri, 30 Jun 2023 11:14:08 -0400
Message-ID: <20230630151436.155586-3-nfraprado@collabora.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230630151436.155586-1-nfraprado@collabora.com>
References: <20230630151436.155586-1-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

On MT8183 it's not necessary to configure the parent for the clocks.
Remove the assigned-clocks and assigned-clock-parents from the required
list.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---

(no changes since v1)

 .../devicetree/bindings/media/mediatek,vcodec-decoder.yaml      | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/mediatek,vcodec-decoder.yaml b/Documentation/devicetree/bindings/media/mediatek,vcodec-decoder.yaml
index 1506d2693f7d..1e56ece44aee 100644
--- a/Documentation/devicetree/bindings/media/mediatek,vcodec-decoder.yaml
+++ b/Documentation/devicetree/bindings/media/mediatek,vcodec-decoder.yaml
@@ -67,8 +67,6 @@ required:
   - clocks
   - clock-names
   - iommus
-  - assigned-clocks
-  - assigned-clock-parents
 
 allOf:
   - if:
-- 
2.41.0

