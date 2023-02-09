Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A647A690898
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 13:23:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjBIMXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 07:23:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjBIMW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 07:22:59 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADCDD125A8
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 04:22:58 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id l37-20020a05600c1d2500b003dfe46a9801so1415493wms.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 04:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LSnO37B34hy1pNZA6pCiDi9wzcXDsjOg5QyQA1q+Ms4=;
        b=OuLFbs3kk5PBuZV1uVbAjaYQdXyT2NX7mXCS04oJUM7Xa2FHT/XMcyVHEp78GSXeqy
         FrKWhvbBnZVt2Wbz+os/9+v8AieE0a8OwzrV318CBrG7YWWj949GfCH8ZbEae/HzQv4j
         hRy3A5oS5i3zzcgb1I7FYbijRH/9TUOdZFVXA+6czIvZGXSqb2NDPuTEQiGiRaBx01M8
         pYFvndv97Uce4pzf/VnPmRcNSk0qqFCbAEpRnjxgSQO7sb+IGlQ17fBxSoiM05f9Vufl
         /n0gtyi71PEFKQ0uuyTf1TpHHon9AKiFLc+cKm2HB33p2rM/77l42dvdPoejKImyb8I8
         3/sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LSnO37B34hy1pNZA6pCiDi9wzcXDsjOg5QyQA1q+Ms4=;
        b=ll/7jfLu1mu/rAejEFB1+81NT6JDlX8sg9YZcvWHoKGMxF0vtlQKyk460514Uba0MJ
         +UdERSW+4lzYT5VyfZIkgg3gf0aLSEZYxmg4+XPB4kfoKDhwPo634uS0UmDEEyk6rNc+
         uSUyJ4Rc4tol2X7toN0l7gJ84NpGBO3H9rlYZaGWBm6RMV07QQSDwyUK8yQS1rk8z9DS
         +KwCRgkzzCTMzU3Z5+ch/vvdKUrGBRDDR6w4x7nPULorMjs67PutxU6KHqrozGQ6au9d
         d8HSIbYLPJ4hbrYRdGde7+BMhoNQeiyuAIy0b3Y4xsx6GO8xtAHHkv6VJhPl+CktTumo
         hrNw==
X-Gm-Message-State: AO0yUKW97oLpxqplmxoY+bwjqfdYD4X2xSuBcQjN2OyH8ikZ1VKSOGWm
        ZhHN3LvNt+9IkqfhQqJ+75uCRw==
X-Google-Smtp-Source: AK7set8vBWfXVH0I3G7ClYmPs1n81MK1qNsDlSUnJEVAfy1Nyh+CRYkg6nzQx4o/eaCCvokyLt3ubw==
X-Received: by 2002:a05:600c:130f:b0:3cf:7197:e68a with SMTP id j15-20020a05600c130f00b003cf7197e68amr9902039wmf.18.1675945377311;
        Thu, 09 Feb 2023 04:22:57 -0800 (PST)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id t8-20020a7bc3c8000000b003e00c9888besm4850980wmj.30.2023.02.09.04.22.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Feb 2023 04:22:56 -0800 (PST)
Message-ID: <027268b7-4b04-f52e-06a8-9d924dc6efe4@linaro.org>
Date:   Thu, 9 Feb 2023 12:22:55 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH] arm64: dts: qcom: sdm845-db845c: Mark cont splash memory
 region as reserved
Content-Language: en-US
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        dt <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
References: <20230124182857.1524912-1-amit.pundir@linaro.org>
 <39751511-3f06-7c39-9c21-208d4c272113@linaro.org>
 <CAA8EJppLBuA08hkqTrZx_wwbtCxK9sAjv48c9_DxgPENgo7a8Q@mail.gmail.com>
 <1a840d88-e5b1-711c-b980-f57620c54472@linaro.org>
 <8508e3d5-7468-0b2f-5a43-7c439ecf2d8b@linaro.org>
 <CAMi1Hd2UNxXHUVWO-=sWh=-bVnrqE3UdLguFOq+62SfvUiEs0A@mail.gmail.com>
 <b2307e91-3373-539a-ecfb-e2542b9f83db@linaro.org>
 <ed737e67-eabc-6f29-b734-f4698767ca8e@linaro.org>
 <fa2e0db7-5b27-5a41-920b-b786dc4e521c@linaro.org>
In-Reply-To: <fa2e0db7-5b27-5a41-920b-b786dc4e521c@linaro.org>
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

On 09/02/2023 12:11, Bryan O'Donoghue wrote:
>> If the bootloader splash is enabled then this memory is used until the
>> DPU driver instructs MDP5 pipes to suck data from a newly assigned 
>> address,
>> so there's a short window where it is.
> 
> It seems a shame to reserve 30 something megabytes of memory for 
> continuous splash unless we are actually using it is my point.
> 
> If I'm running headless its just wasted memory.

Couldn't we

1. Find reserved continuous splash memory
2. Fee it in the MDP when we make the transition

It must be possible

---
bod
