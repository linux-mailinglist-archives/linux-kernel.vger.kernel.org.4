Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8FD15EC2BA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 14:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232260AbiI0MbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 08:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbiI0MbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 08:31:18 -0400
Received: from relay06.th.seeweb.it (relay06.th.seeweb.it [IPv6:2001:4b7a:2000:18::167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6842F5C9DF
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 05:31:16 -0700 (PDT)
Received: from [192.168.1.101] (95.49.29.188.neoplus.adsl.tpnet.pl [95.49.29.188])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id B051F3F289;
        Tue, 27 Sep 2022 14:31:12 +0200 (CEST)
Message-ID: <515f1fa9-e7bd-faf1-03ee-bcb0abc56e07@somainline.org>
Date:   Tue, 27 Sep 2022 14:31:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 1/2] ARM: qcom_defconfig: enable rest of ARMv7 SoCs
 pinctrl drivers
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220925091920.34891-1-krzysztof.kozlowski@linaro.org>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20220925091920.34891-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25.09.2022 11:19, Krzysztof Kozlowski wrote:
> Enable rest of ARMv7 SoCs pin controller drivers.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Acked-by: Konrad Dybcio <konrad.dybcio@somainline.org>

Konrad
>  arch/arm/configs/qcom_defconfig | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm/configs/qcom_defconfig b/arch/arm/configs/qcom_defconfig
> index 7d8b6884fd00..4971de49be36 100644
> --- a/arch/arm/configs/qcom_defconfig
> +++ b/arch/arm/configs/qcom_defconfig
> @@ -131,14 +131,20 @@ CONFIG_PINCTRL_APQ8064=y
>  CONFIG_PINCTRL_APQ8084=y
>  CONFIG_PINCTRL_IPQ4019=y
>  CONFIG_PINCTRL_IPQ8064=y
> +CONFIG_PINCTRL_MSM8226=y
>  CONFIG_PINCTRL_MSM8660=y
>  CONFIG_PINCTRL_MSM8960=y
> +CONFIG_PINCTRL_MDM9607=y
>  CONFIG_PINCTRL_MDM9615=y
>  CONFIG_PINCTRL_MSM8X74=y
> +CONFIG_PINCTRL_MSM8909=y
> +CONFIG_PINCTRL_MSM8916=y
> +CONFIG_PINCTRL_MSM8976=y
>  CONFIG_PINCTRL_QCOM_SPMI_PMIC=y
>  CONFIG_PINCTRL_QCOM_SSBI_PMIC=y
>  CONFIG_GPIOLIB=y
>  CONFIG_PINCTRL_SDX55=y
> +CONFIG_PINCTRL_SDX65=y
>  CONFIG_GPIO_SYSFS=y
>  CONFIG_POWER_RESET=y
>  CONFIG_POWER_RESET_MSM=y
