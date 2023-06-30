Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 362BE74325D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 03:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbjF3BqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 21:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbjF3BqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 21:46:03 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C2330DF;
        Thu, 29 Jun 2023 18:46:02 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id D76DF24E245;
        Fri, 30 Jun 2023 09:45:51 +0800 (CST)
Received: from EXMBX172.cuchost.com (172.16.6.92) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 30 Jun
 2023 09:45:51 +0800
Received: from [192.168.125.93] (183.27.97.206) by EXMBX172.cuchost.com
 (172.16.6.92) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 30 Jun
 2023 09:45:50 +0800
Message-ID: <4ed97fd6-a99c-0be8-aff5-61021be59422@starfivetech.com>
Date:   Fri, 30 Jun 2023 09:45:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v1 2/5] ASoC: codecs: Add StarFive JH7110 dummy PWM-DAC
 transmitter driver
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        "Walker Chen" <walker.chen@starfivetech.com>,
        Xingyu Wu <xingyu.wu@starfivetech.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>
CC:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20230626110909.38718-1-hal.feng@starfivetech.com>
 <20230626110909.38718-3-hal.feng@starfivetech.com>
 <4c421206-39a2-d98e-f75d-f5d269e881ff@linaro.org>
From:   Hal Feng <hal.feng@starfivetech.com>
In-Reply-To: <4c421206-39a2-d98e-f75d-f5d269e881ff@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [183.27.97.206]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX172.cuchost.com
 (172.16.6.92)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Jun 2023 17:33:57 +0200, Krzysztof Kozlowski wrote:
> On 26/06/2023 13:09, Hal Feng wrote:
>> Add a dummy transmitter driver for StarFive JH7110 PWM-DAC module.
>> StarFive JH7110 PWM-DAC controller uses this driver.
>> 
>> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
>> ---
>>  sound/soc/codecs/Kconfig                     |  4 ++
>>  sound/soc/codecs/Makefile                    |  2 +
>>  sound/soc/codecs/jh7110_pwmdac_transmitter.c | 74 ++++++++++++++++++++
>>  3 files changed, 80 insertions(+)
>>  create mode 100644 sound/soc/codecs/jh7110_pwmdac_transmitter.c
>> 
> 
> ...
> 
>> +
>> +static struct platform_driver pwmdac_dit_driver = {
>> +	.probe		= pwmdac_dit_probe,
>> +	.driver		= {
>> +		.name	= DRV_NAME,
>> +		.of_match_table = of_match_ptr(pwmdac_dit_dt_ids),
>> +	},
>> +};
>> +
>> +module_platform_driver(pwmdac_dit_driver);
>> +
>> +MODULE_DESCRIPTION("StarFive JH7110 dummy PWM-DAC transmitter driver");
>> +MODULE_LICENSE("GPL");
>> +MODULE_ALIAS("platform:" DRV_NAME);
> 
> Drop. You don't need it. If you need it, it means you miss proper ID table.

OK. I will drop it in the next version. Thanks.

Best regards,
Hal
