Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD836C7C43
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 11:11:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbjCXKLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 06:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231608AbjCXKLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 06:11:11 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDE5B26CC5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 03:11:05 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id m6-20020a05600c3b0600b003ee6e324b19so625817wms.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 03:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679652664;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7D0AnhC8qINGmkMrvNsGrg02iqTAAE7pNka7bMg+dd4=;
        b=kbJqE+Kpv3PBewVIEy8nF3lSWyuRxhA6lgVtPWSLhfPYk2uEMWIVMSs8RXDh28Wrb9
         +ub1etCXA1woCJcKZpAx5T3ZYSCXckuXjQFAcWKviA1vvX8QV/Cm1RrFYSG5bnIMJVxI
         eGaRZR9KGVDI2CJ0KzhFIbEAyBg8MGpvzGdecOXjhODB+klLh+P8EL4ZXDYhTsyUHoRK
         ZLTKEB/oMQKFjjA1FiXwF2JF0FE7XvXVpcxj2y7b7hqpavFu99Mq68Avo/OOUni7HrVg
         rv31Sz8ImlgdpTJChxWDrGlfiE93FDc5cUqmJeDoja7wURvhnYbxXz1fvCPYIABiJdf/
         sy+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679652664;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7D0AnhC8qINGmkMrvNsGrg02iqTAAE7pNka7bMg+dd4=;
        b=mcqS4MvguFCwTJIjt4e7AXerCebZ3MMabZS792ZAu4zaeyHFg/JReGtiiKgNOv/981
         IcsRCONfdc7uYE6PVwHR4MZ/3TBxOPvkSv01QFUc8KgHQOJCR1CfSgjpgGpl1a5hH0Yb
         rLy/gFzIXR5DPs3/X+2UzFJKcEj2vLF/a2PCeVpMBLXVhjbd2YN1splldta5BQ/k4Ld/
         vHOa6mTJaQ7AClrhtLyuw1dhxv5jsaEeyXyEioOrPxps0NDerTysiedQSNgMG7IEwLhU
         L93RjNQ++NK63/Pq9YjrTalT/0Zd+by31pYlSqcJeW7b0+tWIyUqwzbJ194nDbruPWZ3
         T+Ig==
X-Gm-Message-State: AO0yUKWIuwZ2uXtxCnflppIILk++BehcjQcYF6M9rspp+ttEA3cF1GOy
        vOnuZiNV3LeT8QI+CP7FtXA1rw==
X-Google-Smtp-Source: AK7set9DwzUdUe5hHDRBjGUaWsA8ce55Mua1cKuCK5olDg5+9I5GW9T8rQyUE71YZ4JRpa/kTpVOwQ==
X-Received: by 2002:a7b:c046:0:b0:3ef:8b0:dbac with SMTP id u6-20020a7bc046000000b003ef08b0dbacmr1595348wmc.31.1679652664202;
        Fri, 24 Mar 2023 03:11:04 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:213f:a579:70af:e4a0? ([2a01:e0a:982:cbb0:213f:a579:70af:e4a0])
        by smtp.gmail.com with ESMTPSA id p7-20020a1c5447000000b003dd1bd0b915sm4537056wmi.22.2023.03.24.03.11.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Mar 2023 03:11:03 -0700 (PDT)
Message-ID: <d180c7d5-7db9-a961-e519-cca5ccf6f013@linaro.org>
Date:   Fri, 24 Mar 2023 11:11:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From:   neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v1] arm64: dts: meson: a1: place pwrc and secure-monitor
 under /firmware
Content-Language: en-US
To:     Dmitry Rokosov <ddrokosov@sberdevices.ru>,
        krzysztof.kozlowski@linaro.org, robh@kernel.org,
        khilman@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com, jianxin.pan@amlogic.com
Cc:     kernel@sberdevices.ru, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        rockosov@gmail.com
References: <20230323185548.13731-1-ddrokosov@sberdevices.ru>
Organization: Linaro Developer Services
In-Reply-To: <20230323185548.13731-1-ddrokosov@sberdevices.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 23/03/2023 19:55, Dmitry Rokosov wrote:
> Before, meson power secure controller was a child of secure monitor node.
> But secure monitor isn't the bus in terms of device tree subsystem, so
> of_platform initialization code doesn't populate its children
> (of_platform_default_populate() API).
> 
> Therefore in the current device tree meson power secure controller isn't
> probed at all.
> 
> If we place meson power secure controller and secure monitor nodes under
> '/firmware', they will be populated automatically from of_platform
> initialization.
> 
> Fixes: 04dd0b6584cd ("arm64: dts: meson: a1: add secure power domain controller")
> Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
> ---
>   arch/arm64/boot/dts/amlogic/meson-a1.dtsi | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
> index 77023a29b6e7..44c651254dc5 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
> @@ -72,8 +72,10 @@ linux,cma {
>   		};
>   	};
>   
> -	sm: secure-monitor {
> -		compatible = "amlogic,meson-gxbb-sm";
> +	firmware {
> +		sm: secure-monitor {
> +			compatible = "amlogic,meson-gxbb-sm";
> +		};
>   
>   		pwrc: power-controller {
>   			compatible = "amlogic,meson-a1-pwrc";

The amlogic,meson-gxbb-sm bindings says the power-controller node should be
a subnode of secure-monitor, so instead please fix the sm driver by calling:

of_platform_populate(dev->of_node, NULL, NULL, dev);

Neil
