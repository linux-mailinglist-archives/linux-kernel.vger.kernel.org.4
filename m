Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5108E6F5BE7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 18:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjECQZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 12:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjECQZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 12:25:05 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A445272
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 09:25:01 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-50bd37ca954so8563043a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 09:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683131100; x=1685723100;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ze0Jut8Jaw/ifknxqzKnyodBsn/9QHtRL/qVVYq1llw=;
        b=gz/b3Y3bnJRGNrunc5pvQ52kNHqDIXCDEt4x4jhB8mASaiBP7eBrSifq20QrXloxgD
         Li4IrdSsWj6ezR+oguVZMmdxW0P0+tN3zyOOy52LIIkeMNMMNu4696nKi2Ja81xapDAv
         iT1n4aJKv0PpeVaO3HbD8KRwVX1XQOChLXugETqEqhnOfifjg/1Ry5T1OqdOxwb34tUZ
         nAWcVntJ7M0CARs7uAFvZyejjKh2pqUO/vUveWuD5VSDRqFB+phI1ToRAdMInwymNhIR
         eHNPKGU7FOHJNktIfMGCyqkaavg5vCsUiRm4WSkYDk3uCvkuQIg42zSU2gHLaAwrQTJB
         pvig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683131100; x=1685723100;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ze0Jut8Jaw/ifknxqzKnyodBsn/9QHtRL/qVVYq1llw=;
        b=STEUTylzbreTPMOJfljQxdW2VMajjWl9GbWxGJwnHASa1K3+xCeLG3JWyHoxeKcZ9R
         jbbs38sZMttfBNQ3aczK7prGgOZ8YDkOTVyYbmWAWqtKYwLykIPHGE7ii4S00v9VnI74
         esXJ+doAWlXXm3CMablORs2DoYHHjZP+s0K68Of6mzW2o14KqjNnua/mAsyXqtLNc4BR
         pk981zSHoFObzQntpGOBy9uHHDRVT9qxq5Nzp50yNmEdq01lEK6BakTqHU8pj4c9wrz7
         YxwjZWnff/nN+pEq5OIsytdasieOmiX7FJV8hTPrmHIFG3gpP5fnUniO6iDg8ZpwrDeX
         ptDA==
X-Gm-Message-State: AC+VfDwRKQvzE6uGUdRI6b03DvXN7/Dir5p+SJeGpVgDZivTGQD5bGto
        nst4osaEXuA0MzNREbDlay+48g==
X-Google-Smtp-Source: ACHHUZ6Ep0HhQcksbydX/7YXvwqa1Tty4Z/q8q7c2xvPyK6lt1j7GimAB71oBrZSotEDHVh5AIKLCQ==
X-Received: by 2002:a17:907:9308:b0:94e:bf3e:638 with SMTP id bu8-20020a170907930800b0094ebf3e0638mr1939840ejc.11.1683131100188;
        Wed, 03 May 2023 09:25:00 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:db42:e3d0:c55a:8cf1? ([2a02:810d:15c0:828:db42:e3d0:c55a:8cf1])
        by smtp.gmail.com with ESMTPSA id sb10-20020a1709076d8a00b00958079b676asm14837366ejc.122.2023.05.03.09.24.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 May 2023 09:24:59 -0700 (PDT)
Message-ID: <faefbbed-0f62-e569-455d-0d21b363f8f3@linaro.org>
Date:   Wed, 3 May 2023 18:24:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v10 1/4] dt-bindings: phy: qcom,qmp-usb: Drop legacy
 bindings and move to newer one (SM6115 & QCM2290)
Content-Language: en-US
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-phy@lists.infradead.org
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        andersson@kernel.org, bhupesh.linux@gmail.com, robh+dt@kernel.org,
        konrad.dybcio@linaro.org, kishon@kernel.org, vkoul@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dmitry.baryshkov@linaro.org
References: <20230502053534.1240553-1-bhupesh.sharma@linaro.org>
 <20230502053534.1240553-2-bhupesh.sharma@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230502053534.1240553-2-bhupesh.sharma@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/05/2023 07:35, Bhupesh Sharma wrote:
> 'qcom,msm8996-qmp-usb3-phy.yaml' defines bindings for several PHYs
> which predate USB -> USB+DP migration. Since SM6115 and QCM2290
> nodes for USB QMP phy are being added to dtsi files by followup patches,
> move these bindings instead to the newer style
> 'qcom,sc8280xp-qmp-usb3-uni-phy.yaml' file.
> 


>    clock-names:
> -    items:
> -      - const: aux
> -      - const: ref
> -      - const: com_aux
> -      - const: pipe
> +    maxItems: 4
>  
>    power-domains:
>      maxItems: 1
> @@ -71,6 +69,42 @@ required:
>  
>  additionalProperties: false
>  
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,qcm2290-qmp-usb3-phy
> +              - qcom,sm6115-qmp-usb3-phy
> +    then:
> +      properties:
> +        clocks:
> +          maxItems: 4
> +        clock-names:
> +          items:
> +            - const: cfg_ahb
> +            - const: ref
> +            - const: com_aux
> +            - const: pipe

I am pretty sure I acked it and there were no changes here... but since
you did not include it, then lets keep the clock order the same as
sc8280xp. ABI is anyway affected, right?

Best regards,
Krzysztof

