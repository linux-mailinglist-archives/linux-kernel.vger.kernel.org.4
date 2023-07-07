Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA7274AC47
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 09:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232584AbjGGHvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 03:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231965AbjGGHvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 03:51:09 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6FD51FCE
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 00:51:07 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4fb96e2b573so2454918e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 00:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688716266; x=1691308266;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=exhYwOQz1Mbfg0VMEEcchmd9FhJ9ZbgKWVkcuVs8fv0=;
        b=xy9u9tHINP2OhQOYpSRS9mO1n0Fgi9RiO05e3JV8Mt+yXH56YaNxaSeN1+PXqFtZ4X
         p9dRgXW7WlB6Lkfu9dknMf0Wwy4SjzJP4Bn/y94MXR8px8Vkx/y8wn4KQfL51jHVl74T
         uIUuQckQZzFw+xqSYT/hp6RNlhEKy68GLoeLnL2CBwImMWAb56rH0oqShtkxqUdbcepm
         1zcusnJ56JuUsafQ82kiJQF3LUOLyTmcB6aMICY/sor+MzX50RYy9ps2HCDBlLdJ3Heg
         NjtytqfBbAAgsi3zBYsOvXix5Jo9WUFGoVZnSOb4GUS8pw5Ze/SHp9RJZwJYa1fzfpLe
         aRtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688716266; x=1691308266;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=exhYwOQz1Mbfg0VMEEcchmd9FhJ9ZbgKWVkcuVs8fv0=;
        b=eMjzWzLwes7BL1f2qASAiwBiy9B/o1XX0hxI8wYABGeWaqF0NuTZoaXss8lfm0l2BI
         h6PsDPjGomhSJwIK74ZHNS5USGRqEKfBh1z5U2hJcQjtgZiPnJeAoixjvCTJDtws7iTq
         FRrn9agPcdjWuByzgqbbvuyeUDMR0MJmGRLb+Yz8S2ZpRpcA8ZyESxCBn+hYjHq7yk10
         sQ+q6M8tj+rOcZxVc/PSZntbqG0CyXmwC/krxUOQ+RJjAYm+8HWtCXI4zRPEArvrjWky
         gelMcQCZ9eeqZes4x5rCjOQVV2FHo+sWs0PC81Y6+/Xqr7RE8KGYcB9yRzjp7f2a5N96
         qKqg==
X-Gm-Message-State: ABy/qLZKVhHrjHEq2/i6p3A7kG1RO7XFpKuBHzIS8X1VE5+/41XqSnPF
        vH4QJr1Q+7AI2k/BCtLC+sQSX3804ApjB/YG6sqQCKdL
X-Google-Smtp-Source: APBJJlGK4QzQeHIwj+Zs4m17eM9Q4NVc2gwIf2/qRxJ81UC32DmjTxUkqCh29R9ASPUDnJCF6MhltA==
X-Received: by 2002:a05:6512:b8e:b0:4f9:a542:91c with SMTP id b14-20020a0565120b8e00b004f9a542091cmr4185793lfv.3.1688716265998;
        Fri, 07 Jul 2023 00:51:05 -0700 (PDT)
Received: from [192.168.27.65] (home.beaume.starnux.net. [82.66.176.246])
        by smtp.gmail.com with ESMTPSA id 12-20020a05600c020c00b003f819faff24sm1651460wmi.40.2023.07.07.00.51.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jul 2023 00:51:05 -0700 (PDT)
Message-ID: <9b389977-156b-44e8-0a80-4273f7d2f178@linaro.org>
Date:   Fri, 7 Jul 2023 09:51:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH V2 4/4] arm64: dts: add support for C3 power domain
 controller
Content-Language: en-US
To:     Xianwei Zhao <xianwei.zhao@amlogic.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>
References: <20230707003710.2667989-1-xianwei.zhao@amlogic.com>
 <20230707003710.2667989-5-xianwei.zhao@amlogic.com>
Organization: Linaro Developer Services
In-Reply-To: <20230707003710.2667989-5-xianwei.zhao@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/07/2023 02:37, Xianwei Zhao wrote:
> Enable power domain controller for Amlogic C3 SoC
> 
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> ---
> V1 -> V2: delete status,use "okay" status by default.
> ---
>   arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi
> index 60ad4f3eef9d..f6603fd57551 100644
> --- a/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi
> @@ -47,6 +47,15 @@ xtal: xtal-clk {
>   		#clock-cells = <0>;
>   	};
>   
> +	sm: secure-monitor {
> +		compatible = "amlogic,meson-gxbb-sm";
> +
> +		pwrc: power-controller {
> +			compatible = "amlogic,c3-pwrc";
> +			#power-domain-cells = <1>;
> +		};
> +	};
> +
>   	soc {
>   		compatible = "simple-bus";
>   		#address-cells = <2>;

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
