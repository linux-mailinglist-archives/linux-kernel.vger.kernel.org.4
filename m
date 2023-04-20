Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB346E90BB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 12:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234303AbjDTKqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 06:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234452AbjDTKpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 06:45:41 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E0BD658C
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 03:44:55 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id h4so2297404ljb.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 03:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681987492; x=1684579492;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=keeALs6lvkX/Tz23QD0lH6BGnlIDkKXtcHe2ftguPZM=;
        b=kj2bAIhCXScUbq3VgiEqEUtg7Vo+zS02TE365Izvn3Mq52Qhv1pSIu+DE8G+PaOLPH
         dJdj84cjL44OJQmBRZvGQNXz0tkW25dYhWdWG2LPYSNeK8TorwNrrB2VeXOhY/v51bJ/
         M4Tg2LKjiz4kZE0j6lM73KSYjBBDTRPiLcp/DlrMP0kYRHZ0RMH9S5U6loQWweFd8UNM
         JYl0pd7V2tNJB0km9IDZWhbI007InCqUm7jxrHYz9pMLgbu1N6NKewvESUicHY3r51F6
         1cTU+6f399pR8Z3ajtgqMpJSVXiMTVBEQHM58j7pF4VcpMI8duXBnvhqCUNkhyVYTbEg
         Njag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681987492; x=1684579492;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=keeALs6lvkX/Tz23QD0lH6BGnlIDkKXtcHe2ftguPZM=;
        b=QX+N4ZY0/8s97B2K2DoUGIQap4N9bHARcrBI+Gw1xCyh+mCQdX/qFMVBW4J4zw4JhU
         cTb1L8+Gu1ghFv0SYAhq+gGGirWoinefzZIfmXtgvgk+uuOM239v9E6U4mdJ7XNgxuEN
         Q4mSf2LrqBYFAXtmYUAH67UuRJ2VD3f2aQyTIEE32HGtOyF2uhlks5Ov7Jzr2LmnkGPY
         RvZfoKYpU/sNs7bgitISOQAczzTfPG7CKADpGil5wEWqDl08+tlQPAGyOQUlGyHuLXf0
         IvxxQAw6Uk3l/WDxzwfDxfSwoJPl6BgyDEJE1kVZ4SxYVsOQYDJO4wEqbzXoyVX82Jqp
         FHDA==
X-Gm-Message-State: AAQBX9fg47DSsUCFDyB+fDHnbYhdlddzXIrQC8ZDiYSrrRWPfxt9qQdc
        l9BZ1EDqbtRP1kmugytuJUoOow==
X-Google-Smtp-Source: AKy350bB66FYtrRoTZ6HTF1AHEnqG1YiQoIVYd0vScHXBaw5nx96EXLIrvMrT1cHm6219aLzyrma6w==
X-Received: by 2002:a2e:a179:0:b0:2a7:6dd3:cce7 with SMTP id u25-20020a2ea179000000b002a76dd3cce7mr349029ljl.37.1681987492441;
        Thu, 20 Apr 2023 03:44:52 -0700 (PDT)
Received: from [192.168.1.101] (abyj144.neoplus.adsl.tpnet.pl. [83.9.29.144])
        by smtp.gmail.com with ESMTPSA id y13-20020ac255ad000000b004e84896253asm172653lfg.251.2023.04.20.03.44.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 03:44:52 -0700 (PDT)
Message-ID: <d1ffc9a9-63b7-905d-547a-a38982ceaa80@linaro.org>
Date:   Thu, 20 Apr 2023 12:44:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 5/7] arm64: dts: qcom: msm8998: add unit address to soc
 node
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230420063610.11068-1-krzysztof.kozlowski@linaro.org>
 <20230420063610.11068-5-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230420063610.11068-5-krzysztof.kozlowski@linaro.org>
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



On 20.04.2023 08:36, Krzysztof Kozlowski wrote:
> "soc" node is supposed to have unit address:
> 
>   Warning (unit_address_vs_reg): /soc: node has a reg or ranges property, but no unit name
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/msm8998.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
> index b150437a8355..803a1f1f2597 100644
> --- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
> @@ -800,7 +800,7 @@ timer {
>  			     <GIC_PPI 0 IRQ_TYPE_LEVEL_LOW>;
>  	};
>  
> -	soc: soc {
> +	soc: soc@0 {
>  		#address-cells = <1>;
>  		#size-cells = <1>;
>  		ranges = <0 0 0 0xffffffff>;
