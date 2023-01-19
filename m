Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3CFC6737E1
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 13:06:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbjASMGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 07:06:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbjASMGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 07:06:32 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C8E51737
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 04:06:31 -0800 (PST)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1pITgU-0001is-CQ; Thu, 19 Jan 2023 13:06:22 +0100
Message-ID: <729c4be6-00f7-4b88-235e-0e9bdeed3e5f@pengutronix.de>
Date:   Thu, 19 Jan 2023 13:06:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [Linux-stm32] [PATCH v6 1/3] ARM: dts: stm32mp13: fix compatible
 for BSEC
Content-Language: en-US
To:     Patrick Delaunay <patrick.delaunay@foss.st.com>,
        Alexandre TORGUE <alexandre.torgue@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Etienne CARRIERE <etienne.carriere@linaro.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
References: <20230118172940.841094-1-patrick.delaunay@foss.st.com>
 <20230118182856.v6.1.I167a5efc1f8777cce14518c6fa38400ac684de3e@changeid>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <20230118182856.v6.1.I167a5efc1f8777cce14518c6fa38400ac684de3e@changeid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.01.23 18:29, Patrick Delaunay wrote:
> Use the correct compatible for stm32mp13 support.
> 
> The BSEC driver for STM32MP15x is not compatible with STM32MP13x. For
> example the proprietary's smc STM32_SMC_BSEC is not supported in
> STM32MP13x OP-TEE, it is replaced by SM32MP BSEC Pseudo Trusted
> Application in OP-TEE to access to the secured IP BSEC on STM32MP13X SoC.
> 
> The correct compatible is already used in U-Boot and in upstream is in
> progress for OP-TEE device tree.
> 
> As the SoC STM32MP13X is not yet official and it is not available
> outside STMicroelectronics, it is the good time to break the DTS
> compatibility and to correct the error done in the introduction of
> STM32MP131.
> 
> Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>

Reviewed-by: Ahmad Fatoum <a.fatoum@pengutronix.de>

> ---
> This patch is already sent separately in:
> https://lore.kernel.org/all/20221017134437.1.I167a5efc1f8777cce14518c6fa38400ac684de3e@changeid/
> https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=685815
> 
> I create a serie for more efficient review.
> 
> Patrick.
> 
> (no changes since v1)
> 
> Changes in v1:
> - update commit message to indicate DTS break reason.
> 
>  arch/arm/boot/dts/stm32mp131.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/stm32mp131.dtsi b/arch/arm/boot/dts/stm32mp131.dtsi
> index accc3824f7e9..0b79380cc627 100644
> --- a/arch/arm/boot/dts/stm32mp131.dtsi
> +++ b/arch/arm/boot/dts/stm32mp131.dtsi
> @@ -520,7 +520,7 @@ rtc: rtc@5c004000 {
>  		};
>  
>  		bsec: efuse@5c005000 {
> -			compatible = "st,stm32mp15-bsec";
> +			compatible = "st,stm32mp13-bsec";
>  			reg = <0x5c005000 0x400>;
>  			#address-cells = <1>;
>  			#size-cells = <1>;

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

