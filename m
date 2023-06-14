Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92B9E726F5C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 22:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235647AbjFGU5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 16:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235606AbjFGU5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 16:57:38 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C7111FE6;
        Wed,  7 Jun 2023 13:57:33 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DD4C76606F00;
        Wed,  7 Jun 2023 21:57:29 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686171452;
        bh=OSgUrJ7XnUuJOY6k3BmTBADMqdJYSB09ILd9ph+D5lE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZoCpR01I/0R63kwknASWo9HkeihEglI6ha5K2F0IfG4lDIRNVq8s1J0muHQkLfqMM
         nhJDPKpRq5vZ3/OFa+XMblXobraKAVNKWQz0CJasqSM4hCWmSBMgg/+PwBlDmv05UH
         +1OlaiEk0mR0MEATFRH+K+YlAFDG1o+INV35/3ho0vrZ+VvNy2aMcDzreDCfpFNrPX
         vmG855GkbUB2AwxnMHiS+AYtddOmrM242yQ2yodpfKbY//pb5mfm1JYHEZzrA0tT2L
         EZDg36wzc3Q5sveBDJq5ql5YSVxQDNq7pxolxOWQ5WJfXazmyYLyviNi5aQTj0GHdu
         Zhm3d4lIQYNCg==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
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
Subject: [PATCH v2 1/5] media: dt-bindings: mediatek,vcodec: Don't require assigned-clocks
Date:   Wed,  7 Jun 2023 16:53:38 -0400
Message-ID: <20230607205714.510012-2-nfraprado@collabora.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607205714.510012-1-nfraprado@collabora.com>
References: <20230607205714.510012-1-nfraprado@collabora.com>
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
index fad59b486d5d..63be42560948 100644
--- a/Documentation/devicetree/bindings/media/mediatek,vcodec-decoder.yaml
+++ b/Documentation/devicetree/bindings/media/mediatek,vcodec-decoder.yaml
@@ -73,8 +73,6 @@ required:
   - clocks
   - clock-names
   - iommus
-  - assigned-clocks
-  - assigned-clock-parents
 
 allOf:
   - if:
-- 
2.41.0

