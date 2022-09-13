Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 375235B6EC5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 16:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232382AbiIMOCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 10:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231653AbiIMOCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 10:02:08 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E1EE19295;
        Tue, 13 Sep 2022 07:02:08 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1274E6600371;
        Tue, 13 Sep 2022 15:02:05 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1663077726;
        bh=YMzqTfx36K6R8VoijWH17yCMGbQdDaXJE9npEtTCxNk=;
        h=From:To:Cc:Subject:Date:From;
        b=is8SAIoah/Lz9cHjty/dsUbPzT+VU1laMksOVCvzyKquI5AMxF8DdkDUzDBXCWcJe
         SgrtCqZrDfGTM9yyNT32jN6wd3GYuAcWKrfbXUijLiYtet91ZdgdduNt1GyPaiPTma
         LRasMK2JJz72pbna+/FxwCmJ/+PxiRfPs0VWyS1xdnvRL3EF1kLaZxKAZgIojayYlZ
         MxPHOIbbUHZ/ce89ItzJXezKawFBh6k+RxS0z7odKpvT6PtnN0kW/gIKLqOHh2HlNQ
         VCRu+PJRqLSEOxSNr0WRwiJFuiQuJOAvC92OOF4B/S7qcE21i6F5KU6LS8B3pPpmmc
         OSBbj56aZmyLQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     robh+dt@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, chunkuang.hu@kernel.org,
        jason-jh.lin@mediatek.com, rex-bc.chen@mediatek.com,
        moudy.ho@mediatek.com, allen-kh.cheng@mediatek.com,
        p.zabel@pengutronix.de, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 0/2] MediaTek Helio X10 MT6795 - Display Mutex
Date:   Tue, 13 Sep 2022 16:01:19 +0200
Message-Id: <20220913140121.403637-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.37.2
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

This series adds display mutex arrays and compatibles for the
MediaTek Helio X10 (MT6795).

Tested on Sony Xperia M5 smartphone.

AngeloGioacchino Del Regno (2):
  dt-bindings: soc: mediatek: Add display mutex support for MT6795
  soc: mediatek: mutex: Add support for MT6795 Helio X10 display mutex

 .../bindings/soc/mediatek/mediatek,mutex.yaml    |  1 +
 drivers/soc/mediatek/mtk-mutex.c                 | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)

-- 
2.37.2

