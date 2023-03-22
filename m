Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 059F46C450F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 09:35:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbjCVIfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 04:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbjCVIew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 04:34:52 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB0ED3B228
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 01:34:50 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id e21so5463661ljn.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 01:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679474089;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U58SQGAdB8WZgcTHG2Lfm70EP6ZtZM71YzBDDEdpTSc=;
        b=R/BVpWHxX1lMprKKvnlFrPRzGgs5Qf3AUJYCzO0arLRbK4GZtrvmsWaBx1R2jzQTfh
         gtCXetN6xxRFENuzL+7QszCpDpz1Kk4PGsFAbrN0cVV4zWTd4jlYccQ8fP8d6xq/qquQ
         MfD6YBkQOTLWxtxW1Jh4+6LXmZXcp+Rgdt7nelYsOBXncd+fcqLyW4TGpTSTqRKOdFof
         Z3LpfVGsbjQxj703MYcy2Sgntm/c9G21lioHnM6Ey8aPXbqMcCDvW95GiJKVNvfQTm4Q
         dVim8DLIwqVunke1dh7XzXcCQ2LHV4fde8d+z1lm9U2VSoMAk81+gZgMjpp83lStU+Ds
         +FqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679474089;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U58SQGAdB8WZgcTHG2Lfm70EP6ZtZM71YzBDDEdpTSc=;
        b=tsR9Gw2Bt6ctpMwem0dTyboBWbKHMCGhH4nlXM0N35LG3ibde6tl+yPHVgkZ6+yp3v
         b8k3KqEk6OqzVLc1dIJ/IpYgKee/m/kUjrC03eGZHJuOYsVsu3WEGcZpGw8asBy+8rlg
         DMd7R1OuktJhtlBSBIfAqLknP729kpGQFAju/WUL/7DJdSR0mfl9vcr+JNkm2QfaZwSl
         FTPaA76rizaygPkzjkNEAxWQPE9NcUqhxMuHBHZ0eEJapcyhxk82Y6Ie1KtTBjp4IHfz
         n0PLGaPOFJu0OCdBso5ZhVQ0CGK2fTfi7TBTLl9zP8DsNuXr81M7QqAMiV3YtCp7gtzg
         d1AQ==
X-Gm-Message-State: AO0yUKVcKK2WcGx9/jO3Z49cVJ5bO0smCzTLsLkxrlJcr/SMzA1z9fyb
        JDUP0tm+hJXmkkcIQKF/T9YidA==
X-Google-Smtp-Source: AK7set8A3jBP6Uv2xqAXq8eF3WXNWxl0CTW0wfvZOq126nqhhSgtxnWkZYplG2AuUcfmhQ55S9dyEg==
X-Received: by 2002:a2e:9c84:0:b0:298:97d7:8fc3 with SMTP id x4-20020a2e9c84000000b0029897d78fc3mr1881970lji.4.1679474089137;
        Wed, 22 Mar 2023 01:34:49 -0700 (PDT)
Received: from [192.168.1.101] (abym238.neoplus.adsl.tpnet.pl. [83.9.32.238])
        by smtp.gmail.com with ESMTPSA id a17-20020a2eb171000000b0029bcfada416sm1918799ljm.138.2023.03.22.01.34.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 01:34:48 -0700 (PDT)
Message-ID: <e121d58d-831a-f593-b933-5177d3d26c43@linaro.org>
Date:   Wed, 22 Mar 2023 09:34:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 0/5] arm64: dts: qcom: Enable Crypto Engine for a few
 Qualcomm SoCs
Content-Language: en-US
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, agross@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        andersson@kernel.org, bhupesh.linux@gmail.com,
        krzysztof.kozlowski@linaro.org, robh+dt@kernel.org,
        vladimir.zapolskiy@linaro.org, rfoss@kernel.org
References: <20230321190118.3327360-1-bhupesh.sharma@linaro.org>
 <41111f93-ef02-0e57-98af-01327213d854@linaro.org>
 <CAH=2NtziWx2g_4K92iH+9DLo8XV0P32NNnEpxy6f0G_dQOVs+Q@mail.gmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <CAH=2NtziWx2g_4K92iH+9DLo8XV0P32NNnEpxy6f0G_dQOVs+Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22.03.2023 09:33, Bhupesh Sharma wrote:
> On Wed, 22 Mar 2023 at 00:57, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>>
>>
>>
>> On 21.03.2023 20:01, Bhupesh Sharma wrote:
>>> This patchset enables Crypto Engine support for Qualcomm SoCs like
>>> SM6115, SM8150, SM8250 and SM8350.
>>>
>>> While at it, also fix the compatible string for BAM DMA engine
>>> used in sdm845.dtsi
>>>
>>> Note that:
>>> - SM8250 crypto engine patch utilizes the work already done by myself and
>>>   Vladimir.
>>> - SM8350 crypto engine patch utilizes the work already done by Robert.
>>>
>>> This patchset depends on the dt-bindings patch which added support for
>>> SM6115 and QCS2290 SoCs:
>>> https://lore.kernel.org/linux-arm-msm/20230321184811.3325725-1-bhupesh.sharma@linaro.org/
>> You could have included that one here for easier tracking!
> 
> Err.. the dt-binding maintainers have been asking to split the
> dt-binding patches from
> the dts ones in the past.
Quite the opposite!

So, let's stick to that for now :)


Konrad
> 
> Thanks.
> 
>>> Also this patchset is rebased on linux-next/master.
>>>
>>> Bhupesh Sharma (5):
>>>   arm64: dts: qcom: sdm845: Fix the BAM DMA engine compatible string
>>>   arm64: dts: qcom: sm6115: Add Crypto Engine support
>>>   arm64: dts: qcom: sm8150: Add Crypto Engine support
>>>   arm64: dts: qcom: sm8250: Add Crypto Engine support
>>>   arm64: dts: qcom: sm8350: Add Crypto Engine support
>>>
>>>  arch/arm64/boot/dts/qcom/sdm845.dtsi |  2 +-
>>>  arch/arm64/boot/dts/qcom/sm6115.dtsi | 26 ++++++++++++++++++++++++++
>>>  arch/arm64/boot/dts/qcom/sm8150.dtsi | 26 ++++++++++++++++++++++++++
>>>  arch/arm64/boot/dts/qcom/sm8250.dtsi | 26 ++++++++++++++++++++++++++
>>>  arch/arm64/boot/dts/qcom/sm8350.dtsi | 26 ++++++++++++++++++++++++++
>>>  5 files changed, 105 insertions(+), 1 deletion(-)
>>>
