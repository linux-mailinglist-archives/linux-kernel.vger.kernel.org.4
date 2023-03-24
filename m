Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6776B6C789D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 08:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbjCXHPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 03:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231589AbjCXHPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 03:15:02 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA6613D5D
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 00:14:55 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id w9so4216084edc.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 00:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679642093;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lUhNXXr7A3jN6EIrBJGqjsnZ6lNCOb7chI6KB9f+Qzw=;
        b=DvkcEHL7sfJp5nyGwfQXhZIzbPqHJ2tgKVhJG0bvdGR5rZxiA+izn69O/NyBK6+aRr
         7HN0GmhfMOM5kDVJO/SvbwwHz2AxaHneVdWbIc72Fj5DfCJfIIi5otJL9nPMvw6JHs+H
         zNrj9gUzVDr4hB76WdN7oI1n5lV7HyMzyZ+pz/KfmEGBtyb5yPwlh2btVYRQBH3gf/wI
         b1j6ynTNxkkYK5H37jEiEnCf/KRiVglyOC1ORa8FeTIjZYT/BIFiYm+gnw3eNehgczQ+
         xdn2JW5zypIj6yEPgLReOkTmdvjcuTPT6eprUijdzprUD+UjaqhWMPToMs6Z7imtX99S
         PVhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679642093;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lUhNXXr7A3jN6EIrBJGqjsnZ6lNCOb7chI6KB9f+Qzw=;
        b=p2YyL70LOVM2nYQleQadT7IbOKTm1AOKKiO2OQvB+Fe5f1Yz/I12c6WG6rsWWbtXNV
         V6fnik05b8ac0zrXNhLAxvNChi9Jnk+/2yB+uDDntb0SuQsNJGhsOeY3mKN65PVTSh8y
         a3nlmm9pqTl5q84G5wFOANEqmrRcJLeEg0Q0m92LabKp9ML9MhlxYQkYsHhL0H4QDG9P
         QIh5VKxOnoxGYne/dBRgsSBflSMpnRb5aq91xFxtR/+iNhgT6RdAObgl2zCi4Cehs+nX
         XmaznDf63TGL8vL6rizqKj5+UoiMfefCPh1nZIE+f4ZxrAyvQNaOP5tpW4m2o9qDGBTS
         rp3g==
X-Gm-Message-State: AAQBX9faX7J1UWvyS7Mxq85xXTRULIVC2AKu/KXe7Skk2ACLlu5Ppmnj
        iI1wXqnRtLCfXGSWLO2ai6As2A==
X-Google-Smtp-Source: AKy350b6WMNA4lV20pB+fdL6d88YIA6NDpZMazgO5ptPxkVcwzyA4h+XyOijzec6QH4ptv+ha13hug==
X-Received: by 2002:a17:907:75dc:b0:932:66ca:faf4 with SMTP id jl28-20020a17090775dc00b0093266cafaf4mr2089685ejc.54.1679642093584;
        Fri, 24 Mar 2023 00:14:53 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:ce50:243f:54cc:5373? ([2a02:810d:15c0:828:ce50:243f:54cc:5373])
        by smtp.gmail.com with ESMTPSA id z8-20020a17090655c800b00930569e6910sm9965176ejp.16.2023.03.24.00.14.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Mar 2023 00:14:53 -0700 (PDT)
Message-ID: <213b18de-3d99-33e1-6089-71c2fa4d3c47@linaro.org>
Date:   Fri, 24 Mar 2023 08:14:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 7/8] arm64: dts: qcom: sm8450: remove invalid reg-names
 from ufs node
Content-Language: en-US
To:     Eric Biggers <ebiggers@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lee Jones <lee@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-scsi@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
References: <20230323-topic-sm8450-upstream-dt-bindings-fixes-v1-0-3ead1e418fe4@linaro.org>
 <20230323-topic-sm8450-upstream-dt-bindings-fixes-v1-7-3ead1e418fe4@linaro.org>
 <9614782e-0d78-e8f2-a438-452cfa86f80b@linaro.org>
 <316d7d7d-b370-36e1-648a-400447d2dd47@linaro.org>
 <20230324065247.GA9598@sol.localdomain>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230324065247.GA9598@sol.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/03/2023 07:52, Eric Biggers wrote:
> Hi Neil,
> 
> On Thu, Mar 23, 2023 at 02:10:44PM +0100, Neil Armstrong wrote:
>> Hi,
>>
>> On 23/03/2023 11:49, Krzysztof Kozlowski wrote:
>>> On 23/03/2023 11:25, Neil Armstrong wrote:
>>>> Fixes the following DT bindings check error:
>>>> ufshc@1d84000: Unevaluated properties are not allowed ('reg-names' was unexpected)
>>>>
>>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>>>> ---
>>>>   arch/arm64/boot/dts/qcom/sm8450.dtsi | 1 -
>>>>   1 file changed, 1 deletion(-)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
>>>> index ef9bae2e6acc..8ecc48c7c5ef 100644
>>>> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
>>>> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
>>>> @@ -3996,7 +3996,6 @@ ufs_mem_hc: ufshc@1d84000 {
>>>>   				     "jedec,ufs-2.0";
>>>>   			reg = <0 0x01d84000 0 0x3000>,
>>>>   			      <0 0x01d88000 0 0x8000>;
>>>> -			reg-names = "std", "ice";
>>>
>>> This is also part of:
>>> https://lore.kernel.org/linux-arm-msm/20230308155838.1094920-8-abel.vesa@linaro.org/#Z31arch:arm64:boot:dts:qcom:sm8450.dtsi
>>> but I actually wonder whether you just missed some binding patch?
>>
>> I'm aware of Abel's RFC patchset to support shared ICE, but this is a cleanup of the current DT,
>> and the current bindings schema doesn't document reg-names.
>>
> 
> The ufs-qcom driver accesses the "ice" registers by name, so the reg-names can't
> be removed from the device tree.  A few months ago there was a patch to fix the
> device tree schema for qcom,ufs to include the reg-names.  It looks like that
> patch got missed, though:
> https://lore.kernel.org/r/20221209-dt-binding-ufs-v2-2-dc7a04699579@fairphone.com

Exactly. This is why I never saw these warnings.

Neil, there are a lot of pending patches, so you need to be sure you run
dtbs_check with them applied.

Best regards,
Krzysztof

