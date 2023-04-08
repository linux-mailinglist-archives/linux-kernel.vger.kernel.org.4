Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2FA6DBA86
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 13:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbjDHLrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 07:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbjDHLrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 07:47:13 -0400
Received: from pio-pvt-msa3.bahnhof.se (pio-pvt-msa3.bahnhof.se [79.136.2.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B05B7FF37;
        Sat,  8 Apr 2023 04:46:59 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTP id 9FD0B3F6DD;
        Sat,  8 Apr 2023 13:46:57 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Score: -2.1
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
Authentication-Results: pio-pvt-msa3.bahnhof.se (amavisd-new);
        dkim=pass (2048-bit key) header.d=dalakolonin.se
Received: from pio-pvt-msa3.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa3.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id TV1ARSLbVha0; Sat,  8 Apr 2023 13:46:56 +0200 (CEST)
Received: by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTPA id A8FF03F645;
        Sat,  8 Apr 2023 13:46:56 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.dalakolonin.se (Postfix) with ESMTP id 4C64095F46;
        Sat,  8 Apr 2023 11:46:56 +0000 (UTC)
Received: from zimbra.dalakolonin.se ([127.0.0.1])
        by localhost (zimbra.dalakolonin.se [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id TXAn8zRf6FVy; Sat,  8 Apr 2023 11:46:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.dalakolonin.se (Postfix) with ESMTP id CF6BD95F42;
        Sat,  8 Apr 2023 11:46:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra.dalakolonin.se CF6BD95F42
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dalakolonin.se;
        s=D374B428-D0A7-11ED-A657-75977B426508; t=1680954413;
        bh=8oCsKoWj+OT4dqdz4wKUl0ESprUGM0ZozVBAf1AeyA0=;
        h=From:To:Date:Message-Id:MIME-Version;
        b=nDIG0lmBvcF8jmEvZZF4zN/YChcDQWKTGKZxmoUU5VlV3iwKWGmTlkhr/QHgBkOsr
         3qp2Uq8to6NteGqWK4NuXUBg4pDpLmkn/KtUUcYFISboofE9D4LTODCTRXYtgShxgM
         3rSRUGBFpw1QN8YV29YCpueTAVqQPLSwLmsHMIju3oVCndb4L+WQOLCaXdpbKUMWIX
         ZQgMQWWN1kXcuZ4TBUQ94R/aUV+F2Kj4MUXx/JXn2UzDq6x0HMzcypM2PNlt3ZSos4
         1sUq3DhqcNe78ehfEXNqGAVX/Vk3lMDI0Dc+WMlXxn4f0O64yZPd9cY8MwvPuMy9Qo
         7lNxh4gG6YCPw==
X-Virus-Scanned: amavisd-new at dalakolonin.se
Received: from zimbra.dalakolonin.se ([127.0.0.1])
        by localhost (zimbra.dalakolonin.se [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id s7CCfjFJXs7L; Sat,  8 Apr 2023 11:46:53 +0000 (UTC)
Received: from rack-server-1.dalakolonin.se (unknown [172.17.0.1])
        by zimbra.dalakolonin.se (Postfix) with ESMTPSA id 35F6A95F3F;
        Sat,  8 Apr 2023 11:46:53 +0000 (UTC)
From:   =?UTF-8?q?Patrik=20Dahlstr=C3=B6m?= <risca@dalakolonin.se>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org,
        kernel@pyra-handheld.com, pgoudagunta@nvidia.com,
        hns@goldelico.com, jic23@kernel.org, lars@metafoo.de,
        linux-omap@vger.kernel.org,
        =?UTF-8?q?Patrik=20Dahlstr=C3=B6m?= <risca@dalakolonin.se>
Subject: [PATCH v3 3/7] iio: adc: palmas: use iio_event_direction for threshold polarity
Date:   Sat,  8 Apr 2023 13:46:20 +0200
Message-Id: <20230408114624.824144-4-risca@dalakolonin.se>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230408114624.824144-1-risca@dalakolonin.se>
References: <20230408114624.824144-1-risca@dalakolonin.se>
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
index 55fdf59ef711..205a7628b235 100644
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
@@ -618,16 +618,21 @@ static int palmas_adc_configure_events(struct palma=
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
@@ -649,16 +654,21 @@ static int palmas_adc_configure_events(struct palma=
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

