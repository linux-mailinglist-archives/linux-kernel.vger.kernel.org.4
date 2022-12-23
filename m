Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D377654D17
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 08:58:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235987AbiLWH6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 02:58:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235977AbiLWH56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 02:57:58 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E351131DCB
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 23:57:36 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id u12so541889ljj.11
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 23:57:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zBvQKOto+vmplvuOPy0PMGPzXwMlPMKtXIbJlmwmhJM=;
        b=hXvibYBkLGjTrJYbsFqKhXLOegd4W20iLdjD3iKt01q1zPltmfjZY8kX+oOr8XLO5Y
         LpdkD//YhwUuB5g0E1vllQlEFb61gRUI3OKL1z4E9UuCAWbSEuByLrEUpa1+crvaugV4
         v8m9+iz35sStKAUq4inDeaI6AVbvGxu1r0p+HjAIq31Uw9Q4XJbtj6xK5Z7Pn1lx+RiB
         kOUoZnU6h0sLNpwcJUp18PRU8gGMrcGF0xqm7aMS6YDVFl/qDOy/qf6WhuCHSIlIpqrD
         UM4t4L1sKbP+/1oOucr3Hryzx4Srk3FFC2Vg4Tz70g4If7xafsB/VPOirUUMTmbTcn9C
         Q+cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zBvQKOto+vmplvuOPy0PMGPzXwMlPMKtXIbJlmwmhJM=;
        b=LbJ0fPZ/Amg776L2+qwo/BVR+duNeutXSlw6njlN0jiWqapUTR+7HPFje8xMtl/8+z
         xFaq3rdiyxpoHuDRFEX4UK/R1G9QumObPS2sKE+bfWIDkhwSbV7dwLUtPCouSoppdurJ
         FSVBpiMnhWJMiMtsBGGh9uBCEbV4YI/qmfsx5n3o9KETHS99NWuopWIcAhCccOhWYrs7
         lB2QszwKpBXPMFZ2GcpRJwNUzaX0o5D/xQC2nTpm0kEHIbPtWwJYUWtLd6T18/L3dvi6
         g15LbA5tnyQraNowDWtME27fHZBACvZzfR21P0DH2hJW10SXBeaVBpDW81aR9lKPVHIW
         1Huw==
X-Gm-Message-State: AFqh2kr5goTxnIrI1ZkVeui9qzSJsAq+g5byJCfmdoWju0nz8E5Ty+GI
        3nLpN20BQhteA5/V4uTamL4Pqw==
X-Google-Smtp-Source: AMrXdXsZDZ5XmTLs7XUsj5QJeRBTIPRou5NU5Myhiv5VfkgR31vazIcUFlwh0ULYxb6j2gSaFSMQRA==
X-Received: by 2002:a05:651c:b94:b0:277:3b1:7017 with SMTP id bg20-20020a05651c0b9400b0027703b17017mr3520368ljb.33.1671782255306;
        Thu, 22 Dec 2022 23:57:35 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id e3-20020a2e8183000000b002778d482800sm306576ljg.59.2022.12.22.23.57.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Dec 2022 23:57:34 -0800 (PST)
Message-ID: <f8ed0927-a97e-9395-1297-addb57ecd855@linaro.org>
Date:   Fri, 23 Dec 2022 08:57:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v14 1/5] arm64: dts: qcom: add data-lanes and
 link-freuencies into dp_out endpoint
Content-Language: en-US
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>,
        dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, agross@kernel.org,
        dmitry.baryshkov@linaro.org, andersson@kernel.org,
        konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        airlied@gmail.com
Cc:     quic_abhinavk@quicinc.com, quic_sbillaka@quicinc.com,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1671217893-17496-1-git-send-email-quic_khsieh@quicinc.com>
 <1671217893-17496-2-git-send-email-quic_khsieh@quicinc.com>
 <1a5cc3d3-ac2d-52c8-79f4-b13252a4bb86@linaro.org>
 <54bd8b85-8b68-4b28-ec68-28edf9a8a097@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <54bd8b85-8b68-4b28-ec68-28edf9a8a097@quicinc.com>
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

On 22/12/2022 17:22, Kuogee Hsieh wrote:
> 
> On 12/22/2022 2:47 AM, Krzysztof Kozlowski wrote:
>> On 16/12/2022 20:11, Kuogee Hsieh wrote:
>>> Move data-lanes property from mdss_dp node to dp_out endpoint. Also
>>> add link-frequencies property into dp_out endpoint as well. The last
>>> frequency specified at link-frequencies will be the max link rate
>>> supported by DP.
>>>
>>> Changes in v5:
>>> -- revert changes at sc7180.dtsi and sc7280.dtsi
>>> -- add &dp_out to sc7180-trogdor.dtsi and sc7280-herobrine.dtsi
>>>
>>> Changes in v6:
>>> -- add data-lanes and link-frequencies to yaml
>>>
>>> Changes in v7:
>>> -- change 160000000 to 1620000000
>>> -- separate yaml to different patch
>>>
>>> Changes in v8:
>>> -- correct Bjorn mail address to kernel.org
>>>
>>> Changes in v9:
>>> -- use symbol rate (hz) for link-frequencies at dp_out at sc7180_trogdor.dtsi
>>>
>>> Changes in v13:
>>> -- delete an extra space at data-lanes
>>>
>>> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
>>> ---
>>>   arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi   | 6 +++++-
>>>   arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi | 4 ++++
>>>   2 files changed, 9 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
>>> index eae22e6..e2783dd 100644
>>> --- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
>>> @@ -814,7 +814,11 @@ hp_i2c: &i2c9 {
>>>   	status = "okay";
>>>   	pinctrl-names = "default";
>>>   	pinctrl-0 = <&dp_hot_plug_det>;
>>> -	data-lanes = <0 1>;
>>> +};
>>> +
>>> +&dp_out {
>>> +    data-lanes = <0 1>;
>>> +    link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000>;
>> Messed order of nodes.
> 
> can you please give me more details and how should i fixed it?

Node overrides/extends are more or less ordered by name. dp should not
be around mdp, but for example dsi.

Best regards,
Krzysztof

