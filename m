Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 420D770B93C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 11:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbjEVJkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 05:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232539AbjEVJkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 05:40:41 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E81DC9D
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 02:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1684748432; x=1716284432;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=yOM8xaXS8i9Ow+0s41tEfJYpws5ETQzrlHpi9sg1dFU=;
  b=hEK2J6iQjEsVy3HwNGLm0gL6uGuBs2T5xeN21Bd6c+BYaDhCL7avOCvo
   kmS4eRw/5WmkZOQ/9lSoTTDwVkEo7j8CcyrJ+in/+GKDvqcZyk1BVVY/Y
   0o8xsVMJaL6cZvwlIvePs5WJLMLzVNT7bsS9FhrcEKgSla/qA0M7JEAlO
   pBMPUiQdQ5gJEiRGOsPUTd2+oOgao/sFbFf9q/AJ+/cITyusNG4kt9Hew
   z7EZgC9ltM9xYVveKQntx6JQCp4nk7g2n7oHNk4+4HATldmcwNzj2ogRT
   E7KPOeEL7VicjNq9hl6lXBJcg3B5DGGGNFSk7APkkcBKiQSKW/PAlYAXM
   Q==;
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="214298114"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 May 2023 02:40:32 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 22 May 2023 02:40:32 -0700
Received: from [10.159.245.112] (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Mon, 22 May 2023 02:40:29 -0700
Message-ID: <635fe2a9-b171-8c1d-3cb2-c4f16e5747b3@microchip.com>
Date:   Mon, 22 May 2023 11:40:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] MAINTAINERS: update arm64 Microchip entries
Content-Language: en-US
To:     Conor Dooley <conor.dooley@microchip.com>, <soc@kernel.org>
CC:     <conor@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Daniel Machon <daniel.machon@microchip.com>
References: <20230522-wagon-stencil-a164ec39322a@wendy>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <20230522-wagon-stencil-a164ec39322a@wendy>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/05/2023 at 11:37, Conor Dooley wrote:
> Krzysztof noticed that patches for arch/arm64/boot/dts/microchip were
> getting lost & the listed tree was inactive.
> 
> Nicolas and I are willing to shepherd patches to Arnd, using the
> existing at91 tree, so add a new entry covering
> arch/arm64/boot/dts/microchip, listing us as maintainers.
> 
> Drop the tree from the existing sparx5 entry & narrow the devicetree
> pattern to just sparx devices, leaving Lars, Steen and Daniel looking
> after support for their SoCs.
> 
> CC: Rob Herring <robh+dt@kernel.org>
> CC: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> CC: Conor Dooley <conor@kernel.org>
> CC: Nicolas Ferre <nicolas.ferre@microchip.com>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Thanks Conor, best regards,
   Nicolas

> CC: Claudiu Beznea <claudiu.beznea@microchip.com>
> CC: soc@kernel.org
> CC: Lars Povlsen <lars.povlsen@microchip.com>
> CC: Steen Hegelund <Steen.Hegelund@microchip.com>
> CC: Daniel Machon <daniel.machon@microchip.com>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> Changes in v2:
> - add Claudiu
> ---
>   MAINTAINERS | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3182992769aa..9ae07caa4e6b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2433,6 +2433,15 @@ X:	drivers/net/wireless/atmel/
>   N:	at91
>   N:	atmel
>   
> +ARM/MICROCHIP (ARM64) SoC support
> +M:	Conor Dooley <conor@kernel.org>
> +M:	Nicolas Ferre <nicolas.ferre@microchip.com>
> +M:	Claudiu Beznea <claudiu.beznea@microchip.com>
> +L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> +S:	Supported
> +T:	git https://git.kernel.org/pub/scm/linux/kernel/git/at91/linux.git
> +F:	arch/arm64/boot/dts/microchip/
> +
>   ARM/Microchip Sparx5 SoC support
>   M:	Lars Povlsen <lars.povlsen@microchip.com>
>   M:	Steen Hegelund <Steen.Hegelund@microchip.com>
> @@ -2440,8 +2449,7 @@ M:	Daniel Machon <daniel.machon@microchip.com>
>   M:	UNGLinuxDriver@microchip.com
>   L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>   S:	Supported
> -T:	git git://github.com/microchip-ung/linux-upstream.git
> -F:	arch/arm64/boot/dts/microchip/
> +F:	arch/arm64/boot/dts/microchip/sparx*
>   F:	drivers/net/ethernet/microchip/vcap/
>   F:	drivers/pinctrl/pinctrl-microchip-sgpio.c
>   N:	sparx5

-- 
Nicolas Ferre

