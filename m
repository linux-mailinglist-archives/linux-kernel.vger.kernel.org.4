Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDC155BF607
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 08:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbiIUGA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 02:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiIUGAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 02:00:55 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D60785AC5E
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 23:00:53 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id q9-20020a17090a178900b0020265d92ae3so13101093pja.5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 23:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=KTDGCxw9K/m0IE28tp7il5a/gdZmEgkpTgtAKS0w1hU=;
        b=zavTnr75v0R2Jmu8cIoC0kmMrrhsQQvbhW76Hf66/C/jT2G1mWEnnpJ839PsBq9ELp
         WFiSsmkvt/IRYSgzyhQZrWfyWDBFRYEclPg69lfizcQH8FTm6mcKCIY3RVp9ovgBAZqn
         FneLIZUucl1wT2e1UotyqMwmUJIsNdx9CU548SnPmQfYWrYCsRqzXlQlcF/r7DEd5vkh
         P++dGV1h5bDlep/rHlOeYtQc7prD+FFwcLltzSbrZL2ebtvx32c7hQVjVlxQtGgYB3sA
         fSzp8HAmHl0ezYQJtWqGLgk8IDLleBqVMVq04kaXPjLNGp5rPrbCfGRA+8rjboJj02oM
         UqFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=KTDGCxw9K/m0IE28tp7il5a/gdZmEgkpTgtAKS0w1hU=;
        b=h4WmPeWOHA5wClOJxLOM8Bqi+aw/FuDz42TsXemVOZNjZcwcwAppM4zQaeihcTToF/
         yTZsFGBgdxEoLTULd4FBhl0cXTBXfA5Ug+kzAW74T3xKnRLHRLirUNhkw/sQiaZFh3hY
         pYqiS7IUKvFxmcZq0IocTJdrlYeha0CFrachLu9U28F1MIjmKavvQyqBBnL2IKyFDiTV
         WJTGPh6wex0pt42yrwQuKRVMnQcbkS3lTlDjBlwO2/CdGMbK1py9MzJCNHY1dUJin+r0
         Ho8Z3N1yyw3R2R3DrfK3szzxp20tf81a1XqGx/2bYFEQA6BVMC8CYrovc1d6ea4/vedq
         jNBA==
X-Gm-Message-State: ACrzQf29LXfPOEVa95tgiF5/r2har4quFV+80xkqorCGXrC1BXS1G2SX
        LB7tiRM5dnnczyVJZbr/i/7nBw==
X-Google-Smtp-Source: AMsMyM48UUe5Twj+PpfUDK1ckCFUCCN/BxyPPQt5HtY9M4iS4sCaXZhdfbYcbPvZflpt/9ByE6wOgA==
X-Received: by 2002:a17:902:f394:b0:176:b7b7:2 with SMTP id f20-20020a170902f39400b00176b7b70002mr3132765ple.57.1663740053290;
        Tue, 20 Sep 2022 23:00:53 -0700 (PDT)
Received: from ?IPV6:2401:4900:1c61:8e50:8ba8:7ad7:f34c:2f5? ([2401:4900:1c61:8e50:8ba8:7ad7:f34c:2f5])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902c21500b00177efb56475sm998181pll.85.2022.09.20.23.00.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 23:00:52 -0700 (PDT)
Message-ID: <05a1447e-51b1-cd6b-36bc-98f011e786e0@linaro.org>
Date:   Wed, 21 Sep 2022 11:30:46 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v7 4/9] dt-bindings: qcom-qce: Add new SoC compatible
 strings for qcom-qce
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org
Cc:     agross@kernel.org, herbert@gondor.apana.org.au,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, thara.gopinath@gmail.com,
        robh@kernel.org, andersson@kernel.org, bhupesh.linux@gmail.com,
        davem@davemloft.net, Jordan Crouse <jorcrous@amazon.com>
References: <20220920114051.1116441-1-bhupesh.sharma@linaro.org>
 <20220920114051.1116441-5-bhupesh.sharma@linaro.org>
 <0a6b443c-33b4-5fc7-5a2f-e55f5387999f@linaro.org>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
In-Reply-To: <0a6b443c-33b4-5fc7-5a2f-e55f5387999f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/20/22 8:40 PM, Krzysztof Kozlowski wrote:
> On 20/09/2022 13:40, Bhupesh Sharma wrote:
>> Newer Qualcomm chips support newer versions of the qce crypto IP, so add
>> soc specific compatible strings for qcom-qce instead of using crypto
>> IP version specific ones.
>>
>> Keep the old strings for backward-compatibility, but mark them as
>> deprecated.
>>
>> Cc: Bjorn Andersson <andersson@kernel.org>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>> Tested-by: Jordan Crouse <jorcrous@amazon.com>
>> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
>> ---
>>   .../devicetree/bindings/crypto/qcom-qce.yaml         | 12 ++++++++++--
>>   1 file changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/crypto/qcom-qce.yaml b/Documentation/devicetree/bindings/crypto/qcom-qce.yaml
>> index 4e00e7925fed..aa2f676f5382 100644
>> --- a/Documentation/devicetree/bindings/crypto/qcom-qce.yaml
>> +++ b/Documentation/devicetree/bindings/crypto/qcom-qce.yaml
>> @@ -15,7 +15,15 @@ description:
>>   
>>   properties:
>>     compatible:
>> -    const: qcom,crypto-v5.1
>> +    enum:
>> +      - qcom,crypto-v5.1 # Deprecated. Kept only for backward compatibility
> 
> No changes since v6.

Right. v7 is just to propose the new subset of patchsets and ordering 
(since we changed it from v5 - which was a single patchset) and get some 
early feedback and comments and get to know if the respective 
maintainers are fine with the patch ordering, cc-list etc.

I will surely include your comments in v8.

Thanks,
Bhupesh
