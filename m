Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EECDB640500
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 11:45:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233016AbiLBKpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 05:45:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232917AbiLBKpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 05:45:00 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A089060B64
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 02:44:58 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id b3so6799230lfv.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 02:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g6zxPDSTjg1DFl2wCGVSiXLCEZRvZ4uYKfSzwxBPZ7Y=;
        b=hTllzCZnIWReN45CdtlN9izfIGriquhF2fvMXWAX95N2CEufn2h0revuuhP283Yzm0
         Ir5LqoQIag2dEGbkIgs0TOW5N5aPd83Z/xCKsBRPok3qIB6BbhjHL2Q1b+ikMFqezA7D
         TB2N5AIAXoVKJVhA7F+SuGjw3Gsxhk4WlQndEfWLF03a3DoAzJOneb9n20fb3rI7Aib5
         JAdKWz5LYSNUKUIBGSe7MKjsG/T39O4uzjcHFORTUSKBW18RJf0pcp/Vxj5UgKYv+DKi
         rRQMEbn1oeEgx7bDzG7P8/2cWyrRROLfr4nRtCiiYLqZuvPLFo3BUtEn0U7xAbC9dgCP
         yUzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g6zxPDSTjg1DFl2wCGVSiXLCEZRvZ4uYKfSzwxBPZ7Y=;
        b=oBdDw+QowgjW3aYqREyuZ9pLadz5WGog51VTEeeexiJYFey2zlyoPYjCobuZj5CrLU
         VgqtGtlWOaCpABhMTnc8EV1pmIMCx+4VukloQPtT21bzp3djupaSJjaUh722Hlr7xfSH
         joP8UqpV1PakE5BYXqTDbwoZvUudCNtDEZgAiMYeFgksYXSqbGZh73qCWHcEfD6dhC6P
         8MDl5CJ0UP0vdR3M7+h8WVBMHrnIcD+d6nqDwIcfKypk2eocgPi5wjaJi+/GEU7l5zhm
         e0dB6ZqwJkfufwVa9bvZCCwrlzl9YVNe0MxjOp3nJ1WaYjDH1pq/8V4vuVwur+4W2kF8
         3FPQ==
X-Gm-Message-State: ANoB5pnWG32MKcUoVyecbv+HovycK6PEUFLdYAnawRyrsxUcQUctTtZU
        tDEADW1zSxLgOsQH1pkzrMB9Yw==
X-Google-Smtp-Source: AA0mqf7E7XTvFGo37Mzgoj/Dq76JprZ8qaXYv8xDBz7wwPg4PWn6n4dzH+ZmPdOnqVyhJQMCQy/XmQ==
X-Received: by 2002:a05:6512:ea8:b0:4b4:f6f4:df2b with SMTP id bi40-20020a0565120ea800b004b4f6f4df2bmr14973823lfb.321.1669977897025;
        Fri, 02 Dec 2022 02:44:57 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id t11-20020ac24c0b000000b004afeacffb84sm979853lfq.98.2022.12.02.02.44.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Dec 2022 02:44:56 -0800 (PST)
Message-ID: <7015b64a-e73c-87aa-4e1f-a0034638c6ec@linaro.org>
Date:   Fri, 2 Dec 2022 11:44:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 2/5] dt-bindings: remoteproc: qcom: adsp: document
 sm8550 adsp, cdsp & mpss compatible
Content-Language: en-US
To:     neil.armstrong@linaro.org, Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Andy Gross <agross@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>,
        linux-remoteproc@vger.kernel.org
References: <20221114-narmstrong-sm8550-upstream-remoteproc-v2-0-12bc22255474@linaro.org>
 <20221114-narmstrong-sm8550-upstream-remoteproc-v2-2-12bc22255474@linaro.org>
 <8d7367b2-126a-d8ba-b616-be1ef9c67122@linaro.org>
 <ace35de2-9aa8-8cfa-1f4c-46480fbbc442@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ace35de2-9aa8-8cfa-1f4c-46480fbbc442@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/12/2022 11:33, Neil Armstrong wrote:
>>> +
>>> +  - if:
>>> +      properties:
>>> +        compatible:
>>> +          enum:
>>> +            - qcom,sm8550-cdsp-pas
>>> +    then:
>>> +      properties:
>>> +        power-domains:
>>> +          items:
>>> +            - description: CX power domain
>>> +            - description: MXC power domain
>>> +        power-domain-names:
>>> +          items:
>>> +            - const: cx
>>> +            - const: mxc
>>> +  - if:
>>> +      properties:
>>> +        compatible:
>>> +          contains:
>>> +            enum:
>>> +              - qcom,sm8550-cdsp-pas
>>
>> This entire if does not look valid - compatible is covered in the
>> previous one. You should see `dtbs_check` warnings on your DTS.
> 
> Wow indeed, this should be mpss-pas...

Then also drop "contains" to match other places (and other files).

> 
> The main changes here was firmware-name and memory-region to handle
> the dtb firmware and the DSM memory region, are those OK ?
> 

Yes.

Best regards,
Krzysztof

