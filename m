Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A13B474D36B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 12:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233511AbjGJK2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 06:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233429AbjGJK2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 06:28:16 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 528F8BD;
        Mon, 10 Jul 2023 03:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688984887; x=1720520887;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UcwkOydYrSjyDo6SStNIT6kPqq10Rd6pUpZ9iNE8Ekk=;
  b=K7OwgEiFNXTuAcAGjzQRfvnhAfEC/M1F7hxD8bXLJTnijOQCCQwtkvqz
   aCaDz9o+yKSgRRSHT9q/vsmUgbJ2Kqf7aTjF/MZgRl+IRO3jVEhma8Ma+
   Y+3HUft36I1LWk+asBkVK7ZOTtCjf6JBy2iwLlGps1vy/vnrTqUIF22Wu
   Jeuiz1oEkByL5ILkQ+fkSEU+CF8+F/q9Rdil8W3MV4oxqEMoT4IB739ta
   4/ZieGXPj6+8a2NcPAV/TPp5CY07oYG5WnZfuWSaLo3oBJ+CI/M22NKWx
   5pH+vQH9v4atu3Oh6WvF3nfdXugNBe1ooSSZpal6FesgUkYTefAxTLGCn
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="364345465"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="364345465"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 03:28:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="865297556"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="865297556"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 10 Jul 2023 03:27:55 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 4C598604; Mon, 10 Jul 2023 13:27:53 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Amit Kumar Mahapatra via Alsa-devel 
        <alsa-devel@alsa-project.org>, Kris Bahnsen <kris@embeddedTS.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org
Cc:     Radu Pirea <radu_nicolae.pirea@upb.ro>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Alain Volmat <alain.volmat@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Richard Cochran <richardcochran@gmail.com>
Subject: [PATCH v1 6/8] spi: Clean up headers
Date:   Mon, 10 Jul 2023 13:27:49 +0300
Message-Id: <20230710102751.83314-7-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230710102751.83314-1-andriy.shevchenko@linux.intel.com>
References: <20230710102751.83314-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a few things done:
- include only the headers we are direct user of
- when pointer is in use, provide a forward declaration
- add missing headers
- group generic headers and subsystem headers
- sort each group alphabetically

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/spi/spi.h | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index becad31aeea2..8e7fc0f21714 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -6,27 +6,41 @@
 #ifndef __LINUX_SPI_H
 #define __LINUX_SPI_H
 
-#include <linux/acpi.h>
 #include <linux/bits.h>
 #include <linux/completion.h>
+#include <linux/container_of.h>
 #include <linux/device.h>
-#include <linux/gpio/consumer.h>
+#include <linux/export.h>
 #include <linux/kthread.h>
+#include <linux/limits.h>
+#include <linux/list.h>
+#include <linux/minmax.h>
 #include <linux/mod_devicetable.h>
+#include <linux/mutex.h>
 #include <linux/scatterlist.h>
 #include <linux/slab.h>
+#include <linux/smp.h>
+#include <linux/spinlock_types.h>
+#include <linux/string.h>
+#include <linux/types.h>
 #include <linux/u64_stats_sync.h>
 
+#include <asm/byteorder.h>
+
 #include <uapi/linux/spi/spi.h>
 
+struct acpi_device;
 struct dma_chan;
-struct software_node;
+struct gpio_desc;
 struct ptp_system_timestamp;
+struct software_node;
+
 struct spi_controller;
-struct spi_transfer;
 struct spi_controller_mem_ops;
 struct spi_controller_mem_caps;
+struct spi_device_id;
 struct spi_message;
+struct spi_transfer;
 
 /*
  * INTERFACES between SPI master-side drivers and SPI slave protocol handlers,
-- 
2.40.0.1.gaa8946217a0b

