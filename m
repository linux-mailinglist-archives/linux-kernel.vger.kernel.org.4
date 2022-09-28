Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 785BE5ED392
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 05:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232618AbiI1Dni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 23:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbiI1Dnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 23:43:35 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D9F7D4AB8;
        Tue, 27 Sep 2022 20:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1664336612; x=1695872612;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/wW0radtxKENdxfN7sINSEiGvHtAEW4jbCxUgo9JoQ4=;
  b=B7kAqMwB/D2nHGEBxIxVWcDNB4PZO8kMvFRoacIWBMoRyb8mo04n2Xtd
   sfls1EXEGmqnXG/o41vZtyPYeAHf6Sd4Fx3oZC0qndiiP8xrsBSEixd2U
   m0zNvH5GuqABjPqgyxBbj58gZFb/U7FDAfwfj3qOl3GGWVsMUdpfgEzp6
   iDEOJfvBpjLsCxkzNN5vVOd9ooFeaO5cwMZ9PsIndneiH5nLNTD5ybjlY
   OK2zaBlckVSi3cGb9lhBI9jX7rSpVcrcdhmTak0XvAVYGGJOksivdX6hJ
   igLpXU7lMTRhFcvAD7iWsPs5qhkuf/OnXr/5NwEMBWkLRYHzxWJCEYVjH
   A==;
X-IronPort-AV: E=Sophos;i="5.93,351,1654585200"; 
   d="scan'208";a="182259697"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Sep 2022 20:43:32 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 27 Sep 2022 20:43:31 -0700
Received: from CHE-LT-UNGSOFTWARE.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Tue, 27 Sep 2022 20:43:29 -0700
From:   Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>
To:     <broonie@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <UNGLinuxDriver@microchip.com>
Subject: [PATCH RFC SPI for-next 0/2] spi: microchip: pci1xxxx: Load SPI  driver for SPI endpoint of PCI1XXXX switch
Date:   Wed, 28 Sep 2022 09:13:34 +0530
Message-ID: <20220928034336.2939265-1-tharunkumar.pasumarthi@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Microchip PCI1XXXX is an unmanaged PCIe3.1a switch for consumer, industrial, and
automotive applications. This switch has multiple downstream ports. One of the
switch's downstream ports is a multifunction endpoint; one of those functions
supports SPI functionality. This series of patches provides the SPI controller
driver for the SPI function of the multifunction PCIe endpoint of the switch.

Tharun Kumar P (2):
  spi: microchip: pci1xxxx: Add driver for SPI controller of PCI1XXXX
    PCIe switch
  spi: microchip: pci1xxxx: Add suspend and resume support for PCI1XXXX
    SPI driver

 drivers/spi/Kconfig        |   9 +
 drivers/spi/Makefile       |   1 +
 drivers/spi/spi-pci1xxxx.c | 453 +++++++++++++++++++++++++++++++++++++
 3 files changed, 463 insertions(+)
 create mode 100644 drivers/spi/spi-pci1xxxx.c

-- 
2.25.1

