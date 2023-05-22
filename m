Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB1D070B71E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 09:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbjEVHzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 03:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231808AbjEVHyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 03:54:40 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC7BD1FF1
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 00:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1684741958; x=1716277958;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WbS260rijrjdGsBDFfLxi3G0STFcJso3jr4x9Y1Llzw=;
  b=n1D5M4E5FFryK53kpp6wY/8Wxzdn9tB2rMowKs64sqHfqHEgixjOO9No
   z7faIhu3U1RhjalHXFWFDKh25WAcy6JRvWBnZnE9w7iQVsoEARybgUzPU
   bbo956bhoWpADRMRyTHXS2a2h2zH4aDbo8l8gdkYyEdwYY7Ad0nJ5Tsdw
   yiN68HPacg2uCPrWBwSZw32GB8GzChkfgVHtnWHLUT7xf89fbjJ7BrlQA
   fedonvRF3HOsvXAV5bo6SIxHPWRQGHSyRTBRw+koWijQRhOsmcjpS5uPF
   hm3X7F3wptKd9hFravaZb1Cv5OVv0Acayfv8jyXDUjD5kAfQwohvWSzgt
   w==;
X-IronPort-AV: E=Sophos;i="6.00,183,1681196400"; 
   d="scan'208";a="212416679"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 May 2023 00:52:37 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 22 May 2023 00:52:36 -0700
Received: from [10.159.245.112] (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Mon, 22 May 2023 00:52:34 -0700
Message-ID: <5e0a2144-81fc-8e83-f8e5-f88abfbf5809@microchip.com>
Date:   Mon, 22 May 2023 09:52:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v1] MAINTAINERS: update arm64 Microchip entries
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>, <soc@kernel.org>,
        Claudiu Beznea <Claudiu.Beznea@microchip.com>
CC:     Conor Dooley <conor.dooley@microchip.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Daniel Machon <daniel.machon@microchip.com>
References: <20230517-shimmer-retry-34596c637882@spud>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <20230517-shimmer-retry-34596c637882@spud>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/05/2023 at 17:55, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> Krzysztof noticed that patches for arch/arm64/boot/dts/microchip were
> getting lost & the listed tree was inactive.
> 
> Nicolas and I are willing to shepherd patches to Arnd, using the
> existing at91 tree, so add a new entry covering
> arch/arm64/boot/dts/microchip, listing us as maintainers.

Yes, and I would like that Claudiu is part of this as well as he very 
active in reviews and is building most of the pull-requests for at91.

Thanks for helping clarifying this.
Best regards,
   Nicolas

> Drop the tree from the existing sparx5 entry & narrow the devicetree
> pattern to just sparx devices, leaving Lars, Steen and Daniel looking
> after support for their SoCs.
> 
> CC: Rob Herring <robh+dt@kernel.org>
> CC: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> CC: Conor Dooley <conor@kernel.org>
> CC: Nicolas Ferre <nicolas.ferre@microchip.com>
> CC: soc@kernel.org
> CC: Lars Povlsen <lars.povlsen@microchip.com>
> CC: Steen Hegelund <Steen.Hegelund@microchip.com>
> CC: Daniel Machon <daniel.machon@microchip.com>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>   MAINTAINERS | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7e0b87d5aa2e..b5c10fb8ae49 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2434,6 +2434,14 @@ X:       drivers/net/wireless/atmel/
>   N:     at91
>   N:     atmel
> 
> +ARM/MICROCHIP (ARM64) SoC support
> +M:     Conor Dooley <conor@kernel.org>
> +M:     Nicolas Ferre <nicolas.ferre@microchip.com>
> +L:     linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> +S:     Supported
> +T:     git https://git.kernel.org/pub/scm/linux/kernel/git/at91/linux.git
> +F:     arch/arm64/boot/dts/microchip/
> +
>   ARM/Microchip Sparx5 SoC support
>   M:     Lars Povlsen <lars.povlsen@microchip.com>
>   M:     Steen Hegelund <Steen.Hegelund@microchip.com>
> @@ -2441,8 +2449,7 @@ M:        Daniel Machon <daniel.machon@microchip.com>
>   M:     UNGLinuxDriver@microchip.com
>   L:     linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>   S:     Supported
> -T:     git git://github.com/microchip-ung/linux-upstream.git
> -F:     arch/arm64/boot/dts/microchip/
> +F:     arch/arm64/boot/dts/microchip/sparx*
>   F:     drivers/net/ethernet/microchip/vcap/
>   F:     drivers/pinctrl/pinctrl-microchip-sgpio.c
>   N:     sparx5
> --
> 2.39.2
> 

-- 
Nicolas Ferre

