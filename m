Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9627F6D4C5C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 17:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbjDCPsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 11:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231411AbjDCPr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 11:47:59 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 075C630EA
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 08:47:22 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id eh3so119073670edb.11
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 08:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680536827;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3msoM9z3RclTRd+eHQKtiv2M7gCA/4iFqXhqJTbcCvI=;
        b=v0+x2EZy3qjDuUVIrhkwAooxOofocWnH75XU1LyTABMzV0iuoerniGu8hYjl7SeOGC
         wAH/mUChSngKFjrlfrJZjMhD4GHgdeN57wwk0wV8OWdtD7cky8jwkZqZeOP+uXVuKJJX
         HG1qB6Zpf4gWjSG+iJyHSHKnE39UxoqWWHS5cON58+4CcbUEAD1T92/avrnmxfUduCk8
         IODwe2YCy7Qac1NgWrzNh/c9rraM8QhDONqzYnzQTghprOtm9BSJ3VktQweXTOsvKZE8
         dVcdUPk+Jxs4UgE4vIXj9Qr2QskDjkmT7bfZLPCzPDI8jViA3QmcSnCe6QndqLDmibP2
         8Sqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680536827;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3msoM9z3RclTRd+eHQKtiv2M7gCA/4iFqXhqJTbcCvI=;
        b=bOvYg4N83xiK1h6BQMGCrnZ/Z1ssyQLVCLoErZ2NZP8OQt7Wirq7/KkHNhvSLZ0s/z
         GSbzPerZwEVwgWlow+16k2+YQGhHYoofrsHQchh4bDNoj2eStb2OY/i4ylEVW1P0Sybh
         UJDrWc1Csv44hGMA9WP7MBZ4idyGbZ/WXY6crFlZXjv2R4uhbDhOdq1fL80LRMbhzi8N
         LXThdsACcK7+n5c5hGps9PRe8w5bv3BiD7XXqUqtTVR4hjjXiI3HxMFCki2QiRfGQM8S
         nVGnzHTFBOASyUaOLSLdnZ2vstTEaSN5vcZQRA0mwl+mS6eOiXIKU5tHjOzIGYfRCjJl
         WoTw==
X-Gm-Message-State: AAQBX9dULr5Qwf9+34TnfMofAO37gNzmOpTlUIqS8BA+GbbBYK5ZVYdL
        cDhGY+YgIzzDR4McwS3jkqHBSw==
X-Google-Smtp-Source: AKy350Z09E9t8/lLHZEsbdT5wvlMV+SEiS4YsUcnXn+I5zCfuY0rRM0+hymgL8S7tpDUY4pqkj/utg==
X-Received: by 2002:a17:906:738a:b0:933:4ca3:9678 with SMTP id f10-20020a170906738a00b009334ca39678mr35816062ejl.24.1680536826851;
        Mon, 03 Apr 2023 08:47:06 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:ae90:d80:1069:4805? ([2a02:810d:15c0:828:ae90:d80:1069:4805])
        by smtp.gmail.com with ESMTPSA id gv19-20020a1709072bd300b00931db712768sm4707227ejc.4.2023.04.03.08.47.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 08:47:06 -0700 (PDT)
Message-ID: <bf7b5218-56ba-5525-fcb8-7be71b114a79@linaro.org>
Date:   Mon, 3 Apr 2023 17:47:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v4 4/6] dts: qcom: arm64: qcom: sdm845: use defines for
 VMIDs
Content-Language: en-US
To:     Dylan Van Assche <me@dylanvanassche.be>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
References: <20230401173523.15244-1-me@dylanvanassche.be>
 <20230401173523.15244-5-me@dylanvanassche.be>
 <ea03bfb6-34c4-45e2-c179-74ecafad559f@linaro.org>
 <2d9d001f14036caf4f6d47448d4d2fdb0b188101.camel@dylanvanassche.be>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <2d9d001f14036caf4f6d47448d4d2fdb0b188101.camel@dylanvanassche.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/04/2023 17:32, Dylan Van Assche wrote:
> Hi Krzysztof,
> 
> On Mon, 2023-04-03 at 11:20 +0200, Krzysztof Kozlowski wrote:
>> On 01/04/2023 19:35, Dylan Van Assche wrote:
>>> Use VMID defines for SLPI's FastRPC node in the Qualcomm SDM845 DTS
>>> instead of hardcoded magic values.
>>>
>>> Signed-off-by: Dylan Van Assche <me@dylanvanassche.be>
>>> ---
>>>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 4 +++-
>>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi
>>> b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>>> index 1f25a7f4e02b..dc4b553cbe2e 100644
>>> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
>>> @@ -13,6 +13,7 @@
>>>  #include <dt-bindings/clock/qcom,rpmh.h>
>>>  #include <dt-bindings/clock/qcom,videocc-sdm845.h>
>>>  #include <dt-bindings/dma/qcom-gpi.h>
>>> +#include <dt-bindings/firmware/qcom,scm.h>
>>>  #include <dt-bindings/gpio/gpio.h>
>>>  #include <dt-bindings/interconnect/qcom,osm-l3.h>
>>>  #include <dt-bindings/interconnect/qcom,sdm845.h>
>>> @@ -3372,7 +3373,8 @@ fastrpc {
>>>                                         qcom,glink-channels =
>>> "fastrpcglink-apps-dsp";
>>>                                         label = "sdsp";
>>>                                         qcom,non-secure-domain;
>>> -                                       qcom,vmids = <0x3 0xF 0x5
>>> 0x6>;
>>
>> Didn't you just add it in previous patch? Don't add incorrect code
>> which
>> you immediately change.
>>
> 
> Both are similar, the code is in fact the same. I followed what Konrad
> suggested in v3 to make a patch on top:

I don't understand. Device nodes are similar, but they are different? If
you add a line in patch X and change it in patch X+1, then something is
wrong. Isn't this the case here or these are different device nodes?


Best regards,
Krzysztof

