Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAC6370C004
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 15:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233629AbjEVNsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 09:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233665AbjEVNsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 09:48:13 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B932103;
        Mon, 22 May 2023 06:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1684763289; x=1716299289;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MI+SHbBzxOfh2VLB/C4yAm6Ar2ylsaQKIV0IU+oq5e4=;
  b=CaqQ2zCfCbUDnzQlZOmRVSgvbsc30TyY7W/Bfb4ILD0sd4ynfDfT7vcT
   URnkPGIdatpamD2++YdH14V6xeUn0cc1aQKfTH5WjEqjL67IoKNU6sNor
   aH2zCiNgUSoNtGJdYNZdMS9HEIOAiowIuSk0zlPMroIBsuHTJYmfLTUnM
   HYrukZ933akrpcFipUdE+6G3vzZPxZi3ljbHEK7qRoW29M/buB0N10+WU
   qlao+ptDOZz+2CzRbL0P1pp4WgisHQbDkaKclBiCyjxqPULkfanEWUx5R
   6qgxiIu2MacA9reVd8lFFB3R/o4PHfOt2D1DieDqpqE44ppdp0J++4QZX
   A==;
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="214338461"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 May 2023 06:48:09 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 22 May 2023 06:48:08 -0700
Received: from ROU-LT-M43238L.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Mon, 22 May 2023 06:48:07 -0700
From:   <nicolas.ferre@microchip.com>
To:     <linux-media@vger.kernel.org>, <hverkuil-cisco@xs4all.nl>,
        <mchehab@kernel.org>
CC:     <laurent.pinchart@ideasonboard.com>,
        <sakari.ailus@linux.intel.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Balamanikandan Gunasundar 
        <balamanikandan.gunasundar@microchip.com>,
        "Nicolas Ferre" <nicolas.ferre@microchip.com>
Subject: [PATCH] MAINTAINERS: Orphan the OV7740 driver
Date:   Mon, 22 May 2023 15:47:51 +0200
Message-ID: <20230522134751.30489-1-nicolas.ferre@microchip.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolas Ferre <nicolas.ferre@microchip.com>

Wenyou's email is bouncing, remove him from this camera driver's entry
and mark it as orphan.

Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
Wenyou, all,

If you want to take this driver, please don't hesitate to update this patch for
a better maintenance. My only concern is the @microchip.com email address
bouncing.

Best regards,
  Nicolas

 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e0ad886d3163..bae9c7591144 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15577,9 +15577,8 @@ F:	drivers/media/i2c/ov772x.c
 F:	include/media/i2c/ov772x.h
 
 OMNIVISION OV7740 SENSOR DRIVER
-M:	Wenyou Yang <wenyou.yang@microchip.com>
 L:	linux-media@vger.kernel.org
-S:	Maintained
+S:	Orphan
 T:	git git://linuxtv.org/media_tree.git
 F:	Documentation/devicetree/bindings/media/i2c/ov7740.txt
 F:	drivers/media/i2c/ov7740.c
-- 
2.34.1

