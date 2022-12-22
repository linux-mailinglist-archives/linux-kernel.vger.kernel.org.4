Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE7F65474A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 21:37:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235580AbiLVUhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 15:37:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235107AbiLVUhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 15:37:00 -0500
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 433EC23BFA;
        Thu, 22 Dec 2022 12:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=gci7HmEu/UU5CFeAVTpWpem7dZdHS+jmF3GnpB+xyIQ=; b=T8H+j+Q9bLsoq8BEgStKsPpInj
        LPHTOR0+rEkCggeh3ChVWVLxsD0iu0SGKkQ94RqLEol01QxjPf4jobVush2ZCNcd1mZf+p3ryu3Nq
        d+5A8KvKbartIL/xbORNbVV5jSob/Sk1SHohCRSVj67lSuKkg5lOAA+XerNQuuZUN9t4=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:48920 helo=pettiford.lan)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1p8SJ8-000070-Sw; Thu, 22 Dec 2022 15:36:51 -0500
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     hvilleneuve@dimonoff.com, jic23@kernel.org, lars@metafoo.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, hugo@hugovil.com
Date:   Thu, 22 Dec 2022 15:36:08 -0500
Message-Id: <20221222203610.2571287-2-hugo@hugovil.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221222203610.2571287-1-hugo@hugovil.com>
References: <20221222203610.2571287-1-hugo@hugovil.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH v1 1/3] iio: adc: Kconfig: add SPI interface mention to AD7924 description
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

The Analog Devices AD7924 uses an SPI interface. There is also a Texas
Instruments ADS7924 which uses an I2C interface.

Adding the SPI mention to the AD7924 will help to avoid confusion
between the two chips.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/iio/adc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 46c4fc2fc534..235319546974 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -243,7 +243,7 @@ config AD7923
 	select IIO_TRIGGERED_BUFFER
 	help
 	  Say yes here to build support for Analog Devices
-	  AD7904, AD7914, AD7923, AD7924 4 Channel ADCs.
+	  AD7904, AD7914, AD7923, AD7924 4 Channel SPI ADCs.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called ad7923.
-- 
2.30.2

