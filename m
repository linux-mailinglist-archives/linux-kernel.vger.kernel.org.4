Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D821E722C60
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 18:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234845AbjFEQVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 12:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234656AbjFEQVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 12:21:31 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE58ED2;
        Mon,  5 Jun 2023 09:21:29 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1A5546606E75;
        Mon,  5 Jun 2023 17:21:25 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1685982088;
        bh=hpuSfUwRgpVJ50aSOdpyF/fGgsKVyjO2zFPFVOsBbR0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BgQDAyVS5lY/HAGajbGzPNci3f/nLj+mgvCtY43vmi5C9uwzdn2auEh89rl5U8v8q
         utcPbqNSWLqK+JOYWVOlqIjKlNv9bxM8NLsVsVvNpJz/VTXna3jpHGahFBkLC1Sg9T
         0SWxfgZUWDlpGgs2Io83WC1quPUMN5s8Zusxmf+SK9CCKViMAPhOKeihx878HP08KF
         2PvcDGUk0Dj9NN3jCfSxfvvg35DnM0Y9qQDtCOhYOlnQvw9Ghy2aC3U5cegPItOzk3
         PfkX5gjsNAdq7EZHBLQr2vPp6a/Ziqilm6GsOkrXXBWwuee9x+BGu6Jtx6L625t73i
         gjpT4MdgQ5fLg==
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
Subject: [PATCH 2/6] media: dt-bindings: mediatek,vcodec: Don't require assigned-clocks
Date:   Mon,  5 Jun 2023 12:20:26 -0400
Message-Id: <20230605162030.274395-3-nfraprado@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230605162030.274395-1-nfraprado@collabora.com>
References: <20230605162030.274395-1-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On MT8183 it's not necessary to configure the parent for the clocks.
Remove the assigned-clocks and assigned-clock-parents from the required
list.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---

 .../devicetree/bindings/media/mediatek,vcodec-decoder.yaml      | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/mediatek,vcodec-decoder.yaml b/Documentation/devicetree/bindings/media/mediatek,vcodec-decoder.yaml
index 57d5ca776df0..6447e6c86f29 100644
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
2.40.1

