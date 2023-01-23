Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C646D6776BD
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 09:51:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbjAWIvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 03:51:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbjAWIve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 03:51:34 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6DE61CAD6
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 00:51:30 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id b7so10067433wrt.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 00:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wq4oxC5buz2E+s+BroZ/0SZWCgxAdvbZS0s80EVNBbM=;
        b=VAMN1A4mAJsh1F+t2xlr3cE95+Gexl9o2e++SHfnnifZaIYwcO/AHR4vLQ1sjZcLtE
         c3M//falD105XaFKZvknfn7UuRlNcIb0SRJRpLOWK1sKGJvcgt8QZoiFUDGSczgbyltd
         18pa5lbRon1N8+2K0tDCOe4BjoNcoua7SKoOfNdMcSm+MoRE51qKwU2brxbGr730htkC
         4rM5cBuzo7tkFUsZDmngeR03BA7Scu0yjYJzEViHymHqIpC0mzF/bJlHmIUG2iSOpvQr
         VkRfevIlfRs3zEMlwPSfIUspfSodAHT3r1xoSwBZsWlijQbEbinAi4YViGeQ4FSLbB6x
         zBYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wq4oxC5buz2E+s+BroZ/0SZWCgxAdvbZS0s80EVNBbM=;
        b=4hamCADpzZH9lJe7YpWTAboyGqtA5DCokqy8p0S/fjxpGd2PDxJwlRzTvjynTnmea8
         RwrrazMETLBnm14UXENpbt6smO5vbgPUPOoVVilPdQqjiLvYZh1XdeEzOY52t3ED0w4E
         RS9lGhwpNzYrkrLrZi3Bxpyrn7it2Sr1Fyz8FjpmPsNonXzCGzUCibtLenyzgdRNAeRe
         QxLgA/02AlHL+LE9HBkQXVFzGprqrCSe2/u2PnL2iXU6jqVW9SIGQMKphaVT+VUtbeOl
         xC6iN+usTg8S4uTQXOlb8SK+4ZSjaZ8zbTKniKidexOm6KH5Qx8iDMQOEN6DcAfnxM7T
         e15Q==
X-Gm-Message-State: AFqh2kr5Ih4A4xKGxHYZEHtRUOu590EKjrSCfvAb7ePWV+WNzVMM49fB
        a+i8SOpRMZbxptTbZq+lJsI1JQ==
X-Google-Smtp-Source: AMrXdXsdQgWZCpS1AtJWPqX/KLIQrSbqDRbAfeCYmmt51Clnv9Byjawpk1DpexppmgpYN7AFmSYRJQ==
X-Received: by 2002:adf:ee10:0:b0:2bd:d5f5:8820 with SMTP id y16-20020adfee10000000b002bdd5f58820mr20537410wrn.27.1674463889449;
        Mon, 23 Jan 2023 00:51:29 -0800 (PST)
Received: from [192.168.7.111] (679773502.box.freepro.com. [212.114.21.58])
        by smtp.gmail.com with ESMTPSA id n8-20020a5d6608000000b002423dc3b1a9sm3649553wru.52.2023.01.23.00.51.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 00:51:29 -0800 (PST)
Message-ID: <c58e70ab-da4d-3045-debb-49e31c383999@linaro.org>
Date:   Mon, 23 Jan 2023 09:51:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 2/3] arm64: dts: meson: move pwm_ef node in P212 dtsi
Content-Language: en-US
To:     Christian Hewitt <christianshewitt@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230123065504.2669769-1-christianshewitt@gmail.com>
 <20230123065504.2669769-3-christianshewitt@gmail.com>
Organization: Linaro Developer Services
In-Reply-To: <20230123065504.2669769-3-christianshewitt@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/01/2023 07:55, Christian Hewitt wrote:
> Cosmetic-only change to alpha-sort the pwm_ef node.
> 
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> ---
>   .../boot/dts/amlogic/meson-gxl-s905x-p212.dtsi   | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi
> index 7055057d7942..a150cc0e18ff 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi
> @@ -97,6 +97,14 @@ &ir {
>   	pinctrl-names = "default";
>   };
>   
> +&pwm_ef {
> +	status = "okay";
> +	pinctrl-0 = <&pwm_e_pins>;
> +	pinctrl-names = "default";
> +	clocks = <&clkc CLKID_FCLK_DIV4>;
> +	clock-names = "clkin0";
> +};
> +
>   &saradc {
>   	status = "okay";
>   	vref-supply = <&vddio_ao18>;
> @@ -170,14 +178,6 @@ &sd_emmc_c {
>   	vqmmc-supply = <&vddio_boot>;
>   };
>   
> -&pwm_ef {
> -	status = "okay";
> -	pinctrl-0 = <&pwm_e_pins>;
> -	pinctrl-names = "default";
> -	clocks = <&clkc CLKID_FCLK_DIV4>;
> -	clock-names = "clkin0";
> -};
> -
>   /* This is connected to the Bluetooth module: */
>   &uart_A {
>   	status = "okay";

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
