Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFF8862DAF9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 13:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240176AbiKQMeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 07:34:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240221AbiKQMdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 07:33:22 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00542725D5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 04:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1668688383; x=1700224383;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=g9OD6C532BG8057DaZIOwkCkEZBhs+LSbf4kM6dueg4=;
  b=xo8+H96LzJfU69c3pltsu1yCLNL9zU6pnd9XPhwuIiHIhXlRQI2KtM0k
   RABH5MDSsjoCex94LMaaP9VC+Uo5oK+uowuM5dNMIULlWrFw7oOY/JVc9
   6WwcwPKf045kd7J7gPXN8+RqP5Iud9owLxWbsVuX97BRIw1X5U802Ulmc
   0yLyPILQpduknm162z+u8ESEChNmwuwKdsTKuq8ek1tXk2MB6FgYt/OSO
   TgItuZHSDgV2mVTM2ympWRgsWyQ5iiTcrwyVlE4X/1u/h062AqMe9xd9J
   bcCZL2PVUxbyKx8MceFeGArM0lG6npQIY2Dncc4G+pUhFOhv3dJZQHfCi
   g==;
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="123885419"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Nov 2022 05:33:03 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 17 Nov 2022 05:33:02 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Thu, 17 Nov 2022 05:32:59 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>
CC:     <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 0/3] ASoC: mchp-spdiftx: add power saving features
Date:   Thu, 17 Nov 2022 14:37:47 +0200
Message-ID: <20221117123750.291911-1-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,T_SPF_TEMPERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series adds support for runtime PM and system suspend/resume
for Microchip SPDIFTX (patches 2/3, 3/3). Along with it I took the
chance and added a minor cleanup (patch 1/3).

Thank you,
Claudiu Beznea

Claudiu Beznea (3):
  ASoC: mchp-spdiftx: simplify locking around ctrl->ch_stat
  ASoC: mchp-spdiftx: add runtime pm support
  ASoC: mchp-spdiftx: add support for system suspend/resume

 sound/soc/atmel/mchp-spdiftx.c | 165 ++++++++++++++++++++++-----------
 1 file changed, 113 insertions(+), 52 deletions(-)

-- 
2.34.1

