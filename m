Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 244DD61F83D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 17:04:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232494AbiKGQEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 11:04:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232453AbiKGQEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 11:04:49 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2CC020199
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 08:04:47 -0800 (PST)
Received: from notapiano.myfiosgateway.com (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4336466023A6;
        Mon,  7 Nov 2022 16:04:42 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667837086;
        bh=Oi0RHcTQN65JIvkiYPMhcF3SS42wYwO3Fdb2TrzpUD4=;
        h=From:To:Cc:Subject:Date:From;
        b=NTlGef0mw3ZejCKzC3iMLReUv53Q7SF3Y8bR0vKyLf6l78aB2ozL6gcg2jcXx+xF7
         bu7ERg7xqnCGL58kW8yRU27x01mEnV/abUs5ikXzw8u+f8F3JrsRu70g2cXJIkkQ7v
         sS71xRZrLSKin3gIsWEU5Amk8dgMA36qzp9PuuTMhDqGb+EwHBz95ZV8vpJdXc58MN
         gulSazNAdzLPMn4vSPmjV1N0L4WM0Flip8UGGh0w/K1WElgMIkPqmGYC2RNi5Rcte1
         vrPBqhAZMkCVnPw0GwoGYb5zHAnWo9XGfdcnmFssWktOghvII9o7vnD/8DXDLhBqfv
         LPag6tKbpaDyw==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>,
        Ajye Huang <ajye_huang@compal.corp-partner.google.com>,
        Akihiko Odaki <akihiko.odaki@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        Trevor Wu <trevor.wu@mediatek.com>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        alsa-devel@alsa-project.org, "chunxu.li" <chunxu.li@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 0/9] ASoC: mediatek: Register machine drivers to module device table
Date:   Mon,  7 Nov 2022 11:04:28 -0500
Message-Id: <20221107160437.740353-1-nfraprado@collabora.com>
X-Mailer: git-send-email 2.38.1
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


Some ASoC machine drivers for MediaTek platforms were not being
registered to the module device table, preventing them to be
automatically loaded when built as modules. This series adds the missing
registration to the drivers.


Nícolas F. R. A. Prado (9):
  ASoC: mediatek: mt2701-cs42448: Register to module device table
  ASoC: mediatek: mt2701-wm8960: Register to module device table
  ASoC: mediatek: mt6797-mt6351: Register to module device table
  ASoC: mediatek: mt8183-da7219: Register to module device table
  ASoC: mediatek: mt8183-mt6358: Register to module device table
  ASoC: mediatek: mt8186-da7219: Register to module device table
  ASoC: mediatek: mt8186-rt5682: Register to module device table
  ASoC: mediatek: mt8192-mt6359: Register to module device table
  ASoC: mediatek: mt8195-mt6359: Register to module device table

 sound/soc/mediatek/mt2701/mt2701-cs42448.c                 | 1 +
 sound/soc/mediatek/mt2701/mt2701-wm8960.c                  | 1 +
 sound/soc/mediatek/mt6797/mt6797-mt6351.c                  | 1 +
 sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c         | 1 +
 sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c | 1 +
 sound/soc/mediatek/mt8186/mt8186-mt6366-da7219-max98357.c  | 1 +
 sound/soc/mediatek/mt8186/mt8186-mt6366-rt1019-rt5682s.c   | 1 +
 sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c    | 1 +
 sound/soc/mediatek/mt8195/mt8195-mt6359.c                  | 1 +
 9 files changed, 9 insertions(+)

-- 
2.38.1

