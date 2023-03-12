Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42A256B6847
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 17:31:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjCLQb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 12:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbjCLQbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 12:31:53 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1513C311CD
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 09:31:52 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id ek18so8443217edb.6
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 09:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678638710;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0c2vyiavGu+PFiZ1nxZZLywcq02QXmGEQE36m/eJ9e0=;
        b=eOJqNpXJkVYYd1RHUCsu2kUHwwLBewQTA0ANS/jXRJCbx+QT84RiA5BPAn/+gtXCfT
         HzRihBIEt2BkSU9MuoRM14kmTuWUs/SHRGNmH7In4wKKkbp/NQ6krRDTRef9/miSbHLK
         kqNzwEtkAT+oyqry5yTZb4Z0XXsTEEQPEwGhmtsx4QYOgSJzwn5RWwTDGbty+vzRzM6E
         qDxODbq7rvMwvjHRPbi4iTWE9xklb4VL/UhWP/68v2dtwxnSj3eWdEwHzE6/ZLp0YfcP
         h5rt2ctK00ECtEoG/iIrsT9P7FDW1j7pl0mYxGFUvGkm3XaO5jV1uKTayMnV8OJek1FC
         SUpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678638710;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0c2vyiavGu+PFiZ1nxZZLywcq02QXmGEQE36m/eJ9e0=;
        b=nuOhQNfZAhPgrKzx8EmtmqXgDiObsan8sJgLam1CzJ+EUvd7zh4f1I9d+755D+V01R
         jpzZ2n3K+TStoq/fIONCuvWFzNbDGg9x2jmamoS4WVvOnauP7bV1VxPEtmiYQWxFw6Cf
         PUT3Fa1zn+B2nLYPMtL8NUOBPurKi6xEdlFzoB6utpkBJmv6JtLYTvTi0teeb6tYi/ZW
         42XRJyIM/P7WvP8N7kXOPv1Lv/KnyNOnFd9Zg7LlQDbk/LoM3B2A42btTvQeky1cQmtG
         KX/LD2FUb6NXJExqhIhufizyWxa4dFVMLSTuP2sraDcSK4FxP0XQV0VcURp+1SllI9HW
         BQJA==
X-Gm-Message-State: AO0yUKXwcZ7hda/keLBDhhKm6SIN8HTfJoz/JqSw/V6M8XnP8VFScxVQ
        i6jhnztTq88K4qVAWtDKoTjf8Q==
X-Google-Smtp-Source: AK7set8nHirJkCw98wM45z7VWuEwhJRUOixhk5nNM6BUxIE1e/TOUiXoI3sI/AiZmkFqCX9Aw0qN5w==
X-Received: by 2002:a17:907:a706:b0:878:78bc:975c with SMTP id vw6-20020a170907a70600b0087878bc975cmr33969418ejc.36.1678638710296;
        Sun, 12 Mar 2023 09:31:50 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:d9f6:3e61:beeb:295a? ([2a02:810d:15c0:828:d9f6:3e61:beeb:295a])
        by smtp.gmail.com with ESMTPSA id eg56-20020a05640228b800b004fb556e905fsm1061434edb.49.2023.03.12.09.31.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Mar 2023 09:31:49 -0700 (PDT)
Message-ID: <08baf8d8-d93d-780e-6b17-9485ccb5350a@linaro.org>
Date:   Sun, 12 Mar 2023 17:31:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 1/2] ARM: dts: exynos: replace mshc0 alias with
 mmc-ddr-1_8v property
Content-Language: en-US
To:     Henrik Grimler <henrik@grimler.se>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, alim.akhtar@samsung.com,
        m.szyprowski@samsung.com, jenneron@protonmail.com,
        markuss.broks@gmail.com, martin.juecker@gmail.com,
        virag.david003@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
References: <20230227193819.30133-1-henrik@grimler.se>
 <20230227193819.30133-2-henrik@grimler.se>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230227193819.30133-2-henrik@grimler.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/02/2023 20:38, Henrik Grimler wrote:
> Previously, the mshc0 alias has been necessary so that
> MMC_CAP_1_8V_DDR | MMC_CAP_8_BIT_DATA are set for mshc_0/mmc_0.
> However, these capabilities should be described in the device tree so
> that we do not have to rely on the alias.
> 
> The property mmc-ddr-1_8v replaces MMC_CAP_1_8V_DDR, while bus_width =
> <8>, which is already set for all the mshc0/mmc0 nodes, replaces
> MMC_CAP_8_BIT_DATA.
> 
> Also cleanup and sort (but keep status property at top) some of the

status is rather the last property

> nodes while we are modifying them.

Don't mix cleanups with any other changes.

> 
> Signed-off-by: Henrik Grimler <henrik@grimler.se>
> ---
> Changes since v2:
> * Set mmc-ddr-1_8v in device trees for mshc_0/mmc_0
> 
>  arch/arm/boot/dts/exynos3250-artik5.dtsi      | 15 ++++++-------
>  arch/arm/boot/dts/exynos3250-monk.dts         | 19 ++++++++---------
>  arch/arm/boot/dts/exynos3250-rinato.dts       | 21 ++++++++-----------
>  arch/arm/boot/dts/exynos3250.dtsi             |  3 ---
>  arch/arm/boot/dts/exynos4210-i9100.dts        |  5 ++---
>  arch/arm/boot/dts/exynos4210-origen.dts       |  3 ++-
>  arch/arm/boot/dts/exynos4210-trats.dts        |  3 ++-
>  .../boot/dts/exynos4210-universal_c210.dts    |  3 ++-
>  arch/arm/boot/dts/exynos4412-itop-elite.dts   |  4 ++++
>  .../boot/dts/exynos4412-itop-scp-core.dtsi    | 17 +++++++++------
>  arch/arm/boot/dts/exynos4412-midas.dtsi       | 17 ++++++++-------
>  .../boot/dts/exynos4412-odroid-common.dtsi    | 16 +++++++-------
>  arch/arm/boot/dts/exynos4412-origen.dts       | 12 +++++------
>  arch/arm/boot/dts/exynos4412-p4note.dtsi      | 17 ++++++++-------
>  arch/arm/boot/dts/exynos4412.dtsi             |  1 -
>  arch/arm/boot/dts/exynos5250-arndale.dts      |  1 +
>  arch/arm/boot/dts/exynos5250-smdk5250.dts     |  1 +
>  arch/arm/boot/dts/exynos5250-snow-common.dtsi |  1 +
>  arch/arm/boot/dts/exynos5250-spring.dts       |  1 +
>  arch/arm/boot/dts/exynos5250.dtsi             |  4 ----
>  arch/arm/boot/dts/exynos5260-xyref5260.dts    | 11 +++++-----
>  arch/arm/boot/dts/exynos5410-odroidxu.dts     |  1 +
>  arch/arm/boot/dts/exynos5410-smdk5410.dts     |  1 +
>  arch/arm/boot/dts/exynos5420-arndale-octa.dts |  1 +
>  .../dts/exynos5420-galaxy-tab-common.dtsi     |  1 +
>  arch/arm/boot/dts/exynos5420-peach-pit.dts    |  1 +
>  arch/arm/boot/dts/exynos5420-smdk5420.dts     |  1 +
>  arch/arm/boot/dts/exynos5420.dtsi             |  3 ---
>  .../boot/dts/exynos5422-odroidxu3-common.dtsi |  1 +
>  arch/arm/boot/dts/exynos5422-samsung-k3g.dts  |  1 +
>  arch/arm/boot/dts/exynos5800-peach-pi.dts     |  1 +
>  31 files changed, 100 insertions(+), 87 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/exynos3250-artik5.dtsi b/arch/arm/boot/dts/exynos3250-artik5.dtsi
> index 0ac3f284fbb8..794cbf579316 100644
> --- a/arch/arm/boot/dts/exynos3250-artik5.dtsi
> +++ b/arch/arm/boot/dts/exynos3250-artik5.dtsi
> @@ -315,19 +315,20 @@ buck5_reg: BUCK5 {
>  };
>  
>  &mshc_0 {
> -	non-removable;
> +	status = "okay";> +	bus-width = <8>;
>  	cap-mmc-highspeed;
>  	card-detect-delay = <200>;
> -	vmmc-supply = <&ldo12_reg>;
>  	clock-frequency = <100000000>;
>  	max-frequency = <100000000>;
> +	mmc-ddr-1_8v;
> +	non-removable;
> +	pinctrl-0 = <&sd0_cmd &sd0_bus1 &sd0_bus4 &sd0_bus8>;
> +	pinctrl-names = "default";
>  	samsung,dw-mshc-ciu-div = <1>;
> -	samsung,dw-mshc-sdr-timing = <0 1>;
>  	samsung,dw-mshc-ddr-timing = <1 2>;
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&sd0_cmd &sd0_bus1 &sd0_bus4 &sd0_bus8>;
> -	bus-width = <8>;
> -	status = "okay";
> +	samsung,dw-mshc-sdr-timing = <0 1>;
> +	vmmc-supply = <&ldo12_reg>;

It is impossible to review what happenned here.

Best regards,
Krzysztof

