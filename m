Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5630D64C71E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 11:31:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237906AbiLNKbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 05:31:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237878AbiLNKbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 05:31:39 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E9720BD3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 02:31:37 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id v11so6189863ljk.12
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 02:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=El9/7ifi8O+Hz4glsuL6bqzvFzAy2OEtSXzBNpeIHsk=;
        b=abKZhRwBMNORACyyZGYHCzGwqAY1dHPJDSnBagPflABjCWBL9Xe6DxA+XTH4sF1AoG
         cI2xtleH8gJ0M+P2f2kP1HMCBWUGz84Ruj4zc5YSaxlzL9XGUGD/j/CGxnkd36y3/Zxy
         Zaq5YyMniXNwOKlHYsvJA3RH29DtKt7TpZS+Fo0sFNMoqL7sA8mJsY1OgGMWCHoEqXIb
         4sgYBLlz8mSuxJQqPU8oETjE/DdUlJoNBIXS9hKWzw+SRn4VDv+AkR/VxYyDHDQj5vX5
         r+TgyV6N/e+7udUPbal2Urw6lpBVV9SKT6zCCRfG8aaEqQKNu/WPiKSKoioOkeEkCHK/
         95hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=El9/7ifi8O+Hz4glsuL6bqzvFzAy2OEtSXzBNpeIHsk=;
        b=2x4tZkyvRw5+cdoUYV75K8z8xbdoL06N5TlVoE2/o9hNZ/HeKShNkvZh4eTzoTcCPc
         QcAgHNnQsqkig+ewsJHvH8ZkmhXVhUPFOny6uIPBpDN79xL4/uoQJfvbBFB4xZr/wokK
         4WJD236PpGa/SqcY+zu9BrDGdcjt9IcLTxwbe3BFRojfW23uJzwKaKyyDbGL7xjR6oHm
         jV4k6KKDVk+bBO3CvWd55ZwonKi3l9MIQHFD/jwxcKivGLS4x9tQr8bDZGwFS8DFd0QK
         NfhxEyfsq9rzSqB5dBi7RQKvXTCcg6jJyfGX8RxUCMKJffBJMgZb5vkEJtPrvhV32XgX
         tvyA==
X-Gm-Message-State: ANoB5plF7ehYaqBwEPDA6y1tTeqmioxF7aUvXo1TvkQQcQOhmuud2wVp
        cfMaRIYGikvBnBImzdX8O6sRzg==
X-Google-Smtp-Source: AA0mqf79fSzvtWEz4zFvsacTgnHGgwwi5oyFdTQ/LV9ocjYJdhjLUODvN0JF0Y9hIngMVmut6eGalQ==
X-Received: by 2002:a2e:bd05:0:b0:278:eef5:8d1a with SMTP id n5-20020a2ebd05000000b00278eef58d1amr8100534ljq.24.1671013895286;
        Wed, 14 Dec 2022 02:31:35 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id p13-20020a2eb98d000000b0027a02d2d4ecsm574058ljp.24.2022.12.14.02.31.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Dec 2022 02:31:34 -0800 (PST)
Message-ID: <149db463-bc54-7a12-eb95-eeef5be137ba@linaro.org>
Date:   Wed, 14 Dec 2022 11:31:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 1/2] dt-bindings: reserved-memory: rmtfs: Document
 qcom,assign-to-nav
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     marijn.suijten@somainline.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221213170340.456252-1-konrad.dybcio@linaro.org>
 <e79ae240-95ce-1629-70f3-378d98f38841@linaro.org>
 <005d073c-a937-5ef8-a97b-09bc17d6f354@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <005d073c-a937-5ef8-a97b-09bc17d6f354@linaro.org>
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

On 14/12/2022 10:55, Konrad Dybcio wrote:
> 
> 
> On 14.12.2022 09:11, Krzysztof Kozlowski wrote:
>> On 13/12/2022 18:03, Konrad Dybcio wrote:
>>> Some SoCs mandate that the RMTFS is also assigned to the NAV VM, while
>>> others really don't want that. Since it has to be conditional, add a
>>> bool property to toggle this behavior.
>>>
>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>> ---
>>>  .../devicetree/bindings/reserved-memory/qcom,rmtfs-mem.yaml  | 5 +++++
>>>  1 file changed, 5 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/reserved-memory/qcom,rmtfs-mem.yaml b/Documentation/devicetree/bindings/reserved-memory/qcom,rmtfs-mem.yaml
>>> index 2998f1c8f0db..1d8c4621178a 100644
>>> --- a/Documentation/devicetree/bindings/reserved-memory/qcom,rmtfs-mem.yaml
>>> +++ b/Documentation/devicetree/bindings/reserved-memory/qcom,rmtfs-mem.yaml
>>> @@ -31,6 +31,11 @@ properties:
>>>      description: >
>>>        vmid of the remote processor, to set up memory protection
>>>  
>>> +  qcom,assign-to-nav:
>>> +    type: boolean
>>> +    description: >
>>
>> No need for '>'
>>
>>> +      whether to also assign the region to the NAV VM
>>
>> Here and in property name you express desired Linux driver action, but
>> it is better to express the property of the hardware. What is
>> different/special in these SoCs or their configuration that additional
>> assignment is needed?
> Honestly, I have no clue.. probably there's something more complex
> than was there before connected to GPS..

One thing could be number of VMs - if it is even something known.

Best regards,
Krzysztof

