Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6256065E32D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 04:00:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbjAEDAD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 22:00:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbjAEC70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 21:59:26 -0500
X-Greylist: delayed 320 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 04 Jan 2023 18:59:17 PST
Received: from mail.avorwerk.net (mail.avorwerk.net [65.21.54.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD42D4882D;
        Wed,  4 Jan 2023 18:59:17 -0800 (PST)
Received: from notebook.fritz.box (p579494d9.dip0.t-ipconnect.de [87.148.148.217])
        by mail.avorwerk.net (Postfix) with ESMTPA id D38E77D8F3;
        Thu,  5 Jan 2023 02:53:52 +0000 (UTC)
From:   Alexander Vorwerk <zabe@avorwerk.net>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Vorwerk <zabe@avorwerk.net>
Subject: [PATCH] drivers: iio: cdc: Drop redundant if check
Date:   Thu,  5 Jan 2023 03:53:51 +0100
Message-Id: <20230105025351.12099-1-zabe@avorwerk.net>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Alexander Vorwerk <zabe@avorwerk.net>
---
 drivers/iio/cdc/ad7746.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/cdc/ad7746.c b/drivers/iio/cdc/ad7746.c
index 6f68651ce1d5..a1db5469f2d1 100644
--- a/drivers/iio/cdc/ad7746.c
+++ b/drivers/iio/cdc/ad7746.c
@@ -285,8 +285,7 @@ static int ad7746_select_channel(struct iio_dev *indio_dev,
 		if (ret < 0)
 			return ret;
 
-		if (chip->capdac_set != chan->channel)
-			chip->capdac_set = chan->channel;
+		chip->capdac_set = chan->channel;
 		break;
 	case IIO_VOLTAGE:
 	case IIO_TEMP:
-- 
2.17.1

