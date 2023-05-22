Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9C270B8AE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 11:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232699AbjEVJSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 05:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjEVJSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 05:18:43 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8FE995;
        Mon, 22 May 2023 02:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1684747122; x=1716283122;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BC/9OS8kOdk7SPv1XjRs1P3rGecz/xIyWEwTr6oiDys=;
  b=DHv+KlyrNVYd5vCdEURszDYmNfyFZkigdRRk2iA2aCdgwxfKQ5j1eD5n
   RdEJW/0bPazimwf+MQpqyK2S9sMQwz12zr5o+bjfG13eDH5e/MMGhRFwR
   ZlxY1XdhsErS37knv8NgW9LsSyd2MX2QsXVff0i41Jy2TRhUyyOV32Q5c
   Onxhk1v61gWF1xZxH2Dr6aKcXKOuXxyythHAkUGfdhU4053WbgfZuhQEm
   whSROFU6uARnDk8hGnydNzL58V9SsYjRRv75qwMxieo8x2ZwYktN+dlSv
   HPATbS5ngFjFYOTBkcNxEsBA/X3lWoEtMth/IfBMkLY3VIW6M72uiIj3K
   A==;
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="216609302"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 May 2023 02:18:41 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 22 May 2023 02:18:39 -0700
Received: from [10.159.245.112] (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Mon, 22 May 2023 02:18:37 -0700
Message-ID: <ad907a40-3e00-e785-e072-460e955457cf@microchip.com>
Date:   Mon, 22 May 2023 11:18:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/3] pinctrl: at91-pio4: Enable Push-Pull configuration
Content-Language: en-US
To:     <Ryan.Wanner@microchip.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <alexandre.belloni@bootlin.com>, <claudiu.beznea@microchip.com>,
        <linus.walleij@linaro.org>, <ludovic.desroches@microchip.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>
References: <cover.1684313910.git.Ryan.Wanner@microchip.com>
 <d898c31277f6bce6f7d830edf4332ff605498c7b.1684313910.git.Ryan.Wanner@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <d898c31277f6bce6f7d830edf4332ff605498c7b.1684313910.git.Ryan.Wanner@microchip.com>
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

On 17/05/2023 at 13:54, Ryan.Wanner@microchip.com wrote:
> From: Ryan Wanner <Ryan.Wanner@microchip.com>
> 
> Enable push-pull configuration. Remove integer value argument from
> open-drain configuration as it is discarded when pinconf function is
> called from gpiolib. Add push-pull do debug and get functions.
> 
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>

Looks good to me:
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Thanks,
   Nicolas

> ---
>   drivers/pinctrl/pinctrl-at91-pio4.c | 15 +++++++++++----
>   1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pinctrl/pinctrl-at91-pio4.c b/drivers/pinctrl/pinctrl-at91-pio4.c
> index 2fe40acb6a3e..3c39d62bbc3c 100644
> --- a/drivers/pinctrl/pinctrl-at91-pio4.c
> +++ b/drivers/pinctrl/pinctrl-at91-pio4.c
> @@ -762,6 +762,11 @@ static int atmel_conf_pin_config_group_get(struct pinctrl_dev *pctldev,
>   			return -EINVAL;
>   		arg = 1;
>   		break;
> +	case PIN_CONFIG_DRIVE_PUSH_PULL:
> +		if (res & ATMEL_PIO_OPD_MASK)
> +			return -EINVAL;
> +		arg = 1;
> +		break;
>   	case PIN_CONFIG_INPUT_SCHMITT_ENABLE:
>   		if (!(res & ATMEL_PIO_SCHMITT_MASK))
>   			return -EINVAL;
> @@ -827,10 +832,10 @@ static int atmel_conf_pin_config_group_set(struct pinctrl_dev *pctldev,
>   			conf &= (~ATMEL_PIO_PUEN_MASK);
>   			break;
>   		case PIN_CONFIG_DRIVE_OPEN_DRAIN:
> -			if (arg == 0)
> -				conf &= (~ATMEL_PIO_OPD_MASK);
> -			else
> -				conf |= ATMEL_PIO_OPD_MASK;
> +			conf |= ATMEL_PIO_OPD_MASK;
> +			break;
> +		case PIN_CONFIG_DRIVE_PUSH_PULL:
> +			conf &= (~ATMEL_PIO_OPD_MASK);
>   			break;
>   		case PIN_CONFIG_INPUT_SCHMITT_ENABLE:
>   			if (arg == 0)
> @@ -948,6 +953,8 @@ static void atmel_conf_pin_config_dbg_show(struct pinctrl_dev *pctldev,
>   		seq_printf(s, "%s ", "debounce");
>   	if (conf & ATMEL_PIO_OPD_MASK)
>   		seq_printf(s, "%s ", "open-drain");
> +	if (!(conf & ATMEL_PIO_OPD_MASK))
> +		seq_printf(s, "%s ", "push-pull");
>   	if (conf & ATMEL_PIO_SCHMITT_MASK)
>   		seq_printf(s, "%s ", "schmitt");
>   	if (atmel_pioctrl->slew_rate_support && (conf & ATMEL_PIO_SR_MASK))

-- 
Nicolas Ferre

