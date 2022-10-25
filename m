Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F55260C198
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 04:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbiJYCTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 22:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbiJYCTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 22:19:33 -0400
Received: from gateway33.websitewelcome.com (gateway33.websitewelcome.com [192.185.145.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C11B21E
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 19:19:28 -0700 (PDT)
Received: from atl1wswcm02.websitewelcome.com (unknown [50.6.129.163])
        by atl4wswob04.websitewelcome.com (Postfix) with ESMTP id 8ADDEC01B2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 02:19:27 +0000 (UTC)
Received: from br984.hostgator.com.br ([162.241.203.37])
        by cmsmtp with ESMTP
        id n9XLooHin4ZGbn9XLosgIs; Tue, 25 Oct 2022 02:19:27 +0000
X-Authority-Reason: nr=8
Received: from [177.194.67.221] (port=49966 helo=arch-avell.meuintelbras.local)
        by br984.hostgator.com.br with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <pedro.guilherme@espectro.eng.br>)
        id 1on9XK-002QdP-It;
        Mon, 24 Oct 2022 23:19:26 -0300
From:   Pedro Guilherme Siqueira Moreira <pedro.guilherme@espectro.eng.br>
To:     laurent.pinchart@ideasonboard.com
Cc:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Pedro Guilherme Siqueira Moreira 
        <pedro.guilherme@espectro.eng.br>
Subject: [PATCH v2 2/3] media: uvc_driver: fix assignment inside if condition
Date:   Mon, 24 Oct 2022 23:19:18 -0300
Message-Id: <20221025021919.929910-2-pedro.guilherme@espectro.eng.br>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221025021919.929910-1-pedro.guilherme@espectro.eng.br>
References: <Y1c9nS04fpoLqPVe@pendragon.ideasonboard.com>
 <20221025021919.929910-1-pedro.guilherme@espectro.eng.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br984.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - espectro.eng.br
X-BWhitelist: no
X-Source-IP: 177.194.67.221
X-Source-L: No
X-Exim-ID: 1on9XK-002QdP-It
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (arch-avell.meuintelbras.local) [177.194.67.221]:49966
X-Source-Auth: pedro.guilherme@espectro.eng.br
X-Email-Count: 5
X-Source-Cap: ZXNwZWN0ODU7ZXNwZWN0ODU7YnI5ODQuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfDaUSEtu6j/WpCvIDSrgl7GLVTPx8gxV5Ga25NR0zi66yvgRejzJc6qFMS1TttPwSqfJ6d5wBnCvBd0d8Ue8MgCnQO2QZ+eD5tPCqyW9rAjQwGvh44Eb
 XQVWARNh1jlGNCJYvZgpEHj5UULpmypIoDqYiyQj70SMbLvFKfXrD78ty6s7xq56S8jBAPgsmr2WKA8PcnsG4KDA7BpTA+or6WTS33nV2jp0a8jdv+83DBIz
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes 'do not use assignment in if condition' errors issued by
scripts/checkpatch.pl on lines 1464 and 2500 on
drivers/media/usb/uvc/uvc_driver.c

Signed-off-by: Pedro Guilherme Siqueira Moreira <pedro.guilherme@espectro.eng.br>
---
 drivers/media/usb/uvc/uvc_driver.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index b591ad823c66..7b6c97ad3a41 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -1174,7 +1174,8 @@ static int uvc_parse_control(struct uvc_device *dev)
 		    buffer[1] != USB_DT_CS_INTERFACE)
 			goto next_descriptor;
 
-		if ((ret = uvc_parse_standard_control(dev, buffer, buflen)) < 0)
+		ret = uvc_parse_standard_control(dev, buffer, buflen);
+		if (ret < 0)
 			return ret;
 
 next_descriptor:
@@ -2213,7 +2214,8 @@ static int uvc_probe(struct usb_interface *intf,
 	usb_set_intfdata(intf, dev);
 
 	/* Initialize the interrupt URB. */
-	if ((ret = uvc_status_init(dev)) < 0) {
+	ret = uvc_status_init(dev);
+	if (ret < 0) {
 		dev_info(&dev->udev->dev,
 			 "Unable to initialize the status endpoint (%d), status interrupt will not be supported.\n",
 			 ret);
-- 
2.38.1

