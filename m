Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D25763364A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 08:50:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232583AbiKVHus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 02:50:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232373AbiKVHuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 02:50:44 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78AEE31FAC
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 23:50:42 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id s24so16992200ljs.11
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 23:50:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TPz0CfRWtJWXgtCnS7ds9MNbespiiT1+KjVHD4pisS8=;
        b=iQY5Gfp6qXqtdYsRxjlZyiRx0Lu7vUpss+/51LGs4B9Rax4lUDwTJTfPULQaneuMtx
         QxBz/8vp5w5UuTi4oMwlEZ08NG7BLC4yVhJdWzFywiQHu7I6HAaTXebE/d2+kFxT8ssW
         hf2MaaFx1n5tUCwJLhOffFqymyQoE2PSbVa620USjXi8xbuMJ7oz0LtAOhSh8Y/G60m5
         TCwc6gaVzqpHMVsgOH0HPH0+BO+xqTgU2x04wjDPgx2TGsAhlEqdg+yI0Jsl9GRzUSKD
         Yfl64D4P8HpC+JCofEHK0hGvo5SDNfSufHR560B+Q9lFuvN5elrb3hrLqEVwipxAAraE
         3Kqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TPz0CfRWtJWXgtCnS7ds9MNbespiiT1+KjVHD4pisS8=;
        b=EFc6su5iaNn8OiYZaAMPgjmKtcVs6PYivT69hwscj0EaVSjyW6LwWdzcM++Gq7kEnF
         rpS4SSDSdTeDH+pg7IPS/JhQ68Zc0rNCl3wgEshcEy1dJu7Tfh6O7O5lzFnSWPO4jKD4
         T3DB5WO7ZTxolhfKFF1U9xBdLFbD5f/mQhvv35ZHzujy43Vf9QJDXeoJjckTaEiY2xDa
         kgh70pDWmNomBSKpKU86xRusbierbjLqbBQapZV/oHEZuq7VyV7ySppBUb2/rNWb6G1f
         gFxrTv4VrAutjKW8Vz1vgWFjdhMdGTwSwawJIL7rSEmz+91FeHmsKLIgYv/VvhkMQNZJ
         mNHA==
X-Gm-Message-State: ANoB5pnsFe1Xko8cgcw6o52thhG/WG6EvY2BtbsklZveAovUaoJFN653
        tZ47+6DUgg/+OsA50R1lG5HzoA==
X-Google-Smtp-Source: AA0mqf7dyX3euZowNC8FGmmtOg2WzEtwBgoJjCmNcNFKoHc5tllPD4n+7B4F81hioDrq3Gxi8dQULA==
X-Received: by 2002:a2e:a37c:0:b0:26e:93:980d with SMTP id i28-20020a2ea37c000000b0026e0093980dmr7466963ljn.488.1669103440836;
        Mon, 21 Nov 2022 23:50:40 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id a4-20020a056512200400b004a01105eea2sm2354702lfb.150.2022.11.21.23.50.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 23:50:40 -0800 (PST)
Message-ID: <b7cc4f5d-c1d6-919c-9604-7855ea802d17@linaro.org>
Date:   Tue, 22 Nov 2022 08:50:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v4 1/3] dt-bindings: interconnect: Add rpmh virt devices
Content-Language: en-US
To:     Melody Olvera <quic_molvera@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Odelu Kukatla <quic_okukatla@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221118182245.31035-1-quic_molvera@quicinc.com>
 <20221118182245.31035-2-quic_molvera@quicinc.com>
 <536af0d9-aa00-ddf1-753d-670ec2adef91@linaro.org>
 <3ada611b-96e0-5cf0-d79d-b90ca4202ddb@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <3ada611b-96e0-5cf0-d79d-b90ca4202ddb@quicinc.com>
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

On 21/11/2022 18:39, Melody Olvera wrote:
> 
> 
> On 11/20/2022 5:13 AM, Krzysztof Kozlowski wrote:
>> On 18/11/2022 19:22, Melody Olvera wrote:
>>> Add documentation for virtual rpmh devices. These interconnects
>>> are not controlled by the application processor and thus
>>> require separate bindings. Also, move compatibles for sm8450 to
>>> this document and add them for QDU1000/QRU1000 platforms.
>>>
>>> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
>>> ---
>>>  .../bindings/interconnect/qcom,rpmh-virt.yaml | 55 +++++++++++++++++++
>>>  .../bindings/interconnect/qcom,rpmh.yaml      |  2 -
>>>  2 files changed, 55 insertions(+), 2 deletions(-)
>>>  create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,rpmh-virt.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,rpmh-virt.yaml b/Documentation/devicetree/bindings/interconnect/qcom,rpmh-virt.yaml
>>> new file mode 100644
>>> index 000000000000..5cbaa51df863
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/interconnect/qcom,rpmh-virt.yaml
>>> @@ -0,0 +1,55 @@
>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/interconnect/qcom,rpmh-virt.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Qualcomm RPMh Virtual Network-On-Chip Interconnect
>>> +
>>> +maintainers:
>>> +  - Georgi Djakov <georgi.djakov@linaro.org>
>>> +  - Odelu Kukatla <quic_okukatla@quicinc.com>
>>> +
>>> +description: |
>>> +   RPMh interconnect providers support system bandwidth requirements through
>>> +   RPMh hardware accelerators known as Bus Clock Manager (BCM). The provider is
>>> +   able to communicate with the BCM through the Resource State Coordinator (RSC)
>>> +   associated with each execution environment. Provider nodes must point to at
>>> +   least one RPMh device child node pertaining to their RSC and each provider
>>> +   can map to multiple RPMh resources. Virtual interconnect providers are not
>>> +   controlled by AP and do not support QoS; they should not have associated
>>> +   register regions.
>>> +
>>> +allOf:
>>> +  - $ref: qcom,rpmh-common.yaml#
>>> +
>>> +properties:
>>> +  compatible:
>>> +    enum:
>>> +      - qcom,qdu1000-clk-virt
>>> +      - qcom,qdu1000-mc-virt
>>> +      - qcom,sm8450-clk-virt
>>> +      - qcom,sm8450-mc-virt
>> You should also move qcom,sdx65-mc-virt, qcom,sc8280xp-mc-virt,
>> qcom,sc8280xp-clk-virt and more.
> 
> Ok. I wasn't sure since some of these entries don't seem to conform to
> these bindings, even though it seems they should.

I have impression that devices I listed conform to these bindings, this
is why I listed them. But if you are sure that they do not, then they
should not be moved.

Best regards,
Krzysztof

