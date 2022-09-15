Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 969FC5B9C5F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 15:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbiIONwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 09:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbiIONwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 09:52:31 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B999E98D31
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 06:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1663249948; x=1694785948;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qNTf/fEg8wubvKF39b6L46iyHFBcPA4/o2SKZONT/Lk=;
  b=HJv5/sHmX5ChOM3rgqca+kdnc4VVoiGqfO2f6G4gWUL1gIUhdFcKHj6C
   rAa/Yt+FYGxH7eCOYHT6lMBNycFBUWdACwDYFUpHu6/y+yl7EkJkVCu5/
   N9Jb9TKw4X32QlRF5sZ5lIliRyChFywCWrmqRQ9E+f53RLKf2PuEJznhW
   C1pd2dMnHaMysae83Or4zCLFHFFGPzyeF15tzEtTmFVw8wpeZAURjX2+/
   suRFAi++6JW0e6/mxsIOqOjukrn1lkCnDRTFF/ogyN/LO4QusgNGEI4sy
   Qgeox0aKGueZX60O276ev1sbn+QiGBmMAJEo6BojPKF5VXO02vql+2WoW
   A==;
X-IronPort-AV: E=Sophos;i="5.93,318,1654585200"; 
   d="scan'208";a="180531560"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Sep 2022 06:52:28 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 15 Sep 2022 06:52:26 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.12 via Frontend
 Transport; Thu, 15 Sep 2022 06:52:25 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     <conor.dooley@microchip.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        "Lukas Bulwahn" <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: update polarfire soc clock binding
Date:   Thu, 15 Sep 2022 14:51:49 +0100
Message-ID: <20220915135148.2968422-1-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.36.1
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

The clock binding has been renamed and a new binding added for the
clock controllers in the FPGA fabric. Generalise the pattern to
cover both.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
The maintainers addition of binding coverage landed as a 6.0 fix via
soc while the binding was renamed in patches pending for 6.1. I'll
send this via soc for 6.1
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c26a5c573a5d..170acda52f03 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17618,7 +17618,7 @@ M:	Conor Dooley <conor.dooley@microchip.com>
 M:	Daire McNamara <daire.mcnamara@microchip.com>
 L:	linux-riscv@lists.infradead.org
 S:	Supported
-F:	Documentation/devicetree/bindings/clock/microchip,mpfs.yaml
+F:	Documentation/devicetree/bindings/clock/microchip,mpfs*.yaml
 F:	Documentation/devicetree/bindings/gpio/microchip,mpfs-gpio.yaml
 F:	Documentation/devicetree/bindings/i2c/microchip,corei2c.yaml
 F:	Documentation/devicetree/bindings/mailbox/microchip,mpfs-mailbox.yaml
-- 
2.36.1

