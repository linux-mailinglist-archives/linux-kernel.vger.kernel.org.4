Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC8672E36C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 14:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238734AbjFMM4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 08:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239139AbjFMM4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 08:56:32 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 135EF1734;
        Tue, 13 Jun 2023 05:56:30 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 35DCtlqE086407;
        Tue, 13 Jun 2023 07:55:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1686660947;
        bh=m3aWRYVccVyv3TBm3CQBhQSLQ8Afh0rwU1mPnybKOSM=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=YbXTTZrIY+UGenKDmM/cnVARAJ7p9b2bkDm1ar7gDhRT7bIkCvpkwibosjYvgjLae
         63bZObWKZFTzLmbfN45ZlZJrDJ8wPl/j5e2se5bX19Uned4epzQ4Vb8vWd/pz3VDRN
         bBdHMeZYl0QWiJWF/oAMLaC8k8N6YWMk5xGFlFcU=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 35DCtlO3121434
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 13 Jun 2023 07:55:47 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 13
 Jun 2023 07:55:47 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 13 Jun 2023 07:55:47 -0500
Received: from [10.250.64.104] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 35DCtZPm112555;
        Tue, 13 Jun 2023 07:55:36 -0500
Message-ID: <4ee9c4dc-7dfc-3cb8-089d-c1535ab2531c@ti.com>
Date:   Tue, 13 Jun 2023 18:25:34 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v3 08/12] thermal/drivers/ti-soc: remove redundant msg in
 ti_thermal_expose_sensor()
To:     Yangtao Li <frank.li@vivo.com>, <glaroque@baylibre.com>,
        <rafael@kernel.org>, <daniel.lezcano@linaro.org>,
        <amitk@kernel.org>, <rui.zhang@intel.com>, <shawnguo@kernel.org>,
        <s.hauer@pengutronix.de>, <kernel@pengutronix.de>,
        <festevam@gmail.com>, <linux-imx@nxp.com>,
        <thara.gopinath@gmail.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <anarsoul@gmail.com>, <tiny.windzz@gmail.com>, <wens@csie.org>,
        <jernej.skrabec@gmail.com>, <samuel@sholland.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <edubezval@gmail.com>, <matthias.bgg@gmail.com>,
        <angelogioacchino.delregno@collabora.com>, <bchihi@baylibre.com>,
        <niklas.soderlund+renesas@ragnatech.se>, <wenst@chromium.org>
CC:     <linux-pm@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-sunxi@lists.linux.dev>,
        <linux-tegra@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
References: <20230613114904.15749-1-frank.li@vivo.com>
 <20230613114904.15749-8-frank.li@vivo.com>
Content-Language: en-US
From:   "J, KEERTHY" <j-keerthy@ti.com>
In-Reply-To: <20230613114904.15749-8-frank.li@vivo.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/13/2023 5:19 PM, Yangtao Li wrote:
> The upper-layer devm_thermal_add_hwmon_sysfs() function can directly
> print error information.

Acked-by: Keerthy <j-keerthy@ti.com>

> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>   drivers/thermal/ti-soc-thermal/ti-thermal-common.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
> index 6a5335931f4d..d414a4b7a94a 100644
> --- a/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
> +++ b/drivers/thermal/ti-soc-thermal/ti-thermal-common.c
> @@ -182,8 +182,7 @@ int ti_thermal_expose_sensor(struct ti_bandgap *bgp, int id,
>   	ti_bandgap_write_update_interval(bgp, data->sensor_id,
>   					 TI_BANDGAP_UPDATE_INTERVAL_MS);
>   
> -	if (devm_thermal_add_hwmon_sysfs(bgp->dev, data->ti_thermal))
> -		dev_warn(bgp->dev, "failed to add hwmon sysfs attributes\n");
> +	devm_thermal_add_hwmon_sysfs(bgp->dev, data->ti_thermal); >
>   	return 0;
>   }
