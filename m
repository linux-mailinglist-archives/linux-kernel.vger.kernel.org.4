Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 052166EE139
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 13:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233842AbjDYLqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 07:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233508AbjDYLqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 07:46:48 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE0734236
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 04:46:46 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-2fa0ce30ac2so5111042f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 04:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1682423205; x=1685015205;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ajycdBwcTMB6vow5DllaOedha5ITJ9rWmnFhPSBn8YA=;
        b=ffc99Fr+JmbaAnLLlUfqcH+Pcw7qUKZOfk9whe6jfHfBloeyACsummrjzUxJ/yxq2i
         5nluTs8Ol9tek4MqxlbBE3aQ3nzbZF43g6xfGhRnLcfJFBRDnLEQZNgbUq+9e9ZAB6QQ
         yeV9bFDoCqFpWKaW7HyhN1wWRKEnuA2EmWfgzAl1RDFVjUX95fDWRS4adwe6+FfspY8q
         oKZvtdjxNwGHM+xDSiNs8f2MUDd2740D4vBv6bd+H3Fi7H4b1N7PGDS6WZpAdc2aBP3J
         S6BUA7ZFg2Xr86mf7ShQ/lefCeF5Da5GlZt6EDyAP+8lo10uPljvCLVTNjgtvzLKg71S
         7irQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682423205; x=1685015205;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ajycdBwcTMB6vow5DllaOedha5ITJ9rWmnFhPSBn8YA=;
        b=DA69g07r70wH+neT5L63b5pMeorl2kwdT+qw/OR5jYGVMHwUlW8Ckl/p1rYUHNIM0w
         G0nKKs/1kAg6hFLeldZWhq7bSMhZaxnYxha72wP1aN2aiUOUMR5i4ULugZQrVGvx5MMO
         I+4GU6NpHe0gQi6K7+rYlAA3tAdd5zaOC9TOkZ2Wr/kVTzLB74BAsiFysVY2MnXkeRGz
         6xe5qdIWxLSRAbQ7PCKTUiLbHw0/5xig2csjRoRVOaAUv8h5XRa1GwCs894ydsCJNR8h
         lUS54oglRi0hNmmHAcRRUvmTU7TUJGePGRf0cP+DJoxGmtwlN6Hn/gDbX765GS9lUq61
         Hxlg==
X-Gm-Message-State: AAQBX9c+UpG6/eIabNkJgxpb3viWb2AJHpEcHKKDFF4SWHwix56NO3XS
        p6u6az1lKDROp39jD2r1aboZAw==
X-Google-Smtp-Source: AKy350bcxHiDpXS6mIVjASu0ZHUZdOWp2LzguxnrL6JCHRjYVszGybHNP4A2pJ7wQ6o3+FK+eIZS/A==
X-Received: by 2002:a5d:428a:0:b0:2ef:f9d:6adf with SMTP id k10-20020a5d428a000000b002ef0f9d6adfmr11224998wrq.35.1682423205302;
        Tue, 25 Apr 2023 04:46:45 -0700 (PDT)
Received: from [10.101.1.6] (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id f6-20020a5d6646000000b002f6dafef040sm12919621wrw.12.2023.04.25.04.46.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Apr 2023 04:46:44 -0700 (PDT)
Message-ID: <31d1d1e4-2f75-bbbd-3e4b-6c796f2d39d1@baylibre.com>
Date:   Tue, 25 Apr 2023 13:46:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 1/4] arm64: dts: mediatek: cherry: Add platform thermal
 configuration
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, matthias.bgg@gmail.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com,
        Chen-Yu Tsai <wenst@chromium.org>
References: <20230424112523.1436926-1-angelogioacchino.delregno@collabora.com>
 <20230424112523.1436926-2-angelogioacchino.delregno@collabora.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20230424112523.1436926-2-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/04/2023 13:25, AngeloGioacchino Del Regno wrote:
> This platform has three auxiliary NTC thermistors, connected to the
> SoC's ADC pins. Enable the auxadc in order to be able to read the
> ADC values, add a generic-adc-thermal LUT for each and finally assign
> them to the SoC's thermal zones.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Tested-by: Chen-Yu Tsai <wenst@chromium.org>
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
>   .../boot/dts/mediatek/mt8195-cherry.dtsi      | 105 ++++++++++++++++++
>   1 file changed, 105 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
> index 8ac80a136c37..4229f4f7dc2f 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
> @@ -114,6 +114,77 @@ ppvar_sys: regulator-ppvar-sys {
>   		regulator-boot-on;
>   	};
>   
> +	/* Murata NCP03WF104F05RL */
> +	tboard_thermistor1: thermal-sensor-t1 {
> +		compatible = "generic-adc-thermal";
> +		#thermal-sensor-cells = <0>;
> +		io-channels = <&auxadc 0>;
> +		io-channel-names = "sensor-channel";
> +		temperature-lookup-table = <	(-10000) 1553
> +						(-5000) 1485
> +						0 1406
> +						5000 1317
> +						10000 1219
> +						15000 1115
> +						20000 1007
> +						25000 900
> +						30000 796
> +						35000 697
> +						40000 605
> +						45000 523
> +						50000 449
> +						55000 384
> +						60000 327
> +						65000 279
> +						70000 237
> +						75000 202
> +						80000 172
> +						85000 147
> +						90000 125
> +						95000 107
> +						100000 92
> +						105000 79
> +						110000 68
> +						115000 59
> +						120000 51
> +						125000 44>;
> +	};
> +
> +	tboard_thermistor2: thermal-sensor-t2 {
> +		compatible = "generic-adc-thermal";
> +		#thermal-sensor-cells = <0>;
> +		io-channels = <&auxadc 1>;
> +		io-channel-names = "sensor-channel";
> +		temperature-lookup-table = <	(-10000) 1553
> +						(-5000) 1485
> +						0 1406
> +						5000 1317
> +						10000 1219
> +						15000 1115
> +						20000 1007
> +						25000 900
> +						30000 796
> +						35000 697
> +						40000 605
> +						45000 523
> +						50000 449
> +						55000 384
> +						60000 327
> +						65000 279
> +						70000 237
> +						75000 202
> +						80000 172
> +						85000 147
> +						90000 125
> +						95000 107
> +						100000 92
> +						105000 79
> +						110000 68
> +						115000 59
> +						120000 51
> +						125000 44>;
> +	};
> +
>   	usb_vbus: regulator-5v0-usb-vbus {
>   		compatible = "regulator-fixed";
>   		regulator-name = "usb-vbus";
> @@ -260,6 +331,10 @@ &gpu {
>   	mali-supply = <&mt6315_7_vbuck1>;
>   };
>   
> +&auxadc {

Can you put it in alphabetical order please. ?

> +	status = "okay";
> +};
> +
>   &i2c0 {
>   	status = "okay";
>   
> @@ -1098,6 +1173,36 @@ mt6315_7_vbuck1: vbuck1 {
>   	};
>   };
>   
> +&thermal_zones {
> +	soc-area-thermal {
> +		polling-delay = <1000>;
> +		polling-delay-passive = <250>;
> +		thermal-sensors = <&tboard_thermistor1>;
> +
> +		trips {
> +			trip-crit {
> +				temperature = <84000>;
> +				hysteresis = <1000>;
> +				type = "critical";
> +			};
> +		};
> +	};
> +
> +	pmic-area-thermal {
> +		polling-delay = <1000>;
> +		polling-delay-passive = <0>;
> +		thermal-sensors = <&tboard_thermistor2>;
> +
> +		trips {
> +			trip-crit {
> +				temperature = <84000>;
> +				hysteresis = <1000>;
> +				type = "critical";
> +			};
> +		};
> +	};
> +};
> +
>   &u3phy0 {
>   	status = "okay";
>   };

After that:
Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

Regards,
Alexandre

