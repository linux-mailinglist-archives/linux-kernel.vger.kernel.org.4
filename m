Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB1F6A6BCC
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 12:38:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjCALie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 06:38:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjCALib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 06:38:31 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E00C92385C
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 03:38:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1677670707; x=1709206707;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AUr2Emb+cEOVy4hejcovcA9VOZoGsG9uyJUZz74KyAA=;
  b=joZ5vgcPkfK7semUUFvpK7LjdOkIi+d7+y4LJ3t5iU3S6itzq1Ukl00N
   8uGF+lM8Uag8JBv53ymuuxh7ULkJisI/u9RwO3QnNUvqvWUCm2esrnXAv
   vuXTCPiu+gtjrZfwmfT8sz9uDi/27oTQiKkLVPzCyaXuSj1VTfYNDZoF5
   hSJQpoiBuDcOyFAUxTrB9fHPmntAqs8AUZgNDYkAWRcDot3jsCbMqyxdF
   iGCeukrXUgLjQ3GXRapJOcLlTPvoiyosb+IwiqO9b3/lPL3xvDlhlCQT8
   X/LgnLBVGhtL+qxAjcRcW8hV3DPa+rXE8V0U9fMdlJSzy8vIYVzmUqzk+
   g==;
X-IronPort-AV: E=Sophos;i="5.98,224,1673938800"; 
   d="scan'208";a="202746402"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Mar 2023 04:38:26 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 1 Mar 2023 04:38:26 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.16 via Frontend Transport; Wed, 1 Mar 2023 04:38:23 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>
CC:     <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 0/8] ASoC: microchip: some cleanups for AT91 sound drivers
Date:   Wed, 1 Mar 2023 13:37:59 +0200
Message-ID: <20230301113807.24036-1-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following patches do some cleanups for Microchip AT91 sound drivers.
Along with it I took the chance and updated MAINTAINERS file.

Thank you,
Claudiu Beznea

Claudiu Beznea (8):
  ASoC: mchp-spdiftx: use FIELD_PREP() where possible
  ASoC: mchp-spdiftx: use regmap_update_bits()
  ASoC: mchp-spdiftx: update debug message
  ASoC: mchp-pdmc: use FIELD_PREP() where possible
  ASoC: mchp-pdmc: return directly ret
  ASoC: mchp-pdmc: avoid casting to/from void pointer
  MAINTAINERS: add myself as maintainer for Microchip AT91 sound drivers
  MAINTAINERS: update Microchip AT91 sound entries with documentation
    files

 MAINTAINERS                    |  9 +++++--
 sound/soc/atmel/mchp-pdmc.c    | 19 ++++++--------
 sound/soc/atmel/mchp-spdiftx.c | 45 ++++++++++++----------------------
 3 files changed, 29 insertions(+), 44 deletions(-)

-- 
2.34.1

