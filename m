Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E90E6A6BD4
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 12:39:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbjCALjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 06:39:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbjCALjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 06:39:16 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D712DE47
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 03:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1677670741; x=1709206741;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0sZyrt4VnnZxnHrao1ck3NRJLPAVFkEpYF9Axnjts2Y=;
  b=EqsY2h8TX4vOCj72O++hmfI8ZAGZL2JwpsjDC3EvqTU5SpRMMr1MwSLI
   Rtb6+VJwZ9y9wU2uZstbIvKLAIRqcptedDMJSrttrBALFPEHAB+jJQxHN
   ioc5DV9wU/VH+1kZoFwh3Or3to3AgYlPJdNylxnlpgKmjQbcGPBjicjZY
   1pbXYyH36/IFElaJuhMWNDwZJBab2wv45KGvARZmDB7JH+1yHONCf+YGR
   5fS7B5BQwxp9QSwqawmjPbul+qPY1/01YH63GtI2D2MzlUW6o/NwVJMZr
   jXa9jPMnFiPYbanxRv7ZtYVbNCD+sJTnDyMxNGKp8QB2ybX9UBWCRKBT7
   w==;
X-IronPort-AV: E=Sophos;i="5.98,224,1673938800"; 
   d="scan'208";a="199325323"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Mar 2023 04:39:01 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 1 Mar 2023 04:38:56 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.16 via Frontend Transport; Wed, 1 Mar 2023 04:38:50 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>
CC:     <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 7/8] MAINTAINERS: add myself as maintainer for Microchip AT91 sound drivers
Date:   Wed, 1 Mar 2023 13:38:06 +0200
Message-ID: <20230301113807.24036-8-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230301113807.24036-1-claudiu.beznea@microchip.com>
References: <20230301113807.24036-1-claudiu.beznea@microchip.com>
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

Codrin is not with Microchip anymore. As I worked lately with Microchip
AT91 sound drivers add myself as maintainer for these.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1e246c16aff6..252cc33f0f5c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13666,7 +13666,7 @@ F:	Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml
 F:	drivers/spi/spi-at91-usart.c
 
 MICROCHIP AUDIO ASOC DRIVERS
-M:	Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
+M:	Claudiu Beznea <claudiu.beznea@microchip.com>
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
 S:	Supported
 F:	sound/soc/atmel
@@ -13833,7 +13833,7 @@ S:	Supported
 F:	drivers/spi/spi-atmel.*
 
 MICROCHIP SSC DRIVER
-M:	Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
+M:	Claudiu Beznea <claudiu.beznea@microchip.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Supported
 F:	drivers/misc/atmel-ssc.c
-- 
2.34.1

