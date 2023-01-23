Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F26AF6776B7
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 09:51:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbjAWIvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 03:51:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbjAWIvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 03:51:19 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0176FCC2C
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 00:51:18 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id d14so6369406wrr.9
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 00:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=22HbhFCoP/frzw0LVOteI3i5o4+fgnftSyLobiyZhNE=;
        b=eoShBrh/9aB0bPJOSCkRoDde/OWXqyhD5G0g66X73uztztr4wIWSQHk+G/M1MkVdbm
         g4X0B3an1wNMhxFqzo42yVy22m0jGXQTezsYcf9uYuP3hac7gLc6MVwMdw9Fx6VfmXAo
         SvbIKdW9mRQ4MlPXpYVzVAQDIrsRb1ABVOcsC20fpdijc8YpfQYRX/OqhWV6ZkGxNDFl
         u0N06Mx8Ib1FFU4QZ90moGpu2KyayhwcHejtmkX9/UGC3loe59U+S0lq2u8gjMtIdskP
         wLLG/+ABG+pbQ2q0+1JGu66kxOcaGt0+dpp5NN5ODR9mhEFV6UCwdmAR36QHgvMOfN6z
         XFvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=22HbhFCoP/frzw0LVOteI3i5o4+fgnftSyLobiyZhNE=;
        b=zk6mJr/g1b73rBNok8P2aQROK/zuytlrbRe/8f2LT9694ok/AgZ92IePN4I4O1WbQZ
         9fCYAsakCz64nXQ4VBB8vSOou3lvGRUOywrvkFp8vHva/GWXrDRjZgipYo5yVlrrvzT+
         1UL01YjaLsqS2JmjePxHjRo+dD4qqo4ib/ZexzSsJC+/pw1g+vbH09hceUYBUUSnIkUw
         gLZr6dE0ODE4YRjDnidV7L/scOGKBTB6F0JLR0upbZ35vtaK0NKu01hbAHNbDFuHWKex
         WLJuqRRfe+1k8lVJ/NJJIDYxRsA/j5XYLeyU5GFoAs35XOXnYEd+qk0VNYJDhNIMbewy
         XP3w==
X-Gm-Message-State: AFqh2kq5c3UPAg9OrpiBIoz9Pq/i/ZJsQNkLJHWhYmWOenvKIfc2S+2U
        KedMTiVxCej2qVVwRn6QkJtlUA==
X-Google-Smtp-Source: AMrXdXsAepFLtbRVd+PBmYG7G51lmeEvUiXA6wUuX0LKhS3sXpHPXAq6vL/HS4qOr8J52dS23f7KDw==
X-Received: by 2002:adf:de04:0:b0:2a9:89e:2b53 with SMTP id b4-20020adfde04000000b002a9089e2b53mr20177577wrm.45.1674463877565;
        Mon, 23 Jan 2023 00:51:17 -0800 (PST)
Received: from [192.168.7.111] (679773502.box.freepro.com. [212.114.21.58])
        by smtp.gmail.com with ESMTPSA id b11-20020a05600018ab00b002be2279f100sm17261066wri.96.2023.01.23.00.51.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 00:51:17 -0800 (PST)
Message-ID: <5e7bd89e-36a5-d52a-382b-16ee28cc937f@linaro.org>
Date:   Mon, 23 Jan 2023 09:51:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 1/3] arm64: dts: meson: add Broadcom WiFi to P212 dtsi
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
 <20230123065504.2669769-2-christianshewitt@gmail.com>
Organization: Linaro Developer Services
In-Reply-To: <20230123065504.2669769-2-christianshewitt@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/01/2023 07:55, Christian Hewitt wrote:
> The P212 has a combined WiFi/BT module. The BT side is already enabled
> in the dtsi but the WiFi side is not. Let's enable the WiFi module.
> 
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> ---
>   arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi
> index 05cb2f5e5c36..7055057d7942 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi
> @@ -125,6 +125,11 @@ &sd_emmc_a {
>   
>   	vmmc-supply = <&vddao_3v3>;
>   	vqmmc-supply = <&vddio_boot>;
> +
> +	brcmf: wifi@1 {
> +		reg = <1>;
> +		compatible = "brcm,bcm4329-fmac";
> +	};
>   };
>   
>   /* SD card */

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
