Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6820E725B86
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 12:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235605AbjFGKXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 06:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233837AbjFGKX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 06:23:29 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 205CF1BD6
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 03:23:27 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2001:b07:646b:e2:e4be:399f:af39:e0db])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: laura.nao)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 037006606EF5;
        Wed,  7 Jun 2023 11:23:24 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686133405;
        bh=H9QRea/52RC21Ar3lTIH+dm/2YukdZI3RX7iffiI+wQ=;
        h=From:To:Cc:Subject:Date:From;
        b=Ao4fa02gCcp1DGDY94o1y99+iPJ2GPtsYQL/IJdK+zPPbSauEIpVP0W6+TeQuRfYE
         54mhRdKCcs+2rrJ+zn3w4KWAPdLVts1Mnk3kG3qrDy8khYzU76Sp3wHfXv6Q70ISN4
         0gt23Y4bmJnCz5q8w0v/X+DCVDJ3ofIAp/ZIFb/JFACNZCPKrgfQ/NUSOrWCDqIYGn
         SfZlRKqXOeFe/hgRu/vvQ/dVQiOmM5RpkmSx8eekb2rH23j6PwJnRsDjBLcMG2HbOx
         yYXp9s5EkVFhk+pTSZRjb05VVmv8bNdWe+eOpX3C3a8VokTpAEzGfQiEk0xf0ckIhY
         2dItHWPl51VSg==
From:   Laura Nao <laura.nao@collabora.com>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, Laura Nao <laura.nao@collabora.com>
Subject: [PATCH] drm/panel-edp: Add AUO B116XAB01.4 edp panel entry
Date:   Wed,  7 Jun 2023 12:21:23 +0200
Message-Id: <20230607102123.219862-1-laura.nao@collabora.com>
X-Mailer: git-send-email 2.30.2
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

Add a panel entry for the AUO B116XAB01.4 edp panel, found in the Acer
Chromebook Spin 311 (CP311-3H) laptop.

Signed-off-by: Laura Nao <laura.nao@collabora.com>
---
 drivers/gpu/drm/panel/panel-edp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index fbd114b4f0be..5f6297531347 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -1867,6 +1867,7 @@ static const struct panel_delay delay_200_500_e200 = {
 static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x1062, &delay_200_500_e50, "B120XAN01.0"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x1e9b, &delay_200_500_e50, "B133UAN02.1"),
+	EDP_PANEL_ENTRY('A', 'U', 'O', 0x145c, &delay_200_500_e50, "B116XAB01.4"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x1ea5, &delay_200_500_e50, "B116XAK01.6"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x405c, &auo_b116xak01.delay, "B116XAK01"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x582d, &delay_200_500_e50, "B133UAN01.0"),
-- 
2.30.2

