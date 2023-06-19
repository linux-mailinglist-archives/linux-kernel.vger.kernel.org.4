Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58D7573585C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 15:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbjFSNTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 09:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231629AbjFSNTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 09:19:06 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74971170A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 06:18:29 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4f86d8a8fd4so1724181e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 06:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687180708; x=1689772708;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fT620nxcybg/D2DY8ZSDWUhANkXuBn86NN02DgIKkvQ=;
        b=icHjr1791Dbit1rX1FfMJQpQ8Q+ZH9ZuiwD+b7ZfbiNfvCFB/ARDWZQnvDBF/FzasB
         qT1Y8FVPF1bPEQyC8YFUwzfw0fIp+QyhJFo52DL6EWiPjiXOtK9mJFgnGHkqcWvyNkWy
         6J42S5nUBMmfQq3OoMCJG9Mm/PhDWy42HAGmiv1d/7WGxHALm4tJsbRV+gB/1snSZ0Dg
         P3XFbIIGiM74JSBX9Y22aht4JAHlF5fAsES4bRg4rFS6+z/H7fcoEACQbTxz5ZLCrQQf
         QdWoPJC3BSED5tROL4XhtXIESoOGeAr+yelTlpDYQth8MFivYQnU83qneMam59rifTPM
         iLHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687180708; x=1689772708;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fT620nxcybg/D2DY8ZSDWUhANkXuBn86NN02DgIKkvQ=;
        b=kB29MOino5p5yaqHzFzAwp7MYrt+zoPMgzODDFaIiplIg7Y54loddej7fqDTVf4KDi
         HgdbB8+J90scmDE6FK8Mp+b09WTDtGGB9IyCGqp/ulzAWR5VV+epS9VrTC7INDAjQH0x
         2Z6MHoaKb/0QDXoqdN910XefgHqI+D4tEVnlZSXJB4E7roFW/RZPyME5wCzjVGN2ZhPC
         WUsl241KIX8ojJPvQqmSsv6Z5uoJ4jUPBJ9EOAE0kDLVy5Pym02shqA5Hm8sRP3rHq+k
         7z+t94a1QM1x783ZXATYwj8yLnki3A3x+Nw0RXz/FbCFpaKvOEA7mCaCwpRYuFGymV6M
         A/dA==
X-Gm-Message-State: AC+VfDyev5NHygnpECt7uXz26xjveJqG/4aNN10F3aU6YZXgVaKCHWI1
        4VH/Ty5BVS0E/Co1OgTCd+uNzw==
X-Google-Smtp-Source: ACHHUZ5xfP1FcCkd/yiql4ahEvM4xwJ9ACCQnpkLhOHClCRNOeEI38LLRvyFwSv+vWo8cYssi7Khyg==
X-Received: by 2002:a05:6512:555:b0:4f8:75d5:8af8 with SMTP id h21-20020a056512055500b004f875d58af8mr695714lfl.4.1687180707632;
        Mon, 19 Jun 2023 06:18:27 -0700 (PDT)
Received: from [192.168.1.101] (abyl242.neoplus.adsl.tpnet.pl. [83.9.31.242])
        by smtp.gmail.com with ESMTPSA id w17-20020a056512099100b004f864434c00sm1049981lft.171.2023.06.19.06.18.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jun 2023 06:18:27 -0700 (PDT)
Message-ID: <54a989e2-b8cb-43c4-f4d5-86e129d1949a@linaro.org>
Date:   Mon, 19 Jun 2023 15:18:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/2] arm64: dts: qcom: apq8039-t2: remove superfluous
 "input-enable"
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230617112115.130024-1-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230617112115.130024-1-krzysztof.kozlowski@linaro.org>
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

On 17.06.2023 13:21, Krzysztof Kozlowski wrote:
> Pin configuration property "input-enable" was used with the intention to
> disable the output, but this is done by default by Linux drivers.  Since
> commit c4a48b0df8bf ("dt-bindings: pinctrl: qcom: tlmm should use
> output-disable, not input-enable") the property is not accepted anymore.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/apq8039-t2.dts | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/apq8039-t2.dts b/arch/arm64/boot/dts/qcom/apq8039-t2.dts
> index 40644c242fb7..43686bbd87f4 100644
> --- a/arch/arm64/boot/dts/qcom/apq8039-t2.dts
> +++ b/arch/arm64/boot/dts/qcom/apq8039-t2.dts
> @@ -366,7 +366,6 @@ typec_irq: typec-irq-state {
>  		function = "gpio";
>  		pins = "gpio107";
>  		bias-pull-up;
> -		input-enable;
>  	};
>  };
>  
