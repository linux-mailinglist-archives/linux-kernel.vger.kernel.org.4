Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20BE56B7199
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 09:51:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbjCMIvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 04:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbjCMIup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 04:50:45 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7103A3864C
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 01:49:03 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id r27so14645800lfe.10
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 01:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678697339;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+okBj9+YTOyap+UDm1PgUDE4NHs7gwqOJzJzAUx2O4w=;
        b=Wgv4OU2aOmxCcxpdbBITu5aDCDFBDZ+UEl1nfVQWtw3Uw/xz6ifR4pByxkeKtzjID+
         naCaNyfGTOVoITOk04UfU7VUNjWL9ZiKR4ZrX+p4qSVu1JI0VAHQ/d/Dt6thrvAxS/yj
         U//xFu6obeYwVORh6xckkUEYbasfFpH7GQCX7lw9/v7rqoZV+AAQutn/B/N8o5MGfEbN
         8nNeXa3+h1obGXm2jxqr3gvyWgquUJBHviA70FeC/dYqYdbX2UqsT7o1FM7YISRcpyX9
         P+ewGG2MD6YZsrjNFVxudD4qOtfAtGdhMAVIKZAm1YYDGODXEV1RVTfSiloLF6XUxqtm
         FuLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678697339;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+okBj9+YTOyap+UDm1PgUDE4NHs7gwqOJzJzAUx2O4w=;
        b=FkW8p9ZnkJtLmvvfXcaAdPtVoyFuaMx1hnttJP6wdt8/tChG1f88WeLSfMdK+nL6th
         jRC6shyZUvUG1LrmonNtISIeP4duXCbkA9VYokNS7GVB9zy0WVwyAu/mw3JrI289Wl6m
         req21YxssfTiMFrcicnpNWPjaWMNAVJDLZiKh2kc+aqw6+p9EIAaisJM+/gNIEF//5he
         zdciEZCPEXlHYrrKfZDB/ykW5ewLnvS7bFzgYepnD3O8Z0r4Hv4sAlAVfy2i9vz4vOSP
         EjEnHnEIlVAdxe3ZkJw1VXjaoGoxqHqQ9dI2wtuzyqhubvMdFSQl8CYVgPPdLLoUIFTw
         v0Jg==
X-Gm-Message-State: AO0yUKX5sEXkq1RieeHPfe1ng0knKhFaUuUS4fLtou1SCHNyacIz+90K
        DnjjA8wQyloYiyJTmcX2sBU2Pg==
X-Google-Smtp-Source: AK7set9z4jCiDG2Fzf+dBk6Uh1F5uu9dcTqK2xnZNfEbnJUXi5eodVIfAhIsf3gj/zUqt6Bie/ZwOg==
X-Received: by 2002:ac2:44cc:0:b0:4db:25f2:c116 with SMTP id d12-20020ac244cc000000b004db25f2c116mr9150127lfm.18.1678697339378;
        Mon, 13 Mar 2023 01:48:59 -0700 (PDT)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id p3-20020a19f003000000b004b4b600c093sm907135lfc.92.2023.03.13.01.48.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Mar 2023 01:48:59 -0700 (PDT)
Message-ID: <fc42ec1d-76ab-e44d-79a3-1f53bb79337d@linaro.org>
Date:   Mon, 13 Mar 2023 09:48:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/8] arm64: dts: qcom: sc7280-herobrine-villager: correct
 trackpad supply
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        "Joseph S. Barrera III" <joebar@chromium.org>,
        Gustave Monce <gustave.monce@outlook.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230312183622.460488-1-krzysztof.kozlowski@linaro.org>
 <20230312183622.460488-2-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230312183622.460488-2-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12.03.2023 19:36, Krzysztof Kozlowski wrote:
> The hid-over-i2c takes VDD, not VCC supply.  Fix copy-pasta from other
> Herobrine boards which use elan,ekth3000 with valid VCC:
> 
>   sc7280-herobrine-villager-r1-lte.dtb: trackpad@2c: 'vcc-supply' does not match any of the regexes: 'pinctrl-[0-9]+'
> 
> Fixes: ee2a62116015 ("arm64: dts: qcom: sc7280: Add device tree for herobrine villager")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---


Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/sc7280-herobrine-villager.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager.dtsi
> index 818d4046d2c7..38c8a3679fcb 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager.dtsi
> @@ -33,7 +33,7 @@ trackpad: trackpad@2c {
>  		interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
>  
>  		hid-descr-addr = <0x20>;
> -		vcc-supply = <&pp3300_z1>;
> +		vdd-supply = <&pp3300_z1>;
>  
>  		wakeup-source;
>  	};
