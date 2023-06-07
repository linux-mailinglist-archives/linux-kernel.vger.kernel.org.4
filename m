Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95754725F70
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 14:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234132AbjFGM3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 08:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240917AbjFGM3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 08:29:25 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6EED1BFD
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 05:29:21 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f611ac39c5so7216158e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 05:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686140960; x=1688732960;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vvv5K2Fa6/qw28wNbL34OYbssjD8GFHlsFB1b17V23M=;
        b=KV9fpP2jx6guTOKgEAlO6GhkKJpM1TSY2zJSafASqc7HPVMhRuJY8j8GDFnHslXoXd
         tsQmZ4Ybww03zHKPSbSH7K0bX/W/4m6cefd8Ete87G9T723V5io/oaflGpqX6BmhMTuj
         r6dnnncuVDGRCrJDxHt5dxeB6bhDplAltZqEodABoowDtqyLRmdILjXwpojH9A0BGOPl
         dyMydx8sDJM4tCFZ4EFkKpdKlWbKCEEC8CVYMANtLM/vSx11Nhju3RDTRkTCpSMXVErj
         AfPMqMS8hQE1YvwrwM5WbZuZJ6KppZuQIKCY2hzogJ5NT/V0Q5B/0h62P0I7fLhET1dv
         l64Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686140960; x=1688732960;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vvv5K2Fa6/qw28wNbL34OYbssjD8GFHlsFB1b17V23M=;
        b=aJQgriNWqV4t3u49o5ggW5k3D7jhYb7EAmUywHr3BH3Pl7TmwAahKkZKUDvERI1UW8
         lYCfkA+cTM47H7ZUIe26sWn1ZwW/0/BIafw/RbkQneJRGC2hYWN17wlDeeoX1AQVjG/x
         FD4ywCXr4+6V4t6lAMMERDI27lQWg1KRvLHqcBUDBZf0MrglXIa/bqF2tuQEXwYpxNlG
         lQdjN5aCpqr4+1GcJyv8HMn0Rls08Hn8KVxWxdc5N8zoG3TGSZw4fSVVcx5dA3Q+BA4l
         ghe4ZD4a0z8VcJ865q0zBNwzWE8WoU8Ez0EbhUaYZ8Gubj666oPYXBzhJgyEufspTM68
         M5GQ==
X-Gm-Message-State: AC+VfDyvxiajUS/6Bb6OCwqkUqfWzRRc90blm3bc2daBKKqDp4dIk7da
        5AyKBxvwenB1lEVQZwkaNTJkSm7MCYAtdK6D15s=
X-Google-Smtp-Source: ACHHUZ44ZMWKvFqzo9F7XcBtsUXfQ+FLzrGKodpTdTU2l21B1LHoRvSCpL1whhvOLHLsLTnYvfreGQ==
X-Received: by 2002:a05:6512:40a:b0:4f6:19e0:8ab6 with SMTP id u10-20020a056512040a00b004f619e08ab6mr2021712lfk.30.1686140959818;
        Wed, 07 Jun 2023 05:29:19 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id u4-20020a056512040400b004f262997496sm1798376lfk.76.2023.06.07.05.29.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 05:29:19 -0700 (PDT)
Message-ID: <cf3c98c1-e283-3fac-3144-5a7354378a6b@linaro.org>
Date:   Wed, 7 Jun 2023 15:29:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 3/9] phy: qcom-m31: Introduce qcom,m31 USB phy driver
Content-Language: en-GB
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Varadarajan Narayanan <quic_varada@quicinc.com>,
        agross@kernel.org, andersson@kernel.org, vkoul@kernel.org,
        kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        gregkh@linuxfoundation.org, catalin.marinas@arm.com,
        will@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        p.zabel@pengutronix.de, arnd@arndb.de, geert+renesas@glider.be,
        neil.armstrong@linaro.org, nfraprado@collabora.com,
        broonie@kernel.org, rafal@milecki.pl, quic_srichara@quicinc.com,
        quic_varada@quicinc.org, quic_wcheng@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org
References: <cover.1686126439.git.quic_varada@quicinc.com>
 <6bb345c6a57ee27516764f36ba7d34fd1a719b87.1686126439.git.quic_varada@quicinc.com>
 <416bef68-6df3-d5c4-2aed-ef1ae7c78d7b@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <416bef68-6df3-d5c4-2aed-ef1ae7c78d7b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two minor nits on top of the review:

On 07/06/2023 14:54, Konrad Dybcio wrote:
> On 7.06.2023 12:56, Varadarajan Narayanan wrote:
>> Add the M31 USB2 phy driver
>>
>> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
>> ---
>>   drivers/phy/qualcomm/phy-qcom-m31.c | 360 ++++++++++++++++++++++++++++++++++++
>>   1 file changed, 360 insertions(+)
>>   create mode 100644 drivers/phy/qualcomm/phy-qcom-m31.c
>>
>> diff --git a/drivers/phy/qualcomm/phy-qcom-m31.c b/drivers/phy/qualcomm/phy-qcom-m31.c
>> new file mode 100644
>> index 0000000..d29a91e
>> --- /dev/null
>> +++ b/drivers/phy/qualcomm/phy-qcom-m31.c
>> @@ -0,0 +1,360 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * Copyright (c) 2014-2016, 2020, The Linux Foundation. All rights reserved.
>> + */
>> +
>> +#include <linux/module.h>
>> +#include <linux/kernel.h>
>> +#include <linux/err.h>
>> +#include <linux/slab.h>
>> +#include <linux/clk.h>
>> +#include <linux/delay.h>
>> +#include <linux/io.h>
>> +#include <linux/of.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/usb/phy.h>
>> +#include <linux/reset.h>
>> +#include <linux/of_device.h>
> Please sort these
> 
>> +
>> +enum clk_reset_action {
>> +	CLK_RESET_DEASSERT	= 0,
>> +	CLK_RESET_ASSERT	= 1
>> +};
>> +
>> +#define USB2PHY_PORT_POWERDOWN		0xA4
>> +#define POWER_UP			BIT(0)
>> +#define POWER_DOWN			0
>> +
>> +#define USB2PHY_PORT_UTMI_CTRL1	0x40
>> +
>> +#define USB2PHY_PORT_UTMI_CTRL2	0x44
>> +#define UTMI_ULPI_SEL			BIT(7)
>> +#define UTMI_TEST_MUX_SEL		BIT(6)
>> +
>> +#define HS_PHY_CTRL_REG			0x10
>> +#define UTMI_OTG_VBUS_VALID             BIT(20)
>> +#define SW_SESSVLD_SEL                  BIT(28)
>> +
>> +#define USB_PHY_CFG0			0x94
>> +#define USB_PHY_UTMI_CTRL5		0x50
>> +#define USB_PHY_FSEL_SEL		0xB8
>> +#define USB_PHY_HS_PHY_CTRL_COMMON0	0x54
>> +#define USB_PHY_REFCLK_CTRL		0xA0
>> +#define USB_PHY_HS_PHY_CTRL2		0x64
>> +#define USB_PHY_UTMI_CTRL0		0x3c
>> +#define USB2PHY_USB_PHY_M31_XCFGI_1	0xBC
>> +#define USB2PHY_USB_PHY_M31_XCFGI_4	0xC8
>> +#define USB2PHY_USB_PHY_M31_XCFGI_5	0xCC
>> +#define USB2PHY_USB_PHY_M31_XCFGI_11	0xE4
> Could you sort them address-wise?

... and lowercase the hex values, please.

> 
>> +
>> +#define USB2_0_TX_ENABLE		BIT(2)
>> +#define HSTX_SLEW_RATE_565PS		3
>> +#define PLL_CHARGING_PUMP_CURRENT_35UA	(3 << 3)
>> +#define ODT_VALUE_38_02_OHM		(3 << 6)
>> +#define ODT_VALUE_45_02_OHM		BIT(2)
>> +#define HSTX_PRE_EMPHASIS_LEVEL_0_55MA	(1)
> Weird mix of values, bits, bitfields.. perhaps BIT(n) and
> GENMASK() (+ FIELD_PREP) would be more suitable?
> 
>> +
>> +#define UTMI_PHY_OVERRIDE_EN		BIT(1)
>> +#define POR_EN				BIT(1)
> Please associate these with their registers, like
> 
> #define FOO_REG		0xf00
>   #define POR_EN		BIT(1)
> 
>> +#define FREQ_SEL			BIT(0)
>> +#define COMMONONN			BIT(7)
>> +#define FSEL				BIT(4)
>> +#define RETENABLEN			BIT(3)
>> +#define USB2_SUSPEND_N_SEL		BIT(3)
>> +#define USB2_SUSPEND_N			BIT(2)
>> +#define USB2_UTMI_CLK_EN		BIT(1)
>> +#define CLKCORE				BIT(1)
>> +#define ATERESET			~BIT(0)
>> +#define FREQ_24MHZ			(5 << 4)
>> +#define XCFG_COARSE_TUNE_NUM		(2 << 0)
>> +#define XCFG_FINE_TUNE_NUM		(1 << 3)
> same comment
> 
>> +
>> +static void m31usb_write_readback(void *base, u32 offset,
>> +					const u32 mask, u32 val);
> We don't need this forward-definition, just move the function up.
> 
>> +
>> +struct m31usb_phy {
>> +	struct usb_phy		phy;
>> +	void __iomem		*base;
>> +	void __iomem		*qscratch_base;
>> +
>> +	struct reset_control	*phy_reset;
>> +
>> +	bool			cable_connected;
>> +	bool			suspended;
>> +	bool			ulpi_mode;
>> +};
>> +
>> +static void m31usb_reset(struct m31usb_phy *qphy, u32 action)
>> +{
>> +	if (action == CLK_RESET_ASSERT)
>> +		reset_control_assert(qphy->phy_reset);
>> +	else
>> +		reset_control_deassert(qphy->phy_reset);
>> +	wmb(); /* ensure data is written to hw register */
> Please move the comment above the call.
> 
>> +}

Or even better just inline the function. I was never a fan of such 
multiplexers.

Also does wmb() make sense here? Doesn't regmap (which is used by reset 
controller) remove the need for it?

>> +
>> +static void m31usb_phy_enable_clock(struct m31usb_phy *qphy)
>> +{
>> +	/* Enable override ctrl */
>> +	writel(UTMI_PHY_OVERRIDE_EN, qphy->base + USB_PHY_CFG0);
> Some of the comments are missing a space before '*/'
> 
> Also, please consider adding some newlines to logically split the
> actions.


-- 
With best wishes
Dmitry

