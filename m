Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 255ED64AA32
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 23:26:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233248AbiLLW0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 17:26:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233749AbiLLWZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 17:25:58 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8404D1ADA2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 14:25:56 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1p4rF9-0004eg-QK; Mon, 12 Dec 2022 23:25:51 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1p4rF8-00477F-D6; Mon, 12 Dec 2022 23:25:51 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1p4rF8-004bob-Fk; Mon, 12 Dec 2022 23:25:50 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 2/3] soc: mediatek: mutex: Drop empty platform remove function
Date:   Mon, 12 Dec 2022 23:25:48 +0100
Message-Id: <20221212222549.3779846-3-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221212222549.3779846-1-u.kleine-koenig@pengutronix.de>
References: <20221212222549.3779846-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1077; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=WGfUhoni8vWurjVU/pKwNFMNSVOT2a39AD+uC/+5ko8=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBjl6pkZQAZnNlqbmONBIaCu/XATKlD66kBisINCbtk fPKjji+JATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCY5eqZAAKCRDB/BR4rcrsCfqTB/ 9eNg97mvFGrIFx70h4TjtfmfUC4O0jZLQfvxO0iG9ECJZaSyNhENtLB+uRn0qiqcgtTq+2gkXsKy7P 3tcpcniSbfioCbY0AvBpMs8sSTLsNRaFFe3NO9lmcA/gixUK5HvT3eZMlA1lWvxzpj6p0VxKmFQtVJ fA6J+7kPOEiPFCfXK2tsBeRkWRcd35JuXbMoocD7Jk7WGSLBL09JyXTx8tQeK2PfLRxJDn9usQjbGu dVSHIVOkTuD4mkkWnPYEJ/ZLE9uiCAtLegaYIyzKJuej+o1oU5wCJG0K2V2PEkudjiDAsIa03baIuh K7aoPrXsb2HQG0JeOgr7IF7F/P7kMt
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
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A remove callback just returning 0 is equivalent to no remove callback
at all. So drop the useless function.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/soc/mediatek/mtk-mutex.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-mutex.c b/drivers/soc/mediatek/mtk-mutex.c
index c1a33d52038e..85f7fd67d7c6 100644
--- a/drivers/soc/mediatek/mtk-mutex.c
+++ b/drivers/soc/mediatek/mtk-mutex.c
@@ -832,11 +832,6 @@ static int mtk_mutex_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int mtk_mutex_remove(struct platform_device *pdev)
-{
-	return 0;
-}
-
 static const struct of_device_id mutex_driver_dt_match[] = {
 	{ .compatible = "mediatek,mt2701-disp-mutex",
 	  .data = &mt2701_mutex_driver_data},
@@ -866,7 +861,6 @@ MODULE_DEVICE_TABLE(of, mutex_driver_dt_match);
 
 static struct platform_driver mtk_mutex_driver = {
 	.probe		= mtk_mutex_probe,
-	.remove		= mtk_mutex_remove,
 	.driver		= {
 		.name	= "mediatek-mutex",
 		.owner	= THIS_MODULE,
-- 
2.38.1

