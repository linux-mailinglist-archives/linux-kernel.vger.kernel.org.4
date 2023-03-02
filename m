Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA9026A7A87
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 05:34:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbjCBEeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 23:34:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjCBEeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 23:34:19 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B7C317154
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 20:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1677731639; x=1709267639;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=yMCGX+ri0QHcTEF3WqiDbtK7r57QxJ5U7JmAuN4zGq8=;
  b=UFU8+Xisgb6eUptNEGsp4KpUqWNbwi9fj/KVXg/2vkZeN0lUaveR95Qk
   ynDKtxN4KdkHHJ8iKPI/HhewKMLjH8XZLp4qMiuVe+TX0VhCekukyKzdW
   o6Yitkx5YOqwDt7oIKfki7l5n4eUzZjbu/7Pr0MIvkDIEP1vy/3p/Wv7C
   VjubJrTsTfnszDDcMP5Zzaq3BobA2pcxz7kda8FpIiSEUH5LiL+ilgSUZ
   wq+MauZ/8sYp5c+nyY9+sIAa4inEZNj6hL9nYOsYKtcaH0ByRJWxWrU9s
   EwTMERhBOZMCKDYTeXHdmeX7xKMH2Lp8F7W6yG7qOUXOg0k0RKkVh6tvl
   w==;
X-IronPort-AV: E=Sophos;i="5.98,226,1673938800"; 
   d="scan'208";a="139828306"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Mar 2023 21:33:55 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 1 Mar 2023 21:33:54 -0700
Received: from [10.40.24.88] (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.16 via Frontend
 Transport; Wed, 1 Mar 2023 21:33:51 -0700
Message-ID: <bcadd5ce-d205-7431-51f3-38239fab348c@microchip.com>
Date:   Thu, 2 Mar 2023 10:03:49 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 8/8] MAINTAINERS: update Microchip AT91 sound entries with
 documentation files
Content-Language: en-US
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <alexandre.belloni@bootlin.com>
CC:     <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230301113807.24036-1-claudiu.beznea@microchip.com>
 <20230301113807.24036-9-claudiu.beznea@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <20230301113807.24036-9-claudiu.beznea@microchip.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/03/2023 at 17:08, Claudiu Beznea wrote:
> Add documentation files to Microchip AT91 sound entries.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

> ---
>   MAINTAINERS | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 252cc33f0f5c..b5a966f84d89 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13669,6 +13669,10 @@ MICROCHIP AUDIO ASOC DRIVERS
>   M:	Claudiu Beznea <claudiu.beznea@microchip.com>
>   L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
>   S:	Supported
> +F:	Documentation/devicetree/bindings/sound/atmel*
> +F:	Documentation/devicetree/bindings/sound/axentia,tse850-pcm5142.txt
> +F:	Documentation/devicetree/bindings/sound/microchip,sama7g5-*
> +F:	Documentation/devicetree/bindings/sound/mikroe,mikroe-proto.txt
>   F:	sound/soc/atmel
>   
>   MICROCHIP CSI2DC DRIVER
> @@ -13836,6 +13840,7 @@ MICROCHIP SSC DRIVER
>   M:	Claudiu Beznea <claudiu.beznea@microchip.com>
>   L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>   S:	Supported
> +F:	Documentation/devicetree/bindings/misc/atmel-ssc.txt
>   F:	drivers/misc/atmel-ssc.c
>   F:	include/linux/atmel-ssc.h
>   

-- 
Nicolas Ferre

