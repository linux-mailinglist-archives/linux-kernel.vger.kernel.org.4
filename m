Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9360D6111D5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 14:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbiJ1Mra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 08:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiJ1Mr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 08:47:26 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F84573322
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 05:47:25 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id 8so3300834qka.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 05:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m1zeisbWzfTRLqshyHyu2ONVYhtME7k5k9XJadTce2s=;
        b=PFKyKgk7W8wOY0MRB/S6pACCrIjHCkTlMW+Yhg3RLzDCGfn2zH66SiaRGnDFFeNNpS
         AaEGFW39LYwKXiQGZsgVVTIY2+ZyKPxoe8eP3Q633BpMZsCSOJwWOR0hb5ad3LYuHJSL
         RAoSEhyRCATvIUtlvm+WsOtX10V7fHg5dNTQK5a4jEciPzwN5t/Wkye+8I/tdCmWX7QK
         5pRM57LlOhRw+5TgEViDRB7aR1Pk0pIQEhWnugXoSTXI7DKCRdGXKRvTed2NLGt7A5Ro
         5m6YRSgUewjzkZnzx9Ti005uE5lr9S84Yec6On5Y/Q94mBJhda73rlWT/iaggTcmG9iH
         XCGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m1zeisbWzfTRLqshyHyu2ONVYhtME7k5k9XJadTce2s=;
        b=YniMr7PCDozpRd6uTiUiPiKFX2ncrFOM3sgdFxkc61FaX8avUrlRJRPrOZIh1MqgA9
         X6yOOpv1JcqFq2qoaUfPKvlSZYGOHsZ3TuAjgftqlgBP35S/PkT8lWtd/VmNbqwwPmko
         1njHqqTvfKlzQW64c29LDkIWUZb7bX0889SDuQHk4JUWMQF8IIuHczsmjylVx8wPFTLx
         o5B/n48FXOtQisgtg/EkIDUKi3RT//mfQs2nvW6K8TZLrXt8/IneMNwfP9mf0mS3LbXP
         GSmUztS/FOEg9KmKXMt/N0jrRexhOO5QRrin6FTRjiVMCmcXgpKzJjeOIExmZDFwSmoz
         fVqw==
X-Gm-Message-State: ACrzQf1zx5sKxa1g0+VQ9wkY5JOsZOlBMih1T5RQ0y6YfDUyJMyTQS1X
        v94x9nsnFBlWwzrZQsmnJiAx5w==
X-Google-Smtp-Source: AMsMyM6L6NmlrETIJHnFwAuEJE3rylPlekFr1bnZnKO4P+98f/WChasuUtJEEWD3DcO89mw+mTE/gw==
X-Received: by 2002:a37:5a42:0:b0:6ee:8f0a:9319 with SMTP id o63-20020a375a42000000b006ee8f0a9319mr37789772qkb.315.1666961244601;
        Fri, 28 Oct 2022 05:47:24 -0700 (PDT)
Received: from [192.168.1.11] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id w10-20020a05620a444a00b006f9e103260dsm2942489qkp.91.2022.10.28.05.47.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 05:47:24 -0700 (PDT)
Message-ID: <20019699-40a7-37d6-4b9b-06446183338f@linaro.org>
Date:   Fri, 28 Oct 2022 08:47:22 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH V1 1/2] dt-bindings: PCI: tegra234: Add ECAM support
Content-Language: en-US
To:     Vidya Sagar <vidyas@nvidia.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, thierry.reding@gmail.com,
        jonathanh@nvidia.com, mperttunen@nvidia.com
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
References: <20221027051214.22003-1-vidyas@nvidia.com>
 <20221027051214.22003-2-vidyas@nvidia.com>
 <4579404d-b3f7-8342-6704-2644f5cd489d@linaro.org>
 <7229a2a6-d646-a8f5-50a2-cca6c44d16d5@nvidia.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <7229a2a6-d646-a8f5-50a2-cca6c44d16d5@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/10/2022 08:09, Vidya Sagar wrote:
> 
> 
> On 10/28/2022 2:48 AM, Krzysztof Kozlowski wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> On 27/10/2022 01:12, Vidya Sagar wrote:
>>> Add support for ECAM aperture for Tegra234.
>>>
>>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>>> ---
>>>   .../devicetree/bindings/pci/nvidia,tegra194-pcie.yaml  | 10 ++++++++--
>>>   .../devicetree/bindings/pci/snps,dw-pcie.yaml          |  2 +-
>>>   2 files changed, 9 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml
>>> index 75da3e8eecb9..15cc2d2055bb 100644
>>> --- a/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml
>>> +++ b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml
>>> @@ -27,6 +27,7 @@ properties:
>>>         - nvidia,tegra234-pcie
>>>
>>>     reg:
>>> +    minItems: 4
>>>       items:
>>>         - description: controller's application logic registers
>>>         - description: configuration registers
>>> @@ -35,13 +36,17 @@ properties:
>>>             available for software access.
>>>         - description: aperture where the Root Port's own configuration
>>>             registers are available.
>>> +      - description: aperture to access the configuration space through ECAM.
>>> +          This is applicable only for Tegra234.
>>
>> Then restrict it per compatible in allOf
>>
> 
> Thanks Krzysztof for your review.
> For a similar change here 
> https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20220707081301.29961-3-vidyas@nvidia.com/ 
> Rob had said that may be it is not worth it.
> Let me know if you really want this change and I'll push a new patch.
> 

That's a bit different. Restricting it per variant works and should be
trivial.

Best regards,
Krzysztof

