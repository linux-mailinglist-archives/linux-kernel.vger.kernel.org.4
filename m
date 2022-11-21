Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51D6E632162
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 12:54:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbiKULym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 06:54:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiKULyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 06:54:39 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4532016589;
        Mon, 21 Nov 2022 03:54:38 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id v124-20020a1cac82000000b003cf7a4ea2caso12557108wme.5;
        Mon, 21 Nov 2022 03:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QB3gNY6yaJMnXhVV7emf4yfo6x5OMz0IYCSWMhi+hEc=;
        b=P+U1OHpHssZT7auV7/xQp9Brb8pDG6DU/KV7YI8GMe86bDpGxYvSv30QBbAWThUDJF
         FY6ychSgiFKhH8qFbXbsbp0b2ZJ/nlQBVL8V9JRNA9DBgG8xFA3pF/bWQgjmD4OHCnZz
         HmiJrKUozvlHT1cRscyxWXgUPsr+y47pZTb27di//zCtLKi2VxciO74sArOihoYsS8Uo
         KE4UiSSAPhd24pzMvJRhGCvbjb5Fi0Byc3RtX9ZnLzZLHd178saR07bvEt4kLnQY2uIe
         Mgvw+6FHZXZwL5CC5RAwblaXjI3voRomDYrV9M+zafQopTsTZB7v3a9gDlZibkSlbod4
         eMPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QB3gNY6yaJMnXhVV7emf4yfo6x5OMz0IYCSWMhi+hEc=;
        b=anGYpwTKE5shp87AatpF0EXwlX8UCaS6wtQufF3oUXa4+c5lah0qGXAXnon5ggGQhv
         uyIK3cnF1WD+AxTWMNoyOA/Jk4oiMoACfGeY6asB8KQJGD6I6zr1+DYHsPOLFtBlvaIA
         kKV+sMxKTvBGhDsbJuMC0MH0arO4AHKvTfi9kfgFsxoyD5HUokz6TqN4bWKykgg4gsWW
         onGvAAFtsPstSSCjoC/s9Tg3iN6FlsawTig85yea1nxvx8pdbsXmKNzDGk1Qwi3t2nSy
         8x0KRCoJcmjUrqS3jitMFQ4R+uByelaewQgiks9FXuEOuiJQgmHlI9SsFz0eJXj0b9MV
         TB6g==
X-Gm-Message-State: ANoB5pkhvAXUVL1TYFWPnsZtSwkG+6IJNMQt8zQCKIVvi3XX/8rE6lKf
        N3WhEWo0gpfwmRJIoa+byPc=
X-Google-Smtp-Source: AA0mqf5yPHbwfASaKwZ0hgwUWI2wZ/5w3j0QHXDZp6K/Ira6H0o+d3uT1LxH0796iYp7TEGBTIBqDg==
X-Received: by 2002:a7b:ce89:0:b0:3c6:c986:f2b9 with SMTP id q9-20020a7bce89000000b003c6c986f2b9mr12282679wmj.53.1669031676568;
        Mon, 21 Nov 2022 03:54:36 -0800 (PST)
Received: from [192.168.1.131] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id i6-20020a05600c354600b003cf894c05e4sm18918780wmq.22.2022.11.21.03.53.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 03:54:34 -0800 (PST)
Message-ID: <c1fbe477-8991-2ac4-7f0a-11360868ca11@gmail.com>
Date:   Mon, 21 Nov 2022 12:53:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] arm64: dts: mediatek: mt8195: Fix CPUs capacity-dmips-mhz
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, robh+dt@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, tinghan.shen@mediatek.com,
        seiya.wang@mediatek.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221005093404.33102-1-angelogioacchino.delregno@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20221005093404.33102-1-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/10/2022 11:34, AngeloGioacchino Del Regno wrote:
> The capacity-dmips-mhz parameter was miscalculated: this SoC runs
> the first (Cortex-A55) cluster at a maximum of 2000MHz and the
> second (Cortex-A78) cluster at a maximum of 3000MHz.
> 
> In order to calculate the right capacity-dmips-mhz, the following
> test was performed:
> 1. CPUFREQ governor was set to 'performance' on both clusters
> 2. Ran dhrystone with 500000000 iterations for 10 times on each cluster
> 3. Calculate the mean result for each cluster
> 4. Calculate DMIPS/MHz: dmips_mhz = dmips_per_second / cpu_mhz
> 5. Scale results to 1024:
>     result_c0 = (dmips_mhz_c0 - min_dmips_mhz(c0, c1)) /
>                 (max_dmips_mhz(c0, c1) - min_dmips_mhz(c0, c1)) * 1024
> 
> The mean results for this SoC are:
> Cluster 0 (LITTLE): 11990400 Dhry/s
> Cluster 1 (BIG): 59809036 Dhry/s
> 
> The calculated scaled results are:
> Cluster 0: 307,934312801831 (rounded to 308)
> Cluster 1: 1024
> 
> Fixes: 37f2582883be ("arm64: dts: Add mediatek SoC mt8195 and evaluation board")
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Applied,

Thanks!

> ---
>   arch/arm64/boot/dts/mediatek/mt8195.dtsi | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> index 905d1a90b406..0b85b5874a4f 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> @@ -36,7 +36,7 @@ cpu0: cpu@0 {
>   			enable-method = "psci";
>   			performance-domains = <&performance 0>;
>   			clock-frequency = <1701000000>;
> -			capacity-dmips-mhz = <578>;
> +			capacity-dmips-mhz = <308>;
>   			cpu-idle-states = <&cpu_off_l &cluster_off_l>;
>   			next-level-cache = <&l2_0>;
>   			#cooling-cells = <2>;
> @@ -49,7 +49,7 @@ cpu1: cpu@100 {
>   			enable-method = "psci";
>   			performance-domains = <&performance 0>;
>   			clock-frequency = <1701000000>;
> -			capacity-dmips-mhz = <578>;
> +			capacity-dmips-mhz = <308>;
>   			cpu-idle-states = <&cpu_off_l &cluster_off_l>;
>   			next-level-cache = <&l2_0>;
>   			#cooling-cells = <2>;
> @@ -62,7 +62,7 @@ cpu2: cpu@200 {
>   			enable-method = "psci";
>   			performance-domains = <&performance 0>;
>   			clock-frequency = <1701000000>;
> -			capacity-dmips-mhz = <578>;
> +			capacity-dmips-mhz = <308>;
>   			cpu-idle-states = <&cpu_off_l &cluster_off_l>;
>   			next-level-cache = <&l2_0>;
>   			#cooling-cells = <2>;
> @@ -75,7 +75,7 @@ cpu3: cpu@300 {
>   			enable-method = "psci";
>   			performance-domains = <&performance 0>;
>   			clock-frequency = <1701000000>;
> -			capacity-dmips-mhz = <578>;
> +			capacity-dmips-mhz = <308>;
>   			cpu-idle-states = <&cpu_off_l &cluster_off_l>;
>   			next-level-cache = <&l2_0>;
>   			#cooling-cells = <2>;
