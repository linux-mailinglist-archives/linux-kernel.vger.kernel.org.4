Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 202C36D390F
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 18:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbjDBQnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 12:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbjDBQn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 12:43:28 -0400
Received: from ste-pvt-msa1.bahnhof.se (ste-pvt-msa1.bahnhof.se [213.80.101.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E2BEB73;
        Sun,  2 Apr 2023 09:43:25 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTP id EC0DF3F6EF;
        Sun,  2 Apr 2023 18:43:23 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Score: -2.1
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
Authentication-Results: ste-pvt-msa1.bahnhof.se (amavisd-new);
        dkim=pass (2048-bit key) header.d=dalakolonin.se
Received: from ste-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (ste-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id xfPpf1fz_h0h; Sun,  2 Apr 2023 18:43:23 +0200 (CEST)
Received: by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 1AD883F42D;
        Sun,  2 Apr 2023 18:43:23 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.dalakolonin.se (Postfix) with ESMTP id DB31C937B1;
        Sun,  2 Apr 2023 16:43:22 +0000 (UTC)
Received: from zimbra.dalakolonin.se ([127.0.0.1])
        by localhost (zimbra.dalakolonin.se [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id HFoiwCDHRIdH; Sun,  2 Apr 2023 16:43:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.dalakolonin.se (Postfix) with ESMTP id AFCBF93789;
        Sun,  2 Apr 2023 16:43:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra.dalakolonin.se AFCBF93789
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dalakolonin.se;
        s=D374B428-D0A7-11ED-A657-75977B426508; t=1680453797;
        bh=+IL/VOJpx/Evc5dCgWk5x3rUwfJq8dsip/nY6cvyErU=;
        h=From:To:Date:Message-Id:MIME-Version;
        b=a8t6789mmQI+9K7R7vspArIyig1h3/guiDMqemD6XbVOkVt96pM2DQbeElPmdAaCS
         Zbn89NSIsJpemC3pUfWhYLaLWHZDZZKzdRxiD1jX01SWnkKstzf81ZkguMXg/Zsy1d
         skUFy5E4GyEpwTG0Txs188eIpJOzzyrFWRFUeTCjz2a+KSIfZ/ySw8PJJpiLdBCFdG
         +vkFSEVOwoi1otzamI9gfO670CZfkf3XVdhbRgaGcCps3pUK2lTpG5RV3DrbYyL2KT
         zEbxTvAGiBbFYpRXmlI1CLSj5BD7YDJ/eX+YAZ3LDwhJoUNy5OMbOgqZFKmbGLcoJP
         WgEcQBbdaxVLQ==
X-Virus-Scanned: amavisd-new at dalakolonin.se
Received: from zimbra.dalakolonin.se ([127.0.0.1])
        by localhost (zimbra.dalakolonin.se [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id BrBSvqf0_VYi; Sun,  2 Apr 2023 16:43:17 +0000 (UTC)
Received: from rack-server-1.dalakolonin.se (unknown [172.17.0.1])
        by zimbra.dalakolonin.se (Postfix) with ESMTPSA id 5B46F9377C;
        Sun,  2 Apr 2023 16:43:17 +0000 (UTC)
From:   =?UTF-8?q?Patrik=20Dahlstr=C3=B6m?= <risca@dalakolonin.se>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org,
        kernel@pyra-handheld.com, pgoudagunta@nvidia.com,
        hns@goldelico.com, jic23@kernel.org, lars@metafoo.de,
        linux-omap@vger.kernel.org,
        =?UTF-8?q?Patrik=20Dahlstr=C3=B6m?= <risca@dalakolonin.se>
Subject: [PATCH v2 3/7] iio: adc: palmas: use iio_event_direction for threshold polarity
Date:   Sun,  2 Apr 2023 18:42:43 +0200
Message-Id: <20230402164247.3089146-4-risca@dalakolonin.se>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230402164247.3089146-1-risca@dalakolonin.se>
References: <20230402164247.3089146-1-risca@dalakolonin.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of having high_threshold > 0 as an indicator for upper threshold
event and lower threshold event otherwise, use enum iio_event_direction
instead. This is hopefully less ambiguous.

Signed-off-by: Patrik Dahlstr=C3=B6m <risca@dalakolonin.se>
---
 drivers/iio/adc/palmas_gpadc.c | 36 ++++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/adc/palmas_gpadc.c b/drivers/iio/adc/palmas_gpad=
c.c
index 3ef0e1c08c8b..fca455a4285e 100644
--- a/drivers/iio/adc/palmas_gpadc.c
+++ b/drivers/iio/adc/palmas_gpadc.c
@@ -77,9 +77,9 @@ static struct palmas_gpadc_info palmas_gpadc_info[] =3D=
 {
 };
=20
 struct palmas_adc_event {
-	int adc_channel_number;
-	int adc_high_threshold;
-	int adc_low_threshold;
+	int channel;
+	int raw_thresh;
+	enum iio_event_direction direction;
 };
=20
 /*
@@ -617,16 +617,21 @@ static int palmas_adc_configure_events(struct palma=
s_gpadc *adc)
=20
 	conv =3D 0;
 	if (adc->event0_enable) {
+		struct palmas_adc_event *ev =3D &adc->event0;
 		int polarity;
=20
-		ch0 =3D adc->event0.adc_channel_number;
+		ch0 =3D ev->channel;
+		thres =3D ev->raw_thresh;
 		conv |=3D PALMAS_GPADC_AUTO_CTRL_AUTO_CONV0_EN;
-		if (adc->event0.adc_high_threshold > 0) {
-			thres =3D adc->event0.adc_high_threshold;
+		switch (ev->direction) {
+		case IIO_EV_DIR_RISING:
 			polarity =3D 0;
-		} else {
-			thres =3D adc->event0.adc_low_threshold;
+			break;
+		case IIO_EV_DIR_FALLING:
 			polarity =3D PALMAS_GPADC_THRES_CONV0_MSB_THRES_CONV0_POL;
+			break;
+		default:
+			return -EINVAL;
 		}
=20
 		ret =3D palmas_write(adc->palmas, PALMAS_GPADC_BASE,
@@ -648,16 +653,21 @@ static int palmas_adc_configure_events(struct palma=
s_gpadc *adc)
 	}
=20
 	if (adc->event1_enable) {
+		struct palmas_adc_event *ev =3D &adc->event1;
 		int polarity;
=20
-		ch1 =3D adc->event1.adc_channel_number;
+		ch1 =3D ev->channel;
+		thres =3D ev->raw_thresh;
 		conv |=3D PALMAS_GPADC_AUTO_CTRL_AUTO_CONV1_EN;
-		if (adc->event1.adc_high_threshold > 0) {
-			thres =3D adc->event1.adc_high_threshold;
+		switch (ev->direction) {
+		case IIO_EV_DIR_RISING:
 			polarity =3D 0;
-		} else {
-			thres =3D adc->event1.adc_low_threshold;
+			break;
+		case IIO_EV_DIR_FALLING:
 			polarity =3D PALMAS_GPADC_THRES_CONV1_MSB_THRES_CONV1_POL;
+			break;
+		default:
+			return -EINVAL;
 		}
=20
 		ret =3D palmas_write(adc->palmas, PALMAS_GPADC_BASE,
--=20
2.25.1

