Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF116DB288
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 20:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbjDGSLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 14:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjDGSLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 14:11:32 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C6EAF10
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 11:11:29 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-94748e41044so163226966b.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 11:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680891088;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L+XwHH+NxH3fpDTzT7U2Uejz40Vg3/GuvV21vLfzLyA=;
        b=mkSF57qv7GXr0i6rVvc5d21h96Tj8SqUcR64xPYNrobd+PQ7P6B0Zt3vCo/pDNt6sj
         +qxLslDoBW1QlLB5DBUtbV7WXVcuQF+wmouHnEDpCujvPmtd8ImsjYTsgGKVemzI99wU
         JzRJnG9LldtJyfbrD68/U+qOSot3OZywvaL9R9Z1N2T5+zjL5ZNn1rzwUzq5SEiheiZ1
         4/Zv7GFSNIfAJ6NbHOWw/HH9x0bVBtG2oCd/8qctgs0r801T+iJVqdS3EcsRYI40uyIC
         qqQtiXU8i0Vut4VcWtLxyFGEdyIotlef6orWDCPU4JbhCgIGHewRJotSj5A5v1p2IW01
         PdrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680891088;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L+XwHH+NxH3fpDTzT7U2Uejz40Vg3/GuvV21vLfzLyA=;
        b=u16DJfEZ+Q8oiyaIriiVmW0bW9MoYkAiAydxIZqWGHz/wzeZOVDoQmwvCma6hlL8ND
         YfWAbLTA1bArAc9MyeRjdtDTF5oNIDHF+ze4BeSeoH/zEQYqcwQkN9yw/ShllWOoqV1w
         blqmgo6Pwa1tEhfiYVcvIWoj46XFfJ6hVC1PpuVLGhgaZtCCQ2eYk+3B/4tS6venFg9X
         bCFZot7MopVU8tjxlx3wTFPBPQM8oyV8mkjR7Xwn/EAu/5HfnP3Q6bNz0x8TywGPSMf0
         5m3AjomOewbQaWnQzpcxWIuYDNNG149gwb96w3mgyoTH2ddYHo7MXO9yTbKfZPy9u1dr
         bAPw==
X-Gm-Message-State: AAQBX9dBH0EaZUsLBuQzzr1erlkFwmRiJ55ojriSSA9thGFODoVLs3Fy
        LOvSh2NJv4S4hWxA1l/wTQesYA==
X-Google-Smtp-Source: AKy350YA4WOMGlUud0T2KIJv6phMSse28tyWV3pz9UJmgbHa/WEwOfeYZ8OM4J3oJ5P98WpBIqBrvw==
X-Received: by 2002:a50:fb87:0:b0:501:d532:d84e with SMTP id e7-20020a50fb87000000b00501d532d84emr2779887edq.39.1680891087495;
        Fri, 07 Apr 2023 11:11:27 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:b20f:8824:c926:8299? ([2a02:810d:15c0:828:b20f:8824:c926:8299])
        by smtp.gmail.com with ESMTPSA id m20-20020a509994000000b0050470aa444fsm1700323edb.51.2023.04.07.11.11.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Apr 2023 11:11:27 -0700 (PDT)
Message-ID: <43b74b3f-e607-ba55-a5fa-326fb4b5519d@linaro.org>
Date:   Fri, 7 Apr 2023 20:11:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 12/14] arm64: dts: qcom: sc7180: Fix trogdor qspi pin
 config
Content-Language: en-US
To:     Douglas Anderson <dianders@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-gpio@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, Andy Gross <agross@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20230323173019.3706069-1-dianders@chromium.org>
 <20230323102605.12.I6f03f86546e6ce9abb1d24fd9ece663c3a5b950c@changeid>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230323102605.12.I6f03f86546e6ce9abb1d24fd9ece663c3a5b950c@changeid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/03/2023 18:30, Douglas Anderson wrote:
> In commit 7ec3e67307f8 ("arm64: dts: qcom: sc7180-trogdor: add initial
> trogdor and lazor dt") we specified the pull settings on the boot SPI
> (the qspi) data lines as pullups to "park" the lines. This seemed like
> the right thing to do, but I never really probed the lines to confirm.
> 


>  &qup_i2c2_default {
> @@ -1336,6 +1340,22 @@ p_sensor_int_l: p-sensor-int-l-state {
>  		bias-disable;
>  	};
>  
> +	qspi_sleep: qspi-sleep-state {
> +		pins = "gpio63", "gpio64", "gpio65", "gpio68";
> +
> +		/*
> +		 * When we're not actively transferring we want pins as GPIOs
> +		 * with output disabled so that the quad SPI IP block stops
> +		 * driving them. We rely on the normal pulls configured in
> +		 * the active state and don't redefine them here. Also note
> +		 * that we don't need the reverse (output-enable) in the
> +		 * normal mode since the "output-enable" only matters for
> +		 * GPIO function.
> +		 */
> +		function = "gpio";
> +		output-disable;

Doug,

I acked some of your patches, but I assumed you tested all this. It
turns out you never run dtbs_check on the patches you sent.

Best regards,
Krzysztof

