Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33EAE6DA208
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 21:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238485AbjDFTzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 15:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbjDFTzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 15:55:47 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25EB659DA
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 12:55:46 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id k37so52289626lfv.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 12:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680810944;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4e1AWlyBcKR3I5ILtwI72cSCBL6y95j52yQauXVOOT4=;
        b=Zsrv5K3FHfPUlnAL4tM0QO4XO4TcKMRkr6dlWxS3c689yhPdxiv74jcFDVkZ/++FKe
         Aj9rESwM+6elJgC6xmYnmx1pRuK/0fw3XztXgJa281VLTq5j2Cg2YErERSatkX7MknPS
         qXDl72lYtrqkcnYCGlrsF2g5gNn+f6dppe53A9CdTl7rg2ciKvWHgTivf5mKhBl+J00A
         41rRghCUuxyfYQ7tEQqY/CjKpPf5vPU4PQXifwkN8C5gsmr0+L1eDxuEQbGykLLHnD8Z
         +83e5LvqHRdu6/jEnC01Ej0zCF71Z8DF7ZJovx2c39KdQtWXoZiFoVbfBulzAoikmHmb
         T+tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680810944;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4e1AWlyBcKR3I5ILtwI72cSCBL6y95j52yQauXVOOT4=;
        b=1MoonhKtvNRIe7Pi8oDwDiKh/9YvzmrCLMVFzKjRCkzRg9xaoDCvVE7xGyxgj/+lxp
         f3KX8bPieyxNHQQdmyevHg42GMG0c91/foxtQLjKCApajo//dlX4q9y4485pXDjIvA8x
         9jEKdfi9Gowt3s4YgCn0IOXnK8PT6gmg3vj6ixhvyzcEWEkjMRhHQw891+yL79ba8cCK
         zzDtLKP+Q4XIv3n3GTBiJQO5oZdU3ljETcxTc/hvbwhcNGxM5ui/filo6JPcjnvJiEz7
         ORT80TO6ybO6rK1WmbmL/xQj6OkCb02+iR136+D4lsgrZGapDIl5rNUm1n5843WVhAQZ
         fTtQ==
X-Gm-Message-State: AAQBX9fYP+Y76PVVahLpcqARZX0+L1M8A2KwoFcNeLE+5gnz17pOOrk4
        bidHSu3sBi196fpGTHgYsC2t1Q==
X-Google-Smtp-Source: AKy350YHCUi8OdmwLOFkttGbLhbPMWeS/ZJvAxLuiglxSYenCnEaHo3KOjeTDn8ks4gRqkuYUnVILA==
X-Received: by 2002:ac2:54a5:0:b0:4eb:e7f:945 with SMTP id w5-20020ac254a5000000b004eb0e7f0945mr50291lfk.41.1680810944382;
        Thu, 06 Apr 2023 12:55:44 -0700 (PDT)
Received: from [192.168.1.101] (abxh37.neoplus.adsl.tpnet.pl. [83.9.1.37])
        by smtp.gmail.com with ESMTPSA id b6-20020a056512218600b004b5480edf67sm393504lft.36.2023.04.06.12.55.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 12:55:43 -0700 (PDT)
Message-ID: <3ce9b5ec-8b02-537a-c663-c849e80cab66@linaro.org>
Date:   Thu, 6 Apr 2023 21:55:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 1/2] dt-bindings: interrupt-controller: mpm: Pass MSG
 RAM slice through phandle
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org,
        Shawn Guo <shawn.guo@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Marc Zyngier <maz@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230328-topic-msgram_mpm-v2-0-e24a48e57f0d@linaro.org>
 <20230328-topic-msgram_mpm-v2-1-e24a48e57f0d@linaro.org>
 <168069726278.2356075.14351594478003012447.robh@kernel.org>
 <20230405134727.GA2461305-robh@kernel.org>
 <1e6e2590-ac78-400b-35ce-321d5e52f385@linaro.org>
 <9df12111-ec84-c4f7-fbcb-bccaef91b048@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <9df12111-ec84-c4f7-fbcb-bccaef91b048@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6.04.2023 19:45, Krzysztof Kozlowski wrote:
> On 05/04/2023 15:49, Konrad Dybcio wrote:
>>
>>
>> On 5.04.2023 15:47, Rob Herring wrote:
>>> On Wed, Apr 05, 2023 at 07:22:40AM -0500, Rob Herring wrote:
>>>>
>>>> On Wed, 05 Apr 2023 12:48:34 +0200, Konrad Dybcio wrote:
>>>>> Due to the wild nature of the Qualcomm RPM Message RAM, we can't really
>>>>> use 'reg' to point to the MPM's slice of Message RAM without cutting into
>>>>> an already-defined RPM MSG RAM node used for GLINK and SMEM.
>>>>>
>>>>> Document passing the register space as a slice of SRAM through the
>>>>> qcom,rpm-msg-ram property. This also makes 'reg' deprecated.
>>>>>
>>>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>>>> ---
>>>>>  .../devicetree/bindings/interrupt-controller/qcom,mpm.yaml   | 12 +++++++++---
>>>>>  1 file changed, 9 insertions(+), 3 deletions(-)
>>>>>
>>>>
>>>> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
>>>> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>>>>
>>>> yamllint warnings/errors:
>>>>
>>>> dtschema/dtc warnings/errors:
>>>> Documentation/devicetree/bindings/interrupt-controller/qcom,mpm.example.dts:22.35-38.11: Warning (node_name_vs_property_name): /example-0/interrupt-controller: node name and property name conflict
>>>
>>> Looks like this is colliding with the example template which has to 
>>> craft an interrupt provider for 'interrupts' properties. Either adding a 
>>> parent node or using interrupts-extended instead should work-around it.
>> Check the devicetree-org issue linked in the cover letter, please!
>>
>> I suppose wrapping it in a parent node could work as a temporary
>> measure, but since it belongs outside /soc, I'd have to make up
>> a bogus simple-bus, I think.
> 
> I don't think your issue in dtschema is accurate. As Rob suggested, you
> need wrapping node.
I don't really know what kind.. I can add something like:

rpm {
	compatible = "qcom,rpm", "simple-mfd";

	mpm: interrupt-controller {
	...
};

And then only introduce a very simple YAML for "qcom,rpm"
describing what it is and documenting the compatible.

Or I can push it under rpm-requests{}.

Konrad
> 
> Best regards,
> Krzysztof
> 
