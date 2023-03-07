Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C01616AE121
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 14:49:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbjCGNtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 08:49:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbjCGNsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 08:48:45 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 147F983895;
        Tue,  7 Mar 2023 05:47:42 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 327DlSLh050148;
        Tue, 7 Mar 2023 07:47:28 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1678196848;
        bh=SK8LF2YieqOxb+9pM44sEMrLQlozFKt0sw/cyRAA+iI=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=QQhWtqZdIDFiFzNDNMrMeDAGi27SgzEZtI5fwCKnOdpAzPKItEhkltRgluimtGD7z
         vusQZx9+HtzOUaTq7S/htD3mP9aQS1VbZeTDJT61VJKNgx3uSifa+AuhG1Bz7GIsUs
         d2HbZBUMz1oE6w+aN/OvBCS15IiWniYnv1hdHwBY=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 327DlSBO068610
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 7 Mar 2023 07:47:28 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 7
 Mar 2023 07:47:28 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 7 Mar 2023 07:47:28 -0600
Received: from [10.250.174.229] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 327DlNEC081802;
        Tue, 7 Mar 2023 07:47:24 -0600
Message-ID: <d6ef0ff1-f8db-c945-99c2-268cded9da8c@ti.com>
Date:   Tue, 7 Mar 2023 19:17:23 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v1 06/11] thermal/drivers/ti: Use fixed update interval
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, <rafael@kernel.org>
CC:     <rui.zhang@intel.com>, <amitk@kernel.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        "open list:TI BANDGAP AND THERMAL DRIVER" <linux-pm@vger.kernel.org>,
        "open list:TI BANDGAP AND THERMAL DRIVER" 
        <linux-omap@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20230307133735.90772-1-daniel.lezcano@linaro.org>
 <20230307133735.90772-7-daniel.lezcano@linaro.org>
From:   "J, KEERTHY" <j-keerthy@ti.com>
In-Reply-To: <20230307133735.90772-7-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/7/2023 7:07 PM, Daniel Lezcano wrote:
> Currently the TI thermal driver sets the sensor update interval based
> on the polling of the thermal zone. In order to get the polling rate,
> the code inspects the thermal zone device strcuture internals, thus
> breaking the self-encapsulation of the thermal framework core
> framework.
> 
> On the other side, we see the common polling rates set in the device
> tree for the platforms using this driver are 500 or 1000 ms.
> 
> Setting the polling rate to 250 ms would be far enough to cover the
> combination we found in the device tree.
> 
> Instead of accessing the thermal zone device structure polling rate,
> let's use a common update interval of 250 ms for the driver.

Thanks for the patch.

Acked-by: Keerthy <j-keerthy@ti.com>

> 
> Cc: Keerthy <j-keerthy@ti.com>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>   drivers/thermal/ti-soc-thermal/ti-thermal-common.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
> index 0c8914017c18..430c4b43151f 100644
> --- a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
> +++ b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
> @@ -23,6 +23,8 @@
>   #include "ti-bandgap.h"
>   #include "../thermal_hwmon.h"
>   
> +#define TI_BANDGAP_UPDATE_INTERVAL_MS 250
> +
>   /* common data structures */
>   struct ti_thermal_data {
>   	struct cpufreq_policy *policy;
> @@ -159,7 +161,6 @@ int ti_thermal_expose_sensor(struct ti_bandgap *bgp, int id,
>   			     char *domain)
>   {
>   	struct ti_thermal_data *data;
> -	int interval;
>   
>   	data = ti_bandgap_get_sensor_data(bgp, id);
>   
> @@ -177,10 +178,9 @@ int ti_thermal_expose_sensor(struct ti_bandgap *bgp, int id,
>   		return PTR_ERR(data->ti_thermal);
>   	}
>   
> -	interval = jiffies_to_msecs(data->ti_thermal->polling_delay_jiffies);
> -
>   	ti_bandgap_set_sensor_data(bgp, id, data);
> -	ti_bandgap_write_update_interval(bgp, data->sensor_id, interval);
> +	ti_bandgap_write_update_interval(bgp, data->sensor_id,
> +					 TI_BANDGAP_UPDATE_INTERVAL_MS);
>   
>   	if (devm_thermal_add_hwmon_sysfs(bgp->dev, data->ti_thermal))
>   		dev_warn(bgp->dev, "failed to add hwmon sysfs attributes\n");
