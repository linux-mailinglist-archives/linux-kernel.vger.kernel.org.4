Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 503616AB727
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 08:35:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjCFHfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 02:35:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjCFHfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 02:35:04 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D69DEE388
        for <linux-kernel@vger.kernel.org>; Sun,  5 Mar 2023 23:35:03 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pZ5N2-0008Os-NA; Mon, 06 Mar 2023 08:34:57 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pZ5N1-002C0m-Gw; Mon, 06 Mar 2023 08:34:55 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pZ5N0-002bam-No; Mon, 06 Mar 2023 08:34:54 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@pengutronix.de
Subject: [PATCH 0/3] spmi: Convert to platform remove callback returning void
Date:   Mon,  6 Mar 2023 08:34:43 +0100
Message-Id: <20230306073446.2194048-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1458; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=LDehB5gsx29IvbmffavsnSV8Eu2SN5vC8ARQBx16fdE=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkBZeGXJt15Yv/ivjvwz1ZXiL3FL+DYlk2Ho0rZ BuAMxOa1WqJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAWXhgAKCRDB/BR4rcrs CW3AB/9vd0mEZbajImYQ7YcxspnZ2asSFbRlMWaqXKeQms/i2l3cKZBq26qcx882t9TpiwyDxpa vw5OxyLIMJp5dgDjXeTTssEpYY12XhMTh8TJTVsbLYklA+9Q0JBPQkgoVJds4WCdJd8qpO7A+IU Q8ECg2+oDNQRdZhXP7IR+8MduOzvpzrPaGaCPedZqNUY4eTuLEbdNNZEF+sjncofHacPc1KDmWl 4h5e/x8C0GMrGC8NWVoVvIZ1uYJpmNdO1ha2txwHaUqvk2Hwz2VyuP5xdPDskW2JI5heJK+rPcf WAmEuKjeyACjDX5GrRlqEgLMvnx5woR95e08sBOv4xFH3zwM
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

this patch series adapts the platform drivers below drivers/spmi
to use the .remove_new() callback. Compared to the traditional .remove()
callback .remove_new() returns no value. This is a good thing because
the driver core doesn't (and cannot) cope for errors during remove. The
only effect of a non-zero return value in .remove() is that the driver
core emits a warning. The device is removed anyhow and an early return
from .remove() usually yields a resource leak.

By changing the remove callback to return void driver authors cannot
reasonably assume any more that there is some kind of cleanup later.

All drivers in drivers/spmi returned zero unconditionally in their remove
callback, so they could all be converted trivially to .remove_new().

Note that this series depends on commit 5c5a7680e67b ("platform: Provide
a remove callback that returns no value") which is included in v6.3-rc1.

Best regards
Uwe


Uwe Kleine-König (3):
  spmi: hisi-spmi-controller: Convert to platform remove callback
    returning void
  spmi: mtk-pmif: Convert to platform remove callback returning void
  spmi: pmic-arb: Convert to platform remove callback returning void

 drivers/spmi/hisi-spmi-controller.c | 5 ++---
 drivers/spmi/spmi-mtk-pmif.c        | 5 ++---
 drivers/spmi/spmi-pmic-arb.c        | 5 ++---
 3 files changed, 6 insertions(+), 9 deletions(-)

base-commit: fe15c26ee26efa11741a7b632e9f23b01aca4cc6
-- 
2.39.1

