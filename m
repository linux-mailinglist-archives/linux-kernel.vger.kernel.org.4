Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E08FB65BCF9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 10:19:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236934AbjACJTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 04:19:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233084AbjACJTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 04:19:35 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD9526579
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 01:19:33 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id m6so34461281lfj.11
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 01:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d/gNsxbPdD+yd4ZyfRtM9n+416cI1Eo6R+OxX/6XXqQ=;
        b=iZYQGiAR04+QsxoX+dDgtvou3KDWhG7Jkfi5JdkrznxgZ8SoXxbONraRfnsFZI/neC
         o7tJp1wywiet9jOLXF3oAKPo7L6NEr2RW6A3kja7HGxa5ZOg2UjhIf088wfc/ozxhG0W
         Mg+AfpckSkD6nYWVRlkfM25aOhzkpV8vvzZDTU0iEEYnyrDOSgL6EmiPr83hSg45plVC
         WqN47fY9M7q7jLFsj2AAA11VWYch503RI1vp0koUI/di6UMIiLnN9c97Q2BDWW5vSIs4
         p+7bw1BmLwEBNkA+QokpXPKWbCpQvBE9oeF48NYuwr0akT/OcmB6F3Ejh7Phn0WvU58r
         XUvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d/gNsxbPdD+yd4ZyfRtM9n+416cI1Eo6R+OxX/6XXqQ=;
        b=WT37wioNoTiEfIHm+Q8G7n1Fjtga82UEBs/voYyWxLC5bZ0QErIjR6yQhcXZDrrJ+G
         mfUYPSqmO9DboSYh6/Xc61LVS/kQUl0c/4olGMeiY/UHHcawgzO8KqH3V/bbUuRcyG+K
         oamF6PXKRQaU35bQtocZhElLLjHJVajak67vDraYTp0ccy/tlb/DXYSG5H1pnm+Pcht7
         BEARrfjIEmo/Mo/OoJkeAnjxpBV8KwowIqwkMn2Y0I3rUVmBIDIsMjJR7Ug5OB63w2s+
         Uk9oBZRCUuJFCABsJTTGwmPeY3Zfs9VSxcwvrYLg+WRVY4/oirW86UIcY7nIyPnNKlWD
         bzgA==
X-Gm-Message-State: AFqh2kqjxXsYnikrkyLM+jG88tzvDfVsdtMKPMqHZhNQzyfswl3Jm1Za
        SEu0Oo9+xHWuDxVHBKixx1q9zw==
X-Google-Smtp-Source: AMrXdXtWsL+F0QTtFzVogEAPA1QaD/tPNMjMPdjRCj4mIeBIeClTJCJMt72emfuB6kfIN1uv2/+vGQ==
X-Received: by 2002:a05:6512:2629:b0:4ca:f9b6:d914 with SMTP id bt41-20020a056512262900b004caf9b6d914mr11687987lfb.7.1672737572067;
        Tue, 03 Jan 2023 01:19:32 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id p2-20020ac246c2000000b004b5a85e369asm4780358lfo.252.2023.01.03.01.19.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jan 2023 01:19:31 -0800 (PST)
Message-ID: <e354421c-55b2-65dc-ca45-1c53696e4069@linaro.org>
Date:   Tue, 3 Jan 2023 10:19:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 7/7] arm64: dts: qcom: Add msm8939 Sony Xperia M4 Aqua
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, djakov@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        benl@squareup.com, shawn.guo@linaro.org, fabien.parent@linaro.org,
        leo.yan@linaro.org, dmitry.baryshkov@linaro.org
References: <20230103010904.3201835-1-bryan.odonoghue@linaro.org>
 <20230103010904.3201835-8-bryan.odonoghue@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230103010904.3201835-8-bryan.odonoghue@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/01/2023 02:09, Bryan O'Donoghue wrote:
> Add a basic booting DTS for the Sony Xperia M4 Aqua aka "tulip".
> 
> Tulip is paired with:
> 
> - wcn3660
> - smb1360 battery charger
> - 720p Truly NT35521 Panel
> 
(...)

> +&dsi_phy0 {
> +	vddio-supply = <&pm8916_l16>;
> +	status = "okay";
> +};
> +
> +&msmgpio {
> +

Drop blank line.

> +	ak8963_default: ak8963-default-state {
> +		pins = "gpio69";
> +		function = "gpio";
> +		drive-strength = <6>;
> +		bias-pull-up;
> +	};
> +
> +	ak8963_sleep: ak8963-sleep-state {
> +		pins = "gpio69";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-pull-down;
> +	};
> +
> +	/* Ambient light and proximity sensor apds9930 and apds9900 */
> +	apds99xx_default: apds99xx-default-state {
> +		pins = "gpio113";
> +		function = "gpio";
> +		drive-strength = <6>;
> +		bias-pull-up;
> +	};
> +
> +	apds99xx_sleep: apds99xx-sleep-state {
> +		pins = "gpio113";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-pull-down;
> +	};
> +
> +	cam_sensor_flash_default: cam-sensor-flash-default-state {
> +		pins = "gpio98", "gpio97";
> +		function = "gpio";
> +		bias-disable;
> +		drive-strength = <2>;
> +	};
> +
> +	cci1_default: cci1-default-state {
> +		pins = "gpio31", "gpio32";
> +		function = "cci_i2c";
> +		drive-strength = <2>;
> +		bias-disable;
> +	};
> +
> +	cdc_ext_spk_pa_active: cdc-ext-spk-pa-on-state {
> +		pins = "gpio0";
> +		function = "gpio";
> +		drive-strength = <8>;
> +		output-low;
> +	};
> +
> +	cdc_ext_spk_pa_sus: cdc-ext-spk-pa-off-state {
> +		pins = "gpio0";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-disable;
> +	};
> +
> +	cdc_slim_lines_act: lines-on-state {
> +		pins = "gpio63";
> +		function = "cdc_pdm0";
> +		drive-strength = <8>;
> +		output-high;
> +	};
> +
> +	cdc_slim_lines_sus: lines-off-state {
> +		pins = "gpio63";
> +		function = "cdc_pdm0";
> +		drive-strength = <2>;
> +		bias-disable;
> +	};
> +
> +	cross_conn_det_act: lines-on-state {
> +		pins = "gpio120";
> +		function = "gpio";
> +		drive-strength = <8>;
> +		output-low;
> +		bias-pull-down;
> +	};
> +
> +	cross_conn_det_sus: lines-off-state {
> +		pins = "gpio120";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-pull-down;
> +	};
> +
> +	ext_buck_vsel: vsel0-state {
> +		pins = "gpio111";
> +		function = "gpio";
> +		drive-strength = <2>;
> +	};
> +
> +	ext_cdc_tlmm_lines_act: tlmm-lines-on-state {
> +		pins = "gpio116", "gpio112", "gpio117", "gpio118", "gpio119";
> +		function = "gpio";
> +		drive-strength = <8>;
> +	};
> +
> +	ext_cdc_tlmm_lines_sus: tlmm-lines-off-state {
> +		pins = "gpio116", "gpio112", "gpio117", "gpio118", "gpio119";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-disable;
> +	};
> +
> +	gpio_key_suspend: gpio-key-suspend-state {
> +		pins = "gpio107", "gpio108", "gpio109";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-pull-up;
> +	};
> +
> +	negative5_reg_default: negative5-reg-default-state {
> +		pins = "gpio17";
> +		function = "gpio";
> +		output-low;
> +	};
> +
> +	positive5_reg_default: positive5-reg-default-state {
> +		pins = "gpio114";
> +		function = "gpio";
> +		output-low;
> +	};
> +
> +	/* Gyroscope and accelerometer sensor combo */
> +	mpu6050_default: mpu6050-default-state {
> +		pins = "gpio115";
> +		function = "gpio";
> +		drive-strength = <6>;
> +		bias-pull-up;
> +	};
> +
> +	mpu6050_sleep: mpu6050-sleep-state {
> +		pins = "gpio115";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-pull-down;
> +	};
> +
> +	nfc_disable_active: nfc-disable-active-state {
> +		pins = "gpio20";
> +		function = "gpio";
> +		drive-strength = <6>;
> +		bias-pull-up;
> +	};
> +
> +	nfc_disable_suspend: nfc-disable-suspend-state {
> +		pins = "gpio20";
> +		function = "gpio";
> +		drive-strength = <6>;
> +		bias-disable;
> +	};
> +
> +	nfc_int_active: nfc-int-active-state {
> +		pins = "gpio21";
> +		function = "gpio";
> +		drive-strength = <6>;
> +		bias-pull-up;
> +	};
> +
> +	nfc_int_suspend: nfc-int-suspend-state {
> +		pins = "gpio21";
> +		function = "gpio";
> +		drive-strength = <6>;
> +		bias-pull-up;
> +	};
> +
> +	nt35521_te_default: nt35521-te-default-state {
> +		pins = "gpio24";
> +		function = "gpio";
> +		drive-strength = <6>;
> +		bias-pull-down;
> +	};
> +
> +	nt35521_backlight: nt35521-backlight-default-state {
> +		pins = "gpio10";
> +		function = "gpio";
> +		drive-strength = <6>;
> +		bias-pull-down;
> +	};
> +
> +	smb_int: smb-int-default-state {
> +		pins = "gpio62";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-pull-up;
> +	};
> +
> +	/* add pingrp for touchscreen */
> +	ts_int_active: ts-int-active-state {
> +		pins = "gpio13";
> +		function = "gpio";
> +		drive-strength = <16>;
> +		bias-pull-up;
> +	};
> +
> +	ts_int_suspend: ts-int-suspend-state {
> +		pins = "gpio13";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-pull-down;
> +	};
> +
> +	ts_reset_active: ts-reset-active-state {
> +		pins = "gpio12";
> +		function = "gpio";
> +		drive-strength = <16>;
> +		bias-pull-up;
> +	};
> +
> +	ts_reset_suspend: ts-reset-suspend-state {
> +		pins = "gpio12";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-pull-down;
> +	};
> +
> +	ts_release: ts-release-default-state {
> +		pins = "gpio13", "gpio12";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-pull-down;
> +	};
> +
> +	usb_id_default: usb-id-default-state {
> +		pins = "gpio110";
> +		function = "gpio";
> +
> +		drive-strength = <8>;
> +		bias-pull-up;
> +	};
> +};
> +
> +&pronto {
> +	status = "okay";

Blank line.

> +	iris {
> +		compatible = "qcom,wcn3660";
> +	};
> +};
> +

Best regards,
Krzysztof

