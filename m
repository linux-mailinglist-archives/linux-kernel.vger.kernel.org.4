Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE80C6426DD
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 11:41:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbiLEKlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 05:41:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbiLEKlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 05:41:10 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACAFBBCAD
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 02:41:04 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id m19so8387298wms.5
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 02:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+puc7EehSj2l1wYCIAHi1SQ7iD7xNS5o4aYLSrDYx5I=;
        b=D4TMfQ78LyNXcaS0GDygRNPWw/l1RoccJb4kWCusR/c12TF3CHwn5+8B041WRmsv8a
         7sdTh+uteBGDYQxMUs65T/uTh9VbNFmOUGQR4Kxw7m4EfeYcioB8N8pskB41o36d04mn
         JxYxB1ZTlMjal1kf3GPFP2E7lOxg1ukh1OnJAzpeKZ25ic0sEUGPJodcB04CAWMFzWZs
         iM+BEQDblxWF+1xtsfFlx2qHotlugHXOTtazuXk/LOsMnf9GdyHx8Y1/fXGXIv68auh8
         +ovAK5Htg4UpbTaPBLK3bF+UNHTNL4FoE7cqO395sG4WdWfCQhULoYcju80J8xgcehos
         svDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+puc7EehSj2l1wYCIAHi1SQ7iD7xNS5o4aYLSrDYx5I=;
        b=yTF49xEu46dJCgz33zne5eUnGrbodaA85p7e/fImn8cskeV56CJ4BFhkczO+OFGqnS
         DBq/ey2MkF8zdv66i0MckENvqixS+a3bfg2zVMAV1cD1r8PThafdybQyUBpMNHUNQl1V
         3jpYqjhPFU43S6UfqC8MOsIHyLNvmf7fh9RT67PqBL2ojtc6CdWYvJNqZqjtpUY4ytOL
         IU3AvreEgr4ov0jqLmbkp0BMtqeX2TiV6Vemd2llMwAGDJvV7HxkafawJUmGsiZurRcQ
         mzYxo2o5ObsOeplVb5/z++bG/gAiWECVEGHBfHepsEbwYQvxbHYaZm6BJz7nTWwHi0xB
         oF4Q==
X-Gm-Message-State: ANoB5pkO5nJSlKRiHrlsKJJrg5Y8Z2T42B6BVn5sleMPvgoNSFZYDnvv
        7kVoRs1MXkvTU8x4dDzR+bTETA==
X-Google-Smtp-Source: AA0mqf4ZIrxBqTKxt2otvM8/XX6LTqqSsZuT5BLpT79uglDkq7o8t/uIRo+/18fAEpJ0EfAWBR7TQw==
X-Received: by 2002:a1c:f015:0:b0:3cf:7818:b123 with SMTP id a21-20020a1cf015000000b003cf7818b123mr63209276wmb.8.1670236863061;
        Mon, 05 Dec 2022 02:41:03 -0800 (PST)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id j9-20020a5d5649000000b0022cdeba3f83sm13685769wrw.84.2022.12.05.02.41.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Dec 2022 02:41:02 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 05 Dec 2022 11:41:00 +0100
Message-Id: <COTTJX635TNF.1WL2TEZN7VW9O@amjad-ThinkPad-T490>
To:     "Daniel Lezcano" <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Amit Kucheria" <amitk@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Zhang Rui" <rui.zhang@intel.com>
Cc:     "AngeloGioacchino Del Regno" 
        <angelogioacchino.delregno@collabora.com>,
        "Fabien Parent" <fparent@baylibre.com>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        "Markus Schneider-Pargmann" <msp@baylibre.com>,
        <linux-pm@vger.kernel.org>, "Rob Herring" <robh@kernel.org>,
        "Michael Kao" <michael.kao@mediatek.com>,
        <linux-kernel@vger.kernel.org>,
        "Hsin-Yi Wang" <hsinyi@chromium.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v7 4/4] thermal: mediatek: add another get_temp ops for
 thermal sensors
From:   "Amjad Ouled-Ameur" <aouledameur@baylibre.com>
X-Mailer: aerc 0.13.0-78-g9db3710dd73b
References: <20221018-up-i350-thermal-bringup-v7-0-ebf08ff2eddb@baylibre.com> <20221018-up-i350-thermal-bringup-v7-4-ebf08ff2eddb@baylibre.com> <4121bb6b-30db-7a23-f4c8-40afdda7a0b5@linaro.org>
In-Reply-To: <4121bb6b-30db-7a23-f4c8-40afdda7a0b5@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,
On Sun Dec 4, 2022 at 6:26 PM CET, Daniel Lezcano wrote:
> On 18/11/2022 12:04, Amjad Ouled-Ameur wrote:
> > Provide thermal zone to read thermal sensor in the SoC. We can read all=
 the
> > thermal sensors value in the SoC by the node /sys/class/thermal/
> >=20
> > In mtk_thermal_bank_temperature, return -EAGAIN instead of -EACCESS
> > on the first read of sensor that often are bogus values.
> > This can avoid following warning on boot:
> >=20
> >    thermal thermal_zone6: failed to read out thermal zone (-13)
> >=20
> > Signed-off-by: Michael Kao <michael.kao@mediatek.com>
> > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> > Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
> > Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> > ---
> >   drivers/thermal/mtk_thermal.c | 99 ++++++++++++++++++++++++++++++++--=
---------
> >   1 file changed, 74 insertions(+), 25 deletions(-)
> >=20
> > diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_therma=
l.c
> > index 3a5df1440822..b1f4d19edd4f 100644
> > --- a/drivers/thermal/mtk_thermal.c
> > +++ b/drivers/thermal/mtk_thermal.c
> > @@ -259,6 +259,11 @@ enum mtk_thermal_version {
> >  =20
> >   struct mtk_thermal;
> >  =20
> > +struct mtk_thermal_zone {
> > +	struct mtk_thermal *mt;
> > +	int id;
> > +};
> > +
> >   struct thermal_bank_cfg {
> >   	unsigned int num_sensors;
> >   	const int *sensors;
> > @@ -307,6 +312,8 @@ struct mtk_thermal {
> >  =20
> >   	const struct mtk_thermal_data *conf;
> >   	struct mtk_thermal_bank banks[MAX_NUM_ZONES];
> > +
> > +	int (*raw_to_mcelsius)(struct mtk_thermal *mt, int sensno, s32 raw);
> >   };
> >  =20
> >   /* MT8183 thermal sensor data */
> > @@ -709,6 +716,29 @@ static void mtk_thermal_put_bank(struct mtk_therma=
l_bank *bank)
> >   		mutex_unlock(&mt->lock);
> >   }
> >  =20
> > +static int _get_sensor_temp(struct mtk_thermal *mt, int id)
> > +{
> > +	u32 raw;
> > +	int temp;
> > +
> > +	const struct mtk_thermal_data *conf =3D mt->conf;
> > +
> > +	raw =3D readl(mt->thermal_base + conf->msr[id]);
> > +
> > +	temp =3D mt->raw_to_mcelsius(mt, id, raw);
> > +
> > +	/*
> > +	 * The first read of a sensor often contains very high bogus
> > +	 * temperature value. Filter these out so that the system does
> > +	 * not immediately shut down.
> > +	 */
> > +
> > +	if (temp > 200000)
> > +		return -EAGAIN;
> > +	else
> > +		return temp;
> > +}
> > +
> >   /**
> >    * mtk_thermal_bank_temperature - get the temperature of a bank
> >    * @bank:	The bank
> > @@ -721,26 +751,9 @@ static int mtk_thermal_bank_temperature(struct mtk=
_thermal_bank *bank)
> >   	struct mtk_thermal *mt =3D bank->mt;
> >   	const struct mtk_thermal_data *conf =3D mt->conf;
> >   	int i, temp =3D INT_MIN, max =3D INT_MIN;
> > -	u32 raw;
> >  =20
> >   	for (i =3D 0; i < conf->bank_data[bank->id].num_sensors; i++) {
> > -		raw =3D readl(mt->thermal_base + conf->msr[i]);
> > -
> > -		if (mt->conf->version =3D=3D MTK_THERMAL_V1) {
> > -			temp =3D raw_to_mcelsius_v1(
> > -				mt, conf->bank_data[bank->id].sensors[i], raw);
> > -		} else {
> > -			temp =3D raw_to_mcelsius_v2(
> > -				mt, conf->bank_data[bank->id].sensors[i], raw);
> > -		}
> > -
> > -		/*
> > -		 * The first read of a sensor often contains very high bogus
> > -		 * temperature value. Filter these out so that the system does
> > -		 * not immediately shut down.
> > -		 */
> > -		if (temp > 200000)
> > -			temp =3D 0;
> > +		temp =3D _get_sensor_temp(mt, i);
> >  =20
> >   		if (temp > max)
> >   			max =3D temp;
> > @@ -749,9 +762,10 @@ static int mtk_thermal_bank_temperature(struct mtk=
_thermal_bank *bank)
> >   	return max;
> >   }
> >  =20
> > -static int mtk_read_temp(struct thermal_zone_device *tz, int *temperat=
ure)
> > +static int mtk_read_temp(struct thermal_zone_device *tzdev, int *tempe=
rature)
> >   {
> > -	struct mtk_thermal *mt =3D tz->devdata;
> > +	struct mtk_thermal_zone *tz =3D tzdev->devdata;
> > +	struct mtk_thermal *mt =3D tz->mt;
> >   	int i;
> >   	int tempmax =3D INT_MIN;
> >  =20
> > @@ -770,10 +784,28 @@ static int mtk_read_temp(struct thermal_zone_devi=
ce *tz, int *temperature)
> >   	return 0;
> >   }
> >  =20
> > +static int mtk_read_sensor_temp(struct thermal_zone_device *tzdev, int=
 *temperature)
> > +{
> > +	struct mtk_thermal_zone *tz =3D tzdev->devdata;
> > +	struct mtk_thermal *mt =3D tz->mt;
> > +	int id =3D tz->id - 1;
> > +
> > +	if (id < 0)
> > +		return -EACCES;
> > +
> > +	*temperature =3D _get_sensor_temp(mt, id);
> > +
> > +	return 0;
> > +}
> > +
> >   static const struct thermal_zone_device_ops mtk_thermal_ops =3D {
> >   	.get_temp =3D mtk_read_temp,
> >   };
> >  =20
> > +static const struct thermal_zone_device_ops mtk_thermal_sensor_ops =3D=
 {
> > +	.get_temp =3D mtk_read_sensor_temp,
> > +};
> > +
> >   static void mtk_thermal_init_bank(struct mtk_thermal *mt, int num,
> >   				  u32 apmixed_phys_base, u32 auxadc_phys_base,
> >   				  int ctrl_id)
> > @@ -1072,6 +1104,7 @@ static int mtk_thermal_probe(struct platform_devi=
ce *pdev)
> >   	u64 auxadc_phys_base, apmixed_phys_base;
> >   	struct thermal_zone_device *tzdev;
> >   	void __iomem *apmixed_base, *auxadc_base;
> > +	struct mtk_thermal_zone *tz;
> >  =20
> >   	mt =3D devm_kzalloc(&pdev->dev, sizeof(*mt), GFP_KERNEL);
> >   	if (!mt)
> > @@ -1150,6 +1183,9 @@ static int mtk_thermal_probe(struct platform_devi=
ce *pdev)
> >  =20
> >   	mtk_thermal_turn_on_buffer(mt, apmixed_base);
> >  =20
> > +	mt->raw_to_mcelsius =3D (mt->conf->version =3D=3D MTK_THERMAL_V1) ?
> > +				raw_to_mcelsius_v1 : raw_to_mcelsius_v2;
> > +
> >   	if (mt->conf->version =3D=3D MTK_THERMAL_V2) {
> >   		mtk_thermal_release_periodic_ts(mt, auxadc_base);
> >   	}
> > @@ -1161,11 +1197,24 @@ static int mtk_thermal_probe(struct platform_de=
vice *pdev)
> >  =20
> >   	platform_set_drvdata(pdev, mt);
> >  =20
> > -	tzdev =3D devm_thermal_of_zone_register(&pdev->dev, 0, mt,
> > -					      &mtk_thermal_ops);
> > -	if (IS_ERR(tzdev)) {
> > -		ret =3D PTR_ERR(tzdev);
> > -		goto err_disable_clk_peri_therm;
> > +	for (i =3D 0; i < mt->conf->num_sensors + 1; i++) {
> > +		tz =3D devm_kmalloc(&pdev->dev, sizeof(*tz), GFP_KERNEL);
> > +		if (!tz)
> > +			return -ENOMEM;
> > +
> > +		tz->mt =3D mt;
> > +		tz->id =3D i;
> > +
> > +		tzdev =3D devm_thermal_of_zone_register(&pdev->dev, i, tz, (i =3D=3D=
 0) ?
> > +							     &mtk_thermal_ops :
> > +							     &mtk_thermal_sensor_ops);
>
> Here you use again the aggregation
I addressed this concern in V6, could you please take a look and let me
know what you think [0].

[0]: https://lore.kernel.org/all/5eb0cdc2-e9f9-dd42-bf80-b7dcd8bcc196@bayli=
bre.com/

Regards,
Amjad
>
> > +
> > +		if (IS_ERR(tzdev)) {
> > +			ret =3D PTR_ERR(tzdev);
> > +			if (ret =3D=3D -ENODEV)
> > +				continue;
> > +			goto err_disable_clk_peri_therm;
> > +		}
> >   	}
> >  =20
> >   	ret =3D devm_thermal_add_hwmon_sysfs(tzdev);
> >=20
>
> --=20
> <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for AR=
M SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog

