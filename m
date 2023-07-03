Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A739C745865
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 11:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbjGCJbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 05:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbjGCJbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 05:31:09 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBCFC12E
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 02:31:02 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-3142860734aso1757124f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 02:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688376661; x=1690968661;
        h=content-transfer-encoding:in-reply-to:organization:references:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FuT4xWkOihq2mrZtoWDkd43kDCIJLbZrTBfddFWhGMs=;
        b=HL5Fed4s+7c6wXe5MltRoTZHcxVOjU8x2HVFWZSlDD1UuGG67NewwEfJNpr0mOEFKV
         ysApBigicygyXkXRPkzFiYpKr3A0PlNWJGHirnRXEJFC6cNwLk50s55urBOm0i0wCxGL
         QXJS2D3KDAVIL6TJPj4Yx6FFa8JzB0GjlgY8C7AHPE6M5wJl+lsRCDx8Jiw4cNj/2EHO
         PoqO/fTP4F6hZ8LBavjVZUXS9Z2eC/JPd2Ow9614HTZzWWaEyv1XPG2C5YLlLmzHREJu
         vWFhaWCnP0+lWdjUqQXFMnrx47NU753d0/D+jMWRLPjJI7NwE4mtt8OnpQB/IZJWE7LW
         x9Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688376661; x=1690968661;
        h=content-transfer-encoding:in-reply-to:organization:references:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FuT4xWkOihq2mrZtoWDkd43kDCIJLbZrTBfddFWhGMs=;
        b=hQqAqkJSLxdS7uApAnqssNse08WE0PUVBeVUo1u4KVZxw3kFMsE3rUufHM43Z9s9ug
         uF9HPwX3eiOrjtliaFVvI0tabw6aBj3rNiyfUPl52jaNNeo+GmM8QyOJzgz4b9pwIoMN
         U0qvBtp0lmGc70nLtlWBAg/U/8sQ5kV2VeySh/R7rHky55oxpNn1UDXbeg6fCjg65HLV
         RfAb3s1y7U48gOuN9C1M05mbrvb3BlCkd+BXdbO2FpMvhJRTfCzwkvBiotTwAJunJXRt
         NL4g7DNh0LPmhLcNkpVaw6Ierev/SSNPljiPxh9FjL3+ndSPUlB7a7lVs2zDE2IWawyM
         WK1A==
X-Gm-Message-State: ABy/qLZ+Zt67IzIkDwt2xHH75SdUigMIPY4JMKBsRN9rzt4cntqCHybq
        9Ysp+omN7lKDlumeC83UZDMGZQ==
X-Google-Smtp-Source: APBJJlFtC78bXoBLWFg9lY69vjdN93P6PIRVIJJMMRjsCUTOQl3IUP4GVH+ppYUkqsNTBbrmxR35zQ==
X-Received: by 2002:a05:6000:1b08:b0:314:3a9a:d70e with SMTP id f8-20020a0560001b0800b003143a9ad70emr958740wrz.11.1688376661309;
        Mon, 03 Jul 2023 02:31:01 -0700 (PDT)
Received: from [192.168.7.21] (679773502.box.freepro.com. [212.114.21.58])
        by smtp.gmail.com with ESMTPSA id w9-20020adfee49000000b0031435731dfasm3049882wro.35.2023.07.03.02.30.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jul 2023 02:31:00 -0700 (PDT)
Message-ID: <15d0da72-8227-5f75-27a3-34693262d06d@linaro.org>
Date:   Mon, 3 Jul 2023 11:30:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] arm64: dts: amlogic: minor whitespace cleanup around '='
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230702185327.44625-1-krzysztof.kozlowski@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <20230702185327.44625-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/07/2023 20:53, Krzysztof Kozlowski wrote:
> Use space after '=' sign to match DTS coding style.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   arch/arm64/boot/dts/amlogic/meson-g12b-bananapi-cm4-cm4io.dts | 2 +-
>   arch/arm64/boot/dts/amlogic/meson-g12b-odroid-go-ultra.dts    | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-bananapi-cm4-cm4io.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-bananapi-cm4-cm4io.dts
> index 1b0c3881c6a1..13d478f9c891 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-g12b-bananapi-cm4-cm4io.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12b-bananapi-cm4-cm4io.dts
> @@ -65,7 +65,7 @@ sound {
>   		compatible = "amlogic,axg-sound-card";
>   		model = "BPI-CM4IO";
>   		audio-aux-devs = <&tdmout_b>;
> -		audio-routing =	"TDMOUT_B IN 0", "FRDDR_A OUT 1",
> +		audio-routing = "TDMOUT_B IN 0", "FRDDR_A OUT 1",
>   				"TDMOUT_B IN 1", "FRDDR_B OUT 1",
>   				"TDMOUT_B IN 2", "FRDDR_C OUT 1",
>   				"TDM_B Playback", "TDMOUT_B OUT";
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-go-ultra.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-go-ultra.dts
> index 29d642e746d4..276e95b34022 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-go-ultra.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-go-ultra.dts
> @@ -221,7 +221,7 @@ sound {
>   				"Headphone", "Headphones",
>   				"Speaker", "Internal Speakers";
>   		audio-aux-devs = <&tdmout_b>, <&tdmin_b>, <&speaker_amp>;
> -		audio-routing =	"TDMOUT_B IN 0", "FRDDR_A OUT 1",
> +		audio-routing = "TDMOUT_B IN 0", "FRDDR_A OUT 1",
>   				"TDM_B Playback", "TDMOUT_B OUT",
>   				"TDMIN_B IN 1", "TDM_B Capture",
>   				"TDMIN_B IN 4", "TDM_B Loopback",

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
