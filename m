Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B86B0602951
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 12:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbiJRK3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 06:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiJRK3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 06:29:14 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 179B2B3B27;
        Tue, 18 Oct 2022 03:29:12 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 44DEB5C00D9;
        Tue, 18 Oct 2022 06:29:10 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 18 Oct 2022 06:29:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1666088950; x=1666175350; bh=n/Zbi+VZv8PL4XGNXNoym9Ld2zzm
        MW3vQ0V8B/QhPt4=; b=PZ6y+XQavhSxLuPV/X+prIBxO9XpY39PIJ1kE2N68POW
        WVoIm8Xqu6u9A1ycfemAi9TGdAoy4D0W2T0E6xY8hI2MnSLMrURYesOnholM1WbD
        MqMr5E4q5jYuIR5rlFGgInYm/R4P1iL/JuQ10Qxe9CrmQxzkDUckl0gJWWkgMYGb
        K94QKBkTCSXkU+I7KcepMRl8Ja5CDixWeqwq8fIWG8k7fTkquaxk0RGBHvp1O5Bn
        26RRv6Jb0AcaoswTEsuekWT5xqI9LPcA3K8yqLkUIEN6QpsgbZSRd9aJQbnx5gow
        j3KKop7cLVFMVnLwSyL16VUgoLdtV9NCck4kjVRfkQ==
X-ME-Sender: <xms:9X9OY33b7Pa4Jc9xJwYH__909T8La2QMxUOz0KQp7KpKrc8V5MjKcA>
    <xme:9X9OY2HePfVJPkDS1EozCCglHfXQ_GUOE5HXoJm0adz3rCoiGAb5LNHD4t3wF1nW6
    9kcqtNLVdCebks>
X-ME-Received: <xmr:9X9OY34t7xdE9d7ldt7KoaeODkeEfx1hWydUPIRi-FEs1OZzrflnyzV-LPHqFromyXrlrkKI9FWGFdSkZAq-lQROPuio5A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeelvdcutefuodetggdotefrodftvfcurf
    hrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefkughoucfutghh
    ihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorhhgqeenucggtffrrghtthgvrh
    hnpedvudefveekheeugeeftddvveefgfduieefudeifefgleekheegleegjeejgeeghfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehiughosh
    gthhesihguohhstghhrdhorhhg
X-ME-Proxy: <xmx:9X9OY83-wIxVhLeG_EyJHB-76nU1yZ0nrr4YGFeZmVD33bCAed_UNA>
    <xmx:9X9OY6FvWDq3ERUQkW960f9Mj1vRGjW21B3FR2rnSihxdjHojzW5KQ>
    <xmx:9X9OY9_JRFNPV48ON3KtZegy_k7vGG7RBO6KQQUpxr2JBdOwRXKBzA>
    <xmx:9n9OYyR5URycp81hcuRzbR7BhMTU5nctiJiCnWmZHY2RghmvKZYURg>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Oct 2022 06:29:08 -0400 (EDT)
Date:   Tue, 18 Oct 2022 13:29:04 +0300
From:   Ido Schimmel <idosch@idosch.org>
To:     Daniel Lezcano <daniel.lezcano@linexp.org>
Cc:     daniel.lezcano@linaro.org, rafael@kernel.org, rui.zhang@intel.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, abailon@baylibre.com, lukasz.luba@arm.com,
        broonie@kernel.org, damien.lemoal@opensource.wdc.com,
        heiko@sntech.de, hayashi.kunihiko@socionext.com,
        mhiramat@kernel.org, talel@amazon.com, thierry.reding@gmail.com,
        digetx@gmail.com, jonathanh@nvidia.com, anarsoul@gmail.com,
        tiny.windzz@gmail.com, baolin.wang7@gmail.com,
        f.fainelli@gmail.com, bjorn.andersson@linaro.org,
        mcoquelin.stm32@gmail.com, glaroque@baylibre.com,
        miquel.raynal@bootlin.com, shawnguo@kernel.org,
        niklas.soderlund@ragnatech.se, matthias.bgg@gmail.com,
        j-keerthy@ti.com, Amit Kucheria <amitk@kernel.org>
Subject: Re: [PATCH v5 01/33] thermal/of: Rework the thermal device tree
 initialization
Message-ID: <Y05/8JUU+3kLCZvb@shredder>
References: <20220804224349.1926752-1-daniel.lezcano@linexp.org>
 <20220804224349.1926752-2-daniel.lezcano@linexp.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220804224349.1926752-2-daniel.lezcano@linexp.org>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05, 2022 at 12:43:17AM +0200, Daniel Lezcano wrote:
> +struct thermal_zone_device *thermal_of_zone_register(struct device_node *sensor, int id, void *data,
> +						     const struct thermal_zone_device_ops *ops)
> +{
> +	struct thermal_zone_device *tz;
> +	struct thermal_trip *trips;
> +	struct thermal_zone_params *tzp;
> +	struct thermal_zone_device_ops *of_ops;
> +	struct device_node *np;
> +	int delay, pdelay;
> +	int ntrips, mask;
> +	int ret;
> +
> +	of_ops = kmemdup(ops, sizeof(*ops), GFP_KERNEL);
> +	if (!of_ops)
> +		return ERR_PTR(-ENOMEM);
> +	
> +	np = of_thermal_zone_find(sensor, id);
> +	if (IS_ERR(np)) {
> +		pr_err("Failed to find thermal zone for %pOFn id=%d\n", sensor, id);
> +		return ERR_CAST(np);
> +	}
> +
> +	trips = thermal_of_trips_init(np, &ntrips);
> +	if (IS_ERR(trips)) {
> +		pr_err("Failed to find trip points for %pOFn id=%d\n", sensor, id);
> +		return ERR_CAST(trips);
> +	}
> +
> +	ret = thermal_of_monitor_init(np, &delay, &pdelay);
> +	if (ret) {
> +		pr_err("Failed to initialize monitoring delays from %pOFn\n", np);
> +		goto out_kfree_trips;
> +	}
> +
> +	tzp = thermal_of_parameters_init(np);
> +	if (IS_ERR(tzp)) {
> +		ret = PTR_ERR(tzp);
> +		pr_err("Failed to initialize parameter from %pOFn: %d\n", np, ret);
> +		goto out_kfree_trips;
> +	}
> +
> +	of_ops->get_trip_type = of_ops->get_trip_type ? : of_thermal_get_trip_type;
> +	of_ops->get_trip_temp = of_ops->get_trip_temp ? : of_thermal_get_trip_temp;
> +	of_ops->get_trip_hyst = of_ops->get_trip_hyst ? : of_thermal_get_trip_hyst;
> +	of_ops->set_trip_hyst = of_ops->set_trip_hyst ? : of_thermal_set_trip_hyst;
> +	of_ops->get_crit_temp = of_ops->get_crit_temp ? : of_thermal_get_crit_temp;
> +	of_ops->bind = thermal_of_bind;
> +	of_ops->unbind = thermal_of_unbind;
> +
> +	mask = GENMASK_ULL((ntrips) - 1, 0);
> +
> +	tz = thermal_zone_device_register_with_trips(np->name, trips, ntrips,
> +						     mask, data, of_ops, tzp,
> +						     pdelay, delay);
> +	if (IS_ERR(tz)) {
> +		ret = PTR_ERR(tz);
> +		pr_err("Failed to register thermal zone %pOFn: %d\n", np, ret);
> +		goto out_kfree_tzp;
> +	}
> +
> +	ret = thermal_zone_device_enable(tz);
> +	if (ret) {
> +		pr_err("Failed to enabled thermal zone '%s', id=%d: %d\n",
> +		       tz->type, tz->id, ret);
> +		thermal_of_zone_unregister(tz);
> +		return ERR_PTR(ret);
> +	}
> +
> +	return tz;
> +
> +out_kfree_tzp:
> +	kfree(tzp);
> +out_kfree_trips:
> +	kfree(trips);
> +
> +	return ERR_PTR(ret);
> +}
> +EXPORT_SYMBOL_GPL(thermal_of_zone_register);

Daniel, I started seeing these memory leaks [1] since commit
613ed3f67609 ("hwmon: pm_bus: core: Switch to new of thermal API").
Seems to be fixed by the following patch [2].

Do you already have a patch for this issue or should I submit it?

Thanks

[1]
unreferenced object 0xffff8ee846198c80 (size 128):
  comm "swapper/0", pid 1, jiffies 4294699704 (age 70.076s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    d0 3f 6e 8c ff ff ff ff 00 00 00 00 00 00 00 00  .?n.............
  backtrace:
    [<00000000d136f562>] __kmalloc_node_track_caller+0x42/0x120
    [<0000000063f31678>] kmemdup+0x1d/0x40
    [<00000000e6d24096>] thermal_of_zone_register+0x49/0x520
    [<000000005e78c755>] devm_thermal_of_zone_register+0x54/0x90
    [<00000000ee6b209e>] pmbus_add_sensor+0x1b4/0x1d0
    [<00000000896105e3>] pmbus_add_sensor_attrs_one+0x123/0x440
    [<0000000049e990a6>] pmbus_add_sensor_attrs+0xfe/0x1d0
    [<00000000466b5440>] pmbus_do_probe+0x66b/0x14e0
    [<0000000084d42285>] i2c_device_probe+0x13b/0x2f0
    [<0000000029e2ae74>] really_probe+0xce/0x2c0
    [<00000000692df15c>] driver_probe_device+0x19/0xd0
    [<00000000547d9cce>] __device_attach_driver+0x6f/0x100
    [<0000000020abd24b>] bus_for_each_drv+0x76/0xc0
    [<00000000665d9563>] __device_attach+0xfc/0x180
    [<000000008ddd4d6a>] bus_probe_device+0x82/0xa0
    [<000000009e61132b>] device_add+0x3fe/0x920
unreferenced object 0xffff8ee846199200 (size 128):
  comm "swapper/0", pid 1, jiffies 4294699710 (age 70.070s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    d0 3f 6e 8c ff ff ff ff 00 00 00 00 00 00 00 00  .?n.............
  backtrace:
    [<00000000d136f562>] __kmalloc_node_track_caller+0x42/0x120
    [<0000000063f31678>] kmemdup+0x1d/0x40
    [<00000000e6d24096>] thermal_of_zone_register+0x49/0x520
    [<000000005e78c755>] devm_thermal_of_zone_register+0x54/0x90
    [<00000000ee6b209e>] pmbus_add_sensor+0x1b4/0x1d0
    [<00000000896105e3>] pmbus_add_sensor_attrs_one+0x123/0x440
    [<0000000049e990a6>] pmbus_add_sensor_attrs+0xfe/0x1d0
    [<00000000466b5440>] pmbus_do_probe+0x66b/0x14e0
    [<0000000084d42285>] i2c_device_probe+0x13b/0x2f0
    [<0000000029e2ae74>] really_probe+0xce/0x2c0
    [<00000000692df15c>] driver_probe_device+0x19/0xd0
    [<00000000547d9cce>] __device_attach_driver+0x6f/0x100
    [<0000000020abd24b>] bus_for_each_drv+0x76/0xc0
    [<00000000665d9563>] __device_attach+0xfc/0x180
    [<000000008ddd4d6a>] bus_probe_device+0x82/0xa0
    [<000000009e61132b>] device_add+0x3fe/0x920
unreferenced object 0xffff8ee846199780 (size 128):
  comm "swapper/0", pid 1, jiffies 4294699716 (age 70.064s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    d0 3f 6e 8c ff ff ff ff 00 00 00 00 00 00 00 00  .?n.............
  backtrace:
    [<00000000d136f562>] __kmalloc_node_track_caller+0x42/0x120
    [<0000000063f31678>] kmemdup+0x1d/0x40
    [<00000000e6d24096>] thermal_of_zone_register+0x49/0x520
    [<000000005e78c755>] devm_thermal_of_zone_register+0x54/0x90
    [<00000000ee6b209e>] pmbus_add_sensor+0x1b4/0x1d0
    [<00000000896105e3>] pmbus_add_sensor_attrs_one+0x123/0x440
    [<0000000049e990a6>] pmbus_add_sensor_attrs+0xfe/0x1d0
    [<00000000466b5440>] pmbus_do_probe+0x66b/0x14e0
    [<0000000084d42285>] i2c_device_probe+0x13b/0x2f0
    [<0000000029e2ae74>] really_probe+0xce/0x2c0
    [<00000000692df15c>] driver_probe_device+0x19/0xd0
    [<00000000547d9cce>] __device_attach_driver+0x6f/0x100
    [<0000000020abd24b>] bus_for_each_drv+0x76/0xc0
    [<00000000665d9563>] __device_attach+0xfc/0x180
    [<000000008ddd4d6a>] bus_probe_device+0x82/0xa0
    [<000000009e61132b>] device_add+0x3fe/0x920

[2]
diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index d4b6335ace15..43d55c29a29a 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -604,13 +604,15 @@ struct thermal_zone_device *thermal_of_zone_register(struct device_node *sensor,
        if (IS_ERR(np)) {
                if (PTR_ERR(np) != -ENODEV)
                        pr_err("Failed to find thermal zone for %pOFn id=%d\n", sensor, id);
-               return ERR_CAST(np);
+               ret = PTR_ERR(np);
+               goto out_kfree_of_ops;
        }
 
        trips = thermal_of_trips_init(np, &ntrips);
        if (IS_ERR(trips)) {
                pr_err("Failed to find trip points for %pOFn id=%d\n", sensor, id);
-               return ERR_CAST(trips);
+               ret = PTR_ERR(np);
+               goto out_kfree_of_ops;
        }
 
        ret = thermal_of_monitor_init(np, &delay, &pdelay);
@@ -659,6 +661,8 @@ struct thermal_zone_device *thermal_of_zone_register(struct device_node *sensor,
        kfree(tzp);
 out_kfree_trips:
        kfree(trips);
+out_kfree_of_ops:
+       kfree(of_ops);
 
        return ERR_PTR(ret);
 }
