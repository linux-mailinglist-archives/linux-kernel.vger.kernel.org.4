Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D59BF65BEBE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 12:14:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237219AbjACLNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 06:13:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236916AbjACLNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 06:13:20 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 788E21126
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 03:13:19 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id v23so21321466ljj.9
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 03:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/TWpQiqg2iNv0O2diyiU4mfauguHMd4IysTnhIm0+fM=;
        b=P2s5tnD5MmHi+uSv4kHuF4d8IwY9IgQ+14JhDu+4u3ZxKe97MH/MG6IY8eE/t+dl7m
         b9BWNzeVLkwLYxXe/GZoRxyz2QKbT+dgj3HZyL/HxyYllp1Se9uXmJp8Q7FRJDdPUr+m
         45kWneEaoQoYg3BK5tWcHhHJSIFYnIKb0nB7llMmj/QNCTUzRe0pFMRqhZCoYKWl6YbS
         65dMNkbEioNXPZ+66yQWA8HX5EU6hlozJvDfS/2MlQUjqAu8IMUmMq0IYbpzygECyMBy
         e9+XT4fWylQly35GWrFj9PggXTGHEwgukIZgWnk+EEXvYYiFWix3h71ThCsrv6eVxmfn
         SgZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/TWpQiqg2iNv0O2diyiU4mfauguHMd4IysTnhIm0+fM=;
        b=hXmDhhuiOJymf+J1l4kCxWZCE559cD9tNANFw8KMTLSoWRgFb1kw1jBVY9ruxWQAef
         VqweW7Z115IN/E10KKfsyJ5eFljs0mciLyQ3enTshIEmZC7ddFw+SduuMWClQ1HoOnrG
         /q3GLcrd09JUzhZyuQ+S0vZW35BIkTWEU4RxIctxrURwLcSTa9Lqt57k6703SbmpZCxD
         h1MLUw39lZzIHGZAIVwssZtbBHUQ6tfZNcJJLxPweGFLX/ovY5G2YGJKAwz6AmFo4m45
         6EfZ53RjtiL96yo7u8DAaLGsgp3LLnpE95q+/r1qUd2VwEC5b4Xuv0FVF16LVThtu/oi
         8HQA==
X-Gm-Message-State: AFqh2kp+YEaKwJ+Qy5ylwMV0TSuZqWH4Hm33uoCXNp5pd8NmWjEsHlPf
        HPd6Tslm4dAwjGnGLYPzKmdcLw==
X-Google-Smtp-Source: AMrXdXsq4eIbXobzEJN/aR14hPh8zbDa75iWKce21g7fG2vNVHzWb4UfMEZpdHsU9qRvjyGv1U9L0A==
X-Received: by 2002:a2e:a583:0:b0:27f:cf81:cbc with SMTP id m3-20020a2ea583000000b0027fcf810cbcmr6992503ljp.24.1672744397870;
        Tue, 03 Jan 2023 03:13:17 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id k10-20020a05651c10aa00b0027fe262a75csm970094ljn.81.2023.01.03.03.13.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jan 2023 03:13:17 -0800 (PST)
Message-ID: <2c6950c9-3489-c2d4-2ca8-cb723195f75b@linaro.org>
Date:   Tue, 3 Jan 2023 12:13:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 5/5] arm64: dts: fsd: Add sound card node for Tesla FSD
Content-Language: en-US
To:     Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>,
        lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, s.nawrocki@samsung.com,
        perex@perex.cz, tiwai@suse.com, pankaj.dubey@samsung.com,
        alim.akhtar@samsung.com, rcsekar@samsung.com,
        aswani.reddy@samsung.com
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
References: <20230103045613.100309-1-p.rajanbabu@samsung.com>
 <CGME20230103045706epcas5p14f2f951d162899234c7f5f7a0998ab6b@epcas5p1.samsung.com>
 <20230103045613.100309-6-p.rajanbabu@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230103045613.100309-6-p.rajanbabu@samsung.com>
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

On 03/01/2023 05:56, Padmanabhan Rajanbabu wrote:
> Add device tree node support for sound card on Tesla FSD board
> 
> Signed-off-by: Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
> ---
>  arch/arm64/boot/dts/tesla/fsd-evb.dts | 37 +++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/tesla/fsd-evb.dts b/arch/arm64/boot/dts/tesla/fsd-evb.dts
> index e2fd49774f15..ce726bddfb50 100644
> --- a/arch/arm64/boot/dts/tesla/fsd-evb.dts
> +++ b/arch/arm64/boot/dts/tesla/fsd-evb.dts
> @@ -29,6 +29,43 @@
>  		device_type = "memory";
>  		reg = <0x0 0x80000000 0x2 0x00000000>;
>  	};
> +
> +	sound {
> +		compatible = "simple-audio-card";
> +
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		simple-audio-card,name = "FSD Audio Card";
> +		simple-audio-card,widgets =
> +			"Line", "Line Out",

I don't think you need to break the line after '='.

> +			"Line", "Line In";
> +		simple-audio-card,routing =
> +			"Line Out", "LLOUT",
> +			"Line Out", "RLOUT",
> +			"MIC2L", "Line In",
> +			"MIC2R", "Line In";
> +
> +		status = "okay";

Why?

> +
> +		simple-audio-card,dai-link@0 {
> +			reg = <0>;
> +			format = "i2s";
> +			bitclock-master = <&tlv320aic3x>;
> +			frame-master = <&tlv320aic3x>;
> +
> +			cpu0 {

Does not look like you tested the DTS against bindings. Please run `make
dtbs_check` (see Documentation/devicetree/bindings/writing-schema.rst
for instructions).

> +				sound-dai = <&i2s_0 0>;
> +			};
> +			cpu1 {
> +				sound-dai = <&i2s_0 1>;
> +			};
> +			codec {
> +				sound-dai = <&tlv320aic3x>;
> +				system-clock-frequency = <33000000>;
> +			};

Best regards,
Krzysztof

