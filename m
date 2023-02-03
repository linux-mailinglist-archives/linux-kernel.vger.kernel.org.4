Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0D06689973
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 14:06:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232524AbjBCNGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 08:06:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbjBCNGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 08:06:16 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82CBD17164
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 05:06:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1675429573; x=1706965573;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=EunfF7HOZNf6ubu/HgxysSlMmeNkh1MUxwjA402fAeU=;
  b=R+rwjOYBdOodsZAxzhsvuwqx8w8/zmAI2I1zNjfky+51jhGGL+CTwfWb
   doP1+vjKWoFnYJ3Gs7TUY91GKbPN83YZDiKVu8a+CJRhjqg/T6AnhWKZk
   hiMWv4k3CgIhwT8p4X/28dtNS49L1UPGZgF4EGrElq4UYHZs0ao49hdZl
   rMMh/0c4GNZ8hdsYAf5vS3/Bglrd/+Z3ZA22/+SmpGmZ4sehK25nEiAoO
   2rdq7z6CPoLwW+vXPDBH++kNTcsdg1MlkWpw67Wtk/N0ZNORjm2RMSQ4r
   hGZtf11zeTbzbfOB0mNdYvCVaSMN3Ke6ZataYEuejEit69BP/tK8cVwEy
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,270,1669100400"; 
   d="scan'208";a="199218324"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Feb 2023 06:06:13 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 3 Feb 2023 06:06:12 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.16 via Frontend Transport; Fri, 3 Feb 2023 06:06:11 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <daniel.lezcano@linaro.org>, <tglx@linutronix.de>
CC:     <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 0/2] clocksource/drivers/timer-microchip-pit64b: add delay timer support
Date:   Fri, 3 Feb 2023 15:05:35 +0200
Message-ID: <20230203130537.1921608-1-claudiu.beznea@microchip.com>
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

Changed in v2:
- rebase on top of [1] and as a consequence get rid of patch 1/1 from v1

[1] https://lore.kernel.org/all/20230121182911.4e47a5ff@endymion.delvare/

Claudiu Beznea (2):
  clocksource/drivers/timer-microchip-pit64b: select driver only on ARM
  clocksource/drivers/timer-microchip-pit64b: add delay timer

 drivers/clocksource/Kconfig                  |  2 +-
 drivers/clocksource/timer-microchip-pit64b.c | 12 ++++++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

-- 
2.34.1

