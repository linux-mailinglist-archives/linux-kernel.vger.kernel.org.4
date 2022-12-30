Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35FE8659E79
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 00:41:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235588AbiL3XlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 18:41:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235567AbiL3XlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 18:41:09 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF535120AF
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 15:41:04 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id bn6so13478562ljb.13
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 15:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zPnKBnQYDe91n3qzykPwxYPbik46clNWIIiDLmpM+LM=;
        b=Xa/Fqx0NvUxpJgTPIvX4T0vNyb26l/p1LbaRpx79zHmFUTrotoFn+o/GP2/1/JAduT
         JCUXNu2z5WZS7KqEx3NGub8LArCpgQ7xUPJPEFz0Hjao3hhPH9ba6VXgZrc3SVJ3KjLN
         ionaedx4yrjZ2QsGoYNI59Y8/hngQAJS3ql9VXT1ObXQ0N3qLKO7KFLFCY484xuGjm9D
         baIer4aQ9jYHKCkjbkA8+8ScvPOmZiUPTn+ZdyEH/Dlap71vU0JqsvAVRaSFAZqrWVXm
         xId9PD6TRSpCAUTIzSkcXguMGjk0+TT3/0coZG4OKJ6XmHQJDHApWhds3HOysLWjPybC
         e6pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zPnKBnQYDe91n3qzykPwxYPbik46clNWIIiDLmpM+LM=;
        b=2nVwbJMOAtNJ9hIsaJe4hXk7HgvlCmsvfx0AJUKwvmEsw0Q+zJNFClBHc/oVDiW0zA
         7CNyHNVbK/pS6YgOx9KZIBMRLwmkI1J7LV5UVaOlrTqwYmVdOyQGw2ZPwHA1nGfYAVm9
         9Wb9IGZvvH4g3vP/MHUx2KjraFvUquY2QuH80Ip7gtuqJZrC4SHKPZYEKOy/yugZf3k6
         VB0O/YCyurgDB8xFYZKAePS0HkAE8OWHPXezRmqgQFUqRqeVaHf0sPzfdB4MUoNvCGAT
         TGqxOwDh+nfb6H/o2oWsa6O063LbRGZuX/5FYjpamSDeZ01fkyWX0dlwyqsP74b5RnGd
         jMkw==
X-Gm-Message-State: AFqh2kr+VWXFbPR1GJbjzww6I/+O0LzKLisDaC8zu7T4gs54O4heeZAu
        RwO84Supy5EXalWQ5B73/9boj0VGf8EP37Wh
X-Google-Smtp-Source: AMrXdXtUJ0n2iB/3L4iWOK6t4N4W+Z7NlbgoxhBolpAqMyQlW2bTixiUoanC6jUUS+d9Rl8zpdtEgg==
X-Received: by 2002:a05:651c:1a22:b0:279:d144:9eb4 with SMTP id by34-20020a05651c1a2200b00279d1449eb4mr11961055ljb.12.1672443663155;
        Fri, 30 Dec 2022 15:41:03 -0800 (PST)
Received: from [192.168.1.101] (abyl184.neoplus.adsl.tpnet.pl. [83.9.31.184])
        by smtp.gmail.com with ESMTPSA id r18-20020a2e8e32000000b0027cf0ecab3fsm2812716ljk.138.2022.12.30.15.41.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Dec 2022 15:41:02 -0800 (PST)
Message-ID: <9bfe5409-3174-c3be-b0b9-55c5a857e834@linaro.org>
Date:   Sat, 31 Dec 2022 00:41:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 1/7] arm64: dts: qcom: sc8280xp: remove GCC from CX power
 domain
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221230160103.250996-1-krzysztof.kozlowski@linaro.org>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20221230160103.250996-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,TVD_SUBJ_WIPE_DEBT autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30.12.2022 17:00, Krzysztof Kozlowski wrote:
> Bindings do not allow power-domain property in GCC clock controller and
> documentation does not indicate that GCC is part of VDD_CX.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Maybe the bindings should be fixed? Maybe this was added as workaround?
> Anyway looking at documentation I do not see such relation, except
> downstream vdd_cx-supply (which is the same as in other SoCs and we do
> not represent it in upstream).
Some clocks scale with _CX, which is annotated on downstream with vdd-levels.
We take care of that by using opp tables in consumer drivers. Usually if
power-domains is added to a clock controller, it means that at least one of
the clocks needs the power domain to be on (which.. should be true for CX
if the ARM part runs anyway, no?), as for example VDD_MX/VDD_GFX may not be
on at boot and trying to enable such clocks would result in a big kaboom..

TL;DR: if nothing exploded, it's fine to remove it

Konrad
> ---
>  arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> index 1d1420c8720c..d14663c9f34c 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> @@ -799,7 +799,6 @@ gcc: clock-controller@100000 {
>  				 <&pcie4_phy>,
>  				 <0>,
>  				 <0>;
> -			power-domains = <&rpmhpd SC8280XP_CX>;
>  		};
>  
>  		ipcc: mailbox@408000 {
