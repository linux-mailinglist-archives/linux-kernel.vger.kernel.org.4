Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80FE36AD8A1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 09:01:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbjCGIA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 03:00:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbjCGIAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 03:00:41 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8981187A03
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 00:00:38 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id q16so11223213wrw.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 00:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678176037;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ijEoAYIJJ5+odRylDAm2UWfSFdsaYTaLyRF8UzmTqYs=;
        b=zV24IqvnRETCGgK1BvWcspkXtXxEtsKqsnUGLw30uEv4VyHEnOxSgqLmPiDuSMMelD
         072MwQ3moInax0wm+YHR4KUU529vc9HKg702nItnzwz99PcJ6RUTIM4xXsNiJdsCTaam
         vzmJ1/VgBGo5fuMj/sxD2B58Q05F1v9YZJKNilkef3D4RXG81nUQKSLh10hRGHUll0W7
         nBvSCmcQ5Uw5yWQ1v4wCsZroe1uMm3UPVpW49JX965GKOF3G7f8eoq1EMMxdIoPcRNvI
         PtoolfPQvOLn3AbCZStuDapDeyl4rg60UmKY0DUF+ex0i2ByYtO6AC8CKsPwuc/yNrO8
         84Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678176037;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ijEoAYIJJ5+odRylDAm2UWfSFdsaYTaLyRF8UzmTqYs=;
        b=nb9aDwLXrjz/G2c96viZrHr824j+JROv5ksrzyr0k7siv95ao1vCbTg2AUrtHFTdW1
         haPZnoY3jWkeJ8CEMx8tQ6ojASAqUBLYcyK5Q7buYU2N8AIeWBThR80+uEoU3oCIOyqy
         b8DaEqgJRAp+mp366VkvixQwuDRQb+ZHrdlhId2QAyVfzv7sJPTwU/ULsKKDyrqnhIHx
         cihRUY+L041mDPIcbt6QcrFRrqJA4Q/AC2IEgAy5IYx5mu9rTPDNuRpOKnaz5K0mWbZp
         RjJeRTsnTy0azgDle82IS0IBrzRYWjrKGJJrAiUDqVb+0PedI42ABkWE6IcKgci1+ydN
         erKQ==
X-Gm-Message-State: AO0yUKUAgDjY8Tw0AKFi7dgaJ52Uvq69ZHvGbtSFN66edY5zwO1ybhQT
        DA9xJGrjhCdHgTcIFvTbeVO/kQ==
X-Google-Smtp-Source: AK7set+TxhLq7JwU5QjThhhQelWeF10eqEhDIkLTdWn+y+uBaBK0ICJkwu0mOEc4uCOOHqjNhhs3Hg==
X-Received: by 2002:a05:6000:10cc:b0:2c7:e60:abe8 with SMTP id b12-20020a05600010cc00b002c70e60abe8mr12062223wrx.9.1678176037002;
        Tue, 07 Mar 2023 00:00:37 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:6faa:6d13:586e:871d? ([2a01:e0a:982:cbb0:6faa:6d13:586e:871d])
        by smtp.gmail.com with ESMTPSA id m18-20020a05600c3b1200b003db0ad636d1sm17430831wms.28.2023.03.07.00.00.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Mar 2023 00:00:35 -0800 (PST)
Message-ID: <9623bc3f-760a-e838-c80f-40d2f9b79f35@linaro.org>
Date:   Tue, 7 Mar 2023 09:00:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
From:   neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v1 1/2] arm64: dts: meson-a1: add gpio_intc node
Content-Language: en-US
To:     Alexey Romanov <avromanov@sberdevices.ru>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, khilman@baylibre.com,
        jbrunet@baylibre.com, martin.blumenstingl@googlemail.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@sberdevices.ru
References: <20230202141520.40003-1-avromanov@sberdevices.ru>
Organization: Linaro Developer Services
In-Reply-To: <20230202141520.40003-1-avromanov@sberdevices.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/02/2023 15:15, Alexey Romanov wrote:
> Add gpio interrupt controller node.
> 
> Signed-off-by: Alexey Romanov <avromanov@sberdevices.ru>
> ---
>   arch/arm64/boot/dts/amlogic/meson-a1.dtsi | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
> index 6268c323a810..a04ddf0f4cd3 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
> @@ -158,6 +158,16 @@ clkc_pll: pll-clock-controller@7c80 {
>   					 <&clkc_periphs CLKID_XTAL_HIFIPLL>;
>   				clock-names = "xtal_fixpll", "xtal_hifipll";
>   			};
> +
> +			gpio_intc: interrupt-controller@0440 {
> +				compatible = "amlogic,meson-a1-gpio-intc",
> +					     "amlogic,meson-gpio-intc";
> +				reg = <0x0 0x0440 0x0 0x14>;
> +				interrupt-controller;
> +				#interrupt-cells = <2>;
> +				amlogic,channel-interrupts =
> +					<49 50 51 52 53 54 55 56>;
> +			};
>   		};
>   
>   		gic: interrupt-controller@ff901000 {

The [PATCH 1/2] highly confused b4, anyway it's applied on v6.4/arm64-dt.

Thanks,
Neil
