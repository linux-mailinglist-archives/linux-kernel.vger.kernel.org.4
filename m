Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 817CE63BE33
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 11:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbiK2Kpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 05:45:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbiK2Kpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 05:45:46 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 265055C750
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 02:45:44 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id j16so21795121lfe.12
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 02:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EgaNiOtXbRukgfZTHYDievg/9LoIfCts6FSyl7+geOA=;
        b=NG/A1uow4JGf9cO5NMSIcSyo/8G36M0bbJyli+xfXvWIW8oIscCkIv4jy4YoQljIv9
         K1kvwcg2hAWKlL0PWRL8XPD8nE5PnnkQuTteqDX3NnvgtR7jmNC7pDcq+iGuddEPU+7N
         Q4/gLBtBRv1strAFK6Lj/wc3QSne39Hr0t3MDIQiAjXJr0a0P+nWtbjd/JDvn6BrSnhU
         QV85rkU0sAsfoU63NhsTmk4eZoXkr/7neZvjaZxxa1OKu0Pqy+ASztcu3QWkL2ILi6u8
         hU65ZJZ/11+mMy/vnQPdOHXp5mw/n956aXhdUAEqLiFo/w0mQA4lvlOXtcHyEXvT5C1G
         ZDaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EgaNiOtXbRukgfZTHYDievg/9LoIfCts6FSyl7+geOA=;
        b=lC4E5QHfmJTdLGe4hqIPFH2FXbQcIe9+ySY8lqnPNcDCcYR8lCifQaNFX4LIZigj1G
         JYSQVsoE68qpFLiSU81tpVHxY9g6zjtsuncat7dKsMhfBTrhM6TBFhz2G7u/m5p7KlGK
         EmIG1n2IJwk/Wr12/YH+oceHAtQg58jReV3GMG1mbaKlJnCOLxowtUaVUakm5OKPLntR
         Bjic6IuKFI8E2Xo6/ii4HgNs8S0tNJE8H3IiaAjmGfecuQ9KG61dVAEKsKYh5GEnppuH
         gY5+7gn9SPN9+MlBlztBPAPcE7SxPE1o4pkLfII5zC0mBMoz9FJu82xqZa5+NaaTlBfa
         4l7g==
X-Gm-Message-State: ANoB5pn/stoy0zKHh4yFkF6QjvL3iCKv9vRfFMCGPeCbpxMFjQtFJXuJ
        uR24yx5Ao1Aqd9eFW3HgUoPGCw==
X-Google-Smtp-Source: AA0mqf7QL0VmeSIrLhv2CGB/d9lqwnVER6ZrjBqZzSej4ClMcCWxmJQ5j1Yjam9vC3WbHqykOP9LIg==
X-Received: by 2002:ac2:5a5e:0:b0:4b5:110e:3fd8 with SMTP id r30-20020ac25a5e000000b004b5110e3fd8mr3777046lfn.100.1669718742494;
        Tue, 29 Nov 2022 02:45:42 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id n11-20020a05651203eb00b00497aa190523sm2172749lfq.248.2022.11.29.02.45.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Nov 2022 02:45:41 -0800 (PST)
Message-ID: <73a5b252-b83b-aa3f-d593-776e42182ab6@linaro.org>
Date:   Tue, 29 Nov 2022 11:45:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH V5 1/2] dt-bindings: firmware: qcom-scm: Add optional
 interrupt
Content-Language: en-US
To:     Sibi Sankar <quic_sibis@quicinc.com>, andersson@kernel.org
Cc:     agross@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        konrad.dybcio@somainline.org, robimarko@gmail.com,
        quic_gurus@quicinc.com, quic_rjendra@quicinc.com
References: <20221123204615.25358-1-quic_sibis@quicinc.com>
 <20221123204615.25358-2-quic_sibis@quicinc.com>
 <3cda9005-d7a5-56f0-d1d2-fd6c1cb36fc3@linaro.org>
 <7b6ffbb4-80fb-610a-c839-e3bf1668d4ed@quicinc.com>
 <61f1a1e5-bd2c-4a22-66f7-1935154b35ad@linaro.org>
 <c21737b3-cb72-6a4e-0ab2-b8231a7119fe@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <c21737b3-cb72-6a4e-0ab2-b8231a7119fe@quicinc.com>
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

On 29/11/2022 11:05, Sibi Sankar wrote:
> On 11/28/22 14:00, Krzysztof Kozlowski wrote:
>> On 28/11/2022 06:57, Sibi Sankar wrote:
>>
>>>>
>>>> Which devices have interrupts?
>>>>
>>>> We talked about it here:
>>>> https://lore.kernel.org/all/2464d90f-64e9-5e3c-404b-10394c3bc302@quicinc.com/
>>>> and here:
>>>> https://lore.kernel.org/all/c20edd0d-7613-5683-60e7-54317cac6e0b@linaro.org/
>>>>
>>>> But I still don't get which devices support it and which do not.
>>>
>>> lol, I thought we reached a consensus earlier because of the "ok" and
>>> R-b. Like I explained earlier the bootloader would be adding interrupt
>>> on the fly, wouldn't such cases cause binding check failure if we list
>>> all the devices supporting it?
>>
>> What type of failure? I don't get. Is this interrupt valid for SM8250?
>> SDM845? MSM8996? and so on? Now you make it valid.
> 
> ok if we mark the interrupt as required for SM8450 and not specify the
> interrupt in the board file (since the bootloader will be adding it on
> the fly), dtbs_check will throw 'interrupts' is a required property for
> the board file. This was the failure I was talking about.

OK, but no one said here about making it required. So how this issue can
happen?

Please read above chapter again. I said nothing about required, but I
said "valid".

> 
>>
>>> Also some of the SM8450 devices in the
>>> wild would be running firmware not having the feature but I guess
>>> eventually most of the them will end up supporting the feature in the
>>> end.
>>
>> That's not what I meant. Your patch describes the case for one variant
>> but you are affecting all of them.
> 
> Not really, the driver treats interrupts as optional. 

Linux implementation matters less. We talk about device/hardware
(firmware in this case).

> If the interrupt
> isn't present we assume that the feature isn't supported. If the
> bootloader adds the property during boot then we assume the fw has
> waitqueue support.

Sure, my question stays. Which devices do not support it at all?

Best regards,
Krzysztof

