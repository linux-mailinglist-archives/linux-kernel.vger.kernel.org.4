Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A703B668FDA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 09:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240800AbjAMIAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 03:00:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240280AbjAMH7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 02:59:52 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E5066952D
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 23:59:47 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id z5so19208846wrt.6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 23:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Wg/RiEz7jyDLq2vZkubHTZleBkEHAFy0WqgTYw1iqQg=;
        b=sX9gyI0ffu0yoZBJ+c4+eJ3nVWf3QgZEydN4s3Y9ga1jqhrTmILffQ7EFNZGcUbToc
         VxFYqXt4WSgPdmyISgj0J1ocA1d0do8VYoOm1/slzHK8Vc2HZX1E/nXNWHAbscBuPUjr
         PfVnfKU6ALCRkbCnWbLDJCk9z0jESrpFAayh3/VocZjHEIbL7Npi3XgBD+lrKXADaHjq
         M3fIY0xH+GblldD1qtllr/eqdw4oB1OgGYQwkTeWqsoyl5slwnOT9deJTLY9xzo6Ovt3
         XE1xQZtQtyFn1KFnooo+9rxbkJJkktKhDRvA7K9YfXXXwwFBNc+797jcoMY+H62h3AoI
         dcmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wg/RiEz7jyDLq2vZkubHTZleBkEHAFy0WqgTYw1iqQg=;
        b=aKynyBt/M7XaEjQLMoerQaRM9PXeKu6JlmYxodblWD+58oH5yT0SGsxK30TuZQV+5U
         sSYs7/8NyGVj8mwv5iQSsESZNwLi5bLZmtzf1naIwjx+gEVnS33OOMVCFIVizaX8je/G
         TNVTymzHfOIW27S8jsx/gq2dUbZahOiLB+ZD5hf7/cRWLBGDeM4RJTZthv2LP20KkQc3
         eL4i9dTtyuxFEepADVYlhnig8yD4/feTRra1l1TLP/PAdaS2znQTkmSXDYgGTbTks/6f
         xiH+ayS00sakRidhl65m6kwUBeuFDDyiSI+oGIgHk9USpqjYGmprFWJhbrkTCP2ZXvJQ
         MiSA==
X-Gm-Message-State: AFqh2kpBil7YEcca+m2owRE8WKCm1NS2ElQFdjBA/rWZqIzlmiJ+5uXd
        eS/7efVQquLzOQmhMCFb/YBaig==
X-Google-Smtp-Source: AMrXdXsgg3InzVtsIcgmU+mCO95D1hRgQWLISXh65fcKTxkt1YimJlUAMQc3VWm6wmL4mYUIoPGtkw==
X-Received: by 2002:adf:da43:0:b0:250:779a:7391 with SMTP id r3-20020adfda43000000b00250779a7391mr47177236wrl.47.1673596785924;
        Thu, 12 Jan 2023 23:59:45 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:8660:aed9:5ce2:6bbb? ([2a01:e0a:982:cbb0:8660:aed9:5ce2:6bbb])
        by smtp.gmail.com with ESMTPSA id q16-20020adff950000000b002bcaa47bf78sm8956951wrr.26.2023.01.12.23.59.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jan 2023 23:59:45 -0800 (PST)
Message-ID: <fbeb53ec-78cb-faf1-85ef-1c6f128c489e@linaro.org>
Date:   Fri, 13 Jan 2023 08:59:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
From:   neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 6/6] arm64: dts: meson-gx: Fix the SCPI DVFS node name
 and unit address
Content-Language: en-US
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, jbrunet@baylibre.com,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org
References: <20230111211350.1461860-1-martin.blumenstingl@googlemail.com>
 <20230111211350.1461860-7-martin.blumenstingl@googlemail.com>
Organization: Linaro Developer Services
In-Reply-To: <20230111211350.1461860-7-martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/01/2023 22:13, Martin Blumenstingl wrote:
> Node names should be generic and use hyphens instead of underscores to
> not cause warnings. Also nodes without a reg property should not have a
> unit-address. Change the scpi_dvfs node to use clock-controller as node
> name without a unit address (since it does not have a reg property).
> 
> Fixes: 70db166a2baa ("ARM64: dts: meson-gxbb: Add SCPI with cpufreq & sensors Nodes")
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
> changes from v1 -> v2:
> - new patch
> 
>   arch/arm64/boot/dts/amlogic/meson-gx.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
> index f8b115cd6775..a79a35e84281 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
> @@ -250,7 +250,7 @@ scpi {
>   		scpi_clocks: clocks {
>   			compatible = "arm,scpi-clocks";
>   
> -			scpi_dvfs: scpi_clocks@0 {
> +			scpi_dvfs: clock-controller {
>   				compatible = "arm,scpi-dvfs-clocks";
>   				#clock-cells = <1>;
>   				clock-indices = <0>;

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
