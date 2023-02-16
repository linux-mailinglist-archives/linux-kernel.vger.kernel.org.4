Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C71E5699FB2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 23:25:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbjBPWZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 17:25:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbjBPWZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 17:25:20 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D351BFA;
        Thu, 16 Feb 2023 14:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1676586317; x=1708122317;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Qsv6ExycvD7L4PXOWLwj6LQgpjYdHLvCMxWuIyD8krc=;
  b=Hu9DUrh6rwpmUZq8tNo6Yw7Jk4EQz7bfiRoe6LqmWEGebu7vdyUjbA68
   GNolsNDzgsd3gOtbEnijRPoADvhbw0vyE422/W9+YONNmppekHQ2mnqqb
   cRyaMpY+xHbIYnDYqE/aj7oHsHyJDLubGsNtHhhFI/7W9CsOW8DNdYJMv
   tZD5gfFNxqUj35jBWG4cI1naQCo2nKJuAI8YK3PyrGbuBpEL93DsoyCJr
   eJlXBu/KbJifOW+yFrg3jgtAQETmW8EB4uj9d768WU//KMxnJiHOT+aqy
   UEv0RA4HKVquDpW+pQ2zCNu9QMx0pjxwyccOthsAzej++aEVbY8HhKEYm
   g==;
X-IronPort-AV: E=Sophos;i="5.97,304,1669100400"; 
   d="scan'208";a="201366781"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Feb 2023 15:25:17 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 16 Feb 2023 15:25:16 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.16 via Frontend Transport; Thu, 16 Feb 2023 15:25:16 -0700
From:   <Ryan.Wanner@microchip.com>
To:     <linus.walleij@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <claudiu.beznea@microchip.com>,
        <ludovic.desroches@microchip.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Ryan Wanner <Ryan.Wanner@microchip.com>
Subject: [PATCH v2 0/2] pinctrl: Sama7g5 drive strength options updated
Date:   Thu, 16 Feb 2023 15:25:22 -0700
Message-ID: <20230216222524.3107759-1-Ryan.Wanner@microchip.com>
X-Mailer: git-send-email 2.37.2
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

From: Ryan Wanner <Ryan.Wanner@microchip.com>

This patch set updates drive strength options for the Sama7g5 to align
with drive strength options in the Sama7g5 data sheet.

changes since v1:
- Fix ABI break.
- Add explanation for drive strength macros.

Ryan Wanner (2):
  pinctrl: at91-pio4: Implement the correct drive values for sama7g5
  ARM: at91: dt: adding new macros

 drivers/pinctrl/pinctrl-at91-pio4.c | 27 ++++++++++++++++++++++++++-
 include/dt-bindings/pinctrl/at91.h  | 10 +++++++++-
 2 files changed, 35 insertions(+), 2 deletions(-)

-- 
2.37.2

