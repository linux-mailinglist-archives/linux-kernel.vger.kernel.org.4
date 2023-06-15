Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27B8F7318E2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 14:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343878AbjFOMWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 08:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343645AbjFOMWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 08:22:05 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D950C295B;
        Thu, 15 Jun 2023 05:21:07 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8E64D6606E79;
        Thu, 15 Jun 2023 13:21:05 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686831666;
        bh=hepMb3xZeHf1j0Zc3B2QLak0UgG9h2pQzK65p5H0pR0=;
        h=From:To:Cc:Subject:Date:From;
        b=ACVd/6d4RfdJ/bnMZb8fkhximmz/jIQSLNbwLo0XAaWPqldGW+Cvu4PxrbN0eviY5
         LIKpzqiJK2iFf1ygdJLf0fWF+1Hckp76ABJWTMLM04wLLJkgGKgr6TTvEcMICnRkyQ
         pH8VwURCioHKvO4wtQR51qTIKHYvRlVg1X8AsjS0qclt5u2ctgp4JHa03w7UqJRsTz
         js50Dyr2RNAQgLOnqJE8QlnS0t5jwH5eM87OM3X0aQWhxXYM3Vvjya23YdE9WYCuAP
         TCsMsh1xqa9nki1sjXWOKb33D8KhB64maB/zdPWFp3+wTxe+VUrAj4/BqKgYfsL4rt
         10OFce64mqb+g==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     sboyd@kernel.org
Cc:     mturquette@baylibre.com, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, wenst@chromium.org,
        u.kleine-koenig@pengutronix.de, msp@baylibre.com,
        miles.chen@mediatek.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com
Subject: [PATCH 0/3] MediaTek clocks: various fixes
Date:   Thu, 15 Jun 2023 14:20:48 +0200
Message-Id: <20230615122051.546985-1-angelogioacchino.delregno@collabora.com>
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

This series performs some fixing action for some issues on clk-mtk
and on mt8173 apmixedsys clock drivers, which have not made any
real appearance (no kernel panics, yet) because of corner cases
not being triggered on the current MediaTek clock drivers.

Still, it was totally necessary to fix those, ensuring that the
MediaTek clock helpers and drivers keep being solid.

AngeloGioacchino Del Regno (3):
  clk: mediatek: clk-mtk: Grab iomem pointer for divider clocks
  clk: mediatek: clk-mt8173-apmixedsys: Fix return value for of_iomap()
    error
  clk: mediatek: clk-mt8173-apmixedsys: Fix iomap not released issue

 drivers/clk/mediatek/clk-mt8173-apmixedsys.c | 7 +++++--
 drivers/clk/mediatek/clk-mtk.c               | 6 +++---
 2 files changed, 8 insertions(+), 5 deletions(-)

-- 
2.40.1

