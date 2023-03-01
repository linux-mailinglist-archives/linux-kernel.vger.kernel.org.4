Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A49216A6BD3
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 12:39:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbjCALjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 06:39:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbjCALjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 06:39:16 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B99B28209
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 03:39:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1677670742; x=1709206742;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Y7gJN/0y8MxfRhsCcPrVR7dxAp760NI/rHw1ZXLbncM=;
  b=TSzINeI+c6RqK09Q469NVg7OEBY44+WgFpv/3cqRDe6EnZPDLLA6FpbB
   Is/bUqqEheQ+jRs8F0YEVGhs/K2NirB334OiOgwuSOjLIK9fnD5l3y14C
   o/ml383+0d9/5F81v9l7PTOTh1eFze2BJq4xSI10ZhNLGkrFv0I3NETAI
   x+aOmvWlUgr5aiOoKh3lmCKt6JdIvMvkaA0Z0eGAnhEggwZTdPuVoHJJs
   8c/WX70Lgn3yoLtV7UuX/mIwcpG+kLwVGWT49R3eoATRTPbaJnoqR09cQ
   nXKlzHwWfebIash05W757AutZHlenCDHbIqU8T3+TR5CcPxtpXrZ3J98r
   w==;
X-IronPort-AV: E=Sophos;i="5.98,224,1673938800"; 
   d="scan'208";a="214196885"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Mar 2023 04:39:01 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 1 Mar 2023 04:39:00 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.16 via Frontend Transport; Wed, 1 Mar 2023 04:38:56 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>
CC:     <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 8/8] MAINTAINERS: update Microchip AT91 sound entries with documentation files
Date:   Wed, 1 Mar 2023 13:38:07 +0200
Message-ID: <20230301113807.24036-9-claudiu.beznea@microchip.com>
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

Add documentation files to Microchip AT91 sound entries.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 252cc33f0f5c..b5a966f84d89 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13669,6 +13669,10 @@ MICROCHIP AUDIO ASOC DRIVERS
 M:	Claudiu Beznea <claudiu.beznea@microchip.com>
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
 S:	Supported
+F:	Documentation/devicetree/bindings/sound/atmel*
+F:	Documentation/devicetree/bindings/sound/axentia,tse850-pcm5142.txt
+F:	Documentation/devicetree/bindings/sound/microchip,sama7g5-*
+F:	Documentation/devicetree/bindings/sound/mikroe,mikroe-proto.txt
 F:	sound/soc/atmel
 
 MICROCHIP CSI2DC DRIVER
@@ -13836,6 +13840,7 @@ MICROCHIP SSC DRIVER
 M:	Claudiu Beznea <claudiu.beznea@microchip.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Supported
+F:	Documentation/devicetree/bindings/misc/atmel-ssc.txt
 F:	drivers/misc/atmel-ssc.c
 F:	include/linux/atmel-ssc.h
 
-- 
2.34.1

