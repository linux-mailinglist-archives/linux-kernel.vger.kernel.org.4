Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0703162BB36
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 12:16:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239100AbiKPLQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 06:16:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238938AbiKPLQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 06:16:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8637713D5F;
        Wed, 16 Nov 2022 03:04:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2D18BB81CD3;
        Wed, 16 Nov 2022 11:04:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4EF2C433D6;
        Wed, 16 Nov 2022 11:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668596642;
        bh=f9cz4x++pwxP/IsN9a6YZJDb1JLe80UCfjGruxH/j6o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oRXEvAznRVrzEUAMN+WnD0RqJ/MIm6KP11GoMbGXkObMHjq0VHkI82HwIt2vniBZL
         V1m27Wij7U/J/iPABmteT/l3B3F8ny3Q7w/mGP2OhCxEifkzTIyVZ5AyjJkV3bzga2
         nK5CSfY7xwM1gCzz1oU1aoj0tMEsWMGUZ7jOK7ceuGifczZs7pC0FXooPKwxR2Xf8S
         ja19Qj2dfIoWYh0Ymy2p6IjjrUAgdhcZ7JHKvEM3ClqJEBiKilZdCE+k7EVNTX+MVO
         9R2hRkdb5V8qp9okOGXeXO3cF0W0OY2ODn8q2ES4K9WhPypWtA6KrymfkQUul2XgAH
         xiiNDwrZcXouw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1ovGCa-0006dh-NH; Wed, 16 Nov 2022 12:03:32 +0100
Date:   Wed, 16 Nov 2022 12:03:32 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] arm64: dts: qcom: sc8280xp/sa8540p: add gpr node
Message-ID: <Y3TDhB+QcdAcFfaB@hovoldconsulting.com>
References: <20221115170242.150246-1-srinivas.kandagatla@linaro.org>
 <20221115170242.150246-2-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221115170242.150246-2-srinivas.kandagatla@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2022 at 05:02:40PM +0000, Srinivas Kandagatla wrote:
> Add GPR node along with APM(Audio Process Manager) and PRM(Proxy

Perhaps spell out GPR as well.

> resource Manager) audio services.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 40 ++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> index c32bcded2aef..e3cdd8bccb0c 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> @@ -12,6 +12,7 @@
>  #include <dt-bindings/power/qcom-rpmpd.h>
>  #include <dt-bindings/soc/qcom,rpmh-rsc.h>
>  #include <dt-bindings/thermal/thermal.h>
> +#include <dt-bindings/soc/qcom,gpr.h>

Please keep the include directives sorted.

>  
>  / {
>  	interrupt-parent = <&intc>;
> @@ -1152,6 +1153,45 @@ IPCC_MPROC_SIGNAL_GLINK_QMP
>  
>  				label = "lpass";
>  				qcom,remote-pid = <2>;
> +
> +				gpr {
> +					compatible = "qcom,gpr";
> +					qcom,glink-channels = "adsp_apps";
> +					qcom,domain = <GPR_DOMAIN_ID_ADSP>;
> +					#address-cells = <1>;
> +					#size-cells = <0>;

I'd move the address and size cells properties above the vendor ones.

> +					qcom,intents = <512 20>;
> +
> +					q6apm: q6apm {
> +						reg = <GPR_APM_MODULE_IID>;
> +						compatible = "qcom,q6apm";

Please move compatible before reg throughout.

> +						#sound-dai-cells = <0>;
> +						qcom,protection-domain = "avs/audio", "msm/adsp/audio_pd";
> +						q6apmdai: dais {
> +							compatible = "qcom,q6apm-dais";
> +							#sound-dai-cells = <1>;
> +							iommus = <&apps_smmu 0x0c01 0x0>;
> +						};
> +
> +						q6apmbedai: bedais {
> +							compatible = "qcom,q6apm-lpass-dais";
> +							#sound-dai-cells = <1>;
> +						};
> +					};
> +
> +					q6prm: q6prm {
> +						reg = <GPR_PRM_MODULE_IID>;
> +						compatible = "qcom,q6prm";
> +						#clock-cells = <2>;
> +						qcom,protection-domain = "avs/audio", "msm/adsp/audio_pd";
> +						q6prmcc: cc {
> +							compatible = "qcom,q6prm-lpass-clocks";
> +							#clock-cells = <2>;
> +						};
> +					};
> +

Stray new line.

> +				};
> +

Same here.

>  			};
>  		};

Johan
