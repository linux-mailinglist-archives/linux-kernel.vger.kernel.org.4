Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77A03723CE7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 11:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236427AbjFFJRg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 05:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236178AbjFFJRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 05:17:16 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C758D10F1
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 02:17:04 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9745ba45cd1so731989166b.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 02:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686043023; x=1688635023;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WFZO1quiYCb7WK7FGJd2k62/gfvxHreHYp1ujyVcgQE=;
        b=YI0x4LbkmazNjw9SPHR89qxvIBqKi+rZQM2uGk0dQ2QkSg17hxKx9pO3DDbhwse1th
         qLjZSeAtWLki/tTjyWSkemYjyXXNrhfa6xnCifIKWNPMtUn8ni7fmv4owW0b70Ndu9zj
         a6a0A4sInpNznlHuzIYI00Mls+GuEGSVYqcJbnl9Nbys5CktNl49x/GIi4ey+IvbrC8t
         gV8z1YB1TZAFZ/qop2kQolfl8pE2HI7nLIEvpd3Z4O5pJHiZBW+9hUGZD41lJ1d7xy7V
         0iTIgudvlsGTLeFLlGrHWVNBkL0JTOOI2xwPrv6bntw9BEcbB5Z/fj4DokQIFPJMp/35
         oTgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686043023; x=1688635023;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WFZO1quiYCb7WK7FGJd2k62/gfvxHreHYp1ujyVcgQE=;
        b=PFH3obOpSZVGnkH4gI5ivAMvH2Fuob31lRFtJy4RkwBWdI5Q7SAmtkeae++0rIBz4i
         XwBcDQFs5X2NfJRZVfGFSuuZX2VsqREvM/VCJ03ywEU/dG2qfIo+3I+wHFAnk/gj/Yu7
         KR3c2SXQJXfIJeznJDrM1I3vGpPGlUt0O4w3Cd/Q8xqfQ7ORLTXfZyE0Z8ggCyuXkFKC
         eBK/6+g54qSHmzvX4xMMoDEgD6VQN4DJ2l6dcKPT2Y6mle3Qgo0Efx0PlcnsBwZ0862Q
         R7s+ou31o2/HJSCEFCLOYsol7qkGq93CGNZ0cr6oRJecl9UGU7qx7ePGDAjrPq50aEkv
         831Q==
X-Gm-Message-State: AC+VfDz0cVqLj0iISyPoLrXxT525BxR6/lZ9PU9ko/J8Rk5GKYIMLPW2
        nSO0gzAlksozQx6xEyyil289xg==
X-Google-Smtp-Source: ACHHUZ4PAeDI8t67bUJhdaqBmTvjv2z7fbXLke2PqprP5R52QQZ3TpwVeTM5xT7yvCcvZsEeW6ORAg==
X-Received: by 2002:a17:907:3ea9:b0:973:7dfc:f052 with SMTP id hs41-20020a1709073ea900b009737dfcf052mr1649432ejc.30.1686043022772;
        Tue, 06 Jun 2023 02:17:02 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id l12-20020a170906a40c00b00971433ed5fesm5214639ejz.184.2023.06.06.02.17.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 02:17:02 -0700 (PDT)
Message-ID: <30c702b2-18c6-ed38-ce7e-6f098a38d3c3@linaro.org>
Date:   Tue, 6 Jun 2023 11:17:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 06/14] dt-bindings: soc: qcom: smd-rpm: Use qcom,rpm-proc
 in example
Content-Language: en-US
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org
References: <20230531-rpm-rproc-v1-0-e0a3b6de1f14@gerhold.net>
 <20230531-rpm-rproc-v1-6-e0a3b6de1f14@gerhold.net>
 <d0fa3b01-edab-fe8e-c309-036cbbcec7ab@linaro.org>
 <ZH73JxLd1i1vUcyw@gerhold.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ZH73JxLd1i1vUcyw@gerhold.net>
Content-Type: text/plain; charset=UTF-8
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

On 06/06/2023 11:06, Stephan Gerhold wrote:
> On Tue, Jun 06, 2023 at 08:37:04AM +0200, Krzysztof Kozlowski wrote:
>> On 05/06/2023 09:08, Stephan Gerhold wrote:
>>> Use the new top-level rpm-proc node instead of having a dummy top-level
>>> /smd node that only contains the RPM but not other remote processors.
>>>
>>> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
>>> ---
>>>  Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml | 6 +++---
>>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml
>>> index c6930706bfa9..06e574239bd4 100644
>>> --- a/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml
>>> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml
>>> @@ -120,10 +120,10 @@ examples:
>>> [...]
>>> +        compatible = "qcom,msm8916-rpm-proc", "qcom,rpm-proc";
>>>  
>>> -        rpm {
>>> +        smd-edge {
>>
>> What about binding updates?
>>
> 
> The binding for this is in PATCH 05/14. The old binding replaced here is
> deprecated in PATCH 07/14.

So changing example without changing binding is not an atomic change.

Best regards,
Krzysztof

