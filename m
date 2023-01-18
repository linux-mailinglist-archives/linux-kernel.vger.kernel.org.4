Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A09DE67202C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 15:51:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231577AbjAROvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 09:51:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231573AbjAROv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 09:51:29 -0500
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A70134C00;
        Wed, 18 Jan 2023 06:44:20 -0800 (PST)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 81BD380CB0;
        Wed, 18 Jan 2023 15:44:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1674053058;
        bh=YJuTQgGzPahBwKm4IFtcujGuauKpmm3/Z5oTWiYcubM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=UxS8OCqjyxc6iOgj3qrQRQgWJhz+vCGO3J3JsHqFWPD/Fr+6J7S+HHDQYua9oV702
         /WLwGutZWFJyOh7RAT5sz7OJz/6X0A+q3d0FBHl7A0khWSU4oCMOqxuwtI0XSJMBOc
         hxwohDT6u5dZSIDX2o1OyiD3wmVUJgYMSr8jW2vLhcB9Vjkxx5V1rgJ/qDJTRzCIvs
         dDR8Dcg1w8DSeCPG9H6rEwwAvV+9Fy9TVfb1wCu6CQWrLdpnMOWCm26FE33lcQXlZJ
         k/vEUWhUanS39j3YbX10c/KNlm27WeiS9g9ZbNj/6vJzwanNxj6LOxnsjODMuh/6RM
         SkEFxnCAVe3PA==
Message-ID: <c55d26a9-21dc-4c64-38fa-446975df16cd@denx.de>
Date:   Wed, 18 Jan 2023 15:44:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 2/3] arm64: dts: imx8mm-verdin: Add yavia carrier board
Content-Language: en-US
To:     Philippe Schenker <dev@pschenker.ch>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Philippe Schenker <philippe.schenker@toradex.com>,
        Aishwarya Kothari <aishwarya.kothari@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Reinhold Mueller <reinhold.mueller@emtrion.com>,
        Tim Harvey <tharvey@gateworks.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230118144042.7705-1-dev@pschenker.ch>
 <20230118144042.7705-3-dev@pschenker.ch>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <20230118144042.7705-3-dev@pschenker.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/18/23 15:40, Philippe Schenker wrote:

[...]

> +	leds {
> +		compatible = "gpio-leds";
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_leds_yavia>;
> +
> +		/* SODIMM 52 */
> +		led-1 {
> +			label = "LD1_RED";

I think label is deprecated in 
Documentation/devicetree/bindings/leds/common.yaml in favor of 
function/function-enumerator/color bindings.

[...]
