Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD7B36E913F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 12:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235162AbjDTK52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 06:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235094AbjDTK5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 06:57:00 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D35DBA24C
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 03:54:26 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id a10so2295931ljr.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 03:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681988064; x=1684580064;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=24JXeGlkkCliqYb2eVhfqy45HNK+Kpe6rgX3GQC2Wnw=;
        b=z24FxfOri5/lpWMIu2FfGwYIL1QayyjzC4uqJfhQmrIy+5kmrB3lsFLFXKaulumeyi
         x6cnEikwmsoVpVurOfpEREzAt33CvuhYjOcEUCHpFrKqlfmiNMY+vT4A9wkpW8mmonvw
         Ed/qNvjDQYfDHIb7Wgc1nsFWrVAftbQkJGl1LVaJLA5PdlcEpNOsQ+4zH52x8MIXddCn
         YuRdOnOyWTp1NYX1VPoB39nbble13gvn7kMD3WhQQvneqi6BHuL8RWJVJ+jGOXC+gCVS
         xQyqOV4p77yqYsUi35zIw/Vonbqhu1I9+/4d6QMXiWCZS30PAvBNVJ5SnMoTY0R6QWth
         bItg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681988064; x=1684580064;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=24JXeGlkkCliqYb2eVhfqy45HNK+Kpe6rgX3GQC2Wnw=;
        b=JTT3ghW10qn/p1oqRLo1ns1rqBDSceVLxK/382iyCjuNcJE384j+lYMsl1htTSqLvT
         E/YPd85uUCawyj9HSie9BtTM6cqFJFO8+AARrUH6UUL6XjQvpEJ+q36SyOirMZwsibfg
         LI/dkR3lmftQE0Juijx62yhFLL25j/UOxMIDHMXQ+NSCW6JlTs9J62Xozx2uAIkAC5WI
         WXpa8GE29jxjyk3ctIh1Ih81Rv/dIlQMk1mtwem9E6TxE66p++1nInxJh+D+F/se9jA7
         XcX6OR0BSVYCQKRcPFNTUQKixSV22BwDobPh/go2OWITt4l1yHAOvfTBrQzIUpNG6LHB
         iRKg==
X-Gm-Message-State: AAQBX9erGXZU9DuPq+joJwGUb+fX64ktGptdJwQDdrImjSim3z4ABiQ7
        ce4O3WODMt8Tm9z4FtMR0y33kQ==
X-Google-Smtp-Source: AKy350aZblPJn8EYpBXD60CODEbQC2hcdAGhMLnf43vCDhUDw3gWfAxZGKUMRT9AudjZxk2PyaOCEg==
X-Received: by 2002:a2e:8846:0:b0:2a8:b9e2:43ba with SMTP id z6-20020a2e8846000000b002a8b9e243bamr334982ljj.12.1681988063862;
        Thu, 20 Apr 2023 03:54:23 -0700 (PDT)
Received: from [192.168.1.101] (abyj144.neoplus.adsl.tpnet.pl. [83.9.29.144])
        by smtp.gmail.com with ESMTPSA id j17-20020a2e6e11000000b002a9ef98116asm200403ljc.49.2023.04.20.03.54.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 03:54:23 -0700 (PDT)
Message-ID: <adbc9939-8912-48fa-3802-a2d960f6ad15@linaro.org>
Date:   Thu, 20 Apr 2023 12:54:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 10/18] arm64: dts: qcom: sdm630: correct camss unit
 address
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sivaprakash Murugesan <sivaprak@codeaurora.org>,
        Todor Tomov <todor.too@gmail.com>,
        "Ivan T. Ivanov" <ivan.ivanov@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Luca Weiss <luca@z3ntu.xyz>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Adam Skladowski <a39.skl@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Robert Foss <rfoss@kernel.org>,
        Andrey Konovalov <andrey.konovalov@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Abel Vesa <abel.vesa@linaro.org>,
        Molly Sophia <mollysophia379@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230419211856.79332-1-krzysztof.kozlowski@linaro.org>
 <20230419211856.79332-10-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230419211856.79332-10-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19.04.2023 23:18, Krzysztof Kozlowski wrote:
> Match unit-address to reg entry to fix dtbs W=1 warnings:
> 
>   Warning (simple_bus_reg): /soc/camss@ca00000: simple-bus unit address format error, expected "ca00020"
> 
> Fixes: f3d5d3cc6971 ("arm64: dts: qcom: sdm630: Configure the camera subsystem")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/sdm630.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
> index eaead2f7beb4..ab04903fa3ff 100644
> --- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
> @@ -1894,7 +1894,7 @@ pil-reloc@94c {
>  			};
>  		};
>  
> -		camss: camss@ca00000 {
> +		camss: camss@ca00020 {
>  			compatible = "qcom,sdm660-camss";
>  			reg = <0x0ca00020 0x10>,
>  			      <0x0ca30000 0x100>,
