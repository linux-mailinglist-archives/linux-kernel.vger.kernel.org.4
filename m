Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77AF063252A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 15:11:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbiKUOLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 09:11:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiKUOKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 09:10:41 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C168BC4C20
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 06:07:04 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id b3so19007084lfv.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 06:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P4Uz366QBeSMJqeZ812r8+RCBhYDrKCWDMibOi8ys2w=;
        b=KuGBLkg2Gq7vHPlrPuzZYktiKWXobodrLyr382sZYcIX0Dbj/x3fhAv6uGy50CcdWZ
         b8c8R2THq5Eo/nW6/9EnZ42oi1TtSlJjsLvLJ2OBKo798mKrSs1rt2Oeux+pA7/W1IPp
         PDXCGtjFHpZd3yyGW1+6l6nKp32Eh3RQlk1+lH2jNPJa1amtrZncvP8K3wlU3+XXXqTf
         c4gqZWqlOslIcj9HD0w8bOJdvai4zg4feaaXbqJACHAqvWtLNWtTlzgjD9Ajn8uq2T+x
         rBaR51Wq5hsSTL6ORcuanPlg0GSLjUIrSzGcYbPXr7fR+umgUxiKzL2LrEInA/iZqfSW
         9ljQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P4Uz366QBeSMJqeZ812r8+RCBhYDrKCWDMibOi8ys2w=;
        b=7Ad0ZB4np2rooErNWxMYXMsoDVYkN5VpjyI9Z4MrDHAGXlo+cFsC8pIE2akt2XWGrT
         MA9AaSVmqCBLS0JrWY5h5ZvkczSqo05/9KqjVIvB5/USNFrjRy1J+TdoIEJPIWdmCkzK
         Rq+zjcO4B72gsVXozTJqDLRhnOdXfR1Y7aOWOidGmnXXssm/omJZxDNI+dCUqeqhexju
         oPu0sfZW1yz8SpcIyIM2mNB9e/YwwYTtJB0g2NnzhcbFocdDWRJGBw9slV+tdSQ64NZc
         IuDYv1dsWJ2k38m/vqWVlyAvWnk/VXARICE0WM/T8xa3AO2wUOw3KW0Q0hIErhhbu8Hb
         KgGw==
X-Gm-Message-State: ANoB5pmj3xdIxffqMxg6SxTSU0JuziKv2G59N/QPwqyODG3CTH8rqx3i
        C69Emei4odE9YprjxJWGBdk6Pg==
X-Google-Smtp-Source: AA0mqf5sj/Iq/c06XnmXaz9QcCZBHQG1a33xgVe7opdm2wSZ1VBouIq05fQF7MP9Mzgs2HwqHMdxuw==
X-Received: by 2002:a05:6512:203a:b0:4b4:9124:8aad with SMTP id s26-20020a056512203a00b004b491248aadmr5730005lfs.285.1669039623027;
        Mon, 21 Nov 2022 06:07:03 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id br32-20020a056512402000b0049aa20af00fsm2050564lfb.21.2022.11.21.06.07.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 06:07:02 -0800 (PST)
Message-ID: <10405a49-7738-ab65-8816-e259be043b1e@linaro.org>
Date:   Mon, 21 Nov 2022 15:07:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3 1/3] arm64: dts: qcom: sc8280xp/sa8540p: add gpr node
Content-Language: en-US
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        agross@kernel.org, andersson@kernel.org
Cc:     konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221121130403.161817-1-srinivas.kandagatla@linaro.org>
 <20221121130403.161817-2-srinivas.kandagatla@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221121130403.161817-2-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/11/2022 14:04, Srinivas Kandagatla wrote:
> Add GPR node along with APM(Audio Process Manager) and PRM(Proxy
> resource Manager) audio services.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 39 ++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> index be72b1f7ad61..65b657f73ebb 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> @@ -11,6 +11,7 @@
>  #include <dt-bindings/mailbox/qcom-ipcc.h>
>  #include <dt-bindings/power/qcom-rpmpd.h>
>  #include <dt-bindings/soc/qcom,rpmh-rsc.h>
> +#include <dt-bindings/soc/qcom,gpr.h>

The order is still not alphabetical. This before
dt-bindings/soc/qcom,rpmh-rsc.


Best regards,
Krzysztof

