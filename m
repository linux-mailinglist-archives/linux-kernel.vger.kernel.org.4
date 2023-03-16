Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 627CB6BC800
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 08:59:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjCPH7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 03:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbjCPH7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 03:59:11 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C4D626C1D
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 00:58:59 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id r11so4115403edd.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 00:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678953538;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GgWjAOSsGpnFZeb1S60AfKC+cGhYfGms4dZlf0IKKGw=;
        b=H43a7pWnRKfhhghjWHGago3HNcH/TRFRNsac1WdvfZSqww/x05Y1YrKWm9dhYZn4gl
         ZrBLZf1HU5rqZJr6ym8sM4P3xUXfyk56XHkDWW3iefFDe7ELUfAVMYEvxIgTQ1IV/03q
         8wWqBe7JHYu8GSKhd8597T5VTiTrOlyWHUtr+1l4nr4hFEFmoY6zLtRkaruqS8tIOQNx
         13/kKFA0LPk8+qaGjt4K92NcdlxtQFeQSWbTJY7EknKDHDI1Zipfwe/nf6MCXIickfrM
         AZjA2Z9HD00SFpSoboA7FUQYOt20/j6ofoEp/iExP/jX/Kr3Goc+QdJU45vu5qdmqAYl
         m5EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678953538;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GgWjAOSsGpnFZeb1S60AfKC+cGhYfGms4dZlf0IKKGw=;
        b=p+IFM9QPHdIg21qi+j8et+KkFRf/2gIX91L6caGMb1QFF72E1Bs3wmYKKYY/CZceSk
         pU5Uu0BlQgUeevefXqWyExGIPSmJka2uyqay4IDfVZKQrDYk8hgm1eWpdmWvtjtzvGci
         JcAgDbroJ9nwIeiA969fvLItFvKUgjZvgAVFS2SmDQVZ6JgeKTIKlM6FYkMConm5LXvC
         No9OA2mOIfre4hMUW3Z49YHyHq1fgjjGylaaa7ElLL0nZ/NbJR933Hwo/HYLaBcdT1ws
         ibB4t4Wf97hArsqOLJcBBuC9otFB+2K914/qFwwC+6NGi0y12PRu+KFrBPhL5cRkiwuH
         9O5w==
X-Gm-Message-State: AO0yUKWYFCEhe01Q0pXFb+vPN4ZqwJp/YsUFBUrLoEk+wa4K2xGKod/Z
        /T3f91tuPukRSyvmfgU8POK3Ow==
X-Google-Smtp-Source: AK7set/d7tBTRU9WkYZeBn2oKVks+I8G8LF9+LOa6Y1dE4mGGH41JMn3Nw7oHi5E9mdgWKAsd3QjqA==
X-Received: by 2002:a17:907:a649:b0:8f7:6ea6:b451 with SMTP id vu9-20020a170907a64900b008f76ea6b451mr10035458ejc.2.1678953537888;
        Thu, 16 Mar 2023 00:58:57 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:9827:5f65:8269:a95f? ([2a02:810d:15c0:828:9827:5f65:8269:a95f])
        by smtp.gmail.com with ESMTPSA id f6-20020a170906738600b008ea8effe947sm3494225ejl.225.2023.03.16.00.58.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Mar 2023 00:58:57 -0700 (PDT)
Message-ID: <1b0c4e5b-55e6-e519-bff1-a641e0141a8b@linaro.org>
Date:   Thu, 16 Mar 2023 08:58:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v4 14/18] dt-bindings: PCI: qcom: Add "mhi" register
 region to supported SoCs
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        andersson@kernel.org, lpieralisi@kernel.org, kw@linux.com,
        krzysztof.kozlowski+dt@linaro.org, robh@kernel.org
Cc:     konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_srichara@quicinc.com
References: <20230315064255.15591-1-manivannan.sadhasivam@linaro.org>
 <20230315064255.15591-15-manivannan.sadhasivam@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230315064255.15591-15-manivannan.sadhasivam@linaro.org>
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

On 15/03/2023 07:42, Manivannan Sadhasivam wrote:
> "mhi" register region contains the MHI registers that could be used by
> the PCIe controller drivers to get debug information like PCIe link
> transition counts on newer SoCs.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

This is a friendly reminder during the review process.

It looks like you received a tag and forgot to add it.

If you do not know the process, here is a short explanation:
Please add Acked-by/Reviewed-by/Tested-by tags when posting new
versions. However, there's no need to repost patches *only* to add the
tags. The upstream maintainer will do that for acks received on the
version they apply.

https://elixir.bootlin.com/linux/v5.17/source/Documentation/process/submitting-patches.rst#L540

If a tag was not added on purpose, please state why and what changed.


Best regards,
Krzysztof

