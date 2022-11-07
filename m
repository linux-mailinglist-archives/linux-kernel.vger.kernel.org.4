Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FECC61F83E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 17:05:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232536AbiKGQE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 11:04:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231756AbiKGQEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 11:04:51 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C2C1115F
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 08:04:50 -0800 (PST)
Received: from notapiano.myfiosgateway.com (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 953D766028B0;
        Mon,  7 Nov 2022 16:04:46 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667837089;
        bh=BnJV/zpf8sAsYJ9izvBwPrAYIuUiDNkZee48XmMB8NY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XqtPPYQtxUeFGbsC/JrwA97aiXK6FhABz+jakbp/MvfSH31oowu7Fu7CYpyS6oJJ8
         BXRZHDdrHLZo8ZASnHGdWp7/FZaATbN3obPj5aZApeZF3fIdY+aMyWom3FzeYRWXtR
         8NL8+UWH8zlrIuVeMlxWl6L0J3iJMwXyzgKRazZrKyT0X5Xz4R6/T0zKchVB1LqJPi
         jesrSPkARouAVQiljoj9HUx6pIYclizHpyBF1GHLQAHey/rgJhRPBoLvKd3yF/24mZ
         5oamUclMiWAK8CxGjuft1cwu4P9C4shSdsKiRd+v75vTbEfQv8IRkoN/oGr3lePvkF
         KToYs9gPzqK4Q==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>, Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 1/9] ASoC: mediatek: mt2701-cs42448: Register to module device table
Date:   Mon,  7 Nov 2022 11:04:29 -0500
Message-Id: <20221107160437.740353-2-nfraprado@collabora.com>
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

 sound/soc/mediatek/mt2701/mt2701-cs42448.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/mediatek/mt2701/mt2701-cs42448.c b/sound/soc/mediatek/mt2701/mt2701-cs42448.c
index d9fd6eb786aa..08ef109744c7 100644
--- a/sound/soc/mediatek/mt2701/mt2701-cs42448.c
+++ b/sound/soc/mediatek/mt2701/mt2701-cs42448.c
@@ -418,6 +418,7 @@ static const struct of_device_id mt2701_cs42448_machine_dt_match[] = {
 	{.compatible = "mediatek,mt2701-cs42448-machine",},
 	{}
 };
+MODULE_DEVICE_TABLE(of, mt2701_cs42448_machine_dt_match);
 #endif
 
 static struct platform_driver mt2701_cs42448_machine = {
-- 
2.38.1

