Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE4A370D487
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 09:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235193AbjEWHHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 03:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235269AbjEWHHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 03:07:40 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 039991B1;
        Tue, 23 May 2023 00:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1684825630; x=1716361630;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=P5aD8T4OPWO3H/B7LgZ9I5LK6FmSItXjie0o4e9PMFA=;
  b=RxQKP6sqm+eabWOsCWZ8OtritO9oSig+UKwPs01D1HrR2ZwZ0nciRb1t
   Fu/08pJjYDOJULi4i3wooPfoAFSwvPX1yjxRbB9MTeFQ5VlnQLxCefT1g
   PlYRWhZ8PsqjM66HmMlbHMDEpAx+QVMlqQZTAl9Sw0LBxF4VaMgNt98AY
   tLGQDniKJ4gp77NP+eIF75UCg0ehUmF2ZC7hWLwpgqy3vnhsVD/cGI6ww
   at4zsbJ3PVF4cT8qRvK1j5XZHZAHz9OKUNaeZlf9+/f4JvhiKwCod3wP7
   YPtjoPNR7wHiab3/bwVbaP6F2GpZhHD3k6KrOpWBVZVW0WNbSqG2tqt4s
   A==;
X-IronPort-AV: E=Sophos;i="6.00,185,1681196400"; 
   d="scan'208";a="153442760"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 May 2023 00:07:09 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 23 May 2023 00:07:08 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Tue, 23 May 2023 00:07:05 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <tglx@linutronix.de>, <maz@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 0/2] dt-bindings: interrupt-controller: microchip,sama7g5-eic: use right naming syntax
Date:   Tue, 23 May 2023 10:06:35 +0300
Message-ID: <20230523070637.224476-1-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Series updates the documentation file for Microchip SAMA7G5 EIC to use
proper naming syntax. It also updates MAINTAINERS EIC section with
documentation file.

Thank you,
Claudiu Beznea

Claudiu Beznea (2):
  dt-bindings: interrupt-controller: microchip,sama7g5-eic: use proper
    naming syntax
  MAINTAINERS: add documentation file for Microchip EIC section

 .../{microchip,eic.yaml => microchip,sama7g5-eic.yaml}          | 2 +-
 MAINTAINERS                                                     | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)
 rename Documentation/devicetree/bindings/interrupt-controller/{microchip,eic.yaml => microchip,sama7g5-eic.yaml} (98%)

-- 
2.34.1

