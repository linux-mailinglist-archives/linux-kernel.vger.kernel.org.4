Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6842467D036
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 16:29:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbjAZP3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 10:29:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232013AbjAZP3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 10:29:41 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1614E45F44
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 07:29:40 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id bg13-20020a05600c3c8d00b003d9712b29d2so3475984wmb.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 07:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=36ptyI51QZl1lF0nXOH5sL81j6kCyJc2TJBHKS4gWCY=;
        b=ti7BQ89IH6jJGhHpbHQdRCviihGgD/O4MfHqO/tKxDoljbNkfMKLwMGO32ru3TM0lm
         ovKQ9fu57Y0VMY5EU1kjTl6/2iSLw4Im048aPwViQUjY+rdRV2Fr77ONVFzr002UmHjz
         RRHTbY34rEMX53EZJrvhVWKesoZxCT0m0piLM5kBDA5WO5xzkhzAgD2AaEBzSjQKycjw
         chwY6xjlB5V33vlACNpaLMGq0iPoYf+N5AvlZ1lyjRNXdEwmvwVXSS5mvFQYH60yD1G3
         U3EQySr2J0kRXQ3H1Uxqz7glbhzC8BHnbCh/a1MjKljXT3r01h5YwiXTQiiFGXBJqVL7
         A4XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=36ptyI51QZl1lF0nXOH5sL81j6kCyJc2TJBHKS4gWCY=;
        b=jE8BY0yqI7g2wqGxAm1FOR/WTPaIPSRIhQMU0uPYwZFZraYwITJSXn7j2+UdbR4kVf
         EDkoET2NQH+9wPBzpAccho4FCP6lAZhpo7usj9lsom/nwKCdKUMIDre1bsHWEw+0d0vv
         9qC2eHGrjOif8MKo4hC7Ar7RFQHoZYLnJAI7BY/1R8Dx5JrCzorJcm4ow8qPpzb+V3ul
         sSuHBmmjeuFHS+dvwC2fgS50ar/6gTyusbxcCl3poXm5zREQmrbAIO0NYXKcb1d9gPZS
         O+g/iTMdfF283cyonl/yrKdU+Barnw8hh7RzrMKAHZ2qmffXKhTDyVXfKN/OLSd/zuDs
         +RDw==
X-Gm-Message-State: AFqh2koEAQ0ysoDqaUvGYeXc69ycqxpVDRxWH/lCRFtpoQdWLF8dcxs1
        GrPtm2Zsue5smuMV7nF+OLm8Lw==
X-Google-Smtp-Source: AMrXdXvcSThOnYqAUTMGMUEcUGsCBnqaWIcnrIeb6n+jrCvIwnFbBOnDt+bNl7lZP/hCUF3r+3HA/A==
X-Received: by 2002:a05:600c:1508:b0:3d3:5166:2da4 with SMTP id b8-20020a05600c150800b003d351662da4mr35819772wmg.8.1674746978603;
        Thu, 26 Jan 2023 07:29:38 -0800 (PST)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id g12-20020a05600c310c00b003db012d49b7sm11437669wmo.2.2023.01.26.07.29.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jan 2023 07:29:38 -0800 (PST)
Message-ID: <87192098-b7f4-060f-9274-933d974c0a7d@linaro.org>
Date:   Thu, 26 Jan 2023 15:29:36 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v4 0/6] Add MSM8939 SoC support with two devices
Content-Language: en-US
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        djakov@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, benl@squareup.com,
        shawn.guo@linaro.org, fabien.parent@linaro.org, leo.yan@linaro.org,
        dmitry.baryshkov@linaro.org
References: <20230123023127.1186619-1-bryan.odonoghue@linaro.org>
 <42baa874-c926-9111-b0b3-2df2562d8de6@linaro.org>
 <Y86CPmgvAi+kChQI@gerhold.net>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <Y86CPmgvAi+kChQI@gerhold.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/01/2023 12:49, Stephan Gerhold wrote:
>> - Adds gcc dsi1pll and dsi1pllbyte to gcc clock list.
>>    Reviewing the silicon documentation we see dsi0_phy_pll is used to clock
>>    GCC_BYTE1_CFG_RCGR : SRC_SEL
>>    Root Source Select
>>    000 : cxo
>>    001 : dsi0_phy_pll_out_byteclk
>>    010 : GPLL0_OUT_AUX
>>    011 : gnd
>>    100 : gnd
>>    101 : gnd
>>    110 : gnd
>>    111 : reserved - Stephan/Bryan
>>
> I'm confused. Are you not contradicting yourself here? You say that
> dsi0_phy_pll (dsi ZERO) is used to clock GCC_BYTE1_CFG_RCGR. Then why
> do you add dsi1_phy_pll (dsi ONE) to the gcc clock list?

So my understanding of the clock tree here is that 
dsi0_phy_pll_out_byteclk is a legacy name.

Its perfectly possible to have DSI0 and DSI0_PHY switched off and to 
have DSI1/DSI1_PHY operable.

dsi0_phy_pll_out_byteclk is perhaps an unfortunate name and probably 
should have been renamed.

> To me this looks like a confirmation of what downstream does, that both
> DSI byte clocks are actually sourced from the dsi0_phy and the PLL of

A better name would have been dsiX_phy_pll_out_byteclk.

---
bod
