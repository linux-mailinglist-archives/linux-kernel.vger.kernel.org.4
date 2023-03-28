Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAE446CB9D5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 10:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbjC1IvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 04:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjC1IvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 04:51:20 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D51FA;
        Tue, 28 Mar 2023 01:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1679993479; x=1711529479;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=T0f2kgJ9KZyICJJMWIGxZxVKRVW/cJ1iN/Ny6VWy2aE=;
  b=sk5ESEVWn3myTmsq+cgffAP6RCXuIdPUJpyx2IWbBB+pJzpmyAAcHTrF
   ae74gTnQeLE50aunfu+7nBTNHCRVGjFT3iOZspjqTpBCxuFuLXuaYWBsC
   bGfpbV+NGMZTbnGEumuCTUWZnyq8/4amF7ReNEG1hm1gwuXOi/YZSN5od
   8mJft7e5CKM4Cjp1AQ+n16G4XD/m13cgIfg2RXlVyM60ySZ8t9JYol3u6
   mJziAJDaIs+1WIEhSHa0F+t32w0bzCMCrefkQ3lRJ0l+Py53lP3xhRdp5
   EPknN7EMerzzQr+0Gpr69HjjZKjlHaxUV4r28+KswAUfnWEZb5RabMyAM
   g==;
X-IronPort-AV: E=Sophos;i="5.98,296,1673938800"; 
   d="scan'208";a="206642288"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Mar 2023 01:51:14 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 28 Mar 2023 01:51:13 -0700
Received: from [10.159.245.112] (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Tue, 28 Mar 2023 01:51:11 -0700
Message-ID: <a6fe77b6-4ff4-3c91-0c67-a9da5a638e7b@microchip.com>
Date:   Tue, 28 Mar 2023 10:51:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 5/8] ARM: dts: at91-sama5d27_wlsom1: Set sst26vf064b SPI
 NOR flash at its maximum frequency
Content-Language: en-US
To:     <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <alexandre.belloni@bootlin.com>, <claudiu.beznea@microchip.com>,
        Tudor Ambarus <tudor.ambarus@linaro.org>
CC:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mtd@lists.infradead.org>
References: <20221117105249.115649-1-tudor.ambarus@microchip.com>
 <20221117105249.115649-6-tudor.ambarus@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <20221117105249.115649-6-tudor.ambarus@microchip.com>
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

Hi Tudor,

On 17/11/2022 at 11:52, Tudor Ambarus wrote:
> sama5d27-wlsom1 populates an sst26vf064b SPI NOR flash. Its maximum
> operating frequency for 2.7-3.6V is 104 MHz. As the flash is operated
> at 3.3V, increase its maximum supported frequency to 104MHz. The
> increasing of the spi-max-frequency value requires the setting of the
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
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---
>   arch/arm/boot/dts/at91-sama5d27_wlsom1.dtsi | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/at91-sama5d27_wlsom1.dtsi b/arch/arm/boot/dts/at91-sama5d27_wlsom1.dtsi
> index 83bcf9fe0152..20caf40b4755 100644
> --- a/arch/arm/boot/dts/at91-sama5d27_wlsom1.dtsi
> +++ b/arch/arm/boot/dts/at91-sama5d27_wlsom1.dtsi
> @@ -220,7 +220,8 @@ qspi1_flash: flash@0 {
>   		#size-cells = <1>;
>   		compatible = "jedec,spi-nor";
>   		reg = <0>;
> -		spi-max-frequency = <80000000>;
> +		spi-max-frequency = <104000000>;
> +		spi-cs-setup-ns = /bits/ 16 <7>;

Following the different changes that happened to this property after 
this post, am I right saying that this must now be changed to:

spi-cs-setup-delay-ns = <7>;

?

Thanks for your insight. Best regards,
   Nicolas

>   		spi-rx-bus-width = <4>;
>   		spi-tx-bus-width = <4>;
>   		m25p,fast-read;

-- 
Nicolas Ferre

