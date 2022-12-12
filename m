Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7167464A071
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 14:25:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232709AbiLLNYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 08:24:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232650AbiLLNYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 08:24:42 -0500
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3E0638B6;
        Mon, 12 Dec 2022 05:24:41 -0800 (PST)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id B388D84D70;
        Mon, 12 Dec 2022 14:24:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1670851480;
        bh=ByugvTB2TdD9rhs8DFOD2UNRwsHQ+Fwc4kOKwPPfwr4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=VQWdRaTfiV38yMRIHxVMtDuuJWSFn+RlcDFwqCkKkB0bXpHT/qcBbnYCYQShghKA6
         FNRa3XAg/ZJ4jwLqaUuRGxlhu4p9FxEJ5WWQei5o1VgvQLfPEgm93jR9wpGxpzYftQ
         vM24hYkUpcM8C1Yf1PZW438WYHmw9Z2PcJ2fxoXE7OElL4ZVHkpwehWc6F2JPej1YA
         8B480VZ7yM1ykqR+bUJgVnXa7LqHM2b1f3Jd2VnpCFWYeNlxVsRjnjUlAM0tDYHk9o
         qxYgjWbY5bXu920z8lcHZlQi8/tDfjzRk/bx93zucyYsoezW4kMq4bXWL0ZewId2/C
         JXrVw7RV+cZug==
Message-ID: <7e9301a5-a246-9779-39c7-9f2125218c30@denx.de>
Date:   Mon, 12 Dec 2022 14:01:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 1/4] ARM: dts: stm32: Fix qspi pinctrl phandle for
 stm32mp15xx-dhcor-som
Content-Language: en-US
To:     patrice.chotard@foss.st.com, robh+dt@kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        alexandre.torgue@foss.st.com
Cc:     mcoquelin.stm32@gmail.com,
        linux-stm32@st-md-mailman.stormreply.com, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Alexandre Torgue <alexandre.torgue@st.com>
References: <20221212085142.3944367-1-patrice.chotard@foss.st.com>
 <20221212085142.3944367-2-patrice.chotard@foss.st.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <20221212085142.3944367-2-patrice.chotard@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/22 09:51, patrice.chotard@foss.st.com wrote:
> From: Patrice Chotard <patrice.chotard@foss.st.com>
> 
> Chip select pinctrl phandle was missing in several stm32mp15x based boards.
> 
> Fixes: ea99a5a02ebc ("ARM: dts: stm32: Create separate pinmux for qspi cs pin in stm32mp15-pinctrl.dtsi)
> 
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Marek Vasut <marex@denx.de>
> Cc: Alexandre Torgue <alexandre.torgue@st.com>
> Cc: linux-stm32@st-md-mailman.stormreply.com
> To: linux-arm-kernel@lists.infradead.org
> ---
>   arch/arm/boot/dts/stm32mp15xx-dhcor-som.dtsi | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/stm32mp15xx-dhcor-som.dtsi b/arch/arm/boot/dts/stm32mp15xx-dhcor-som.dtsi
> index 134a798ad3f2..bb40fb46da81 100644
> --- a/arch/arm/boot/dts/stm32mp15xx-dhcor-som.dtsi
> +++ b/arch/arm/boot/dts/stm32mp15xx-dhcor-som.dtsi
> @@ -247,8 +247,12 @@ &pwr_regulators {
>   
>   &qspi {
>   	pinctrl-names = "default", "sleep";
> -	pinctrl-0 = <&qspi_clk_pins_a &qspi_bk1_pins_a>;
> -	pinctrl-1 = <&qspi_clk_sleep_pins_a &qspi_bk1_sleep_pins_a>;
> +	pinctrl-0 = <&qspi_clk_pins_a
> +		     &qspi_bk1_pins_a
> +		     &qspi_cs1_pins_a>;
> +	pinctrl-1 = <&qspi_clk_sleep_pins_a
> +		     &qspi_bk1_sleep_pins_a
> +		     &qspi_cs1_sleep_pins_a>;
>   	reg = <0x58003000 0x1000>, <0x70000000 0x200000>;
>   	#address-cells = <1>;
>   	#size-cells = <0>;


Splitting the pins makes sense indeed.

Reviewed-by: Marek Vasut <marex@denx.de>
