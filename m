Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A102E63F2A2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 15:21:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231823AbiLAOVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 09:21:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231849AbiLAOVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 09:21:03 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA0CB2B40
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 06:20:59 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id x6so2029920lji.10
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 06:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bU1Vwk5Tmv4K9L2VLdgCnaQGUjWEJsKp00x/W3heURk=;
        b=HS1BLG4qnjMDc4F3JIRikYOrGBGxN1wAY476bEDpuo+WAy0l/myC7qWNbJ8WoADIsL
         6mMQmex8rDOvMcRa+wyPDQZo1SOfeQwtz2KeMFlOpa40Ddgq9WyhQQP1QSaGyyVBzQvi
         /6DmuCbycX/0jnTI9dzR1jAd3QX4uT2o2tgqlq/41IUN4r1iVIF7GZ4+EpxzFvS0kCs3
         bdPNup/X2bH1XpQtApW+tUIJciD6sZkQOn9MHTAlNa0CFjnVWtelOiZ7PAXlUKPgUF9l
         cE0SrNwDnBr6gAZfaOmJuSFct5DirKH6PukFuE9+rPKFz8wZ22M5syrwMwC3Dua7Go0w
         3mUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bU1Vwk5Tmv4K9L2VLdgCnaQGUjWEJsKp00x/W3heURk=;
        b=Caavw6BqlstltHkGRu3y7NWTxkj3VnB7sdMZGAJexiYcClO43p/k4AfTHzcwPVxg9D
         sKtsUtgUO6q8WVt/Gt2BPrxf1sp3GSa7aTFwsk3XdBXbGzfGZ6OTdiRVT6i7fxXBmQuU
         UkxQZ4G97XtZV+PcRUBY+CUUSV7jb16UhxO7oOeyp7BEYkY7Tf4gBQqA9rwNtt9elLWi
         +YZ/nZtEsOS/WYWVEJiKSNJQp72SKZv/iqrf5HrBiVZ3xDt4Brm6pFFmMB8njczb4JgV
         2LRzQUWx8hW/82brC1iBy9yU0ib/WRtnDXz3M5ZgzPmP8PtuCJGIMjE3K6jHjJm6PT+7
         1RPA==
X-Gm-Message-State: ANoB5pnmNK5a2tCHYZVV1l/BZztAMkLZZPc/Y491QmXcaC3XrSDmkcH0
        wIXXD6x85Ntv+MbPf+b/OKsevQ==
X-Google-Smtp-Source: AA0mqf6J6k0OFCFa1BM3BigB8Pj/um7/adyO77ipGhIpgb1e4AaxHzi419P6M5zNn9+T+qn9jTTtdw==
X-Received: by 2002:a2e:b631:0:b0:277:890a:f1cc with SMTP id s17-20020a2eb631000000b00277890af1ccmr21408432ljn.395.1669904458058;
        Thu, 01 Dec 2022 06:20:58 -0800 (PST)
Received: from [192.168.1.101] (95.49.124.14.neoplus.adsl.tpnet.pl. [95.49.124.14])
        by smtp.gmail.com with ESMTPSA id z22-20020a056512309600b004b4b5bde0c2sm653174lfd.279.2022.12.01.06.20.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Dec 2022 06:20:57 -0800 (PST)
Message-ID: <1cdcafab-5dae-09af-3101-9f7d57bed189@linaro.org>
Date:   Thu, 1 Dec 2022 15:20:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 3/4] dt-bindings: arm: qcom,ids: Add SoC IDs for SM6115 /
 SM4250 and variants
Content-Language: en-US
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     agross@kernel.org, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski@linaro.org, andersson@kernel.org,
        a39.skl@gmail.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
References: <20221201141619.2462705-1-bhupesh.sharma@linaro.org>
 <20221201141619.2462705-4-bhupesh.sharma@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221201141619.2462705-4-bhupesh.sharma@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1.12.2022 15:16, Bhupesh Sharma wrote:
> Add SoC IDs for Qualcomm SM6115 / SM4250 and variants.
> 
> Cc: Bjorn Andersson <andersson@kernel.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: Konrad Dybcio <konrad.dybcio@somainline.org>
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  include/dt-bindings/arm/qcom,ids.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/dt-bindings/arm/qcom,ids.h b/include/dt-bindings/arm/qcom,ids.h
> index 5e0524991e99..8f5324dd3ff2 100644
> --- a/include/dt-bindings/arm/qcom,ids.h
> +++ b/include/dt-bindings/arm/qcom,ids.h
> @@ -125,11 +125,13 @@
>  #define QCOM_ID_IPQ8071A		396
>  #define QCOM_ID_IPQ6018			402
>  #define QCOM_ID_IPQ6028			403
> +#define QCOM_ID_SM4250			417
>  #define QCOM_ID_IPQ6000			421
>  #define QCOM_ID_IPQ6010			422
>  #define QCOM_ID_SC7180			425
>  #define QCOM_ID_SM6350			434
>  #define QCOM_ID_SM8350			439
> +#define QCOM_ID_SM6115			444
>  #define QCOM_ID_SC8280XP		449
>  #define QCOM_ID_IPQ6005			453
>  #define QCOM_ID_QRB5165			455
> @@ -137,6 +139,8 @@
>  #define QCOM_ID_SM7225			459
>  #define QCOM_ID_SA8295P			460
>  #define QCOM_ID_SA8540P			461
> +#define QCOM_ID_QCM4290			469
> +#define QCOM_ID_QCS4290			470
>  #define QCOM_ID_SM8450_2		480
>  #define QCOM_ID_SM8450_3		482
>  #define QCOM_ID_SC7280			487
