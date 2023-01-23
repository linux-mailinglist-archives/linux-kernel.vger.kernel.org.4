Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CAC96779C6
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 12:03:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbjAWLDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 06:03:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231551AbjAWLDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 06:03:20 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8303216AF3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 03:03:18 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id f12-20020a7bc8cc000000b003daf6b2f9b9so10287850wml.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 03:03:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eSV5uo0LzqlE/rDUs0H+Ek9lv+hIiI/0qlptbm1nlzo=;
        b=Q9zz6tDiTIEqkINnMDbEAc9ILYldzvnpgCQVocYauAClFiB3JC21S7pEtANOVdZngz
         sttTVNKpYbQs/CUaAQ6c6Bu+Rg4lHVBfNw3htHvzbyVKBPvXsz405idLuCmYZcfuHZcV
         0dXI193ffNKuBK/eDHl2qnP6X0OMu2gc9PpobucvwpCPE+eaPQDeBFxjdhchSnuL92XK
         UKOsUp3TtcdIP2rRZ/DuBofaRRwR9HjwFhfoo7gDJ9fnDNLyOeM8Xe+9umcHSQspdQEM
         sixtL7seJkdnvPRsQMkBXyrGVvwklSHxT9LedF5WQU1Sbzy9giC0jIOk4gTeeQRQ2EKr
         BUtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eSV5uo0LzqlE/rDUs0H+Ek9lv+hIiI/0qlptbm1nlzo=;
        b=mH6yA9Ps9NKmnRJY/8MdjDovtb9THGFYTPgpElFwqn3GE0SSowQpxvr5xkSlohTAK+
         Rhvb3whO0tX8sfbEw9EV12lAwNs8n8G1ja2TXoJI8njADauIhs0ZJtxCsJ+Ea3NpJF5o
         /7qcad8oKcl7TYOr8Iu8C1CKc6FMwfsuMJh5aysYCO1a5LhJ8oZmhV5cg+CJ1Y6Dw6pm
         ydHJZbBoOc1a6lxbDP+no6gBRwshn6kcngoUxwLiNCkbm6HdcL0qz4dLCLKQUEvWLDZD
         0zGCm1FtwEmq5LahuxldSKnPdJTxROULwvmhO9sxK1OE3NINGfBqzB/5Im9rENFMcj+0
         QWYw==
X-Gm-Message-State: AFqh2kotK0X1xy+z2vnghFOJ/FRP28bz5tzVDOt2kKp4UI2DcQbaQGuZ
        rptFNEowGaLBTDGVmYxqgbnBIw==
X-Google-Smtp-Source: AMrXdXuWIciYT3qWABQE8KiIpgFepimGzph3mMI6Ii1TsVDBmMMhr3NEtvyE/L5N3b+DBiIooIRzog==
X-Received: by 2002:a05:600c:35d6:b0:3db:2ad:e344 with SMTP id r22-20020a05600c35d600b003db02ade344mr20332817wmq.13.1674471797051;
        Mon, 23 Jan 2023 03:03:17 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id bg24-20020a05600c3c9800b003d9ed40a512sm14284884wmb.45.2023.01.23.03.03.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 03:03:16 -0800 (PST)
Message-ID: <4f0f8477-2a06-0e95-be32-0ec0f337a7fe@linaro.org>
Date:   Mon, 23 Jan 2023 12:03:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v4 09/12] dt-bindings: PCI: qcom: Add SM8550 compatible
Content-Language: en-US
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20230119140453.3942340-1-abel.vesa@linaro.org>
 <20230119140453.3942340-10-abel.vesa@linaro.org>
 <7af21247-a44e-cb46-7461-204fa6b4fcab@linaro.org>
 <Y85lFD3m5pdpNtdR@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Y85lFD3m5pdpNtdR@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/01/2023 11:44, Abel Vesa wrote:
> On 23-01-22 15:10:59, Krzysztof Kozlowski wrote:
>> On 19/01/2023 15:04, Abel Vesa wrote:
>>> Add the SM8550 platform to the binding.
>>>
>>> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
>>> ---
>>>
>>> The v3 of this patchset is:
>>> https://lore.kernel.org/all/20230119112453.3393911-1-abel.vesa@linaro.org/
>>>
>>> Changes since v3:
>>>  * renamed noc_aggr to noc_aggr_4, as found in the driver
>>>
>>> Changes since v2:
>>>  * dropped the pipe from clock-names
>>>  * removed the pcie instance number from aggre clock-names comment
>>>  * renamed aggre clock-names to noc_aggr
>>>  * dropped the _pcie infix from cnoc_pcie_sf_axi
>>>  * renamed pcie_1_link_down_reset to simply link_down
>>>  * added enable-gpios back, since pcie1 node will use it
>>>
>>> Changes since v1:
>>>  * Switched to single compatible for both PCIes (qcom,pcie-sm8550)
>>>  * dropped enable-gpios property
>>>  * dropped interconnects related properties, the power-domains
>>>  * properties
>>>    and resets related properties the sm8550 specific allOf:if:then
>>>  * dropped pipe_mux, phy_pipe and ref clocks from the sm8550 specific
>>>    allOf:if:then clock-names array and decreased the minItems and
>>>    maxItems for clocks property accordingly
>>>  * added "minItems: 1" to interconnects, since sm8550 pcie uses just
>>>  * one,
>>>    same for interconnect-names
>>>
>>>
>>>  .../devicetree/bindings/pci/qcom,pcie.yaml    | 44 +++++++++++++++++++
>>>  1 file changed, 44 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
>>> index a5859bb3dc28..58f926666332 100644
>>> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
>>> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
>>> @@ -34,6 +34,7 @@ properties:
>>>        - qcom,pcie-sm8250
>>>        - qcom,pcie-sm8450-pcie0
>>>        - qcom,pcie-sm8450-pcie1
>>> +      - qcom,pcie-sm8550
>>>        - qcom,pcie-ipq6018
>>>  
>>>    reg:
>>> @@ -65,9 +66,11 @@ properties:
>>>    dma-coherent: true
>>>  
>>>    interconnects:
>>> +    minItems: 1
>>>      maxItems: 2
>>>  
>>
>> I don't see my concerns from v3 answered.
> 
> Check the dates for v4 and your reply to v3.
> 
> v4 was sent a day before you sent your v3 comments. :)
> 
>>
>> This is a friendly reminder during the review process.
>>
>> It seems my previous comments were not fully addressed. Maybe my
>> feedback got lost between the quotes, maybe you just forgot to apply it.
>> Please go back to the previous discussion and either implement all
>> requested changes or keep discussing them.
> 
> Will address your comments in next version.

Ah, then ok :)

Best regards,
Krzysztof

