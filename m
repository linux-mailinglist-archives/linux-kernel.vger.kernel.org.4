Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6276AB726
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 08:35:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjCFHfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 02:35:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbjCFHfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 02:35:03 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37322EB63
        for <linux-kernel@vger.kernel.org>; Sun,  5 Mar 2023 23:35:02 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pZ5N2-0008Ot-6m; Mon, 06 Mar 2023 08:34:56 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pZ5N1-002C0p-Iz; Mon, 06 Mar 2023 08:34:55 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pZ5N0-002bap-Ts; Mon, 06 Mar 2023 08:34:54 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 1/3] spmi: hisi-spmi-controller: Convert to platform remove callback returning void
Date:   Mon,  6 Mar 2023 08:34:44 +0100
Message-Id: <20230306073446.2194048-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230306073446.2194048-1-u.kleine-koenig@pengutronix.de>
References: <20230306073446.2194048-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1769; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=x46iUoVgDIkav2eWjEW3fVwWqvRPWVkTe9JpC8hEs6g=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkBZeKumnzDEGS3cNKpPSgFIsbr4ESrKdUuOXs/ wj2cK5zxUaJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAWXigAKCRDB/BR4rcrs CaeNCACNimmydFtC9/L6aAebZ10gGzFctSiRYpMUXHe6JH2e9I6Ol6C/p0Ijg4HjV1NAYeud/A0 9UQWbay91553sz82s8dXIQaJ5bLBYFgVMThRG6JupwkhpF+b4Tiyt7iSocLK6dMqPKut3Vs+JDt pifCSelGFKjbCAcSPqtLi2uSSuBKwowm+xutjSH6SoGjCQgJfEuPg/3qPoWXRmQUoVfk9j1a1Gh L2em8drjYf1bnOC5zOwlMorTI2sAClCBaz1ToIdH7gvs9vFWyPMg8WxtcoD9PQGKrZ8fAYudzrK Q8tjIgpWXxvGg3rVV+vDQaE7AVmPHDspR7NrCVOvU7b8m8mS
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is (mostly) ignored
and this typically results in resource leaks. To improve here there is a
quest to make the remove callback return void. In the first step of this
quest all drivers are converted to .remove_new() which already returns
void.

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/spmi/hisi-spmi-controller.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/spmi/hisi-spmi-controller.c b/drivers/spmi/hisi-spmi-controller.c
index 5bd23262abd6..9cbd473487cb 100644
--- a/drivers/spmi/hisi-spmi-controller.c
+++ b/drivers/spmi/hisi-spmi-controller.c
@@ -324,13 +324,12 @@ static int spmi_controller_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int spmi_del_controller(struct platform_device *pdev)
+static void spmi_del_controller(struct platform_device *pdev)
 {
 	struct spmi_controller *ctrl = platform_get_drvdata(pdev);
 
 	spmi_controller_remove(ctrl);
 	spmi_controller_put(ctrl);
-	return 0;
 }
 
 static const struct of_device_id spmi_controller_match_table[] = {
@@ -343,7 +342,7 @@ MODULE_DEVICE_TABLE(of, spmi_controller_match_table);
 
 static struct platform_driver spmi_controller_driver = {
 	.probe		= spmi_controller_probe,
-	.remove		= spmi_del_controller,
+	.remove_new	= spmi_del_controller,
 	.driver		= {
 		.name	= "hisi_spmi_controller",
 		.of_match_table = spmi_controller_match_table,
-- 
2.39.1

