Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10C2F6B3A73
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 10:30:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjCJJaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 04:30:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbjCJJaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 04:30:01 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E29F92C5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 01:27:19 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id o12so17878678edb.9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 01:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678440434;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XJ9d6j8WgsUVApYR9beAlFODQrsbj5fgx2ATD5prkCo=;
        b=ITYfOyk1V+fh+hLeBeeWpKOxlkixzXLY/Qygab5E77P1V4ILjHuYmCqPTGql79ZXPT
         ikJxl0CJEpK6ZfSZAS6XWKp6vmFI4fVMNcGT7WqwP8SdlZephL9HuQb4OoM40KLw910D
         gKk2vKA9O2ohWhjCMemQdr44jFYOatMeatjbZ6CmF3pPkb1qvr+4q1yeInpOEQC2P4ye
         qAtVyfDtMnTYN9JU3MITFhn1If5UFn2+TxrIz0D+op1cnuLfRTL/A96ATo5uKiIKVOP8
         nSSvQkFZGe+iS/wcNw+4YoYWYGYaV4dpWhjhQ3YaXq9C6ZrvJDL8PAeeQGKfqF6BUVe8
         Bgww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678440434;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XJ9d6j8WgsUVApYR9beAlFODQrsbj5fgx2ATD5prkCo=;
        b=SvP+mxqNwEB33QkcCkKNZ7cI4PkKVXFHiGjaZWhTygm5DsbP8lgt1CP7xdJGR2ocQ/
         RO5sw60UuGW4Ik5p1hs080xP4P1sMx+FPgJW3JeWXX2ykHVPira8m5AT3CfG+mvd6vvF
         mu2n5avEmPU7wWr7MWZiRUvmLJ+ejOE++z6ytBfOHmTUzzcnvkIHz4Oy+yZDKp8c6+ht
         awDlmLnZXWNJwBik9z3e21uHFq8o46C2+YEur8yDVwCLUYUHlgyFLGXXgaV7DedzWBtt
         77T7IqyGe8mGFEakSGtg2g5/n3Qd8ZqyrX99ynmWkyAQnIJATA8frglsdlwUpSqdr7ON
         LB0w==
X-Gm-Message-State: AO0yUKVnKgkK8v/P+AeHoDsqfvV19ELIUIj/Z7xPxKXWAdEjqnc6va6z
        wFQbVM7TeLN0s3BSN7Z9NFUYPr3/vZxKJf641PI=
X-Google-Smtp-Source: AK7set/UU5JNmfqtdOeprVMtCMKMVwmOaXWOeCmemwa89Rw+58w4g5QPq10TYPNzmZvg9KoJftba5g==
X-Received: by 2002:aa7:d513:0:b0:4af:7f6e:297b with SMTP id y19-20020aa7d513000000b004af7f6e297bmr23687464edq.35.1678440433991;
        Fri, 10 Mar 2023 01:27:13 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:2a59:841a:ebc:7974? ([2a02:810d:15c0:828:2a59:841a:ebc:7974])
        by smtp.gmail.com with ESMTPSA id cz2-20020a0564021ca200b004aee4e2a56esm610424edb.0.2023.03.10.01.27.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Mar 2023 01:27:13 -0800 (PST)
Message-ID: <4ea944dd-8a42-e83f-607c-1a36124d19bb@linaro.org>
Date:   Fri, 10 Mar 2023 10:27:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [RFC PATCH v2 7/7] arm64: dts: qcom: Add the Inline Crypto Engine
 nodes
Content-Language: en-US
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org
References: <20230308155838.1094920-1-abel.vesa@linaro.org>
 <20230308155838.1094920-8-abel.vesa@linaro.org>
 <4eab53fc-2d26-dc93-3ae6-c0b2546ad3e0@linaro.org>
 <ZAol5o5a6HZYgRaG@sol.localdomain>
 <b5c9aa6e-69d1-165a-4ff9-b5a9f33688e6@linaro.org>
 <ZAr2nlFSKkBBQgcY@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ZAr2nlFSKkBBQgcY@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/03/2023 10:21, Abel Vesa wrote:
>>>>>  			compatible = "qcom,sdm630-sdhci", "qcom,sdhci-msm-v5";
>>>>>  			reg = <0x0c0c4000 0x1000>,
>>>>> -			      <0x0c0c5000 0x1000>,
>>>>> -			      <0x0c0c8000 0x8000>;
>>>>> -			reg-names = "hc", "cqhci", "ice";
>>>>> +			      <0x0c0c5000 0x1000>;
>>>>> +			reg-names = "hc", "cqhci";
>>>>
>>>> I believe this will break the ICE on these platforms without valid
>>>> reason. The commit msg does not explain why you do it or why this is
>>>> necessary.
>>>>
>>>> We already we received comment that we keep breaking Qualcomm platforms
>>>> all the time and need to keep them in some shape.
>>>>
>>>> Also, patchset is non-applicable in current set (breaks users) and
>>>> neither commit nor cover letter mentions it.
>>>>
>>>
>>> FWIW, I tested this patchset on SDA845, and ICE continues to work fine.
>>
>> Really? I clearly see of_find_device_by_node -> "return NULL" and all
>> old code gone, so ABI is broken. Are you sure you applied patch 1-6 and
>> ICE was working?
> 
> of_qcom_ice_get will return the ICE instance if the consumer node has a
> qcom,ice property with a phandle for the ICE devicetree node.

When patches 1-6 are applied, there is no qcom,ice property in DTS. Thus
I don't consider the test as correct... Even if we skip entire ABI
discussion the patchset is non-bisectable thus the test was failing to
detect even that.

> It will
> return NULL otherwise. SDA845 has such ICE node added by this patch,
> therefore, it will work. All platforms that have such node will work
> functionally like before. But I'll take care of the legacy approach as
> well in v3 (see below).

At point of patch 6 none of nodes have it. That's the entire point of
bisectability.

What's more, if you reverse code and makes DTS patches before driver
hoping to fix bisectability - do you see ICE working on existing
platforms? I don't think it so...

> 
>>
>>>
>>> (Though if I understand the patchset correctly, the ICE clock is no longer
>>> turned off when the UFS host controller is suspended.  That isn't ideal as it
>>> wastes power.  I would like that to be fixed.)
>>>
>>> Anyway, when you say "break the ICE", do you really mean "make an incompatible
>>> change to the device-tree bindings"?
>>
>> It breaks existing users of DTS and kernel.
> 
> I assume you mean it breaks if someone is using old approach DTS with a
> kernel that would have ICE driver merged. Yes, that it does. And for
> that, in the v3, I'll make of_qcom_ice_get check if there is a reg entry
> with name "ice" and create an ICE instance but for the same dev as the
> consumer driver. OTOH, if there is no reg entry called "ice", it will
> look up a device based on phande of qcom,ice property. This will allow
> legacy style DTS to work fine, while using the unified driver as a
> library, in that case. For newer platforms, the recommended approach
> will be to add a new ICE node and use qcom,ice property.

For the driver this sounds good. I still think that existing (older) DTS
should not have regs removed, because this affects other users of kernel
DTS.


Best regards,
Krzysztof

