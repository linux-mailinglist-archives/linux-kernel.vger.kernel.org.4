Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8FE16B83F7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 22:29:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbjCMV3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 17:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjCMV3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 17:29:30 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B18F22A38
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 14:29:27 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 917866603082;
        Mon, 13 Mar 2023 21:29:21 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678742965;
        bh=/a+ZftsO/uQuk3g4rAVV0hz862INekzwBz589RiqAYU=;
        h=From:To:Cc:Subject:Date:From;
        b=Bg+ly/rqbIhNQsfLNi6+7kQy/GXCaMSVdZoLTpHYmcUVKpELzB7N+LYqFEYfEViJC
         xdGZurpZk6YoME0FuotfUusEUh50NQdjJWDClBVUSzURsqeMooPzuXR1teEX8WzKjm
         R8xG3ovFTDgdy0hiMzGQcZYfLdx7lrejSHKkOAeVX400w3/wbIQ4OGeKtK8x9JRMez
         Ak4vQHsX6CgCGBPzXhLhX+tstZl+88j+T4VXGIab1bcE4At/5WAgLAm3cXv14Rpqmw
         oU9c+hBQGSfIR47MV3b53xQihkBpLuN0RsiCvENQsEZvZBW50ssHYjRhqUbwL3I7R8
         0+oqQuM6h11Ew==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>, Akihiko Odaki <akihiko.odaki@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: [PATCH 0/2] ASoC: mt8192: Address spammy log messages
Date:   Mon, 13 Mar 2023 17:29:05 -0400
Message-Id: <20230313212908.2282961-1-nfraprado@collabora.com>
X-Mailer: git-send-email 2.39.2
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


A couple commits to make the mt8192 sound driver not spam the console.


Nícolas F. R. A. Prado (2):
  ASoC: mt8192: Remove function name log messages
  ASoC: mt8192: Move spammy messages to debug level

 sound/soc/mediatek/mt8192/mt8192-afe-clk.c    |  4 ---
 sound/soc/mediatek/mt8192/mt8192-afe-pcm.c    |  6 +---
 sound/soc/mediatek/mt8192/mt8192-dai-tdm.c    | 28 +++++++++----------
 .../mt8192/mt8192-mt6359-rt1015-rt5682.c      | 12 ++++----
 4 files changed, 19 insertions(+), 31 deletions(-)

-- 
2.39.2

