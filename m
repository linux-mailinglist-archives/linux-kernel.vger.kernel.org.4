Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5080C6D6A38
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 19:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235816AbjDDRRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 13:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235710AbjDDRQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 13:16:54 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7993610FA;
        Tue,  4 Apr 2023 10:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1680628612; x=1712164612;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Y/b1MRTx2c39EaWfOqjznrO4Us/4HnZFtVn5WYJHB70=;
  b=HNqSvIToo75+ARIY16fcx3Phkaf7Drg31MvDPS9CSWKEQ/6V4oCZRXzI
   Me0/yPQv3Eq9zEJaqKBc+TWTqe0fr03Nm8iMr9569G7UQkT8HO87Y23JR
   5JJqP3i3v8rLZ4t9CP+Z3hmWc1cLYlI8f7r4xIfoQb7/lFdz2N/b+/OPo
   n2GL1vd2R7tAtYDQD22eCzS+nRUTdLyqdYeuGRpTu+m2A7PLPBmv2Bz2k
   9dEen0UTaq0/ojxVrnJXXzmyavrW65glBUykfsh4g+nzGNEi0s8GfXMsO
   C0QGdGmIIcbPrQQI+qt3pwobeuzOVX4IRieFm2oxQOO4j3PoILSTwgfxB
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,318,1673938800"; 
   d="scan'208";a="145482256"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Apr 2023 10:16:51 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 4 Apr 2023 10:16:44 -0700
Received: from CHE-LT-UNGSOFTWARE.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Tue, 4 Apr 2023 10:16:43 -0700
From:   Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>
To:     <linux-spi@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <broonie@kernel.org>
Subject: [PATCH SPI for-next 0/3] spi: mchp-pci1xxxx: Fix minor bugs in spi-pci1xxxx driver
Date:   Tue, 4 Apr 2023 22:46:10 +0530
Message-ID: <20230404171613.1336093-1-tharunkumar.pasumarthi@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series fixes the following bugs in spi-pci1xxxx driver:
1. Length of SPI transactions is improper
2. SPI transactions fail after suspend and resume
3. Incorrect implementation of pci1xxxx_spi_set_cs API

Tharun Kumar P (3):
  spi: mchp-pci1xxxx: Fix length of SPI transactions not set properly in
    driver
  spi: mchp-pci1xxxx: Fix SPI transactions not working after suspend and
    resume
  spi: mchp-pci1xxxx: Fix improper implementation of disabling chip
    select lines

 drivers/spi/spi-pci1xxxx.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

-- 
2.25.1

