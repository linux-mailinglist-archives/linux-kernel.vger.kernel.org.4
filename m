Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1996D8989
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 23:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233855AbjDEVYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 17:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232680AbjDEVXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 17:23:48 -0400
Received: from ste-pvt-msa2.bahnhof.se (ste-pvt-msa2.bahnhof.se [213.80.101.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50930729F;
        Wed,  5 Apr 2023 14:23:33 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 5359E4111E;
        Wed,  5 Apr 2023 23:23:31 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Score: -2.099
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
Authentication-Results: ste-ftg-msa2.bahnhof.se (amavisd-new);
        dkim=pass (2048-bit key) header.d=dalakolonin.se
Received: from ste-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (ste-ftg-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id cLEjAgfxlFdL; Wed,  5 Apr 2023 23:23:30 +0200 (CEST)
Received: by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 90C05410A1;
        Wed,  5 Apr 2023 23:23:30 +0200 (CEST)
Authentication-Results: ste-pvt-msa2.bahnhof.se;
        dkim=pass (2048-bit key; unprotected) header.d=dalakolonin.se header.i=@dalakolonin.se header.b="BKU6KxXw";
        dkim-atps=neutral
Received: from localhost (localhost [127.0.0.1])
        by zimbra.dalakolonin.se (Postfix) with ESMTP id 5413094E54;
        Wed,  5 Apr 2023 21:23:29 +0000 (UTC)
Received: from zimbra.dalakolonin.se ([127.0.0.1])
        by localhost (zimbra.dalakolonin.se [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Eo1i7dPfeaZD; Wed,  5 Apr 2023 21:23:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.dalakolonin.se (Postfix) with ESMTP id 7942C94E10;
        Wed,  5 Apr 2023 21:23:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra.dalakolonin.se 7942C94E10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dalakolonin.se;
        s=D374B428-D0A7-11ED-A657-75977B426508; t=1680729792;
        bh=tdhqZ0SVQrHBM7Ty7175uvKzDgdZmch0EnHFXXlVQ9Y=;
        h=From:To:Date:Message-Id:MIME-Version;
        b=BKU6KxXw0q3BYRECa/VLJ1Qmqwt+nhDQzLXW90g1ooUpPlyzmn0clAgEe770Mlo93
         jtbmHgxFdwsJZBAUqhyNZFNulp0hcadwwWh/2gbMzN44iQU3PbWz6H8r+p0D7MOmbY
         KEIe0LrEfxrxWclWuGfoSSviQHRc37P1Qv0eb08yakFgRpQnVYVMA9cNjl3u0PGnhh
         phuGOkooSxFHzkOeBH9MOg/Zi8J5++wGFgy1ywboxJiXP6iIzCXQtZCyKVJyJlQsAI
         LiW1+yYriH7avPLH6c1MTmZBEb/7toDlZwOWAj3kPjRgqXxJNxChg3iae0w6a8P0TY
         5w1Vw6ko3+fyw==
X-Virus-Scanned: amavisd-new at dalakolonin.se
Received: from zimbra.dalakolonin.se ([127.0.0.1])
        by localhost (zimbra.dalakolonin.se [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 9C4YbUzBMhgc; Wed,  5 Apr 2023 21:23:12 +0000 (UTC)
Received: from rack-server-1.dalakolonin.se (unknown [172.17.0.1])
        by zimbra.dalakolonin.se (Postfix) with ESMTPSA id F225094E00;
        Wed,  5 Apr 2023 21:23:08 +0000 (UTC)
From:   =?UTF-8?q?Patrik=20Dahlstr=C3=B6m?= <risca@dalakolonin.se>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org,
        kernel@pyra-handheld.com, pgoudagunta@nvidia.com,
        hns@goldelico.com, jic23@kernel.org, lars@metafoo.de,
        linux-omap@vger.kernel.org,
        =?UTF-8?q?Patrik=20Dahlstr=C3=B6m?= <risca@dalakolonin.se>
Subject: [PATCH v3 7/7] iio: adc: palmas: don't alter event config on suspend/resume
Date:   Wed,  5 Apr 2023 23:22:33 +0200
Message-Id: <20230405212233.4167986-8-risca@dalakolonin.se>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230405212233.4167986-1-risca@dalakolonin.se>
References: <20230405212233.4167986-1-risca@dalakolonin.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The event config is controlled through the IIO events subsystem and
device wakeup is controlled by /sys/devices/.../power/wakeup. Let's keep
those two knobs independent.

Signed-off-by: Patrik Dahlstr=C3=B6m <risca@dalakolonin.se>
---
 drivers/iio/adc/palmas_gpadc.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/adc/palmas_gpadc.c b/drivers/iio/adc/palmas_gpad=
c.c
index 2e0755e9e3a4..ba3cc0e68197 100644
--- a/drivers/iio/adc/palmas_gpadc.c
+++ b/drivers/iio/adc/palmas_gpadc.c
@@ -1137,16 +1137,10 @@ static int palmas_gpadc_suspend(struct device *de=
v)
 {
 	struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
 	struct palmas_gpadc *adc =3D iio_priv(indio_dev);
-	int wakeup =3D adc->event0.enabled || adc->event1.enabled;
-	int ret;
=20
-	if (!device_may_wakeup(dev) || !wakeup)
+	if (!device_may_wakeup(dev))
 		return 0;
=20
-	ret =3D palmas_adc_configure_events(adc);
-	if (ret < 0)
-		return ret;
-
 	if (adc->event0.enabled)
 		enable_irq_wake(adc->irq_auto_0);
=20
@@ -1160,16 +1154,10 @@ static int palmas_gpadc_resume(struct device *dev=
)
 {
 	struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
 	struct palmas_gpadc *adc =3D iio_priv(indio_dev);
-	int wakeup =3D adc->event0.enabled || adc->event1.enabled;
-	int ret;
=20
-	if (!device_may_wakeup(dev) || !wakeup)
+	if (!device_may_wakeup(dev))
 		return 0;
=20
-	ret =3D palmas_adc_reset_events(adc);
-	if (ret < 0)
-		return ret;
-
 	if (adc->event0.enabled)
 		disable_irq_wake(adc->irq_auto_0);
=20
--=20
2.25.1

