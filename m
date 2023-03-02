Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADFE06A8600
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 17:17:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjCBQQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 11:16:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjCBQQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 11:16:55 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F135329D
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 08:16:53 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id v16so14261687wrn.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 08:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677773812;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :to:content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5HYjZpMpytZSGqDsP2K0KCRwhR+itCR/8/lFWesuhjo=;
        b=H7oc1ycRYvXIKKZhYMMqwsHf+0g+8ypaFk6dk8L5BQShyqbanuGVkSK7X2pcd1OgMu
         LoMDBDJr5ykK0DXXxaByjexZWLV3FhGEHajt9+gVqQp0r08o3yw9DysU+0LrRmHcoG/b
         FGKPZheIN/qjKt1uBthr/5wkcnzrW+1pE1lslRipqA9+AxMNNqsjpWpFktS8FbKGEuut
         +r/t1Q1iKlJzVA4Q3mG77VVnvaUhr/yt/CNRV/GI+0DYxhsERZPEBc8rd/+8s3djqVNc
         WhswMp7LjlqAs3A+En9SfpZ2OH3Ion3sgOq9NVPpmNiDroJEiekiPG2f+Z4P6BFNKcbY
         oisA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677773812;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :to:content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5HYjZpMpytZSGqDsP2K0KCRwhR+itCR/8/lFWesuhjo=;
        b=ImNNRfTa5Ciht0NEWSXvqctel0OZCJvs3c9x9aINTTdh2NbO6bOoKcz9Hann4dAvOG
         pDiKeZlMKlEJ3aCdlU6pOsBf2BhoORrJinDwzPYIqii0/ek3pdQkfKX9ewfKJgQ/U3oy
         K8uz8ygU0dhtRDOi3ivgMpRP9DQ2YSYye54HIsbU9NCHk22SL457yZEP3/SBOq/94ftc
         y2w0Ne8vIUruKblsbbuIwLK14rjeim/YvaceB8ZcradnctXRZH0iZJVSaZslQ1u3uIaw
         XW+kLdRrzflKY7xnFgI3RKFYdvN6FGWoyjYlN9iw/sECv9q2WDlkhnqpFjFL0mh9F4kQ
         F7fQ==
X-Gm-Message-State: AO0yUKXORbviQ02zd7oFmj26RpzQDjnx7Podub2Ha1o8JE+FSC4hVJUx
        FCWXTETGBwQLre2M5e5os67eHJEGFJ0stAruZnw=
X-Google-Smtp-Source: AK7set/OXYKwHtUzDjDTB14sUjIPRR5ax4v3gv1KunbFBF2UbUGo3zPLpddvJ30FI1tl/xvyYK6StQ==
X-Received: by 2002:a5d:404b:0:b0:2c7:420:5d52 with SMTP id w11-20020a5d404b000000b002c704205d52mr8232023wrp.62.1677773812032;
        Thu, 02 Mar 2023 08:16:52 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:217a:db24:fe27:6b35? ([2a01:e0a:982:cbb0:217a:db24:fe27:6b35])
        by smtp.gmail.com with ESMTPSA id a18-20020a5d53d2000000b002c70ce264bfsm16250852wrw.76.2023.03.02.08.16.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Mar 2023 08:16:51 -0800 (PST)
Message-ID: <3b6f866b-1d38-2605-df35-7a937e73a2fe@linaro.org>
Date:   Thu, 2 Mar 2023 17:16:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] arm64: dts: qcom: sm8550: fix LPASS pinctrl slew base
 address
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230302154724.856062-1-krzysztof.kozlowski@linaro.org>
From:   Neil Armstrong <neil.armstrong@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <20230302154724.856062-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/03/2023 16:47, Krzysztof Kozlowski wrote:
> The second LPASS pin controller IO address is supposed to be the MCC
> range which contains the slew rate registers.  The Linux driver then
> accesses slew rate register with hard-coded offset (0xa000).  However
> the DTS contained the address of slew rate register as the second IO
> address, thus any reads were effectively pass the memory space and lead
> to "Internal error: synchronous external aborts" when applying pin
> configuration.
> 
> Fixes: 6de7f9c34358 ("arm64: dts: qcom: sm8550: add GPR and LPASS pin controller")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Fix for current cycle - v6.3-rc1.
> ---
>   arch/arm64/boot/dts/qcom/sm8550.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> index 1dea055a6815..6296eb7adecd 100644
> --- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> @@ -2001,7 +2001,7 @@ IPCC_MPROC_SIGNAL_GLINK_QMP
>   		lpass_tlmm: pinctrl@6e80000 {
>   			compatible = "qcom,sm8550-lpass-lpi-pinctrl";
>   			reg = <0 0x06e80000 0 0x20000>,
> -			      <0 0x0725a000 0 0x10000>;
> +			      <0 0x07250000 0 0x10000>;
>   			gpio-controller;
>   			#gpio-cells = <2>;
>   			gpio-ranges = <&lpass_tlmm 0 0 23>;

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
