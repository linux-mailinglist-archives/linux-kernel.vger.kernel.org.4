Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58C4A70F2DD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 11:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjEXJe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 05:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjEXJeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 05:34:24 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D397AA1
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 02:34:22 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 608966602B7B;
        Wed, 24 May 2023 10:34:20 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1684920861;
        bh=a0EL23vvvIql72p1r/4NKLcSB4WiPqmju45rIVviM68=;
        h=From:To:Cc:Subject:Date:From;
        b=ZP5a327h5yCff5ZXdwT2PhCRIiWKVrLGL6pB/6yDmbhFk9LVZjUpotpTzwphtKI8I
         4Zef0ZrvJR3ggmSITFsYBPYGwV7gVTQ+LsfeIMP77I9JFMAgphxxmYD+puW04GCRno
         k3ybG/WKIdxUm8n/hG/xL1VoNw75mwN305REL6VLAKtiinVPe+KiUsFAJK1BumaMr/
         yhNLv/M2Sde4LXH/NC1EU3xpr52o5D7BKD2Xj+8L5mw/Wva/cO+RVBKripiJNjkQl+
         FPm7DoVy9yfrKSmoSeHqc99cuD4JJQ8n/wtaBPe5tRHgb3mkqv3GIF8RnE6hMMvWla
         ZxQsCu7VSlHWw==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     chunkuang.hu@kernel.org
Cc:     p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com
Subject: [PATCH v1 0/4] MediaTek DRM - DSI driver cleanups
Date:   Wed, 24 May 2023 11:34:08 +0200
Message-Id: <20230524093412.92211-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series performs some cleanups for mtk_dsi, enhancing human
readability, using kernel provided macros where possible and
also reducing code size.

Tested on MT8173 and MT8192 Chromebooks (using a DSI<->DP bridge)
and on MT6795 Sony Xperia M5 (DSI video mode panel).

Please note:
This series depends and can be applied only on top of [1].

[1]: https://lore.kernel.org/lkml/20230523104234.7849-1-angelogioacchino.delregno@collabora.com/

AngeloGioacchino Del Regno (4):
  drm/mediatek: dsi: Use GENMASK() for register mask definitions
  drm/mediatek: dsi: Cleanup functions mtk_dsi_ps_control{_vact}()
  drm/mediatek: dsi: Use bitfield macros where useful
  drm/mediatek: dsi: Replace open-coded instance of HZ_PER_MHZ

 drivers/gpu/drm/mediatek/mtk_dsi.c | 198 +++++++++++++----------------
 1 file changed, 88 insertions(+), 110 deletions(-)

-- 
2.40.1

