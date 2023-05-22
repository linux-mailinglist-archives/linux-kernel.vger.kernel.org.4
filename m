Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 208C470B7DD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 10:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjEVImj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 04:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbjEVImf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 04:42:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1CE9B6;
        Mon, 22 May 2023 01:42:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6ED1E61EEA;
        Mon, 22 May 2023 08:42:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C10DFC433D2;
        Mon, 22 May 2023 08:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684744953;
        bh=HIGTSD/vvdWcZODz0o7xC7IWIgnQxzwUcLiD/t29xIA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gXnH98Y9zE9UXL0YjMpznFUlkCZ0fYCG17hK+orCQaAZVv8yka+aZEvP7pm3tg3nm
         f9IdUJgE9hf4IMXvgASPK97LiJE0ghD7XBUGHDQFPSaESgLexuVNFjNDYa008a0UKT
         XRG7wgNRGZzOBFfFYf/Me/XmAduvtVirnOAKXtyRVVoKEE5Wze6X7ok+P6b6mb55SB
         ECxK4sYfeEILDaNHp0cd5bcUkU17QLWXfGXyZm/9tzm/xuwQNqhor8lHLIUhZZqiZE
         eVwkdRuOaNXjmsgNxQeoMOvayQdKRufjjCxCfZcMHgz7FWbTmRKH1OEwEdx92rbptP
         JKBcAekcLXkVQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1q117h-0004Wq-6e; Mon, 22 May 2023 10:42:33 +0200
Date:   Mon, 22 May 2023 10:42:33 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, johan+linaro@kernel.org,
        agross@kernel.org, konrad.dybcio@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] arm64: dts: qcom: sc8280xp: add resets for soundwire
 controllers
Message-ID: <ZGsq-Rn8fDn3GuwQ@hovoldconsulting.com>
References: <20230518113800.339158-1-srinivas.kandagatla@linaro.org>
 <20230518113800.339158-6-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230518113800.339158-6-srinivas.kandagatla@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 18, 2023 at 12:38:00PM +0100, Srinivas Kandagatla wrote:
> Soundwire controllers on sc8280xp needs an explicit reset, this
> patch adds support for this.

s/this patch adds/add/

> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> index d2a2224d138a..a2d0f8abe23d 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> @@ -6,6 +6,7 @@
>  
>  #include <dt-bindings/clock/qcom,dispcc-sc8280xp.h>
>  #include <dt-bindings/clock/qcom,gcc-sc8280xp.h>
> +#include <dt-bindings/clock/qcom,lpasscc-sc8280xp.h>
>  #include <dt-bindings/clock/qcom,rpmh.h>
>  #include <dt-bindings/interconnect/qcom,osm-l3.h>
>  #include <dt-bindings/interconnect/qcom,sc8280xp.h>
> @@ -2548,6 +2549,8 @@ rxmacro: rxmacro@3200000 {
>  		swr1: soundwire-controller@3210000 {
>  			compatible = "qcom,soundwire-v1.6.0";
>  			reg = <0 0x03210000 0 0x2000>;
> +			resets = <&lpass_audiocc LPASS_AUDIO_SWR_RX_CGCR>;
> +			reset-names = "swr_audio_cgcr";

Move after clocks.

>  			interrupts = <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>;
>  			clocks = <&rxmacro>;
>  			clock-names = "iface";
> @@ -2647,6 +2650,13 @@ swr0: soundwire-controller@3250000 {
>  			status = "disabled";
>  		};
>  
> +		lpass_audiocc: clock-controller@3300000 {
> +			compatible = "qcom,sc8280xp-lpassaudiocc";
> +			reg = <0 0x032a9000 0 0x1000>;

Either this property or the unit address is wrong as they do not match.

The bindings currently mandates that vendor property you added
("qcom,adsp-pil-mode), but you left it out here.

> +			#reset-cells = <1>;
> +			#clock-cells = <1>;

clock before reset for some sort order.

> +		};
> +

Your preliminary version of this patch also added a reset to swr0, which
has been left out here. Was that not needed?

>  		swr2: soundwire-controller@3330000 {
>  			compatible = "qcom,soundwire-v1.6.0";
>  			reg = <0 0x03330000 0 0x2000>;
> @@ -2654,6 +2664,8 @@ swr2: soundwire-controller@3330000 {
>  				     <GIC_SPI 520 IRQ_TYPE_LEVEL_HIGH>;
>  			interrupt-names = "core", "wakeup";
>  
> +			resets = <&lpasscc LPASS_AUDIO_SWR_TX_CGCR>;
> +			reset-names = "swr_audio_cgcr";

Add after clocks.

>  			clocks = <&txmacro>;
>  			clock-names = "iface";
>  			label = "TX";
> @@ -2849,6 +2861,13 @@ data-pins {
>  			};
>  		};
>  
> +		lpasscc: clock-controller@33e0000 {
> +			compatible = "qcom,sc8280xp-lpasscc";
> +			reg = <0 0x033e0000 0 0x21000>;

Your driver (and the binding example) seems to suggest that the size
here should be 0x12000.

The vendor property appears to be missing here too (or the binding is
incorrect).

> +			#reset-cells = <1>;
> +			#clock-cells = <1>;

clock before reset

> +		};
> +
>  		usb_0_qmpphy: phy@88eb000 {
>  			compatible = "qcom,sc8280xp-qmp-usb43dp-phy";
>  			reg = <0 0x088eb000 0 0x4000>;

Johan
