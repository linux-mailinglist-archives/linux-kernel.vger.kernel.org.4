Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9DFD653E3B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 11:26:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235225AbiLVK0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 05:26:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbiLVK0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 05:26:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 537D47676;
        Thu, 22 Dec 2022 02:26:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 056CFB81CFA;
        Thu, 22 Dec 2022 10:26:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB2C3C433D2;
        Thu, 22 Dec 2022 10:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671704770;
        bh=rEaTjHoGaG/GmLeHAgYZZfzKQ7QMGfKquTO4exPzJEI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=V5oHZpUdJDz4/HkJZNzeeG0n80vHBGofnb1Q0GsTAj6AS+i5XQjwQn1TGHqUivJ+W
         ExkCuxkIN3YAxwyRUVkfXUVcUg1dmDaGEDxHenCPAx2vJzXhqSzmbRz2baDp5Tp2TB
         zMyuqxP7bcks2x/DxIqIxmvq3eixAO7T1GQMi2c8K33g7wWkA8M2HlHVGurH9nBvup
         Ya7UOmOp9wlrE6MtntrmvUfjKXu1L+Ss6LDNfoUdehCMWmGhiiDtLwP/umYvVf9Mpv
         Lvssx4BTSG28nHi82vbCHtoXEeih2ghkIn6UhTFs0saWdrA2Bpz1hjiPdsB4E083CU
         7WckAzLyIjPhA==
Message-ID: <879325d2-4b2d-bc1d-310c-ece4c449ad8f@kernel.org>
Date:   Thu, 22 Dec 2022 11:26:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [RFC PATCH 3/7] dt-bindings: bus: add STM32MP15 ETZPC firewall
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
 <20221221173055.11719-4-gatien.chevallier@foss.st.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20221221173055.11719-4-gatien.chevallier@foss.st.com>
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
> Adds the list of peripherals IDs under firewall bus on STM32MP15.
> 
> Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>
> ---
>  include/dt-bindings/bus/stm32mp15_sys_bus.h | 98 +++++++++++++++++++++
>  1 file changed, 98 insertions(+)
>  create mode 100644 include/dt-bindings/bus/stm32mp15_sys_bus.h
> 
> diff --git a/include/dt-bindings/bus/stm32mp15_sys_bus.h b/include/dt-bindings/bus/stm32mp15_sys_bus.h
> new file mode 100644
> index 000000000000..97eacc7b5f16
> --- /dev/null
> +++ b/include/dt-bindings/bus/stm32mp15_sys_bus.h

That's wrong in multiple ways:
1. No underscores
2. Missing vendor prefix
3. Name not matching compatible.

> @@ -0,0 +1,98 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +/*
> + * Copyright (C) STMicroelectronics 2022 - All Rights Reserved
> + */
> +#ifndef _DT_BINDINGS_BUS_STM32MP15_SYS_BUS_H
> +#define _DT_BINDINGS_BUS_STM32MP15_SYS_BUS_H
> +
> +/* ETZPC IDs */
> +#define STM32MP1_ETZPC_STGENC_ID	0
> +#define STM32MP1_ETZPC_BKPSRAM_ID	1
> +#define STM32MP1_ETZPC_IWDG1_ID		2
> +#define STM32MP1_ETZPC_USART1_ID	3
> +#define STM32MP1_ETZPC_SPI6_ID		4
> +#define STM32MP1_ETZPC_I2C4_ID		5
> +/* ID 6 reserved */

Reserved why? These are IDs so they start from 0 and go by 0. Don't
hard-code some register offsets.

Best regards,
Krzysztof

