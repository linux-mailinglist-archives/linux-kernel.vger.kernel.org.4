Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62AB46D4E93
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 19:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233052AbjDCRBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 13:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231730AbjDCRBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 13:01:43 -0400
X-Greylist: delayed 361 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 03 Apr 2023 10:01:41 PDT
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFACFEC;
        Mon,  3 Apr 2023 10:01:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1680540578; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=JZCEDBqe94ZP+XqIriJZ9uXVomODIgXyqxwS8soNUd+f9GhPpFdeE/SXyTTIFXa0Xj
    T/T3/8cotjDzA1bM8actFKRfgtiDSWqBeNCgIcjJui04H7ZoutCv53GMvqSvPRtMwIDx
    neDm0UBZ18vFOnVjvwVdC3p40fgpPN0Qn52nIdgAC8b+OLgftcAFy5cRj92sDeMxoSzI
    oh0CVu29QPbQvAhtM0NiDRQtQeG/VpsbY0kty2kiidW5MV3LKitCM9/PMeySkpXSMUE+
    r3Lj3wZJWeng+F+z37Ua0TaLqApxQfe8dizuSwPuP9PkJezptHejQqtsB6efA2oJjCJl
    bOzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1680540578;
    s=strato-dkim-0002; d=strato.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=KSDue1p+VZ4KJNR/gP4suPyEpJHTiWImzDH5HEo47SU=;
    b=hu/xe9sFUw0clqQLDtC4bYCRbCzkuHRobuzDAP1gxhB4PQGXrnlP4cj+SVJ+KDW1FJ
    eMXr3p2Th/IFfjl81pZkHvaMFRyVPPrTOvBTGPLv+mwrGhySo7OBQw1aiLYDTYjZ9IDq
    jNZpvcBScbli7X04m+GJRcvr7C4hYH/sZK6dAPZepnPGDnP752KQXMoOZ2VuiDFiNmk1
    ZXujvkt3xqQFxZFAqCTEsnxYfriTuW0l7H89XpmjTDgydC/GWSCc7pCpBbL1kdDpvkX/
    Bs+dh7blyUTIAQOWQzsvdh4167gE+9I85fqvhwWg57Hdo0PDGft06E1KK97ULyHu1lXw
    tFJw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1680540578;
    s=strato-dkim-0002; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=KSDue1p+VZ4KJNR/gP4suPyEpJHTiWImzDH5HEo47SU=;
    b=cO5xUHnF7ezpPDzISHKDwgEMxGdBaip7ULpF/GlLF/BYS7DnQC7DTRjvpvyIPVU1o7
    MLsiCSNsbGJlPzRYW20jsZTPKoaMeLuVKPydzTCdzKFPSfeKH1klrnWRwaQzHEsj/lMg
    KCUIxEKgK2yIHyzbMaCXrKt276TzNdlDWExurlXyNgfuJO8ykJtplggdiraTuk7aFsPH
    2OAmLzMyBACczjz43AoZEX4CxlP9sqNtxP8tbitsyxa21Yko9XiFEH4rWQjZfGr3tnms
    TXPwHho5AlSz6pQfuG2SAGWAHeVAkUhXCI3zpQBNPQhvOYe/AL16vJm8dmv8ZHa6wuxJ
    bUxQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1680540578;
    s=strato-dkim-0003; d=goldelico.com;
    h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=KSDue1p+VZ4KJNR/gP4suPyEpJHTiWImzDH5HEo47SU=;
    b=zIJDepv/2+iWSrU0G6sBAC2zWD6JY19BJza19zwpEZea8J++xTgYbEscTfhLOiBXzS
    zKQxz0/9chqCiH0hvnBQ==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj5Apz9PSN6LgsXcGYk/8="
Received: from imac.fritz.box
    by smtp.strato.de (RZmta 49.4.0 DYNA|AUTH)
    with ESMTPSA id C9fe35z33Gnc0HT
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
    Mon, 3 Apr 2023 18:49:38 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.21\))
Subject: Re: [PATCH v2 1/7] iio: adc: palmas: remove adc_wakeupX_data
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20230402164247.3089146-2-risca@dalakolonin.se>
Date:   Mon, 3 Apr 2023 18:49:36 +0200
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        letux-kernel@openphoenux.org, kernel@pyra-handheld.com,
        pgoudagunta@nvidia.com, jic23@kernel.org, lars@metafoo.de,
        linux-omap@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <ED6919A6-CE57-4C31-9AE5-2C31D288A810@goldelico.com>
References: <20230402164247.3089146-1-risca@dalakolonin.se>
 <20230402164247.3089146-2-risca@dalakolonin.se>
To:     =?utf-8?Q?Patrik_Dahlstr=C3=B6m?= <risca@dalakolonin.se>
X-Mailer: Apple Mail (2.3445.104.21)
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Patrik,

> Am 02.04.2023 um 18:42 schrieb Patrik Dahlstr=C3=B6m =
<risca@dalakolonin.se>:
>=20
> It does not seem to be used by anyone and later patches in this series
> are made simpler by first removing this. There is now a lot of dead =
code
> that cannot be reached, until later patches revive it. Arguably, this =
is
> preferred over removing the code only to add it again.
>=20
> Signed-off-by: Patrik Dahlstr=C3=B6m <risca@dalakolonin.se>
> ---
> drivers/iio/adc/palmas_gpadc.c | 50 ++++------------------------------
> include/linux/mfd/palmas.h     |  8 ------
> 2 files changed, 6 insertions(+), 52 deletions(-)
>=20
> diff --git a/drivers/iio/adc/palmas_gpadc.c =
b/drivers/iio/adc/palmas_gpadc.c
> index 24d7c096e4b8..943ac579eb1f 100644
> --- a/drivers/iio/adc/palmas_gpadc.c
> +++ b/drivers/iio/adc/palmas_gpadc.c
> @@ -76,6 +76,12 @@ static struct palmas_gpadc_info palmas_gpadc_info[] =
=3D {
> 	PALMAS_ADC_INFO(IN15, 0, 0, 0, 0, INVALID, INVALID, true),
> };
>=20
> +struct palmas_adc_wakeup_property {
> +	int adc_channel_number;
> +	int adc_high_threshold;
> +	int adc_low_threshold;
> +};
> +
> /*
>  * struct palmas_gpadc - the palmas_gpadc structure
>  * @ch0_current:	channel 0 current source setting
> @@ -492,11 +498,6 @@ static int palmas_gpadc_get_adc_dt_data(struct =
platform_device *pdev,
> 	return 0;
> }
>=20
> -static void palmas_disable_wakeup(void *dev)

something seems to be mixed up here.

There is no palmas_disable_wakeup() upstream that can be removed. So =
this patch
can not be applied as 1/7 to any upstream kernel.

Please rebase your series on either linus/master or linux-next/master.

BR,
Nikolaus

> -{
> -	device_wakeup_disable(dev);
> -}
> -
> static int palmas_gpadc_probe(struct platform_device *pdev)
> {
> 	struct palmas_gpadc *adc;
> @@ -547,36 +548,6 @@ static int palmas_gpadc_probe(struct =
platform_device *pdev)
> 		return dev_err_probe(adc->dev, ret,
> 				     "request irq %d failed\n", =
adc->irq);
>=20
> -	if (gpadc_pdata->adc_wakeup1_data) {
> -		memcpy(&adc->wakeup1_data, =
gpadc_pdata->adc_wakeup1_data,
> -			sizeof(adc->wakeup1_data));
> -		adc->wakeup1_enable =3D true;
> -		adc->irq_auto_0 =3D  platform_get_irq(pdev, 1);
> -		ret =3D devm_request_threaded_irq(&pdev->dev, =
adc->irq_auto_0,
> -						NULL, =
palmas_gpadc_irq_auto,
> -						IRQF_ONESHOT,
> -						"palmas-adc-auto-0", =
adc);
> -		if (ret < 0)
> -			return dev_err_probe(adc->dev, ret,
> -					     "request auto0 irq %d =
failed\n",
> -					     adc->irq_auto_0);
> -	}
> -
> -	if (gpadc_pdata->adc_wakeup2_data) {
> -		memcpy(&adc->wakeup2_data, =
gpadc_pdata->adc_wakeup2_data,
> -				sizeof(adc->wakeup2_data));
> -		adc->wakeup2_enable =3D true;
> -		adc->irq_auto_1 =3D  platform_get_irq(pdev, 2);
> -		ret =3D devm_request_threaded_irq(&pdev->dev, =
adc->irq_auto_1,
> -						NULL, =
palmas_gpadc_irq_auto,
> -						IRQF_ONESHOT,
> -						"palmas-adc-auto-1", =
adc);
> -		if (ret < 0)
> -			return dev_err_probe(adc->dev, ret,
> -					     "request auto1 irq %d =
failed\n",
> -					     adc->irq_auto_1);
> -	}
> -
> 	/* set the current source 0 (value 0/5/15/20 uA =3D> 0..3) */
> 	if (gpadc_pdata->ch0_current <=3D 1)
> 		adc->ch0_current =3D PALMAS_ADC_CH0_CURRENT_SRC_0;
> @@ -616,15 +587,6 @@ static int palmas_gpadc_probe(struct =
platform_device *pdev)
> 			palmas_gpadc_calibrate(adc, i);
> 	}
>=20
> -	if (adc->wakeup1_enable || adc->wakeup2_enable) {
> -		device_wakeup_enable(&pdev->dev);
> -		ret =3D devm_add_action_or_reset(&pdev->dev,
> -					       palmas_disable_wakeup,
> -					       &pdev->dev);
> -		if (ret)
> -			return ret;
> -	}
> -
> 	return 0;
> }
>=20
> diff --git a/include/linux/mfd/palmas.h b/include/linux/mfd/palmas.h
> index 1e61c7e9f50d..55f22adb1a9e 100644
> --- a/include/linux/mfd/palmas.h
> +++ b/include/linux/mfd/palmas.h
> @@ -129,12 +129,6 @@ struct palmas_pmic_driver_data {
> 			    struct regulator_config config);
> };
>=20
> -struct palmas_adc_wakeup_property {
> -	int adc_channel_number;
> -	int adc_high_threshold;
> -	int adc_low_threshold;
> -};
> -
> struct palmas_gpadc_platform_data {
> 	/* Channel 3 current source is only enabled during conversion */
> 	int ch3_current;	/* 0: off; 1: 10uA; 2: 400uA; 3: 800 uA =
*/
> @@ -153,8 +147,6 @@ struct palmas_gpadc_platform_data {
> 	int start_polarity;
>=20
> 	int auto_conversion_period_ms;
> -	struct palmas_adc_wakeup_property *adc_wakeup1_data;
> -	struct palmas_adc_wakeup_property *adc_wakeup2_data;
> };
>=20
> struct palmas_reg_init {
> --=20
> 2.25.1
>=20

