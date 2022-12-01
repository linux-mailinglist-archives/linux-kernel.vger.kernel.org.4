Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E15A63E711
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 02:27:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbiLAB05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 20:26:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiLAB0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 20:26:55 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54BF48C6A5;
        Wed, 30 Nov 2022 17:26:54 -0800 (PST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4NMz222Fsgz8QrkZ;
        Thu,  1 Dec 2022 09:26:50 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.40.50])
        by mse-fl2.zte.com.cn with SMTP id 2B11QftC001011;
        Thu, 1 Dec 2022 09:26:41 +0800 (+08)
        (envelope-from zhang.songyi@zte.com.cn)
Received: from mapi (xaxapp01[null])
        by mapi (Zmail) with MAPI id mid31;
        Thu, 1 Dec 2022 09:26:42 +0800 (CST)
Date:   Thu, 1 Dec 2022 09:26:42 +0800 (CST)
X-Zmail-TransId: 2af9638802d255a4c856
X-Mailer: Zmail v1.0
Message-ID: <202212010926422966197@zte.com.cn>
Mime-Version: 1.0
From:   <zhang.songyi@zte.com.cn>
To:     <adrian.hunter@intel.com>
Cc:     <ulf.hansson@linaro.org>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <zhang.songyi@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIG1tYzogc2RoY2k6IFJlbW92ZSB1bm5lZWRlZCBzZW1pY29sb24=?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 2B11QftC001011
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.137.novalocal with ID 638802DA.000 by FangMail milter!
X-FangMail-Envelope: 1669858010/4NMz222Fsgz8QrkZ/638802DA.000/10.5.228.133/[10.5.228.133]/mse-fl2.zte.com.cn/<zhang.songyi@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 638802DA.000/4NMz222Fsgz8QrkZ
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zhang songyi <zhang.songyi@zte.com.cn>

The semicolon after the "}" is unneeded.

Signed-off-by: zhang songyi <zhang.songyi@zte.com.cn>
---
 drivers/mmc/host/sdhci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 42aaeabcad22..8413180a1039 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2289,7 +2289,7 @@ static bool sdhci_timing_has_preset(unsigned char timing)
        case MMC_TIMING_UHS_DDR50:
        case MMC_TIMING_MMC_DDR52:
                return true;
-       };
+       }
        return false;
 }

--
2.15.2
