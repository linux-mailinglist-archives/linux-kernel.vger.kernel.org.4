Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 946766D0DFC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 20:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231409AbjC3SmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 14:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231578AbjC3SmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 14:42:02 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26ACF10250;
        Thu, 30 Mar 2023 11:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1680201696; x=1711737696;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2lhEavYsX0XeKONGXX9Iu6NgQrMHJIVeCVJEWC8FSVk=;
  b=OgTqmzldJhLyMYaEfuV9Y6Z4DZ4/8BSfEfyROmmNuqeoKDs0/ZIV7mZ5
   PslHL29E2MafVlDxS05DxzD/HAHfKBeK/O91F6+ppuZUf75OCBK3ZznPz
   ozesecyUNYJ9TU6RvSK/HpT+K5L93GwWrUfA8eBkLKYX87pzQwkiXuCx5
   GYaeK/QaM7hpAUGFtsB4tHjdy1v7ZCk1eXSlLOI0yd7evGkHnamyd7j29
   1/UHEQrpVXo28KmsE4620UZmGVlOvFcmyKDskVLnBA6gB7AcU6vpeWptL
   1zXA6XBtP8ummyivQGYqnT9ZqV268LibWdxLlflmN2jMusKxhnBdV7Wwd
   A==;
X-IronPort-AV: E=Sophos;i="5.98,305,1673938800"; 
   d="scan'208";a="208114310"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Mar 2023 11:41:35 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 30 Mar 2023 11:41:34 -0700
Received: from [10.171.246.14] (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Thu, 30 Mar 2023 11:41:32 -0700
Message-ID: <4328668b-26c7-ebe7-f839-b6accd0a38f9@microchip.com>
Date:   Thu, 30 Mar 2023 20:41:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 3/4] ARM: dts: at91: sama5d2_icp: Set sst26vf064b SPI
 NOR flash at its maximum frequency
Content-Language: en-US
To:     Tudor Ambarus <tudor.ambarus@linaro.org>,
        <claudiu.beznea@microchip.com>
CC:     <alexandre.belloni@bootlin.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        "Tudor Ambarus" <tudor.ambarus@microchip.com>
References: <20230328101517.1595738-1-tudor.ambarus@linaro.org>
 <20230328101517.1595738-4-tudor.ambarus@linaro.org>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <20230328101517.1595738-4-tudor.ambarus@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/03/2023 at 12:15, Tudor Ambarus wrote:
> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
> sama5d2_icp populates an sst26vf064b SPI NOR flash. Its maximum operating
> frequency for 2.7-3.6V is 104 MHz. As the flash is operated at 3.3V,
> increase its maximum supported frequency to 104MHz. The increasing of the
> spi-max-frequency value requires the setting of the
> "CE# Not Active Hold Time", thus set the spi-cs-setup-ns to a value of 7.
> 
> The sst26vf064b datasheet specifies just a minimum value for the
> "CE# Not Active Hold Time" and it advertises it to 5 ns. There's no
> maximum time specified. I determined experimentally that 5 ns for the
> spi-cs-setup-ns is not enough when the flash is operated close to its
> maximum frequency and tests showed that 7 ns is just fine, so set the
> spi-cs-setup-ns dt property to 7.
> 
> With the increase of frequency the reads are now faster with ~37%.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>

Tested-by: Nicolas Ferre <nicolas.ferre@microchip.com> # on sama5d2 ICP 
board with a linux-next kernel today.

Thanks Tudor!

Best regards,
   Nicolas

> ---
>   arch/arm/boot/dts/at91-sama5d2_icp.dts | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/at91-sama5d2_icp.dts b/arch/arm/boot/dts/at91-sama5d2_icp.dts
> index 1346b8f2b259..999adeca6f33 100644
> --- a/arch/arm/boot/dts/at91-sama5d2_icp.dts
> +++ b/arch/arm/boot/dts/at91-sama5d2_icp.dts
> @@ -669,7 +669,8 @@ flash@0 {
>                  #size-cells = <1>;
>                  compatible = "jedec,spi-nor";
>                  reg = <0>;
> -               spi-max-frequency = <80000000>;
> +               spi-max-frequency = <104000000>;
> +               spi-cs-setup-ns = <7>;
>                  spi-tx-bus-width = <4>;
>                  spi-rx-bus-width = <4>;
>                  m25p,fast-read;
> --
> 2.40.0.348.gf938b09366-goog
> 

-- 
Nicolas Ferre

