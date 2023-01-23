Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A87A678173
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 17:30:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232627AbjAWQaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 11:30:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232233AbjAWQaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 11:30:17 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C4392BEFD
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 08:29:54 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id rl14so28648487ejb.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 08:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TASDLyKH+0DjNc1kNKn1XmKSEz18xnkdI15P2UbcAWA=;
        b=SEoC8mIsBQpVsNL2SVpaX/Me7/JqveYsN/AJ66jJyFj5rhL9xBCbptenc9ciLNnrVc
         KHsDrFGXh7FIUYQcybbIIPplTH49U46Sh5Tw8e9Vj5pAISupKU5vjsuAtI++WQyZdu4L
         +t9/9uqk4bM9YExaatLWO2fDozZmJoGl09pb+PLFMTCnxx0FDkYKLeqggM4T0LJOi7r9
         PJF2UqpmcCJza2j+2Zcf58z5n564C4rStg0qJ8SbYoihP62Do07fFKdstIneYafQXhPO
         k0+o2+ude7SzDVYOXI7KUSUE2JEiaMxuEmvs/VbU29SrWzh0/5NkyjJQov+njEInrFjx
         0qUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TASDLyKH+0DjNc1kNKn1XmKSEz18xnkdI15P2UbcAWA=;
        b=yr5ZqHvcm+d10eqRicdm5IdxbwSZEZVj50NotsySUcxof2NIDNKqKsU8EBCHPojka2
         uPhA18phQjQPuWBzpPVvWzhJuo0JMahLJvscfQ/j/Ju6XCBe44gsDTRBUtvl3ZCsmgdL
         nUB7M/pq39hJBwNNiUKx1SngfTPzHDBvhGdcQYnzCod3DkTk2aCyLEQf98wI2YtkhNm6
         NQQDDos5ODL6Knf86o+vilzWJ/XaixUsTt5SBnlyvXYMZ/KYx3WMYcKwSS2ziMZtqEeb
         xbS/c9LH5sZLx44doPhRIJBWelS7MCdRD2UtJ7SGloSRdIfY39SBwhutjdOMdpcSb38K
         bf1Q==
X-Gm-Message-State: AFqh2kp995iwcTZhyYvz7JPNOKs7V/3wcxzognml6Tle1a5ORR/tHTlE
        JE2X1bYmShvNdMKjhE9/jwi3BA==
X-Google-Smtp-Source: AMrXdXv6uGougMYEDD5lLrYNdz6BR2Jr2z2VhkIydC8OzXmpkcu1kg8rLsEa1mULz9hSljpmUUWDXA==
X-Received: by 2002:a17:906:95d2:b0:7c0:a6a9:64e9 with SMTP id n18-20020a17090695d200b007c0a6a964e9mr27120793ejy.36.1674491393106;
        Mon, 23 Jan 2023 08:29:53 -0800 (PST)
Received: from [192.168.1.101] (abxi24.neoplus.adsl.tpnet.pl. [83.9.2.24])
        by smtp.gmail.com with ESMTPSA id hr35-20020a1709073fa300b00877557ae644sm8748272ejc.71.2023.01.23.08.29.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 08:29:52 -0800 (PST)
Message-ID: <a7d10bdf-f605-7cef-3ccb-68592febb67b@linaro.org>
Date:   Mon, 23 Jan 2023 17:29:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v2 4/4] arm64: dts: qcom: sm8550: drop incorrect cells
 from serial
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230123125612.154840-1-krzysztof.kozlowski@linaro.org>
 <20230123125612.154840-4-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230123125612.154840-4-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23.01.2023 13:56, Krzysztof Kozlowski wrote:
> The serial/UART device node does not have children with unit addresses,
> so adderss/size cells are not correct.
> 
> Fixes: 377972ac743f ("arm64: dts: qcom: sm8550: add I2C Master Hub nodes")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
> 
> Changes since v1:
> 1. New patch
> ---
>  arch/arm64/boot/dts/qcom/sm8550.dtsi | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> index 6ff135191ee0..0307b853ec4f 100644
> --- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> @@ -1582,8 +1582,6 @@ uart7: serial@a9c000 {
>  				interconnect-names = "qup-core", "qup-config";
>  				interconnects =	<&clk_virt MASTER_QUP_CORE_1 0 &clk_virt SLAVE_QUP_CORE_1 0>,
>  						<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_QUP_1 0>;
> -				#address-cells = <1>;
> -				#size-cells = <0>;
>  				status = "disabled";
>  			};
>  		};
