Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C46EA67A528
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 22:43:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbjAXVnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 16:43:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235060AbjAXVne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 16:43:34 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CAAF4B4A1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 13:43:31 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id vw16so42691201ejc.12
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 13:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=REF9Fo0sKbKUPgYgq1ClXxYyHpD2eo/2b/LahHN2320=;
        b=tK0gwua8KBnxjCNNIZiSmKMZxH1Xq2GMFWZkbxZlHBxQkf7whmVoR0tNVrdr+ok4mE
         MxgC1/45Ur7dOcEeZ6W7LO2Tq9xoVHheIwpkNKpG4AfeaUFU4/USWpM/zsGJdN+XF03/
         AZQMVqMRHTZDe3bzPH8wv7kweoNoSFjWkJOdeFiF1mHw1U8t1no6xulT956fV98abDjt
         A+NNlZmhBz9ZeR1bUm+8mnQf8gr9gBImV5UvNpyKLmXEbxQEvMhc4XfPCJbFnjp/LRkN
         Y9FlRqke542W93wi30+AL0w6ZTFeyg+udZs+4d48nAC/CboBFweiQbOaLnN4BV57E3Tf
         aPrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=REF9Fo0sKbKUPgYgq1ClXxYyHpD2eo/2b/LahHN2320=;
        b=y2rL6uewJjywnb1Ge0yRun7tXKYxvGqZW5muGTIk3gD4y7JNjUba39LYXdHsn5m5zC
         fiZ4WefLAZJm17FMcLEti3TpB9RRrGbdGTgpsDNIgwIkDihf4Dh61ifYo0koZ3Tsm/Ss
         rhVI+K9w606z1BUNFOtYB7VM0cCfDBMTDtVkngVZpl6+lHnluhuOB/ImCsjl2NFMt5zr
         WuOrqLJ5SXOASahBJiaGcl5j3Qj5To3A0LjlHZLWIKFOAAMBbOEAnGnDLqdibzJ2RBxz
         4DY10z5iRMRHongm9JaSEG1SdDfEvHikm4ViSsIJqTViAys1a+wjR6sVKkCZRYSBeV52
         F2Yw==
X-Gm-Message-State: AFqh2kqL7fY4cl+MkRdAH2ErnhaKEEMNZjBZNnfC3/6NU3DZVEMnbjOT
        6apN+MMNZ9MNJHPzDgPxq/0yKw==
X-Google-Smtp-Source: AMrXdXucqopCCy6mQUblvOoS2imUr4b4rNxxuleAJ/9M8nNSvDTTAFCtJ7pfS2ZCXFjAe/O7Qc/2VQ==
X-Received: by 2002:a17:907:2982:b0:7c1:23f2:c052 with SMTP id eu2-20020a170907298200b007c123f2c052mr21529722ejc.45.1674596609850;
        Tue, 24 Jan 2023 13:43:29 -0800 (PST)
Received: from [192.168.1.101] (abyl109.neoplus.adsl.tpnet.pl. [83.9.31.109])
        by smtp.gmail.com with ESMTPSA id o14-20020a170906774e00b0084d1b34973dsm1421473ejn.61.2023.01.24.13.43.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 13:43:29 -0800 (PST)
Message-ID: <973776ae-0434-db09-0ffb-d88f65bdf050@linaro.org>
Date:   Tue, 24 Jan 2023 22:43:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 1/2] arm64: dts: qcom: sa8540p-ride: Fix some i2c pinctrl
 settings
Content-Language: en-US
To:     Andrew Halaney <ahalaney@redhat.com>, andersson@kernel.org
Cc:     agross@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bmasney@redhat.com, quic_shazhuss@quicinc.com
References: <20230124192351.695838-1-ahalaney@redhat.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230124192351.695838-1-ahalaney@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24.01.2023 20:23, Andrew Halaney wrote:
> Some of the pinctrl groups were invalid for the selected pins. Select
> the proper qup group to fix these warnings:
> 
> [    6.523566] sc8280xp-tlmm f100000.pinctrl: invalid group "gpio135" for function "qup15"
> [    6.535042] sc8280xp-tlmm f100000.pinctrl: invalid group "gpio136" for function "qup15"
> [    6.597536] sc8280xp-tlmm f100000.pinctrl: invalid group "gpio158" for function "qup15"
> [    6.597544] sc8280xp-tlmm f100000.pinctrl: invalid group "gpio159" for function "qup15"
> [    6.597991] sc8280xp-tlmm f100000.pinctrl: invalid group "gpio0" for function "qup15"
> [    6.597996] sc8280xp-tlmm f100000.pinctrl: invalid group "gpio1" for function "qup15"
> 
> Fixes: e073899ec3e1 ("arm64: dts: qcom: sa8540p-ride: add i2c nodes")
> Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
> ---
This matches the pinctrl .c driver.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/sa8540p-ride.dts | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sa8540p-ride.dts b/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
> index eacc1764255b..cb9fbdeb5a9e 100644
> --- a/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
> +++ b/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
> @@ -318,21 +318,21 @@ &xo_board_clk {
>  &tlmm {
>  	i2c0_default: i2c0-default-state {
>  		pins = "gpio135", "gpio136";
> -		function = "qup15";
> +		function = "qup0";
>  		drive-strength = <2>;
>  		bias-pull-up;
>  	};
>  
>  	i2c1_default: i2c1-default-state {
>  		pins = "gpio158", "gpio159";
> -		function = "qup15";
> +		function = "qup1";
>  		drive-strength = <2>;
>  		bias-pull-up;
>  	};
>  
>  	i2c12_default: i2c12-default-state {
>  		pins = "gpio0", "gpio1";
> -		function = "qup15";
> +		function = "qup12";
>  		drive-strength = <2>;
>  		bias-pull-up;
>  	};
