Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C091653E3E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 11:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235282AbiLVK0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 05:26:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbiLVK0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 05:26:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A1F4FAF6;
        Thu, 22 Dec 2022 02:26:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 35C5BB81D11;
        Thu, 22 Dec 2022 10:26:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B70BC433EF;
        Thu, 22 Dec 2022 10:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671704795;
        bh=nTIprPbBPmmuP2oq21PiemF3QPCICgFm0PU6xvFtAXk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=mI2799M0UatDu42RK5leXd/+q5Dwcb2aJAqYO1dYobXBlJuUYpoxDLucNgiuDvy+A
         h5z3ap9QXga0Nr/33171JTHyfhXNyTzb/m1ZZ+iV4MQQKUYI9kdSARKhIYFG9F+DRb
         PsLpioL2I1QH7bT/EE0hkLZ5J7+pbCnudlE38zg1j8TI7aewy+IZDpdhc4ekQY6qLj
         CMyFQHPr5If7+4rbGIH7KBT3yLL+HF67tLpYhX4/yZpVXGv/kpVgz3wID1cHkDqoeP
         qsFI/GbTeHoVKoIhqgHVbIRX1rWFEBVa09AjdFqcUTrl9E8YU3mbLdBUPqY83xwisw
         hcsoRNbiu40Vg==
Message-ID: <85c3352c-b427-c440-a1bd-57f830c14c50@kernel.org>
Date:   Thu, 22 Dec 2022 11:26:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [RFC PATCH 4/7] dt-bindings: bus: add STM32MP13 ETZPC firewall
 bus bindings
Content-Language: en-US
To:     Gatien Chevallier <gatien.chevallier@foss.st.com>,
        alexandre.torgue@foss.st.com, robh+dt@kernel.org,
        Oleksii_Moisieiev@epam.com, linus.walleij@linaro.org,
        gregkh@linuxfoundation.org
Cc:     linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        loic.pallardy@st.com, devicetree@vger.kernel.org,
        mark.rutland@arm.com, arnd@arndb.de
References: <20221221173055.11719-1-gatien.chevallier@foss.st.com>
 <20221221173055.11719-5-gatien.chevallier@foss.st.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20221221173055.11719-5-gatien.chevallier@foss.st.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/12/2022 18:30, Gatien Chevallier wrote:
> Adds the list of peripherals IDs under firewall bus on STM32MP13.
> 
> Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>
> ---
>  include/dt-bindings/bus/stm32mp13_sys_bus.h | 60 +++++++++++++++++++++
>  1 file changed, 60 insertions(+)
>  create mode 100644 include/dt-bindings/bus/stm32mp13_sys_bus.h
> 
> diff --git a/include/dt-bindings/bus/stm32mp13_sys_bus.h b/include/dt-bindings/bus/stm32mp13_sys_bus.h
> new file mode 100644
> index 000000000000..1160de87bc4a
> --- /dev/null
> +++ b/include/dt-bindings/bus/stm32mp13_sys_bus.h
> @@ -0,0 +1,60 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +/*
> + * Copyright (C) STMicroelectronics 2022 - All Rights Reserved
> + */
> +#ifndef _DT_BINDINGS_BUS_STM32MP13_SYS_BUS_H
> +#define _DT_BINDINGS_BUS_STM32MP13_SYS_BUS_H
> +
> +/* ETZPC IDs */
> +#define STM32MP1_ETZPC_VREFBUF_ID	0
> +#define STM32MP1_ETZPC_LPTIM2_ID	1
> +#define STM32MP1_ETZPC_LPTIM3_ID	2
> +#define STM32MP1_ETZPC_LTDC_ID		3
> +#define STM32MP1_ETZPC_DCMIPP_ID	4
> +#define STM32MP1_ETZPC_USBPHYCTRL_ID	5
> +#define STM32MP1_ETZPC_DDRCTRLPHY_ID	6
> +/* IDs 7-11 reserved */
> +#define STM32MP1_ETZPC_IWDG1_ID		12
> +#define STM32MP1_ETZPC_STGENC_ID	13
> +/* IDs 14-15 reserved */
> +#define STM32MP1_ETZPC_USART1_ID	16
> +#define STM32MP1_ETZPC_USART2_ID	17
> +#define STM32MP1_ETZPC_SPI4_ID		18
> +#define STM32MP1_ETZPC_SPI5_ID		19
> +#define STM32MP1_ETZPC_I2C3_ID		20
> +#define STM32MP1_ETZPC_I2C4_ID		21
> +#define STM32MP1_ETZPC_I2C5_ID		22
> +#define STM32MP1_ETZPC_TIM12_ID		23
> +#define STM32MP1_ETZPC_TIM13_ID		24
> +#define STM32MP1_ETZPC_TIM14_ID		25
> +#define STM32MP1_ETZPC_TIM15_ID		26
> +#define STM32MP1_ETZPC_TIM16_ID		27
> +#define STM32MP1_ETZPC_TIM17_ID		28
> +/* IDs 29-31 reserved */

Same comments (all of them). IDs cannot be reserved.

Best regards,
Krzysztof

