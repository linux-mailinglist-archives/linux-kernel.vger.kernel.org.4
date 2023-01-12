Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 534C4667153
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 12:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237000AbjALLxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 06:53:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231694AbjALLwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 06:52:41 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E0D4637C
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 03:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1673523751; x=1705059751;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XUcU5tUq9qLLqZtHqP40AGxdi2M6R+R7u4UfkFMYnyE=;
  b=xQFmHKjklxNgA1m8/Q/56Z/C7LsXxycKj3drLoQFy1FWftCP2Ev1WyPO
   Kxkjvbmpov11LdcqmwQdqTOGOk9Eya9YL4L/d78sA06BUjhBllLw4uTh3
   vl2Zw1E89f2xl0zXLQtT4l0CWtuYXuoeI+pwKNluG8zwE1Q7lGiSla67o
   PiVwfV6gA+a4QD3qNuYPcvSP6QIy7ITWoSkgSiL9W5Ui7MPSjRkhUFJi8
   o7qEQyGAvxua0fHZm3GUSTOXBmjHSmL0bBpp16iri/oXII/6tPx5YPSGq
   rareAngvg/4aclDbbirM1kVdpmIrgYvJMOPyMnXYGM0XpFWDmvQNZITHY
   A==;
X-IronPort-AV: E=Sophos;i="5.97,319,1669100400"; 
   d="scan'208";a="131994633"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Jan 2023 04:42:28 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 12 Jan 2023 04:42:27 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.16 via Frontend Transport; Thu, 12 Jan 2023 04:42:25 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <daniel.lezcano@linaro.org>, <tglx@linutronix.de>
CC:     <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 0/3] clocksource/drivers/timer-microchip-pit64b: add delay timer support
Date:   Thu, 12 Jan 2023 13:42:09 +0200
Message-ID: <20230112114212.1161136-1-claudiu.beznea@microchip.com>
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

This series adds delay timer support for Microchip PIT64B driver.

Thank you,
Claudiu Beznea

Claudiu Beznea (3):
  clocksource/drivers/timer-microchip-pit64b: move COMPILE_TEST on type
    definition
  clocksource/drivers/timer-microchip-pit64b: select driver only on ARM
  clocksource/drivers/timer-microchip-pit64b: add delay timer

 drivers/clocksource/Kconfig                  |  4 ++--
 drivers/clocksource/timer-microchip-pit64b.c | 12 ++++++++++++
 2 files changed, 14 insertions(+), 2 deletions(-)

-- 
2.34.1

