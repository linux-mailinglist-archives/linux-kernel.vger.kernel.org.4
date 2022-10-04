Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA69B5F3D0A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 09:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbiJDHHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 03:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbiJDHHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 03:07:08 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC593DBFB
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 00:07:06 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id bs18so12691856ljb.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 00:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=b3hNZwmZyFy/xOhulemGtHZ8byzYtjyXSAifiACW+Q4=;
        b=ALgFRgtjPCe3hUl+SpgglaCF3oQaWbTsfs+CHfWQ6wvy5oy9Xll4iZUURHYz+aUFgs
         7fVlFfBDC4ys2g/9DdgOiQh5Enln0JrbHC8VaYZhkl662Sz/IMRTWtFyBYjz45dShaGC
         8isy7Kcg6b04rdKYQGOSzo+yI8QGGZ+/xEn9ORrl1pCVX/nZBbkASH+exzrPl7MxrRPW
         hpwEUJYNvBkM5QcQ44+wF8ZBl4wpkLNd4iLb/wLBIhHf5j26D/KEFfUi7lxfDYpJDGff
         14Ut7tsBFf4oJV1I5DSKnHl8GOfiBg5g6XRaHKyg614LQz1UbRYj5FxRsduUUhSJiL/d
         TqvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=b3hNZwmZyFy/xOhulemGtHZ8byzYtjyXSAifiACW+Q4=;
        b=wNNFQl6Rnm3hH2nvgHtn6xr+Zqarw7xDAM7VmkOQVFr8cpydd6IR8EY40JQbJR0a6l
         NxYVcw2FRknUFcwc2ZANm9IfclfnLMIK3flzyZeetudeOHdU8ov3QRJsTVtZZsCwQCsk
         o9uAbx3n9VBrezp48HuD5eWm/Ws22dggilV2BwLYPWzdCgJsuyE40SwIRFmYwtVohFHe
         KrMSOehJMmxRtJ6SbqrITaMkEGepO2qRVkyPFNC6diKmViYcdVKyzKwQE/3TIKLEjWKp
         fTfPq5WlhmfVM2p/K/qH/GgDJw5uG0dc/czY2fLbc4QS/INMz0kZq/VCUQgvvoLKu/cQ
         W0Gw==
X-Gm-Message-State: ACrzQf0grYG7+JJOzlcyrQw9N8G/xXcpwSVEgPEbMc+zaw81YFAtjD6O
        stJAyHml+OaLqslHeiXp1cgAXg==
X-Google-Smtp-Source: AMsMyM4HM5M9/Rvi0MTsnNMyZYgZrZm00DDBXJiWXvNeMHU+7P+7jyU4L/inah1+jNARgLiwnwUhNA==
X-Received: by 2002:a2e:6d02:0:b0:26a:cf02:40c4 with SMTP id i2-20020a2e6d02000000b0026acf0240c4mr8259235ljc.513.1664867224822;
        Tue, 04 Oct 2022 00:07:04 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id a37-20020a05651c212500b0026dc7b59d8esm978446ljq.22.2022.10.04.00.07.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Oct 2022 00:07:04 -0700 (PDT)
Message-ID: <6e2a25b1-3158-e3fc-8290-5064009972c7@linaro.org>
Date:   Tue, 4 Oct 2022 09:07:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v3 1/2] arm64: dts: qcom: sagit: add initial device tree
 for sagit
Content-Language: en-US
To:     Dzmitry Sankouski <dsankouski@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
References: <20221003185500.928608-1-dsankouski@gmail.com>
 <20221003185500.928608-2-dsankouski@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221003185500.928608-2-dsankouski@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/10/2022 20:54, Dzmitry Sankouski wrote:
> New device support - Xiaomi Mi6 phone
> 
> What works:
> - storage
> - usb
> - power regulators
> 
> Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>

Thank you for your patch. There is something to discuss/improve.

> +
> +&tlmm {
> +	gpio-reserved-ranges = <0 4>, <81 4>;
> +
> +	cci1_default_state: cci1-default-state {
> +		pins = "gpio19", "gpio20";
> +		function = "cci_i2c";
> +		bias-disable;
> +		drive-strength = <2>;
> +	};
> +
> +	cdc_reset_n: cdc-reset-n {

This is a friendly reminder during the review process.

It seems my previous comments were not fully addressed. Maybe my
feedback got lost between the quotes, maybe you just forgot to apply it.
Please go back to the previous discussion and either implement all
requested changes or keep discussing them.

Thank you.

> +		pins = "gpio64";
> +		function = "gpio";
> +		bias-pull-down;
> +		drive-strength = <16>;
> +		output-high;
> +	};
> +
> +	hall_sensor_default_state: hall-sensor-default-state {
> +		pins = "gpio124";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-disable;
> +		input-enable;
> +	};
> +
> +	mdss_dsi_active_state: mdss-dsi-active-state {
> +		pins = "gpio94";
> +		function = "gpio";
> +		drive-strength = <8>;
> +		bias-disable;
> +	};
> +
> +	mdss_dsi_suspend_state: mdss-dsi-suspend-state {
> +		pins = "gpio94";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-pull-down;
> +	};
> +
> +	mdss_te_active_state: mdss-te-active-state {
> +		pins = "gpio10";
> +		function = "mdp_vsync_a";
> +		drive-strength = <2>;
> +		bias-pull-down;
> +	};
> +
> +	mdss_te_suspend_state: mdss-te-suspend-state {
> +		pins = "gpio10";
> +		function = "mdp_vsync_a";
> +		drive-strength = <2>;
> +		bias-pull-down;
> +	};
> +
> +	msm_mclk0_active_state: msm-mclk0-active-state {
> +		pins = "gpio13";
> +		function = "cam_mclk";
> +		drive-strength = <2>;
> +		bias-disable;
> +	};
> +
> +	msm_mclk0_suspend_state: msm-mclk0-suspend-state {
> +		pins = "gpio13";
> +		function = "cam_mclk";
> +		drive-strength = <2>;
> +		bias-pull-down;
> +	};
> +
> +	msm_mclk1_active_state: msm-mclk1-active-state {
> +		pins = "gpio14";
> +		function = "cam_mclk";
> +		drive-strength = <2>;
> +		bias-disable;
> +	};
> +
> +	msm_mclk1_suspend_state: msm-mclk1-suspend-state {
> +		pins = "gpio14";
> +		function = "cam_mclk";
> +		drive-strength = <2>;
> +		bias-pull-down;
> +	};
> +
> +	nfc_int_active_state: nfc-int-active-state {
> +		pins = "gpio92";
> +		function = "gpio";
> +		drive-strength = <6>;
> +		bias-pull-up;
> +	};
> +
> +	nfc_int_suspend_state: nfc-int-suspend-state {
> +		pins = "gpio92";
> +		function = "gpio";
> +		drive-strength = <6>;
> +		bias-pull-up;
> +	};
> +
> +	nfc_enable_active_state: nfc-enable-active-state {
> +		pins = "gpio12", "gpio116";
> +		function = "gpio";
> +		drive-strength = <6>;
> +		bias-pull-up;
> +	};
> +
> +	nfc_enable_suspend_state: nfc-enable-suspend-state {
> +		pins = "gpio12", "gpio116";
> +		function = "gpio";
> +		drive-strength = <6>;
> +		bias-disable;
> +	};
> +
> +	ts_active_state: ts-active-state {
> +		pins = "gpio89", "gpio125";
> +		function = "gpio";
> +		drive-strength = <16>;
> +		bias-pull-up;
> +		input-enable;
> +	};
> +
> +	ts_int_suspend_state: ts-int-suspend-state {
> +		pins = "gpio125";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-disable;
> +	};
> +
> +	ts_reset_suspend_state: ts-reset-suspend-state {
> +		pins = "gpio89";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-disable;
> +	};
> +
> +	wcd_int_n: wcd-int-n {

You missed here state suffix

> +		pins = "gpio54";
> +		function = "gpio";
> +		bias-pull-down;
> +		drive-strength = <2>;
> +		input-enable;
> +	};
> +
> +	wsa_leftspk_pwr_n: wsa-leftspk-pwr-n {

Ditto

> +		pins = "gpio65";
> +		function = "gpio";
> +		bias-disable;
> +		drive-strength = <2>;
> +		output-low;
> +	};
> +> +	wsa_rightspk_pwr_n: wsa-rightspk-pwr-n {

Ditto

> +		pins = "gpio66";
> +		function = "gpio";
> +		bias-disable;
> +		drive-strength = <2>;
> +		output-low;
> +	};

Best regards,
Krzysztof

