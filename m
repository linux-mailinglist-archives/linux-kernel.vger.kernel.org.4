Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAD0D737D7E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 10:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbjFUIS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 04:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbjFUISb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 04:18:31 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D864172C;
        Wed, 21 Jun 2023 01:18:13 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35L6INqP006169;
        Wed, 21 Jun 2023 10:18:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=ktAiYtJ3jDq+n1lXapDqHkfJt+cyOFmuJ6D84451tAg=;
 b=eaPf8EHez5T7vchZyx59VVwGadXKUyUzwybgCPJ18E0sXOyGFUtPeEIYpfLSiO83Uwgh
 EukgR2uKOGFMmKta1uF17sJP3FatNBfdEZn3H66Pnz48W84rGljtf3l54/wbsJp7tL5Q
 C/IE8O4h2LXVbD3lA8gwzOWyDeyteZX0fqXJa7nHen4Gc3pBf54H1341sbyXVXl/J27f
 vJ00SytBJ830GpFfhQUrBwjms4rXfQFsFcizc2LOjP5I0rXBBHwrBkyb73oVWZlLl2/b
 ABJymWGstx/Ny+1/mEExPFvRA8/QjSnQcxia3jVTC5xolbo4cBwIAVQw18xHLwLfZZoP PQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3rbuts94xe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jun 2023 10:18:04 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4F4D4100069;
        Wed, 21 Jun 2023 10:18:02 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3560921BF70;
        Wed, 21 Jun 2023 10:18:02 +0200 (CEST)
Received: from [10.252.11.107] (10.252.11.107) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Wed, 21 Jun
 2023 10:18:01 +0200
Message-ID: <40b91e5a-0b25-c5e3-66f1-70e1d12f661c@foss.st.com>
Date:   Wed, 21 Jun 2023 10:18:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] pinctrl: stm32: set default gpio line names using pin
 names
Content-Language: en-US
To:     Valentin Caron <valentin.caron@foss.st.com>,
        Linus Walleij <linus.walleij@linaro.org>
CC:     <linux-gpio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20230620104349.834687-1-valentin.caron@foss.st.com>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20230620104349.834687-1-valentin.caron@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.252.11.107]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-21_05,2023-06-16_01,2023-05-22_02
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,SUSPICIOUS_RECIPS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 6/20/23 12:43, Valentin Caron wrote:
> Add stm32_pctrl_get_desc_pin_from_gpio function to find a stm32 pin
> descriptor which is matching with a gpio.
> Most of the time pin number is equal to pin index in array. So the first
> part of the function is useful to speed up.
> 
> And during gpio bank register, we set default gpio names with pin names.
> 
> Signed-off-by: Valentin Caron <valentin.caron@foss.st.com>
> ---

Acked-by: Alexandre TORGUE <alexandre.torgue@foss.st.com>

>   drivers/pinctrl/stm32/pinctrl-stm32.c | 35 +++++++++++++++++++++++++++
>   1 file changed, 35 insertions(+)
> 
> diff --git a/drivers/pinctrl/stm32/pinctrl-stm32.c b/drivers/pinctrl/stm32/pinctrl-stm32.c
> index 4b97bd00191b..eedbb9b97a65 100644
> --- a/drivers/pinctrl/stm32/pinctrl-stm32.c
> +++ b/drivers/pinctrl/stm32/pinctrl-stm32.c
> @@ -1275,6 +1275,28 @@ static const struct pinconf_ops stm32_pconf_ops = {
>   	.pin_config_dbg_show	= stm32_pconf_dbg_show,
>   };
>   
> +static struct stm32_desc_pin *stm32_pctrl_get_desc_pin_from_gpio(struct stm32_pinctrl *pctl,
> +								 struct stm32_gpio_bank *bank,
> +								 unsigned int offset)
> +{
> +	unsigned int stm32_pin_nb = bank->bank_nr * STM32_GPIO_PINS_PER_BANK + offset;
> +	struct stm32_desc_pin *pin_desc;
> +	int i;
> +
> +	/* With few exceptions (e.g. bank 'Z'), pin number matches with pin index in array */
> +	pin_desc = pctl->pins + stm32_pin_nb;
> +	if (pin_desc->pin.number == stm32_pin_nb)
> +		return pin_desc;
> +
> +	/* Otherwise, loop all array to find the pin with the right number */
> +	for (i = 0; i < pctl->npins; i++) {
> +		pin_desc = pctl->pins + i;
> +		if (pin_desc->pin.number == stm32_pin_nb)
> +			return pin_desc;
> +	}
> +	return NULL;
> +}
> +
>   static int stm32_gpiolib_register_bank(struct stm32_pinctrl *pctl, struct fwnode_handle *fwnode)
>   {
>   	struct stm32_gpio_bank *bank = &pctl->banks[pctl->nbanks];
> @@ -1285,6 +1307,8 @@ static int stm32_gpiolib_register_bank(struct stm32_pinctrl *pctl, struct fwnode
>   	struct resource res;
>   	int npins = STM32_GPIO_PINS_PER_BANK;
>   	int bank_nr, err, i = 0;
> +	struct stm32_desc_pin *stm32_pin;
> +	char **names;
>   
>   	if (!IS_ERR(bank->rstc))
>   		reset_control_deassert(bank->rstc);
> @@ -1354,6 +1378,17 @@ static int stm32_gpiolib_register_bank(struct stm32_pinctrl *pctl, struct fwnode
>   		}
>   	}
>   
> +	names = devm_kcalloc(dev, npins, sizeof(char *), GFP_KERNEL);
> +	for (i = 0; i < npins; i++) {
> +		stm32_pin = stm32_pctrl_get_desc_pin_from_gpio(pctl, bank, i);
> +		if (stm32_pin && stm32_pin->pin.name)
> +			names[i] = devm_kasprintf(dev, GFP_KERNEL, "%s", stm32_pin->pin.name);
> +		else
> +			names[i] = NULL;
> +	}
> +
> +	bank->gpio_chip.names = (const char * const *)names;
> +
>   	err = gpiochip_add_data(&bank->gpio_chip, bank);
>   	if (err) {
>   		dev_err(dev, "Failed to add gpiochip(%d)!\n", bank_nr);

