Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D863D714DA7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 17:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbjE2P6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 11:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjE2P6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 11:58:48 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB50CD;
        Mon, 29 May 2023 08:58:46 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-30abe551605so2444541f8f.0;
        Mon, 29 May 2023 08:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685375924; x=1687967924;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DmbKTWrR5Ist8xbfhfIsTWnGuuP3Tj0QFkiF3QCNa5I=;
        b=eFu0CeBY8gp/40z60b34rH6O04y5Yh8sEMC3WKnYs6lLYSlq5jFOdzdK9a2txRIdlN
         BHa3YeZFukW1UHyj7/6s2dUUos9lezr8zWrHCyeSnvW3MJh4sgfKk2sx2VxOCPI3JSHf
         5H1E1ZNs0g5ZII9ycUlvLr7gkTxe4I4ljkWR1qUJByOI/hntrHAqq/opy8a+Of84Gmgy
         frpEWi04wu7fz8LDKG7aJ7dLxDVaud3g1PogjNHe4VFsPBfxq/kpIOvicfzRP2vv/SRX
         5ZFyIZN7HVJX/A9oaP1lNlIFZ35D0ALu8EaRTPTk2kSxDh2r9xgJj7M/sk3+fd39yGOA
         +//g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685375924; x=1687967924;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DmbKTWrR5Ist8xbfhfIsTWnGuuP3Tj0QFkiF3QCNa5I=;
        b=bYOw5DxCHbUBR22ECHAAgSEr0zdZy7LxxNWvjOiqOANKMdQGoWOEoAPOgubzuOY1xW
         G9m+B5S0C8idCsGMynJVYaeOv1qrYC8s95ZMMjkjgWlrotUiSYYKsUnJ4hK5NKh93xDY
         YtyzxzuLxxu8b0EHYAaZg1bvKj/y9gx5e9gAlz9Yg7DPVOD2aD/IYVAM34UFW7atr5SE
         pvp3VtK2OmWlvqVi4kAG9N7dKn9tebbokXdb+XBt1k709TNLgmKXHaAN+GY9+6JLn5YH
         4DmHpxCUGqmQCJ4WWNtVilNCips57lM3yyE7FyiM7SRoG0xvctgKbe2u9ldHsArZW9b7
         TEvw==
X-Gm-Message-State: AC+VfDypINmSGE92eVMTniex7FYy0bzN99dkerWsEbP4UDe2ZhnjgVO1
        HCIFz7AaxZ9tp//PS7fuzTY=
X-Google-Smtp-Source: ACHHUZ6k7FdIrg5GktNfDGImRYatKh5VSOf6eWINqdYV4QBqmmd72yfSLLQ9HTcoaAYIzzukk93u9Q==
X-Received: by 2002:a5d:6584:0:b0:307:f75:f581 with SMTP id q4-20020a5d6584000000b003070f75f581mr7270131wru.18.1685375924532;
        Mon, 29 May 2023 08:58:44 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id o1-20020a5d4741000000b002f9e04459desm324601wrs.109.2023.05.29.08.58.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 May 2023 08:58:43 -0700 (PDT)
Message-ID: <3c635ce1-71b0-9079-836c-1a628a19414d@gmail.com>
Date:   Mon, 29 May 2023 17:58:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v1 5/7] arm64: dts: mt7986: add PWM to BPI-R3
Content-Language: en-US, ca-ES, es-ES
To:     Frank Wunderlich <linux@fw-web.de>,
        linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        "Hui.Liu" <hui.liu@mediatek.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Lala Lin <lala.lin@mediatek.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Daniel Golle <daniel@makrotopia.org>
References: <20230421132047.42166-1-linux@fw-web.de>
 <20230421132047.42166-6-linux@fw-web.de>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230421132047.42166-6-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21/04/2023 15:20, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Add pwm node and pinctrl to BananaPi R3 devicetree.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>

Applied, thanks

> ---
>   .../boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts   | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts
> index 2b028141f1f7..782519429497 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts
> @@ -274,6 +274,13 @@ mux {
>   		};
>   	};
>   
> +	pwm_pins: pwm-pins {
> +		mux {
> +			function = "pwm";
> +			groups = "pwm0", "pwm1_0";
> +		};
> +	};
> +
>   	spi_flash_pins: spi-flash-pins {
>   		mux {
>   			function = "spi";
> @@ -344,6 +351,12 @@ mux {
>   	};
>   };
>   
> +&pwm {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pwm_pins>;
> +	status = "okay";
> +};
> +
>   &spi0 {
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&spi_flash_pins>;
