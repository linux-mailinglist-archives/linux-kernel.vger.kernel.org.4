Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E61F61F840
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 17:05:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232582AbiKGQFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 11:05:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232540AbiKGQE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 11:04:58 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8278E1CB1E
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 08:04:57 -0800 (PST)
Received: from notapiano.myfiosgateway.com (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BF4CD66028B1;
        Mon,  7 Nov 2022 16:04:52 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667837095;
        bh=kyJUl4AIfO/bUHE12xVqYeJlBk+GtcwnhEWyl6Ffr50=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IOE585/bBs1Urpz+7wizZVDFh28yo+XQgY1LV95IGy7snk4vB2ayP4Kr9Qgip953p
         1x7+QGeKcKehO/RwmLvWCDGRyfXAhP4RWK0oNu19trya1DW8OXRZTfRn+10yEhd+d0
         ePdN1Zh74GiBYHnBcHACyueDl5acGdC7SgE4yMfc0k3kJgWmqfdfqbdpyXout9aWxu
         ZGJMjfGkvvoIZ7FNxcvQ9Q36MseW9Mo4pHfTrKeuQaL69darwdw/27znC0zRJBMvIc
         Pny7MhxqMz4oV3uBz7U+9VqdKgcrVxCbtTYEtwh+zXeH+JUHRogTzXCXkwcnIPOtF2
         mR5GPYij1YTgA==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>, Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 3/9] ASoC: mediatek: mt6797-mt6351: Register to module device table
Date:   Mon,  7 Nov 2022 11:04:31 -0500
Message-Id: <20221107160437.740353-4-nfraprado@collabora.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221107160437.740353-1-nfraprado@collabora.com>
References: <20221107160437.740353-1-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register the compatibles for this module on the module device table so
it can be automatically loaded when a matching device is found on the
system.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---

 sound/soc/mediatek/mt6797/mt6797-mt6351.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/mediatek/mt6797/mt6797-mt6351.c b/sound/soc/mediatek/mt6797/mt6797-mt6351.c
index d2f6213a6bfc..784c201b8fd4 100644
--- a/sound/soc/mediatek/mt6797/mt6797-mt6351.c
+++ b/sound/soc/mediatek/mt6797/mt6797-mt6351.c
@@ -242,6 +242,7 @@ static const struct of_device_id mt6797_mt6351_dt_match[] = {
 	{.compatible = "mediatek,mt6797-mt6351-sound",},
 	{}
 };
+MODULE_DEVICE_TABLE(of, mt6797_mt6351_dt_match);
 #endif
 
 static struct platform_driver mt6797_mt6351_driver = {
-- 
2.38.1

