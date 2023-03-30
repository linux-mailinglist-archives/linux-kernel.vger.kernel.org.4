Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 102806D0E26
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 20:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231630AbjC3Sxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 14:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbjC3Sxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 14:53:50 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B789BDE;
        Thu, 30 Mar 2023 11:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1680202429; x=1711738429;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Q+MgTXHJ/CdLCzYqceHDtR8K4jouu9hMZPEEUCL5pw0=;
  b=VU+0u4EyYbfbgwSzZ0KIlgD51zyhRXkA94qFtpGeO7mmC6Rj7NVpsvyc
   z5UITX6P9plPBErbLA1DD28fMPl1Li3zZ9DwLr52fjvpvBLQo9IpPA1Ey
   Oe5lY/yOYdgSrmUyHQE45+YYjlqgIl0o9p0aWwd8DzKcSdMrK3D56pqTP
   jy7l9MnL6yFPrWi/zp/gaWHJQ2FTv4qgz7D3n/2bx5b4jLNTcK8+Fj3Ir
   8pbvRQG/o7mvf47E9Uh2PVRIjxG82VWUlawCdo2ogPC/J5VYBlhuNFC4v
   DB2YXNCmbID4rO3uC+XVf6u3tuL7V8oxfSGAewQ7sm81GJgo+JX4Lx+o4
   w==;
X-IronPort-AV: E=Sophos;i="5.98,305,1673938800"; 
   d="scan'208";a="218749486"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Mar 2023 11:53:49 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 30 Mar 2023 11:53:48 -0700
Received: from [10.171.246.14] (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Thu, 30 Mar 2023 11:53:46 -0700
Message-ID: <3fc2611e-3cd8-d9ae-5ff4-d33fda8c0099@microchip.com>
Date:   Thu, 30 Mar 2023 20:53:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 0/4] ARM: dts: at91: Set sst26vf064b SPI NOR flash at
 its maxumum frequency
Content-Language: en-US
To:     Tudor Ambarus <tudor.ambarus@linaro.org>,
        <claudiu.beznea@microchip.com>
CC:     <alexandre.belloni@bootlin.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20230328101517.1595738-1-tudor.ambarus@linaro.org>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <20230328101517.1595738-1-tudor.ambarus@linaro.org>
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
> Changes in v3: Update S-o-b tag to match author's email.
> Changes in v2: update value of spi-cs-setup-ns as it was changed to u32
> since the first proposal.
> v1 at: https://lore.kernel.org/linux-mtd/20221117105249.115649-1-tudor.ambarus@microchip.com/
> 
> ---
> SPI NOR flashes have specific cs-setup time requirements without which
> they can't work at frequencies close to their maximum supported frequency,
> as they miss the first bits of the instruction command. Unrecognized
> commands are ignored, thus the flash will be unresponsive. Introduce the
> spi-cs-setup-ns property to allow spi devices to specify their cs setup
> time.

Now that it's tested:
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
to the whole series and I'll queue them on at91-dt branch and changed 
your email address when doing so.

Thanks for your patches Tudor, it's appreciated! Best regards,
   Nicolas

> Tudor Ambarus (4):
>    ARM: dts: at91-sama5d27_wlsom1: Set sst26vf064b SPI NOR flash at its
>      maximum frequency
>    ARM: dts: at91-sama5d27_som1: Set sst26vf064b SPI NOR flash at its
>      maximum frequency
>    ARM: dts: at91: sama5d2_icp: Set sst26vf064b SPI NOR flash at its
>      maximum frequency
>    ARM: dts: at91: sam9x60ek: Set sst26vf064b SPI NOR flash at its
>      maximum frequency
> 
>   arch/arm/boot/dts/at91-sam9x60ek.dts        | 3 ++-
>   arch/arm/boot/dts/at91-sama5d27_som1.dtsi   | 3 ++-
>   arch/arm/boot/dts/at91-sama5d27_wlsom1.dtsi | 3 ++-
>   arch/arm/boot/dts/at91-sama5d2_icp.dts      | 3 ++-
>   4 files changed, 8 insertions(+), 4 deletions(-)
> 
> --
> 2.40.0.348.gf938b09366-goog
> 

-- 
Nicolas Ferre

