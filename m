Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3012D690D76
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 16:46:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbjBIPqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 10:46:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjBIPqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 10:46:37 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF783658C0;
        Thu,  9 Feb 2023 07:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1675957573; x=1707493573;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Sqb9CrQupozwaRxUfcLxkEjJR/QRyQ5olCidEY2nEW4=;
  b=aMefnL7A/Od3enlOTrbpKlXYt/knRh6jvZuX3EGw4cZE28F2RHnmhGVU
   DHjHNwbMI5ZYFwPGSl8YlDnChGH77oJUut6aBXCPs/phzwSb6R96nkNpW
   uEAoZOf0GzYnX+HARR+J6f8F0dzPBvkJ39vmTYtKdXIH6RCF87Jeo0Jvg
   0Dw4v9PnU8/hwGeFBwbFKB85BqFVh5MMEpBqKLD1p7oZLmKIVBpoZNexQ
   X6ivL+oevwsQTtTM189i97KdW3fGq7QGuPA9tsLgsN2RaiIOS8U7MjvB6
   KCJ2L3/ImIoy08drhP0L9SD+z6iU7nF/hvU82YpdvsvL20zKskLRj7xl7
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,284,1669100400"; 
   d="scan'208";a="211286105"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Feb 2023 08:45:36 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 9 Feb 2023 08:45:35 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.16 via Frontend Transport; Thu, 9 Feb 2023 08:45:35 -0700
From:   <Ryan.Wanner@microchip.com>
To:     <ludovic.desroches@microchip.com>, <linus.walleij@linaro.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <claudiu.beznea@microchip.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <manikandan.M@microchip.com>,
        Ryan Wanner <Ryan.Wanner@microchip.com>
Subject: [PATCH 0/2] pinctrl: Sama7g5 drive strength options updated
Date:   Thu, 9 Feb 2023 08:45:42 -0700
Message-ID: <20230209154544.535136-1-Ryan.Wanner@microchip.com>
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

Ryan Wanner (2):
  pinctrl: at91-pio4: Implement the correct drive values for sama7g5
  pinctrl: at91: adding new macros

 drivers/pinctrl/pinctrl-at91-pio4.c | 29 +++++++++++++++++++++++++++--
 include/dt-bindings/pinctrl/at91.h  |  8 +++++++-
 2 files changed, 34 insertions(+), 3 deletions(-)

-- 
2.37.2

