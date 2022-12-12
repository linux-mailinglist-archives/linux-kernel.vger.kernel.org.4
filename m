Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3603764AA35
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 23:26:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233766AbiLLW0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 17:26:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233753AbiLLW0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 17:26:00 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B4019C3F
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 14:26:00 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1p4rFA-0004ea-BO; Mon, 12 Dec 2022 23:25:52 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1p4rF7-004777-Rd; Mon, 12 Dec 2022 23:25:50 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1p4rF7-004boV-Vk; Mon, 12 Dec 2022 23:25:49 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org, linux-tegra@vger.kernel.org
Subject: [PATCH 0/3] soc: Drop empty platform remove function
Date:   Mon, 12 Dec 2022 23:25:46 +0100
Message-Id: <20221212222549.3779846-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=903; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=9Yqk7LGk8vsN1xLwr87+BsL2JAMEBNXdS9ZNHOAdVxM=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBjl6peqTXm1Zx9NKzokMGKZQZSwYOUvxD/gnhcUpA/ UQjbZzqJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCY5eqXgAKCRDB/BR4rcrsCaK1B/ 4oIK1BL6SDADD6LcuQe6Vsa6aKJmXXgR3STJ4wsSKPXnYiCAC/9THyfxl8k2xY1pz76wXoGGpsv3n6 nx/FwuiOJvQMLSaq7cikPEXGBM9KLDUEb16XsRoG0iniCd38O2eORUQEHsChm0McPvqgQbBmccJA1w 4wULbfw28dt9LwvXTHkSLNET79AidBbXCrktJIe1LO4OatyB/N/8t7VcLlryAW48jTn2Nz/Kv/KWWw xmzyct/oVFDgC1LB+pO8L33gWeSlWsnbzQxSn/ERJDlfModX0FhRGGmaP6aUuRxeT7butXbwlOBj30 imqj5ub3nTf8Gw1G4yN5MKRpufu8iA
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

this patch series removes all platform remove functions that only return
zero below drivers/soc. There is no reason to have these, as the only
caller is platform core code doing:

        if (drv->remove) {
                int ret = drv->remove(dev);

                if (ret)
			dev_warn(...)
        }

(in platform_remove()) and so having no remove function is both
equivalent and simpler.

Best regards
Uwe

Uwe Kleine-König (3):
  soc: bcm: bcm2835-power: Drop empty platform remove function
  soc: mediatek: mutex: Drop empty platform remove function
  soc: tegra: cbb: Drop empty platform remove function

 drivers/soc/bcm/bcm2835-power.c      | 6 ------
 drivers/soc/mediatek/mtk-mutex.c     | 6 ------
 drivers/soc/tegra/cbb/tegra234-cbb.c | 6 ------
 3 files changed, 18 deletions(-)


base-commit: 830b3c68c1fb1e9176028d02ef86f3cf76aa2476
-- 
2.38.1

