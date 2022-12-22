Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14C59654675
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 20:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbiLVTSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 14:18:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiLVTSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 14:18:35 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C9DF8
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 11:18:34 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id g13so4128139lfv.7
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 11:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+nIjDYFZ/q7w9qAhp90+SKidk8iu8dhx1d9mlC/tW0c=;
        b=yrRJPcE78fNCnK9sR1nhZnrkvIK0a8Jlo4I9kpkI7hsxVyOT0DRmxB3n4qYH95gbiD
         Abpr7j/RSJRtamJnLwjBLT4KmXUyp3ogiQ/7R6tXldS3TNrXLYhCwEQFgUJYB7FlaRon
         CmMIGrLbfcVUMI7ypnCpSpn0n+cBmFbHDNiUZxXfk2eSj2fj4LCYLHwIcAWhG1PxkKXk
         FZbZkUVGCV8jz7HLm1vmui7AhGLNEkF6GOMjg8pPu3v+chy4roDh/v5fUTL6wKCRUhd8
         C3s/eqJ8DpA/MT6R512ly5RM0dKxv+Y8mgAXGEpRdfZUE17qWNEAGv1bRVfhV55k5q+F
         kd0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+nIjDYFZ/q7w9qAhp90+SKidk8iu8dhx1d9mlC/tW0c=;
        b=MHr5AcI0axil54XyBPZi7WN7bJZTNaYIA2NIP/VdWlqNwIHZbrAvH/vVDGY+Q4yS59
         vn8TZdO0swE3kqiP3pKW+VHsvJ9iy3Qf83E/xgMpAOL8SiN0VoIkSK1LAuHGFI2QUEbk
         /zKySHvf0pe8PebiIjhh6qx1qcjBIpfmX/WAQlnn9SjqyL7RESw+tiFEz8jrHe04bcxQ
         zing1vhqwAerNyDZEw6Gk86YZCUsAhFHGnTDKDbHF2Dhudimv+wSvI4+b3Vy/jJhyf7J
         r1LphDecq3t/9hXBtnTZ3KsweEcCFHUezmgFP4Waq8xSbQvj6D3dQZ9foDsOXhHBVxXX
         kFWQ==
X-Gm-Message-State: AFqh2kqxyJMRDALieWfoicwGdwuU6UApUcdSkVMwCI1VNmXTddLR2+yy
        ZpMFmdWEI202KDqDOS6qDZCU/w==
X-Google-Smtp-Source: AMrXdXuRA2TZlXiMk/H+rp6r4ihck4Na/0nUwW3npG2/RhtLvzSRWFzNQwklWFPqZmKwzcBtBhNBmA==
X-Received: by 2002:ac2:5102:0:b0:4b5:6649:eb6c with SMTP id q2-20020ac25102000000b004b56649eb6cmr2397541lfb.25.1671736712582;
        Thu, 22 Dec 2022 11:18:32 -0800 (PST)
Received: from [192.168.1.101] (abyl184.neoplus.adsl.tpnet.pl. [83.9.31.184])
        by smtp.gmail.com with ESMTPSA id c11-20020a056512324b00b004b550c26949sm169532lfr.290.2022.12.22.11.18.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Dec 2022 11:18:32 -0800 (PST)
Message-ID: <d1e1b18c-0d17-2145-0fc2-3f9be8d68fe9@linaro.org>
Date:   Thu, 22 Dec 2022 20:18:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] arm64: dts: qcom: sdm845-tama: Add volume up and camera
 GPIO keys
Content-Language: en-US
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        phone-devel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221222190656.31664-1-marijn.suijten@somainline.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221222190656.31664-1-marijn.suijten@somainline.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22.12.2022 20:06, Marijn Suijten wrote:
> Tama has four GPIO-wired keys: two for camera focus and shutter /
> snapshot, and two more for volume up and down.  As per the comment these
> used to not work because the necessary pin bias was missing, which is
> now set via pinctrl on pm8998_gpio(s).
> 
> The missing bias has also been added to the existing volume down button,
> which receives a node name and label cleanup at the same time to be more
> consistent with other DTS and the newly added buttons.  Its deprecated
> gpio-key,wakeup property has also been replaced with wakeup-source.
> 
> Note that volume up is also available through the usual PON RESIN node,
> but unlike other platforms only triggers when the power button is held
> down at the same time making it unsuitable to serve as KEY_VOLUMEUP.
Sounds rather intriguing..

> 
> Fixes: 30a7f99befc6 ("arm64: dts: qcom: Add support for SONY Xperia XZ2 / XZ2C / XZ3 (Tama platform)")
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  .../dts/qcom/sdm845-sony-xperia-tama.dtsi     | 72 +++++++++++++++++--
>  1 file changed, 68 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi b/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi
> index 87dd0fc36747..6390dadd5f82 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi
> @@ -4,6 +4,7 @@
>   */
>  
>  #include <dt-bindings/input/input.h>
> +#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
>  #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>  #include "sdm845.dtsi"
>  #include "pm8005.dtsi"
> @@ -17,14 +18,43 @@ / {
>  	gpio-keys {
>  		compatible = "gpio-keys";
>  
> -		/* Neither Camera Focus, nor Camera Shutter seem to work... */
> +		pinctrl-0 = <&focus_n &snapshot_n &vol_down_n &vol_up_n>;
> +		pinctrl-names = "default";
>  
> -		key-vol-down {
> -			label = "volume_down";
> +		key-camera-focus {
> +			label = "Camera Focus";
> +			gpios = <&pm8998_gpio 2 GPIO_ACTIVE_LOW>;
> +			linux,code = <KEY_CAMERA_FOCUS>;
> +			debounce-interval = <15>;
> +			linux,can-disable;
> +			wakeup-source;
> +		};
> +
> +		key-camera-snapshot {
> +			label = "Camera Snapshot";
> +			gpios = <&pm8998_gpio 7 GPIO_ACTIVE_LOW>;
> +			linux,code = <KEY_CAMERA>;
> +			debounce-interval = <15>;
> +			linux,can-disable;
> +			wakeup-source;
> +		};
> +
> +		key-volume-down {
> +			label = "Volume Down";
>  			gpios = <&pm8998_gpio 5 GPIO_ACTIVE_LOW>;
>  			linux,code = <KEY_VOLUMEDOWN>;
>  			debounce-interval = <15>;
> -			gpio-key,wakeup;
> +			linux,can-disable;
> +			wakeup-source;
> +		};
> +
> +		key-volume-up {
> +			label = "Volume Up";
> +			gpios = <&pm8998_gpio 6 GPIO_ACTIVE_LOW>;
> +			linux,code = <KEY_VOLUMEUP>;
> +			debounce-interval = <15>;
> +			linux,can-disable;
> +			wakeup-source;
>  		};
>  	};
>  
> @@ -358,6 +388,40 @@ &i2c14 {
>  	/* AMS TCS3490 RGB+IR color sensor @ 72 */
>  };
>  
> +&pm8998_gpio {
> +	focus_n: focus-n-state {
> +		pins = "gpio2";
> +		function = PMIC_GPIO_FUNC_NORMAL;
> +		power-source = <0>;
> +		bias-pull-up;
> +		input-enable;
> +	};
> +
> +	vol_down_n: vol-down-n-state {
> +		pins = "gpio5";
> +		function = PMIC_GPIO_FUNC_NORMAL;
> +		power-source = <0>;
> +		bias-pull-up;
> +		input-enable;
> +	};
> +
> +	vol_up_n: vol-up-n-state {
> +		pins = "gpio6";
> +		function = PMIC_GPIO_FUNC_NORMAL;
> +		power-source = <0>;
> +		bias-pull-up;
> +		input-enable;
> +	};
> +
> +	snapshot_n: snapshot-n-state {
> +		pins = "gpio7";
> +		function = PMIC_GPIO_FUNC_NORMAL;
> +		power-source = <0>;
> +		bias-pull-up;
> +		input-enable;
> +	};
> +};
> +
>  &qupv3_id_0 {
>  	status = "okay";
>  };
