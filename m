Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3630669107
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 09:32:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240892AbjAMIcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 03:32:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240727AbjAMIcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 03:32:24 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F3C16A0EB
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 00:31:49 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id cf18so44228517ejb.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 00:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fq5EiwvFx5q9sBjRycwRwjCKfYTdfMVhpxypdyTT44M=;
        b=wC33l/oTMiL899EyjBVV9328MMq6JQ/3akZlghhyGgV1QWKORUyePI7y34TurfpNul
         lbXJ2/CGWYeoZoaFvTFuCDiFV77ukg5G4jkW7zxavJxR5Nu9n6YK9jge0NrQLBVZRn98
         2iKwxCa3AG3Gw/qoVYPviTdk3Pg09O2gt+Uir8MaptECLS67105WegeBS+GaY7M9pjFY
         IYDuPbTt9Giu0qwr0hmF2HCy6PWBnJwYrfJpea+WgfRdthyWDTQG53cInqQWttE0L2ZH
         R8dGHjYkG7ssu5qBwH4pkpA8QSpjjP31KkWnNZ0D9m0v8Pj5Y4VwG0HRtxW8uGRPSDhc
         FbHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fq5EiwvFx5q9sBjRycwRwjCKfYTdfMVhpxypdyTT44M=;
        b=NzbIRpU155j+q+mqOU0F06Lhp4fMF3blsMnZ252AI0MvgMM9cusuZ2nacvxQmT9le6
         IPYfegIFDzFKxXRJZPMq8zNlWWfaAqZN1dnLRkbgqv7JBch+LTWRhZsM4rOtLUMl0sb5
         ToI4LLG41G8HmAar8+OuoD9XSuLtxFlklYN1hyfj578fWO1ZtqWUmQl+xtXj8bXvMiDM
         0J46SGK0Q1iwqgTrZYippJvBezXuYEjjT4Q6aYEOWvG6UE948v+eUgyIYTvWZIIh84Oz
         f3tA8EeK6uERnn9g2EIoopPPMivXimRS/ooHRkVfeNd1BiAAKMZCW5oBeEDBk+hQFhpY
         NF3w==
X-Gm-Message-State: AFqh2krWWygRoaMlUkX5Qca0AlWO4J/v4x9o9cw6wk3gT6PWaOprcPmm
        VUDFpHEGAvdcRyt6Ls/rT0bGVg==
X-Google-Smtp-Source: AMrXdXsulXgacbJYElkpfNDsVUbCzylD/dY6JtmLSKOFwq+AHZUSUS65j+5vIXesjafwGx6FV6YFPw==
X-Received: by 2002:a17:906:36ce:b0:838:1b80:9a7a with SMTP id b14-20020a17090636ce00b008381b809a7amr66237619ejc.12.1673598708053;
        Fri, 13 Jan 2023 00:31:48 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id g19-20020a17090613d300b00862bfccf477sm2180179ejc.78.2023.01.13.00.31.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Jan 2023 00:31:47 -0800 (PST)
Message-ID: <787212be-990f-1e61-c814-17958ee0c47c@linaro.org>
Date:   Fri, 13 Jan 2023 09:31:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] Support for MAX98090/91 codec in iMX8MM evk
Content-Language: en-US
To:     Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>,
        Daniel Baluta <daniel.baluta@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "peng.fan@nxp.com" <peng.fan@nxp.com>,
        "m.felsch@pengutronix.de" <m.felsch@pengutronix.de>,
        "shengjiu.wang@nxp.com" <shengjiu.wang@nxp.com>,
        "Markus.Niebel@ew.tq-group.com" <Markus.Niebel@ew.tq-group.com>,
        "hongxing.zhu@nxp.com" <hongxing.zhu@nxp.com>,
        "tommaso.merciai@amarulasolutions.com" 
        <tommaso.merciai@amarulasolutions.com>,
        "jun.li@nxp.com" <jun.li@nxp.com>,
        "ckeepax@opensource.cirrus.com" <ckeepax@opensource.cirrus.com>,
        "rf@opensource.cirrus.com" <rf@opensource.cirrus.com>,
        "povik+lin@cutebit.org" <povik+lin@cutebit.org>,
        "pierre-louis.bossart@linux.intel.com" 
        <pierre-louis.bossart@linux.intel.com>,
        "james.schulman@cirrus.com" <james.schulman@cirrus.com>,
        "flatmax@flatmax.com" <flatmax@flatmax.com>,
        "srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>,
        "ryan.lee.analog@gmail.com" <ryan.lee.analog@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
References: <MA0PR01MB7145CB5A2D487FB713CD7C01FFFC9@MA0PR01MB7145.INDPRD01.PROD.OUTLOOK.COM>
 <CAEnQRZC2X5v6hh=-PRiaUgp3SZQYg1vot+4JKwEE6x5bzTKvwA@mail.gmail.com>
 <MA0PR01MB71451A4A70DBD85680E90AE0FFFC9@MA0PR01MB7145.INDPRD01.PROD.OUTLOOK.COM>
 <CAEnQRZDowp=-Cqvy=hJzQDDN_+cEUS7Pj-GJ-0oAhqq=N2STWw@mail.gmail.com>
 <MA0PR01MB7145B5094B0E3FB35764DE9FFFC29@MA0PR01MB7145.INDPRD01.PROD.OUTLOOK.COM>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <MA0PR01MB7145B5094B0E3FB35764DE9FFFC29@MA0PR01MB7145.INDPRD01.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/01/2023 06:50, Hardevsinh Palaniya wrote:
> From d2001cdbc2fda3345af307b4cf3d0f2e53d80c35 Mon Sep 17 00:00:00 2001
> From: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
> Date: Fri, 13 Jan 2023 11:01:22 +0530

That's still not correct patch format.

> Subject: [PATCH] Add dts to support MAX98090/91 with i.MX8MM-evk

That's still not correct subject. You already got this comment and
ignored it.

Your recipient list is enormous. Use get_maintainers.pl. You already got
this comment and ignored it.

If you intend to ignore all the comments, then this is NAK.

This is v2? Patch subject should be marked with it. You need to add
changelog.

> 
> - Add sound-max98090 node to support external codec MAX98090/91

Why? Explain what you want to achieve and why do you do it.

> - Use i2c3 for i2c communicate with codec
> - Use sai5 for i2s communication
> 
> Signed-off-by: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-evk-max98090-91.dts b/arch/arm64/boot/dts/freescale/imx8mm-evk-max98090-91.dts
> new file mode 100644
> index 000000000000..d053c586514a
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-evk-max98090-91.dts

That's a dead code without Makefile.

Missing bindings.

> @@ -0,0 +1,65 @@
> +#include "imx8mm-evk.dtsi"
> +
> +/ {
> +	sound-max98090 {
> +		compatible = "simple-audio-card";
> +		simple-audio-card,name = "max98090-audio";
> +		simple-audio-card,format = "i2s";
> +		simple-audio-card,frame-master = <&cpudai>;
> +		simple-audio-card,bitclock-master = <&cpudai>;
> +		simple-audio-card,widgets = "Speakers", "Speakers";
> +		simple-audio-card,routing =
> +				"Speakers", "SPKR",
> +				"Speakers", "SPKL",
> +				"IN1", "MICBIAS",
> +				"MIC1","IN1",
> +				"MIC2","IN1";
> +
> +		cpudai: simple-audio-card,cpu {
> +			sound-dai = <&sai5>;
> +			dai-tdm-slot-num = <2>;
> +			dai-tdm-slot-width = <32>;
> +		};
> +
> +		simple-audio-card,codec {
> +			sound-dai = <&max98090>;
> +			clocks = <&clk IMX8MM_CLK_SAI5_ROOT>;
> +		};
> +	};
> +}
> +
> +&i2c3 {
> +	max98090: audio-codec@10 {
> +		compatible = "maxim,max98090","maxim,max98091";

You either ignored the comment or misread it. Go back to previous code.

> +		#sound-dai-ceddlls = <0>;

This is no way working... Test your code against bindings. Please run
`make dtbs_check` (see
Documentation/devicetree/bindings/writing-schema.rst for instructions).


Best regards,
Krzysztof

