Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E64F06D5C95
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 12:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234251AbjDDKEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 06:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233594AbjDDKEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 06:04:22 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 671391BD0
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 03:04:21 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id eg48so128192670edb.13
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 03:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680602660;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TKymJL3ZS/VQPdBDvCI45/oFF+qLRLulQyUOz54fv4A=;
        b=Vgh76H/QH+buPHA4URB3wzXuozyX0vjXFkKfUrRA8usWE5pe5RO8E2s9b2vrO5WxhM
         EJLYA5gdtVxOZDCAbkljk8iPMLvTrDnBvqimUFUJO6znJFcNFyGu8jEGxL9cyWU+I0fB
         vcgSf3augSaizOKJxbjluQxlh11DrE9gqfKHRHgbhmNEkwrhBDUneMyuFKxpRapqDjqj
         N5Ljk3QMXbNWzbP13+KFNDLsGRVUIRxZhnCmysbkIuuO5tmOYR0wXARobyWgeJw51dFl
         IPnkC6nxp7TmGhEKqKDBmZ9+AZJDZpIjKQhvog5qY4WJwlkJ/V8pybXjvLBjajzLjKjC
         tDiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680602660;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TKymJL3ZS/VQPdBDvCI45/oFF+qLRLulQyUOz54fv4A=;
        b=PdHpQ9vKlLEVTOBkPqDpr2/ee+VbaSRUMbKwU3k3c5Ux5nRhkGPk7JmJCI+110ZtuH
         FYGlEf0CVtulir4tjKOaDh4IWqpO3p7pVCwSg/7upi7xz4Fwbv2L0cV6tkjVdDthx9p6
         TsvzpYknmDkimp4ea8YDIo1dNiOcBsU/pO/yeVlUzWe+9leZqUBnpwOMz5WAdyVpwkxN
         CF+3XJ4Zer5LGlcuLtJPKwpfwWCLYps5xmwmZIE/TynJ9BEW163BwzFR+kihbivMakzj
         0/Q/WRL8btLY8wrV5pYyztvNxpE9WAdo/POhjykUPVVxUMBnpxBeFXbVNTntA6NyKUMm
         PXMw==
X-Gm-Message-State: AAQBX9dI5HOd9Get0Qe6EZhNYIQ5uXQ7/U0Mmt9tpeeEVJdUrJyhSxTZ
        PgdHd0n34zVZ6iL7TAhrC5jzDw==
X-Google-Smtp-Source: AKy350YrXrrHhi9Qq2TSsZ9KTRvIeI2WfuMgWdIw0BoB/fM6z8A1DvSprNkv0RtV56E0L20rAXZmCA==
X-Received: by 2002:a17:907:76ea:b0:933:3b2e:6016 with SMTP id kg10-20020a17090776ea00b009333b2e6016mr1735746ejc.7.1680602659903;
        Tue, 04 Apr 2023 03:04:19 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:99ed:4575:6001:8bda? ([2a02:810d:15c0:828:99ed:4575:6001:8bda])
        by smtp.gmail.com with ESMTPSA id q18-20020a170906941200b009316783c92csm5812177ejx.12.2023.04.04.03.04.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Apr 2023 03:04:19 -0700 (PDT)
Message-ID: <15d590ac-0b50-4190-4e27-d8912e2f66ec@linaro.org>
Date:   Tue, 4 Apr 2023 12:04:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 8/9] arm64: dts: qcom: qcm2290: Add WCN3990 Wi-Fi node
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Robert Marko <robimarko@gmail.com>,
        Das Srinagesh <quic_gurus@quicinc.com>
Cc:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230403-topic-rb1_qcm-v1-0-ca849b62ba07@linaro.org>
 <20230403-topic-rb1_qcm-v1-8-ca849b62ba07@linaro.org>
 <4816461e-38b7-ba79-dd64-859fa0ee808e@linaro.org>
 <a295af57-f8d1-35c2-77e8-7d29d043e47e@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <a295af57-f8d1-35c2-77e8-7d29d043e47e@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/04/2023 11:55, Konrad Dybcio wrote:
> 
> 
> On 4.04.2023 08:08, Krzysztof Kozlowski wrote:
>> On 03/04/2023 19:36, Konrad Dybcio wrote:
>>> Add a node for the ATH10K SNoC-managed WCN3990 Wi-Fi.
>>>
>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>> ---
>>
>> We had these talks a lot... All these 3-8 patches should be two patches:
>> 1. SoC DTSI
>> 2. Board DTS.
>>
>> Splitting superficially patchset on initial submission does not make
>> sense. If you sent it in separate patchsets during development - release
>> early, release often - then of course it would be fine. But hoarding
>> patches till everything is ready is not the approach we want (and we
>> made it clear that SM8550 should be the last such platform)
> That wasn't my intention.
> 
> This patchset is "feature-rich", as it piggybacks off of Shawn and Loic
> having submitted the driver parts long long ago and SM6115 being quite
> well-supported (and almost identical to the QCM). Patches 4-8 were not
> "held hostage" waiting for full fat platform enablement, but were
> essentially "copy-paste, adjust, verify" and that does not require a
> lot of manpower or time.. I split them to ease the review (~850 LoC @
> PATCH 3, ~1900 LoC @ PATCH 8).
> 
> In any case, the fact that there's so many features submitted with
> the initial posting is not related to me holding onto them on
> purpose, they were created together, probably within 20 minutes of
> each other.. This should have been posted a long time ago with even
> more things (like regulators), but there's been some communication
> issues with Qualcomm..
> 
> LMK how you want me to proceed with this.

All these 3-8 patches should be two patches. If you have separate PMIC,
then could be three patches.

Best regards,
Krzysztof

