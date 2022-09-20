Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9B85BEA05
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 17:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbiITPUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 11:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbiITPUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 11:20:14 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A51665E55B
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 08:20:11 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id k10so4364838lfm.4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 08:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=S11NggDEZbAzaPL/B9baBHcXqnC/Zw2y7dmhiZ0KQDI=;
        b=aEu0ti9RrFrHCkNWVqigZIAEzauAIe8PTyD9VWYptLoZMC6ceBDf4JGH3Li0zcqfrx
         sqaSqlxicxGCCpHj2KczRyka4NWfzvvpIu5LAvy1IC0Yf63yrK8qkxKVgkvGE8d0jADQ
         Zu05iLNJHadGxStI4Pn5g47S4YkEFtUsTHHl/1caYCkFMri3fCPu0c0AGP/aiM0BPtkm
         ZRbzvPKOWtu/gJqjCw5JS++ZAdtx9jkOUh8YkrJUlDJ4KHb618ypq6ex7Q5mYGeRfO42
         llRZa1r1GiTCfkLW4yPNHRo5bS45hAs8tQ6YP9d6v9e4u8gF0iN9WgWHOZjXHrFU08nx
         AKcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=S11NggDEZbAzaPL/B9baBHcXqnC/Zw2y7dmhiZ0KQDI=;
        b=Y3RZLnxb5FWSQBJ7snW+ESsY0Z2AoJYFIyin3uUyqMQUdoZc1AELaiJoOAsftPi23m
         Adm/o3e4uAXTqpO0DExpq8bNmtPEacYRu8uRfbQ/Q8UZV18YC5AcjTj164Achxyf6oNX
         fiED6CrPD3UWZMyg1lrTAp3oDu7YOFaQAeHCHKwvtXXDF6Cu47lt0lcIc/7l+ijriVvD
         pI/F9k+1ur34QT43LBdEY5+zllNlr6J6RRDLkkWpQg1BXCQ3tFrwcHgk3cjyE8rGNsfa
         JsZer9tHsACPTMN2ywUZ7VprwmUdaX22BteWO/CJQWHocLlp2To8tVRppACqYZWYbNIm
         NGhA==
X-Gm-Message-State: ACrzQf3++Tvvfa6f3tED/wPFF/rE8PcXl1rxbrAu02zHbY8i+1fEcNzj
        JWttsY08vS4dsvJwIO7qW+6KbpIe58fVTw==
X-Google-Smtp-Source: AMsMyM72/7126sVD9qFY5ExNfMrGtbf+z9xceAI2UZHTPCg5s+yM78dWdIGH+qmuqmPXCliHph5fhw==
X-Received: by 2002:a05:6512:201b:b0:497:a29d:25c1 with SMTP id a27-20020a056512201b00b00497a29d25c1mr8960124lfb.276.1663687209774;
        Tue, 20 Sep 2022 08:20:09 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id z10-20020a056512370a00b0049478cc4eb9sm2165lfr.230.2022.09.20.08.20.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 08:20:09 -0700 (PDT)
Message-ID: <30ea787d-8987-8bb3-4fb6-c2c547b8c223@linaro.org>
Date:   Tue, 20 Sep 2022 17:20:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 1/2] arm64: dts: socfpga: Add clk-phase-sd-hs property to
 the sdmmc node
Content-Language: en-US
To:     Dinh Nguyen <dinguyen@kernel.org>, jh80.chung@samsung.com
Cc:     ulf.hansson@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220919181309.286611-1-dinguyen@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220919181309.286611-1-dinguyen@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/09/2022 20:13, Dinh Nguyen wrote:
> The sdmmc controller's CIU(Card Interface Unit) clock's phase can be
> adjusted through the register in the system manager. Add the binding
> "altr,sysmgr-syscon" to the SDMMC node for the driver to access the
> system manager. Add the "clk-phase-sd-hs" property in the SDMMC node to
> designate the smpsel and drvsel properties for the CIU clock.
> 
> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
> ---
>  arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi      | 1 +
>  arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts | 1 +
>  arch/arm64/boot/dts/intel/socfpga_agilex.dtsi          | 1 +
>  arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dts     | 1 +
>  arch/arm64/boot/dts/intel/socfpga_n5x_socdk.dts        | 1 +
>  5 files changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
> index 14c220d87807..a5d08920ac81 100644
> --- a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
> +++ b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
> @@ -309,6 +309,7 @@ mmc: mmc@ff808000 {
>  				 <&clkmgr STRATIX10_SDMMC_CLK>;
>  			clock-names = "biu", "ciu";
>  			iommus = <&smmu 5>;
> +			altr,sysmgr-syscon = <&sysmgr 0x28 0>;

Missing bindings change.


Best regards,
Krzysztof
