Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77BB1617C6F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 13:22:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbiKCMV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 08:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbiKCMVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 08:21:50 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70AB11084
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 05:21:48 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id f8so953742qkg.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 05:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P+5YUCvZqbd7CB2bQQ6MOe7ruJKblRITAjPMVct4pI8=;
        b=CO/f0A0UqCf3wCwPKnaBeTqdgR6dBumZAGDTOy0GPfBAk5+rSxhjYmofU5K1KyJHkp
         bQyvFZSpUmpU7EU32AtkXmOH+YUqkO0wCQVAXj6hRkJlUlGjZyI1U1Juy+GHmBg5ztKs
         CpFVbEqN3F0rO6soGDKfnafyjrgbVh7rwGF/DvRWV7EwaS87hgEqkKoZOEHbbntSFtvV
         wX9fFHnuskwD2YM3PQX53UFKeGDcnv7gCWFo2ApNWPKd/6DHJm7u8Tz2L+ff2M4zdIWQ
         8myc7gDWb3DMVbw62yk+cAxfoED7cJAZhrpKrLeoNIAoGIH9mQU9e7eoFWrdFGfi0Xb2
         62GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P+5YUCvZqbd7CB2bQQ6MOe7ruJKblRITAjPMVct4pI8=;
        b=QFo8ZF0VCGVaWzdLGqX4pGoGZmqarmcqPK//IMgLdRvm4SHZW2OYK3Zp2gIroJKgwh
         90FkEaI1/IvKLMzxSmMeuaXvyCYsl5qwT0ItCVIP6MzPD/oHjiHsVwbh+IwZmbkf9+yr
         LxpOQ7mdSkWM27YpjasxW8FZK65Fxbr7BwKNNSN+my+ZfluMPucrJotyT9UEjtAC48HY
         GIrG//O46IFjfiH4wraf9oLVq/OqGiD/Px/ncMQRlv8Dk9Yj/i9yJLgPiIPRZ1vSQYmm
         Z4s5hCze6CKoqge/SeZQ6riZolzdmvRp8Oiy950Q33ESJ0NHmZatXmGpEiAm3tdPj/Tm
         8sNw==
X-Gm-Message-State: ACrzQf09U0cv1j1OAW0Kj9FfFUeCjA3sKYE/DdYMKfUEgxRMhJFLgeLQ
        aMuDPSlUZkgY8CBUxWoaIKUgQw==
X-Google-Smtp-Source: AMsMyM6SDfF7cMxptMVQxQuncXmO78QNH8O+ogTcFC6KAzOv0cS/F4ORrpJhJoSy97C4UYtYyZxdXQ==
X-Received: by 2002:a37:5e41:0:b0:6ce:79e2:68af with SMTP id s62-20020a375e41000000b006ce79e268afmr21736389qkb.239.1667478107634;
        Thu, 03 Nov 2022 05:21:47 -0700 (PDT)
Received: from ?IPV6:2601:586:5000:570:a35d:9f85:e3f7:d9fb? ([2601:586:5000:570:a35d:9f85:e3f7:d9fb])
        by smtp.gmail.com with ESMTPSA id r23-20020ae9d617000000b006f474e6a715sm606366qkk.131.2022.11.03.05.21.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Nov 2022 05:21:46 -0700 (PDT)
Message-ID: <10086127-c733-364c-25da-0332c2336925@linaro.org>
Date:   Thu, 3 Nov 2022 08:21:45 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 09/10] dt-bindings: interconnect: qcom,msm8998-bwmon: Add
 sc8280xp bwmon instances
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Mike Tipton <quic_mdtipton@quicinc.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221028034155.5580-1-quic_bjorande@quicinc.com>
 <20221028034155.5580-10-quic_bjorande@quicinc.com>
 <0ada5a42-02f4-50ce-e65c-1a5fa9966900@linaro.org>
 <20221103033741.GA5525@core-thresher1.qualcomm.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221103033741.GA5525@core-thresher1.qualcomm.com>
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

On 02/11/2022 23:37, Bjorn Andersson wrote:
> On Fri, Oct 28, 2022 at 06:15:50PM -0400, Krzysztof Kozlowski wrote:
>> On 27/10/2022 23:41, Bjorn Andersson wrote:
>>> The sc8280xp platform has two BWMON instances, one v4 and one v5. Extend
>>> the existing qcom,msm8998-bwmon and qcom,sc7280-llcc-bwmon to describe
>>> these.
>>>
>>> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
>>> ---
>>>  .../devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml | 5 +++++
>>>  1 file changed, 5 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
>>> index be29e0b80995..223cd6ecf279 100644
>>> --- a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
>>> +++ b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
>>> @@ -25,9 +25,14 @@ properties:
>>>        - items:
>>>            - enum:
>>>                - qcom,sc7280-cpu-bwmon
>>> +              - qcom,sc8280xp-bwmon
>>
>> qcom,sc8280xp-cpu-bwmon
>> To match sc7280. I think it's better than my initial choice for
>> qcom,sdm845-bwmon without the cpu part.
>>
> 
> As discussed back then, we omitted "cpu" because there where multiple instances
> of the bwmon block. Would you prefer we give it the "cpu" compatible and
> potentially us it for non-cpu measurements?

I think yes, because we actually do not know whether measuring on
non-cpu instances would work without some adjustments...

Best regards,
Krzysztof

