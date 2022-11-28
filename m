Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2849D63A32C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 09:35:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbiK1IfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 03:35:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbiK1Ie6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 03:34:58 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA0A62FC
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 00:34:55 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id p8so16185508lfu.11
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 00:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bkk5qJOE/VryR0ieeP2IB27nwP5PcGUzPajxP73VPy4=;
        b=RyNUCF7DIdcBaeiOO+4l1RdqwPSkuTV/DKV2RCcU2ByM4W+Jlk+lCSxHwz3u3Yx97p
         QE9AgoC9w9yXM/dcSpHjbD5h99jxKKOqMsCt70v20BlvrJ+OT0OuhZQspO2g/CuqmG8f
         Gt63wSMiSKPpGn+JUnHPzqpy6qRiOKbwNvz5xwWCjhQVrK7AT4phhuiy+4xr5FzdrL4g
         jMK0fqJH3E+DJIPeYtsU5oXFhFJDwPvcNLeGl9n0MgvK9RHpG81CUS/sa2XPEnxpcqyM
         nzEqzZKg12KGHhHz30ZyiezkcyQezGqNMubHqOrPI6F6bPlaKqkicTLQ/Aq7M1aGkgdL
         tBLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bkk5qJOE/VryR0ieeP2IB27nwP5PcGUzPajxP73VPy4=;
        b=z7cVp7wZZxYknqL6Mlh+JTXgxgpEX1KlY+N4lJnXQOaGszzL+W49NtucDu7EsvAByr
         aWJZROXoxIRqpaDJoMXqDpbA4jEXcibqqGZCjqLpWWqAZQFkYOEyu4U1xlH0nVRcaPuL
         kA2kESr7zjOJH05MU8oO1zvLPTluV7/M+QAvsHjqvmvKGmyUlHoUVeNq0L6WWQCJJJzv
         8WteYpfxhRIs+bnqoXlKPwmmIzndD7bmVCrYi74yCOXJiRZIY449jw3sxd7324elIsdT
         IuYCQz5h2pdv7p87b2gvqyZ+TrcfYNqvXqIr2q9GFBC1Vqb95l3wrl8qbXnSyHTk4pRZ
         7sxQ==
X-Gm-Message-State: ANoB5plPwF7o+J1eKMyUmLgS9pd/8f+WI4PRSdKRyxAQ8DmIIjxPjvIq
        gP+2OA/YicfUE09gSAZKVms+VA==
X-Google-Smtp-Source: AA0mqf5aVBlZGW/MVwnVh0IXkD7kUGTSF7mWoGHUIYNw0Z6CKWdYuycbqyE//gvbfon36dwMH98lxQ==
X-Received: by 2002:ac2:5ddb:0:b0:4a2:500d:f031 with SMTP id x27-20020ac25ddb000000b004a2500df031mr10606791lfq.266.1669624493519;
        Mon, 28 Nov 2022 00:34:53 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id a3-20020a2eb543000000b002770f0a742bsm1159037ljn.41.2022.11.28.00.34.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 00:34:53 -0800 (PST)
Message-ID: <f6bb5759-453b-fa05-c6e1-f1d57abeaffa@linaro.org>
Date:   Mon, 28 Nov 2022 09:34:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 1/2] dt-bindings: arm: qcom: Document oneplus,bacon device
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Luca Weiss <luca@z3ntu.xyz>, linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221127181835.806410-1-luca@z3ntu.xyz>
 <CAA8EJpoe09FZcfVXuknmFWO5qg-iYDOBVN3=qr=DeJjvHw56Mw@mail.gmail.com>
 <f0a15b01-81b6-5c73-6c35-ce3a8c71b4ad@linaro.org>
 <CAA8EJppEXpv-wVAAXhZ6NiPzDGzP+evnKrT=an5esOx610D+dw@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAA8EJppEXpv-wVAAXhZ6NiPzDGzP+evnKrT=an5esOx610D+dw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/11/2022 22:43, Dmitry Baryshkov wrote:
> On Sun, 27 Nov 2022 at 23:30, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 27/11/2022 22:25, Dmitry Baryshkov wrote:
>>> On Sun, 27 Nov 2022 at 20:19, Luca Weiss <luca@z3ntu.xyz> wrote:
>>>>
>>>> Document the OnePlus One ("bacon") which is a smartphone based on the
>>>> Snapdragon 801 SoC.
>>>>
>>>> Also allow msm8974 devices to use qcom,msm-id and qcom,board-id.
>>>
>>> The patch itself is good. However it raised a broader question for me.
>>> Up to now all msm8974pro devices use qcom,msm8974 as a top-level
>>> compatibility string. Should it be changed to use pro-specific one
>>> (e.g. qcom,msm8974pro)?
>>
>> Yes, makes sense.
> 
> Would you make the patch?

I do not plan to. I don't know which ones are Pro which aren't.

Best regards,
Krzysztof

