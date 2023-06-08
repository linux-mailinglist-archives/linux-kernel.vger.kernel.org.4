Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CDB7727A5C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 10:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235674AbjFHIr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 04:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235609AbjFHIri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 04:47:38 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 948212729
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 01:47:37 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5548A66058B2;
        Thu,  8 Jun 2023 09:47:35 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686214056;
        bh=/eSnfxogbScGlNOOjeGiLsCkqg34znU4OI0UheFc0FI=;
        h=From:To:Cc:Subject:Date:From;
        b=JZVCfEXagXlNeJVB5syTmC2EN4+t98xcDijANVzj/YBw8siGAZ1IY9sHCDYfqBQLQ
         onm1CV/QH2vC8VYFasLlfK9UUGYCkDLw7gTsKUNEVP2pa51/q4mTa+1Dajk7UvLU6+
         s2TSj6I6LbY8POa1PKywP57ol/mWO3T+YDtypzdjGhMg7ytJmWV5jQfW1yOWYK9ZSf
         ABp4ym3RTVWSzre1o8uNiQVxX6rJQ7ctE606ISvTSRvp2BAP+GrFoMmSE87o17qQgS
         zUnhtW2umIK1+2ZK7sZa/OEFeUnwcxwgx9414TPXOBoFwkcgXdTWPnQQmUAchmlwuM
         JyxuANLoP+Tlg==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        trevor.wu@mediatek.com, amergnat@baylibre.com,
        dan.carpenter@linaro.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com
Subject: [PATCH 0/5] ASoC: mt8188-mt6359: Cleanups
Date:   Thu,  8 Jun 2023 10:47:22 +0200
Message-Id: <20230608084727.74403-1-angelogioacchino.delregno@collabora.com>
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

This series performs some cleanups to the mt8188-mt6359 driver,
including usage of bitfield macros, adding definitions of register
fields and some others for readability and consistency.

AngeloGioacchino Del Regno (4):
  ASoC: mediatek: mt8188-mt6359: Compress of_device_id entries
  ASoC: mediatek: mt8188-mt6359: Cleanup return 0 disguised as return
    ret
  ASoC: mediatek: mt8188-mt6359: Clean up log levels
  ASoC: mediatek: mt8188-mt6359: Use bitfield macros for registers

Dan Carpenter (1):
  ASoC: mediatek: mt8188-mt6359: clean up a return in codec_init

 sound/soc/mediatek/mt8188/mt8188-mt6359.c | 87 ++++++++++++-----------
 1 file changed, 45 insertions(+), 42 deletions(-)

-- 
2.40.1

