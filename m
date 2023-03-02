Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9D1A6A80A0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 12:01:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbjCBLBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 06:01:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjCBLBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 06:01:49 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C8C4609E;
        Thu,  2 Mar 2023 03:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1677754892; x=1709290892;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=EdwzYUqM4WHhd41os8sRNv7MYoebDrWBfOJm0mH2oAE=;
  b=06EvO0bcuw174hFjr23OWii770/qjp7u6tND+vErjSnXCc48hwEG5jIh
   C1hgKK0FT2KRIgCTnvGaK0DCaSStxIXmkASN6iDU935Pnb+oADtKEupfR
   PQrYPndpNY7eZRAM5DsMR4LHX+7X9/bLWV/2arrl/fhREtzoMUAUBQvkn
   eJg/J5VtDkiHJCmjIP5MrItKZJedJUF3Ees7JdUZvpgErO122DQqEru9Z
   LmjgMt43z9FENmkTARhRZX1ELuX7xiMcqL3qled9XoZNk5gFJt6PIVQ9c
   8vLQpyaAgnScKpVqIbgYRZDm6RowuAGK+yl8QFRdjeUV6GYNQ2BGoslE7
   g==;
X-IronPort-AV: E=Sophos;i="5.98,227,1673938800"; 
   d="scan'208";a="203271625"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Mar 2023 04:01:31 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 2 Mar 2023 04:01:30 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.16 via Frontend Transport; Thu, 2 Mar 2023 04:01:26 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <ludovic.desroches@microchip.com>, <linus.walleij@linaro.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 0/4] pinctrl: at91-pio4: few cleanups
Date:   Thu, 2 Mar 2023 13:01:12 +0200
Message-ID: <20230302110116.342486-1-claudiu.beznea@microchip.com>
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

Series contains few cleanups for pinctr-at91-pio4 driver.

Thank you,
Claudiu Beznea

Claudiu Beznea (4):
  pinctrl: at91-pio4: use devm_clk_get_enabled()
  pinctrl: at91-pio4: use device_get_match_data()
  pinctrl: at91-pio4: use dev_err_probe()
  pinctrl: at91-pio4: use proper format specifier for unsigned int

 drivers/pinctrl/pinctrl-at91-pio4.c | 42 +++++++++--------------------
 1 file changed, 13 insertions(+), 29 deletions(-)

-- 
2.34.1

