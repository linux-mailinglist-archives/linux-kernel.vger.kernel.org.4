Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3345E79B3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 13:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbiIWLgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 07:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231610AbiIWLgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 07:36:12 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D7D3207B;
        Fri, 23 Sep 2022 04:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1663932968; x=1695468968;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=A1t0eWZyyRcxoNYSibGgAxGV8DMRZ+q9ar+XSQ1FnLs=;
  b=2WATOtN+P85c5cioARZtCL2u+w8vb4x+LiZGlO/No/p7maP01UeQbgo6
   nfEf6Bi0jjjnxFtCJij5R+vcQN/Hu53+QAMCsbkfcHIp5ANQDPF3KVHJa
   hNFgOvWVtlTCbAkVI3AW2yzbQVNImGNZAHH9PR1Y/IYZGRUK2Dso2JLwk
   BeaBr89F+MDgucHvvT3X6IL/SpGlsGNO+KUP4kX6xQG7D4RG10H23cF39
   hvMG7cei/MSTRlCJoSY52warIhbcIZG8kVO6Na6kwe4JlobiIJCk11y+0
   bs8tsoFbOH0VH5yqMrWljrXbICqMmd8t3Xc8V4DOgezkA3OQrDNZyCclm
   A==;
X-IronPort-AV: E=Sophos;i="5.93,339,1654585200"; 
   d="scan'208";a="178580950"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Sep 2022 04:36:07 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 23 Sep 2022 04:36:07 -0700
Received: from ROB-ULT-M68701.amer.actel.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Fri, 23 Sep 2022 04:36:05 -0700
From:   Sergiu Moga <sergiu.moga@microchip.com>
To:     <gregkh@linuxfoundation.org>, <krzk@kernel.org>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Sergiu Moga <sergiu.moga@microchip.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] MAINTAINERS: Solve warning regarding inexistent atmel-usart binding
Date:   Fri, 23 Sep 2022 14:34:18 +0300
Message-ID: <20220923113415.90236-1-sergiu.moga@microchip.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After the conversion to json-schema, what was previously known as
`Documentation/devicetree/bindings/mfd/atmel-usart.txt`
has been moved to another bindings directory and renamed to
`Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml`.
Thus, make `MAINTAINERS` reflect this change.

Signed-off-by: Sergiu Moga <sergiu.moga@microchip.com>
Reported-by: kernel test robot <lkp@intel.com>
---
 MAINTAINERS | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d30f26e07cd3..7308dfba6f0e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13292,7 +13292,7 @@ F:	include/dt-bindings/dma/at91.h
 MICROCHIP AT91 SERIAL DRIVER
 M:	Richard Genoud <richard.genoud@gmail.com>
 S:	Maintained
-F:	Documentation/devicetree/bindings/mfd/atmel-usart.txt
+F:	Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml
 F:	drivers/tty/serial/atmel_serial.c
 F:	drivers/tty/serial/atmel_serial.h
 
@@ -13300,7 +13300,7 @@ MICROCHIP AT91 USART MFD DRIVER
 M:	Radu Pirea <radu_nicolae.pirea@upb.ro>
 L:	linux-kernel@vger.kernel.org
 S:	Supported
-F:	Documentation/devicetree/bindings/mfd/atmel-usart.txt
+F:	Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml
 F:	drivers/mfd/at91-usart.c
 F:	include/dt-bindings/mfd/at91-usart.h
 
@@ -13308,7 +13308,7 @@ MICROCHIP AT91 USART SPI DRIVER
 M:	Radu Pirea <radu_nicolae.pirea@upb.ro>
 L:	linux-spi@vger.kernel.org
 S:	Supported
-F:	Documentation/devicetree/bindings/mfd/atmel-usart.txt
+F:	Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml
 F:	drivers/spi/spi-at91-usart.c
 
 MICROCHIP AUDIO ASOC DRIVERS
-- 
2.34.1

