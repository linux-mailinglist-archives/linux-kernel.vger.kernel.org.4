Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5A217263AD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 17:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240540AbjFGPG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 11:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235568AbjFGPG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 11:06:56 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B0910CE
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 08:06:54 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2001:b07:646b:e2:e4be:399f:af39:e0db])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: laura.nao)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B2D096606F02;
        Wed,  7 Jun 2023 16:06:52 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686150413;
        bh=y+PbL+Fg/8DzH+orsPMxQq0SAzHS4gXdy7ZEMk+P5Dg=;
        h=From:To:Cc:Subject:Date:From;
        b=kIN66jByGdnm2ZFVf3wYpNEWvvZaMhUV0DvodJcaFyyL4BcflSYUFviUo0l1U8qFY
         KMTe3cByCbI83ur6igB0/GYKoHjKR8IKkzxl/OJ1lowUIZTgNiSmR8C+QFDdCzSoEa
         BvIf+LLlKbQSGhoIWcJTMI4EU94szUW2r/YUZZ3if7AwDOWpliiOl1oddCVb3+R2Qt
         FW47BAqknSNbM+ILAecSi5Qir32/NZvzE3b4RXY3ZEJVFFwCcvNNAlZ3mLT6uFVsDt
         cTCfqPdNjp9+/IoY7ruDtFzz3bRq0GcMaQ+WR0kAS5A2X6oH5Fghjb3Q0R/k7HCNst
         rpr0mRIkee+Ag==
From:   Laura Nao <laura.nao@collabora.com>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, Laura Nao <laura.nao@collabora.com>
Subject: [PATCH v2] drm/panel-edp: Add AUO B116XAB01.4 edp panel entry
Date:   Wed,  7 Jun 2023 17:06:15 +0200
Message-Id: <20230607150615.241542-1-laura.nao@collabora.com>
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

Changes in v2:
- Sorted by product ID

 drivers/gpu/drm/panel/panel-edp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index fbd114b4f0be..df7e3cff004c 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -1866,6 +1866,7 @@ static const struct panel_delay delay_200_500_e200 = {
  */
 static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x1062, &delay_200_500_e50, "B120XAN01.0"),
+	EDP_PANEL_ENTRY('A', 'U', 'O', 0x145c, &delay_200_500_e50, "B116XAB01.4"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x1e9b, &delay_200_500_e50, "B133UAN02.1"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x1ea5, &delay_200_500_e50, "B116XAK01.6"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x405c, &auo_b116xak01.delay, "B116XAK01"),
-- 
2.30.2

