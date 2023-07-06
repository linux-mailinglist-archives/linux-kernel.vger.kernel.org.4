Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7044974A0D8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 17:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233559AbjGFPXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 11:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233278AbjGFPWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 11:22:52 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 505A01997
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 08:22:50 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4fb863edcb6so1243102e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 08:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688656968; x=1691248968;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WLDwx5tYXULZ7iwRh5vsxvhGwQg4ReHP1YmuaIqwW+E=;
        b=SDe2oZscSliBoW/Dyy+fqfpgXh2r80xl7bt8ehDYz96nqZ47X5o7+vmmBaI5HuLCMY
         oONjTYFjoj5Qx55KMlLw/NPQYav5plXtXatbyXvMxRCL+t5x+c2LEqYVPpY5F2IuCY0y
         3ebG+XVBTFbQQMOo7xeSF+i56QeTu9bAB4SiCfCSmFp6vNklgoJJzK4xA0K/A71bHns3
         kCgNh/vtird/jioEtgCDL2ytgI/w/de8DIr+UzYIhObOs9ymn3B0xcB/sY7noiex8oUA
         Vp60NMRHBPkJBIvHahNCyPF4uZboty7xHrAvFiLISDLr2mdD4FcLsv1zTi/MIFKckfq9
         a9tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688656968; x=1691248968;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WLDwx5tYXULZ7iwRh5vsxvhGwQg4ReHP1YmuaIqwW+E=;
        b=iuj0a7Plwu+k6wpf/mnpQMutUeJgj3BbJu/jgDZtsH1R8V4z2lXH7K6EKNFciA5bY8
         sLDlv1RBt/9W1eftAEi9kIGNB8iaYqb1nOH1J/9E5GhdXP2UXIJ8UYovKxkWasVxelfs
         kQmwP8jHGbB2Z/nIJuvkSDVb5hfQypkQJKdAl8jOPtKIq0axZbVuFe/LYaDjs/pxuyz9
         MKwJKe6RytzL/Vs7qqeMNi04Vgn84xSh/ChcIRwH2FQ9uiea0ao8f6eaGD2UihFPqznl
         hzwqj8rmwwEfB6WblkAkptr6qvLiAYgm5ERozCZGCRoavFohTP7qSfBqZuV+Qd/wf/oc
         byJQ==
X-Gm-Message-State: ABy/qLZOmaiPEth7jLERCHrQJn3C73Xprs/frUIaJIyjgbkG3lbj5z/I
        TPAYpydKKKm9eqm/8m4S59HneA==
X-Google-Smtp-Source: APBJJlFn/kZ1GF96lP0K6eJGbdHL5705joKo40xM1P5VZyngJEbnKGTMosEsG0pNFyumxl2JNkxETA==
X-Received: by 2002:a05:6512:3da8:b0:4fb:8b2a:a4af with SMTP id k40-20020a0565123da800b004fb8b2aa4afmr2281694lfv.2.1688656968504;
        Thu, 06 Jul 2023 08:22:48 -0700 (PDT)
Received: from [192.168.1.101] (abyj26.neoplus.adsl.tpnet.pl. [83.9.29.26])
        by smtp.gmail.com with ESMTPSA id j16-20020a19f510000000b004fb75943ab3sm291805lfb.258.2023.07.06.08.22.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jul 2023 08:22:48 -0700 (PDT)
Message-ID: <d9b08d1b-17b2-00ad-6ffb-c1641eb2cb6f@linaro.org>
Date:   Thu, 6 Jul 2023 17:22:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/3] dt-bindings: power: rpmpd: Add Generic RPM(h) PD
 indexes
Content-Language: en-US
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>,
        Pavan Kondeti <quic_pkondeti@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1688647793-20950-1-git-send-email-quic_rohiagar@quicinc.com>
 <1688647793-20950-2-git-send-email-quic_rohiagar@quicinc.com>
 <35b6b086-9b03-49df-b80d-863218b42fae@quicinc.com>
 <a6241054-0f66-53c4-af59-31ceca13bf7c@quicinc.com>
 <b7376555-3ffd-3587-bc91-6c407c43e72e@linaro.org>
 <2d0b3769-ca87-3e18-160d-604c24fac52d@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <2d0b3769-ca87-3e18-160d-604c24fac52d@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6.07.2023 17:15, Rohit Agarwal wrote:
> 
> On 7/6/2023 8:30 PM, Konrad Dybcio wrote:
>> On 6.07.2023 16:47, Rohit Agarwal wrote:
>>> On 7/6/2023 8:00 PM, Pavan Kondeti wrote:
>>>> On Thu, Jul 06, 2023 at 06:19:51PM +0530, Rohit Agarwal wrote:
>>>>> Add Generic RPM(h) Power Domain indexes that can be used
>>>>> for all the Qualcomm SoC henceforth.
>>>>>
>>>>> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
>>>>> Suggested-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>>> Does it make sense to give this link [1] so that we know what is
>>>> Konrad's suggestion and the discussion around it?
>>>>
>>>> [1]
>>>> https://lore.kernel.org/all/0d468d08-6410-e424-b4f3-5245cdb0334a@linaro.org/
>>> Yes, could be given in the cover letter.
>>>>> ---
>> [...]
>>
>>>>> +#define RPMPD_VDDMD        22
>>>>> +#define RPMPD_VDDMD_AO        23
>>>>> +#define RPMPD_LPICX_VFL        24
>>>>> +#define RPMPD_LPIMX_VFL        25
>>>>> +
>>>> How did you come up with this list? A union of all SoCs supported by
>>>> RPMh driver?
>>> Yes, union of all the SoCs and arranged based on frequencies of usage.
>> The latter part is very thoughtful, thanks for taking that into account.
>>
>> That said (and I really don't wanna be picky here, I'm just coming up with
>> ideas a bit later than I'd like to).. Perhaps this patch should be limited
>> to RPMhPD [1] and the definitions could be moved to a new binding, so:
> So should we not update anything in this old binding and completely move to the new bindings?
Yes, create qcom,rpmhpd.h and add new common entries there and let this
ship sink

> rpmhpd.h?
> Not even rpmpd_* bindings?
Again, due to [1], let's not touch that for now. We'll worry about that
when somebody will try to add a new entry to that driver.

Konrad
> 
> Thanks,
> Rohit.
>> include/dt-bindings/power/qcom,rpmhpd.h
>> // this way we don't have to add RPMHPD_
>> #define CX    0
> Ok, will remove this as well.
>> which would result in us being able to do:
>>
>> #include ....rpmhpd.h
>> [...]
>> power-domains = <&rpmhpd CX>;
>>
>> in the device tree
>>
>> which is even more concise!
> 
> Yes
> 
> Thanks,
> Rohit.
> 
>>
>> [1] The old RPM SMD platforms have some duplications in the names..
>>      No point in duplicating that. The oldest entries remember 2013 so
>>      it's easy to see how we had some dirt build up there.
>>
>> Konrad
>>> Thanks,
>>> Rohit.
>>>>>    /* SA8775P Power Domain Indexes */
>>>>>    #define SA8775P_CX    0
>>>>>    #define SA8775P_CX_AO    1
>>>>> -- 
>>>>> 2.7.4
>>>>>
>>>> Thanks,
>>>> Pavan
