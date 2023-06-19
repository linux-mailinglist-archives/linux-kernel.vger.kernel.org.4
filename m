Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A195373581F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 15:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbjFSNMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 09:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbjFSNMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 09:12:25 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75196E60
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 06:12:22 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f762b3227dso4141073e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 06:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687180341; x=1689772341;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8c+PKgYSaMUQpe5P7IcFPccIwoeRkhCGol6IejFiVag=;
        b=BCAk4DTYBZqlNLS0BODZwt8pA70k36Me2R9Pl9GoXYoLLIokwJjkiEZdyoDUZ2qjnC
         q47J/E0fZ3XEfSBoXou/XxShwTtnlGV/+dIg/HLo+RkghrjwRqlRsr3L3fHF9O6XM4up
         gLp+fTMit/MRConp5oNRS9pcAWtUhvmUY341Ki/bndolzUmoyFUhvnbjw+EaF3bxfFVi
         J7aY2KbeTz20xjgg7EcAE115F3MzjgvNETEj2lf1u80hD3ehiuLfnKMsAng2BHjTbAEb
         PfnGH5X6x6U+8OsHLDTpCipAyC0pTTqixK8AUQ3/2mTjYKJh8wSq19dI6SI2HfI9+kvf
         airg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687180341; x=1689772341;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8c+PKgYSaMUQpe5P7IcFPccIwoeRkhCGol6IejFiVag=;
        b=Go2osDlhViM2KNDsRXjVfR0UerqkOrNeEYoOJKjn7NgFy8C0mN+GClx7Vw0mUfOGJz
         0EONjWs7GkE4iINru1TsYWx6RhihRTr9THA8sBLDWF7pqfKUyGj62jIKwiJp3fv0/kWY
         GiqcwObZdubST9xi+sg4cguJzdsf0nfM9TVM9KN8Unzb519g3sd7KDakkujB35iXq5lJ
         wz72mvad3tNVH9pwRqXMyYarQIZiJe6pVi7yIgbUDv0wAUndWsXAnsVv/FIE3IjYSFYy
         5drDfoYCmtTqKP7oepHOXzOtQZJBbgowPB/RJ0kWlCMQE0Ov3LTKKeN9Bp5rLEffRAVN
         XCJQ==
X-Gm-Message-State: AC+VfDw81JN/+MqpAl1kSqBo26YNYNpL6JP6OeoNsshatCkkunJqdiDV
        qvhEf7FdGfbS0rrG1RRRbaKgfg==
X-Google-Smtp-Source: ACHHUZ6KrcJEUvsbFSOWx1Gpv1Tuu4+yk8DyuCgl4FliCyVzK6Bt7M277Ive/mtM4G/luQ4t0lEnSw==
X-Received: by 2002:a05:6512:3d12:b0:4f7:557b:fca4 with SMTP id d18-20020a0565123d1200b004f7557bfca4mr5820428lfv.26.1687180340830;
        Mon, 19 Jun 2023 06:12:20 -0700 (PDT)
Received: from [192.168.1.101] (abyl242.neoplus.adsl.tpnet.pl. [83.9.31.242])
        by smtp.gmail.com with ESMTPSA id c15-20020ac2414f000000b004f861e64f24sm1088925lfi.113.2023.06.19.06.12.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jun 2023 06:12:20 -0700 (PDT)
Message-ID: <48db4706-de69-04ff-2733-ab05ecfaa9df@linaro.org>
Date:   Mon, 19 Jun 2023 15:12:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 04/15] arm64: dts: qcom: apq8096-db820c: drop label from
 I2C
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org,
        Nikita Travkin <nikita@trvn.ru>,
        Stephan Gerhold <stephan@gerhold.net>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230617171541.286957-1-krzysztof.kozlowski@linaro.org>
 <20230617171541.286957-4-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230617171541.286957-4-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.06.2023 19:15, Krzysztof Kozlowski wrote:
> I2C controller bindings do not allow label property:
> 
>   apq8096-db820c.dtb: i2c@7577000: Unevaluated properties are not allowed ('label' was unexpected)
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/apq8096-db820c.dts | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/apq8096-db820c.dts b/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
> index 537547b97459..002cf5806d83 100644
> --- a/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
> +++ b/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
> @@ -138,8 +138,7 @@ wlan_en: wlan-en-1-8v {
>  };
>  
>  &blsp1_i2c3 {
> -	/* On Low speed expansion */
> -	label = "LS-I2C0";
> +	/* On Low speed expansion: LS-I2C0 */
>  	status = "okay";
>  };
>  
> @@ -168,14 +167,12 @@ &adsp_pil {
>  };
>  
>  &blsp2_i2c1 {
> -	/* On High speed expansion */
> -	label = "HS-I2C2";
> +	/* On High speed expansion: HS-I2C2 */
>  	status = "okay";
>  };
>  
>  &blsp2_i2c1 {
> -	/* On Low speed expansion */
> -	label = "LS-I2C1";
> +	/* On Low speed expansion: LS-I2C1 */
>  	status = "okay";
>  };
>  
