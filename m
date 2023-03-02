Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0A06A7A85
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 05:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjCBEdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 23:33:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjCBEdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 23:33:02 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DBD85BBA
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 20:32:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1677731578; x=1709267578;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=z7XH4Pck2obKvHWgumzadusXlBkpmVZ9RS92+m5IOSk=;
  b=BwErcUf2JB9/nvEp2h/eV+o+zk3geSYuWlkCuYOvjjMAwRUSqNJWFQf6
   +klByw/PxYVE0HYmF6v6cuBUD0otw8SCtQ4IdA34Fr1kYyI6ecUVoAIW1
   hBqHvxhihXPCVZ6BL9omyN6QH9j9vMBBjr8BcigMvpIwY/3aLjUBcfk6N
   L1gxLVsGDTVYgsor5mBI2WOEOTXG5Sx/jM7D1ki7UdhY7hcImO/TXqwRW
   yNQvh0d+Xrq0OQaJybHlBzHGREk64qU4QTBg9JfUnsQNBK4MkfTn7KVjL
   uWYuYczz26Okz56LM2uPuUu6zI7JdRLY1ugosFxYFb9pwfw3ZeDW8uYkB
   A==;
X-IronPort-AV: E=Sophos;i="5.98,226,1673938800"; 
   d="scan'208";a="203185791"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Mar 2023 21:32:56 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 1 Mar 2023 21:32:56 -0700
Received: from [10.40.24.88] (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.16 via Frontend
 Transport; Wed, 1 Mar 2023 21:32:52 -0700
Message-ID: <c379dc5d-46ec-613e-22ec-eba94c399a90@microchip.com>
Date:   Thu, 2 Mar 2023 10:02:51 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 7/8] MAINTAINERS: add myself as maintainer for Microchip
 AT91 sound drivers
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <alexandre.belloni@bootlin.com>
CC:     <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230301113807.24036-1-claudiu.beznea@microchip.com>
 <20230301113807.24036-8-claudiu.beznea@microchip.com>
Content-Language: en-US
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <20230301113807.24036-8-claudiu.beznea@microchip.com>
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
> Codrin is not with Microchip anymore. As I worked lately with Microchip
> AT91 sound drivers add myself as maintainer for these.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Thanks Claudiu for taking this responsibility!

Best regards,
   Nicolas

> ---
>   MAINTAINERS | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1e246c16aff6..252cc33f0f5c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13666,7 +13666,7 @@ F:	Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml
>   F:	drivers/spi/spi-at91-usart.c
>   
>   MICROCHIP AUDIO ASOC DRIVERS
> -M:	Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
> +M:	Claudiu Beznea <claudiu.beznea@microchip.com>
>   L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
>   S:	Supported
>   F:	sound/soc/atmel
> @@ -13833,7 +13833,7 @@ S:	Supported
>   F:	drivers/spi/spi-atmel.*
>   
>   MICROCHIP SSC DRIVER
> -M:	Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
> +M:	Claudiu Beznea <claudiu.beznea@microchip.com>
>   L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>   S:	Supported
>   F:	drivers/misc/atmel-ssc.c

-- 
Nicolas Ferre

