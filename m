Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70D3B649F7D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 14:10:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbiLLNK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 08:10:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232125AbiLLNKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 08:10:22 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5105964C5;
        Mon, 12 Dec 2022 05:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1670850619; x=1702386619;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kcrzmGTR7C7wlxWvy8O11JGORcZwZVBintZtJZ2LbuE=;
  b=z3KAOqqLI+XCTKNNOcSkBjSd/Ay+mDfc1JaUpbeBa7x/I2OBhkdTUb/+
   NnRiyz7WBEqv6iPjcMhcTef/bjXDlCuzh73moxYcIetkBFwTrCY0KAQgZ
   TCw9R52cdOlhe3cGH0ZJYur8VaNPFSdcBDznRntt49siX2S3ROrSMeW4k
   RAcyBtAybSt/DL98/nboTDkQiBUzeO2NE+5eMawgIiPWTPJEKH8v4bnR7
   UXwJeTtK8pUXxhr7OC3EGJk+5jQ/zm1/1lPT9RDTniIdmd6iEkKTi5u3X
   hB9CItatF58eaFG1aHoUk2ggHmRTfoT8HAuLi8pXr9OtBUiTSRnJjpUYZ
   g==;
X-IronPort-AV: E=Sophos;i="5.96,238,1665471600"; 
   d="scan'208";a="187716852"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Dec 2022 06:10:19 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 12 Dec 2022 06:10:18 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.16 via Frontend Transport; Mon, 12 Dec 2022 06:10:15 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>
CC:     <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 1/4] ASoC: dt-bindings: microchip: use proper naming syntax
Date:   Mon, 12 Dec 2022 15:15:32 +0200
Message-ID: <20221212131535.76111-2-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20221212131535.76111-1-claudiu.beznea@microchip.com>
References: <20221212131535.76111-1-claudiu.beznea@microchip.com>
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

Use the following syntax for Microchip ASoC YAML files:
vendor,device.yaml

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 .../sound/{mchp,i2s-mcc.yaml => microchip,sama7g5-i2s-mcc.yaml}   | 0
 .../sound/{microchip,pdmc.yaml => microchip,sama7g5-pdmc.yaml}    | 0
 .../sound/{mchp,spdifrx.yaml => microchip,sama7g5-spdifrx.yaml}   | 0
 .../sound/{mchp,spdiftx.yaml => microchip,sama7g5-spdiftx.yaml}   | 0
 4 files changed, 0 insertions(+), 0 deletions(-)
 rename Documentation/devicetree/bindings/sound/{mchp,i2s-mcc.yaml => microchip,sama7g5-i2s-mcc.yaml} (100%)
 rename Documentation/devicetree/bindings/sound/{microchip,pdmc.yaml => microchip,sama7g5-pdmc.yaml} (100%)
 rename Documentation/devicetree/bindings/sound/{mchp,spdifrx.yaml => microchip,sama7g5-spdifrx.yaml} (100%)
 rename Documentation/devicetree/bindings/sound/{mchp,spdiftx.yaml => microchip,sama7g5-spdiftx.yaml} (100%)

diff --git a/Documentation/devicetree/bindings/sound/mchp,i2s-mcc.yaml b/Documentation/devicetree/bindings/sound/microchip,sama7g5-i2s-mcc.yaml
similarity index 100%
rename from Documentation/devicetree/bindings/sound/mchp,i2s-mcc.yaml
rename to Documentation/devicetree/bindings/sound/microchip,sama7g5-i2s-mcc.yaml
diff --git a/Documentation/devicetree/bindings/sound/microchip,pdmc.yaml b/Documentation/devicetree/bindings/sound/microchip,sama7g5-pdmc.yaml
similarity index 100%
rename from Documentation/devicetree/bindings/sound/microchip,pdmc.yaml
rename to Documentation/devicetree/bindings/sound/microchip,sama7g5-pdmc.yaml
diff --git a/Documentation/devicetree/bindings/sound/mchp,spdifrx.yaml b/Documentation/devicetree/bindings/sound/microchip,sama7g5-spdifrx.yaml
similarity index 100%
rename from Documentation/devicetree/bindings/sound/mchp,spdifrx.yaml
rename to Documentation/devicetree/bindings/sound/microchip,sama7g5-spdifrx.yaml
diff --git a/Documentation/devicetree/bindings/sound/mchp,spdiftx.yaml b/Documentation/devicetree/bindings/sound/microchip,sama7g5-spdiftx.yaml
similarity index 100%
rename from Documentation/devicetree/bindings/sound/mchp,spdiftx.yaml
rename to Documentation/devicetree/bindings/sound/microchip,sama7g5-spdiftx.yaml
-- 
2.34.1

