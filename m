Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38D296B4FD7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 19:10:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbjCJSKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 13:10:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbjCJSJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 13:09:55 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E1112E152
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 10:09:52 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id k10so23843768edk.13
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 10:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678471791;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ORVCXx3FJT9k8xFkspcdLXNgp+g9cIrdMKWgI9R15io=;
        b=vtW4LQkIgVpatcxIr0Q1Xf20P3KlifZ1jN1L1CB8200CtJJ4Vydc+HWO2YQ7n1K2qL
         IG65+MMh3iyznCLGvmPZqWILhaj1Noedk6ALJc6U7hrKWd1ygkSfqmPTeRls7rdkBULk
         s774r5Zz8Fv8PQx7fj145Hg1CyQWQWxbIYAq9JHiYS7Ekn9GPCJ/9l+Zfe/SP8bePbXy
         lewMgX1l/eaOSOx3LQpbNymWXKvsdRjaHVasBC1LBFcnXB3l34UxKNxEqFfzjQAdYI8+
         cz6xYLZnIaHKBjzCch3pKziSAzyUYUfYVKOzvVptSc5uivB8yGmG0oM9oFv8H0ERsrFt
         DdDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678471791;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ORVCXx3FJT9k8xFkspcdLXNgp+g9cIrdMKWgI9R15io=;
        b=nrwrZWGhOp6G4C0yuKQsC3Ekgqk6OVoVy6ly8eIfTRF6U3JBbD0pDNIkUzBp3dgB2A
         CA4T/uDKnhfvFstR00yDfX9zfTU+Fu3zuEOOTIVd/6bfeAPQVrDCXSLeFZx8RvNoUtrU
         D4kAk4zHKAIWZ405VusENJ2duhMWDdB1wminDvOeitazfykGfqvi+i3/ln6PR5FIOibC
         re6wMuZuiJ01LpuRFvlVEOqVof4WJd9snm8TI3mu8vDAu1KQYUr1MYYzebfY1zG6t+RL
         4qi5W2dzDLbviarFeKH4HLhBkXBBPmeo66NGV1eIk/bvCbKpRTZr14z7eqie2NeOpw3M
         gF1w==
X-Gm-Message-State: AO0yUKXsnGskPCY8n7SgzUCcBCag1IkX19e4eJRAqJ9duAFBb9EOH8/P
        JYqposgm5vebY1fV9EHjb7sIcw==
X-Google-Smtp-Source: AK7set/U6hDft9wrsY++czNE4jn1ojWioWAIarHr3m6wUnBWFzUyTYOKaCG6qW4KUaYMtf9VH24S4A==
X-Received: by 2002:a17:907:7241:b0:884:fd73:8053 with SMTP id ds1-20020a170907724100b00884fd738053mr33528706ejc.9.1678471791057;
        Fri, 10 Mar 2023 10:09:51 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:34:52e3:a77e:cac5? ([2a02:810d:15c0:828:34:52e3:a77e:cac5])
        by smtp.gmail.com with ESMTPSA id kw23-20020a170907771700b008d8f1b238fdsm144516ejc.149.2023.03.10.10.09.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Mar 2023 10:09:50 -0800 (PST)
Message-ID: <e3ca545d-47f0-9fd5-4d51-4bb15fa7bf65@linaro.org>
Date:   Fri, 10 Mar 2023 19:09:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/8] dt-bindings: usb: Add bindings for multiport
 properties on DWC3 controller
Content-Language: en-US
To:     Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        quic_pkondeti@quicinc.com, quic_ppratap@quicinc.com,
        quic_wcheng@quicinc.com, quic_jackp@quicinc.com,
        quic_harshq@quicinc.com, ahalaney@redhat.com,
        quic_shazhuss@quicinc.com,
        Bjorn Andersson <quic_bjorande@quicinc.com>
References: <20230310163420.7582-1-quic_kriskura@quicinc.com>
 <20230310163420.7582-2-quic_kriskura@quicinc.com>
 <ade5b126-9506-5e0d-3071-d26c97ecfc9a@linaro.org>
 <8aadbea6-29c0-713f-ced3-263307ad0051@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <8aadbea6-29c0-713f-ced3-263307ad0051@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/03/2023 17:54, Krishna Kurapati PSSNV wrote:
> 
> 
> On 3/10/2023 10:11 PM, Krzysztof Kozlowski wrote:
>> On 10/03/2023 17:34, Krishna Kurapati wrote:
>>> Add bindings to indicate properties required to support multiport
>>> on Snps Dwc3 controller.
>>>
>>> Suggested-by: Bjorn Andersson <quic_bjorande@quicinc.com>
>>> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
>>
>> What happened with entire previous changelog? This is not v1 but v5 or
>> more? At least v4 was here:
>>
>> https://lore.kernel.org/all/20230115114146.12628-2-quic_kriskura@quicinc.com/
>>
>> Best regards,
>> Krzysztof
>>
> Hi Krzysztof,
> 
>    Since I pushed a formal patch series, I mentioned PATCH in header 
> instead of "Patch v5". If the RFC v4 is to be followed by Patch-v5, I 
> can re-push the changes again with a proper header and fix my mistake.
> 
> The previous change log is mentioned in cover letter.
>

OK, for the future, first submission is the v1. This is fifth submission.

Best regards,
Krzysztof

