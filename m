Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDE1B715688
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 09:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbjE3HUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 03:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbjE3HUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 03:20:36 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C8B12B
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 00:19:59 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1q3tda-0006UN-Vz; Tue, 30 May 2023 09:19:23 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q3tdX-003or8-As; Tue, 30 May 2023 09:19:19 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q3tdW-009OQh-H3; Tue, 30 May 2023 09:19:18 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Minas Harutyunyan <hminas@synopsys.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mathias Nyman <mathias.nyman@intel.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-arm-msm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2 0/6] usb: Convert to platform remove callback returning void (remaining bits)
Date:   Tue, 30 May 2023 09:19:07 +0200
Message-Id: <20230530071913.2192214-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2124; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=w8VLr5gg9MpKTC9YCycRET36XrXSH3CwM63P78lVMiE=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkdaNn0SwQSjxYtJxfeHrEoXtLMeSFDUcwcASJz Q5sxk0JeI2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZHWjZwAKCRCPgPtYfRL+ TiwYB/902+th/wxDM1fEHoElL6MAPbVZDAHoWnj2tTAcukNFQj2wdNxOzuqXAw8X7XcPvUx+N5T NtZU3QvkNFmLka+QTh0+Ud++cxkvPglHW09q5aFkhqZ7otsgjkglp0pduorbBZmxIqNDX9cZ18h cVn12h3+FiKxsvu4MLWi0JS+HjgNm9+d/QE7Avej5dMFfzbZb8iS0m34n9IV5SgDs7CaTHvhu1m dDzocHYMdhF0FsHxa3v5H1WbxNKEOmCCVTFoyrtPIuAqntA/C89UQKIcALzx9v9DTResYLSy/dT h8Jol0qSLffUwoGpr8jF9D0V4Zh0EcPTdeXpXI/K08ATTuF5
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,

Greg applied a big part of the v1 series (which had 97 patches). There
was some fallout however and so this v2 only contains the remaining bits
on top of Greg's tree that has most of v1 already.

I fscked up the xhci-plat patch. So Greg dropped all xhci patches. The
xhci-plat patch included now is obviously a bit different, touching more
files, but in return compiles fine.

Also there were some conflicts with other pending changes in the usb
tree:

 - The dwc2 patch conflicted with commit ada050c69108 ("usb: dwc2: Fix
   some error handling paths"). My v1 submission got an Ack by Minas
   Harutyunyan, I applied it to this serie's v2, too.

 - The xhci-mtk patch is unchanged but gained a Review by
   AngeloGioacchino Del Regno.

 - The qcom-pmic-typec patch confliced with commit a4422ff22142 ("usb:
   typec: qcom: Add Qualcomm PMIC Type-C driver"). I applied the
   received acks/reviews by Konrad Dybcio, Bryan O'Donoghue, and Heikki
   Krogerus anyhow.

Thanks for all the feedback on v1.

Best regards
Uwe

Uwe Kleine-König (6):
  usb: dwc2/platform: Convert to platform remove callback returning void
  usb: xhci-histb: Convert to platform remove callback returning void
  usb: xhci-mtk: Convert to platform remove callback returning void
  usb: xhci-plat: Convert to platform remove callback returning void
  usb: xhci-tegra: Convert to platform remove callback returning void
  usb: typec: qcom-pmic-typec: Convert to platform remove callback
    returning void

 drivers/usb/dwc2/platform.c                   | 6 ++----
 drivers/usb/host/xhci-histb.c                 | 6 ++----
 drivers/usb/host/xhci-mtk.c                   | 6 ++----
 drivers/usb/host/xhci-plat.c                  | 6 ++----
 drivers/usb/host/xhci-plat.h                  | 2 +-
 drivers/usb/host/xhci-rcar.c                  | 6 +++---
 drivers/usb/host/xhci-tegra.c                 | 6 ++----
 drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c | 6 ++----
 8 files changed, 16 insertions(+), 28 deletions(-)

base-commit: b4a4be8471846d96b0ac52a0e9e7d48005cc97e2
-- 
2.39.2

