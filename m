Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7837A72FE94
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 14:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243076AbjFNM04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 08:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244454AbjFNM0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 08:26:52 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7B7E1FE8
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 05:26:50 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f8d5262dc8so4818805e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 05:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686745609; x=1689337609;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3NY9mrsvwl5zfIPZArwnmdeb4vxo5oIHW0I0xAx9Ck0=;
        b=GyhLvqWEBVUiGocpa8YEixGautz0c8f2/JdqWXCNnLgHhX6wgQkpMGpuA5yLUTrIw7
         oPEV7X5xBlH9WgaS3eK/xznBstks+aipUH6nao//SLd3BVcEfohbBJgSrEPLIzyORlsX
         05QakOLFVW2pOGwG/bUvTcPDp63Tygf905laruxcV7caqlunBKbwhG+iRNYy8IMLMGNr
         kHdp3BokzdwlopV+qqMe5RtlBITPOyRGvoBeXSlv9nnK3XbaLDD6WiWkMgJf/qayODiQ
         yq4sQUPBOl99h1Q8QRJ/CrhPftSN7TbhVdO9CI6cKgstY5WiuLYEcLtB3GkroiP7nXlj
         jAHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686745609; x=1689337609;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3NY9mrsvwl5zfIPZArwnmdeb4vxo5oIHW0I0xAx9Ck0=;
        b=VGSTjA86IStamIf3nWmnSXT1kHCFGW4HiPrPOqKxIBRRdL5KIaUGdY0ePWobVy+kcP
         npIOkoYsC3wX55WmtDisjtnpQOAGguhVrNFi2fLuEu7AkKnKPE4L4tWIqmFljBM05TEW
         CMfRQkYqsYXdqSz8+HE0/AnQJ5mPfURaECPnS3vjiNdKMLmDWpyFwXvNoKAlVI6REUOd
         ThlEr4sfDw9jRZeOXT/GyXKRK0gdiRGCgWKX1So4G9LvvTaOqwkIX3NnGOtDDPZDpQUN
         63wHyKOSz+CFbrH0rY0NbKSdKYze0B1WCpQyFHcH+GsfE4At5e+HRJhuvl0x7OL6Vogz
         vm0A==
X-Gm-Message-State: AC+VfDwpDsZvcXZN30l2xo0q8JqLXIGVxsxywQvyYEszb6AUGSfX6+US
        buzM/Gre7gdkSQhGMTALsIfvjw==
X-Google-Smtp-Source: ACHHUZ7YiVU59J82kIVqUIDiGCftqnZauiZ656NME9ImNlEZvFoMqyQVXlPTJmpffwvWI8abBIDZdw==
X-Received: by 2002:a7b:c8ce:0:b0:3f7:c92:57a0 with SMTP id f14-20020a7bc8ce000000b003f70c9257a0mr1308539wml.14.1686745609096;
        Wed, 14 Jun 2023 05:26:49 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id w15-20020a5d404f000000b0030fcf3d75c4sm4138103wrp.45.2023.06.14.05.26.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jun 2023 05:26:48 -0700 (PDT)
Message-ID: <70943e3b-8f6f-0b81-7272-03f19633d858@linaro.org>
Date:   Wed, 14 Jun 2023 13:26:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 4/8] arm64: dts: qcom: msm8939-sony-tulip: Allow disabling
 pm8916_l6
Content-Language: en-US
To:     Stephan Gerhold <stephan@gerhold.net>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230530-msm8939-regulators-v1-0-a3c3ac833567@gerhold.net>
 <20230530-msm8939-regulators-v1-4-a3c3ac833567@gerhold.net>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20230530-msm8939-regulators-v1-4-a3c3ac833567@gerhold.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/06/2023 08:16, Stephan Gerhold wrote:
> The vendor kernel from Sony does not have regulator-always-on for
> pm8916_l6, so we should be able to disable it when setting up the
> display properly. Since sony-tulip does not have display set up
> currently it should be fine to let the regulator disable until then.
> 
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> ---
>   arch/arm64/boot/dts/qcom/msm8939-sony-xperia-kanuti-tulip.dts | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8939-sony-xperia-kanuti-tulip.dts b/arch/arm64/boot/dts/qcom/msm8939-sony-xperia-kanuti-tulip.dts
> index dc5b8cd5b9f4..509abcdad287 100644
> --- a/arch/arm64/boot/dts/qcom/msm8939-sony-xperia-kanuti-tulip.dts
> +++ b/arch/arm64/boot/dts/qcom/msm8939-sony-xperia-kanuti-tulip.dts
> @@ -91,7 +91,6 @@ pm8916_l5: l5 {
>   	pm8916_l6: l6 {
>   		regulator-min-microvolt = <1800000>;
>   		regulator-max-microvolt = <1800000>;
> -		regulator-always-on;
>   	};
>   
>   	pm8916_l7: l7 {
> 

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
