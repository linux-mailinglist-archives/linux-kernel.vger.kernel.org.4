Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07BBF6FB31A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 16:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234169AbjEHOlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 10:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233648AbjEHOlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 10:41:50 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F56E10C0
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 07:41:48 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pw23Y-00032R-I7; Mon, 08 May 2023 16:41:40 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pw23X-0021LS-0d; Mon, 08 May 2023 16:41:39 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pw23W-002SpR-AW; Mon, 08 May 2023 16:41:38 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Joe Perches <joe@perches.com>
Cc:     Liviu Dudau <liviu.dudau@arm.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        Andra Paraschiv <andraprs@amazon.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexandru Vasile <acvasile96@gmail.com>,
        Brian Starkey <brian.starkey@arm.com>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH] MAINTAINERS: Drop realname for L: entries
Date:   Mon,  8 May 2023 16:41:35 +0200
Message-Id: <20230508144135.1450524-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2111; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=5MAYXKXrDK0JRRNZ5gPCoA2bv4PjsOKRsLUgPH2+tQI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkWQoeQjqySYiomkaNxW/xuyfC4KJtzhUhJHjvg 2Vu3ts/wLCJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZFkKHgAKCRCPgPtYfRL+ TpXlB/4ga8V6C9N3XRZh8O5u7MTydfre0g8IguqoUna1fTrjeXdVW+OCCH7vF04X847UhhqimHk 8cISO9MpYfBLy7q950WGUhDClIrvKmL3JC5e7IEQHgd7u4X49oqngFcyNWF2kMxQ/Y3ycNcd1KB hEDzYCeQDFTdlHHhiQxy3Yf51b0nTHT1+HFIm7vgrSZucvz+2nVdJgxoKbwaWSIUoonivVHr3NA 1UXAl4YTzvzZ1RF2N8LJZl9uggQ4JZXwa0jrVg/VrhJQVCvka4Mu39e8s1xDWRLqnIFFcF8IOKS H5Vj7NKHLY4MQw115F1B2gGsrjVjKKo9edWf9MmtVRji4bYX
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

The format of L: entries in the MAINTAINERS file are expected to just
contain the list's email address. get_maintainers doesn't cope well, if
a realname is specified:

	$ scripts/get_maintainer.pl -f Documentation/devicetree/bindings/display/arm,komeda.yaml
	...
	 (open list:ARM KOMEDA DRM-KMS DRIVER)
	...

So drop the realname (and the < >).

Fixes: ab6911b73493 ("MAINTAINERS: Add maintainer for Arm komeda driver")
Fixes: 6865788f5ad9 ("MAINTAINERS: Update entries from the Nitro Enclaves section")
Fixes: 3affaa5a7ca3 ("drm/afbc: Add AFBC modifier usage documentation")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Hello,

who will apply this patch? Joe?

Best regards
Uwe

 MAINTAINERS | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7e0b87d5aa2e..ae1d8e140a67 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1669,7 +1669,7 @@ ARM KOMEDA DRM-KMS DRIVER
 M:	James (Qian) Wang <james.qian.wang@arm.com>
 M:	Liviu Dudau <liviu.dudau@arm.com>
 M:	Mihail Atanassov <mihail.atanassov@arm.com>
-L:	Mali DP Maintainers <malidp@foss.arm.com>
+L:	malidp@foss.arm.com
 S:	Supported
 T:	git git://anongit.freedesktop.org/drm/drm-misc
 F:	Documentation/devicetree/bindings/display/arm,komeda.yaml
@@ -1691,7 +1691,7 @@ F:	include/uapi/drm/panfrost_drm.h
 ARM MALI-DP DRM DRIVER
 M:	Liviu Dudau <liviu.dudau@arm.com>
 M:	Brian Starkey <brian.starkey@arm.com>
-L:	Mali DP Maintainers <malidp@foss.arm.com>
+L:	malidp@foss.arm.com
 S:	Supported
 T:	git git://anongit.freedesktop.org/drm/drm-misc
 F:	Documentation/devicetree/bindings/display/arm,malidp.yaml
@@ -14825,7 +14825,7 @@ F:	arch/nios2/
 NITRO ENCLAVES (NE)
 M:	Alexandru Ciobotaru <alcioa@amazon.com>
 L:	linux-kernel@vger.kernel.org
-L:	The AWS Nitro Enclaves Team <aws-nitro-enclaves-devel@amazon.com>
+L:	aws-nitro-enclaves-devel@amazon.com
 S:	Supported
 W:	https://aws.amazon.com/ec2/nitro/nitro-enclaves/
 F:	Documentation/virt/ne_overview.rst

base-commit: ac9a78681b921877518763ba0e89202254349d1b
-- 
2.39.2

