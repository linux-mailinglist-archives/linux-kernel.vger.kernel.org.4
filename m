Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F15C15EBDA7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 10:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbiI0Inl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 04:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbiI0Ina (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 04:43:30 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C5A0753AC;
        Tue, 27 Sep 2022 01:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1664268209; x=1695804209;
  h=from:to:cc:subject:date:message-id;
  bh=mqeu4ctTSeKJelOAi5YhFsLv9gvO0DIIHlFPu3E7yxI=;
  b=aZEkeCpaOGSMDb3hFfx56hm1EU+pCP+xHOMD7foUFRu9KoN3ZNBp1NPA
   Gl8YwVISyBbPcC1knFEDMR9OuBvNTbCNUczSEbJTTQNAtp8mpI121ke+m
   fmOeSeKjL9c/ImC9+cdVa9wx1K3873N7/nqGhpwpvkP/hrGN7TqxiVVle
   xcieEV2M0896yGW4xKyMKsiSQ54CLwHbSDj62di1vTv404Jrv2ltUonXA
   aGQsO4lD1Uwxpg9gXvQ13XIbujPhazqERn2a2L9dVMIoxeUVGG6OaSn0A
   pvKwgBCRnY16uogNHZ75Pnn0X6iQDG2uKcW7Lq3oVhk68iA3B/DNWAzLC
   w==;
X-IronPort-AV: E=Sophos;i="5.93,348,1654531200"; 
   d="scan'208";a="210729605"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 Sep 2022 16:43:28 +0800
IronPort-SDR: U9jzNy2Awnu3HW1UsJbMbMW8jjpwIKjPGXQ9v6UTKnuGy2PfcIQWM0KIjHnaML91HugetxFPoD
 iK5RQKm234dQ+Vfigr4dtBJIb5WtpBNo9nu6cY+EdNHFPn/pkXvY+1JvBsVDocH+HMbAdaN14G
 20Tx/UZckrJnXO2/kcrP/5sCZjvQsrA+ZZJGtK0cGTpfbdmy+pxJUNDuYD+txlZrjwssc5ir1t
 M6MXjr4c5DYJCHjSgGkegHRDMZHtARY7xhJB1QAjej1H8dvXI3g6tddfOTtmvpkNoSO2iojYqm
 bsIKSKedpsSSWgo5mnbLxxTE
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Sep 2022 01:03:25 -0700
IronPort-SDR: 0vd5/xxHBlzNYt5Zapx1gzVhtYB7gn97fV6XvbnQEfjP58/T2W9SPGw3eRw90k+zcsUnBit80G
 Hi9dYwTuoRuZelhwDov2d5P4FcoSgiUkjIwQO96IBDzmrkn5WstL3il0a1RQSFmwUaxNlQzTEM
 zl9UXyezcOlS0i4HubN3YFAzp6uDOTA+SWut5s4eL9Nic6W3mH+0rctW3crwQ2TyRcQTAEKKET
 qg3DqKUzvILLc30RCqQbPDH/hVr+C0MMwkW0TkoluCbr7lnOQcY+d+mFvv34vgeQmWEA1z9Krv
 yno=
WDCIronportException: Internal
Received: from 5cg1421gqg.ad.shared (HELO BXYGM33.ad.shared) ([10.225.33.87])
  by uls-op-cesaip02.wdc.com with ESMTP; 27 Sep 2022 01:43:25 -0700
From:   Avri Altman <avri.altman@wdc.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc:     Mark Kanczak <Markk@us.atpinc.com>, linux-kernel@vger.kernel.org,
        Avri Altman <avri.altman@wdc.com>
Subject: [PATCH] mmc-utils: Fix a typo for ATP mid
Date:   Tue, 27 Sep 2022 11:43:17 +0300
Message-Id: <20220927084317.138-1-avri.altman@wdc.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Manufacturer id 0x44 is assign to ATP by 3c-LLC, and not to SanDisk.
mmc-utils inherited this typo when lsmmc got merged into it.

fixes: 4af1749d2350 (mmc-utils: Merge the lsmmc tool into mmc-utils)

Reported-by: Mark Kanczak <Markk@us.atpinc.com>
Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 lsmmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lsmmc.c b/lsmmc.c
index 05d59e8..55da3aa 100644
--- a/lsmmc.c
+++ b/lsmmc.c
@@ -237,7 +237,7 @@ struct ids_database database[] = {
 	{
 		.type = "mmc",
 		.id = 0x44,
-		.manufacturer = "SanDisk",
+		.manufacturer = "ATP",
 	},
 	{
 		.type = "mmc",
-- 
2.17.1

