Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92EDC7032EE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 18:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242436AbjEOQ3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 12:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242734AbjEOQ3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 12:29:50 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A13D630C8
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 09:29:45 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 34FGTaTK010608;
        Mon, 15 May 2023 11:29:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1684168176;
        bh=jXYt2Gt0ftzupMzxASNCzR0XrKgYFXFskLgcA+hx8/k=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=k3GXwq0I3MqvhKzZFuelXgIkMLG9UBaB2xrKXDnf4JHQPq6MYgcslN5TjnPmsYm8e
         C80wvPS4gdi+ylYcm6lVn0B/dNITdBo+Sfx939D41JXpsbSvK0KqC/K7b1enoPUr26
         fLFhtEz+HNf1Q3Pv+JwZFBQjKtYvv59Y5BmBzgH4=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 34FGTakA006154
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 15 May 2023 11:29:36 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 15
 May 2023 11:29:36 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 15 May 2023 11:29:35 -0500
Received: from [10.250.35.77] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 34FGTZn7085026;
        Mon, 15 May 2023 11:29:35 -0500
Message-ID: <05880eb0-5df5-93e3-1d42-b119ea0563cb@ti.com>
Date:   Mon, 15 May 2023 11:29:35 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] ARM: multi_v7_defconfig: Enable OMAP audio/display
 support
To:     Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230306222604.14574-1-afd@ti.com>
Content-Language: en-US
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <20230306222604.14574-1-afd@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/6/23 2:26 PM, Andrew Davis wrote:
> We would like to support some additional OMAP class devices using the
> common multi_v7_defconfig. To start, enable some audio/display related
> modules:
> 
> DRM_OMAP/OMAP5_DSS_HDMI: For base DRM display support.
> DRM_TI_TFP410: Used as a display bridge for several EVM's panels.
> DRM_TI_TPD12S015: HDMI encoder on several OMAP/Sitara EVMs.
> SND_SOC_TLV320AIC3X_I2C: For I2C attached TLV320AIC3x codecs.
> 
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---

Ping, still valid and can apply on v6.4-rc2.

Andrew

>   arch/arm/configs/multi_v7_defconfig | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
> index 084cc612ea23..06f5fb9137ba 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -711,6 +711,8 @@ CONFIG_ROCKCHIP_INNO_HDMI=y
>   CONFIG_DRM_ATMEL_HLCDC=m
>   CONFIG_DRM_RCAR_DU=m
>   CONFIG_DRM_SUN4I=m
> +CONFIG_DRM_OMAP=m
> +CONFIG_OMAP5_DSS_HDMI=y
>   CONFIG_DRM_MSM=m
>   CONFIG_DRM_FSL_DCU=m
>   CONFIG_DRM_TEGRA=y
> @@ -734,6 +736,8 @@ CONFIG_DRM_SII9234=m
>   CONFIG_DRM_SIMPLE_BRIDGE=m
>   CONFIG_DRM_TOSHIBA_TC358764=m
>   CONFIG_DRM_TOSHIBA_TC358768=m
> +CONFIG_DRM_TI_TFP410=m
> +CONFIG_DRM_TI_TPD12S015=m
>   CONFIG_DRM_I2C_ADV7511=m
>   CONFIG_DRM_I2C_ADV7511_AUDIO=y
>   CONFIG_DRM_STI=m
> @@ -822,6 +826,7 @@ CONFIG_SND_SOC_SGTL5000=m
>   CONFIG_SND_SOC_STI_SAS=m
>   CONFIG_SND_SOC_TLV320AIC32X4=m
>   CONFIG_SND_SOC_TLV320AIC32X4_I2C=m
> +CONFIG_SND_SOC_TLV320AIC3X_I2C=m
>   CONFIG_SND_SOC_WM8960=m
>   CONFIG_SND_SOC_WM8962=m
>   CONFIG_SND_SOC_WM8978=m
