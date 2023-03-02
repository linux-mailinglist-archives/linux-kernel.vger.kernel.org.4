Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94F8B6A8469
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 15:47:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbjCBOry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 09:47:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbjCBOrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 09:47:49 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAED841B72
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 06:47:47 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pXkDb-0003rI-24; Thu, 02 Mar 2023 15:47:39 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pXkDa-001LrA-9m; Thu, 02 Mar 2023 15:47:38 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pXkDZ-001Zpf-Dq; Thu, 02 Mar 2023 15:47:37 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
Cc:     kernel@pengutronix.de,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 06/29] platform/x86: amilo-rfkill: Convert to platform remove callback returning void
Date:   Thu,  2 Mar 2023 15:47:09 +0100
Message-Id: <20230302144732.1903781-7-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230302144732.1903781-1-u.kleine-koenig@pengutronix.de>
References: <20230302144732.1903781-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1623; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=A8djoGpUAgNgkbWQ39wAp8VsGIh4VFkpPhaldfySJwA=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkALaZ2pVqagkhwomGyOVT91iRR36ZU9e7wuLcT JPIITqf5Z2JATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAC2mQAKCRDB/BR4rcrs CTfKB/95zYHTwLm7M3dAiiZI2Y5CA2UCdwVZr59pVKuWqZJ0rNZ5bUV9ygA/PIwL2AV90a5y6w/ EfytQEvPQhocXUu5Lo+e7yMqsvA5/9aclOMQONCv8MbV4zrudSKGnMXvPjNaUojoWyjDgdfc3Bv 83GB0TOQgKwNlAjktslFxkS0Rz+VrYBtxR8H5U1+S0LbSKUewDWRBJN9Uj4uPekHcllZJdbkd7L FYlTmEQcPSsiWX2IeURMmWxnOdyFIxLnhPz/BJiKrLaWT6m+0K5EwG8qwQDFLMfFrY2XaKmQRVf b3xZ7ijEMIYtc4j6EOrERAbky6dDSgM4tUJvz/SWfn9QQMHo
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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
 drivers/platform/x86/amilo-rfkill.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/amilo-rfkill.c b/drivers/platform/x86/amilo-rfkill.c
index 3e313c4d538d..efcf909786a5 100644
--- a/drivers/platform/x86/amilo-rfkill.c
+++ b/drivers/platform/x86/amilo-rfkill.c
@@ -124,11 +124,10 @@ static int amilo_rfkill_probe(struct platform_device *device)
 	return rc;
 }
 
-static int amilo_rfkill_remove(struct platform_device *device)
+static void amilo_rfkill_remove(struct platform_device *device)
 {
 	rfkill_unregister(amilo_rfkill_dev);
 	rfkill_destroy(amilo_rfkill_dev);
-	return 0;
 }
 
 static struct platform_driver amilo_rfkill_driver = {
@@ -136,7 +135,7 @@ static struct platform_driver amilo_rfkill_driver = {
 		.name	= KBUILD_MODNAME,
 	},
 	.probe	= amilo_rfkill_probe,
-	.remove	= amilo_rfkill_remove,
+	.remove_new = amilo_rfkill_remove,
 };
 
 static int __init amilo_rfkill_init(void)
-- 
2.39.1

