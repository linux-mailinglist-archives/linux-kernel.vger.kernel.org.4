Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84B7F5B9A83
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 14:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbiIOMK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 08:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbiIOMKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 08:10:01 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E738A3AB12;
        Thu, 15 Sep 2022 05:09:45 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 813EB6601DA4;
        Thu, 15 Sep 2022 13:09:27 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1663243768;
        bh=HWBn/M52pLNG9jF9V0WnYR9GDulkLMEO1gk39KXryO0=;
        h=From:To:Cc:Subject:Date:From;
        b=CGOQFirTY6hJdv+pca94IvXspPFLIWe8jJbMe6BrycEJwUI7vtF3U/R84Ux9Rk42F
         FdL1CKpZt/NbNNWIE1Vdk8qjZD7rQlJuZahFnCDIg9afB+hZ8mzXmpktj9UefE8gRm
         HWl1grFjaE/SRSE7G7YJ1hSCeOz5W6cSBg8YRJw/ye8SE7DM9Q7Pj7Z0TVysOaJcAC
         HYyeH2kujmfJg7jQjPcNFOWowMzH4DFUisTJS4MqghCqtKug6Wt5gkzVKDHuNbSERO
         32J8hQ3jCkPTR8VrcUj7qvlqp5YxOy7TELG54d7EXPqR3Zf5eGlu30+ENjlOyDe/a3
         MDp0kBu/7fcSw==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     chaotian.jing@mediatek.com
Cc:     ulf.hansson@linaro.org, matthias.bgg@gmail.com,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 0/2] MMC/SD support for MediaTek MT6795 Helio X10
Date:   Thu, 15 Sep 2022 14:09:21 +0200
Message-Id: <20220915120923.86038-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for the MMC/SD controller found on the
MediaTek Helio X10 (MT6795).
While at it, I've also made the compatibles and plat data ordering
consistent.

P.S.: There's no dt-bindings addition because that was already merged
      and it's present [1] in next-20220915

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=next-20220915&id=55e7dceee83ca6584a08bd876ed0ec38de5b13ce

Tested on a MT6795 Sony Xperia M5 smartphone

AngeloGioacchino Del Regno (2):
  mmc: mtk-sd: Reorder of_device_id and platform data by name
  mmc: mtk-sd: Add support for MT6795 Helio X10

 drivers/mmc/host/mtk-sd.c | 109 ++++++++++++++++++++++----------------
 1 file changed, 62 insertions(+), 47 deletions(-)

-- 
2.37.2

