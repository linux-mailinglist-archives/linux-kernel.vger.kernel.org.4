Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33AA1607269
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 10:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbiJUIeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 04:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbiJUIeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 04:34:02 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B29A1838B
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 01:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1666341218; x=1697877218;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=W0FjmqEq7W2v1e6mYbxIfrYRIN+4wzQIfAWufS6O4S0=;
  b=EJpAQOm8oAKOIT9nQdLw20Ag3BalAWBHwkASqauDilppSdmEJbxhHJXG
   9ZfLIgEuUFWGbxKuFzmpJteTHVsD3RliTC4LgVuLk8j/3bivZhZBv3Jc5
   C/6fKgU6qXWslkA+NVwO+2ZDD4WR7d37uAeU2Pk91L836+r5j+jXX0B9Y
   vCn7Tgogm5WQJXi3el7DlfaBObvcgrN4MdbNk/NbY8RX/44v6OluXEbuy
   N0YfSmIfZXXSZ+omyM3C4Ob61P7MwU6uc/Mdc1xNZ4Tpg0fELuDgcxIYa
   T5MIhW6seSicqxFnnWw45QMrZYg86+iYwsSGNru9+Tq1fEXVldx+jXxb1
   A==;
X-IronPort-AV: E=Sophos;i="5.95,200,1661842800"; 
   d="scan'208";a="196445545"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Oct 2022 01:33:24 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 21 Oct 2022 01:33:24 -0700
Received: from [10.159.205.135] (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.12 via Frontend
 Transport; Fri, 21 Oct 2022 01:33:23 -0700
Message-ID: <b1ee9223-8aec-e1ca-562c-6564f8876607@microchip.com>
Date:   Fri, 21 Oct 2022 10:33:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 01/17] ARM: at91: remove stale MAINTAINER file entries
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
References: <20221019144119.3848027-1-arnd@kernel.org>
 <20221019150410.3851944-1-arnd@kernel.org>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <20221019150410.3851944-1-arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/10/2022 at 17:03, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Going through the entries of recently removed machine types,
> I found these two that were removed a long time ago.
> 
> Cc: Nicolas Ferre <nicolas.ferre@microchip.com>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>


> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: Claudiu Beznea <claudiu.beznea@microchip.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   MAINTAINERS | 10 ----------
>   1 file changed, 10 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cf0f18502372..aedb7c008dd6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1798,16 +1798,6 @@ M:       Lennert Buytenhek <kernel@wantstofly.org>
>   L:     linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>   S:     Maintained
> 
> -ARM/AFEB9260 MACHINE SUPPORT
> -M:     Sergey Lapin <slapin@ossfans.org>
> -L:     linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> -S:     Maintained
> -
> -ARM/AJECO 1ARM MACHINE SUPPORT
> -M:     Lennert Buytenhek <kernel@wantstofly.org>
> -L:     linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> -S:     Maintained
> -

Yes, both removed by fb3642ebb52cfab8eaa52fea677abec4d92182a0 during 
v3.18..v3.19.

>   ARM/Allwinner SoC Clock Support
>   M:     Emilio López <emilio@elopez.com.ar>
>   S:     Maintained

Thanks Arnd! Best regards,
   Nicolas


-- 
Nicolas Ferre
