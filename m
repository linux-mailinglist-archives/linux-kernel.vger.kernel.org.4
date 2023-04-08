Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E77D6DBA80
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 13:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbjDHLq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 07:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbjDHLqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 07:46:52 -0400
Received: from ste-pvt-msa2.bahnhof.se (ste-pvt-msa2.bahnhof.se [213.80.101.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EECDEFBD;
        Sat,  8 Apr 2023 04:46:46 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 5E1954040D;
        Sat,  8 Apr 2023 13:46:44 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Score: -2.1
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
Authentication-Results: ste-ftg-msa2.bahnhof.se (amavisd-new);
        dkim=pass (2048-bit key) header.d=dalakolonin.se
Received: from ste-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (ste-ftg-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id An0gfqvTNGqE; Sat,  8 Apr 2023 13:46:43 +0200 (CEST)
Received: by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 6F2663FF56;
        Sat,  8 Apr 2023 13:46:43 +0200 (CEST)
Authentication-Results: ste-pvt-msa2.bahnhof.se;
        dkim=pass (2048-bit key; unprotected) header.d=dalakolonin.se header.i=@dalakolonin.se header.b="TRv4YgPc";
        dkim-atps=neutral
Received: from localhost (localhost [127.0.0.1])
        by zimbra.dalakolonin.se (Postfix) with ESMTP id 4D6EA95F1B;
        Sat,  8 Apr 2023 11:46:43 +0000 (UTC)
Received: from zimbra.dalakolonin.se ([127.0.0.1])
        by localhost (zimbra.dalakolonin.se [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 5mKt8oYuwbOU; Sat,  8 Apr 2023 11:46:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.dalakolonin.se (Postfix) with ESMTP id 07E4C95F17;
        Sat,  8 Apr 2023 11:46:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra.dalakolonin.se 07E4C95F17
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dalakolonin.se;
        s=D374B428-D0A7-11ED-A657-75977B426508; t=1680954402;
        bh=QpAkz8NzyhCd80cX7C/EMbSMfNw/jsM+n+BufT6T6ZU=;
        h=From:To:Date:Message-Id:MIME-Version;
        b=TRv4YgPc7jqopecowqYjGjGoeWm1CoI0t24YbuY8l50kb4p3lkiq4FTRS+35E+xSB
         ZxeFlTzB7sqBiI5Ezfe5vkMpN9x8ua9OcZgnncUFnqlgcbcSs00Qh2ry6ZkIAnb9dW
         gZ5JpVr0cPpGEGNptdmEKStdkqIX1VcWm2GJ+rxQ7iDvzwnbH2R29u6L73wHQtWSya
         QL5luJwfQ/EFaaXJICz5uPXgFVvVoWAxNq36PlpDcTsduc1wAErfOgBge2dDHbScDn
         FuESHpgGscoW5qg3IxFBqeEyu8XOqz9QWSCZHnoxiPXUOS1CRYnFZPVbJPTtNHUuzH
         PcvFZwuk7K2Hg==
X-Virus-Scanned: amavisd-new at dalakolonin.se
Received: from zimbra.dalakolonin.se ([127.0.0.1])
        by localhost (zimbra.dalakolonin.se [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id XovZAKi-2bup; Sat,  8 Apr 2023 11:46:41 +0000 (UTC)
Received: from rack-server-1.dalakolonin.se (unknown [172.17.0.1])
        by zimbra.dalakolonin.se (Postfix) with ESMTPSA id C0F7995F14;
        Sat,  8 Apr 2023 11:46:41 +0000 (UTC)
From:   =?UTF-8?q?Patrik=20Dahlstr=C3=B6m?= <risca@dalakolonin.se>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org,
        kernel@pyra-handheld.com, pgoudagunta@nvidia.com,
        hns@goldelico.com, jic23@kernel.org, lars@metafoo.de,
        linux-omap@vger.kernel.org,
        =?UTF-8?q?Patrik=20Dahlstr=C3=B6m?= <risca@dalakolonin.se>
Subject: [PATCH v3 1/7] iio: adc: palmas: remove adc_wakeupX_data
Date:   Sat,  8 Apr 2023 13:46:18 +0200
Message-Id: <20230408114624.824144-2-risca@dalakolonin.se>
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

It does not seem to be used by anyone and later patches in this series
are made simpler by first removing this. There is now a lot of dead code
that cannot be reached, until later patches revive it. Arguably, this is
preferred over removing the code only to add it again.

Signed-off-by: Patrik Dahlstr=C3=B6m <risca@dalakolonin.se>
---
 drivers/iio/adc/palmas_gpadc.c | 50 ++++------------------------------
 include/linux/mfd/palmas.h     |  8 ------
 2 files changed, 6 insertions(+), 52 deletions(-)

diff --git a/drivers/iio/adc/palmas_gpadc.c b/drivers/iio/adc/palmas_gpad=
c.c
index 2921186458e0..03af6cd73ec8 100644
--- a/drivers/iio/adc/palmas_gpadc.c
+++ b/drivers/iio/adc/palmas_gpadc.c
@@ -76,6 +76,12 @@ static struct palmas_gpadc_info palmas_gpadc_info[] =3D=
 {
 	PALMAS_ADC_INFO(IN15, 0, 0, 0, 0, INVALID, INVALID, true),
 };
=20
+struct palmas_adc_wakeup_property {
+	int adc_channel_number;
+	int adc_high_threshold;
+	int adc_low_threshold;
+};
+
 /*
  * struct palmas_gpadc - the palmas_gpadc structure
  * @ch0_current:	channel 0 current source setting
@@ -493,11 +499,6 @@ static int palmas_gpadc_get_adc_dt_data(struct platf=
orm_device *pdev,
 	return 0;
 }
=20
-static void palmas_disable_wakeup(void *dev)
-{
-	device_wakeup_disable(dev);
-}
-
 static int palmas_gpadc_probe(struct platform_device *pdev)
 {
 	struct palmas_gpadc *adc;
@@ -548,36 +549,6 @@ static int palmas_gpadc_probe(struct platform_device=
 *pdev)
 		return dev_err_probe(adc->dev, ret,
 				     "request irq %d failed\n", adc->irq);
=20
-	if (gpadc_pdata->adc_wakeup1_data) {
-		memcpy(&adc->wakeup1_data, gpadc_pdata->adc_wakeup1_data,
-			sizeof(adc->wakeup1_data));
-		adc->wakeup1_enable =3D true;
-		adc->irq_auto_0 =3D  platform_get_irq(pdev, 1);
-		ret =3D devm_request_threaded_irq(&pdev->dev, adc->irq_auto_0,
-						NULL, palmas_gpadc_irq_auto,
-						IRQF_ONESHOT,
-						"palmas-adc-auto-0", adc);
-		if (ret < 0)
-			return dev_err_probe(adc->dev, ret,
-					     "request auto0 irq %d failed\n",
-					     adc->irq_auto_0);
-	}
-
-	if (gpadc_pdata->adc_wakeup2_data) {
-		memcpy(&adc->wakeup2_data, gpadc_pdata->adc_wakeup2_data,
-				sizeof(adc->wakeup2_data));
-		adc->wakeup2_enable =3D true;
-		adc->irq_auto_1 =3D  platform_get_irq(pdev, 2);
-		ret =3D devm_request_threaded_irq(&pdev->dev, adc->irq_auto_1,
-						NULL, palmas_gpadc_irq_auto,
-						IRQF_ONESHOT,
-						"palmas-adc-auto-1", adc);
-		if (ret < 0)
-			return dev_err_probe(adc->dev, ret,
-					     "request auto1 irq %d failed\n",
-					     adc->irq_auto_1);
-	}
-
 	/* set the current source 0 (value 0/5/15/20 uA =3D> 0..3) */
 	if (gpadc_pdata->ch0_current <=3D 1)
 		adc->ch0_current =3D PALMAS_ADC_CH0_CURRENT_SRC_0;
@@ -617,15 +588,6 @@ static int palmas_gpadc_probe(struct platform_device=
 *pdev)
 			palmas_gpadc_calibrate(adc, i);
 	}
=20
-	if (adc->wakeup1_enable || adc->wakeup2_enable) {
-		device_wakeup_enable(&pdev->dev);
-		ret =3D devm_add_action_or_reset(&pdev->dev,
-					       palmas_disable_wakeup,
-					       &pdev->dev);
-		if (ret)
-			return ret;
-	}
-
 	return 0;
 }
=20
diff --git a/include/linux/mfd/palmas.h b/include/linux/mfd/palmas.h
index 117d02708439..eda1ffd99c1a 100644
--- a/include/linux/mfd/palmas.h
+++ b/include/linux/mfd/palmas.h
@@ -128,12 +128,6 @@ struct palmas_pmic_driver_data {
 			    struct regulator_config config);
 };
=20
-struct palmas_adc_wakeup_property {
-	int adc_channel_number;
-	int adc_high_threshold;
-	int adc_low_threshold;
-};
-
 struct palmas_gpadc_platform_data {
 	/* Channel 3 current source is only enabled during conversion */
 	int ch3_current;	/* 0: off; 1: 10uA; 2: 400uA; 3: 800 uA */
@@ -152,8 +146,6 @@ struct palmas_gpadc_platform_data {
 	int start_polarity;
=20
 	int auto_conversion_period_ms;
-	struct palmas_adc_wakeup_property *adc_wakeup1_data;
-	struct palmas_adc_wakeup_property *adc_wakeup2_data;
 };
=20
 struct palmas_reg_init {
--=20
2.25.1

